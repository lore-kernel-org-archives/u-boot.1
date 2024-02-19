Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FA2C48260
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F5A387D64;
	Mon, 19 Feb 2024 10:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aD6XHeWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349EC87D1A; Mon, 19 Feb 2024 10:12:29 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4072D87D64
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d509c5706so352674f8f.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708333943; x=1708938743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WpAlYj92YR+zb9uzYjlZ6Bwm81oStj1vjhc5I1UP3vE=;
 b=aD6XHeWyBp70vYEkdj57bt70UsgnFZPhSbv8LwZGkaLwtb/4+0ZyPpql6rAXFFlizd
 87Ri9Qe8uuqyPEFDQLIPleAwwrNNI807F0SbPS5Xe/+eVR7X7rWnKWPpa52p6QwyEIgE
 k77fLN2WGnAivZ4osR+dS2qQrPgnYZ2ph2qQX4u4Ar39cEt5rbjU9TnUZroJ79hoZqit
 QNuFrZquoYeD1BRFW7RtvWAcR1z+dc/bY6GNmEpFoVL9Q+HdsEBrpO810VbTaT2tIT1S
 X/aMiCPpw1kh4CeG2uznXQxxF0jfGh2wHrhi24vP6aLYdzAwUCZw+bPV91t5ZIIa2A2E
 8/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708333943; x=1708938743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WpAlYj92YR+zb9uzYjlZ6Bwm81oStj1vjhc5I1UP3vE=;
 b=lyiM09r5dip48mKxbPZFNUNpDFy9UNlzWLo8PvFAoEqJchChl9HWUfX0Yp35SUoBTQ
 CzRLDNRbhV/LMnIHIng1+CviSX0GYgOoWqmu/Agm/P334jpPy2j1tGYKdjulh3eQ+VLf
 0I+aXyCDZ7vjmo17hWNvPeOfvi1KAQEZ/pRl0gf+B//kaYHHI1XMo/nt2Z9jeEKFT09m
 Q+A8gYKw+QyYT3Wv86iUtGWfXnkbhBnhg/Drwp4NcSLtaKlGnyNe08El2dadPuMWJX10
 SSYgBDDOzFIVWSK3pq/EeBR1R6DznYzVmUCeT7GK9LQTc3hWTYY5mPPT+JvaAOQhaNzw
 TkjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdkFF1aDLcAloNeKV81HaCNxVTNb5LUNyzr+BhpBbLM142RqhSVhkos/EkVb2gBVVbS0glo4iSkZ9suf7w8hUjUhGLLQ==
X-Gm-Message-State: AOJu0YzMLUiEhN3zkRTbGitU6pfCgzMK1PhsVrERIJR8az2KXbbX5yUq
 bZjGzYYJDYFHsyM5Wtp4xg+mz43od7RAvP0IucJq5wiZaYVptX38
X-Google-Smtp-Source: AGHT+IE3G0px34ZCIx8r8LYrYUmSSrIoYLPnodMI4JYTSNdEGEALgfF9w7l4UahP4owgiyVZOI6hqQ==
X-Received: by 2002:a5d:64a7:0:b0:33d:ed4:5c86 with SMTP id
 m7-20020a5d64a7000000b0033d0ed45c86mr10147984wrp.63.1708333942721; 
 Mon, 19 Feb 2024 01:12:22 -0800 (PST)
Received: from morpheus.home.roving-it.com.com
 (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::1c8]) by smtp.googlemail.com with ESMTPSA id
 q2-20020a056000136200b0033d12895cfdsm9947333wrz.61.2024.02.19.01.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 01:12:22 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] disk: dos: Add all options for EFI System Partitions
Date: Mon, 19 Feb 2024 09:12:15 +0000
Message-ID: <20240219091220.1022422-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.1
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

The EFI spec states that the ESP can be any of FAT12/16/32 but for
compatibility doesn't necssarily require the partition to be the
EFI partition table ID of 0xef. A number of arm devices will not
find their firmware on a FAT partition with an ID of 0xef so also
allow the original FAT12/16/32 partition IDs as they are also
permissable for an ESP.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 disk/part_dos.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 567ead7511d..303eb1d13ee 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -40,6 +40,12 @@ static int get_bootable(dos_partition_t *p)
 {
 	int ret = 0;
 
+	if (p->sys_ind == 0x1)
+		ret |= PART_EFI_SYSTEM_PARTITION;
+	if (p->sys_ind == 0x6)
+		ret |= PART_EFI_SYSTEM_PARTITION;
+	if (p->sys_ind == 0x0b)
+		ret |= PART_EFI_SYSTEM_PARTITION;
 	if (p->sys_ind == 0xef)
 		ret |= PART_EFI_SYSTEM_PARTITION;
 	if (p->boot_ind == 0x80)
-- 
2.43.1

