Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24279E67A92
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 08:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BB08063E;
	Tue,  3 Mar 2026 09:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oDpVGxxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF2F780050; Tue,  3 Mar 2026 09:10:19 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5046983F30
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 09:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F9754479F;
 Tue,  3 Mar 2026 08:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1472C116C6;
 Tue,  3 Mar 2026 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772525414;
 bh=M8b0/baWp7AMWiDhOedNRKFeOy8hqSwhA+J438d7XL0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=oDpVGxxb4Ylkih829VeCf6X1eXMdGd8mG1rbGMxE+dsFnkIN3/vDkE+Kjl0hdVyfb
 E9g1JkW494SE3Jsmfq/VxDnrpMVC6E+LcyJmNuwewFsImDJUVgcFx4l3Zn8waG7mTv
 WSf6FEoYCLZ2sTtQ/yi/kJtQUWjRP8Hy6WVevyjGOFe375T3JzO0NwbG7+YUHZ4egY
 +jIJ2A4ElEenYHdDd3I4gvk1fw2ngymZLbBsoDJhRjplrK2EJ7hd0QBETfBcwbI988
 fn4qVsgLoVEKQH+pGEaoxaw69q4H0CZZKuBeh0DRYiP+V7ulAnaqbarRdHanpsd+Vr
 BkwR12VA6ncwg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>
In-Reply-To: <20260224154504.85301-1-trini@konsulko.com>
References: <20260224154504.85301-1-trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: Mark udc_disconnect as static
Message-Id: <177252541152.27264.3871659267822240957.b4-ty@kernel.org>
Date: Tue, 03 Mar 2026 09:10:11 +0100
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

On Tue, 24 Feb 2026 09:45:04 -0600, Tom Rini wrote:
> With the last external callers of udc_disconnect long removed, mark this
> function as static now and remove it from headers.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: Mark udc_disconnect as static
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7b60cd933bc1db31c94483f6aeb9289722427c5e

--
Mattijs
