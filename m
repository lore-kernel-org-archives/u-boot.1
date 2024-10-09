Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB0CEDDA4
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E526D89217;
	Wed,  9 Oct 2024 16:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CMeqe+BX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91AE6891C8; Wed,  9 Oct 2024 16:50:45 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8318C89166
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5398996acbeso7883739e87.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728485442; x=1729090242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAeV8c6Pbb/IEQIhEymwOdnJI8PLapYICczp3BpmZxo=;
 b=CMeqe+BXtyZ0qD0K3YpKv2t0tcEcs232+8c9J0s2Q5uLsPHA9VIofIVdRH+rP8sJXS
 CIZ+zBhCz8AqluDoTbQUTKXi8ayrc1YH5xLDj9m2tj5adYvJcOjF8nR9NsBHlFAxKVOU
 /W9suSshGj0DHX6zlEyvHJhG3C9YWuCvVhnoBd2SPaqp4YaWtOyWFuvznY5KYRCbe6Mo
 u4BQnfHDbesk5tGGtnS//C9O8ALFZyophMJLNYWwaxjyqnoU2Tdeg61wQqYnr0zmVyHM
 0mm9x4COw3HWYJm4H/SAUMtNed0q8q3e161VyUn3csF3wmR1TG7PE+K0t5CqObm+lmD1
 qe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728485442; x=1729090242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAeV8c6Pbb/IEQIhEymwOdnJI8PLapYICczp3BpmZxo=;
 b=DJTo4YlGFgkPe7zv89aEZtgA5nijLu8Cfqf21epOJHsCwCka0zkHDFesV4r0JTnclD
 jad2WLpRH7OLhzECvZzsG/FRu74i3hbdoT1luTIk42D52B9KzKbNaaioj7cDRvAOL5Ay
 T8FJwzU9uN2L0yCcsE2YcuAmDLYRwaaO05ZayFil2jBodR3hSczj5fCjeL+rzHXHqkQc
 eVY96UytOrPblCZhUdIMjLMaKWpLgsDmSBbzi4pg12sfKH6XD/rPAqkPak/UhXjRyqCL
 JPNg7WlBrdr/pyuaqzWq62hT2oU9Rjr7S3aPWtfFbPCL2IfJzPHFUZX15xXW4TiKxKOi
 tBSA==
X-Gm-Message-State: AOJu0YzQU66eSLZ0aK4wfKfYUrPwFV2Fr0HddQ9GOiAgnGMCgtuFydgI
 /Et5pg+GXZviQRUUywyzZsUN4FraUzBJvO9vLhr81xDGbhF3nI0qUCvIQ2FoiBU+FSlN8nE8Rgb
 S+SUrg4E4
X-Google-Smtp-Source: AGHT+IGgQJtrFByC1Ohrsp5jl1E73OQmHH/UQMSXlhQimKtjiEBdt2VJdF2xa42VQTNnFxLKfltnWA==
X-Received: by 2002:a05:6512:3d93:b0:530:ae22:a6f0 with SMTP id
 2adb3069b0e04-539c488cb71mr2151558e87.5.1728485442535; 
 Wed, 09 Oct 2024 07:50:42 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b5ddsm10700957f8f.47.2024.10.09.07.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:50:42 -0700 (PDT)
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
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v12 21/21] MAINTAINERS: net: lwip: add myself as a maintainer
Date: Wed,  9 Oct 2024 16:50:02 +0200
Message-Id: <b7ce8784222d0ea75b5776c1ceae6c8dc8c7882a.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7aefda93d01..ddfb0f481a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1359,6 +1359,17 @@ F:	drivers/net/
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

