Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8E0CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 13:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2183C8441D;
	Thu,  9 Oct 2025 15:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R8PcT7rp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC66A844F7; Thu,  9 Oct 2025 15:18:18 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4E2843E8
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 15:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-5ce093debf6so961996137.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760015895; x=1760620695; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Mi4KYTAl+zu9v8DLzcZVMf8EVaUqa6zDLgsGnqYpZk=;
 b=R8PcT7rpnQu6w6vzBZcDy/OzD39Ej89tuYEfAueH8MiL2W4eh16FZh+iECxLiVS2tS
 U4hIkLiEM73LIHUAyPm+8zVW6mDYdkslpID46y2UiUfhKRLjYN59R4+wsmr2SXvU60XS
 CKewqfKDhfD+kfgN0KyaILP6IR7ect5Uz3GqHg34Tu8TH3SnV4Pj9cZCW8q1gm0U+pj6
 j+uNWzXL9lyCLJxiu84Y5cYQ16cURdGpQc0OqeXDK5RFwv1eOQKmbUoq8FWWuy3PdkUR
 Gkbkjap9JpcEE+pI6bXJuVlL/YLz/S5u8JzKwKwfYKPATknAOKKTfSPdYsFPdIAoW7G1
 Ge/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760015895; x=1760620695;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Mi4KYTAl+zu9v8DLzcZVMf8EVaUqa6zDLgsGnqYpZk=;
 b=xLhOcg9/yIEn0HZ3/vmsbQcJ0ctdw8mk7xzrFJkQ7XivQqvPEATBp9WH5w5CBhXD5E
 qcZqdnpu6deEV8bx4AwfPuOuxxayPTRA/fEZ5rwknvv87/EYlQezJLqRvOQGQ6UGWyXK
 OwQncPaW//V7HXvydwl0YdxOABfeHZ6Xocr0GzCo1w5yViVmq474ysKyVPncTVx/sbqU
 PP/4f1WdTyfCb0SYQ9OrAuECbKUPQCjqtLsLaZX+UuY3I5NaShquRfOswyzbfa8RE7/T
 6dJMa4wzv1UJNoX6Y+6SKw0D+34oXbXaHSZ3EqSx2iQjbvyT5wsOYoTr02tNuRRNcsoG
 h4bg==
X-Gm-Message-State: AOJu0YxsBMs6QU0Xk1w0Y8G5oMOyyl4IEW9vW0BO51SPbebUUV5xe+dM
 KxOKJQ3J7mcedn7vDlNny9uWsvT0lsU+B8OJM7RtC+cPYlym7N4FkecYj90dJf8CTRw=
X-Gm-Gg: ASbGncs0KLQq8oPeJmwVwKqi5EzGSZzcFt6GCA9TCNXvd2VI4tO7PNqJUnDBLAxdGlU
 lW+bF0IsvrANUdv62mZTo+42CMuzlClptNvptR4AbOlRCj4mFoY4coaWoZ7a/za4l1QgxkFh7kD
 mYW6Olo9WZJ91xDWE951gV+c9vVlLRXHkz0UsXoKQ5vmi5kixjOQR+EfqO/dOWLG1Jh3P3SeZdw
 qPaG2HEyOCh7b0QjlqxNafNve0E97w14xv/FQDkwpt1smR1p4dM3UkgQ858J4XmoRCqeTRDR5vO
 mqcdjwoqOTfmUbOQdNnb33fTHhjAncE4jhWveETOcMLk8GtakZCot0l7FHmkXqnkW6V4M0bG/y6
 WHbig74Yru1QQE+r+HzHsYBIQLoOn8xAy1X/gCS8Kwh7rEnugMKUQsMIz4tRgTuzS4eBvqUkb/g
 WLhPr29sEc
X-Google-Smtp-Source: AGHT+IFKyFkctHsoIqA7Vzqf0ybCJheFqlQD0gyUqZzdk392gfoXQ4oXaGZ38drlllJdIpvx7S2HcQ==
X-Received: by 2002:a05:6102:a4e:b0:528:92b8:6c3e with SMTP id
 ada2fe7eead31-5d5e21ce95amr3560796137.1.1760015895003; 
 Thu, 09 Oct 2025 06:18:15 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.local ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5d5d3835333sm2400604137.3.2025.10.09.06.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 06:18:14 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
Subject: [PATCH v8 0/2] Improve disk image detection in efi_bootmgr
Date: Thu, 09 Oct 2025 07:17:45 -0600
Message-Id: <20251009-detect_disk_image_type-v8-0-a8b50a3b4acf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPm152gC/x3MSwqAIBRG4a3EHSeYFFhbiRDRv7pED1SiiPaeN
 PwG5zwUERiRuuKhgJMj71uGLgtys90mCPbZpKRqKim18EhwyXiOi+HVTjDpPiDqUdZWWe1b3VK
 Oj4CRr3/cD+/7AZHqZphoAAAA
X-Change-ID: 20251008-detect_disk_image_type-4f04a2a8d989
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.14.3
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

Enhances the process for identifying disk images within the EFI boot
manager. Utilize part_driver_lookup_type() to verify the validity of a
downloaded file as a disk image, rather than depending on file
extensions.

part_driver_lookup_type() is now used in the prepare_loaded_image()
function in the EFI boot manager to detect partitions on a block device
created from a downloaded image. This allows the boot manager to boot
from any disk image that can be recognized by a partition driver, not
just ISO and IMG images.

Update prepare_loaded_image() to create the ramdisk block device
internally, obtain the blk_desc and use part_driver_lookup_type() to
detect a valid partition table.

In try_load_from_uri_path(), try prepare_loaded_image() first to detect
disk images, and fall back to PE-COFF detection only if that fails.

Include part.h in the EFI loader and export part_driver_lookup_type and
add its prototype and documentation in include/part.h. This makes the
partition-driver lookup available to other code paths that need to
detect partition tables on a block descriptor.

---
Changes in v8:
- Cleanup part_driver_lookup_type history after being removed and added
  again.
- Passing CI: https://github.com/u-boot/u-boot/pull/816

- v7 link: https://lore.kernel.org/u-boot/20250925224838.567562-1-javier.tia@linaro.org/
- v6 link: https://lore.kernel.org/u-boot/20250924233120.454116-1-javier.tia@linaro.org/
- v5 link: https://lore.kernel.org/u-boot/20250905172330.135550-1-javier.tia@linaro.org/
- v4 link: https://lore.kernel.org/u-boot/20250903214417.431985-1-javier.tia@linaro.org/
- v3 link: https://lore.kernel.org/u-boot/20250829155415.90634-1-javier.tia@linaro.org/
- v2 link: https://lore.kernel.org/u-boot/20250808213627.649669-1-javier.tia@linaro.org/
- v1 link: https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@linaro.org/

Signed-off-by: Javier Tia <javier.tia@linaro.org>

---
Javier Tia (2):
      part: Export part_driver_lookup_type for external use
      efi_loader: Improve disk image detection in efi_bootmgr

 disk/part.c                  | 18 +---------------
 include/part.h               | 21 +++++++++++++++++++
 lib/efi_loader/efi_bootmgr.c | 49 +++++++++++++++++++++++++++++++-------------
 3 files changed, 57 insertions(+), 31 deletions(-)
---
base-commit: 0ee639ff5af33342c6c2f4579e210d707abc9bc2
change-id: 20251008-detect_disk_image_type-4f04a2a8d989

Best regards,
-- 
Javier Tia <javier.tia@linaro.org>

