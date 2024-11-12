Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A942D32D8C
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4081893C2;
	Tue, 12 Nov 2024 11:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AVnCfa0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64378931D; Tue, 12 Nov 2024 11:26:51 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3CC2893BC
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 83C8A3F215
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731407208;
 bh=vEVjBcCw7DPTgRmI9UO+Tg4tnBGoY70B4ucpCdvZ3+o=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AVnCfa0l1fuHRWPOzLckY0iYve1womnZbW4SZwvg3gQfGrUZSiE6DCrFAgjGLBmsu
 NX1DUJYnjfk3UBFGSkNNDGlcHrFlkVAwjtP0Cz9RAnfBFMfAwb/7fMnaE1e/Anhnee
 nfVv523r6SUpYCzN+VJi+4EOFAMAA0kQcQIJu0EHrYhJtihmSvDN4s3lHxnd999Us7
 CuFn6lB04VDIe9xpoR7Um8oYjPcLL5Y4xpyCYPZ1QNLsZ8MJS53sLpzxIBcAJ5G2Ac
 C/h5rEC7v2MX+bu1mQ0rzgOB3q/vVrUsDyf1IJcOOclJScDz9QpQw3SFrVsrUFKgwi
 8gZomxqcUsx5A==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43159c07193so51244295e9.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731407208; x=1732012008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEVjBcCw7DPTgRmI9UO+Tg4tnBGoY70B4ucpCdvZ3+o=;
 b=gn5AlyQ2akAlJlNqvlEnOO78zMZvBH5WPBQy3fahgdOOvpsvbiN7IPd6OLFLZV0NK6
 340BQi8TqJG97y5+gqE0SeERoa5v7EdXFewdwayxFFHOliomR+zUSWTVBjULQ8ogQEiM
 no70hk5CZuO1SXp2hnDwve71ZIihw89As9isY7Pi2Czi4qURx3aI/d/d/zx2SUt5PK6S
 AL7L/f81KuL27FJKAr7Qo4iugvYnof5Q3b5c+csDlji1VzcKf4PZt1VGB7hWvHqHIT98
 ogtD0T58xOwH4s230QciWYXI1qoxr9FCTVFpxdV7SD6neGeydMli3sVC+CtN/cE3xm2t
 sBWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKLV/RXCgONRamy15c/wCENySpv1WX/+jJZueIZUNHRHtD5Ca0fhUEnv263n+fVNM7GqivYIQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwxMbwmVZCqtbvR1Q+TGVDw3Rj9TkWtQARJ5nusmMhwGslLVR0s
 Asv8et2aBJSaS+s8TMO8Dk9l5T634S8Dm21jQhLWJhKy2ZIj2tw4eqDnpdbxbNcclAZRbKFyRl5
 u/M4zjATI9Twj5B+B6THa8MTmtixvLPdbkcxtvbYsuvW208ds6b3FW9arRSU8eVDPvF0=
X-Received: by 2002:a05:600c:468b:b0:431:b264:bad9 with SMTP id
 5b1f17b1804b1-432b7505af7mr174877615e9.14.1731407208094; 
 Tue, 12 Nov 2024 02:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjGey2WwnvxY8OyQgRAYgDdIWx+BaiG6BlnwAZ9GZE3UXzLzaI9Liem8ZzsBkGwWgqm4CozA==
X-Received: by 2002:a05:600c:468b:b0:431:b264:bad9 with SMTP id
 5b1f17b1804b1-432b7505af7mr174877485e9.14.1731407207774; 
 Tue, 12 Nov 2024 02:26:47 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432bbf436ffsm141918695e9.44.2024.11.12.02.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 02:26:47 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>, u-boot@lists.denx.de,
 Yuri Zaporozhets <yuriz@vodafonemail.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] configs: SiFive Unmatched: add 'nvme scan' to preboot
Date: Tue, 12 Nov 2024 11:26:44 +0100
Message-ID: <20241112102644.37459-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Without 'nvme scan' the ESP on the NVMe drive is not found early.
EFI variables cannot be persisted.

    Hit any key to stop autoboot:  0
    Cannot persist EFI variables without system partition
    ** Booting bootflow '<NULL>' with efi_mgr
    Loading Boot0000 'mmc 0' failed
    EFI boot manager: Cannot load any image
    Boot failed (err=-14)
    scanning bus for devices...
    ** Booting bootflow 'nvme#1.blk#1.bootdev.part_1' with efi
    Booting /\EFI\BOOT\BOOTRISCV64.EFI
    error: no suitable video mode found.
    GNU GRUB  version 2.12

With 'nmve scan' booting works as expected.

    Hit any key to stop autoboot:  0
    ** Booting bootflow '<NULL>' with efi_mgr
    Loading Boot0000 'mmc 0' failed
    Loading Boot0001 'nvme 0' failed
    Booting: nvme 1
    error: no suitable video mode found.
    GNU GRUB  version 2.12

Reported by Yuri Zaporozhets <yuriz@vodafonemail.de>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	mention board in subject
---
 configs/sifive_unmatched_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 058e5fab683..1ea744ffa80 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -27,7 +27,7 @@ CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x84000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};"
+CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};nvme scan"
 CONFIG_DEFAULT_FDT_FILE="sifive/hifive-unmatched-a00.dtb"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
-- 
2.45.2

