Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656DC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DB68895B;
	Mon,  5 Aug 2024 15:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g9tYNQyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9BF688915; Mon,  5 Aug 2024 14:43:36 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B3B88908
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 14:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b79c27dd01so57882586d6.3
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722861813; x=1723466613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eG7eGFC87WGqiacq9foM7qALIiKS16b8fsVar2T0IIA=;
 b=g9tYNQyB12TqP/5ep6mQCYd+u7tFbTm/Q6fMR5ZcYbTQeq9uGmNvVub03CH4rA1Da0
 Q7DRuqAsYFl2t01ZQUpkD7ze+Hk8UxSGD7TJCFNR96qRV0T9yxb6C5vuRQIUAUXP3soY
 3VQTrlE6g3JO7tuq2gLntJ+rKfYMuloy1FkhllYvYt4oHHhHPcr7cCNioXvG8etVAE7s
 yzolFnbGp37lYbpfhylhV9LqDXvnAohQW0a4XIqLo7/KteK0GAnhQBQFD8zQ508RDsMo
 6+apjx4iaSqupO7pMSJU1bvcfYAG9smo2GWGvwFcAyx9nDb/upJLIHcuaw81OlYWMWVa
 BE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722861813; x=1723466613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eG7eGFC87WGqiacq9foM7qALIiKS16b8fsVar2T0IIA=;
 b=DCDsTFwIeMNv01gpYSyI0jkuMHn4tNu/GO26y+Uf7qgzXe463BeGJc4n5IEIoGLDkQ
 pAy1LV5zJyVxaX7f/NFbkrXLvcZUI4WUoiWG1rWaJBe0WdsE7FENYD+kYGq7g2Oww62Z
 h07yP9d709H2DP8nA38qQAm5e1Jt3rTSBgiZ6m6/kYuTbr0mWzXH6opjazaId8HD76MF
 VEeTeQdbmdz3AqimpfeP2luJuyLux9p97DCf6RSAM0+ahqD2l7XTAblltDpz5/42DgaG
 IGdgmwWTolZH2T6Fl08CfeL4wQKoRRu7aF0B8t7hhLBdxqjE4P28IjBMN7tHeeQjDpkN
 lvnw==
X-Gm-Message-State: AOJu0YxSlsGLJ/Hh+C6ulPTVTDpe7sdGX+CLyz+KB7+PJbvDPMmCUJEP
 BDey1j6DkDfyBYtaaaAX3JhvtTuP8ORjHPRKnEY2GpRAPRQDPTfaFYHjXA==
X-Google-Smtp-Source: AGHT+IF5MjGKjSFBgLS7wGcLlmJJjHEshq/nyqsrgrH4dUKjSc6gKXAB7OQK8NGofgmNuvsPD9I4og==
X-Received: by 2002:a05:6214:568e:b0:6b5:e488:61f5 with SMTP id
 6a1803df08f44-6bb984069a9mr121641636d6.40.1722861813507; 
 Mon, 05 Aug 2024 05:43:33 -0700 (PDT)
Received: from p1g2.lan (128-78-204-97.abo.bbox.fr. [128.78.204.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c87bb90sm34984796d6.130.2024.08.05.05.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:43:33 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH 2/5] tools: imx8image: add upower image support
Date: Mon,  5 Aug 2024 14:43:23 +0200
Message-ID: <20240805124326.544310-3-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805124326.544310-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Aug 2024 15:54:59 +0200
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

Part of the upower management was included in a previous commit [1].
This patch only adds the bits required to properly parse a config file
that would include the binary as follows:
IMAGE PWR upower.bin

[1] 6ec65c8558f (tools: image: support i.MX93)

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
---
 include/imx8image.h | 1 +
 tools/imx8image.c   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/imx8image.h b/include/imx8image.h
index 32064bfeeb8..85fb642ae39 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -162,6 +162,7 @@ enum imx8image_cmd {
 enum imx8image_core_type {
 	CFG_CORE_INVALID,
 	CFG_SCU,
+	CFG_PWR,
 	CFG_M40,
 	CFG_M41,
 	CFG_A35,
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 53ab16637ba..5eb4b9612c8 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -57,6 +57,7 @@ static table_entry_t imx8image_cmds[] = {
 
 static table_entry_t imx8image_core_entries[] = {
 	{CFG_SCU,	"SCU",			"scu core",	},
+	{CFG_PWR,	"PWR",			"uPower core",	},
 	{CFG_M40,	"M40",			"M4 core 0",	},
 	{CFG_M41,	"M41",			"M4 core 1",	},
 	{CFG_A35,	"A35",			"A35 core",	},
@@ -181,6 +182,10 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 			param_stack[p_idx].option = SCFW;
 			param_stack[p_idx++].filename = token;
 			break;
+		case CFG_PWR:
+			param_stack[p_idx].option = UPOWER;
+			param_stack[p_idx++].filename = token;
+			break;
 		case CFG_M40:
 			param_stack[p_idx].option = M40;
 			param_stack[p_idx].ext = 0;
-- 
2.43.0

