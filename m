Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527D0CE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DBDA88D38;
	Fri,  6 Sep 2024 14:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lUBAkIky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BA888D1C; Fri,  6 Sep 2024 14:35:25 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1F288D33
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42c94e59b93so16908375e9.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626122; x=1726230922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X31r2+WwWvTBRJFNZIhR9Hju6vvkRpqu0GGZrnMp3kw=;
 b=lUBAkIkyEbkQtlZryKcq+1r/60JY3OfiwDFJZ05AHLLhITWAMIDVbhUCHiv4MRe4zu
 HIpwHQKDVNa3uDmk1Lz6Nfw0iEWPjP03dAiAxW8Kkdt5UvtrKW0SZo9b6vswVe2abchq
 uYBSnFo75E5zSnCixmvLYDorF92rLF6jep4lMH8bSYCCHqx/hsy/d/q3qeRtjhuYcdiE
 2LBbdo9o8NaHW+ZP+6BQpKj+RJcB7NwiyGimPSz2nlJd3CzrrFpNQXKkXbBgE3nX3nwl
 dXDe7NUewDnlEAbbYEBJngcHrHUvXu09rDjqFBVINl3mkXUlJN44HyI/OVJ+HFrbRTFT
 Wbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626122; x=1726230922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X31r2+WwWvTBRJFNZIhR9Hju6vvkRpqu0GGZrnMp3kw=;
 b=AK0Riq1pZoxitLCUGZea+8JGa+2B2yAZYPigZQ3XYNXjjJ1Ok1chFRiCbJoRD8sP2x
 NI8WMuAf3eEiQka/TGbwuO7dZSwDPEd4xKNnE/SPf+NHYvFYCP0AfhIOGFFxgyt5cF8y
 w2vyX8Qv8aINNcJ8ya0XyJUOykkRdauSln+pb8v8B6chRYvD0NuwQeyiIwWV26l4sF75
 vuUbIbITDvsrFJ8NQbpk9bIFOru0hpEmePfZZjCAdECTOI0kha3sBI85thxFC2RoJiEz
 XNSZiOfPFgdvl/sooLASdqLKJG/2dQubeiJdH45Rh/JKkLvIfQOf3X1nsceEgPJjBz9K
 SQSA==
X-Gm-Message-State: AOJu0Yw7VQSxRT61iTnxnKpoNxNs95MkBegbRhPQEx4Gn06BBqDoGTNV
 G7r/e0l56Ip2Mg5D2qCqT6V/gFaYolfcrNY+wwnqRl4noKGRVhlJvrncA2wgatU/McD2ODAPvoo
 7l2ZknEKq
X-Google-Smtp-Source: AGHT+IG3UDIHy6JmMENTB4gDi0DKTEQxxWLtmOZnjKGlq95uYCwhJ3cNk8akB5Ohx2tdMpr9rGVx3A==
X-Received: by 2002:a7b:cbd4:0:b0:428:e820:37dc with SMTP id
 5b1f17b1804b1-42c9f49f2d3mr16437975e9.7.1725626122332; 
 Fri, 06 Sep 2024 05:35:22 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:22 -0700 (PDT)
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
 Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v10 20/25] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Fri,  6 Sep 2024 14:33:36 +0200
Message-Id: <9904f9b2e4c0122c44d7327b0d8ac9dc74c8a903.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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
index daaf0345d0e..f915db0c1d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1351,6 +1351,17 @@ F:	drivers/net/
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

