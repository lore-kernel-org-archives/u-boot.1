Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2226EE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F68803E0;
	Thu, 19 Dec 2024 19:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mkOb32gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8244803E0; Thu, 19 Dec 2024 19:29:56 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7430803DF
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so3634945ab.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632993; x=1735237793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eKWeFZUZnZ3XsLz+o1borQc1e4Uv2sbE1CGKfSsrd8=;
 b=mkOb32gxjPur6NQth8jCOS+mfZbACmmM31gF/ug7+B+PNlkYsDtjpYNajfOVlPvBW4
 EopIXivstpr6sGuYBwvr9z4NUINiJvMYGbIk49d9K4eXn/fPGJDA76wti06lv2gIvBEA
 twIyLnzyBlDhVYOanDnLMXzvbNxdcCGARlGtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632993; x=1735237793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eKWeFZUZnZ3XsLz+o1borQc1e4Uv2sbE1CGKfSsrd8=;
 b=kDT6YVcsx7uF3O8jfNNe5BJgCxHtq/kg29g6lXFgb0ofgZ1NuBUch1J9HWS1j2V2hs
 2hYLUmzfwuQNhg+6zjXJ9VUN1UG4hNO3dgBVpezd021XiR/la3nu8thAIALpVOfN/qxW
 hgKd0HZzcZheVhdOJ/3qdQtLzrQq9Lp1+oTJ63yZ2fg3KfU14aYWIeKefmKThhRoj0kN
 8uWar0RuCeoCapSV04gK6/Ou6BYBF6IAy/nctO37SMgn7ztINhQZzzAiLtSHl22eVzYI
 iK3eWReznqYsRPTGFvaAx6rp27Fsrfug/9hVTLFEqcp7h37tyc70yCH0v9E925JPfdFF
 cElA==
X-Gm-Message-State: AOJu0YyIFm0d7bF49a7HufpPaMEw68z3J11eMs9BkIimyqWIjb9yBy1L
 f3JSD2emr3qbkBKvnI959gU6HIJkHm6BPoC1dCG6Ni3PDoyOoMrzgqOIYApV7FkMnimXP9kAvDI
 =
X-Gm-Gg: ASbGnct+9tTeJX4paEpTOolc2EiX2sjIf5YQR5NcfY2BINvYH8DIlOaZrB2UIi+gRJ8
 1OjmcH9y38aILtixjslvEnKr9tkSAQi9ez2jAgfAkhlMHhrvq1+60ZrnDUn2A74yhgmeMPt/nwb
 bnVyYB3PsIpzwyVcx1yTJY2WUmFsDvJVQnF3ZC7FMoZ9a0CXwH1gULqYYhbYG+s83MLhdfAd4H8
 N+YGic7o4u94zIeFQWK0+KWotUJNvL+4oWkaZTDVRWuJKwcMhHYj69Nvg69NuUq33CpALudaRGc
 T8E33WfHT+ZH1uK8Vw==
X-Google-Smtp-Source: AGHT+IEPmKCg8G96ttUBE8Q9XNUGYxaoNSOshPZrUAlZM2NIZgw/uSp7Wul9XOjeYUrQBV7yd/5Z4g==
X-Received: by 2002:a05:6e02:1685:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3c2d4e6c573mr927335ab.17.1734632992999; 
 Thu, 19 Dec 2024 10:29:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 18/19] boot: Imply CRC8 with VBE
Date: Thu, 19 Dec 2024 11:29:06 -0700
Message-Id: <20241219182907.2609704-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

VBE uses a crc8 checksum to verify that the nvdata is valid, so make
sure it is available if VBE is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Depend on TPL/VPL as well

 boot/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index cdf787eb5c2..20935a269c6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -704,6 +704,8 @@ config SPL_BOOTMETH_VBE_REQUEST
 config BOOTMETH_VBE_SIMPLE
 	bool "Bootdev support for VBE 'simple' method"
 	default y
+	imply SPL_CRC8 if SPL
+	imply VPL_CRC8 if VPL
 	help
 	  Enables support for VBE 'simple' boot. This allows updating a single
 	  firmware image in boot media such as MMC. It does not support any sort
-- 
2.34.1

