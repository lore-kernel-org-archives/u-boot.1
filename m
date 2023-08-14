Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B66EC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17D9869A4;
	Mon, 14 Aug 2023 23:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JR/E70Zc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5975869C5; Mon, 14 Aug 2023 23:56:29 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5754884788
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso41575415ad.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050184; x=1692654984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTMr2FRTpHjIBRHXvgOPzf/szvTGFUdrZlh64BxVuMw=;
 b=JR/E70Zcw6C8AfMaU/CGcBjcAM/hbEo/ENqHjmsPjihieCE9U4AcPsjXROgfe1A2vA
 HrrVPzV7V/GvEM7+lOEM64OdTQFQzkpBu99YakdJoP/+hWR//RxhGOPtLTqpm7apqCfy
 RwsO0cY/byq6oNqRDjegO1yz+Y3czmQFQgSciAZHFwB5a8W/EWRRMNqz2CLvknCKfbQl
 A+ePPXcERZAPgOeF5cEuH3XCgXqeNzy01NSp8oWg8eiZv+2YV5SULGJc6FUnMRWmGg1p
 Hurs2y5JJbhzT8IDA3pdLgF0ZWC8Pp1NFG9evEqnpTqgZp+JLOUUPl0I3eY8PQOCMmaT
 ahIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050184; x=1692654984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTMr2FRTpHjIBRHXvgOPzf/szvTGFUdrZlh64BxVuMw=;
 b=bJiCnSiti5ExJckl0JtGMDg9YfRXgmt+fdkqDH98R/vVEpu14hGUIU+naDROVEf28W
 PHfpnR8sE4rfA+o1XnT4f3Iy3hN+BZ2MyECKA3Uw2EqrRNkk/AkwWJj+DjKSLM2nnjB1
 RjHT0pgLnNNdmpeIrT6yX0TcC6kBo6xMvsw8mrhFJCG71dE+5RcPzE7bFF7GiPkVGypc
 +KfHHIUGA5pi0Rg45099uKOIZjwUBmaUPE/a5VjH9+s2/fbOGNGeva25cI1WsZ/mCTtM
 /pnDtKrZWJNFlLOCZrR5/O/Z8e3JP6M4brQApCAmMQcO4ZT4zDMPyyG0sOFzzpqjf/tX
 2IHg==
X-Gm-Message-State: AOJu0YyUX7ZN75dvxb9nRC9KZj9zUMW5UjW21veCNu9SV5YeJsbUKx3C
 LHxVlu1x5LsSGQqQ6NA7r6CG4KLb0bvpK0pqQYE=
X-Google-Smtp-Source: AGHT+IEHwLVES+y0YE/xcIdbRgzqQ47WOVimxnj/ihhFwNoWODI3ucZVQfbsxYEkM0p53EBMcLUJgg==
X-Received: by 2002:a17:902:da8d:b0:1b8:90bd:d157 with SMTP id
 j13-20020a170902da8d00b001b890bdd157mr14374823plx.26.1692050184508; 
 Mon, 14 Aug 2023 14:56:24 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:56:24 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 17/17] MAINTAINERS: Update UFS maintainer
Date: Tue, 15 Aug 2023 03:24:57 +0530
Message-Id: <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

Since Faiz Abbas's email ID is no longer valid,
drop him from UFS Maintainer list.

Since I am using the UFS framework now extensively
on Qualcomm Snapdragon SoCs, so proposing myself as
the new UFS maintainer.

I have also been sending out u-boot UFS fixes in the
recent past.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2db052961b..3b2acb5167 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1584,7 +1584,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
 UFS
-M:	Faiz Abbas <faiz_abbas@ti.com>
+M:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
 S:	Maintained
 F:	drivers/ufs/
 
-- 
2.38.1

