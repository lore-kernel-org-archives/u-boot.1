Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C84C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 117D687942;
	Tue,  2 Jan 2024 23:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m54YuL84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C908756F; Tue,  2 Jan 2024 23:13:03 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D45587962
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bbd1fab171so3221005b6e.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233579; x=1704838379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/e4JzivTISCCsPSFsQFEYIBzORuKqi+Hfw3LYucieE=;
 b=m54YuL84InJCeOsQSk/Pk5wdldPeYDxGy+I3OQ9m6yz0VepN4/6xzoedvtT1H5uCGD
 z0chwK4CxUFG/rAg3jZbcAenAtu64Rcmocrbz7dlKfc90a301FK9XbJ/yCJNY3UFbQ8K
 O8gewHklRi3qoZ7sZygFCCe2hF8LMHLyC68N85ZSdA1n5qEamGPSGqxaXGH37RdzBD4U
 7ZNH4QoFiT2YWwSPJvrF+2ZYNa2QDS4rZc7ARJO32zkFfDaNmfhxNd4pN6608DWrnC+9
 OZ+T7PfGuAtXl1tb2Sqd+BJXGl4kreSXJDZN6zcEkttGNTsZs8NbZw5nlZu7kkNL660P
 1ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233579; x=1704838379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/e4JzivTISCCsPSFsQFEYIBzORuKqi+Hfw3LYucieE=;
 b=Bqd2iT3dfKe0gJWZrFDnji0K3BUHBmorFgfeHRLbij1opZSz08MQlXa11Mp2hLcSV1
 tqyDdIkhxrq9tCahSjlOuJBsvyqO70/Z0TCmX8Jq8MSfbPpcUDrWam4Z7ZBkoSwWx38F
 1yz6xjbnU6lMoJU7qUXSvWsPr7P/T7+fF4WIYXpChAn3NauKxA1KOmn3k6R3oD3/zgwK
 235nOgKidcWuivic8AXysHw7fiH5g0NGXwPZs8BHzax8KtzPFFXP2d1fh8siSBk/m+5W
 Om2ZHXfV3IsK9LB/OqRNPSnvP/zcsYhOq2RN9h39VwzW0US97RBT2Bud6/gY8Ye/wB1K
 auxA==
X-Gm-Message-State: AOJu0YyJSQR+0GBtlBZ90p9CDIWwkxjOZnnjC9nmpnaaaHHMRwApyNyS
 8e5KoYE79FtgN0QD40CW+lOrqFezlAeBG9fYWf5/cHlRujI=
X-Google-Smtp-Source: AGHT+IFu6LrIoxSyPtc72pealiiQoBvSm/KusoTwlfyk7gU+Jeqx8qxERnhylXmPvtOlvca2aF+6+Q==
X-Received: by 2002:a05:6808:1410:b0:3b9:e779:8a0e with SMTP id
 w16-20020a056808141000b003b9e7798a0emr16393138oiv.1.1704233578785; 
 Tue, 02 Jan 2024 14:12:58 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:12:58 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v4 1/9] bloblist: add API to check the register conventions
Date: Tue,  2 Jan 2024 14:12:26 -0800
Message-Id: <20240102221237.1007090-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102221237.1007090-1-raymond.mao@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
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

Add bloblist_check_reg_conv() to check whether the bloblist is compliant
to the register conventions defined in Firmware Handoff specification.
This API can be used for all Arm platforms.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Refactor of bloblist_check_reg_conv().
Changes in v3
- bloblist_check_reg_conv() returns -ENOENT if OF_BOARD is disabled.
Changes in v4
- Add checking of signature register.

 common/bloblist.c  | 14 ++++++++++++++
 include/bloblist.h | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 9daf0d2b13..acf67304d0 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -542,3 +542,17 @@ int bloblist_maybe_init(void)
 
 	return 0;
 }
+
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
+{
+	if (!IS_ENABLED(CONFIG_OF_BOARD))
+		return -ENOENT;
+
+	if (rzero || rsig != (BLOBLIST_MAGIC | BLOBLIST_REGCONV_VER) ||
+	    rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
+		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/include/bloblist.h b/include/bloblist.h
index 84fc943819..bf9e12ebf8 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -78,6 +78,13 @@ enum {
 	BLOBLIST_VERSION	= 1,
 	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
+	/*
+	 * FIXME:
+	 * Register convention version should be placed into a higher byte
+	 * https://github.com/FirmwareHandoff/firmware_handoff/issues/32
+	 */
+	BLOBLIST_REGCONV_VER	= 1 << 24,
+
 	BLOBLIST_BLOB_ALIGN_LOG2 = 3,
 	BLOBLIST_BLOB_ALIGN	 = 1 << BLOBLIST_BLOB_ALIGN_LOG2,
 
@@ -461,4 +468,17 @@ static inline int bloblist_maybe_init(void)
 }
 #endif /* BLOBLIST */
 
+/**
+ * bloblist_check_reg_conv() - Check whether the bloblist is compliant to
+ *			       the register conventions according to the
+ *			       Firmware Handoff spec.
+ *
+ * @rfdt:  Register that holds the FDT base address.
+ * @rzero: Register that must be zero.
+ * @rsig:  Register that holds signature and register conventions version.
+ * Return: 0 if OK, -EIO if the bloblist is not compliant to the register
+ *	   conventions, -ENOENT if OF_BOARD is disabled.
+ */
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
+
 #endif /* __BLOBLIST_H */
-- 
2.25.1

