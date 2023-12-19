Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73648C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 21:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7DF874B7;
	Tue, 19 Dec 2023 22:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JbZYjr9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3004C875DB; Tue, 19 Dec 2023 22:11:57 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1120585E44
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 22:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ba46a19689so3942226b6e.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703020313; x=1703625113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWhK9E3F7Z6K8heZtrBrHp5U+k+K1SV72L5UTRpSFQ8=;
 b=JbZYjr9a99A8dLypM2QU5XLcJ5cz46kPwAS4Q+p5fCndEC+69To/IXvkypr4hvWwVe
 PmWQhkzwZcCzXX9AlLBUn44Jr69QLafd6O8HhU6wz5Z8t1gfPGehxISqEfnXJ6z1IdZD
 9Fi9VB8LTHvZ204qoTuCUan0jA1w98Q2LHJW2llv7Qm8RqaKAhkoIZFvsZqeUtFMuh7v
 1jgw/t4ACkCZmSTZzqXZJKY34WHniO4Z65m7tgS0qLskh57fwYXSMBMxFeSz6+35ad/9
 VZBhMMmiSuyQqlgzV+R4dbdeNyVBvg5ZK81PdmYsIYzau965S4FmoOrVjMcNw1djOYFN
 jomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703020313; x=1703625113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWhK9E3F7Z6K8heZtrBrHp5U+k+K1SV72L5UTRpSFQ8=;
 b=mDdKAvmz6U4ZHODqvDuftDU+u8tdFCNfuwUF34SMfBgt5jRtyiW9mJqAGmWlsuIJmx
 MbBr9b5OzOCDVgQALRAsFSlLPSSMDgeuJdBck+7Izn9oKVoagBXk94wR286Jm1ZekWb1
 5TxqCiIJdXYAtdTaPGztUi5EWlJxsLsBGWEptduHZmjV0/XnLJt+sQhjONRS0adHztm8
 c0sUsltZ3mfPVXoxomI71rwscrfdB6N9Bq3zStbLYfQF4J998l/pGvqsSX/5kLUVeUkO
 lIDFWn9y8Qc41Y/evsPMYZpTuPcngYfVGlFdbGCNLju6pEdxT55qxUN+ewyUUWmh9uWA
 6CMg==
X-Gm-Message-State: AOJu0Yx56rRTWDrqiWk+do71evB7P6bXUzDm+PIlG8DctfZjKibE5FbV
 u9VT6R/zs2VLhPAHIkNDBax7bgU/y6oS3MTmG+Y=
X-Google-Smtp-Source: AGHT+IGG9C6dAvOtSpNdpP4KEhD9BYQSchTriBcsJSd5/HB86S2HkBuiPsbiNJ37PI+xECz6YeCvoA==
X-Received: by 2002:a05:6808:300e:b0:3b8:b063:ae00 with SMTP id
 ay14-20020a056808300e00b003b8b063ae00mr20704066oib.93.1703020313383; 
 Tue, 19 Dec 2023 13:11:53 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a0cf38e000000b0067a33133420sm10709493qvk.110.2023.12.19.13.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 13:11:52 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 4/5] fdt: update the document and Kconfig description
Date: Tue, 19 Dec 2023 13:11:11 -0800
Message-Id: <20231219211114.393193-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219211114.393193-1-raymond.mao@linaro.org>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
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

Update the document and Kconfig to describe the behavior of board
specific custom functions when CONFIG_OF_BOARD is defined.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 doc/develop/devicetree/control.rst | 6 +++---
 dts/Kconfig                        | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b17..e061f4e812 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -104,9 +104,9 @@ in u-boot.bin so you can still just flash u-boot.bin onto your board. If you are
 using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the device
 tree binary.
 
-If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
-devicetree at runtime, for example if an earlier bootloader stage creates
-it and passes it to U-Boot.
+If CONFIG_OF_BOARD is defined, board-specific routines will provide the
+bloblist and devicetree at runtime, for example if an earlier bootloader stage
+creates it and passes it to U-Boot.
 
 If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff89..12d61dc748 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -110,8 +110,11 @@ config OF_BOARD
 	default y if SANDBOX || OF_HAS_PRIOR_STAGE
 	help
 	  If this option is enabled, the device tree is provided at runtime by
-	  a custom function called board_fdt_blob_setup(). The board must
-	  implement this function if it wishes to provide special behaviour.
+	  a custom function called board_fdt_blob_setup().
+	  If this option is enabled, bloblist is provided at runtime by a
+	  custom function called board_bloblist_from_boot_arg().
+	  The board must implement these functions if it wishes to provide
+	  special behaviour.
 
 	  With this option, the device tree build by U-Boot may be overridden or
 	  ignored. See OF_HAS_PRIOR_STAGE.
-- 
2.25.1

