Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D6CE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6197C871A5;
	Mon,  2 Oct 2023 03:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FW4W8L3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D3D870CE; Mon,  2 Oct 2023 03:15:04 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6166D87128
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-352308c0799so17520845ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209260; x=1696814060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OG3Jj+Vw6n5KlU51Bw1U/cWjx9nzMDo6F5ri2xcTi4I=;
 b=FW4W8L3KnGPnnNTyau1rmsJfa4rNRkDNcnkNeG/6mMKW5q4fqOC3LwftKcgpF/ot3c
 Me0bQRti74M02qw9tw/48jdw7ZTxGgNPlIQ+Ef9U0CPutlnfbezqkCyY3RGw6s+bMSLD
 RUC0n09G0lIDacqN04KU85qoIanHv51jTphrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209260; x=1696814060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OG3Jj+Vw6n5KlU51Bw1U/cWjx9nzMDo6F5ri2xcTi4I=;
 b=Vuua9RXp/TsX5yZnHSS+Hym1ke3gvqihfMjhgmRS4XHXMRA1h5nqo33bb+ZfygTH2X
 ccYovVvWKx/YIikg7eZ2d2f+TkifLN4N5LhsXUha8YEsEwAMKZg4bkgn5Whpj+dGnWwF
 pQvBFs/R2rGL8LCGDJl3EXxsvKm8aIHAB0LIO7Ct+ty8sBSzDEcFHELrwqi7VLUGvfse
 L3BsMkJUxh1Rv7IEhQoZOZhxSRyg0SCNIlGCKqaWtzh4MdYpOo4EgbSTzzix2ww1/xdQ
 UulSqXWvhGY+1xk40OJJ6t7rMMlHhwRaixwdzBrRofQrhXvgf5naycZiS5K0s3bxzYmQ
 D77A==
X-Gm-Message-State: AOJu0YzBs7K/Su72mDIkm1KWvvCnU3i0RLv3Y3wP9le5soesJK3BUhV1
 31H09QhDyqrV5AO1Xg0wcgYyiYxBeTb7vt9KiBQ=
X-Google-Smtp-Source: AGHT+IFYpNPLbmqCjTmV85tDOodMx8+SxHCmm1WINXsXrvLzaZS8LHIZnzuRexlvm4DRHvtoaDfDJA==
X-Received: by 2002:a05:6e02:1d19:b0:350:f51b:c32e with SMTP id
 i25-20020a056e021d1900b00350f51bc32emr14467753ila.16.1696209260044; 
 Sun, 01 Oct 2023 18:14:20 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 32/36] expo: Support handling any key in cedit
Date: Sun,  1 Oct 2023 19:13:36 -0600
Message-ID: <20231002011349.461284-33-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

(no changes since v1)

 boot/cedit.c   | 2 +-
 include/menu.h | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index bb194af77bdc..407793aaddd4 100644
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
index 64ce89b7d263..6571c39b1430 100644
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
2.42.0.582.g8ccd20d70d-goog

