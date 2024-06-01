Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35DCC25B7E
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 14:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892BD88239;
	Sat,  1 Jun 2024 16:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2wgPu3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42B98822F; Sat,  1 Jun 2024 16:55:35 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 920318820B
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 16:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7e21b6e98bdso128392639f.0
 for <u-boot@lists.denx.de>; Sat, 01 Jun 2024 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717253731; x=1717858531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tndlB+iqTVzPo1qMRPJF49l+Yph4mzEWfoKG6hU9ffU=;
 b=U2wgPu3YpYtwZ4tfiJAPFx9ig2xEn29tVe3EbuUosbrFMcyb+kVdenAnCRN0iTLK3V
 CxJtYPtYKCAb+mT9YapGhqz+3NgdicDuC50/6EPcai8lK4NT+x3YWRoVMbvjexCgykDD
 4yfXszSxsdQvd9SxzE4k7NCnvR4ps7XLTf0deHh8qhNOkaZjb08DZxZnbLtLfebBaAU5
 S0bSiVvVOx1+MKyQNWTFDhxSBE3foffoT8DfwuF1aNgxHrKPGG8QVsTgkkYt+3AHNf3t
 YFJtp4Lngk1OQxZ4yABUBAI1nzzXxf0yLWJSL0gURZIcYAoHOs68RomiXJ0pj60if10R
 NIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717253731; x=1717858531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tndlB+iqTVzPo1qMRPJF49l+Yph4mzEWfoKG6hU9ffU=;
 b=D32G6wxxDgnFLoi/TfJoFjrDOPVtFwWBBktEFOa58TNczHSYOxE97lu/KK/t/itxE/
 ZujurWmkF6LzshhCyV8ngoxbzL7ZvwGNZHoeTAOB+NhPqH1vNxfJiZn9VVM6wpZbQ6sf
 VO8+HBzdOjV0tg90yG30rIx9AmXqJ0kixRdqFkHj4bddaJGDhdr/P784MD8Epp8Qvg0n
 q2dRJ7eZpFL9b/uVoner4d6KEsdKDS27vnM0MsTo1hKSrREiwUjVc/vm9fQ7VgmDuTg1
 x9KGbzdiX7/clXl0/Taj8GnTQMdQAxrtVe9idzhEjG3mfemR4SttTIW9l2346AdIQnfJ
 ifHA==
X-Gm-Message-State: AOJu0YzJc1prQts1LmOWz7ZejatmPNl2I8FY8gQH6ZpOSbS2roDUZMVd
 JjcUZj4iwXJUMrf/nPWVHh0mQCbRdfKwPnEHq+UkNhWq+KMUkqYBd6GUXn+y
X-Google-Smtp-Source: AGHT+IF3BOLeRB5f5XV/cjsDzzvtm8NjYshIMWxWNQ2I/9N6wJYC5bNTfQaQmRjO/AM8S8CKkpNZfA==
X-Received: by 2002:a05:6602:3c2:b0:7e7:2c84:1369 with SMTP id
 ca18e2360f4ac-7eafff5f8e3mr539984339f.21.1717253731484; 
 Sat, 01 Jun 2024 07:55:31 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:e0b7:c613:ee:e8f3])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b4881d5bdesm1050386173.46.2024.06.01.07.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jun 2024 07:55:31 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 2/2] configs: rzg2_beacon: Realign ENV location and offset
Date: Sat,  1 Jun 2024 09:55:20 -0500
Message-ID: <20240601145521.200132-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240601145521.200132-1-aford173@gmail.com>
References: <20240601145521.200132-1-aford173@gmail.com>
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

The ENV size and offset were changed to different
values in Beacon's downstream release.  Change them to the
same values as the downstream for consistent behavior.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 4aabb1fe03..234c965023 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -3,7 +3,8 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-beacon-rzg2m-kit"
 CONFIG_RCAR_GEN3=y
-- 
2.43.0

