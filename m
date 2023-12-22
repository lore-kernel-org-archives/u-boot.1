Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750C3C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 06:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40CC87837;
	Fri, 22 Dec 2023 07:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nNEf5dXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DABB386590; Fri, 22 Dec 2023 07:13:18 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D5F87837
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dbbd2bc34aso712038a34.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703225593; x=1703830393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5V39enIL1JRTUIy4Wlehj3YAJJ42dNoY6cKQFQLyws=;
 b=nNEf5dXRqe45XdQwB85N4QB+KcfyUSEl5LwpHc/i2bn5++GLsiNGdcQnCsPFnlMzRz
 Uh6Jhux06ZjQTch/T7rJ+GGmv3WtG8NKK8G43dfCbpm40M+XwttFOD4zG6fQOKPG4rid
 yZBbkfhS+wO78EI1GGjsfiF0V0NZuBBSXMmxU9JqgJctHBtpGgkdV6PwbUUVoDxVBQIR
 vB5iumGvn7E/RI0C5I9koRXpM+5zITwopYwFpqQ90NFk5NQpT6LwUL9WxxGaicBvozVd
 pT2/WK2pGhcs99udQMfLRVlcMa/ehagMA+EDFwGbku38Xp2jOYCmeU2e9XlgWh94C671
 Izeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703225593; x=1703830393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5V39enIL1JRTUIy4Wlehj3YAJJ42dNoY6cKQFQLyws=;
 b=hxkrYnx7scn3sdPAEP6hYWr8xK4yil6g1G6EmJ+6a9d+HBvrvtzO+2+3SJZxxc9xxh
 uMbDWtc0+OukviaKQKziL7y5rmvY/KeadC3+eWygV7YekTFWk5n/QKlExyAYKO2e1wIV
 IEjrQJ+XLl3OdZiwTTKaZHRz4b8QQ1kwlgAwcsBPNayPpHMjBMbo9iyjR39NY2qNDReo
 J6ezWzUrtxzrXuDTZ/cmDdu6FS3o5W+VHbgW5GBiUuz3OnCC40TUpVtlOCh72BMvf66y
 u/2UlDq4eW3cf9dtDx99HBLl8WCeKdpNGflvGsk1FOwKzjXDXHjnQHA8ElH2r63m5HjQ
 a1Aw==
X-Gm-Message-State: AOJu0Yx0Cu4PVkl6U5xgFvFyPuGxNkajH1fUoNnFePKWXsQQ0MAnZQnw
 j5uJZt7DIng/ZlQEunImoUUx/lRcW103DCa4VNUHCSFJC3HHGA==
X-Google-Smtp-Source: AGHT+IG/zOcu2pdGtqETOAsN2vQ2OW+Co4IDqBGUO/vpxHw0jmOhsbL2HUcENo/+mLQBACBrMebmKw==
X-Received: by 2002:a9d:4f14:0:b0:6da:46fb:76c with SMTP id
 d20-20020a9d4f14000000b006da46fb076cmr916017otl.8.1703225593677; 
 Thu, 21 Dec 2023 22:13:13 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.219]) by smtp.gmail.com with ESMTPSA id
 h6-20020aa79f46000000b006ce835b77d9sm2602883pfr.20.2023.12.21.22.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 22:13:13 -0800 (PST)
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
Subject: [PATCH v2 6/8] MAINTAINERS: Add myself as devicetree-rebasing
 maintainer
Date: Fri, 22 Dec 2023 11:42:06 +0530
Message-Id: <20231222061208.3009970-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222061208.3009970-1-sumit.garg@linaro.org>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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

