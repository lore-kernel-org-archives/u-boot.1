Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66848EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 06:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3414871D0;
	Tue, 22 Aug 2023 08:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsdAIu6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA5B87244; Tue, 22 Aug 2023 08:32:45 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4342E871C8
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5259cf39154so5152293a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692685961; x=1693290761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFx0DoHCa25pyZwi5z7omycT0PwlW346NuZX94LtBgg=;
 b=nsdAIu6mqX7lhcfJv2LagRg3Th2EPltDPddhcBVV5EtQj+yVRdLm+Zat9559680mKl
 HIMuxa9OthMjgHKCXb9jKScF+SwRwPNh2w5uRv1HG6iEbx8ibHX4jbH6sW2TkuaNsFf5
 0UtH6QFGWprS3jWE0WKOeDiZRj4YDzwEZH3hdQ35ICl2g2rrgzfeELFK3uBjjfpAPYHN
 qxbx5XZq2CfkvI6MCj4NDu3Rj4AhjYBE8xgSJxaoe2epv/cRKu5T6KvNmYGW6IKsEXUy
 56dpMFifQmmA4wK4j7lv1643QWzLtNIZ0ph+AEjGaGdzGl6bXD2cUFAHb3oNFTJE/j2C
 AI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692685961; x=1693290761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFx0DoHCa25pyZwi5z7omycT0PwlW346NuZX94LtBgg=;
 b=ZUir8UW19Cn/9ET7u95w/ANY8q3zEKYnKkui8ngnRnjfZIcl4cF0zKiLq7G2c4Xnw8
 +0KxZ6Lk50ws3rcPe/aK3juGbACON7lKtPmC/2EpMnCR5VutpGJj7QD0e1g5nHFA4xcD
 GFGMMmAAkGfcCahuRKzWEYoO5liUZr2Co98ggWL2P4rOVJyO+smV/koBlgkdx2XHI9+i
 PAC+RnQ3W7ikmDtcKbsxp52krahPbcdaH7BmlF81FsXW4UP8Kq8J8gSs5xYKyjixxYJ7
 k3Pr6/uddP8G8CY8O//7vuyiparCa1pMJawMLcjmlH8vMIHHPsrnF7+97A+o4T7j9slP
 UUvQ==
X-Gm-Message-State: AOJu0Yw4tuDwOF08ppXFJzE9DXGTi+aMiq9O9S3JkNJVb65Upb4jqiwU
 xNG/4CKadSBhlIx2Y/xQUcpt2W61yAygMQ==
X-Google-Smtp-Source: AGHT+IHAOSc2/xfH1CI9xCNMpysQ8riGjgJrJqXLVkmuaCZTE5lLUpgejR4BKbTCGnPhBMjOLeZkuQ==
X-Received: by 2002:aa7:c48f:0:b0:523:b665:e48e with SMTP id
 m15-20020aa7c48f000000b00523b665e48emr7291674edq.7.1692685960574; 
 Mon, 21 Aug 2023 23:32:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 dy21-20020a05640231f500b0052a19a75372sm784320edb.90.2023.08.21.23.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 23:32:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 1/8] power: pmic: palmas: support TI TPS65913 PMIC
Date: Tue, 22 Aug 2023 09:32:13 +0300
Message-Id: <20230822063220.5191-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822063220.5191-1-clamor95@gmail.com>
References: <20230822063220.5191-1-clamor95@gmail.com>
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

Existing PALMAS PMIC driver is fully compatible with TI TPS65913
PMIC found in many Tegra 4 devices, like Tegra Note 7 and ASUS
TF701T. TPS65913 shares same structure of regulators like TPS659038
so data can be reused.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # NVIDIA Tegratab
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/power/pmic/palmas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index 6080cbff0b..d6eb9cb433 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -87,6 +87,7 @@ static struct dm_pmic_ops palmas_ops = {
 
 static const struct udevice_id palmas_ids[] = {
 	{ .compatible = "ti,tps659038", .data = TPS659038 },
+	{ .compatible = "ti,tps65913" , .data = TPS659038 },
 	{ .compatible = "ti,tps65917" , .data = TPS65917 },
 	{ }
 };
-- 
2.39.2

