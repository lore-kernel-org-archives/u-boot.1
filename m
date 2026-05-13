Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5807ECD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 21:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7789883E36;
	Wed, 13 May 2026 23:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="buSDuZIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC9DB8469A; Wed, 13 May 2026 19:57:23 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E37083FB0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 19:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c8028fa6039so4759286a12.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778695040; cv=none;
 d=google.com; s=arc-20240605;
 b=QgMc/sRK8cub1xkO83GinQdGSdBdVgiHab80JS8LiZz79YE5yFZZQHk5fb6X90HEdG
 UZ4RYYC6KQTEJsltJMbM2yBK0NM2zOwNLllT0vnfvgQKa+rpzU7OUGfq9UUZVHcXcxPm
 CzmPB2FVSWTZ1nnDaSFyuoAr5DwzjKOo7hoNlJMauOhpCsofPjfvlPRbulK17JTKMXyo
 T1KUnS/hIiZFfy9OwMqBM7gBeXS2YjZO9OEs0niST0UfAYLNV/+bCVKzvjIu2Gwye4rs
 7MwKiZ+ny+rZ4EwyKCEV535VwJDGHyYVklrbIKwehvY5gZ81+cu/b2zyMCYkohKoe54c
 k5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=PMqbp7wQmxOMQQ+iM7B+aOmMpOcLsRX9Hu+BEvmvJHs=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=g5hzbMDbJ35h1yarIGytVS01fVi14EKRopYP5YGGQzHGkBXpyP1P0LWXW5bksd+RYw
 ftjAGcc+vWFB0GTmt9YV4d3cCpnOmDBL5dTMOFY6TKJOi07i8zg/33dtPsMSGabaFZE0
 XsL4EzmnrIUzWHCaUTiVfqVFC/LsOLm5RgKKasJc5eSG2KiXu/nFiIKEJRy3+qdnQs7z
 2cbVXBx+WTPtdLFktUnkU9JS20XpcNZNUxyfbcidBj6512dXI5hSLy44Qs/xh6ANJ+tA
 k1LD2sCBCULtMaJ12sI6i3vp5s6POblws53qe4gnEh+bnsYmSUbgBLzdgB6MKH8tFZh1
 kzXQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778695040; x=1779299840; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PMqbp7wQmxOMQQ+iM7B+aOmMpOcLsRX9Hu+BEvmvJHs=;
 b=buSDuZIp1+J5WUEjwDQFtQ5uVVsckD8a9ZR/uUpKqfT1L9eVKpkAYQkO/Vk2eMhCiH
 nbQ2oqZ5G7YHwJamedDaOS2oQFJi7TzjCHielHRa9hkB8Gdt7ImSIUo5S2kjnV8cK4To
 6D07kCvN+e8apdzZ7CljzZS/zxg0ZL2DeuYayvrYYP9+rSVOufRp0zltrjshwhXkWlea
 M/ZiqGYLksVvlvXbDjp7fPpl0WppnsiS+Bt2Dm4gFTSH/omstUNor3FKNtXqTA+6jd7i
 9+p6b+XGpqSEj8Xcn2xqlsxBoOGlnWjK3sStbfY9v5uc2TLWFPBbneH/nNoyR2ojslTp
 rJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778695040; x=1779299840;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PMqbp7wQmxOMQQ+iM7B+aOmMpOcLsRX9Hu+BEvmvJHs=;
 b=ewa3O5ON/aeFD9ohwXFfhdTG4Bp3sk0TdX3Jx8/1qvvhBkaDJfAcRkxKI4W23PL1uz
 yoKCMcTZDPDYRAfvSjMgZXlQAzdnAAPq7CvW0syrNAJQBdIQVN/5ZvCXGzamZBA1iq6a
 HvAZYXNUk6wy8fqAp800RGrqAVxHIOv4NRhfNCyKt509wetT6lHe75qB8k8ucaV74bG7
 8+dt/UpcW3w14hL+UxVqIpOfpyIzslOP/Iy9d9TV8JMH0WO7uireNEJyy4VO1TI2zcF/
 hSIeK188ZVlV3EYXj7fpAqtss0TUZ7mhsOAtqiHbXEnWHEpbdBNiot+UOLcH3nc9azj4
 LN2A==
X-Gm-Message-State: AOJu0YyZZ+tP9gqUNwUd1LY38Iwn4Zk0ZSgdb4aBZtTn1lFTS8g5Op9e
 0FFLfyw9G3Q9yPDAOPSBPr8xvxkqw7XVxzUvr8lXreRkhCM3U4yrelUJWZ/9Ivp0qmHcNwKOlMk
 iQZhmAzR2tFudEVT+RwqVg+ftKrNs+L+Y6d35DlE=
X-Gm-Gg: Acq92OHa8pJWPUeHzVLFqvqzXC//ISzsIy/1XoGHKBjZZGbfrKvpcVeDq8mUZztzrRT
 ybjQG6OmSz+H7U0Imyaxkmng/c1AVtf84NS6Bt3YIwCu0D/aVkJykTQ5/DkyaLwqP1Zl3vGkMtb
 xst2ZNpu6J0zeGgOyV4r12QQ29eaBuA/HnqNp5Ng4a6hZMfC4ab+Ov7odzRuL5YBb18YgOvqvni
 tOitEFjP8vnNIl1/+hfeo5XK8amnuDmctlqHOxt/WhoZywPL/c++JDF/DMGMwH9oClqT+Me/fvQ
 PZLzus8IeOaKMGmj0dn6T80kqEd/yjzBbGXEEpqdTHnxmSptx3fDmNhMJ8X2pb6qXbjWzVqJNS2
 KKQU5vDIghSRwb3gkj16Rp9UTbhof6uNuOqEhNhNco+THH2gxrH3whM+DiIsljgEmpnyB/OT6BQ
 ZSiY04
X-Received: by 2002:a05:6a20:7289:b0:39c:1f90:284e with SMTP id
 adf61e73a8af0-3af83e46908mr5063966637.53.1778695039594; Wed, 13 May 2026
 10:57:19 -0700 (PDT)
MIME-Version: 1.0
From: Allan Elkaim <allan.elkaim@gmail.com>
Date: Wed, 13 May 2026 19:57:02 +0200
X-Gm-Features: AVHnY4L092HXuRkXORIDZz2ovdYARocWEs0C_Z6sGXLFsLYXmVsShDnzjvLkS_4
Message-ID: <CACgNL-F2=KJtZ+gThpx_BuWsn6puqFxK0uLOmnABSS9=rRQmeQ@mail.gmail.com>
Subject: Bug: Synchronous Abort in sqfsload resolving symlinks (aarch64) after
 increasing inode count
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 13 May 2026 23:36:38 +0200
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

Hello U-Boot team,

I have encountered a Synchronous Abort bug in the U-Boot squashfs driver
when attempting to load a kernel image via a symlink.

*Environment:*

   -

   Architecture: aarch64 (ARM64 / Raspberry Pi CM4)
   -

   OS: Yocto-built Embedded Linux
   -

   U-Boot version: 2026.04 (Latest Release)
   -

   Filesystem: Squashfs (A/B partitioned rootfs)

*Context & Use Case:*

To support a robust OTA update strategy (using RAUC), I require strict [kernel
+ rootfs] atomic slots for my A/B partitioning. Therefore, the kernel is
intentionally baked directly into the squashfs rootfs partition and loaded
via /boot/Image, rather than residing on a shared FAT boot partition. This
guarantees that an OTA update or rollback applies to both the rootfs and
its specific kernel simultaneously.

*Description:*

My custom boot script successfully uses sqfsload to load /boot/Image (which
is a symlink to /boot/Image-6.6.63-v8) directly from the active squashfs
slot. This setup worked perfectly until I added the tzdata package to my
Yocto rootfs.

After adding tzdata (which introduces hundreds of timezone files and
symlinks into the squashfs image), sqfsload crashes with a Synchronous
Abort when parsing the /boot/Image symlink.

If I bypass the symlink and load the target file directly (sqfsload mmc 0:2
2 /boot/Image-6.6.63-v8), it works flawlessly, even with the bloated tzdata
filesystem.

*Crash Log:*

U-Boot> sqfsload mmc 0:2 2 /boot/Image
Error: invalid inode reference to directory table.
"Synchronous Abort" handler, esr 0x96000004, far 0xffffffffffffffea
elr: 00000000000e73c0 lr : 00000000000c8da4 (reloc)
elr: 0000000037fb13c0 lr : 0000000037f92da4
x0 : 0000000037b51780 x1 : ffffffffffffffea
x2 : 000000000000000c x3 : 0000000000000000
x4 : 0000000037b51780 x5 : 000000000000005f
x6 : 0000000000000000 x7 : 0000000037b1b100
x8 : 0000000000000001 x9 : fffffffffffffff0
x10: 0000000037b514d0 x11: 0000000000124c8b
x12: 000000000002d196 x13: 0000000037e838cd
x14: 0000000000016dc1 x15: 0000000000016c97
x16: 0000000037f7a80c x17: 0000000000016c97
x18: 0000000037b29d60 x19: 0000000037b51800
x20: 0000000037e838ad x21: 0000000000000001
x22: 0000000037b512c0 x23: ffffffffffffffea
x24: 0000000000000000 x25: 000000000000005f
x26: 0000000037b512a0 x27: 0000000000000001
x28: 000000000000012e x29: 0000000037b1b110

Code: 8b030042 cb030004 cb030021 17fffff0 (38636825)
Resetting CPU ...

*Relevant U-Boot Configuration:*

CONFIG_USB=y
CONFIG_DM_USB=y
CONFIG_USB_DWC2=y
CONFIG_USB_HOST=y
CONFIG_USB_KEYBOARD=y
CONFIG_SYS_USB_EVENT_POLL=y
CONFIG_USE_PREBOOT=y
CONFIG_PREBOOT="usb start; setenv stdin serial,usbkbd"

CONFIG_ENV_IS_IN_FAT=n
CONFIG_ENV_IS_IN_MMC=y
CONFIG_SYS_MMC_ENV_DEV=0
CONFIG_SYS_MMC_ENV_PART=0
CONFIG_ENV_OFFSET=0x100000
CONFIG_ENV_SIZE=0x20000

CONFIG_FS_SQUASHFS=y
CONFIG_CMD_SQUASHFS=y

*Steps to Reproduce:*

   1.

   Generate a squashfs image with a few files and a symlink to a kernel
   image.
   2.

   Verify sqfsload can load the kernel via the symlink.
   3.

   Install tzdata (or pad the filesystem with thousands of dummy
   symlinks/inodes).
   4.

   Attempt to sqfsload the kernel via the symlink again.

*Workaround:*

Currently, my workaround is to use a ROOTFS_POSTPROCESS_COMMAND in Yocto to
remove the symlink and rename the kernel binary to /boot/Image directly,
which loads without issue.

Please let me know if you need any further information. I am fully
available to help investigate this, provide additional debug logs, or test
out any potential fixes and patches on my hardware.

Best regards,

Allan
