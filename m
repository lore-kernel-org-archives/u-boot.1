Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA53C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 677E2884AB;
	Fri,  5 Apr 2024 10:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XOarGDgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F2CC884A8; Fri,  5 Apr 2024 10:22:03 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912B888499
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-343e46ec237so270006f8f.2
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305321; x=1712910121; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2VXhmTPTkrGz79CaY+8KabcI4NMo90SgGYVaGgHBzEU=;
 b=XOarGDgOad38R1+b/hFTMGiMyroJiCSrYvn+Ge1zY+IL+u6ubdUMo4nvole9m/aWDI
 RuxWTFAWOHeCTTP8zz9FJWTkfprCSfhzUat/MDfA+QgGErvdQ1Pmz7h3l7TiCqWTnEom
 Vb9K7ntEWutHxbD03DSMa/ZYRW2gJNU/O2yfEyDMUuMl2sk+swauJqIGsxdbtOTOWkqS
 7EKgKISeL3LuLvrmSiEVBiI59gMlyhoQ2+A6DrLaHc6Ux5fyUQHZnhFlpqjPrGvARivY
 Brr9Qjc9OxU4CEV/wRPW5skBgU5tEju/t14Bj+nKqlxcCiovRSVAaApuYBtiF4hMhMOP
 Wm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305321; x=1712910121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VXhmTPTkrGz79CaY+8KabcI4NMo90SgGYVaGgHBzEU=;
 b=F3UNRAmFwanJ7pjnBlqsWjCfqiMtQoIuA8DuI2JAd4q7RGQ7fyXdXnBhl5mnlF0fQL
 biSZmSK4yjhXiLrhdDfweqUuq/Mi63ZnvEXI/35SNrkGlaZA9+a3fD3s8vEHcXDyrTUQ
 sTbxV1zEGEGb6eLGHm8dFtHQ1ggxk4Idw/vtdhu0im9gmYpoADFR0qm55tACQwJN28Pl
 9hxMyjeekuC28s7XB5hU1kF6QiADrDVIAXxABmb39blrS2ASc+VeJOMl3DiPgZQA2wvD
 wfduNYJd0qeVOqKgrkMuM94+pp5sboCFkfjmZfjqlRDDv5uK+c80Wuw7lPEW11h45Y8D
 yrkw==
X-Gm-Message-State: AOJu0YxlchcAKDZRnC+BzVNfzSkTYeFAQhrPExicQjRGubVw2ooMxFFY
 YduACvATEZ22Ipv+MtkPizBffTUxNYr3TC9asFH9sGVwaHbvTz4dcPoQLE5tQf4=
X-Google-Smtp-Source: AGHT+IGqoZ2KoJ0llyGtrIF/j+5an1dSz+E3z44JvLtGfT34CAVAD69uFsrI7qO1ZuArEdWqlQUyVg==
X-Received: by 2002:adf:f40d:0:b0:343:878d:d691 with SMTP id
 g13-20020adff40d000000b00343878dd691mr604569wro.47.1712305320894; 
 Fri, 05 Apr 2024 01:22:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 j27-20020adfb31b000000b00341d84f641asm1452326wrd.8.2024.04.05.01.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:22:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:21:55 +0200
Subject: [PATCH 3/4] spmi: msm: handle peripheral ownership
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-spmi-fixes-v1-3-031a9e5efab4@linaro.org>
References: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dzmitry Sankouski <dsankouski@gmail.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4513;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mM6+B/F0qZuOIU4XA5qgwXI4s/DfVycw26pJr7R+bMI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7SkzZMSrNj1G2jeUU0ZFxzpqu26sx7LaICTC9Ll
 T2NaHnGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+0pAAKCRB33NvayMhJ0XIWD/
 9q8RtSkI+OJF/67VuMZaXKfgjgNimNEypSCd4soZmPi3W/nd9y8XFXNHIyyASKj16rPLLT9ocSatZ5
 3qTSOFslYWks16LMxDb5Jb3iNJC3EaZJJbQEIw/ELegi9+hyG19zEBgs9SAnWOIx7N8MFapOP89eCZ
 rH0sBz3RBgtNX7ZH8RzKEEtG6yZK3GXSGv+EJ/558GcMtWo/Xeh+PyB7p93A/lgUlQ/qaHjNVVAHCR
 2V1jduXjJGVNVJZqU/reinR0EaMhE1xIman2JKrMQtPlggHelg9klykIIlfYrWDL2CHIqxeiZCVHkP
 QRt4l4qDBOa8dNUfD/WkIruVY+2Ph+aq6Je/nPZVgTrlIE5vLVAJxXgfjaeGnwSXgdDaTsUgVAa9Wt
 2isYWUBb/imTRkHN5IVkDLofLaIgtG8ij6dQce7fLp0hIX+R20QuVZGlkAqlQv5r5Bjq8NEvSvlXYd
 zeDNPDjYJ1XZKxgy+DfIizAevbuQ8fCCEmR/FPVrGK8geJYJRmqZMJmWFcpyUAW7/YHRNKTjGthJW7
 RmcaJcZgmKd+041CLkG0wd5Riv/8Zkrj4I3zYugt3E8hA9pkYc/Qlx0KlF7lRGbbI0Tz8zk7gjvZJQ
 on4sBPr5DOa834WRsgFHnPFDJPPZO38PJVsSrEICEYa6DzBUWK7/m44F/OBw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The cnfg registers provides the owner id for each peripheral,
so we can use this id to check if we're allowed to write register
to each peripherals.

Since the v5 can handle more peripherals, add the max_channels to
scan more starting from version 5, make the channel_map store
32bit values and introduce the SPMI_CHANNEL_READ_ONLY flag to
mark a peripheral as read-only.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/spmi/spmi-msm.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 68bb8a38c3c..46e2e09dc26 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -31,6 +31,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SPMI_V5_OBS_CH_OFFSET(chnl) ((chnl) * 0x80)
 #define SPMI_V5_RW_CH_OFFSET(chnl) ((chnl) * 0x10000)
 
+#define SPMI_OWNERSHIP_PERIPH2OWNER(x)	((x) & 0x7)
+
 #define SPMI_REG_CMD0 0x0
 #define SPMI_REG_CONFIG 0x4
 #define SPMI_REG_STATUS 0x8
@@ -49,9 +51,13 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SPMI_STATUS_DONE 0x1
 
 #define SPMI_MAX_CHANNELS 128
+#define SPMI_MAX_CHANNELS_V5	512
 #define SPMI_MAX_SLAVES 16
 #define SPMI_MAX_PERIPH 256
 
+#define SPMI_CHANNEL_READ_ONLY	BIT(31)
+#define SPMI_CHANNEL_MASK	0xffff
+
 enum arb_ver {
 	V1 = 1,
 	V2,
@@ -72,8 +78,11 @@ struct msm_spmi_priv {
 	phys_addr_t arb_chnl;  /* ARB channel mapping base */
 	phys_addr_t spmi_chnls; /* SPMI channels */
 	phys_addr_t spmi_obs;  /* SPMI observer */
+	phys_addr_t spmi_cnfg;  /* SPMI config */
+	u32 owner;	/* Current owner */
+	unsigned int max_channels; /* Max channels */
 	/* SPMI channel map */
-	uint8_t channel_map[SPMI_MAX_SLAVES][SPMI_MAX_PERIPH];
+	uint32_t channel_map[SPMI_MAX_SLAVES][SPMI_MAX_PERIPH];
 	/* SPMI bus arbiter version */
 	u32 arb_ver;
 };
@@ -100,8 +109,10 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 		return -EIO;
 	if (pid >= SPMI_MAX_PERIPH)
 		return -EIO;
+	if (priv->channel_map[usid][pid] & SPMI_CHANNEL_READ_ONLY)
+		return -EPERM;
 
-	channel = priv->channel_map[usid][pid];
+	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
 
 	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
 
@@ -162,7 +173,7 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
 	if (pid >= SPMI_MAX_PERIPH)
 		return -EIO;
 
-	channel = priv->channel_map[usid][pid];
+	channel = priv->channel_map[usid][pid] & SPMI_CHANNEL_MASK;
 
 	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
 
@@ -227,18 +238,23 @@ static int msm_spmi_probe(struct udevice *dev)
 	core_addr = dev_read_addr_name(dev, "core");
 	priv->spmi_chnls = dev_read_addr_name(dev, "chnls");
 	priv->spmi_obs = dev_read_addr_name(dev, "obsrvr");
+	dev_read_u32(dev, "qcom,ee", &priv->owner);
 
 	hw_ver = readl(core_addr + PMIC_ARB_VERSION);
 
 	if (hw_ver < PMIC_ARB_VERSION_V3_MIN) {
 		priv->arb_ver = V2;
 		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
+		priv->max_channels = SPMI_MAX_CHANNELS;
 	} else if (hw_ver < PMIC_ARB_VERSION_V5_MIN) {
 		priv->arb_ver = V3;
 		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
+		priv->max_channels = SPMI_MAX_CHANNELS;
 	} else {
 		priv->arb_ver = V5;
 		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V5;
+		priv->max_channels = SPMI_MAX_CHANNELS_V5;
+		priv->spmi_cnfg = dev_read_addr_name(dev, "cnfg");
 	}
 
 	dev_dbg(dev, "PMIC Arb Version-%d (%#x)\n", hw_ver >> 28, hw_ver);
@@ -252,12 +268,21 @@ static int msm_spmi_probe(struct udevice *dev)
 	dev_dbg(dev, "priv->spmi_chnls address (%#08llx)\n", priv->spmi_chnls);
 	dev_dbg(dev, "priv->spmi_obs address (%#08llx)\n", priv->spmi_obs);
 	/* Scan peripherals connected to each SPMI channel */
-	for (i = 0; i < SPMI_MAX_PERIPH; i++) {
+	for (i = 0; i < priv->max_channels; i++) {
 		uint32_t periph = readl(priv->arb_chnl + ARB_CHANNEL_OFFSET(i));
 		uint8_t slave_id = (periph & 0xf0000) >> 16;
 		uint8_t pid = (periph & 0xff00) >> 8;
 
 		priv->channel_map[slave_id][pid] = i;
+
+		/* Mark channels read-only when from different owner */
+		if (priv->arb_ver == V5) {
+			uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
+			uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
+
+			if (owner != priv->owner)
+				priv->channel_map[slave_id][pid] |= SPMI_CHANNEL_READ_ONLY;
+		}
 	}
 	return 0;
 }

-- 
2.34.1

