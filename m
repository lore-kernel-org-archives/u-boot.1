Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79414C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4A887897;
	Sat,  3 Feb 2024 17:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xWhCrECR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B62378798F; Sat,  3 Feb 2024 17:37:39 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D07C8767C
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-68c7a26a5cbso14895216d6.1
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978256; x=1707583056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KebDo8TeWIxSF2S0h4D1Oq0QWFRjBhCj6m9Tj1VWLyg=;
 b=xWhCrECRpuFKxSprnDwrab7MD5+avvhSSVMzrepl4xTAzBakYu54eZOLmOrg3vjeyA
 LN9v2644d7PyM0YyanpUckyejGu5RTpQaozIXykIcUU9eQZ0J2hjqnTowbPXyPJzV8uX
 UPpfK3ymRWT+xoDnuR3+thJfKUhtkVYAQMESl0/WYdPI6WJivNcKgakWm2gSe+gxKzWC
 OLlqDuxEBDfnKeVZ+TQzzq+6b0eLWhgtCG6k5Hl9y7rxBI6Ebmr+So/Cj9ec6fuOQb+T
 ISM6HaRDFgwjlamotJ6EK0Xm5cDXmO08BjZ348mb2qCAUcdMlzZyO7dFaW1dTIP5OyRF
 0vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978256; x=1707583056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KebDo8TeWIxSF2S0h4D1Oq0QWFRjBhCj6m9Tj1VWLyg=;
 b=tMCE28Kd6gv4GYWUiX9kwP0uTfDWiqcuL04RcSUcw5MlBD5b7pLcVQjUdNdBsTzF2b
 lTsM42lfpUXBODoc19sQQ5Th/NCFB7j1eUQFoAIUB3HGs1zHddAXjNdVJFyxBL67Xao+
 3GVM1YFBH7qFsUeIU5673DutQQi8tWSOSMOiiNDUawk/XYO9B0k9H3hVRBJXp4A5IS3W
 TLCaESabmk9eSIU5+9DA2shG/PpevBVhpbApXmZO9CJ3go/NhPyHB20A6Znh8F0D8scu
 3RZNCiIJaKQyLr5cQp+0ltIR2xTAZcpmz2+LTwDwziewX+ZRTOrXevNyhMA6086/2biS
 4qSA==
X-Gm-Message-State: AOJu0Yxff4yhjW6YdElspQIszZ8BOm6yxx4giOXN/1A2Q+FR2aRyk+eg
 WHXN2+lmr4DZyiEN+KZPoJMtC5CAZf235AhQ/KR3JIJ2lq1z86KvhrfTMwO2kWWXEmsL6MSsgBj
 J
X-Google-Smtp-Source: AGHT+IHUDyVL1py5D3KjVzZmgDqh9KotIn7Ss+VV00Ko7n4lvr5VP2FMI0i//DNDlKRDTakjrbmyZQ==
X-Received: by 2002:ad4:4e31:0:b0:68c:803d:7cb4 with SMTP id
 dm17-20020ad44e31000000b0068c803d7cb4mr2693281qvb.2.1706978255688; 
 Sat, 03 Feb 2024 08:37:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX8gVqu1Qk2OkNScXHHXgBx4El8Mwidha0pCmU4IZ3scMNkr8T3PU9PAwHdPaKV0Uju3cpR3IG6vr05TqCcQtJdxyVB47HGF3yAiOIlF/puy3Sms4wpijVnR+rZmYyYtPb2AaTmwA5+dcVpwGKTgz/c1g/K8fzU4uGDHH8CBp3g9aYl4zbTgu7mlS72vM8HiL1X29dWyxxOJ2x2rI6/nDCUXdpNUyoBwfNEpYg8MciBEnw8IunlcufhOM+lSVqC0IWR/UEXtIXspCrpJRjmu1m0mGsuON9kjYeP/TFjoe5TAxMdi0YqtS1jHChq4Ech9koSOG8gumLqZcROPNDLrjTQmMHFY5b7IDLd0ucx5dRPy8YgWctzbTu77fMtCNcGU67cbNWl58svujfe7VJA9/U0neu//k8mMiHvBIdxMeBlBf3LNGWzoZ+Kmg8J/y90lGnx8p+UyXu6rOdsc3LGww==
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:37:35 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 1/8] bloblist: add API to check the register conventions
Date: Sat,  3 Feb 2024 08:36:20 -0800
Message-Id: <20240203163631.177508-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240203163631.177508-1-raymond.mao@linaro.org>
References: <20240203163631.177508-1-raymond.mao@linaro.org>
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

