Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A2CC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902A58787E;
	Thu, 21 Dec 2023 01:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DILG5ICm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B158787E; Thu, 21 Dec 2023 01:41:32 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7E987885
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4259a275fa9so1559281cf.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119285; x=1703724085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWhK9E3F7Z6K8heZtrBrHp5U+k+K1SV72L5UTRpSFQ8=;
 b=DILG5ICmFMAZQqJy9slkci6XdfCfuW7kKQCpdqlLh4bZeK+d951owbObUFHebYADvt
 C9DnxpsmjZsClE7OH18AdI+JhrpCHy30d1L+IXYmq4+QOsf+Hp/IYPSvQxaM5FbxlqkN
 oYlVhtxtIclAMfcZzFVv7OvfYUmCYU6HPmX6dwGKT4+e6wveAFH+tfRxdHQUZUQj5RCH
 toMIU9XUY/hXcXsgQezczu1s8fMkD8WNWjBDfLArSxh1JI3z9KhNQAfrIJ6pfgljK1HQ
 UYi0seYsPR0nNHlmGroFiXLQeODaC7z77bi3COSDz4upYgSlq68lM7cX0LcsfFperCFY
 xLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119285; x=1703724085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWhK9E3F7Z6K8heZtrBrHp5U+k+K1SV72L5UTRpSFQ8=;
 b=fPxH0TYRiH5vGx4fOs580AwHRgX2TFwaYk177uPuNiRIB4mHhePIR8QD8467swD/CI
 sa7KMjLhCTbA3KLd4P9Po41rXtuPCgMFQiQBGxuJUs/oM5m5KqOTiiICMFQfxPNwAkmv
 jOqRYHYdYIaoqrhmZWyoSsipAmEdDnJ63YKiGOl5iTO4oDqBHXJKjQemUq3PtnZSeuq0
 Haf32FgdXLk1Bo+6BMr1U8KdM8rTqng0IWECfqIx9+sNxL37CXBPNtcq9/Kdwk2wazYn
 PjCErK9m0/iWQehMT/cDme6uMsNEeI0+vMHWMrIbAUub5vyQU6o2iVX/xyheWLdtTnIK
 ilVg==
X-Gm-Message-State: AOJu0Yzm+Exe4KPd16eGgAWtKEzPimjq+LsIGU72TOaTrs1RZfQcOIdD
 0/XL42GPnb4RPNwfOcrz2EBWFNEAsusSJOgzEmY=
X-Google-Smtp-Source: AGHT+IHjYfUeXe56Gj/ue3+kcETEmV+3MHb+xORK2VefwsadZSX4oqDEhtAgO17CFmVIJi1Au4dmzQ==
X-Received: by 2002:a05:622a:347:b0:425:4043:41bc with SMTP id
 r7-20020a05622a034700b00425404341bcmr26991005qtw.104.1703119285033; 
 Wed, 20 Dec 2023 16:41:25 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:41:24 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 8/9] fdt: update the document and Kconfig description
Date: Wed, 20 Dec 2023 16:40:27 -0800
Message-Id: <20231221004030.581388-9-raymond.mao@linaro.org>
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

