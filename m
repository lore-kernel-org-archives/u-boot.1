Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5BDC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528D08785F;
	Fri, 12 Jan 2024 22:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ISYdzO96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E3F8787E; Fri, 12 Jan 2024 22:34:04 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1248A879A3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7831389c7daso557026385a.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095240; x=1705700040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KebDo8TeWIxSF2S0h4D1Oq0QWFRjBhCj6m9Tj1VWLyg=;
 b=ISYdzO96Cc3MtzCl0X0IBp8GqRWcynWOVvzz7m3A546PmZYY448ye87Xp2Hl0y6u0S
 QCbVa9ygRRvNngph7GsHn7tfKwsua1uLmrP9t8pDzltdeqVIYPEn2afos4ohLv6gfeQ/
 hgbH2K+HAa4BksJEPjtg6XHKGGaRYvQJsGy1S1Slx5nGRfrfMMfqRHVW4ZBCArDN5ILV
 TNKguf5RSnnzTZTFVH3oHRrJcpZQ4PbjsYESxHjsSA6juUmCodQUIDBe+evATTN/7mDv
 ZetJDSBk0qz50YIGXJ6rBsiv80P5akhtHr2b3jkr3Jy4qZSZGvKwz4DfLKRw5CGAKPbo
 sNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095240; x=1705700040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KebDo8TeWIxSF2S0h4D1Oq0QWFRjBhCj6m9Tj1VWLyg=;
 b=aEgGi3b1rnR/90e/y11nmEs30yw0xIiVt5czbwuqkqk7vklAmbW5ru6FKCCbN4GCJs
 ya+2YlyjTiYXA72PZ7jt6+MG4FcFal2F5ASyVnv+lI6XRHnJgy5SwaTNUe26cfMOj2l/
 95ZRu3xCCcxrRYRzd6npThagrzBFji81q10w3tjKuPcD2DzEpGACvZGbpBTDdGAPmFqX
 6GuAnPuSHvsy7tlAweoUjjT6EdRuQdEUQbXnZiTrXhXMWUqGVxokWmYRT1Dr5hJzhKhX
 UUcbD5V+yNU0YhJVzuT+bn2d+YOrA0bgk2uaY4FdRnmRTu58TnxxircuJ6c0E2W0wKPk
 0azw==
X-Gm-Message-State: AOJu0YxsxPpKHxuUfL5Apwo6Ix7d/CYTj2NLpGo0T6QDjZLCby/oBIeS
 d4BDbBxsL3SJLSZen+yzYoCFLW5MYYu2VyIPLgT2cAqlrF4=
X-Google-Smtp-Source: AGHT+IH7zGvtW6MJZDLIXKW7W28wj67npVfYcno5hV5A7RW4VNE/YanG+eqv1cSmyY43KUN8Aj5C9g==
X-Received: by 2002:a05:620a:385e:b0:781:56f9:c6c7 with SMTP id
 po30-20020a05620a385e00b0078156f9c6c7mr1938561qkn.103.1705095240475; 
 Fri, 12 Jan 2024 13:34:00 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 wa12-20020a05620a4d0c00b0078321f3e7c7sm1325321qkn.114.2024.01.12.13.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:34:00 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 1/8] bloblist: add API to check the register conventions
Date: Fri, 12 Jan 2024 13:33:27 -0800
Message-Id: <20240112213337.185460-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112213337.185460-1-raymond.mao@linaro.org>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
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

