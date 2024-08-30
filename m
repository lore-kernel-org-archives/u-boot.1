Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D4ECA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B5A88B6D;
	Fri, 30 Aug 2024 12:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BiKPRgLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE4E88B40; Fri, 30 Aug 2024 12:17:43 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF4288B29
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3730749ee7aso1123409f8f.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013061; x=1725617861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Tv8acgq5VmfVE0WMLnnNsQ3BITV0x/6LfX/TV/+s5A=;
 b=BiKPRgLzwEAlqHmM54hretz3/M5JlDlTD4NXaMuybdpu1aoS2IpkZtKUBT2S3yQF67
 wGBjuZGs+e1trxw/XPsX9/BR0BVR6YG7NwOy4RW+fQlwr+3hh+qSW8xwj++VzoIdgvsU
 w/Ca+RzLZ29O82JWb2NbLDZil7XErYWcs4kCuwgTF0FMA3GZ1CNIm+ih+cYziewzHZ8K
 PbKGbdjcZEGmn03ZHGPdk82GpW/Kh3VaS3Bfk2E95fnO21QnjwCMZ+8OfF/er1p/aH6C
 LkEyIhZviZuELP4fI/9HY3KLtvvRyGRiAjhILtmkwEWm4lR5wqdHF3jl77nMnJbZ6ij/
 PRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013061; x=1725617861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Tv8acgq5VmfVE0WMLnnNsQ3BITV0x/6LfX/TV/+s5A=;
 b=k0RFdb04x33C2Yvay1YQJb8V98XMa8kxuvolu3SqMegJMe1+pvxO2mb98fnlxdDJSQ
 hL+lF4jtryWzb0t10pXpOmJKJJw2b+u9LaMJrzbcqctWkxk5LYbo9+YdpkeuQSvp3nE+
 Dml+CQWxqtvWAYij5SFwMesMmw1dNcyXXMb149lhlLfz9Xj3+p3dMWnof8xzO4SKNKu9
 pfSeELp5btB7XSlNL5bTDzbi8Fa/rdQthjiAmoKVBuX2gy8WC7g4O9zCNrXpdzIlKK+Q
 c8zb+3GifwlpSqeh59X6fAlblZVNPMNhu6kDhwO7kmaSQznLZNrplVsjiPQ/DUtORpVQ
 bTGQ==
X-Gm-Message-State: AOJu0Yz3LHJV6s9v/v8OfKRPZrwbRjkWZNfPmMBKnM1U/48orl1GvM92
 AomjyrrdXyw5N6/lGnnEvyLlmJCTS90hA7yVQd7YR83YwxST6M5Z2XL8IbwqYWpo3sjJLssAVFx
 0XKLudxpC
X-Google-Smtp-Source: AGHT+IFg05RLA+Q69qxpWqdV49PbJ2fGvEohk+St4D5C7+gz+Hdfb8AYxpTGbrMSpEclal1XI3tlkQ==
X-Received: by 2002:a5d:5d86:0:b0:374:b69f:8 with SMTP id
 ffacd0b85a97d-374b69f013emr404401f8f.33.1725013060877; 
 Fri, 30 Aug 2024 03:17:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:40 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 16/16] cmd: pxe: CMD_PXE implies CMD_TFTPBOOT
Date: Fri, 30 Aug 2024 12:16:59 +0200
Message-Id: <2fc6c69a1aa28b578684642959906cfe000b2a0c.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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

cmd/pxe.c (CMD_PXE) calls do_get_tftp() (CMD_TFTPBOOT) therefore add
an "imply" to cmd/Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda4..be15a4d267 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2091,6 +2091,7 @@ config CMD_ETHSW
 config CMD_PXE
 	bool "pxe"
 	select PXE_UTILS
+	imply CMD_TFTPBOOT
 	help
 	  Boot image via network using PXE protocol
 
-- 
2.40.1

