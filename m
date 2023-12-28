Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F71C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 11:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5273C87A15;
	Thu, 28 Dec 2023 12:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UcR3JAv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756DA879DF; Thu, 28 Dec 2023 12:59:20 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6167387A1B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d408c2908cso14227365ad.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 03:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703764755; x=1704369555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cb3XFZL1wSgCUb0IUdl2uX0NzUG6r5NYkoUBmB8V16g=;
 b=UcR3JAv7k+7LWh2Esj/LHENy9leD6QcS/hxJj93XeygdoWdXxMfhKx3DHvS4SmhlJN
 e3NVF4ihj3yPVYfKiYM23xgJV3AcV3GAh07IYsWw5miT1XVO+MPxLQCF2rI2PSA5UJA0
 qRKVtZmtdJLpjJAdjG8je51YoW7gS9LjNBoX+2LrwZmcqermXvmAdaSbCrOtfQ4ds29l
 jscx3lb4/Pid7JfVPoOmTa3I0qK7KGUbwvBYv8H8pzABB3Q+f3RvDefzkiGL1nfXTwXp
 KnUvSE4H5QYCMmCIxw3MeKwFi8SwcLLSSI/0jOTzOkrZ1wowkKJvhfGYORu9iK1AFgxS
 wYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703764755; x=1704369555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cb3XFZL1wSgCUb0IUdl2uX0NzUG6r5NYkoUBmB8V16g=;
 b=gWGLcwrXoNfEfqYoD/5DAh5Y1dAGMy3KiyfezmN7DH8rvXLfvT9ijW+tBoY1gC4HJe
 FkN92drfbT/GMHqtF/g7BfRBIfR9fmiCmqnp19yJbXb7guGdeVVFxF9MTxLEqr21qNIk
 8vJUc6gQ0DLRVfs6/92PvtTWIPONzucwJyldMhSDJQDVOjA0lmyeZO68uIgKtcdECH4J
 OvP+GRLlro1yVzbRhxOp0iP2H1bl9RUACDXaccrH46qRTb6CZ5OpA2O/s+khE8JZFNO9
 LUTwvrT0ByN0a4VZjJNSKJTJCoTKg3c2f4iuqhxQ+jYr7V3bTIMglDo99QVH1tbWAZs2
 nPtA==
X-Gm-Message-State: AOJu0YyUGIB4XS7QwkaZMmpg1D/mJx4Dv/Ws5QZXDtixs/vCteY4OhRt
 7l+R4fl2Ej9YHeepPxUPVVjQtxGhkSRGD0A0dG2wyGpjqQjk3Q==
X-Google-Smtp-Source: AGHT+IG+qwCl9JEvkkwXfKVIdd8GU4hSRu9OFp1L197yJrWbeK5tzFIki33ekqUXMGBBMx+6F+bWJg==
X-Received: by 2002:a17:902:7ec9:b0:1d4:2330:8590 with SMTP id
 p9-20020a1709027ec900b001d423308590mr3674193plb.40.1703764755514; 
 Thu, 28 Dec 2023 03:59:15 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202]) by smtp.gmail.com with ESMTPSA id
 r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 03:59:15 -0800 (PST)
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
 mibodhi@gmail.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 6/8] MAINTAINERS: Add myself as devicetree-rebasing
 maintainer
Date: Thu, 28 Dec 2023 17:28:02 +0530
Message-Id: <20231228115804.3626579-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- Picked up review tag

Changes in v2:
--------------
- Picked up review tag

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

