Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7228ED172CC
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 05:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DDF83CEE;
	Mon,  2 Feb 2026 06:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=openadk.org header.i=@openadk.org header.b="S0pCEeix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF95C83CF3; Mon,  2 Feb 2026 06:34:52 +0100 (CET)
Received: from helium.openadk.org (unknown [IPv6:2a00:1828:2000:679::23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A05183C51
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 06:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=wbx@openadk.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
 t=1770010489; bh=TprS27JkljWjU4pBia/UhOXiQdLj58D/tDWTfVt3v84=;
 h=Date:From:To:Subject:From;
 b=S0pCEeixFpTSvbv1+WGcTP4OX/5wcAk6i1sx+Dfqe6H0EeXJuHSnSy9pZCnjBQ0/N
 xKhSbGW2YqmkPzBcNXSUJ/wMxHmB9Bcz4d347tn6aYCaVDmA316Mckgy4N5YNswru3
 YpY7N+p9zK4WVDguHgc9hYAoYU2lxw+Q4pAu84vPk1XrlJ9a1HWPehP8SQgTV+yoDk
 BoZnhAyqmobXGkZT1Lll9vSMsZL5VzpcA6GeeTy+Vcan2jVgzfCAEaflXQjjoV3EoS
 B3T45RGghqZ7ymqSa9tx5iAiruJ6O/+O8q1jcfjKWRajiC7veTU96+s7PoDxgZPX3P
 LZMXOZZjYLHXw==
Received: by helium.openadk.org (Postfix, from userid 1000)
 id C883D31E0BA1; Mon, 02 Feb 2026 06:34:49 +0100 (CET)
Date: Mon, 2 Feb 2026 06:34:49 +0100
From: Waldemar Brodkorb <wbx@openadk.org>
To: u-boot@lists.denx.de
Subject: Re: Question about u-boot.hex for Microchip PIC32MZ DA
Message-ID: <aYA3eUsx2OHHKpMs@waldemar-brodkorb.de>
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

Hi,
Waldemar Brodkorb wrote,

> Hi U-Boot developers and users,
> 
> I successfully flashed u-boot.hex from Github Linux-LTS-for-PIC32 on
> my device. Next step I try is to flash my own cross-compiled U-Boot
> hexfile from 2026.01 release. It cross-compiled fine and then I used
> following command to convert it to hex:
> $(CROSS_COMPILE)-objcopy -O ihex -R .note -R .comment -R .debug_* u-boot u-boot.hex
> 
> After flashing it with MPLAB X IDE 6.2.0 nothing is output via
> serial and the orange LED is no longer blinking.
> 
> What might be the reason for this behaviour? What I am doing wrong?

Me again. Found this URL in the meanwhile:

https://www.reddit.com/r/chipKIT/comments/dtmg4h/installing_debian_on_pic32/

And indeed such a hex file can be flashed, but U-Boot does not
start:
U-Boot 2026.01 (Feb 02 2026 - 02:46:10 +0100)

Model: Microchip PIC32MZDASK
Core: PIC32MZ[DA]
CPU Speed: 200 MHz
DRAM:  128 MiB
Mis-aligned relocation

How to fix "Mis-aligned relocation"?

I am using gcc 15.2.0 and binutils 2.45.1 to compile U-Boot.

best regards
 Waldemar

