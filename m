Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2DBC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 833D38078B;
	Wed, 22 Jan 2025 16:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jk5FaL84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6E980812; Wed, 22 Jan 2025 16:03:07 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB26480763
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso10862890a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737558184; x=1738162984; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ehnRpAXquS9xhsD6lJP9lE4qllrXdqpurU30qAl0viE=;
 b=jk5FaL84mMTK3dAVipfTrze+IiJB+csGIxRulqjeCOSM/i3CWtJNGs1iNzQZjX325n
 FQtwllCDgsSPP3Uy5YE+LsStLTHCBRRG/pTSBZ0kAdZvnrQfwJHfPlVxk9CJhRPj0AUS
 KhN0A7CQu0Wj2t1DzOtGDVRNPQ6k+P3TIyq5NxdJ+0TH4hVk3/ao8vAbMVcth8vGMh9A
 sm4uQY+vmFlNL7qorXS/UuG06A1u7Bao0x7TsGBVSVhfYYHK7by/u6ZbnrevO5OJ/pOw
 bHUPjfuqWkyZr7+VaLuM8HmIPyOySB+NGNbl1KXetPU6ro03jxIM/G0LOyrJUQEvRDK8
 ePAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737558184; x=1738162984;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehnRpAXquS9xhsD6lJP9lE4qllrXdqpurU30qAl0viE=;
 b=CTA1j/QqnNdVM9JOMxYPVA1N3AXlaH/y9N7ZNGn8qmMSTuXe2FBmoZNM8Fjuwwhts7
 icSZlETspxnAPxFEJXWg6fqbNyQ7/rUccgAcsEMpkKgcstwoQAnCEPWaPXeLNMLSjSl/
 IvSdv+YEuTcXIpdxVbXxxYIwMZKp6eFVCPCu1GqOYQ+2MUbGmMu8mSKl4zkyNpIooWaN
 5DCZNmZxF3axRL2pFvDcVbSBkY4U8MEhL7NUry044ISngcgUvpdWG+Xe3/o9brsYbpWH
 7MM5dy5N2KefvtaNw5jTroyXVh2bTG6ShkO9v4uGJ+wGNO3mFV0GZ0OITtFpma96ZFFZ
 FH5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8jKhwW1/OC9NwR9UaO+sE+WE2qax6J+LutJZSk1A4tk19q3yy3KvyP+XUa1vnVG6WC7o8ZlI=@lists.denx.de
X-Gm-Message-State: AOJu0YxAfLL6KDy6rNaRpSZSra1xx6/VhKWUYA81flPEcoeDdmm4uD2+
 B9rlPxmF9lTMTVFxc6B5v4/p7S09D9DPKeUUbC0fjwjSIZvXgf51QSNS69youcE=
X-Gm-Gg: ASbGncuW6Yl8BSTzOzXeTIbqQ2huL1Tt9JvZaKHoIaTdZOMHz3/oabkse907yVAofLO
 JXwkOj+Y9c2/1OCNBCMhb+inaxahyxsFCryZ7avtVBXJ0i+qV4AY+sqMKQXGUcxfTwisL0BkKEq
 enT4Q8ilshlS2dVokOEveIez0HqBZpPZyiwnHhFgvs/nDbj5+dvlpfBbnUoVaE+AOGUIVJpXjRp
 gZiBopjDn+OGAXUmMkhjq795RdTUKPpjOlI0rT/il0ShV8wRynhiKeQnFBy4gv//PTescpLx/C4
 SaEMGJrWDmWP
X-Google-Smtp-Source: AGHT+IHb1xAODS7smhKT/lhY+w02ci775nDMjNO9dxJMtGpx0k/psF9I0EgDGS4q+9Fv6tMQRgxhfw==
X-Received: by 2002:a17:906:cf85:b0:ab6:36fd:1c8f with SMTP id
 a640c23a62f3a-ab636fd22c0mr900971266b.39.1737558184004; 
 Wed, 22 Jan 2025 07:03:04 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223fesm930214166b.105.2025.01.22.07.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 07:03:03 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] Snapdragon SC7280 pinctrl
Date: Wed, 22 Jan 2025 16:02:50 +0100
Message-Id: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoIkWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMj3YLMvOSSohzd4mRzIwsD3cQUS4PkxKRES0MTUyWgpoKi1LTMCrC
 B0bG1tQB8PLqfYAAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Markus Bauer <Markus.Bauer2@tria-technologies.com>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=614;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Yshr0fOJ9DLOZZmJfaptO31d+puJlPybKvrAhW0cnlQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvSJHMs4dywJ0717d7euxf+6TS8P5k/qMVSY/FXmy8Yrz
 /e8szk2oaOUhUGQg0FWTJFF/MQyy6a1l+01ti+4ADOHlQlkCAMXpwBcxJHhn/aGVWYv7mlcv3Ve
 YoLwYb3oKZOfL076sNhrS0fkE/1gxR6G/xXmumq5Itc9fmhcv7rOZo/o4Tn7RNYyzdHLOzTh/LK
 /zLEA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Introduce and enable pinctrl support for SC7280 and QCM6490, similarly
to other platforms.

This was missed during RB3 Gen 2 bringup.

---
Caleb Connolly (2):
      pinctrl: qcom: add sc7280 pinctrl driver
      qcom_defconfig: enable PINCTRL_QCOM_SC7280

 configs/qcom_defconfig                |   1 +
 drivers/pinctrl/qcom/Kconfig          |   7 +++
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7280.c | 106 ++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)
---
base-commit: 639cd409987acf173eaffebe7876968b42fd7c32

// Caleb (they/them)

