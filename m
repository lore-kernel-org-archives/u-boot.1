Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B020C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FF186986;
	Mon, 14 Aug 2023 23:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M7Dw9ODK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF73384788; Mon, 14 Aug 2023 23:56:22 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5000869A4
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso21153715ad.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050176; x=1692654976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhI1mMRqdntfAiCbrQ0RQ38YBFxa9z9THd4b258BQ8Y=;
 b=M7Dw9ODKJfWeUAVDFu0pGRZwk4/+Q+u/Hgrf1STX/yBWknukZzW+54CY6hLTza3N5i
 f9tzc5XHSxzrpR8Qu2bi9OXqKM4lUxuekH9zciOuyBXJNmKA8NU1UMSm4F59GoI131l5
 WiF+2yrPaLiOKOVPii1nXs9yS29zg6qL7Qm1sz5Yj8hv+zUAotFCcuEPqwnjd+UwJjia
 Jok8k/ME+klGyCB2WCg42SBuROR1qop4eKi9lDRkkd1pFSqTuE/CeWey/BQbN7Yf+ae2
 b8Q5TLSJOlSlgmNJh6iZC8397hJCQcRPV8M/yhyeKMeEpunG+HS24N/06O9BqtzsX43A
 rxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050176; x=1692654976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhI1mMRqdntfAiCbrQ0RQ38YBFxa9z9THd4b258BQ8Y=;
 b=KSELNmvB5Qvl7c9Bx1crLvdBX2qTSXNQVNyfgge2HQM+hQBmy1DoeUrKD1WXK+yvmH
 UV8qOkQTnaz25RTPpwe8Dq8i3Uko6DtpWLiTrGodMWVqY4qwi/gZGTUbjNcWlWUHWx3e
 OWUvG/xKDxuxYTtVT5jWqLVpjj0Mo5gNQRH2c6D9U2QTjm+n9g3LL4WES25YNDt6/3dc
 TWQyKIs/u/+lpNJPxOHapO1i3FwKE0/eghsCbtsX92N9ZZGGcb70BBkybEt8SVzc5ImO
 VAY/rh3yoZZTqVeYVw4o4WTsiv1F3jO6Zy/UJ92Xev3p9Cr6dHfkUYHD1MlU7L3FuOo8
 AdrQ==
X-Gm-Message-State: AOJu0YwHjfpyYfp/az4RB2UOvPkjnoWp/3HCL32uV5REUNIUPwtUuCLx
 YTUoV48d4tvISoWQBpveEp8iFbw/peCdBJSnt8U=
X-Google-Smtp-Source: AGHT+IEgQqjFMibG9WzTMu35fCPwJkansV1fpHhwEuXYEnJy8Bt25d5ADk9W8POiZ105itrRGd9vYA==
X-Received: by 2002:a17:903:2342:b0:1bc:e6a:205a with SMTP id
 c2-20020a170903234200b001bc0e6a205amr14691334plh.4.1692050175878; 
 Mon, 14 Aug 2023 14:56:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:56:15 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 15/17] configs/dragonboard845c_defconfig: Enable DM_RESET by
 default
Date: Tue, 15 Aug 2023 03:24:55 +0530
Message-Id: <20230814215457.4075025-16-bhupesh.sharma@linaro.org>
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

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 configs/dragonboard845c_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/dragonboard845c_defconfig b/configs/dragonboard845c_defconfig
index a69d82761a..e2676a37b5 100644
--- a/configs/dragonboard845c_defconfig
+++ b/configs/dragonboard845c_defconfig
@@ -4,6 +4,7 @@ CONFIG_COUNTER_FREQUENCY=19000000
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_DEFAULT_DEVICE_TREE="dragonboard845c"
+CONFIG_DM_RESET=y
 CONFIG_TARGET_DRAGONBOARD845C=y
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 845C"
 CONFIG_SYS_LOAD_ADDR=0x80000000
-- 
2.38.1

