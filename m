Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C6FC77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 15:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DB382D5E;
	Tue, 24 Jun 2025 17:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="o+6tOxjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0481282E27; Tue, 24 Jun 2025 17:35:15 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F1182C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 17:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6A13A3F27F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750779312;
 bh=I9g++9CCr1FGr86zb43DRETQIrSjoHg62WfIUGA9VMg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=o+6tOxjNUyyYHW9POX4pbu4+4rDd84i4bLGw1k6HeJ86pMuc8Hc9uKdrY0ZB59gqn
 r/6wSiG3uYGYxqRrWi8zEPvOqIiUM2mN3oAbcqhNSxBOqzwbcTF8NXe5AQQWM7J/t3
 V6CFB04xZ2qMvH5BgdmMPHC2wRFsJfDvK+GuIMrg9lIwizwK3bzxLasGaG0P1CaByr
 xG15BaFmD5dxM+jcfMLp/RcmCPngmii6dZU+4NKZkoKFgNr/w+bTXzKyhJrZCl3T2w
 orQQybX+6qFHek6kBzS1XysOCUn1li3T7HADINq5SPK5q3WX15ItO/l0JLAZ8ViTQ2
 O7BNYVLfDZTyA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a578958000so2047392f8f.3
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 08:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750779308; x=1751384108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9g++9CCr1FGr86zb43DRETQIrSjoHg62WfIUGA9VMg=;
 b=Me6XRM6WoezpupSamQ29GvmGmIzhFhMYjc90RdbeX5uZf7a+eXIviIlG3FdZnk6wVU
 c6ORSQV8TJmTKCwLPv5gXnTS0Kwl8oDRVG1WAmzl0gSkxsBUYP7CjeES07i3/OtiL93h
 Cl80f95PXPfJ4cH7K8uEYd5i3hReJprk/NKI4kOKgdWEamJUOfodhGbMvH5+DeL4A8pi
 hjOkMqILmj8F0f0S9mKo60AQC7KKegFp4tCjB/2PWycyQ/TgYzcELvQfytOZvFzSESNm
 xbrwnM5aJIac6qZVl+ZMNdxW+X4kFzxRxUiPFEFHogjmvexvuC6lVI/H97Eqjn9jOFiu
 fHag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSnRN2iLwqMgZEabdhgN29z0Hdwf+eIpX5pRiiAFcLuDXuzJRExtw6UC9URTPvwFLdE5RTSxk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1Pj79d3YB2oFI+3Bq8mrwHvRBHV5I9mbh317PEve91d6hC+Qs
 ONKbi1UmvJeIMp7Ru4j7vfzxS+io3s0eR3xLerpXIFLNcHAR2lw3jsOWjIqwJIEvNxUZLLO1ACR
 GJ9MECU/p5D6ifaQZpgNgjAoPdz4mSsQwUm/sayM9f/rzLRWAr7FVf+iP6oXM/yOA8H5msPM=
X-Gm-Gg: ASbGnctzbDVADzoVqW91BKdi/+mRptktmv83ac2V3R5ozPSdyBD2n5bJHVdPssoDiV8
 vq9yfCgRvNSzP+YngYI3LxA9GNHThsEdfpoplymGLE5c11KPLhTDEUk4UbBpAsYwvaghTmQlG+a
 u4GKG8a4TgpMrpFibT2zifTuCcop2ed9tKez3poKsJ2nThvgBl28QytSJoLqUt+9TRItUlwO3Cg
 JUEH4KH+QhnmKYETaFenFsFbczYFz7Eos4/J5DebaQRb9FZqPx8zRMrDOMaODzjtsO3ZYQSo2zU
 VgOwx6gDOmpVuSq4h1fJdRHL9w3yjOf2U9r8gLm8GimiAtzczaZU11cg
X-Received: by 2002:a05:6000:144e:b0:3a5:2f23:3780 with SMTP id
 ffacd0b85a97d-3a6d129e038mr14075002f8f.18.1750779307932; 
 Tue, 24 Jun 2025 08:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr5ziET3OuA7Ee75zkc40lMBx6Rz+GDCzzG+IKPvpLXE3z58tBd+0xqRZ97FfdycbfjD2+VA==
X-Received: by 2002:a05:6000:144e:b0:3a5:2f23:3780 with SMTP id
 ffacd0b85a97d-3a6d129e038mr14074979f8f.18.1750779307551; 
 Tue, 24 Jun 2025 08:35:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:9801:7335:789f:7f15:8b3b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8113b00sm2277019f8f.96.2025.06.24.08.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 08:35:06 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] common/spl: Revert fix potential out of buffer access in
 spl_fit_get_image_name function
Date: Tue, 24 Jun 2025 17:34:30 +0200
Message-ID: <20250624153431.46986-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
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

The change in commit 3704b888a4ca ("common/spl: fix potential out of buffer
access in spl_fit_get_image_name function") led to function
spl_fit_get_image_name() no longer detecting if a property does not exist
at a non-zero buffer.

Link: https://lore.kernel.org/u-boot/38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de/T/#m59f3a23e675daa992c28d12236de71cae2ca2bb9
Fixes: 3704b888a4ca ("common/spl: fix potential out of buffer access in spl_fit_get_image_name function")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/spl/spl_fit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index b3824af475f..e250c11ebbd 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -86,12 +86,11 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
 
 	str = name;
 	for (i = 0; i < index; i++) {
-		str = memchr(str, '\0', name + len - str);
-		if (!str) {
+		str = strchr(str, '\0') + 1;
+		if (!str || (str - name >= len)) {
 			found = false;
 			break;
 		}
-		str++;
 	}
 
 	if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {
-- 
2.48.1

