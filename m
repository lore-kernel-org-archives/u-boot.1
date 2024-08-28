Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10297C5B548
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 14:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC0B88829;
	Wed, 28 Aug 2024 16:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O2VEyFeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B023388861; Wed, 28 Aug 2024 16:39:43 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9994288754
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 16:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-82a0f237a68so8065539f.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724855980; x=1725460780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzJgLbSM0euUT+7rKDQMqjuypTS2caIHK3fG2UEAowo=;
 b=O2VEyFeboI1XbFM/v2ZnXxyWwlXokvHcL/sLvgQxAM2tRfgwo9VrSfsvR13D9YyByZ
 jeoA2xl/dFRaRs4yVh9bq+Fo7YqflkbHQVxSrlVKG4e2Q2VdfhQbyq4pqOSt0nI9RKL/
 GHZtMQjqJKydRS2cKOPa9EVhloS9qZgrVFVX2/qmCPxsL07Xewu3ZtifwYNqy3nmRtSO
 /B4qkCcDdqcW4CsQoVFKuLf48hrDOpJBqbaS3505Kfl+T/41252c3MFTdkA9iY0rngoW
 VZDV85llQcGH2Pjwx14AvliGIeaSZRam/zcRW+08lKP3FvQL+9QMH6x10ZpkOJhs5cNA
 uhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724855980; x=1725460780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzJgLbSM0euUT+7rKDQMqjuypTS2caIHK3fG2UEAowo=;
 b=K1OpZzRxpRVtiCgOj8I4DsqLFmc9hyrjrR9reYIWSluRQAsehYqJq57vXBmEyirBwc
 hqeYi/1v1SF7FTkrW+MN00tLTmiQV05/CgiJh0LNsKSqnsrjY7McY9YIYa5F5T5VCl0q
 zBxNK8I5RBOefHq4h01h2swYKn2XpJ1pApBxjID03XmQx6SWykffDjJjguJl5PJjteS0
 uLERkbWRSxswMdc+ogW15QiluPp687j95ZzolWHiPbfZe82BuRaWnadmvdAefZuKt/85
 nrjB9aLHssxL1yGisLqNxUQwykfxg/HKBd1sBjmCcEsLt3SfapQVmwoLcDKEnr0wuGEs
 1sFQ==
X-Gm-Message-State: AOJu0Yz1FxZaSAXLsEEVb5HWosA0ac9EPZOFpiC3/B4z07nALgBmY21U
 sRakZ/gGM4IaAtGyaeva80TlQNQQNtacE4Ql1KYvc6XIEscI2ikQpDA/9w==
X-Google-Smtp-Source: AGHT+IGqeUXpBIg4K0vRhdov2UhbE+wUVqnUP8rKdWwV9uGVMiodj5HOaUKpeUXrbV2vKcZWRLzpEw==
X-Received: by 2002:a05:6602:6087:b0:7fb:87d6:64b with SMTP id
 ca18e2360f4ac-8278738a54cmr2295537139f.17.1724855979548; 
 Wed, 28 Aug 2024 07:39:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::9ea])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82540b5c7b4sm389619339f.35.2024.08.28.07.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 07:39:38 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] android_ab: Fixes: Fix backup offset calculation
Date: Wed, 28 Aug 2024 08:37:57 -0600
Message-ID: <20240828143924.3987331-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807141434.733085-1-JPEWhacker@gmail.com>
References: <20240807141434.733085-1-JPEWhacker@gmail.com>
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

The backup offset is in bytes, but was incorrectly be interpreted as
blocks, leading to it being written to the wrong location. Fix the
calculation, clarify that ANDROID_AB_BACKUP_OFFSET is in bytes and must
be a multiple of the block size, and add a runtime check to validate the
offset.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 boot/android_ab.c | 9 +++++++--
 common/Kconfig    | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 143f373aae..1196a189ed 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -139,8 +139,13 @@ static int ab_control_store(struct blk_desc *dev_desc,
 {
 	ulong abc_offset, abc_blocks, ret;
 
-	abc_offset = offset +
-		     offsetof(struct bootloader_message_ab, slot_suffix) /
+	if (offset % part_info->blksz) {
+		log_err("ANDROID: offset not block aligned\n");
+		return -EINVAL;
+	}
+
+	abc_offset = (offset +
+		      offsetof(struct bootloader_message_ab, slot_suffix)) /
 		     part_info->blksz;
 	abc_blocks = DIV_ROUND_UP(sizeof(struct bootloader_control),
 				  part_info->blksz);
diff --git a/common/Kconfig b/common/Kconfig
index 83c81edac2..e1b8557e0c 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -986,7 +986,8 @@ config ANDROID_AB_BACKUP_OFFSET
 	help
 	  If non-zero, a backup bootloader message starting at this offset in
 	  the partition will tried in the event that the primary one (starting
-	  at offset 0) fails its checksum.
+	  at offset 0) fails its checksum. The offset is in bytes and must be
+	  multiple of the block size.
 
 endmenu
 
-- 
2.45.2

