Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B17CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1973886BFC;
	Tue, 19 Sep 2023 20:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VdyDANoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404B286B7E; Tue, 19 Sep 2023 20:09:56 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3797586BE1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79329a8f78bso228389939f.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146993; x=1695751793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=br+gTWjreyxwUihvRfRNisrw3ValdGM8WF+1kSL5kpA=;
 b=VdyDANoGDbzdSFSkG6OrTX/kHvS8ChDFrvm0vpPEs5jIiWY5RnvwfKILgSCK3fV9lD
 qxhAAzrS8E8kvBk/qNwswNN2IZSL1WTMwyiwAIYCl7yHrl2dNegbp6V9I/QMVaLi3qds
 qsPxY23Q5lOLmEw+DWsIHBWuNx56lfajcgfvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146993; x=1695751793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=br+gTWjreyxwUihvRfRNisrw3ValdGM8WF+1kSL5kpA=;
 b=L5MdpUS7GvuzXItcVdb/jigm+fdbU227yTiAkHxxHfGs4YUg9lecXD13kmj+ecrluL
 I6ptH9TC8MIXAMWwPDwKvJ1lKW7JyfZk73T4bdeDSqR/4WvJm2Vy3zOt11HPZM3uoKRA
 kA9tAKp0dc3TrgjEqEaOcbAftTBwB4HKyoR4MGM5Zhx3nu+qdYAD6m3kNtFaDsO3W3e3
 DFMrERaFT+KCrS3iCSuw6GQvGLD3FLFgNs/WG6j9lh4wsTmkXacOQheegp3h40cSWtz1
 YyPiXBm2AFdqCN8Qq+95A1K+wxs4yPnC49HLS1tfcnKLTTvcKKyhc0s89+YFcKPPgMaI
 nEFQ==
X-Gm-Message-State: AOJu0Yznk0oxymkSYFeC2dGE9Ob07ET/JK9KD6LOn1zmOpvaNteK66DS
 6hELlIEw60azY7EFL52gA9zOwym7+FTUXPDei1Q=
X-Google-Smtp-Source: AGHT+IHwxIh3XOFhJ7rXO3O0So3C5Q0EK7gipHu2xhiT7tVUoz2oLbSCPHPasLtrKSnnxd7QKeKDLg==
X-Received: by 2002:a05:6e02:b24:b0:349:2cd0:4368 with SMTP id
 e4-20020a056e020b2400b003492cd04368mr680234ilu.18.1695146992898; 
 Tue, 19 Sep 2023 11:09:52 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 32/36] expo: Support handling any key in cedit
Date: Tue, 19 Sep 2023 12:09:02 -0600
Message-ID: <20230919180918.2904313-33-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

At present cedit only supports menu keys. For textline objects we need
to insert normal ASCII characters.

We also need to handle backspace, which is ASCII 9.

In fact, expo does not make use of all the menu keys, so partition
them accordingly and update the logic to support normal ASCII
characters, too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c   | 2 +-
 include/menu.h | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index bb194af77bd..407793aaddd 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -176,7 +176,7 @@ int cedit_run(struct expo *exp)
 		key = 0;
 		if (ichar) {
 			key = bootmenu_conv_key(ichar);
-			if (key == BKEY_NONE)
+			if (key == BKEY_NONE || key >= BKEY_FIRST_EXTRA)
 				key = ichar;
 		}
 		if (!key)
diff --git a/include/menu.h b/include/menu.h
index 64ce89b7d26..6571c39b143 100644
--- a/include/menu.h
+++ b/include/menu.h
@@ -50,12 +50,17 @@ enum bootmenu_key {
 	BKEY_DOWN,
 	BKEY_SELECT,
 	BKEY_QUIT,
+	BKEY_SAVE,
+
+	/* 'extra' keys, which are used by menus but not cedit */
 	BKEY_PLUS,
 	BKEY_MINUS,
 	BKEY_SPACE,
-	BKEY_SAVE,
 
 	BKEY_COUNT,
+
+	/* Keys from here on are not used by cedit */
+	BKEY_FIRST_EXTRA = BKEY_PLUS,
 };
 
 /**
-- 
2.42.0.459.ge4e396fd5e-goog

