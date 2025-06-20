Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E214C71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 15:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9527282CBC;
	Fri, 20 Jun 2025 17:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OLBbwN12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E48582DBC; Fri, 20 Jun 2025 17:11:04 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7531D80E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 17:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4a43e277198so11236361cf.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750432260; x=1751037060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pegDBeCNSoCSbW5NSHd4sQc164bcthrgdNfjnhRg7kk=;
 b=OLBbwN12tttMPTJr/tGSWafm1w3BYF3opKg14/ZJGfBe47p+aZBe4E8M9DKAgoM/yE
 O4U4Ko55WbSNfveSium/xegBeAftOIfFHk840ue3x7Yom5gk58z0hTaScK6u6rfQnm7H
 OmbvTQmxdY9FVm8ie6vyO+2jx0MBneAUmCdaYuR4fMK0r36BycVVkpXb0No3yM6BWJD7
 QG6r0G83g6yIa5aGawzZTVyF2MSIdTCBjCB4IpURZ9akqPBEqjMzQF+spw22Ku60rZz7
 1+DZXP2bswvM/Dt4nFupNnmCrQiRgOgt7gqAtsWQ84J1ykmIh5cMncrQdP4aMI2xbZi4
 xy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750432260; x=1751037060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pegDBeCNSoCSbW5NSHd4sQc164bcthrgdNfjnhRg7kk=;
 b=UbgsBgGgl8fR5c4dMGPQC2HI9J6eoieSfS6FRAAYuJ3dk409u/bxNj9TWTV2qGc/Vx
 adaNT4PiMpUwPtDN/srNKcvSHrMozSxpuFYQUD1gXn/0v2rWM6Ag1E+mDAqi1VqLOkVr
 gs+fs7hrcYFtkILHrZ+cfXJwTldxCLezaMymhUH53wL2dQv0TeRFlpY6YS6igE+v5E1D
 1SnDCplSYuhBweFwbI+O17M7UXQ25yUa1iVpXw5AkGF2J7g6K3MGdILPz50EEpOPE6dn
 zblocS/wITAbpO0iaeWIMUQ9hzgDr3LmWA9mEKM6aW52u8MBkTBs1HDcqx7jlRE8NhbK
 Eang==
X-Gm-Message-State: AOJu0YyszElV9VHBOvJ163OamwireZe+aPMEyZiDQFA6HKaCoC7C56Z8
 gcsCsRgO5BOL7uToZcEqVs6AiaAnmn/MZHXRa2ZokJymuA7e8HllVo3sjtUOTikHbG+b7xE+244
 9uORt
X-Gm-Gg: ASbGncvBRGJtmb19h4GxrGqZQPwLmK/Ye1adxM6yKFfWG9zDHUs1FyhlgQ0cpRwSsL0
 AYYL2VWYX/tAgHGwGZO3gMGvgYwUrd6oWjvi6IzKko/1PjjWmt5iso0avqpjvXSIjvIWuMDDK6+
 LANPhKzSGz+gUSGwhRGj5l+Xijp0S1AdkLW+iKL1eb/dkMc9Tp3ywgI+b0xM+ELGqlp61oHmd1e
 QXQCHVFmAA3NqHIayA3GeqTYT7byL1zXqNvZ3fn0IeigqtMwdFmBi/Tl3t4XYClcU9+uIZPo2Eq
 A4++HPwcoA8f7gWtXS8cxy7zMLuI+7bNh8V2FJhIm7E2s+mhBh19XfVb0UL/qPqhIcQIu33ExQ8
 0pFoYKUNPBLlQXJ6ASUkC3xo9WFnudPwqk2wwRaw5dGQSY33/YhIdGeLYbg==
X-Google-Smtp-Source: AGHT+IFnwGoMkKqX862tXlq1Qw/iXG06NrhAf6Sk+AEX9bwIbzPrzSP9Wi9yhR2p4KSsTLFu616x6g==
X-Received: by 2002:a05:622a:10f:b0:48e:ef59:db50 with SMTP id
 d75a77b69052e-4a77a25f216mr53301771cf.31.1750432260345; 
 Fri, 20 Jun 2025 08:11:00 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3f99fc0a8sm99405085a.80.2025.06.20.08.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 08:10:59 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 3/3] MAINTAINERS: Add myself into the list for MbedTLS
Date: Fri, 20 Jun 2025 08:10:10 -0700
Message-Id: <20250620151021.2711542-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250620151021.2711542-1-raymond.mao@linaro.org>
References: <20250620151021.2711542-1-raymond.mao@linaro.org>
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

Add myself into the list for MbedTLS.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..d52624342f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1282,6 +1282,11 @@ T:	git git://github.com/ARM-software/u-boot.git
 F:	drivers/video/mali_dp.c
 F:	drivers/i2c/i2c-versatile.c
 
+MBEDTLS
+M:	Raymond Mao <raymond.mao@linaro.org>
+S:	Maintained
+F:	lib/mbedtls/
+
 MEMBUF
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-- 
2.25.1

