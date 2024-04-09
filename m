Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F23CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F00879A0;
	Tue,  9 Apr 2024 17:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ukkvlKHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EE987E86; Tue,  9 Apr 2024 17:03:00 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85677870AB
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a51c6e91793so450467166b.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712674978; x=1713279778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VPJwhRYi+nUW1fly8pzfAp8Ji2Kz0/VQxCPGeDPCLu8=;
 b=ukkvlKHvkqrGxwntWqlfx/KLNLvZsPxpXwQlr4dGZUOaxxJ4Wm/2zKKRnHepWUs+QG
 TetbwYhfcqP/1pLhSiJMUowm0CRIC2iY5FTz6kXTLSxJZ/2T00/da/OFZ567vMJYk/ot
 5FaOTKcnjLjBoHaErFqwPql6eajjGJK/MlNtTp7A54NGnY+2s4jE9LFfMsb4pwjFxrhM
 DesrT3Xtbtgr1wjmSafmQ1tmA0dSI7RyBT3+bWbBUicMz/rE6XMOAeZyE2rUayey3zeL
 NjwK675utqM6iqEDcQxJ+QZC88hlQ5CGSpVZXcIhZ7Xml6Nc1bks4V+OFwAwf76lJzRf
 hBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712674978; x=1713279778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VPJwhRYi+nUW1fly8pzfAp8Ji2Kz0/VQxCPGeDPCLu8=;
 b=AP4fiReB+9yChTGTO3RimLo+rB5UvcUpA4hdhy7IG0qMOgDYFc+ePisIEABOLkhrmC
 7mEIAIHe+aQhxLHa5BEZM0ZAajdYQl1xEFQmaPclhhGMuNwz/GLlJk4CcvlXZfJMZTRE
 iCKnUsa7qeAmmGPVxtWOA/elQIMDhXY0rxmrfCLIYImMoO8ZHOYqPswDDwSyCC/FQMw/
 tnJ4jgv0bnh2fdbVudYvXntyiI5WYwpFyDUl0QW9a2mUESOWkwfMAeVig44DfIyKDitJ
 aVLqaoVDR6mr0GUJSNoZLKSmKU4UQ5lk27W0kZA6NVP7pZhXJbT5EEVlZXnirecYSDXe
 1uhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKr5ewycAHYDBngs+O5qrsSzqUKIwLE4fxSvpgO+4dwVNWiI0kGgExsalng2cC9h1/o6MnVmvN7ZzfI1er7WrzT7+rVQ==
X-Gm-Message-State: AOJu0YynMIGDfTYLHKxeQGv0XoonSj4XB61odIkq4iCvpxET8qgpzmb9
 IA0UQfmUNGLckrtwqFSyBee4iqoKx5wlJMLKwz4Sk4Q4TsImgud9MW8AILMN15ZYbNh9GCAFqbt
 n
X-Google-Smtp-Source: AGHT+IHdml0hTa9xDSG/ZLnmjlHL30Xl6oOZTMBegsYZJsdjpuSRwcA6kMHCnazcv9DKlhR6eT0+UQ==
X-Received: by 2002:a17:907:20f7:b0:a51:c957:a613 with SMTP id
 rh23-20020a17090720f700b00a51c957a613mr2487271ejb.10.1712674977982; 
 Tue, 09 Apr 2024 08:02:57 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 hv8-20020a17090760c800b00a51c0ba2c7csm4235339ejc.16.2024.04.09.08.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 08:02:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] MAINTAINERS: add Qualcomm mailing list
Date: Tue,  9 Apr 2024 17:02:51 +0200
Message-ID: <20240409150252.561029-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

Add the newly created u-boot-qcom mailing list to keep track of Qualcomm
patches.

Additionally, link to the U-Boot Snapdragon custodian tree.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0462ade4ac60..c0d2b5138fca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -602,9 +602,11 @@ F:	arch/arm/dts/am335x-sancloud*
 ARM SNAPDRAGON
 M:	Caleb Connolly <caleb.connolly@linaro.org>
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
+L:	u-boot-qcom@groups.io
 S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
 F:	arch/arm/dts/msm8*.dtsi
 F:	arch/arm/dts/pm8???.dtsi
 F:	arch/arm/dts/pms405.dtsi
 F:	arch/arm/dts/sdm845.dtsi
-- 
2.44.0

