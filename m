Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D56D73E80
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 18:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B9B83FFF;
	Thu, 29 Jan 2026 19:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=openadk.org header.i=@openadk.org header.b="B57nFpmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F008405A; Thu, 29 Jan 2026 19:22:30 +0100 (CET)
Received: from helium.openadk.org (unknown [IPv6:2a00:1828:2000:679::23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AF683FED
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 19:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=wbx@openadk.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
 t=1769710947; bh=5hBkwDDujGko76ddKV92truVtDmQXWK51W3oxNrakCo=;
 h=Date:From:To:Subject:From;
 b=B57nFpmTHKI0xs59nRbtRapS4y07LG9s2pgGJDuj1UJGoeQ5Hb8P8KfUhC3s8ZIld
 f6NofP9Ac6EBO8hE2uDAuXVwHBDl6Ogt0wizcM3cjo4+WwzVDAx/QpDLjVqu6FE3CV
 0LtI7ekSFU1fQvW4OelAC8yQo9fOwOi1ACexBYHL4U/ZPOVjg1al6Q0AuVru9zcEXi
 zgRUV1Ekn4hwo5EPjpDAxTj+2iPRV5KYK25ZXB5Rjr3msqEdR6yJedK4lEIsPEwt0W
 TocnF1nFkT51lrNZ/ltKxapqMCp+Wn+mB96yjUZ//4DBpfDZX/LkCkD+Lato0It4Ip
 K3mufqg0OZvLQ==
Received: by helium.openadk.org (Postfix, from userid 1000)
 id 7015131E0B2F; Thu, 29 Jan 2026 19:22:27 +0100 (CET)
Date: Thu, 29 Jan 2026 19:22:27 +0100
From: Waldemar Brodkorb <wbx@openadk.org>
To: u-boot@lists.denx.de
Subject: Question about u-boot.hex for Microchip PIC32MZ DA
Message-ID: <aXulY6gVxDckP0ti@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 6.12.63+deb13-amd64 x86_64
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

Hi U-Boot developers and users,

I successfully flashed u-boot.hex from Github Linux-LTS-for-PIC32 on
my device. Next step I try is to flash my own cross-compiled U-Boot
hexfile from 2026.01 release. It cross-compiled fine and then I used
following command to convert it to hex:
$(CROSS_COMPILE)-objcopy -O ihex -R .note -R .comment -R .debug_* u-boot u-boot.hex

After flashing it with MPLAB X IDE 6.2.0 nothing is output via
serial and the orange LED is no longer blinking.

What might be the reason for this behaviour? What I am doing wrong?

Thanks in advance for any help,
 Waldemar
