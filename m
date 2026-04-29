Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D44FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 16:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAF7848A9;
	Wed, 29 Apr 2026 18:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="orOUSRZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC5F848B6; Wed, 29 Apr 2026 18:56:37 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD6984707
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 18:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C5F5A3F9B5
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777481794;
 bh=/4fo/U9IFuuwinOE+Wiwr+DLZh1wMxk0UqAE1SQ0ai0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=orOUSRZeW9PQlc2VToPXdcnvwoZpuOUJ/+t8FiMNE+6N7+q6ykEUGsRGEJf9myvz7
 HuUid9J69FcOa3/WIyzCPLhel0aghGjYRb+HQJLBPDL2e/7htMH66KdBCmSsZN3gOn
 HXRGmkf3PFuYjGiV2jTcRjndpxHefGrFJzO/3WdmzBdRAey2L7XRS7HhZD64Ob0SS2
 GcgxdjalpeT559wr/Rd4wCLQN/AACP6TqwZWDje+C5lIqt6SaREh+/UIYDaQqIA1ya
 9fMO74lo4kMiLHUldaZFZmHK2hrZ+9m9ZpDevzR54xmwYu+0nY3P4EFRQoMF6+DXpF
 DVSWA+CYqbdy85g7xjkUWtMYVBNTRVeGQynrbSeM5UE0t7tY05gtXsBRvCLJZ3HCba
 yzgYHbeJzO84b+Ga87pdqXHl3p6ArbF2fq/PZBpSGL3BhY4XNdAmR3paOl4Xg6zMnj
 LVV5l1MUR5PIaJmB1N/3r6oOp4mtB9S2LuvRscp8qFZBhL/WytcZVKEZ8D0wXKqe54
 weBhmcob+d5ltyZW15ChdgpTswT1KuheRPsUCwSiaNYQ8epiPrbS8Bj8eXnwDix28J
 DU5kNXildi6UTM9V8sbtAnNwWQGJa74u8LdIiRFuW+0/s2B+LH8ZhxgXEC/TZeD90S
 tOYzaxk7HlVZnvUgKrBV8qZs=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-440d12a472eso19780f8f.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777481794; x=1778086594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4fo/U9IFuuwinOE+Wiwr+DLZh1wMxk0UqAE1SQ0ai0=;
 b=p7QdtlBeWwZK7nu3vnTJL/E9cYkj4hjAamhmIvlttAOV18GLNPKCPLbzcLLra4ClvE
 d3r6o4rvTpdzfTXhVfW9Ihp6/FXiQN/TzfX9W4cFIR8EbRZgNfrW8BrZQE2B0Zg2caNc
 +kgQ9GZ2Lzkj5g5t/HM0zm8eCr7uj+RpaMkTeE9H64fR9dtcVxmS+llI/sfiymrKyx8S
 AScP2fKtA70teQNGW1nvabLTpsaODSmrNHAzQFy2c1qq9BZHVDiLjednHrXGZhTOyCxu
 tQTkGh+zXbyb3Kkd2NOS4qa0HYci7lm6oD8as9H2/dxHfR9ko94NKzsjs12gc9CXKt4l
 lH7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FO5rhcabKr15ww+mmF2TSjoKLshRBWv6AHkiEnGEtw6WFpzOKzxWrS8NLbDyLtIl1owNmDXM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7MHcv4uPtIUBHlrV/FnD9djXK4mdUTip+d+HZbCvPP1w2SX0s
 SrDc8laFy3PjMQslqIo6bebXIcPYh8I2MXtJ9BFalQHzzOAML7ajw9YKqmhAc0cDahkKn0G+T6k
 i9zvp/gr7izkE13B20ZeV2Fx41q4Woyu2P3iR4B6pEO5qpWqQhDUHbH4F63UYqZffM5CPn3A=
X-Gm-Gg: AeBDietZJxa9MPSFni6CrAenZe3PcW/kv0Df11FnnRuofq7mlXGTp9Hifr2qMeqBfQo
 i5PlfN5nnNcCnzT7TrhUEdetoswsyh0tD5QMlojxC1mkenpc5pgAccNmUNE7fhkMKtxIUNXf2Df
 f8mJ/n6uvIZi7OLLq5PWJpP9iM3szn9GVio8UXBLdA8DsZ3G+1Xvobnp3OlAk5J8bSgImuHPTg+
 OTapQRZPemUEfHzYHE22IwQIz0NPt5jKvlFVT+CQsNjOMSharNBf4BPFfJ/HifnU+N8K2gxa1lE
 FHBO9GXFkiymC2jDaER66Jdc8sRrwG1qKt72ht7XPq7IkODBAKAxd0W86mTKxzvWTp9EsxJ03DG
 BOahckJyOCSlz3MixsG4s0A8wTv7wEpqvGc/n7iXv7Vqh2+duYzYA7aqJ20sigDGj1eYMqXltFR
 b5AF7xSbF5fziIT6Xirg0/WPZy0CQz7E6GQLFs5t62tRuf+XQoY30j0O6Hn2Yz
X-Received: by 2002:a05:6000:26d2:b0:43d:68d4:7469 with SMTP id
 ffacd0b85a97d-4464896354fmr15563648f8f.11.1777481794293; 
 Wed, 29 Apr 2026 09:56:34 -0700 (PDT)
X-Received: by 2002:a05:6000:26d2:b0:43d:68d4:7469 with SMTP id
 ffacd0b85a97d-4464896354fmr15563620f8f.11.1777481793797; 
 Wed, 29 Apr 2026 09:56:33 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d47f56sm6923810f8f.2.2026.04.29.09.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 09:56:33 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: eficonfig: adjust struct eficonfig_entry, field key
Date: Wed, 29 Apr 2026 18:56:29 +0200
Message-ID: <20260429165629.104063-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

The number EFICONFIG_ENTRY_NUM_MAX - 1 must be printable
to field key of struct eficonfig_entry.

Fixes: 1f0583beeb32 ("eficonfig: set EFICONFIG_ENTRY_NUM_MAX to INT_MAX - 1")
Fixes: 23aa0502a4b9 ("eficonfig: increase the number of menu entries")
Addresses-Coverity-ID: 583414 - Out-of-bounds write
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_config.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/efi_config.h b/include/efi_config.h
index 23211e799fc..bff77a5f961 100644
--- a/include/efi_config.h
+++ b/include/efi_config.h
@@ -24,7 +24,7 @@ typedef efi_status_t (*eficonfig_entry_func)(void *data);
  *
  * @num:	menu entry index
  * @title:	title of entry
- * @key:	unique key
+ * @key:	unique key, takes a number up to EFICONFIG_ENTRY_NUM_MAX - 1
  * @efi_menu:	pointer to the menu structure
  * @func:	callback function to be called when this entry is selected
  * @data:	data to be passed to the callback function, caller must free() this pointer
@@ -33,7 +33,7 @@ typedef efi_status_t (*eficonfig_entry_func)(void *data);
 struct eficonfig_entry {
 	u32 num;
 	char *title;
-	char key[3];
+	char key[11];
 	struct efimenu *efi_menu;
 	eficonfig_entry_func func;
 	void *data;
-- 
2.53.0

