Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F3BC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 19:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC5D8760B;
	Wed, 22 Nov 2023 20:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="a6OGiwV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B05D874BF; Wed, 22 Nov 2023 20:25:23 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478DE875AA
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 20:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50aab20e828so70876e87.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 11:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1700681118; x=1701285918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3MzQ0f+X94UmTAquJXDH+/pyItg1+Dk/SwpGp8hEWg=;
 b=a6OGiwV4oK5oSmUbUQxstO/dkZjFM4U75kkgLdU5Xrx1zwmplh1xVTs7skOuy5QpAb
 46cYjQPSzqdvmBwA4sPB3FQpk3CAD4gfObfotEkLHHlHszI1PFHVxJOVHLtESJDVagkB
 O37fW+JQ5e07Xi3fhc6qsVyxt2z+osy+MFqEwJ6ETtH7q939+eDn9wPT+fDY/WnfCzbF
 QR5cvNhjbCYykOjBNW52qYcyy/PMBrboc5yb9tcqhbefXYjOPBiE9Z0YYAq0LROsOEkK
 1CZfDL9+W4/M4VnjgXuJFtAPNHxA3vzSZlbJMD1NvQppWrrhXdyZ4SuYvN1mV2XIccXL
 xRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700681118; x=1701285918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3MzQ0f+X94UmTAquJXDH+/pyItg1+Dk/SwpGp8hEWg=;
 b=rXoqKetjfI+ogWc0i2PGKyChNeXN/mmVCDt//dqOzTEO61tSrKG16SYK5OR3fuhO6J
 cdM1avgANKIKV+EOkjAzU9FpfrimEB0XLxewgUPcaI34C+GVRsjIZK2ATYym3/BF9m/n
 SG5E5jJTcnV/I1Gl/YPMlV9IG1yCi0nfuU/Jeycxq7ND+2qJAmz2I6VN6dL8dgN9tegA
 8DW2A31yL7Bxi+r6tG5nvyKwBzBUIuGBvN7Il5G2eAB5MHrNiH4+PTFy+0YJk6P57KyP
 OL+k1/rYvtiQ8md07qwqip1ZB94g4hTSpmmM4BIFFBaZ6oYd5u3oE0w531rg+0M8D/Dp
 rnXQ==
X-Gm-Message-State: AOJu0Ywc2KMtgqML+rTyG/6A/LkA3Gn42ZrWJ5SS2n9GDHiWBNbQoNL8
 IT0G6L0vFMu5hYf/OoTsUQvVpA==
X-Google-Smtp-Source: AGHT+IHSBzF1n5cqRkeJFU+JkDMXkL9ZMYT0bv/uLbsDoew1l6CfR3iE8qlnSEmB8lLDd3/Xog0NPw==
X-Received: by 2002:a05:6512:1242:b0:50a:a150:a030 with SMTP id
 fb2-20020a056512124200b0050aa150a030mr3128879lfb.7.1700681118065; 
 Wed, 22 Nov 2023 11:25:18 -0800 (PST)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 d32-20020a0565123d2000b0050aaa675555sm1355790lfv.255.2023.11.22.11.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 11:25:17 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Tom Rini <trini@konsulko.com>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v2 1/2] armv8: layerscape: Enable ext4 environment storage
Date: Wed, 22 Nov 2023 20:24:52 +0100
Message-ID: <20231122192453.1479031-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122192453.1479031-1-artur@conclusive.pl>
References: <20231122192453.1479031-1-artur@conclusive.pl>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

v2: no change

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

