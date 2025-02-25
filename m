Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB6AC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6492680FAA;
	Tue, 25 Feb 2025 17:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pAA9Ar0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF28807EE; Tue, 25 Feb 2025 17:35:13 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A7880F53
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so14719395e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501311; x=1741106111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDfKby4rgYi6Um9EPDrRuQexeymWhXMTc0fOwNjxpFM=;
 b=pAA9Ar0/fRT1rsQNw7zZvbcG0yFCSMz4FwZF9LKCDElHHJ+H5ZJBFI4xEoCbni9NkD
 oOonTriCNoP0LdkicVvoprW+BQxo9/hbdqasBpXicL7NSL8MwTAmPnsgsDex3NlACkq7
 +AgCYyB83Khk2+sIuqLBZf39/yGV+IU21X7fgpvukzEXDUnQs8pcrzdmQuh48j7V0gJJ
 dTxpgrC1BxlOU9WMhAyYumjQwFx7HPdxfZH6ZmZwZ2UAY2eCDXGWSOU+KuDo8reDT1yv
 j1hcIgBO/OoZBN8ah6jzjHlUte8Pny9D22c9Tg2KF4USOgAR/42M9GtQl0s4IMbekqMB
 /Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501311; x=1741106111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDfKby4rgYi6Um9EPDrRuQexeymWhXMTc0fOwNjxpFM=;
 b=AMJ+dLqetYx1Ra/u+0YqYqa5oFQl8eJn3YBQmMTUnsZuBvUi3GcfHemErf0+UiHATn
 l8XIR5YCDa1mucmjOzLRZikJtkwMmuX47Y649sM2bS02DDc6emce0XL387QCDckNY9Tp
 TxEXqj7BuFr0kDTFlqC4oL1f/aFmms0YLoQxakydx8uPZDqF0dzFXw8tn2PXqHHScDO+
 ZNDP8xachzQTvewgA77SQ0fhsM8vEszyP5iIcMAgO912t8Km+tkY1dJBOIAbpPsy+izP
 5Bu2lVaKiMvFZ37hmDR/Cu2IQGLGNfJyuLg5AMNOb3zvpfRaZbIjX6fWTQQIyWRbxhs8
 qJUA==
X-Gm-Message-State: AOJu0YwYNErabx/aDsV6b4yBTX7e57cMSYXq6qhIIWGD+6oc71UtdZ5+
 EjmY/XsLhC2YqxcdBRgNYn/yBr8DvvjNbCkVjrDL455sbUCTGf5Ra9JZEF1pnE3kKVCSQS1okK0
 EsQkYQQ==
X-Gm-Gg: ASbGncss8yJDVDfzQ6I/8MuBVNgY4l3ykOplgCMvuk3+z+bUD2+9HpFnb3y2vuGj4mT
 np8Vck6VPQialuLfcuGKGrD9LDyUHFeQMPGfw9AH045FTMHk7yRwVOsAbUNKpc/f7m1c9EYnTYA
 +77RNDDKBsfwcl93lA3Ew9kifJwGDBX9Kg/mUVXh0f5zugk9aVf/U1uOmPIQm+RkWGFjQsX+BnO
 d4YFXiDYmsEVNx0sNKYmKEWwonXOz7Ng+3PafIvM2rqSRlwp/3xMApJPsgx98TZA7lRy3eqc4X7
 HEqIvaW2M0At3u0DRgWLQX34z5Uvmpo07ds=
X-Google-Smtp-Source: AGHT+IGtKIpxBdra+J4BzbdyqjSb+GzfZXMv3vjZ7ChyGAT6yRq3Xq19v2Y7WEf2zR3UyX1zQdKWIA==
X-Received: by 2002:a05:600c:3150:b0:439:955d:7adb with SMTP id
 5b1f17b1804b1-439ae222a7amr192159345e9.30.1740501310945; 
 Tue, 25 Feb 2025 08:35:10 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:10 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v2 01/14] arch: introduce symbol HAVE_INITJMP
Date: Tue, 25 Feb 2025 17:34:27 +0100
Message-ID: <2589612a53a9e9feb67b8e8286e87893359676d1.1740499185.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740499185.git.jerome.forissier@linaro.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
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

HAVE_INIJMP will be set by architectures that support initjmp(), a
non-standard extension to setjmp()/longjmp() allowing to initialize a
jump buffer with a function pointer and a stack pointer. This will be
useful to later introduce threads. With this new function it becomes
possible to longjmp() to a particular function pointer (rather than
to a point previously reached during program execution as is the case
with setjmp()), and with a custom stack. Both things are needed to
spin off a new thread. Then the usual setjmp()/ longjmp() pair is
enough to save and restore a context, i.e., switch thread.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 35b19f9bfdc..8d5b54031b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -13,6 +13,12 @@ config HAVE_SETJMP
 	help
 	 The architecture supports setjmp() and longjmp().
 
+config HAVE_INITJMP
+	bool
+	help
+	 The architecture supports initjmp(), a non-standard companion to
+	 setjmp() and longjmp().
+
 config SUPPORT_BIG_ENDIAN
 	bool
 
-- 
2.43.0

