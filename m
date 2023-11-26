Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD92C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 22:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D29874E4;
	Sun, 26 Nov 2023 23:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="NmAGLWJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E64887474; Sun, 26 Nov 2023 23:09:53 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8218C874C3
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 23:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b397793aaso13665155e9.0
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701036588; x=1701641388;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbEHkc5D4+vXq0WV/czvuLKP20zxjbJLqpyEIdhbGMQ=;
 b=NmAGLWJgpyiVv1/mdk4+D8KKIHQ0SjQ8aOS6nIWKhESVFFzBRIVaTr1qREX0ZHYxsk
 yyV8uXtauXTegaMQBx0xYvZHVUwrr0tEJR7HsQ+E2ykMr9pPnPqt/+LLTGTbv86M3HIM
 qSr6VgYUiKp8ruObAViob0B+WNmCRcxsPdr25Mz8/6zdcY7g/pk3Q09o4NG7fkeYfgjv
 7FwCGYdiK6lJjhW91G4dRfOLBHqbaePolY3J2FmWHWIbBMhdKMeBenZfEqjwJaxMjoAA
 4B4Hff1QtHMXWE7cwbw9NFfXEqmyQ0zU7DkfsR8Dv3QTD60v0yNfUBNS0IvnE+KlGEYe
 W46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701036588; x=1701641388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbEHkc5D4+vXq0WV/czvuLKP20zxjbJLqpyEIdhbGMQ=;
 b=VTEPdhCRFOhLG41sfA3KJBCbcmki9VCO3MHiDMy9jM5YfD1kRsjjBASjADHWOTDqBq
 VLxT3UW9yOoO5DJLb8OecsH0w28TxtidRV4zj8s713HfEgLhJOoibmeI1Ylbx4zlSjcf
 N6vghvdoit38hnrbaz/iJjyzaSWmOWwE7wK4wC6dqr22fD9w2h6cL553HqG8IhMxbz/P
 oItD54vRbJzT8dPfshdNV9OjANduZIEE82jYASNrcMHs7X1DgiLs0K0FpAtdWt89+LyG
 +HSM4yGVQUwSVrQFCK0RThjpBF1IcCpdDbhgrP/zp//Zid7Rzs1djaJOhGLNAVqgO3BG
 XMxg==
X-Gm-Message-State: AOJu0YxbyGiQGTSlSn258pDPpVY5tiT1wdbMV1P7GPP0mLBdConSn8B8
 zGDiLGhjmO+OBUi0vu6Va4sq5fn1ErY7tv3WMVYApDMZ
X-Google-Smtp-Source: AGHT+IGN3IPEV7k+ef4ln2lG75EGFCX4AWJ/Q5PlMvE393DK+y6sPLEm2THDWsMFOZdgpMYYTSXLbA==
X-Received: by 2002:a05:600c:4695:b0:3ff:516b:5c4c with SMTP id
 p21-20020a05600c469500b003ff516b5c4cmr8303566wmo.18.1701036588637; 
 Sun, 26 Nov 2023 14:09:48 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c1d9000b0040b3e3eaad0sm6471126wms.41.2023.11.26.14.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 14:09:48 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 3/3] defconfig: rockpro64: Enable SF EFI var store
Date: Sun, 26 Nov 2023 22:08:36 +0000
Message-Id: <20231126220836.374956-4-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126220836.374956-1-i@shantur.com>
References: <20231126220836.374956-1-i@shantur.com>
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

RockPro64 uses SPI Flash for storing env, also use it store
EFI variables.

Signed-off-by: Shantur Rathore <i@shantur.com>
---

 configs/rockpro64-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 4cd6b76665..f550f2ae43 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -8,6 +8,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_EFI_VARIABLE_SF_STORE=y
+CONFIG_EFI_VARIABLE_SF_OFFSET=0x7D0000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rockpro64"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
-- 
2.40.1

