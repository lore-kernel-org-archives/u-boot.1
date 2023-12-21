Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F84C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3318763E;
	Thu, 21 Dec 2023 01:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JlWRcivL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE66875C5; Thu, 21 Dec 2023 01:40:57 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B0C687850
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4257ba1bc5fso1678471cf.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119252; x=1703724052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjwdM4NoZWIXdG65Q7CKZ3WgB8haXQ8NoXS/P+XFpEQ=;
 b=JlWRcivLCwsXZOJtuOOYIRIvaA4eOctjkGT52iW5qgQ24gfXFvOmQRNkFTHYFkC1zk
 ksZzXWnQZVTZjHUqsR8FtolpMM5+rc25YfIYGQY70sKzi+9GpQtTOao0JIwaYaqarIxU
 6sYZOLvAUfQOHeUurPATnmCRBNBgZivn/du5Pb8rWbhJIINjy0debsQHaR/AhsI1w7g9
 YV5yjMSyy5xWxT5rJM5ANR/LNsewz9Nw43BlZshDr7UVVJbaymD8stkai/EIGkmkXcPR
 gdZOPx+dMUxq/e5L54CTx3KJ51G2zvObdEMyr1sq/UbabnrGvli9m6H0ILzF46Q3wrb7
 KFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119252; x=1703724052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QjwdM4NoZWIXdG65Q7CKZ3WgB8haXQ8NoXS/P+XFpEQ=;
 b=TMB+MbaaV4ucujTeDKLGG0BNVy+ZFyvfvViDHMdAF1jeBzxJps71cS2F73DxRhSCNm
 z2H/rssarDX06Qu6K9O38sGqUOLXg/V8ZOAZy9NkO2ex4c9PI/d1sCL1wn/c7pvTL93P
 eX4T6vHYVyKx0i6eVPC6mKKgehESBFU2MNnOb3mAlakUm13/cKKJKElte7vPkACLC34m
 7Q4qoZV5EqXYds0GqNRTposH/Q8DUQ0w+RPQaXvOWit3/aOdE8VOlA1hRK9N1fIvWj8V
 mnITZ5GvHsKIy5w//o1AdV/xof8D/6FWyoCE69iAD5fk9bjgKPtLP5QRIzaCYrP7CmYW
 SRbw==
X-Gm-Message-State: AOJu0YxxLji9uHq38+hyO55giN/b4R78yOXCxs64PLaoVhwpcymv8q7o
 a3cmTBN5kNZiqt38qR2yh5j+53PIAGl7VfCqux4=
X-Google-Smtp-Source: AGHT+IEYtA627J4zS+4r+BK5+aXA5oiLlf0pF9w+LOATVXTLATLDOkXrI5rxLfhaO/TOrZ5cDU1FkQ==
X-Received: by 2002:ac8:7f0e:0:b0:425:4043:96f1 with SMTP id
 f14-20020ac87f0e000000b00425404396f1mr29339977qtk.126.1703119251855; 
 Wed, 20 Dec 2023 16:40:51 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:40:51 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 1/9] bloblist: add API to check the register conventions
Date: Wed, 20 Dec 2023 16:40:20 -0800
Message-Id: <20231221004030.581388-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221004030.581388-1-raymond.mao@linaro.org>
References: <20231221004030.581388-1-raymond.mao@linaro.org>
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

 common/bloblist.c  | 13 +++++++++++++
 include/bloblist.h | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 625e480f6b..193122a8af 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -542,3 +542,16 @@ int bloblist_maybe_init(void)
 
 	return 0;
 }
+
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
+{
+	if (!IS_ENABLED(CONFIG_OF_BOARD))
+		return 0;
+
+	if (rzero || rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
+		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/include/bloblist.h b/include/bloblist.h
index 84fc943819..b5d0f147f6 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -461,4 +461,16 @@ static inline int bloblist_maybe_init(void)
 }
 #endif /* BLOBLIST */
 
+/**
+ * bloblist_check_reg_conv() - Check whether the bloblist is compliant to
+ *			       the register conventions according to the
+ *			       Firmware Handoff spec.
+ *
+ * @rfdt:  Register that holds the FDT base address.
+ * @rzero: Register that must be zero.
+ * Return: 0 if OK, -EIO if the bloblist is not compliant to the register
+ *	   conventions.
+ */
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero);
+
 #endif /* __BLOBLIST_H */
-- 
2.25.1

