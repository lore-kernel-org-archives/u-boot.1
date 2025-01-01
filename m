Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA99E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59640803C6;
	Wed,  1 Jan 2025 23:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lh+c9TWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57108803DC; Wed,  1 Jan 2025 23:22:17 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE4E80463
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21654fdd5daso137020805ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770131; x=1736374931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vQHhBiU43SN3PMc2mGCcxT81y6zSjFxVM1YC2MwhiY=;
 b=Lh+c9TWn2pcWwpHORqwWGUllO8J9BEfu9rOZ/xu+vY5bDJrGq2+QuHZ2HyZhnfFpvB
 CkvlHJka53inQdKnJzJMSGmqk9exoxQ5TE7b4uazCdAdbff7OCa51lZ+bXYBW0rfdNo8
 scQDbwCm9G86+ORGHEPU6tANOZoA1b44UCnV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770132; x=1736374932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vQHhBiU43SN3PMc2mGCcxT81y6zSjFxVM1YC2MwhiY=;
 b=mf1jq674qEl/9os7SkQJ+/wKCQaU+CPxb8oIpwD2t4+RbUI1R6Lj53ULAVd3HmVqaX
 dy0nmk8p0Ak53XlJWzDH0NXYmxjWmxEObpGDTkJxZ2WbDWKwOSGkTmic1UUIP+Hne9m9
 AOQPy9j04TtuIyr80dppvULggfeanPJxZycNB1/nOJPYbArWZndAO+/FtskNgU73xoPw
 zQ1DGcjH1PcJx5/TnE5h9OYBMdSXYT0SNx5AijtAlTB+1OtMAVxmATUQo6mxPIce1K0r
 XK3x+nQGGmDolUgjxQHlrVG/aJHCnnKD0FjQF1tlbZlahhFxD/sepeV1UitBUjqlsUEn
 UsjA==
X-Gm-Message-State: AOJu0YwbUbF0DePMopr+/VPcaE+SxuV4YhGH4lOC24Sozc9uztzd4TIz
 6fesx316yjBfk+7/vijZbIxjDeXv47FdXKKqjh0c2lVpMw5bOmRiLksigPMHMOjoj+1LDyR7/Ks
 =
X-Gm-Gg: ASbGncuPSfEAfiqp97hb2rz2jP/uRmtlLYcCvQ/Wm74BZL9t4vqLvD55apB3FVmk9Ax
 GGlOBUI4Hd0a6KndctQsamG3NFUCQOnfepVnp8B2DpeOzDjbz5lYKWe0qmR8Y5WMWT9Sj9g4tWL
 MWQ3ZUGMp5M+Kbjk4AmteDcMjkUYzv4MeXnMPozIXT+XFEUa+5LN4asdsAOmes8ZMg6zqSiOumE
 c56KNDo+wDOYzG/o0xWI0NNuGutjzRsLcbq0X/T5hj6mfmYUoo/e18=
X-Google-Smtp-Source: AGHT+IGwejfP04Z8Zd+WmbdJaX4N5nnrWGdFrNHXnyyoTaPtLObtLVpJQ4zHhVcxrlIQ+skxQf5UqA==
X-Received: by 2002:a05:6a20:8412:b0:1e1:a671:7122 with SMTP id
 adf61e73a8af0-1e5e044635dmr71041699637.2.1735770131683; 
 Wed, 01 Jan 2025 14:22:11 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 44/67] upl: Add a compatible string for the upl-params node
Date: Thu,  2 Jan 2025 11:09:30 +1300
Message-ID: <20250101221003.1944600-45-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The latest UPL spec uses a compatible string for this node rather than
relying just on the node's name to indicate its purpose. Add one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 4 +++-
 include/upl.h    | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index c2bb3187803..c29848a9ce3 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -178,7 +178,9 @@ static int add_upl_params(const struct upl *upl, ofnode options)
 	if (ret)
 		return log_msg_ret("img", ret);
 
-	ret = write_addr(upl, node, UPLP_SMBIOS, upl->smbios);
+	ret = ofnode_write_string(node, "compatible", UPLP_UPL_PARAMS_COMPAT);
+	if (!ret)
+		ret = write_addr(upl, node, UPLP_SMBIOS, upl->smbios);
 	if (!ret)
 		ret = write_addr(upl, node, UPLP_ACPI, upl->acpi);
 	if (!ret && upl->bootmode)
diff --git a/include/upl.h b/include/upl.h
index 5ddcd990de4..a4ed24edbb8 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -23,6 +23,7 @@ struct unit_test_state;
 
 #define UPLN_OPTIONS		"options"
 #define UPLN_UPL_PARAMS		"upl-params"
+#define UPLP_UPL_PARAMS_COMPAT	"upl"
 #define UPLP_SMBIOS		"smbios"
 #define UPLP_ACPI		"acpi"
 #define UPLP_BOOTMODE		"bootmode"
-- 
2.43.0

