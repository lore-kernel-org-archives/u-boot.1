Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C929C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F0F8858C;
	Thu, 25 Jul 2024 14:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hOp4/hQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5101E884A7; Thu, 25 Jul 2024 14:59:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22AD7884E2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-427ffae0b91so9214555e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912349; x=1722517149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKlcmRfoniWXVhSWmoK6IZWIj0OZ5n4IXqkHVuJswJk=;
 b=hOp4/hQPIhZdSGBYVf5+egicNCQuIMkD/0/D5VxuIXvTPmsHQSpRe3uJQrx8KMOYd3
 nr77/HBXhn4MhF1D1FXU7fMCrH/pBVAOmumNtbx9cJIBNlFtcfK93aZIQqUgDLwcy8EE
 SVADGbAbUZXSahDZMhlg+XPwgPb0m62tQDLdDjA+bO8vvrbLOVjGUd/jttuXG6x0/Vq+
 V+WbHv/7ISyVKGFMK9S2CTciqZr66dSVKYXWmx2uruHhD4Ws6nBZ3PIAYldJ2uLADtc4
 vHnMfka7reEtx+YVojLO4RPHiZloeuPwApAukNXpHrPYdhnFZeir0qX8FaDYsVdnjhFQ
 dFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912349; x=1722517149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKlcmRfoniWXVhSWmoK6IZWIj0OZ5n4IXqkHVuJswJk=;
 b=PlnzT5IpRyYmHmYAom76eU9gSXwfQI6JO6e5zV2X6x9YWBh234goNSrLEOQ3kNSxPe
 +1PBsgTPksC8TASAQdOhGc2DAlvyq8JSNKafIK5t1OabWw2pOsIxoDXrro3NvRYI4ojP
 kDs9RyVZGEtHevKCNLX2ZA6iKUGdpfDFJLTKUpsy1/2pPwryYnjUVn9c55d/ci9zIraU
 +avXkWogrHxw0Y2+GHI+kMu3hrRPRX9dpisox8CxfmvF8hUAf+bYjEumRfXUqpaaTrql
 0ixhETHbGpWLK8AQ9FWp9McjBALTfiZLLr6KJeFbTk2UC42e064bGyyezitJE7joG/aQ
 fVkQ==
X-Gm-Message-State: AOJu0Yzqej+3cTYu/5UI2Kf2xLtpWzKyyLS5HzzfQ/CLAFSMUzYsT+vq
 bzdhVm7YpriI+3FBopuCsd+pGCjesaC0Mp9UyGpEYWDwuBmwfCcwydxQpRk964tLnml2wcGofi7
 8NzUCNA==
X-Google-Smtp-Source: AGHT+IFIO0fkpueFMASiZ9MQKP2BwUemH89vzQghbW49LWkDX9MiUXeT2mIPzFk24CdWZ4aU0P2Hvg==
X-Received: by 2002:a05:600c:3592:b0:426:6f4b:b386 with SMTP id
 5b1f17b1804b1-42806bf48b7mr17681825e9.34.1721912349458; 
 Thu, 25 Jul 2024 05:59:09 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:59:09 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v5 20/20] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Thu, 25 Jul 2024 14:57:41 +0200
Message-Id: <35905a6c2414777e1b48ff016c06db232eec591e.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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
index 6b32a6d9464..10323efffad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1336,6 +1336,17 @@ F:	drivers/net/
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

