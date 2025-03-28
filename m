Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594F7C36010
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2529381EC0;
	Fri, 28 Mar 2025 09:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hfcm61vh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C74A81E6C; Fri, 28 Mar 2025 09:53:28 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7970681DCC
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1343408f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743152006; x=1743756806; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FFstgTTdCanMvRex2reMXEoj65g7avceFpD5gCwBsCU=;
 b=hfcm61vhNZwhyvsQatQ75DlvjRxO0npkkW244E89k7bIPEhkqBDbxkmazZTj/5qCDY
 c+NTWQhSo1cojcFFgjlJZfPz4PQBRW9DB/Vp9G+hqkE6W8R+Th4Qfo5lYGeGrZNZQgVG
 5j3C14sb1Vv709lJ+LDRctING9YRk/TlbZtXaqM++S4Df8QWjENMpDy+eBOgsRrxSHdC
 TxqA4jJlCvuGvA5EdiOZLFATavUD5gNAUZl/JTe3Qdc4OEFdTYZlSb46i9ZY3FrEuSxX
 e0KXTffE0MKiyLZ0Tv3ZGU0hVLQ2Z47wNOfFCvSm44pPRJmOWdBMS+mswc74UdYxeKVW
 Ltpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743152006; x=1743756806;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFstgTTdCanMvRex2reMXEoj65g7avceFpD5gCwBsCU=;
 b=dYOQCuxivHpnohfqpSYEcQrI52M50DcRlMIeOMGq9nUUEbIpAFm41cKZy2gumWb+DE
 LprkbvNRYhMMhhX3WoSiL83vnkZ8CHZ/RKjSC5rB2/nD/efF5AlChSb+GGC1VMOThIj/
 SzZoeVWgyRCmgBuxXpW5kMpv5Guj6DyB9YAiE1iOTgkPm0Wbshy+NpAsvN5+zmbXowkl
 OArnOWAkc5bdpxPxhoHZWrxFK6Ah/XTyngpnzGUl7bKY2HveFgGeiq+9RK8oyysi0U5r
 cMY1wsrpi1X3js6TDRnA8CeyW/3iQ5D2tUFLsoPl49jTFd8iejyjBbL1b45Wqcle6cdQ
 7G8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX6x4gXu41Jd5YY9+cOK5zFksW48bBP/+ZrYKlwHpxgmjBqnf6DLl8Oh15g+iDRs+4VYE0H0M=@lists.denx.de
X-Gm-Message-State: AOJu0YwM4cRy82d4sE6ZQaYplta10APuRvSgZX9SIh6iw4wojiNdqZW3
 OReQfrqIkNSPT+JTOiA8qvKtYP9RcB1qid8cNlXy6VB9FTS45zK5dlVGEDZoDbngZFlVNyE6H3b
 f
X-Gm-Gg: ASbGncsZDLG6Ui2iEK7Ft/8IN+qHP5kZRSZZ3wdI5higWMgfvF6H6Ot78rPRWfUYuHx
 qODrc+0GiF3tfBybQEEa92Ew8vNgFKnfIUvtJLypmZT1dJTUgkT3PeMO6hiBHWiKtZ2c3PquoLY
 R51X92oys8RLv+/OeXva1fjo/WzJ3O68we0Jg4EewsAswuBLaJF7SV6XN4Ig/1t6nGZBBg31/sH
 BDzueJQX9GRTwEazqNYgVPBoTFtPQXjzdRSS/soW4EZ8fPIMrOoSyxGXnUtB/1eaKN83MsjDw0N
 HWc6FUdf/xk3NQjtkXaJhL8UKDISHE0KfF2CWjEzcvk7N3K9t59G2KCXX674TTtcXw==
X-Google-Smtp-Source: AGHT+IFU5YKIP/QP6lW+v0YXer3582VOqalZbagb1N/SRl/ZIkKmAugOPHJVpSU8oRcGELHH3yXmmw==
X-Received: by 2002:a05:6000:2a1:b0:391:466f:314e with SMTP id
 ffacd0b85a97d-39ad1741a73mr6486803f8f.16.1743152005826; 
 Fri, 28 Mar 2025 01:53:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0basm1969794f8f.63.2025.03.28.01.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:53:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 28 Mar 2025 09:53:21 +0100
Subject: [PATCH 1/4] spmi: msm: use real number of channels for v5 & v7
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-topic-sm8x50-spmi-fix-v1-1-a7548d3aef0d@linaro.org>
References: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
In-Reply-To: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=A2IMOgIDnFbyt+w1PgFnhrRwDh2xDfwmeARDqd7Wo5g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn5mOChGHAYaTJxgUoXlTwcEQ+jpQ5n1hLJt9Twxnw
 vWBk/MyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+ZjggAKCRB33NvayMhJ0TZXEA
 CGkKXkafkdAtQmjSV1I07CmsFSZnhdIM513d2VLup6jx290aEU9FHMkalmPGbZaHn0c/XlFZQmtyZ+
 rcfn/g7HJX1Lili7C7zXX9IDRyeyB9SwXamYLDh/icpF3dHDm5G3/xgiOQu0CzutVa662YryoIHzFx
 7YRmlrrF6ZVEDXcqW0XZsI1oEInSxQox9Ng2Iwue04e0rPJVnNfjuPOCZz10gKPpnlBs013XfTXac8
 J+/iMbYD25hy+tm3KZwut/UmjAme+q6OpLFFjIgJxtef+08VrlQMhON+tbwxI1NUAwAEbjdkYa4WyU
 LtEXDGp338tL707eElw6973410R3WY+5i84yjbUeg87N0nJZ9O32vziEaEOuEaWDES7DNP/lgOaBTX
 ajt0e3MAu/PEqAnw0BDCgaLTnsX3YNMVdkOyRB9ArhLR1A0uUMABnduKHlLvSk8Zon0Pd0F9S8CIbg
 1ZeGp4NQ5bdI7yJoLOzpRfw3UM47RIaXZ958LbGm4KlGjsaRJ1ustNnbeGI35UQ+RI+3jvKQHLGXiq
 N/on23CCn1B2fcLJUP3egI51Sr4bFpgK8xsVqY0dd5NeeEd1UIrDJwHwsEXwbqVenY5FkO5OYEWhWb
 6uvgvSzZ9pBuwVk0f6AAzpjn/yXPR+L3t87WAg+sUxduZ5GTBT2RV47vYGfQ==
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

The SPMI_MAX_CHANNELS_Vx are only the maximum channels supported
by the controller, but the real number of channels mapped on this
system can be read from a register, so take this info.

This allows no to overlap on the second controller present on
the V7 SPMI arbiter, otherwise we would also parse the mapping
of the second SPMI bus and we would bet the wrong IDs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/spmi/spmi-msm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 5cc5a9e654c8371d71386384654e9429ed96b05f..08be4517df189f320302e97334a371d370b36440 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -24,6 +24,9 @@ DECLARE_GLOBAL_DATA_PTR;
 #define PMIC_ARB_VERSION_V5_MIN 0x50000000
 #define PMIC_ARB_VERSION_V7_MIN	0x70000000
 
+#define PMIC_ARB_FEATURES		0x0004
+#define PMIC_ARB_FEATURES_PERIPH_MASK	GENMASK(10, 0)
+
 #define APID_MAP_OFFSET_V1_V2_V3 (0x800)
 #define APID_MAP_OFFSET_V5 (0x900)
 #define APID_MAP_OFFSET_V7 (0x2000)
@@ -271,13 +274,17 @@ static int msm_spmi_probe(struct udevice *dev)
 	} else if (hw_ver < PMIC_ARB_VERSION_V7_MIN) {
 		priv->arb_ver = V5;
 		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V5;
-		priv->max_channels = SPMI_MAX_CHANNELS_V5;
+		priv->max_channels = min_t(u32, readl(core_addr + PMIC_ARB_FEATURES) &
+						PMIC_ARB_FEATURES_PERIPH_MASK,
+					   SPMI_MAX_CHANNELS_V5);
 		priv->spmi_cnfg = dev_read_addr_name(dev, "cnfg");
 	} else {
 		/* TOFIX: handle second bus */
 		priv->arb_ver = V7;
 		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V7;
-		priv->max_channels = SPMI_MAX_CHANNELS_V7;
+		priv->max_channels = min_t(u32, readl(core_addr + PMIC_ARB_FEATURES) &
+						PMIC_ARB_FEATURES_PERIPH_MASK,
+					   SPMI_MAX_CHANNELS_V7);
 		priv->spmi_cnfg = dev_read_addr_name(dev, "cnfg");
 	}
 

-- 
2.34.1

