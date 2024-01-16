Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D474C47DA7
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A88E8879F8;
	Tue, 16 Jan 2024 18:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kSOYl11Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DBC186F67; Tue, 16 Jan 2024 18:14:17 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5EF87A0B
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-429be992974so29222971cf.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705425252; x=1706030052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KebDo8TeWIxSF2S0h4D1Oq0QWFRjBhCj6m9Tj1VWLyg=;
 b=kSOYl11Z4sPULva+2bonSpABUtGTtNhLuxzdMvGLES4vZVULpyqHJrICaRWK0qA6yD
 BBaosD1UyJx4fAHiWQ7DwmOQ7E/17lIwa5AgTcpQKt3d0B5N6Tx41ZCau66Fe8GFxcBv
 yzqBNGxV4mPG9b15QTAcXNnL7drylJ9BGYWhzNgbIGu3MY471DuyhdHoKNQ4D2VFR9WT
 /lrj9Ybk8VC1xWf1Mwsj0CtY+usMlR4Y6YOZ0CrV+CJ84Nj9zMj1h/pMMW7Zyi6DGc9l
 2K/1SKtAV5hwf4jM7D3A2Wl6/xg6dCa0Q0j7QkUhlaPgUEd9aI8M8F1WYYHoE45kDey0
 5jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425252; x=1706030052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KebDo8TeWIxSF2S0h4D1Oq0QWFRjBhCj6m9Tj1VWLyg=;
 b=AnqI57g2UOQ+dC77mCETAsyP5ABN+EESjsDQPe5URD0ZqvZwukjZn9rjyMJKOGLjsW
 lW4LfyQZPrbmiiut3SFeKaA09A9INSqs2AcRg7TOBd7msztT+U6IIw7f+2o4qaL15zzp
 UmOkI1jJVM9zFikbFIZZox79yKS/69SvMBZj186siTVnSewXLCIcuWr4NBTP3O53En2S
 Yedh86nlD6++tV5ZHiyojAlIRpE2UwDE90ef3dh11mDt/YzuxsGW0tWZAsTGUGjpSbE3
 9bbcd+KCN24b5nJoRrzLyYKkFWE4Zs2sy8jN5eVnzmbVELP4iRd0WrPBg7HU0uwFcxlZ
 Ty5w==
X-Gm-Message-State: AOJu0YzhxE6hcgD7QrynllYHbmtVlKMw7lB0kVySszPbawrk+ERoI9JS
 JKEiThzQalK8B3l8ppjjZqsAxCAfCSpziRCoNCop8WhA0b8=
X-Google-Smtp-Source: AGHT+IFA2tGsFOR4UD7yWx7/wqdQf2SJjWhxFuF5g8NcUYvXZPm6O2awOSo7ChijHFm8OltvYBuzjg==
X-Received: by 2002:a05:622a:3c6:b0:42a:9ce:ae76 with SMTP id
 k6-20020a05622a03c600b0042a09ceae76mr654176qtx.87.1705425251921; 
 Tue, 16 Jan 2024 09:14:11 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 bp43-20020a05622a1bab00b00427e0e9c22dsm4988291qtb.54.2024.01.16.09.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:14:11 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andrew Davis <afd@ti.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Devarsh Thakkar <devarsht@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v6 1/7] bloblist: add API to check the register conventions
Date: Tue, 16 Jan 2024 09:13:46 -0800
Message-Id: <20240116171356.376801-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116171356.376801-1-raymond.mao@linaro.org>
References: <20240116171356.376801-1-raymond.mao@linaro.org>
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
Changes in V5
- Drop the dependence on OF_BOARD.

 common/bloblist.c  | 11 +++++++++++
 include/bloblist.h | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2d373910b6..980b1ddbcb 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -542,3 +542,14 @@ int bloblist_maybe_init(void)
 
 	return 0;
 }
+
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
+{
+	if (rzero || rsig != (BLOBLIST_MAGIC | BLOBLIST_REGCONV_VER) ||
+	    rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
+		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/include/bloblist.h b/include/bloblist.h
index 84fc943819..f7e800f681 100644
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
+ *	   conventions.
+ */
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
+
 #endif /* __BLOBLIST_H */
-- 
2.25.1

