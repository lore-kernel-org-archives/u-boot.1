Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2ABC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C62D88C07;
	Thu,  2 May 2024 15:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCIwiExl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 041BE88BDD; Thu,  2 May 2024 12:35:21 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D838B88B98
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 12:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antoni.s.jankowski@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78edc49861aso581093185a.3
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714646117; x=1715250917; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cDtmXfRsrEs/eHseugVF9W2VNlQaeRSWb0Hl0KQzXTA=;
 b=KCIwiExlbhtiqM+b8aQaU4BRNiWanGNBWLApEDbAvNmEG0oTwI8trtCXEGl/sgl6bQ
 VnLgE4hN5gd7w35YG/77FeVsOb5iJ7rzKU6vQvX6a1IfrZ4JAudi9CK6vaBy6bjV1Ht5
 HpWszfTnHUXyT0I1KW6SezjPSUNLATaNOJOcm/KyC+Xmq0pfPju9uitvn8YHsSe5dJtE
 gOW8MVmNqPjaJZ30gBiJCeoLbM7DQUV6aGIgshMKpYB2UF/wI63TaU69qh5Z6Ji4YIB+
 dhS+KXgxc+jrk4obgT6vIsavffhDw1khKjmtHBsYrGbt1AzK9fBCeflPkME0MeBCwI5u
 9ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714646117; x=1715250917;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cDtmXfRsrEs/eHseugVF9W2VNlQaeRSWb0Hl0KQzXTA=;
 b=YUcTagxFZwv/vVob3yMTwHpLgpbQtIryhi4g0B8S+mGfaQxhl/x0tgS68dRIAmMZ+P
 7qgAkaH4qyiSh/jAGHLgO0L0flzWX6U36RRZMMGLJq2DLgs84ah1fN+CXa7Uf+3G7t+z
 T5JHvHBKpRzENkt06Grz2wiB9dZokLESg4TTjV9afj/CyZNSA5ztXE1rm5/opZbzs6hQ
 fD1XX5fW/+WPDZYbK2CYsMrQ8hRadUCUTq/Gday3RPEMMIrqXtR2q0kQUpKiU1IQcyA9
 RD0ziMxYP14sWu5rmeFOvJtOzwpqyyoPyzUKCMuxpwAHZLw0iNmkQWqVoYIAp80poNwG
 H4sg==
X-Gm-Message-State: AOJu0YwXCqAO9ZP2DNcrybrdH7s/PLoWoKLEX4shUHnwyJ4ZwRFtYmnH
 apZDM0KhAD/HpdI8nCcZMb+AQneAoWh2TE9knJV+KHkyJJ2HrYPd9fxDD7YlN7BTDx9p572ovLq
 +5hVUGKue0//GEb/doBNPShEZ9j7dWbR2u54=
X-Google-Smtp-Source: AGHT+IH5Z8hhPShhV4kJAs10W1Hbv4CTWg5rK2l7F8/g5Splb6ztP0zV6RasFa1eElGDCFfEqXbGTyA9XFLIaWkAIdI=
X-Received: by 2002:ac8:5e49:0:b0:43a:bcd9:1422 with SMTP id
 i9-20020ac85e49000000b0043abcd91422mr1991317qtx.29.1714646116493; Thu, 02 May
 2024 03:35:16 -0700 (PDT)
MIME-Version: 1.0
From: Antoni Jankowski <antoni.s.jankowski@gmail.com>
Date: Thu, 2 May 2024 13:35:05 +0300
Message-ID: <CAM4sPk_N9e_q4BJ6zaiMyjcunz9gWXwZppdHJ-543coQZdF7ZA@mail.gmail.com>
Subject: U-boot script for RPI with boot partition of ext4 type
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 02 May 2024 15:17:58 +0200
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

Hi,

I'm working with a Raspberry Pi Compute Module 4 and RAUC update tool for
embedded linux.
The problem I'm struggling with is to update both the rootfs and the boot
partition. The approach I'm trying to apply is based on an architecture of
two boot partitions and two rootfs partitions.
The boot and rootfs partitions are supposed to get updated in pairs.

boot_A (/dev/mmcblk0p1)
boot_B (/dev/mmcblk0p2)
rootfs_A (/dev/mmcblk0p3)
rootfs_B (/dev/mmcblk0p4)

For RAUC to be able to write an update to a boot partition it has to be of
*ext4* type and this is the real problem. What should be the u-boot
*boot.scr* script to handle this?
I've read that *fatload* should be replaced with *ext4load* instruction,
however such a simple swap does not work well, the board does not boot at
all.
Are there any other steps I should take to make the board bootable with an
ext4 boot partition?

Below is the source of my original *boot.scr* script:

fdt addr ${fdt_addr} && fdt get value bootargs /chosen bootargs
>
> setenv bootpart "/dev/mmcblk0p3"
> setenv raucslot "A"
> setenv bootargs "${bootargs} root=${bootpart} rauc.slot=${raucslot}"
> fatload mmc 0:1 ${kernel_addr_r} @@KERNEL_IMAGETYPE@@
> if test ! -e mmc 0:1 uboot.env; then saveenv; fi;
> @@KERNEL_BOOTCMD@@ ${kernel_addr_r} - ${fdt_addr}
>

Best regards,
Antoni
