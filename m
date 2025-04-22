Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4746C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C90280FDA;
	Tue, 22 Apr 2025 12:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="uLmDXkWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A1680FEC; Tue, 22 Apr 2025 12:37:40 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5942080C93
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3C2991F9CD;
 Tue, 22 Apr 2025 12:37:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1745318256;
 bh=SLlvcd7D4WCJvYXvw53rGRY2P62IQfgq8xeEtgKHvEA=; h=From:To:Subject;
 b=uLmDXkWtFstYMV7VaxV7W72jefuA5EPFs7LI+en5Ud7K1uTtBQTxQ+bEUmk26g5cX
 B+bjfz7JjZMt3aTYemXRRLXynwNQHr6zxah5vV1MCggy8j2CzVAptNFOyRx9ccyivE
 ZAtip7vOxzDERpfOEfQs3xVaeAvQPGEu5SInWY+YeK31jW9Jby39v8V6lAm1TZz7BS
 8nst3kWnnMTo++KC+jzaF/oVLFXY/WAVKA8fDeJ/5rKhpwp+jzt2RJX8Bt3BIrXKsz
 l/+kVHPtwH51cScrrL5p7uumLGYuJad/rY6oGfdqPjbzY7NsXi9WLkNbQgI8iomMI6
 iGf3/9LVueqQQ==
Date: Tue, 22 Apr 2025 12:37:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [REGRESSION] [PATCH 1/1] mtd: mtdpart: Support MTD_SIZE_REMAINING
 with unallocated memory area
Message-ID: <20250422103732.GA117260@francesco-nb>
References: <20250220145808.1911832-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220145808.1911832-1-alexander.stein@ew.tq-group.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom, Alexander

On Thu, Feb 20, 2025 at 03:58:07PM +0100, Alexander Stein wrote:
> If there is an unallocated memory area before the last, filling parting
> the size calculation for MTD_SIZE_REMAINING does not take this hole
> into account.
> Fix this by calculating the remaining size just based on total size
> and partition offset.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

This change introduced a regression on colibri imx7 and imx6ull.

```
Booting from NAND...
Partition size must be a multiple of 2048
Could not parse device nand0
Failed parsing MTD partitions from mtdparts!
Partition ubi not found!
```

Reverting commit 1ca97ee90392 ("mtd: mtdpart: Support MTD_SIZE_REMAINING
with unallocated memory area") on top of current master fixes the issue.

Any suggestion? I have not looked at the code, I just did a git bisect.

Francesco

