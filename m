Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0F7C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA838796F;
	Tue, 26 Dec 2023 16:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kgMIx6DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22218796F; Tue, 26 Dec 2023 16:49:06 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4D58797F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cca5e7b390so37874281fa.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605742; x=1704210542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pf6x698dLaZJBSsZFkaInNZGzkRaXpfYDKp15lohVD4=;
 b=kgMIx6DV9W089eDRRGhSr7r/fpWh5N16q85UftXeM6iM3qomZUtHZ53zMmeYqJegH6
 IV1moW57GmEDRzpGJh1itlZC1ly9PhI67Gy+/eKUMq3AyAl+Hb6Byr6z7C7irorqqkS0
 GwHALvhlx5IhvjYxpAkdV7NOmAG4P+9ORtFGvknEDXpceKPiKwP9WGMWSerOWpu7f0bQ
 9iWmGeJ7NYQ0m4lzSwxujNcDRqqzZcPH6xtUuwydYtTN3glDPkYdz9aapgkWWNvgkNJi
 Ca8V5zN5sbU3JCVpGtlrMgfkLnh3sKDeeHt14EY0deJtSSDr+AW/Cz0n9e8QLlFb2g4P
 VLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605742; x=1704210542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pf6x698dLaZJBSsZFkaInNZGzkRaXpfYDKp15lohVD4=;
 b=QfIm1z5LDn9c/lQnh18CEOg5M3WHJYSNicD6VHdlgnOXmWnOazZ0M+8kSpw32CXYp/
 FBHbmDdlJTdyTp/68Zbpg8Z4cpKNFqQVEfkjCnytjStVbzVNYOpTe3IQWtjzHYHNf39t
 oj3BPHXwr4JzPzv/LyzQeJmTXlcCyD+w9IQYmXahl0BDE3czZmdefe3FxLDTqP0N77Ci
 elWw/hgItNjo4UpeYUhAHnXE3kgP05Uo02RaDIMavX1i8hHqzhlJwnorkwYzrcUcmb/P
 W+PNdobJbzKhWwK9rSjhenXKjnyuWEJIlM5oQEPAsTiJizWe0w9MzR/M9Wp9dJOndo1/
 1BbA==
X-Gm-Message-State: AOJu0Yzp+M+nMMmNSIeudRAyFpxW2j6+g4PmmU8L/KNC9+0oBUh7yL22
 y3ml0gclcYQufXZ1VkhMGM+AvMm4gDahqgr0PvyaAgpPWf4=
X-Google-Smtp-Source: AGHT+IFZRPNd6vYWn+V8nQQcMPNbX59XY8ZFbcf5C39ciL/oG9W1zya/9CBGPxKw3+Z4R4vPPtcMFw==
X-Received: by 2002:ac2:5b9b:0:b0:50e:71d4:c76d with SMTP id
 o27-20020ac25b9b000000b0050e71d4c76dmr1829016lfn.109.1703605742305; 
 Tue, 26 Dec 2023 07:49:02 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:49:02 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv3 8/8] Makefile: add dtbs to clean
Date: Tue, 26 Dec 2023 21:46:19 +0600
Message-Id: <20231226154619.5071-9-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
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

CI test checks that generated dtb has to be cleaned up.
Use the same clean procedure as Linux top level Makefile has.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 220411a293..b443831a93 100644
--- a/Makefile
+++ b/Makefile
@@ -2195,6 +2195,8 @@ clean: $(clean-dirs)
 	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
 		\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '*.ko.*' -o -name '*.su' -o -name '*.pyc' \
+		-o -name '*.dtb' -o -name '*.dtbo' \
+		-o -name '*.dtb.S' -o -name '*.dtbo.S' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
-- 
2.30.2

