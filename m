Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FC7C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C305287CC1;
	Fri, 19 Jan 2024 16:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z2UJ/zTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E2187CDD; Fri, 19 Jan 2024 16:12:10 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51C4387AEC
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-682bfd39ac5so3489926d6.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677126; x=1706281926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KebDo8TeWIxSF2S0h4D1Oq0QWFRjBhCj6m9Tj1VWLyg=;
 b=Z2UJ/zTiy5Etmj/ILPinqLoIsAza0ALpM56NGLsOpZmlqKszRDcrMBbN/RoCkD/maT
 EzLbt/NqxCKAApJxkE9X2ja29oBksU1NUgw31SX+XIgL9NgYHLUKLmvlHSnEgQDV9Pu/
 xZlIhOs8x13/IuOrS9GluJj/WCrs0ZaXxrGG4V9v7BEIWVFF7tFe3q4P36Gkc5NV93rp
 10k1cuHMT2OOspKPVC28xGCCOgSYcwYfVpw8b3rt7HvlMQpAhHy5psI/YEZCFhXLVZOF
 oxaGs34oXynt3WH983xiO6HZdrq5RVKMc4ta84mcqlE85u9Urxk5cfToh4oyXYJLqZPa
 mLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677126; x=1706281926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KebDo8TeWIxSF2S0h4D1Oq0QWFRjBhCj6m9Tj1VWLyg=;
 b=uvhfc92aY9XoI/YBkdua3TTSDHZ8tRnztaJ/+ASNTvt6wWoMk8JPoH/d96Hp77ixLd
 2aaZTszgy9XJnrkfr5ynCx9R2r/UEACnHmhsUi9wGRTTO9SqU7evzbFCY8hqdq//TpLA
 2aaIZNgZXno4/IT5Ef+/Vpyqq29hJy9HtkwGt0WyGICceDNtkd6+56+B0cqcN6pP6khi
 6qioaMSfridORWpO6m5fiWaAtdD7qwvYrfGq+OErzmEDvtqFhlP1WTpqwsrk1pZhvtl1
 vhUvDYEk+XPJRIV4TSIrt5Ri/iNoMrY50Dz7s48e6M5gMiTalq0Qg5P6mP1za1B/C+GQ
 bnog==
X-Gm-Message-State: AOJu0YxFwk9b1CJ3BbSKo4DF6svfbShKcKMc4yEVOcFbvGsUewCiLeXj
 H36JvgBHGfzq9UefzqlcPtK7Y3fnGmE2ALOm2gWNJ3+2JJMUQ5oFogFHsiRDPIqElhLOAU3rJMC
 q
X-Google-Smtp-Source: AGHT+IHL6W2/lW6FeA93a08fkITFgm2M21xnunwnFISgF1ZU7YnS07+jT4Vm5H901xwTev3ahf2qfw==
X-Received: by 2002:a05:6214:5297:b0:681:5e14:339a with SMTP id
 kj23-20020a056214529700b006815e14339amr43243qvb.19.1705677126759; 
 Fri, 19 Jan 2024 07:12:06 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:12:06 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v7 1/8] bloblist: add API to check the register conventions
Date: Fri, 19 Jan 2024 07:09:57 -0800
Message-Id: <20240119151007.715348-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119151007.715348-1-raymond.mao@linaro.org>
References: <20240119151007.715348-1-raymond.mao@linaro.org>
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

