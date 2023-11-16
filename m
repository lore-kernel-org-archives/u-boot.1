Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14517C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8861387499;
	Thu, 16 Nov 2023 14:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="S4DbGRKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186A586F73; Thu, 16 Nov 2023 14:17:07 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA6486F73
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9e28724ac88so111500566b.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1700140622; x=1700745422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOooz7EfklbaJLalJkDLmrhthjjmOc06tz4zjJxjiKU=;
 b=S4DbGRKlEy/1ffYnus3QowGnUqARuHwORly85MZ8Ifr63V9VdtCBOx3tYdJn7jisLX
 T2Z0RlHVasdmqevHOmM4zVkC2cwAxlynVrBzUvZlPhegudAAc/cq13bHPbRTGkVu8IeK
 FnRsCcs98chvC++feGwG6R4SF/zgH0496SEmZfXAbDRpnhTVMjvfCdchgYoKmtRDpVxr
 NfK4YUv5c3+l07+WyCzhZmJGKULLJE+R4CavUKQFXayE3lTE2PBKCNRDO58jmgzYh77q
 4pguV4mBl0Uf19O9C4156jbHVcS8sRe7hdL+QWRBfgxOSTGu/HGnK7s4L3Kps249RJQy
 uidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140622; x=1700745422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOooz7EfklbaJLalJkDLmrhthjjmOc06tz4zjJxjiKU=;
 b=a/nKkdIsPsO+7i4Xopz0L/SExWfVaSybmxnsApKlv/+DRy3dMt6JNe/RsupWio3omk
 aG5JiiIYhvvzRn5OJs3eMjBSveKXdtH7eAr31rApX1nUkQVJHJtFl1bcv6qug1X8eYK/
 FDf9kElOlYNgmXXvfAHge5Mh9JtvP7QkSzF5g+zKaycqjFCNI7eTU2tDquJkjyCQe9Rm
 wa35fxsEqqKFtTLaJgmazxb6YdxiJ8DKZoIUUJ7+c4qWa8MUd4W46LoFDn+gMcSwZ38b
 62/c0jTJxQLS9Thuy34yiA/l9Q4rnhQUB0hgP5YDYBfIB3l5F7zXuwqqEzCnSYd9weLv
 kZjw==
X-Gm-Message-State: AOJu0YwBWBP94CS9WYqX5ELv7Dr8W2ohaaB6AQxcrLazRUPVMRfCuvu9
 7MpQG2oD3SrVfP0C8KGZVowO8g==
X-Google-Smtp-Source: AGHT+IEnopz/hoB1vbAyDpGfhbFi23INTmV4A88mYNL1KmgjVMHfSMsgJ8Z33m2MtPCJ+C0DKDDZdQ==
X-Received: by 2002:a17:906:6d4e:b0:9ba:1d08:ad43 with SMTP id
 a14-20020a1709066d4e00b009ba1d08ad43mr11818349ejt.70.1700140622320; 
 Thu, 16 Nov 2023 05:17:02 -0800 (PST)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 h17-20020a1709063b5100b009e6e82939f9sm8347885ejf.26.2023.11.16.05.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 05:17:01 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH 1/2] armv8: layerscape: Enable ext4 environment storage
Date: Thu, 16 Nov 2023 14:16:29 +0100
Message-ID: <20231116131630.407502-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231116131630.407502-1-artur@conclusive.pl>
References: <20231116131630.407502-1-artur@conclusive.pl>
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

From: Jakub Klama <jakub@conclusive.pl>

Some boards keep their environment on MMC storage within an ext4
partition.

Signed-off-by: Jakub Klama <jakub@conclusive.pl>
Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index 12d31184ad91..3775cb493732 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -857,6 +857,11 @@ enum env_location arch_env_get_location(enum env_operation op, int prio)
 		break;
 	}
 
+#ifdef CONFIG_ENV_IS_IN_EXT4
+	if (env_loc == ENVL_MMC)
+		return ENVL_EXT4;
+#endif
+
 	return env_loc;
 }
 #endif	/* CONFIG_TFABOOT */
-- 
2.42.1

