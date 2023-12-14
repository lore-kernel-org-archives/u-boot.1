Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D358AC4167D
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 13:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA16487A8E;
	Thu, 14 Dec 2023 14:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GIwRF2L4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF25F87A8E; Thu, 14 Dec 2023 14:52:27 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167B787A93
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 14:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28b011857f0so731222a91.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702561943; x=1703166743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Td8aJIXbMp5JqUrMaHqKAzI/IeFL8/SoXqjrn04NGuE=;
 b=GIwRF2L4b5ne7baGUi7qlVvx5F5yQL798f8+ecHhFeQ01jRX1NZtVg5o1JQD5wc5fm
 e6xxzxzxRPtzM/NU+EGRzYNsjkCn3opZN5YKe3QvIuVU2Z2V4X4ClZxYSAvPUs2wgymb
 FPJonRGTDSx3N411ou/8cEtzcahHcoHfWdFmtYniIbfQa7OuA38Ku8wchVKmykI5UevX
 XDYI6hGvZEhH6jTOs5eitt3DQ8LhKNO5dndqO1TQbuc3o/7pde3hZxECAIuEJKb+m9Y2
 14ikTu+4eRLYWHfLMftvs6GECsGXo4pa4rt0xTkdi5LK7K5nP4x7CZ2ssSv/lXmAEB3c
 o/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702561943; x=1703166743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Td8aJIXbMp5JqUrMaHqKAzI/IeFL8/SoXqjrn04NGuE=;
 b=rjPHwOZh/XMk0WTfwag4RygCrlNExTVuLe7g0fkmU8dkSQa0uHSXuzCYaF2+ZZzuad
 K1o6YKU9StRtbsPyOZQf6MC/NgjOzenG/f0s3Epfr88q7Fr23GWCn6BQP0kVWqRIhot2
 0IU9VR+0G/gXqjjRPoh0+paDzwJVL/wNFbrcaUNQ+vBMtGFOCPcokI9KmTSsHpDAFFwN
 lSwQKGVoGOp/fRON8g+g6jpP/PRZ9pb41OS9PAC/CcLGR8FfIIduLDke/xGcnGMoRX3H
 hyr9ROaQsCJTRxssV/2fzKpzMqXzS5qONT2TefpgW5mrzK4CoP13MDJUAYoUTW4w+hFp
 X+Bw==
X-Gm-Message-State: AOJu0YzuQUwseBIPpIgkf1ZTah5AohUJDAPERrPQI7cdWv+1eKih/lFF
 afPZqsEIz2Eht8T54w8m6yWu0ZkYaOE4Uuh1pa1M5w==
X-Google-Smtp-Source: AGHT+IFlXBG9ffsEU+xaNO9vHp3Hti5/DyLT/Qv6tA/QpsMlCeHMtDqwhRCe04GZhEIPys5K6JnhEw==
X-Received: by 2002:a05:6a21:6da1:b0:18c:346c:d59f with SMTP id
 wl33-20020a056a216da100b0018c346cd59fmr5433647pzb.62.1702561943252; 
 Thu, 14 Dec 2023 05:52:23 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 05:52:22 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 6/8] MAINTAINERS: Add myself as devicetree-rebasing maintainer
Date: Thu, 14 Dec 2023 19:21:01 +0530
Message-Id: <20231214135103.1606605-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
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

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 969514468cb..253092c345c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -951,6 +951,12 @@ F:	cmd/cyclic.c
 F:	common/cyclic.c
 F:	include/cyclic.h
 
+DEVICETREE REBASING SUBTREE
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	devicetree-rebasing/
+F:	dts/arch/
+
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
-- 
2.34.1

