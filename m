Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5771DC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A5682103;
	Wed,  2 Jul 2025 12:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MdNPbeZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D521282CFA; Wed,  2 Jul 2025 12:09:25 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E8580E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 90B05A535E9;
 Wed,  2 Jul 2025 10:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5DAC4CEED;
 Wed,  2 Jul 2025 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751450962;
 bh=88RT9pZ1lopQzwgKUUbkRHe2qKGadBOrMj+oKV/Qn6s=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=MdNPbeZLMq3XPP57dZmh3tss19sFhLZN5M6meDQ0V/5BKuQHaSgdKt1LpCIoY2HD5
 3zGwZ2nonX9BqNtW1p+B+4NgdACrYwfIOz+u7rWET0fv26aftTL7oAGeCKwj1E3zAj
 Sqw8aNkyuN9sOCTOlUO2HI4IfKKsCUzZr5wugoEMyAKCh+8+gB9wMr46h4J5bz6Qnz
 OaMqQHYmk0JNIkiMZBJe5Gr5ZnoTf9vXGIlqZMUbQ6w17iTndG25nGK2Eq+ZluYZUI
 mhXM73Efxj72NfMpB67ckCg1AJFHeMnykFsmIenedbGNtu0DANReaui2YG5c6O5JWg
 7734lTN5vKi5A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20250618-maintainers-dfu-spl-v1-1-03f4bc745e36@kernel.org>
References: <20250618-maintainers-dfu-spl-v1-1-03f4bc745e36@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add common/spl/spl_dfu to DFU entry
Message-Id: <175145095945.54603.12460432413109856107.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 12:09:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Wed, 18 Jun 2025 15:43:44 +0200, Mattijs Korpershoek wrote:
> This was not listed as part of the DFU entry.
> 
> Add it to make sure that the DFU maintainers get CC'ed on
> patches for spl_dfu.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] MAINTAINERS: Add common/spl/spl_dfu to DFU entry
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a6732920821a23e00cc3291d8069061bd7d00e67

--
Mattijs
