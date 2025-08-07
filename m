Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B0C87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C6F84413;
	Thu,  7 Aug 2025 07:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDgjZ4de";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91097843F5; Thu,  7 Aug 2025 07:33:00 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3F68440B
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-31effad130bso545033a91.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544777; x=1755149577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExyaCLbCO/QKYLdCwquBrl2RvysdKhk4M+4+jYNP32M=;
 b=bDgjZ4de/Q45oZprOFdKSVZP8riWRVntCVCT5zNLT+q0rjmSJuWK9YBPdhmqoD6faB
 3yD0kd6dGYb9Rit1bjYBkJlxu73Qo8R3XrTPPTJkddie+lVbNxU17UfGaFFrpXb+cBdp
 QkIgybdtMdcNrIjKaTE3RODpPlFsGBuJjoRP7jKbycfQURcDD9VUvoMmZxSeI/bZ3s/a
 LTQx0ueLc+zTYCBdru3r5TviS3IfJO+ZHvcKwmwra7lyKCc160UQvz+XvFzLxdRXld8x
 uZhO4b98ayMf3O48nNB6uaJCvqeaw64f1OudHwfFc0kFio7EB9JvTSRB6Fh6lX9jhcWb
 6ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544777; x=1755149577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExyaCLbCO/QKYLdCwquBrl2RvysdKhk4M+4+jYNP32M=;
 b=avPcO1xW9Zj9bP9MagpOxWp/Nk5pzEzeL8sr0kT1LLSd5q6EVAglPjA6u0Rk1eDlZG
 7/5VOjKk+yqs+xdHX+gNMMSIa9l9PxnAunYqhePqK/u84Xuowl9TEn1IRmVvlPmfiX/5
 266Jw6Cz6mybXgLRGr9Fyy/vj5KUD4iMCL/ORw6+ZmV8CLqIbGsugPNZushQw50Ioc04
 B7pzCLFdOTvoqe6WvI0DHEnheacDUQBNHzYWWHWRj6DAw78Qvu2/VcrMrpJ5BWAQNKhS
 +eUvDDLAgbYwiGcOUF/8qgic76SL2uNxY+yvdjyDsU6WzL9xhRdefFs3SEwszyUF7JXk
 wMXw==
X-Gm-Message-State: AOJu0Yzpbp9I8/TdEwQC/IT81rmRVVzSvcK90N3U6FIt1tnm2lus4LX2
 dLoHkUSf8IskCrCYtsnKmDE5X/eoEm1s1AGolsaV94tumxLJIF7H4qJB
X-Gm-Gg: ASbGncvATLju68H2+pUEIAoqqfYb5Uu46AmtinolTRo8KFUlWfQhsCMHLzrJBy0GHWS
 QaRhxmtp/HBkSkwmtnBpATeG5z95/gC8FKO/f6mSzoxh/OqX5l7WdcPg3BXPBhu97Hgar3r9bje
 XjVpqdFf29asfEBEH6dt+/05UpdC/CMVDHaDt3NwyZJwzNpx37t+5EQj19BRz5VYwSW9kkkNWb6
 5EY5YBYcMpYvlE460v3lOkjw3sx5zyIqmncu1BtnipeFZaUFB9M/yia1rSEbCx5u4G3CoTcOi+S
 xWi6KXI0fajh25k5+ywI8ZxKGWNLBrgMHEI9Eq3ORHpvSb7w7BZBvyzhxIcuvdLxNCi9Qr3/zoZ
 nJF4luPyXwh+a6moPLatDH2OWqhSLbDKOAMoX3vKPpgIC
X-Google-Smtp-Source: AGHT+IFi4JKuKPx4rjkgY4cLLm3UqKeTiONg3jwhwWNrD88bG8mbYFXP6ujo2phU1TN/Q5mVujqTkA==
X-Received: by 2002:a17:90b:4986:b0:31f:253e:d34f with SMTP id
 98e67ed59e1d1-321675237e7mr7490139a91.19.1754544776558; 
 Wed, 06 Aug 2025 22:32:56 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216126c98fsm4384084a91.21.2025.08.06.22.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:32:56 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v2 5/7] misc: npcm_host_intf: Add Arbel eSPI workaround
Date: Thu,  7 Aug 2025 13:32:22 +0800
Message-Id: <20250807053224.2169557-6-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
References: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
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

Enabling an eSPI channel(e.g. Peripheral Channel) during
an eSPI transaction might cause the BMC eSPI module to
transition to a wrong state and therefore respond with
FATAL_ERROR on incoming transaction.
Add workaround to avoid the module getting into the wrong
state.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/misc/npcm_host_intf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/misc/npcm_host_intf.c b/drivers/misc/npcm_host_intf.c
index 58bab888c3c..2c89bd7a167 100644
--- a/drivers/misc/npcm_host_intf.c
+++ b/drivers/misc/npcm_host_intf.c
@@ -22,6 +22,8 @@
 /* ESPI Register offsets */
 #define ESPICFG			0x4
 #define ESPIHINDP		0x80
+#define ESPI_TEN		0xF0
+#define ESPI_ENG		0xF1
 
 /* MFSEL bit fileds */
 #define MFSEL1_LPCSEL		BIT(26)
@@ -40,6 +42,9 @@
 #define AUTO_HS2		BIT(12)
 #define AUTO_HS3		BIT(16)
 
+#define ESPI_TEN_ENABLE		0x55
+#define ESPI_TEN_DISABLE	0
+
 static int npcm_host_intf_bind(struct udevice *dev)
 {
 	struct regmap *syscon;
@@ -83,6 +88,13 @@ static int npcm_host_intf_bind(struct udevice *dev)
 		val &= ~(CHSUPP_MASK | IOMODE_MASK | MAXFREQ_MASK);
 		val |= IOMODE_SDQ | MAXFREQ_33MHZ | FIELD_PREP(CHSUPP_MASK, ch_supp);
 		writel(val, base + ESPICFG);
+
+		if (device_is_compatible(dev, "nuvoton,npcm845-host-intf")) {
+			/* Workaround: avoid eSPI module getting into wrong state */
+			writeb(ESPI_TEN_ENABLE, base + ESPI_TEN);
+			writeb(BIT(6), base + ESPI_ENG);
+			writeb(ESPI_TEN_DISABLE, base + ESPI_TEN);
+		}
 	} else if (!strcmp(type, "lpc")) {
 		/* Select LPC pin function */
 		regmap_update_bits(syscon, MFSEL4, MFSEL4_ESPISEL, 0);
-- 
2.34.1

