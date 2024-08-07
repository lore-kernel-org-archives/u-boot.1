Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B676BC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D39088BD5;
	Wed,  7 Aug 2024 16:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="koUZsSbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9BB88CF0; Wed,  7 Aug 2024 16:14:54 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A2888B9B
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-26875ace6cbso455520fac.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723040090; x=1723644890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TAxqye0nL/tAgsg+fvSvwzPsFbsCGVZbpGamUpj3F4A=;
 b=koUZsSbJXmiZQApcEPO+x+Cj9+XA3HSBwXT1K/7tpn3Z4TFISoQ8gharjdmcZZqqlK
 dnWmAp3f8quneTV7fooJwXvIAnnA7LtXfEh0vgQR5XRFZ/rYVgIa9duBhdZKlH+cZEwu
 l+RmZGlqM2q+zP92rF8KU9jee4jt3u1UI4vnQ90L1IrRCPmJ0vMixtucpDLCFaKiD5ME
 hNlbZZaygjW1TeyGFLIYtRwhHN/XTmoKHQ8aIK3rJbfip/hkTfXjQ5r31jjSFoX5O4YX
 OFHMYc83IHgWutJZLkmEidPNOliFxnFYd5x+kgPI8BwHzZqs/1PfaIsdvluVpXkjvOUL
 yN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040090; x=1723644890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TAxqye0nL/tAgsg+fvSvwzPsFbsCGVZbpGamUpj3F4A=;
 b=AyWidH7JdbrFWmpRHLu88lkTkXAbatDaopcfgCtjIoEpaeJxwnupX7l7EoWJzcY89E
 az+AZCgiK3C6eDdG2VzkxW7GajgdolDDtyzJhJglo7ajizRvqW5y7abdtgdw+EMcLuHL
 s4DmmbUJxFyjQu9DYi1UfVuIE5T5tU3PpxHCtHyg5Gzn027dj8kapLS2oDUgaBhn5RHY
 JYmISrD2RY9J5ATH8dxL5WSxZuvKmfQsWHYhQEZxbGdeJDU+Oi9bBnof9icZYC+o+bGu
 ggB2ku9DFEPcWkzVPVvs9i5QOBc+LDWqFBSISJljDmPPTJPmvjyfW4lzb+De6HpupJLF
 Ph9A==
X-Gm-Message-State: AOJu0YyqmWlbc9BURJqzhe10tmi6jqFZLBDo6xwGA9Iw8C0E2PMLbXls
 oTa8I/2KnxaLdsR7Innojsvo41WzJ6LNdAC8NF1pkJT5oFNCZ7LaQKb/aA==
X-Google-Smtp-Source: AGHT+IErt4oL6OYAv4ZKMqp0etBU6ZStPrxtJW5G5IkS75QueAKuOOdu7g0CpWQOBpNCb2P+Pk4KEQ==
X-Received: by 2002:a05:6870:168b:b0:25e:b6c2:3bcb with SMTP id
 586e51a60fabf-26911248889mr972355fac.0.1723040089768; 
 Wed, 07 Aug 2024 07:14:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::d80b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67fb3bsm3915231fac.49.2024.08.07.07.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:14:49 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] android_ab: Fix backup offset calculation
Date: Wed,  7 Aug 2024 08:13:45 -0600
Message-ID: <20240807141434.733085-1-JPEWhacker@gmail.com>
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

The backup offset is in bytes, but was incorrectly be interpreted as
blocks, leading to it being written to the wrong location. Fix the
calculation and clarify that ANDROID_AB_BACKUP_OFFSET is in bytes and
must be a multiple of the block size.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 boot/android_ab.c | 4 ++--
 common/Kconfig    | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 143f373aae..b253200161 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -139,8 +139,8 @@ static int ab_control_store(struct blk_desc *dev_desc,
 {
 	ulong abc_offset, abc_blocks, ret;
 
-	abc_offset = offset +
-		     offsetof(struct bootloader_message_ab, slot_suffix) /
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

