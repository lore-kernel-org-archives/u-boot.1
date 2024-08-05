Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C10DC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 21:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB7088906;
	Mon,  5 Aug 2024 23:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gxYo1r6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661CD8885D; Mon,  5 Aug 2024 23:25:23 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB388867B
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 23:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so4754941f8f.3
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722893121; x=1723497921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVqpJc/h+a9l35m/Phc858J9o2hhvtznd2pMSyT8Ynk=;
 b=gxYo1r6c6hpRrmtS2z6KRYl28++Fbn5Gs84pJOveXQyxvor7/DoXewd8ZacebTEfeh
 sWwf9ukeqK0izdcg5oAoeVoy1x50p5C51W2AZUUe+p+z0E/3ZAA5N2038Jmyq7XxEO2T
 4PE8Ep72tf90SWLUUcF1chKImNAuv7mo6rRorUojD0JiuRcGO5DkahM6tbPotoWyeyc8
 lWJEDUd0aI19khQMtlQDM15S5fUl88J83SOClwKucmLnw00q4qfwbR0AWcYBB0oyi2VR
 HW2pIqduMzde1l+gwXuuA9GFtAwDMgWW5bbzsCINOP5k6INXRALr8tYepg84oC66gRA1
 begA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722893121; x=1723497921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVqpJc/h+a9l35m/Phc858J9o2hhvtznd2pMSyT8Ynk=;
 b=BxkVRoCXlRTZ47gmLOSVk/Dtbqc4CInwuOWWq2MYRQ0BKIRpsIm1WkO44Qp0y6vnDM
 czWTSKyUijtaX1I8WyudAeEMwucvCEm03DdIST1PC8CoXMqqeU7bHNQTtxaJ/rQyX2Ck
 OtTZQ/yxVutBENUe4NU037V3nzql6DXdZN6wDuxGl1alv/q6RqMI2MQgA9FS2N4P5Nft
 nAyVmvOorwrRhi37HmgSic+9nQC8l4U+M6MfL9nzsSejQCBTs+rHcO5Rsb277XdRma2m
 Bd8sLzlkNHot5w0XU7UROQcPR+o5aKlVnAm5jXbYnbOzxRqcyVoPYH/vsJkeXQv+IYbF
 sd3g==
X-Gm-Message-State: AOJu0YwJltzxCUPjbbXhAdfJC2AQEHuS0kzqwLRlBxuQyfuK34mqRnOn
 +z3QwTk34j/2ofdv8zP6j6P4bICeUdhtPKjBoXmA18d/8GjXQPs1tIL0SQ==
X-Google-Smtp-Source: AGHT+IG9ObQ5AJ5iiKaD0dr6FOiMKfC1Ii7t7j/a1+e5gXcrAYW1D2wsAFjeZe6ORaQ95UnkY8UKxw==
X-Received: by 2002:a05:6000:d86:b0:34d:ae98:4e7 with SMTP id
 ffacd0b85a97d-36bbc1712eamr8585472f8f.41.1722893120522; 
 Mon, 05 Aug 2024 14:25:20 -0700 (PDT)
Received: from p1g2.lan ([2001:861:3201:3d10:ab7b:e9dd:27f4:647d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c33bsm11018351f8f.22.2024.08.05.14.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 14:25:20 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH v2 2/5] tools: imx8image: add upower image support
Date: Mon,  5 Aug 2024 23:25:08 +0200
Message-ID: <20240805212511.653667-3-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805212511.653667-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805212511.653667-1-bisson.gary@gmail.com>
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

Part of the upower management was included in a previous commit [1].
This patch only adds the bits required to properly parse a config file
that would include the binary as follows:
IMAGE PWR upower.bin

[1] 6ec65c8558f (tools: image: support i.MX93)

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

