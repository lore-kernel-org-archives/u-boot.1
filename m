Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D98C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B074D87CA5;
	Sun, 17 Dec 2023 17:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CjFX9QY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C45A87C92; Sun, 17 Dec 2023 17:36:38 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687E387C8B
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7b7aacf63c9so109433839f.2
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702830995; x=1703435795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3LeFC8aWoVu1xRZKBj6wEzBd0GoHNiZ1yKmFaUkmEk=;
 b=CjFX9QY19MOHN6/MvUPEKJE+89kqq1EjNRE9QlpejAJZdrlbRz3KNzNKOg/01vvmmQ
 P1gq9But/Id/9eFBgbMPP7DccFXXrxaOp6+diJxcsgjiYzCWT4B7JB+8h/sViymUHTRc
 HU9a9kbjm6uJB6W7TCZr8DjedfZvk4wa0fX4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702830995; x=1703435795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3LeFC8aWoVu1xRZKBj6wEzBd0GoHNiZ1yKmFaUkmEk=;
 b=Oe+tDkuRX3P0e8t4LKoQvcNNLDCq6FXy4r8ATJOMAXYj+AWeYukjacqB1L9m0FWd3n
 QCUM65eqSS8ujHmKc9caYYUKo4RSFo1a8n5cQg2wYWfKSq/sSz5ZnUAppYH+d18OlFzC
 QsAuS/0+GaP4Xdy+VyjuKFGSgyFSNXi6DffbVl6qd06MDmkq68pIa8HBFW3JuSyfMIF8
 og+XUJXJOTDAGLj9nCS0zoHcIsynM68tekCCfD/FaGqgBoHsHw8ipNxyTKYwn+dhvAN+
 p7lqu5IKQkRW8drNyEbK3E4pxvBIiMcldMxZWgzjSw/3GoqlM7tfLai0YPQ8oWiv0aWM
 JiQQ==
X-Gm-Message-State: AOJu0Yyox64LgztxPX1oBk71+HeZSFYq7DwybxFAvq8m07KueBR9lM3u
 D859q4paqC7Jk43XCHJPDnxMcrc1R5aIXB9U68xpVA==
X-Google-Smtp-Source: AGHT+IGRAhgqf6Dv8SLrpBiZW9mouY8KGbkH042BWNlL2w9TCXxUl+XQ3GJYQuiF7lOm2CqBJMcsAA==
X-Received: by 2002:a5d:8853:0:b0:7b4:5583:30b8 with SMTP id
 t19-20020a5d8853000000b007b4558330b8mr19554555ios.23.1702830995042; 
 Sun, 17 Dec 2023 08:36:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 01/10] x86: coral: Align bootph SPI-flash subnodes with parent
Date: Sun, 17 Dec 2023 09:36:14 -0700
Message-ID: <20231217163627.2339802-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

The subnode has different tags from the parents, which is not correct.
Fix the subnode.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/dts/chromebook_coral.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/dts/chromebook_coral.dts b/arch/x86/dts/chromebook_coral.dts
index 8bfb2c0d19dc..2412801302ea 100644
--- a/arch/x86/dts/chromebook_coral.dts
+++ b/arch/x86/dts/chromebook_coral.dts
@@ -369,12 +369,14 @@
 				rw-mrc-cache {
 					label = "rw-mrc-cache";
 					reg = <0x008e0000 0x00010000>;
-					bootph-all;
+					bootph-some-ram;
+					bootph-pre-ram;
 				};
 				rw-var-mrc-cache {
 					label = "rw-mrc-cache";
 					reg = <0x008f0000 0x0001000>;
-					bootph-all;
+					bootph-some-ram;
+					bootph-pre-ram;
 				};
 			};
 		};
-- 
2.43.0.472.g3155946c3a-goog

