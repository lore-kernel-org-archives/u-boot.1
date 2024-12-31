Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D16E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 14:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED79680379;
	Tue, 31 Dec 2024 15:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fUehU/H6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD2980383; Tue, 31 Dec 2024 15:53:27 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA912801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 15:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso14576184a12.3
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735656804; x=1736261604; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=If/g5vT5rLyyN6bWH43lj/MSmUnmwIdAXmSXBV1yq2w=;
 b=fUehU/H6hBUpRWMJcX6VjZpRzdhEpk9/kGJB0VT2962nYbmnj6ZIKonvxgf4J3IykT
 dXjfLnptbgF2Pmpbn1mfN8BIJS5riRRgjtYE/h74ye32iFeR5P9wNpHa2ndIUNGhS4o+
 1khPYhq9h4rABgPntuAFk5XXLLDNCbTBrq4QlNdKOdyeMmeQO/AX9ev7kUFAI10fBuiF
 TLTLTZQ0FO6maO6mJTdHD/ECMBmGJxMvBi5vdL/wmlnI8sIA55WaDN4xxtAfszJfnkbd
 VE3amOdyeWbIkH8TrN+xjV/xFRnOBBIQKb10Gh9cnWeC96ITVsBSXUHvl552juNYPdWh
 8rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735656804; x=1736261604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=If/g5vT5rLyyN6bWH43lj/MSmUnmwIdAXmSXBV1yq2w=;
 b=KEr9UqhjVxb8IWixi8insSosYZR+Xl2bClQ6Eo4uwS+0QGUFBFTEZaFvzcofUTb+RB
 bwoOPjHUtnwcqMvwVGLKdoS4E/MoGozrQsl6GSvRU44DcvDiFvLU7AMF5t2UNjdjXOSO
 N9/HBQEKWOkagfaLl1Om6hzgviOKcLUxl/mm5eHR6giAvaQDmXmQ+VY3MM64ECqg9Kzo
 STIcqfVu2lly73hA3Pp//T8ESr1xxBi0eusHYjmiz0sJgz5r1cxgbZbWt1jZeWNWXt9o
 HvRCdoJaI1ljMxBC4aJze+ZqOhNmRz8hx9WPsSrVHnZb/eojcAYhRJWMaMxNNA/f2+pC
 G9WA==
X-Gm-Message-State: AOJu0Yw7Dwm/WVvcClZFBdMXEJMKUdC6mGfG15AafKIs46DZRnJLcqMd
 HegcJxZsdRVAdsYYDZRNL1xrfyvhQ28U7v8lT4NPhWBJQd1qIYO53F3sk7pE0bTXgXuO4aKkv7A
 0QBX7KB9CBJlHMLQG3BKLwL0RBf1vDA==
X-Gm-Gg: ASbGnctGNSCKeAoH9CF4huDaMaUp4jdZ2MEgUwxwcEL2jxm7KLu4IXcSHEijvGW+Y21
 2UO0+jcFKJWj4f0w8uB8ewtHKtgS+kWkHI/jI6amr1JiiSw+n/BRee03pWpNNR8vSWJNclgQ=
X-Google-Smtp-Source: AGHT+IGL1UatI7xTz5pIfq67gNzZAdvMKI/9+QW2X3LENaZ4JDWW0DnWw3ZRUK6kb3sXYf1Sjt8Ayn0WwTDNdX2I23M=
X-Received: by 2002:a05:6402:4011:b0:5d0:b040:4616 with SMTP id
 4fb4d7f45d1cf-5d81de17fa4mr41789877a12.28.1735656803640; Tue, 31 Dec 2024
 06:53:23 -0800 (PST)
MIME-Version: 1.0
References: <cd71682e-33c9-4e38-829a-a540a53bacad@munisense.com>
In-Reply-To: <cd71682e-33c9-4e38-829a-a540a53bacad@munisense.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 31 Dec 2024 14:53:12 +0000
Message-ID: <CALeDE9P45GvLagdkkC-8FuT5Ee3ZWpMPa4+F_eizoPHFtJFSjA@mail.gmail.com>
Subject: Re: rpi: Compute Module 5 doesn't autoboot without debug UART
To: Gijs Peskens <gijs.peskens@munisense.com>
Cc: u-boot@lists.denx.de
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

On Tue, 24 Dec 2024 at 14:00, Gijs Peskens <gijs.peskens@munisense.com>
wrote:

> I'm working on getting a compute module working with Yocto using U-Boot
> as bootloader, which mostly works thanks to previous work to get RPi 5
> working.
> However I'm running into a strange issue: if I turn on the CM5 without
> the debug UART (which requires soldering a header onto the CM5)
> attached, the Pi doesn't boot beyond showing the submarine splash
> screen, if I boot it with the console attached it autoboots correctly.
> If I attach the UART after the boot halted and press enter I get a
> U-Boot console, and giving the boot command boots it normally.
> And setting bootdelay=-2 in the env allows it to correctly boot.
>
> Which leads me to believe there is perhaps a spurious input registered
> by U-Boot which interrupts autobooting.
>
> Is there a command that allows me to extract why U-Boot didn't continue
> autobooting?
>
> And anyone have a hint how this could perhaps be fixed in a more elegant
> way (allowing interruptable autoboot).
>
> The hardware I'm testing on is the CM5 devkit, I needed to make small
> changes to yocto to get it working:
> https://github.com/agherzan/meta-raspberrypi/pull/1397
>

I don't think this is unique to the CM5, I've seen it on other RPi models,
I have a RPi4 8Gb model that exhibits the same behavior, yet other RPi4s I
have don't exhibit the behavious. In the case of the 8Gb I have a USB
serial TTL on it, it boots if the USB is plugged in, doesn't if not. I have
other v4s, both with and without the TTL and they boot fine, I've never
been able to get to the bottom of why.
