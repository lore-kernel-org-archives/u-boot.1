Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC87CC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A79988476;
	Thu,  6 Jun 2024 15:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rWR5qizH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4184788464; Thu,  6 Jun 2024 15:37:18 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0501088499
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-421208c97a2so9855685e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681035; x=1718285835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqVqLn066MM3njEiUrH9ehDx4F2etQZeP2c8uVrZpho=;
 b=rWR5qizHj5QNBMLvyCLySFdX+6E6OBw4q2zAdHUO/lYJMyL31hrlwl+lsqtL8GTAEw
 rmdtdbbrmHGMK8e+UoQMvu5fY2TmdgKqPuXtsfpx81yEo5zP1Kwu3n6It8zfuyO1evCZ
 1mmBV6v0Xh0pmP0sWRTy3sJskqItC2nbodnpPZVy67psONE2i3hNU5hDWiSiO3chBoqh
 vni0bcaNrQDuHwevVwExBnMPT7T6eYnHDNZEFQL8Ym3b4E1eMqLkNetKeR1HsJ3frnMS
 tWKnSlGG/SSLJQfTeuNycO2wcr6YEkVGq6r12yBZCrP7GsFMbEbcZkGbRTWb2rFWI8ze
 Jpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681035; x=1718285835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqVqLn066MM3njEiUrH9ehDx4F2etQZeP2c8uVrZpho=;
 b=pNVtjIRowxITW9HldlXWMhu0I1dt2AWUUaj0gCBmVU2aoT+L7XSXlxKpI9zMV6TTXB
 xuMyvUBabgudL1UGG+GbIcAM+jnUMu3ZWt2Oms+NW0q7Nxl4p4Av59gHHyalzk5u/YCr
 f4sZprioQP2gxP/1YpVDoeIwRZs38cKJ3giW5OegrFsoAu95ATN3nrrD719Ds1VQlBvh
 6ILeT/rxhPkcSi4vKnlqBvCtR519QXBvLikGmy7ASghNUGGS6JsOryEJDyDszRdvacGp
 f6h6KiWkR3tWgqGtxwk+KmzaBYvEimB3anXjkzAY3xtONonUUPddiAdlOe16Et17oOwa
 BFcw==
X-Gm-Message-State: AOJu0YxTgSK3tKsWd/UL/A78u/FCMzuzxEcbHUNKRHnNchBNAW68toJM
 J5Mr3teStaBlAdsuiTStceGVDkv3dpofGOpLIt/2w2D+ioa/ZBAxdUXt+DxzPzJ/SdWETHt3kwE
 jjVrAwZ4e
X-Google-Smtp-Source: AGHT+IHWPsxOwAPy782heI9A6kvHY6pMryW0Ti1JdRr/gPhd1i/n4lqEHr1/PgDnH/ZZSZ4C44U2gg==
X-Received: by 2002:a05:600c:458d:b0:420:2983:2229 with SMTP id
 5b1f17b1804b1-421562e6358mr53315695e9.22.1717681035366; 
 Thu, 06 Jun 2024 06:37:15 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:14 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Subject: [PATCH v3 11/12] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Thu,  6 Jun 2024 15:36:06 +0200
Message-Id: <a49d313c767c7b3cd92fc2ca09d0701e39ca65c4.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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
index f8afd7d51e2..11105869304 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1310,6 +1310,17 @@ F:	drivers/net/
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
+F:	net-lwip/
+
 NIOS
 M:	Thomas Chou <thomas@wytron.com.tw>
 S:	Maintained
-- 
2.40.1

