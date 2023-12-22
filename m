Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AF8C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F9A87745;
	Fri, 22 Dec 2023 22:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M/jeVl9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF0F8777D; Fri, 22 Dec 2023 22:31:44 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B5C8753D
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67a338dfca7so13675756d6.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280700; x=1703885500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiuPnCJkIWirwDrimojMVsTF32M3M2sOimafB8HdgvU=;
 b=M/jeVl9e3Jnj9rAwC0yDic4kgc7R/dyecQI96jVS4YswWVeVqBQ2wjT9uCOsVTvg/L
 KULKOpjl9CmNJoPjzbHHkbDHuccZ18MVWdppJdinCOpE3SUNYgCIvP3ryAUbytr7Vi8w
 dxHS4hQjUU9QbsnqvjdeUC57ZZu7Q6HuYeDlZvEZvVoSE+WkS/G2rDdxwbzB5T6rDHU1
 EK2E+JuLG1xX1QKCX10IMmq7XHRyUW0GINccAbbXgPIVlsT7EB0M1DibcTxWydZdJtvz
 Y3cvtbtJ8wh/3Ym2FiNZ0CeAUiaLBSAPIP9EYo4Go+fPbStOLo0wAkYKYwYVI5/7H4po
 5KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280700; x=1703885500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiuPnCJkIWirwDrimojMVsTF32M3M2sOimafB8HdgvU=;
 b=GPl5gJlji+DkOmYG8NdY6BAFOmFHjqgTE8fFna1JkA05V6yhi5IGTst+1JLQFBqls7
 VrjkZqwHyfRDXmLsR1EWezlAb3fvaAbnTsVSbpIQpaOa4MX/ON0h9EuvVQpQtR9ER9Xh
 tGi+zgze5+K5obFeGBBofVzrcoxXh31sfCQF/1NBtNdtwVOXu1YBezVAkeeOY+IoL96p
 yaN0qqltgRJqIMgR4Ykxt1bidGnOsR0hj00rk3qpA3cSBxqmbAFH/bRXR7lwiJPm8WiH
 ufUJpraIVbp31J/cgk8DH2a1APYbVMleKTWrTfojH4gkLdHKzsWL/UUN1/8exHrPHUs6
 HyhA==
X-Gm-Message-State: AOJu0Yy6U2Jcirv/e8nucN+7IExdzpf4cHh2ZdLNUDvLqh45bJuohZ63
 kmYMSSOQiX7NupKqQHc4S/DCRR6sGlTj0qreLDmWmP33cGw=
X-Google-Smtp-Source: AGHT+IFKZa0laLB4Q+EfdssPJy6Hnc+Bk2iJmn4bK8iU7616WABtcz0yr2zGWLkWZWGiug8Pf1JhWw==
X-Received: by 2002:a05:6214:ac9:b0:67f:2632:9992 with SMTP id
 g9-20020a0562140ac900b0067f26329992mr3194499qvi.38.1703280699815; 
 Fri, 22 Dec 2023 13:31:39 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:31:39 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 1/9] bloblist: add API to check the register conventions
Date: Fri, 22 Dec 2023 13:31:01 -0800
Message-Id: <20231222213110.660402-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222213110.660402-1-raymond.mao@linaro.org>
References: <20231222213110.660402-1-raymond.mao@linaro.org>
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

 common/bloblist.c  | 13 +++++++++++++
 include/bloblist.h | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 625e480f6b..ba17dd851a 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -542,3 +542,16 @@ int bloblist_maybe_init(void)
 
 	return 0;
 }
+
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
+{
+	if (!IS_ENABLED(CONFIG_OF_BOARD))
+		return -ENOENT;
+
+	if (rzero || rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
+		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/include/bloblist.h b/include/bloblist.h
index 84fc943819..bd32e38a06 100644
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
+ *	   conventions, -ENOENT if OF_BOARD is disabled.
+ */
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero);
+
 #endif /* __BLOBLIST_H */
-- 
2.25.1

