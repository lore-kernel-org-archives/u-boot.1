Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524B4CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E692888E7A;
	Thu,  3 Oct 2024 17:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XE91zOjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A23C88F95; Thu,  3 Oct 2024 17:47:37 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB6888F5E
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so14487815e9.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970454; x=1728575254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iR7fwaiaf6ymrpq1AznpcyUra4kodMDvFIUQi7Nly3U=;
 b=XE91zOjvGjM+wN6SuJYG6SgZ7syfCeGLdhtHaTgMUFqLX3xfPHsmk+7BrNR+TfpRcP
 VS+gkyvZlMYAFU1atDYRyehMBaP8u6CThQST5DQHZrlwgxaOzIFbqUslDGLZtdQYpKfH
 cupHVE5CNHhErFP8Aoscq1l+UKQHeuC34l7e8w1u1OHTIn0nP/6QwDeBIKQCU/dl0O05
 2jj6ULrFTryCffZ5EQ9f+ChnuEO02bCtsKeCn+1CL/Me1D41fiy4ksBMSAuBWW5709IV
 OGB/4wzbsz51+9V0yjXDwZKac4Zp7xUtcGeAIG/Oltp0LlnUhVjRc4OtgfJ+Mu3SKV7f
 T1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970454; x=1728575254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iR7fwaiaf6ymrpq1AznpcyUra4kodMDvFIUQi7Nly3U=;
 b=rvxusypdwmTcT7fLy1oumcXc6BwlGt1VKMn/f+Dd2h3SlQqIaWzo0gx54y/edZnyfJ
 x+tNZTz18XoIfPX3kgAzU9AMiFH/nE7KZ3Cpnm22D5XDRVJM/HmmuS1ieWoOsbuV28Nm
 IsXt+yRNFX1xoriXIySCtCkkXujhH7iJ8x9qF9gAklIJOWqQd/eMWQmCBNoTf6SJyGnW
 KERM7PjXLlEcRBloTvSufjotC3GplsriRJUpjPsh2cMD73ZAR5xXSlIUg/RT6CP08rKL
 8Z1gIRZWt8xVFA/g28Uooui67hy55DQkLJqV6c8Hvd8sCiTE1YU0EGldarhhzxlmpGka
 GmNQ==
X-Gm-Message-State: AOJu0YwN5C43XtTzUS3p8LzqHxcBL9yv/qt7VBggRxZ+CdTMePMjRNQH
 OhvZFDZ0ghJSZi4kLtG6A4l7naWAfZKwpkCpvCWkOFmxoCNKbGVVq36j4fjxRQmx/KVOH4JiWqH
 aKoD4VqSK
X-Google-Smtp-Source: AGHT+IE8Ippuv4xFZkJWmuNMuzV1y6NJB9H4eBpC4rrHi0jJC9IAeALxFeOttzoooLs8Cphk4uQZZA==
X-Received: by 2002:a05:6000:1211:b0:37c:d1ea:f1ce with SMTP id
 ffacd0b85a97d-37cfb9d318amr5296393f8f.25.1727970454109; 
 Thu, 03 Oct 2024 08:47:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:33 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v11 26/29] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Thu,  3 Oct 2024 17:46:30 +0200
Message-Id: <97a2a2f8bceaf42aef74ea2daef9d1d6bb4445ac.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

Add myself as a maintainer for the lwIP network stack integration code
and network commands as well as the sandbox ethernet driver for lwIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ab39d91a55..27d6de67b21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1352,6 +1352,17 @@ F:	drivers/net/
 F:	include/net.h
 F:	net/
 
+NETWORK (LWIP)
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	cmd/net-lwip.c
+F:	configs/qemu_arm64_lwip_defconfig
+F:	drivers/net/sandbox-lwip.c
+F:	include/net-lwip.h
+F:	lib/lwip/Makefile
+F:	lib/lwip/u-boot/
+F:	net/lwip/
+
 NIOS
 M:	Thomas Chou <thomas@wytron.com.tw>
 S:	Maintained
-- 
2.40.1

