Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF26C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC1187787;
	Tue,  2 Jan 2024 23:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o/xgQ1GB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F78D8756F; Tue,  2 Jan 2024 23:14:06 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605A28798D
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-680496bc3aaso35610156d6.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233643; x=1704838443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eGMYaGa7FCHD3KlofvtS8+JJRRDD4vE9QXsb1DuwX0=;
 b=o/xgQ1GBCcvIeYQmxkPnePjCgTcXvKxB5oavbAaITxfQl8xtw6dBdzok/zyM4A3EdF
 VbOiTqrI2GkyS33xbV94KAu1VuwGAMsZrHkji+vbS6PfTm5dHwgMYBVFYe9yLf7/FTNJ
 C534JPCBu3IoKUupxuPhSHjKzsC4tWKEkYFfUN8fe5TCC1qR1i8TPJGKA9zFFV4akvSg
 XOGrU2TjDLw51ycwJTJ3KatdCJnXu17l3m5Vk9PUNiMUUXKw08B6tJWpABpenCZP65s8
 2ThGHHCJY5IdJ2y8k+TsoQniyhaxamqwJxZXOpqQE4InjX+que6F5oDB4omsna77yFRJ
 vHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233643; x=1704838443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eGMYaGa7FCHD3KlofvtS8+JJRRDD4vE9QXsb1DuwX0=;
 b=MxJgg6GISUDiqC6mSQpRxryM4/Y+G3HYvJizuwiHAq5sIuutkpFPjRUmELe4zCYUz9
 lx14TsyhozOOYdpQiUevUQlRjRB1axRnwYBWGCLPtphGRjo3kvT1zR+BIFJJpFGhaMRA
 cDEv/RSxRblJFSfCL0OUtuXVOA38TijYDkEvtJdSJ0hRA2Ql+akP2Ru7ctTz+14O23/u
 vFOupwE7x3Kd9BJudPRSCCN1CAJD+TBXQoS5UumP6UiTQr9n3KpAWIEs/zTVEsGZwMrj
 JejgHdqGN0t0oTQd1plWFaDu76dEs4DkaE5WZs+qhn9QdSd2M8qSQ0wyvJqvLQrxYWcT
 ZuZQ==
X-Gm-Message-State: AOJu0Yzt+w9fG8kdkXxwPCsEApqCKSF7ERHsK996Xz36k2nI6fvxNUjz
 KOhTlqKqAqrdqIZaqHXUB/C6R7j0N8nNUgJX7X3VmzJdfs0=
X-Google-Smtp-Source: AGHT+IFAFsFfAQ4Kp+is3F6Wugnkf+X9BMNN0UzIs58jwZjObskIaNIIXxexTegFzqIxKZXarJ/Icg==
X-Received: by 2002:a05:6214:4017:b0:680:b7e4:1c48 with SMTP id
 kd23-20020a056214401700b00680b7e41c48mr3075229qvb.113.1704233642823; 
 Tue, 02 Jan 2024 14:14:02 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:14:02 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 8/9] fdt: update the document and Kconfig description
Date: Tue,  2 Jan 2024 14:12:33 -0800
Message-Id: <20240102221237.1007090-9-raymond.mao@linaro.org>
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

Update the document and Kconfig to describe the behavior of board
specific custom functions when CONFIG_OF_BOARD is defined.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v4
- Refine the description.

 doc/develop/devicetree/control.rst | 6 +++---
 dts/Kconfig                        | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b17..2b968a6b01 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -104,9 +104,9 @@ in u-boot.bin so you can still just flash u-boot.bin onto your board. If you are
 using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the device
 tree binary.
 
-If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
-devicetree at runtime, for example if an earlier bootloader stage creates
-it and passes it to U-Boot.
+If CONFIG_OF_BOARD is defined, arch-specific routine and board-specific routine
+will provide the bloblist and devicetree respectively at runtime, for example if
+an earlier bootloader stage creates it and passes it to U-Boot.
 
 If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff89..ac6e1752bb 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -110,8 +110,11 @@ config OF_BOARD
 	default y if SANDBOX || OF_HAS_PRIOR_STAGE
 	help
 	  If this option is enabled, the device tree is provided at runtime by
-	  a custom function called board_fdt_blob_setup(). The board must
-	  implement this function if it wishes to provide special behaviour.
+	  a board custom function called board_fdt_blob_setup().
+	  If this option is enabled, bloblist is provided at runtime by an
+	  arch custom function called xferlist_from_boot_arg().
+	  An arch or board must implement these functions if it wishes to
+	  provide special behaviours.
 
 	  With this option, the device tree build by U-Boot may be overridden or
 	  ignored. See OF_HAS_PRIOR_STAGE.
-- 
2.25.1

