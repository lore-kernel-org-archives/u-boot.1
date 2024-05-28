Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB874C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 10:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA80F884B3;
	Tue, 28 May 2024 12:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CV/sPOll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B96B58844E; Tue, 28 May 2024 12:00:05 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91E688481
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6265d3ccf7so82595866b.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716890403; x=1717495203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjbZPFEoUxSp2A35tLB1KsC8ENXrOOJluGWRutJQ2fQ=;
 b=CV/sPOllXh2xOeP4TNUKOKU9i1T9sopFj6LKJmnHCVY/rN/PXOyDALtmZgSNUooxfK
 vpPTPKaPJ8Jd7WDh8FiVj97pS74+p3jSA2SodTp2p5EkXFPPyh37Dmz3AsNsJiEs342e
 pPPZ31shm8ihTe9i4jrK5iOsAPSGosAWToOW1DGzJ4KwU9qG7TlIDo7Reh+ZWAqba1hX
 ladVelRcAqDp7Xqc5fQa7DysXGlvg29lLacuO5a9n6xrWIBcqd3+atC7Pq/qbIL7sEfA
 Ui9Zri89yjoARmEH63AT/qwyHwTqu4MmBuu1DgSGSPXNjCIqYVk1JcBPPH/EDbWE0DFF
 jFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716890403; x=1717495203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjbZPFEoUxSp2A35tLB1KsC8ENXrOOJluGWRutJQ2fQ=;
 b=gS4gDkvhJv8VYJ1VBRpSqXgFWo8c5Z5AR39lvkBuTDbRZt/0plov5e4eWLhDdBHA9v
 W/xmEpeRRuGippQb2hikUWMGEnFy9vETClIsTXI/s8LMJjVB2Y5kuylwAHOPVNsxOOo/
 Oa0Q2B8/QiEarBmjujHYouZv5hMoPdaXge/I+3fwvVz8n0WwUlwyqu7PDneqAVR+XvdZ
 8RLLBrOj13c0IvXdMwUa2vCAq5pViWiuUgi7TSDmSXYI7cs6NlyIPJBg/Cz4WSpWYPdL
 ZHSFhBBrzQB8pE7DT2oF4InRbzml0sHWr4ba3vvVX+MCCLGazV1AHVkUslZfCiYtHMuB
 zxpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWJyUSLFvpcNW0BWoPWfgibXEH7nhkid5CsDCJrolkZkP2iZAMqMMILMSabW0Y0hE1O03otNldXlZe6b3bdmDHPglGfA==
X-Gm-Message-State: AOJu0YxosuOSGFn/OplUrUIGKAl9XXT990W5qkDZw0Ek7QwwdC00qV5k
 phfqlyudc88wk6/iWYEgLIKTFe+de/6jptn/YDLbMDy0DVlgJrL4
X-Google-Smtp-Source: AGHT+IG6xwhtqS9X3NUrDnxhfQwZBb5tbpk1OCPxDhJAYJCgYwqVXleSLjPUnQgZMIWRw5UsjNQZ8A==
X-Received: by 2002:a17:906:170f:b0:a59:d063:f5f3 with SMTP id
 a640c23a62f3a-a626501c25cmr741664966b.63.1716890403077; 
 Tue, 28 May 2024 03:00:03 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a634da2e2absm33239266b.87.2024.05.28.03.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:00:02 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 5/5] toradex: tdx-cfg-block: add verdin i.mx8m mini 0090
 pid4
Date: Tue, 28 May 2024 11:59:41 +0200
Message-Id: <20240528095941.872693-6-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
References: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
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

Add new PID4 0090 Verdin iMX8M Mini Quad 4GB WB ET to support
the new hardware variant.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c        | 1 +
 board/toradex/common/tdx-cfg-block.h        | 1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index ec41d4ea3c5b..ded619e92afa 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -160,6 +160,7 @@ const struct toradex_som toradex_modules[] = {
 	[87] = { "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 	[88] = { "Aquila AM69 Octa 32GB WB IT",          TARGET_IS_ENABLED(AQUILA_AM69_A72) },
 	[89] = { "Verdin iMX95 Hexa 16GB WB IT",         TARGET_IS_ENABLED(VERDIN_IMX95)    },
+	[90] = { "Verdin iMX8M Mini Quad 4GB WB ET",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 122a7aceabd6..0d6dd1c3a721 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -115,6 +115,7 @@ enum {
 	VERDIN_IMX8MMQ_2G_IT_NO_CAN,
 	AQUILA_AM69O_32G_WIFI_BT_IT,
 	VERDIN_IMX95H_16G_WIFI_BT_IT,
+	VERDIN_IMX8MMQ_4G_WIFI_BT_ET, /* 90 */
 };
 
 enum {
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 31e8d5fb04b5..0b5a538ae2f1 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -84,7 +84,8 @@ static void select_dt_from_module_version(void)
 		 */
 		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT) ||
 			  (tdx_hw_tag.prodid == VERDIN_IMX8MMDL_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT_NO_CAN);
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT_NO_CAN) ||
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_4G_WIFI_BT_ET);
 	}
 
 	switch (get_pcb_revision()) {
-- 
2.34.1

