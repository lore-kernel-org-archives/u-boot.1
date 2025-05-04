Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300D0C369DC
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 01:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3010080F03;
	Mon,  5 May 2025 03:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=chewies-net.20230601.gappssmtp.com header.i=@chewies-net.20230601.gappssmtp.com header.b="RtTwzhJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A0F80EE5; Mon,  5 May 2025 00:34:36 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AB480ADF
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 00:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=raz@chewies.net
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f7ec0e4978so2092404a12.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746398072; x=1747002872;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MeSq/vxrxonH9tLqPxNlJB0rPeY/8kH3taEkTAOMzwA=;
 b=RtTwzhJcxdSH3IZOVFAN8qmoUYeZYWzquPMa5jeB0YEERyAhVVhg5UwjIKImAIFwYL
 igxJ6x95BUN2Jz/x8nndhHtqiSQZZ+4svF3sprQBg9B2Sz8JQ20iY5bvA/4nANItCjUZ
 8UmbQT0t2VC0FkmburqSP5Su6D/M1oFlo11dsEue4L6Zhcqdbi02FdAZ9ZVcp/8ZcdzJ
 PsTvJI3CnfdU651HmKtIROuiH/zuqc+Oxi/10T7VSLnWV8g7VSFBUbcPb8ptgpKUvIf8
 tI+WNYAJYFKtTe63/I/g97BeQefFW3fUcKnIB0WJkzDI3274+ihW14oqO+W6VCv/ywfU
 So9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746398072; x=1747002872;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MeSq/vxrxonH9tLqPxNlJB0rPeY/8kH3taEkTAOMzwA=;
 b=uovTuVIZqfZy0InFtfgL06eKJpn8e3JZluDKfIEAF8nwZRGrnX85P6UCWaJ5MyZpkv
 z9r0sIAPu151zbyXLUmDR2WXj45ziqzB9eZxe4rSlVe4qQuTBiFsd7ikeAjSZZPzz03V
 AuAxIXk71devRltvUF6pwlNRG9umgqiGHg1SURgoZO/gulkwXyyJ3JkT9HV6bS2ssyCq
 oXFV8mwnHRjq3Rn/khxfwGvYLA0FrGy3jiQO2W8gf6WMpQEcVYhcCEku/wOHnUCmaOkC
 NhTSf+PSPuyfh5hSbyrFl4ti5I09Cg96C9ln1RnJ2E2OlSTl5gzlSkgczrS03xLqK3zu
 pUPw==
X-Gm-Message-State: AOJu0Yx8efwXnLiEqGtWQNrPq8bqTsaQjfgXfegQ2o+aecWim+HDSyBl
 Jd0JfNxw7nbuYcVadmVyk+DAlnQhBsv1KjMZgFnKPqoRLNai1cw+V0N6swuk5j5nHPkMxT9IZY2
 uP5ChDBUazqyguD8UqTgRaTrVS4mtbvuU1r6dzAO3I8CxUjNCXw==
X-Gm-Gg: ASbGncuE4YY0SqtkAHfgrfo+puj7M/e8alU1SJsoIOXuNUECRM3iUkJ1fuoFYEG0kEs
 XjxWpdttEjIZpLGyumJpbl4W6Eq/qSQ+t+3BSdg0UH8B/QyWVS40T5mFg2xN6prrDOicSh2VI7c
 jUgTVZuR5pt1mZBrNJLlBgC77slEI44g==
X-Google-Smtp-Source: AGHT+IFkPW206yYEquymk9Aeqgbpx/tgUn04+HHS8xHLZf7Es/8xTei5eJ2Xo1qM/4oQHa3y4Ny0+YJKW/w9dS2jHgI=
X-Received: by 2002:a17:907:72cd:b0:abf:749f:f719 with SMTP id
 a640c23a62f3a-ad1905cf9c2mr611923766b.7.1746398071920; Sun, 04 May 2025
 15:34:31 -0700 (PDT)
MIME-Version: 1.0
From: Wayne Schroeder <raz@chewies.net>
Date: Sun, 4 May 2025 17:34:20 -0500
X-Gm-Features: ATxdqUHw6fl0nPqiOIV3wAmLKOuHNPtlw6Vnk1mRMJyL4Dzil1st7d2pEIRb_y0
Message-ID: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
Subject: Odroid n2+ usb broken on reboot
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 05 May 2025 03:42:23 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello.  I am not sure if this is a bug, or even related to u-boot, but I am
reporting it here because it was easiest to resolve via a u-boot change.

I am using u-boot-2025.04 (source) with a mainline linux from Arch Linux
Arm.
Linux alarm 6.14.4-1-aarch64-ARCH #1 SMP PREEMPT_DYNAMIC Sat Apr 26
13:02:01 MDT 2025 aarch64 GNU/Linux

On my odroid-n2+, the USB ports work on the first boot after power.  If I
run shutdown -r now, or hit ctl-alt-del and otherwise reboot the system,
the usb ports do not function at the next or subsequent boot up.

My apologies if this is not applicable to u-boot because it is a linux
issue--I am not sure what the source of the issue is, but adjusting the
u-boot .config after make odroid-n2_defconfig resolved the issue entirely.

I am booting via extlinux/extlinux.conf and have adjusted my
CONFIG_BOOTCOMMAND before build to execute a usb reset prior to the
existing run distro_bootcmd.

CONFIG_BOOTCOMMAND="usb reset; run distro_bootcmd"

This has allowed me to reboot the system and successfully have access to
the USB devices such as my keyboard, mouse, and root file system on USB3
SSD.

Thanks!

Wayne
