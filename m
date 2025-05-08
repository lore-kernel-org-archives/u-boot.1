Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F4C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434AE82AEF;
	Thu,  8 May 2025 14:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FrhgYZOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAAB5828B3; Thu,  8 May 2025 11:38:18 +0200 (CEST)
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6742182162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 11:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mep.sw.dev@gmail.com
Received: by mail-vs1-xe43.google.com with SMTP id
 ada2fe7eead31-4c4fa0bfca2so275684137.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746697095; x=1747301895; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0y8Ti9gVJBmQxARqNSkZZcs04tUVNNGEgIECSa+2l0M=;
 b=FrhgYZOPP8Zi926sAc2ig37EONs6OfhF5Y/IOWK1+WcISuRrdfy0Yr386LQnoSBS5M
 LpKv8/4S2ebha2ve/AA1JtF/TA2XsebuRaN73Xd023V/s+jEX8eKbpvdt4CXRH1jLh22
 SGPWlC5K0RxFi2/NgKOthkAYerFryQ+W6zEsE86lh8dC/sACZQZ/T+2OfgJjaMELiJFr
 +cSkxgQXrud+r1jsRSgXD7LmBXrlBY1DsZMKH8pttwqFM9QKGLlowGlCJ8EwGtqwcqXw
 o9E/drXFyHhuzZkJ2D0urIiNIOzBPA0srS/OQ1P+JAtF9wve4dA8LTuRnwZa1D7Vl/Rh
 1u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746697095; x=1747301895;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0y8Ti9gVJBmQxARqNSkZZcs04tUVNNGEgIECSa+2l0M=;
 b=vy5VtFiaivoqujWBV0h00dV8Fr6UCaCIKp1/lDsmrFvzBRmWEegiU9EBmkZxBXXiee
 Hf+0e+rrs46nRpqUFvSYHSk9/j7FIHqJ/nRdD7zpbt16hHnJ+Ll4mpkMqbFthkeir92r
 ImQvNYNYFB+QNpEpC375G1S0Cat2/fAxZ9wtSOneX2pKvFo4b4u0C9L21yMfrEdMsylz
 HBVMbHu/TZXQGtwikYyhc15s0ho7Mtjipfs/Xa51nhmvLZmH/ar8LAtMBQM9kTLp/MHL
 B3fvYCeChzGQn8gTbd7MK+9xq/mwyFBKi6mSxe1VuLzf53D+jJ/EPs7R9LV82MesokKT
 gebQ==
X-Gm-Message-State: AOJu0YxLdSyZg3HaN0QY8J4sjke4odEm4si/+cEpHbiiyN1wGCx2YiZG
 xwBZ9MQyLjhoxzmlpMSebeJaM2OPYK7QGCmXOY5Db9a3p24FqjgRusxmmXWZyr44wUewFzzYdNT
 +rvRbY3TKJbeVSYvAbnEYUDDuq5QLiIZosMs=
X-Gm-Gg: ASbGnct+MOxuumVFrES2n2V5vpf8HaUMY635z8R+VrG6rxLv5ShEJJgQV5lDFe+v3zG
 44kekqtvw3NDF52CXZ0zCmVMrrvCIOQVduBZhBEUQ0MHS2cnaqbXXXqipJ7wc8A/q/FpSBHg9h6
 fVN39gVqc1uVeRqOk85wQ1z0UKKDezpfel+w==
X-Google-Smtp-Source: AGHT+IEtdr/kbQX87jQeVnnzDS5goBFMTbFyOh45d5YyvN09iEfitulcKhnX4GSb+ciwUW9JurlKYAssI1C+GReJV7A=
X-Received: by 2002:a05:6102:91c:b0:4c1:924e:1a1d with SMTP id
 ada2fe7eead31-4ddad0adf6amr1912222137.18.1746697095219; Thu, 08 May 2025
 02:38:15 -0700 (PDT)
MIME-Version: 1.0
From: Michael <mep.sw.dev@gmail.com>
Date: Thu, 8 May 2025 11:38:04 +0200
X-Gm-Features: ATxdqUHLoDJQ-FyyyXcpYny-eTktXFnCOEToUOSB8F4SU6pxg2vm7fMfhM-wyMc
Message-ID: <CAHYLw-ReP8avjX8gKdpJJxus1u7FC0KVtzBRy594M1x6XfxPUQ@mail.gmail.com>
Subject: u-boot on x86
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 08 May 2025 14:50:08 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello!,

i'm currently working on a project that could use several architectures
(arm / x86).
To have a common base for all systems, i want to use u-boot as unified
bootloader for both platforms.
At the moment i try to get u-boot working on x86. These systems are more
general pcs than classic embedded systems and can have intel atom / i3...
etc. processors (for example advantech mio series) - All of them have a
uefi bios.
To build the whole system i am using yocto. I have made some minor changes
to u-boot (v2025.01 / build as efi app / binary) to fit my use case (find
env partition via gpt part uuid / A/B update mechanism etc.)
The kernel and initramfs are packed as fit image (
https://docs.u-boot.org/en/latest/usage/fit/x86-fit-boot.html). I can boot
the system and the a/b update mechanism is also working.

The fit image contains kernel / setup / initramfs - (
https://docs.u-boot.org/en/latest/usage/fit/kernel.html)
The current boot procedure is: "boot uboot.efi" =E2=86=92 "load fit image o=
ver the
efi interface" =E2=86=92 "bootm"

My current problem is, that i can only use one cpu core. I think there is a
problem with the acpi tables ("smpboot: Boot CPU (id 0) not listed by BIOS"
/ "smpboot: Allowing 1 CPUs, 0 hotplug CPUs" / "smpboot: SMP disabled")
I already got some hints on the irc chat (thanks for that!), but i could
not fix the issue yet. I also tried an "EFI handover" patch for uboot, but
with this, i cannot boot the kernel anymore (exception).

At a later point i want to lock down the device with enabling the "secure
boot" bios function. I have not worked with secure boot yet. I think i can
only get it working with the fit images (fit signature verification)?

Is this thre right implementation approch?
I am grateful for any advice!


Best regards,
Michael
