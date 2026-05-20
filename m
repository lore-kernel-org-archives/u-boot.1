Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD685CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB9984881;
	Wed, 20 May 2026 15:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tml/7ogD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0FE84882; Wed, 20 May 2026 15:52:05 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B114846BD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so32691235e9.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779285123; x=1779889923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L6jAjXlGh4GCln9OqtNXvhQG3jztMQI4qVg48pqVmag=;
 b=Tml/7ogDq3myz6uY1zT+C/dhmDW2P0O89vYwGvSVAGC0rOpR5YJwmdlaaxqWmr7lQX
 VM+DBTYTYIZ2YybumSme/5l1u11StoAFGPsbmEvXBMWfPXcQEqtQ4JosV/QkDKZXAxT4
 vJN/3GTAetsIADXPPax0DjUO8Oka5/SGcxP1xKrbBGTGtIgvQD9kMBLwVEV9hzYEVX5O
 VOmGCopMaLzTscY0ZMplkpC3Mlx3z5Z7t7vAB+A7uE8RT4zuW/iJ7hLXu41qEm8OYtgL
 4+Fn1Wu0c/JgTgIl82ksnqJCE7Rpr4JW1DD39DWefslq8P8uWgH/6VPvdkwZDH4AvT7e
 Xp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779285123; x=1779889923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6jAjXlGh4GCln9OqtNXvhQG3jztMQI4qVg48pqVmag=;
 b=FFqxf/XtkO95ocXXebizo2QwhiHF+jIZlUzoRwkwdGuldNQ0o67ZXQYXRfJcruHGjN
 7S5bK6xRCTnqwvxe24w6nFg1/CYDYrduSS7ACjFtYERs7elJYFgBiFUzUTKsvTrWi5IZ
 I7Dw0Hlk+YnKm+dxdkZYzHrgm1NCNOpemJxz5q112n6ZwYEhYvgg5F0zBFIBCn95PGkN
 xpTgHhHBJpUT6NBq/MPyMjC+3UAIhS72V2QFapjTpuFzn3IA2UOUapS42PjAH3Z9GDsb
 yNLmOvApYnHmmMkDJpDZkTTP6VQrnIHITDY4u6jspNJl4sHKs/yYWCPYtxG1qi7pgKi8
 k/Og==
X-Forwarded-Encrypted: i=1;
 AFNElJ+A/8Z56h11p6uXlhhlLBC1JpEFpNHyB0ROavEt9vG1V5xfUxrRC2QVN0a1SckfUYr4DwPxEgM=@lists.denx.de
X-Gm-Message-State: AOJu0YzQu2TYsd3h0cs46sAy1L50k8IB6rJmDAkVBNPYY0t5V7I4WZU6
 6qcgfxXjY/zpaqombfzTpn8eoynC5kTNgv4QlZBKacFgzICc72GvpPKR
X-Gm-Gg: Acq92OGSHeTLKSBLOwsK5LFZdLhKxCFV2yD575swsD1NgiOk95ajfdUuFGmWCLngscB
 NuvzKDUEdEnAMTZf1BxlhBhh2bC52aheuA0mdpHbDFMkwiIkzOClBVTizhsrugecEjapX01iMD8
 wskv+MyQ3LpSFkUr+ucvau0bcUlYkAVVxI8vPH3jINTyZ4ml/SiRTIkjYAsmtSeFr0zQhTGsQcX
 rzt2QTg9RbDlvm9UdFo0ZuzO0PumQ+IEchgcvM2nlsJpCfBRNDt4LA5scJ8dCX5VLHsTKcw7DMf
 jdYQnS647IJC9x3bS/WFc878kF2j9a9knN302q0bOkEbkYXjWLAc7VK4MdJD3ZgsEIZbsDblB38
 sPzfKEyz4AhkEQvkMzeXsyFhdDaHmPQPae5/losDdbfsyveZz7bZAFopnnc1cxfl4eMEVoxHKzD
 87ZXpJbpci4WVQ83QWfjjh8W/pdh9qVOWttlh2LCPlG8XgtoNpbJDu7vt/WSy1gGDUoWLCKqVwb
 eZXwLdnxqaruOqINrtoRXokY6p0Bf20VPwjBuDE6pYa+g==
X-Received: by 2002:a05:600c:37ca:b0:489:1b10:d896 with SMTP id
 5b1f17b1804b1-48fe59af198mr376449155e9.0.1779285122757; 
 Wed, 20 May 2026 06:52:02 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-5-34-196.retail.telecomitalia.it. [87.5.34.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe7dd22sm177390975e9.7.2026.05.20.06.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:52:01 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1] board: toradex: verdin-imx95: fix ram size check
 calculated addresses
Date: Wed, 20 May 2026 15:51:34 +0200
Message-ID: <20260520135138.1047110-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The ram_alias_checks addresses are 32 bit values. When summed as 64 bit
values the calculation is done correctly, otherwise, if they are summed
as 32 bit values, the sum wraps around.

Fix by adding uintptr_t recast to the base address.

Fixes: 60d8255d8dc0 ("board: toradex: add Toradex Verdin iMX95")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/verdin-imx95/verdin-imx95.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/toradex/verdin-imx95/verdin-imx95.c b/board/toradex/verdin-imx95/verdin-imx95.c
index 60c1dbb5e294..7c0804c1d1ce 100644
--- a/board/toradex/verdin-imx95/verdin-imx95.c
+++ b/board/toradex/verdin-imx95/verdin-imx95.c
@@ -50,10 +50,10 @@ int board_late_init(void)
 }
 
 static const struct ram_alias_check ram_alias_checks[] = {
-	{ (void *)(PHYS_SDRAM + SZ_8G), (void *)(PHYS_SDRAM), SZ_16G },
-	{ (void *)(PHYS_SDRAM + SZ_4G), (void *)(PHYS_SDRAM), SZ_8G },
-	{ (void *)(PHYS_SDRAM + SZ_2G), (void *)(PHYS_SDRAM), SZ_4G },
-	{ (void *)(PHYS_SDRAM + SZ_1G), (void *)(PHYS_SDRAM), SZ_2G },
+	{ (void *)((uintptr_t)PHYS_SDRAM + SZ_8G), (void *)(PHYS_SDRAM), SZ_16G },
+	{ (void *)((uintptr_t)PHYS_SDRAM + SZ_4G), (void *)(PHYS_SDRAM), SZ_8G },
+	{ (void *)((uintptr_t)PHYS_SDRAM + SZ_2G), (void *)(PHYS_SDRAM), SZ_4G },
+	{ (void *)((uintptr_t)PHYS_SDRAM + SZ_1G), (void *)(PHYS_SDRAM), SZ_2G },
 	{ NULL }
 };
 
-- 
2.43.0

