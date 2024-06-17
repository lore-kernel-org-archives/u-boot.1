Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58412C2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C63D3883DB;
	Mon, 17 Jun 2024 17:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RgnUP3bO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 914AD883BB; Mon, 17 Jun 2024 17:33:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA3E88398
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4218008c613so34287235e9.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638431; x=1719243231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqVqLn066MM3njEiUrH9ehDx4F2etQZeP2c8uVrZpho=;
 b=RgnUP3bOCl7uaBlx+nZydm+Fy/pYYZsWY3AUB9/G0lzIlzRui50aWZafBvJ19Xkn/H
 8faOfVBUFYMNnIZquxvQhnOwVe/sCrEfJT0hYjIZE4CkpLbzoZEZAlO0Z52dS968xd3X
 qw4ySWjIKwl+nK/pZNVJP+/uaXEk20UkgIY+EK5JDcvvkoiJJzHrSNT4bS96W9YlSMYo
 keng3ruMfn2IXTklCSk8TzLeEBZk8a5RicOmSqperXDz04An3tKwYkLqTVnzj7MNCLsj
 QEFRv/eXMeR5iBBXik3ILiE8b7cZd4mvP0/vb6iD6NI2Ur5Uj18EVU9JFSRsixhuvvQx
 gUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638431; x=1719243231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqVqLn066MM3njEiUrH9ehDx4F2etQZeP2c8uVrZpho=;
 b=X6cIWeaDYpIKkj0GjCxygTGWv4QHAZoXS13WlPdFiwTuiMonE07Qbzd2KkF/4pUK1K
 VWkL739d6Qh/WQLH2No+yb4mzy2J5p4PbBRpA+gFxOe2JGqXTWZ7G1j9wzAXr/5RISYw
 0Q9CUk14e84/7gVFR50L6ftMi8PG7qbIEmHsOMk8ukKYuRfM5QeWSuLwuaVOy0z8dndz
 /mpBq13ZAc68hjM7M6Vko6SHLv7aWEhOOUX9S6OfTjQIWhoQNEF/0Ybu/DRbAzvfC8ge
 dlQ+S0QB1isu0GDdLwL323mXG+HxR01bC/3BhVNh9qFw7Eli0QIOEN+1NLuL0ag+1u7o
 KKvQ==
X-Gm-Message-State: AOJu0YzntwmuweRn3v4NKJA+SLuNFsDphuEX2o6CrDcmGJNudVIVXqXr
 DllUm4ssDFwS0YEi2VYkD9MLVOR+8MRNEKf2ga/KEwAr0sq/xANkRf4cvW0zWHDYS9PCb27Mw6X
 fQaE=
X-Google-Smtp-Source: AGHT+IHz9MqV4cqNBAqXsq1AZ4eu9m9i8vCTLaPcNJm1d6XgbgHE0SgfusFL5cWzduOdtMr+EyQsoQ==
X-Received: by 2002:a05:600c:314d:b0:421:eed3:5991 with SMTP id
 5b1f17b1804b1-4230484eecemr102433755e9.32.1718638430890; 
 Mon, 17 Jun 2024 08:33:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Subject: [PATCH v4 13/14] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Mon, 17 Jun 2024 17:33:05 +0200
Message-Id: <dd3bcf75ca2c3c652742d77137bf7b1dc15525f0.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
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

