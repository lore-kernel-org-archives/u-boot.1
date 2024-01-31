Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B412C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4F287D82;
	Wed, 31 Jan 2024 16:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cQ00i6gQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFCFB87DAE; Wed, 31 Jan 2024 16:17:18 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E46587DD5
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33b029a1c8aso484025f8f.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714232; x=1707319032; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CET3eUDV9NZELvt9it488uR+EPRcQvbv6V634t911uU=;
 b=cQ00i6gQqR9ILg+VtSWraN1rIy0KxavnXARjpzqiPYRqVAnYgKYFfA3jHb28qanJnN
 gmPcHBS7ea0qwLYg3s23CRy3WHPA8l5XwHpPlbuIYMHk+hoUlcxyU+6tfXjtVWqcZV0T
 kAK3+J48NGawnLqCBbFs5TTBW2ogNzwhmX2aYVjquYG7bGfAYsPlAC6vwP9g9giPKhCy
 UZvH5sbSCnIx5P/vqimjCGQQMNP+53pW1VcA9myX7G3Z6jcFvJiZl4d6ijNzIyGlvY43
 /U/fYERm3dO1xzfD5lt2bXluNGyuK8Omi0EohksG4FmBsb2HV98lryq2SXc6dk/kW5qk
 hm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714232; x=1707319032;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CET3eUDV9NZELvt9it488uR+EPRcQvbv6V634t911uU=;
 b=ORXxVtlbuhVGxFCZeO5yNUQjPYttap9M+eTVJbBoBJ8kUyTP2iK30EPJDSzqoaJf8m
 NE0XJR7JpfrEzp2MVig27TNKajax9jKqJIyaxkyNKIKv2Gl9G4zwtVxrwwW6CgK6ekd+
 Hc0ftQpEiqi0VAoQ9aAuJtZS4Q5WYeLaIIPihVUU7gvlcUQE5JpihLgNE1ElrRvFw8uQ
 /cy5SLBkvD3+7QBh6xWjZq+sYUM+t471JhAID4VXsWDRP/814hSqR5aN8AFbjNAzbrgK
 /4SsZrl6Jpb4WSj6xGJUAdsmtLZMxtIGOuqzBfSf1pF/NvH2lGcmloMBchplWDSXdPEF
 3fSA==
X-Gm-Message-State: AOJu0Yz61g0Unh2wvQrzgKwX4c+g44xBcvx2ssXYZ9JQiJ2ry+4ndkxX
 EMFblJBK0srWBrU46pykaKWOJr6uv68HqkDbkpMPJEF1AZu/LG6+QgZJTkCShJbUWPfaVcLKIGG
 T
X-Google-Smtp-Source: AGHT+IESZ2pLxjvP6p76Gk40+VTDleUL6XNd/Ca++tOJZgT8MVjXiZpsGc0yIPyfMx1YtuttXr29sA==
X-Received: by 2002:a05:6000:1c3:b0:33a:ff6f:815e with SMTP id
 t3-20020a05600001c300b0033aff6f815emr1973656wrx.8.1706714232590; 
 Wed, 31 Jan 2024 07:17:12 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:12 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:17:04 +0000
Subject: [PATCH 12/13] qcom_defconfig: enable livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-12-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=mRizWpS+90DO1FRezjuCs5U0eGxwVK0LwtZzPnHg6k4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTk39T2dgkQnb39Q7vtk/9W9oauYH7+Y2fS/Jq+ob
 6rmOrtFHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAieUwM/0Osmz/pKAufvG5v
 JV8y78jyXM+FdVcuvH56616LyFGJG9sZ/rvveNC2YF7ZpclPjypFtpy//l3TbkHg2vm3Wz4fCuv
 VvHwOAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Qualcomm FDTs are on the larger size, and with the addition of DT
modifications during board_init() it makes sense to enable OF_LIVE
globally. The cost of building the tree should be offset by the
increased efficiency at which we can walk it.

Some rough measurements with CONFIG_BOOTSTAGE suggests that this might
add 0.1-0.2ms to the boot-to-console time. However the reset-to-reset
timer difference is in the range of 0.5ms so this could just be noise.

Suffice to say, no significant slow down.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 659775852c07..3935fe2ef59f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -32,7 +32,9 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_LOG=y
 CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
 # CONFIG_NET is not set
+# CONFIG_OFNODE_MULTI_TREE is not set
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y

-- 
2.43.0

