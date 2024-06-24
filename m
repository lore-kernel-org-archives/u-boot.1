Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED885C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3DC888403;
	Mon, 24 Jun 2024 14:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="jmI0gRqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2776088352; Mon, 24 Jun 2024 09:49:39 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF1AD88307
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 09:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.laffont@smile.fr
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6fbe639a76so635254666b.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1719215376; x=1719820176; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yjuHmRJuWKe8nZhVd6+ZbMPjGYaOvMqK9k1JzXPab2o=;
 b=jmI0gRqbbGhLmv/CZpURtjlPha9FdONntHI49q2y+ZjlgUfUutQLqZLFSLZLYfH3mi
 dUOWZN8ObdiIm2gO/NdYTJnRNrD+RRgVMc/i8u+/vEM60VKqdamOfgPUKT3pAwLqWuQw
 vF8Hnidm7XnS6lOx4R/YD6ylh6jBJrbAzKcm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719215376; x=1719820176;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yjuHmRJuWKe8nZhVd6+ZbMPjGYaOvMqK9k1JzXPab2o=;
 b=LfSWzXUgZoJfGojwkexUh8jOzqqHZegAFCLC/yfGZa7nSfTDDuyMJco6+Y7ukQ1OeF
 ROTcyIVxAiTkkzEEpPM1VH9L0OeMhFrOAU2UZci2pX3gpyopMR/IBgPAYkd5VTGNi0Ke
 Pn8tr2zamKF9I7ZYmW7jdcWwBOq0HJ4KmoPkdAQY2PjemMUFXCABpmeIHLSU8foxKVp6
 Uzl3sNkYNHxML/SSYBDR+uOUqb+mUKcvke4HJPawPjr2gYrIsv4rg7Cqcko44u3LUzO4
 RyhLEje7TGpdN+1ef+7sx3UT9nrf0sQB1EeVUxoKFdTgvghHNkY0POl3Q6XJsHzrAjBw
 rAww==
X-Gm-Message-State: AOJu0Yz70LQ65KkoH/ct6pAfY9uwLNVBG+TCofav+6XWW6GqqJqIqOJt
 xvBg4PbBPm/OHC0u3dH7FN4CNiHCj5HhuJLHjFeOId5HXVLx+fRQ5rwxUx9vi8gLsTiD0QwSO0Z
 hyGYUKgqpsYkdami0U1A8qbvAcdK8zj4v1Lk8bCDsYbm8T1h/HCk=
X-Google-Smtp-Source: AGHT+IEjpQ/AD51snx4QUH2fBzHpd6OKORSL/1Vy1ZP7JPX+f/kykYQDR78ssL6W/kH7Ysrc5zhLUKP04/ZmfKNrtrc=
X-Received: by 2002:a17:907:a64b:b0:a72:5bbf:efc0 with SMTP id
 a640c23a62f3a-a725bbff13dmr69844966b.16.1719215375782; Mon, 24 Jun 2024
 00:49:35 -0700 (PDT)
MIME-Version: 1.0
From: Hugo LAFFONT <hugo.laffont@smile.fr>
Date: Mon, 24 Jun 2024 09:49:25 +0200
Message-ID: <CA+EWzRAhmezMHiHQFLma4L6SgB1SxJbzi_B_Dx1=v9=D4NoGYQ@mail.gmail.com>
Subject: File renaming problem with systemd-boot after u-boot
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 24 Jun 2024 14:52:21 +0200
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

Hello,

I am creating an update system using systemd (repart + sysupdate) and
systemd-boot on an embedded target (beaglebone black).

Everything seems to work except the bootcounting of systemd-boot. "Failed
to rename '\loader\entries\entry+3-0.conf' to 'entry+2-1.conf', ignoring:
Access denied". This happens when the function handle->SetInfo(handle,
MAKE_GUID_PTR(EFI_FILE_INFO), file_info_size, file_info) is called
(src/boot/efi/boot.c line 1385). Then the system is able to boot but I need
to get this bootcouting system working to be able to do fallback if the
update goes wrong.

According to the UEFI Specification we get Access denied after the call of
this function in these cases:
- An attempt is made to change the name of a file to a file that is already
present.
- An attempt is being made to change the EFI_FILE_DIRECTORY Attribute.
- An attempt is being made to change the size of a directory.
- InformationType is EFI_FILE_INFO_ID and the file was opened read-only and
an attempt is being made to modify a field other than Attribute.
However, none of these cases seem to happen because only the field FileName
is modified, the file is opened read/write before and the new name of the
file is not taken by another file.

I tried first to find the implementation of the SetInfo function to see in
more detail what is going wrong, but I didn't find it. Then, I tried to
identify the problem by printing the Attributes field of the EFI_FILE
\loader\entries\entry+3-0.conf. I found that this field is set to 0 and it
correspond to nothing :
- #define EFI_FILE_READ_ONLY  0x01U
- #define EFI_FILE_HIDDEN     0x02U
- #define EFI_FILE_SYSTEM     0x04U
- #define EFI_FILE_RESERVED   0x08U
- #define EFI_FILE_DIRECTORY  0x10U
- #define EFI_FILE_ARCHIVE    0x20U
- #define EFI_FILE_VALID_ATTR 0x37U

I built the image with Yocto and here are the different partitions in the
image :
# u-boot partition
part --source uboot-part --ondisk mmcblk0 --fstype=vfat --label uboot
--active --align 1024 --fixed-size 32 --mbr
# esp partition
part --source esp-part --ondisk mmcblk0 --fstype=vfat --label esp --align
1024 --part-type C12A7328-F81F-11D2-BA4B-00A0C93EC93B
# recovery partition
part / --source rootfs --ondisk mmcblk0 --fstype=ext4 --label recovery
--align 1024
# create gpt layout with mbr
bootloader --ptable=gpt-hybrid

systemd-boot was started by u-boot using the bootefi command :
fatload mmc 0:2 ${loadaddr} EFI/BOOT/bootarm.efi ; bootefi ${loadaddr}

So, my question is why do I get Access denied when I activate the
systemd-boot bootcounting ? Is it because the Attributes of the file
entry+3-0.conf is not set by u-boot ? If yes, how can I set it correctly ?
