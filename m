Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21696C52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC8888D82;
	Wed,  7 Aug 2024 19:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WbOfPaZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4978388D61; Wed,  7 Aug 2024 19:13:31 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB25A88D61
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428119da952so776385e9.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050808; x=1723655608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkKRc9tiAJFdt76vsQexFStGWAJLRS96aiIA0OLZBS0=;
 b=WbOfPaZH50KasNRYmJs4FNdmbTASORdzNeGuaAgTxJqWfyx7hzbUusa/zyOZc0g8TA
 lLv3lkyUlI6kHHZk2VJdfG2O2T/8I9MJ+d0MGxPfIO8nPjgkiOAa5D6Q0kdi7C66S0Kp
 JbP7H9X+NVAnB99IKiR+Kh6QPj8xOPHU69iOVej377NuZ8FG8M3qmlBdXXbCV2wZXOeP
 xLBNBTyQZv0X0dQRbtoBHT0rLI5fXtnfTdnTC0SfoMtlaFCHz6coVMSg49JtQPX9X1ty
 Ojf/A08B7imUtRsUFmUi9wIKi9zYMCYd2CtIML403VcPzPvK/A9ltdk8EpKFmBB4BasL
 yYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050808; x=1723655608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkKRc9tiAJFdt76vsQexFStGWAJLRS96aiIA0OLZBS0=;
 b=o26be73RpfxJocHOKscuJxbU79qiglMJjeP6560bYmXNmScwECxvjiw4HSjMFikRHv
 qUzInVPcxL4CB68zgRvvrxNC3MR0GTn/3bqW8DQzG9L+H92vsd+W6NCZF1W5SidbYOVo
 /xI4zONYNMEO1R2MsHtSb/xN12M8D5v+Tx0PbwWA5tkonwT0+K5UFY+BFfW1jaX0jqe/
 J0MuGSj/xcD8hBd3daDXXKnBs0WERZlIAgHBM60mAYQGgB0aXSSXzxGhoZKK3yLnMUla
 7MYk8CtHhYoAy5KwXyb1T8u0Kks0MBZS34/RNIuQtcOE6t8XMFh0lXGuO+lqE9CTuRZG
 LyrA==
X-Gm-Message-State: AOJu0YwUm6T6cIr2xsReNal8digoa+swu8/7+SemJcDiBZ9CSkcQ+G+G
 EQxZ8iS2Y9+357qFPTL37q7Xk8AE+f18L66ALkm4IrSLMVsBMM1M8y/wCTZx5TRpOVb9G7eX6BA
 xdky0w/R9
X-Google-Smtp-Source: AGHT+IF2d83i4phZO4U8yzmBQxtEc508sgieExzxgZE8MeX4OXFUeGYimh9h9a9lxjaLnvU+HIf8Hg==
X-Received: by 2002:a05:600c:3112:b0:426:59fc:cdec with SMTP id
 5b1f17b1804b1-428e6b30300mr127984475e9.21.1723050808177; 
 Wed, 07 Aug 2024 10:13:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:27 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v8 23/23] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Wed,  7 Aug 2024 19:12:07 +0200
Message-Id: <1bc1fadcde4c150b7d7b4db8b9d0cad2c10be524.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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
and network commands. The library code itself (i.e., most files under
lib/lwip/ except README, Makefile and integration files in u-boot) is
unmodified from upstream and therefore does not need a maintainer.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2832345ab1..04897023571 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1343,6 +1343,17 @@ F:	drivers/net/
 F:	include/net.h
 F:	net/
 
+NETWORK (LWIP)
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	cmd/net-lwip.c
+F:	configs/qemu_arm64_lwip_defconfig
+F:	include/net-lwip.h
+F:	lib/lwip/Makefile
+F:	lib/lwip/README
+F:	lib/lwip/u-boot/
+F:	net/lwip/
+
 NIOS
 M:	Thomas Chou <thomas@wytron.com.tw>
 S:	Maintained
-- 
2.40.1

