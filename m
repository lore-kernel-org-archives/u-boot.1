Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAD4C25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1678824B;
	Mon, 27 May 2024 19:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MwVlPRHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3748837D; Mon, 27 May 2024 19:18:01 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF11883A7
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5dcb5a0db4so764166b.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830279; x=1717435079; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HdY/KRsi3dVlIZusk479FdyYE2jpaJHVs9ewzf9en8E=;
 b=MwVlPRHfU9X/hHi3fiJ0uNuVA92bMFoLBrypWjVEyFsx8aPxt+Aqw54LWJ15h2yq0x
 seX7uNw+vvkWI5+aVcTyyBIObOtNBsgGuLyk6MR8h0NRZsxOrkOabdT0tEBYXiMUAeia
 VZNVDB5yCfNwxP1QZh44+iD98RVhEPPy1HCppQwMWzZ55OpoqSdkcPfvCOwlU9xoMUhD
 69/pznoyeqUFSw+FuWE/XXy1nc49D1PvyTk88RKJrBVjhk5L5wwdB2U9i7Gu4/5NG6yL
 fcoBDC2slKeyfnqWtXXKZe6s841NTr+BnvHPGpA5NB8kX9PmUYQJtX5xlmIewBHXxMRg
 gOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830279; x=1717435079;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdY/KRsi3dVlIZusk479FdyYE2jpaJHVs9ewzf9en8E=;
 b=A1G4PBmzzUyIUDHXEFbcw6lyEEOAzYG6rUtstkwTNo8IBiHAokGN6Nrp0OBdT0aaXu
 N3XvOHXlQB5g2DU3L6wFCHKWqqFbb2c66MPuiZQ6Z2BfkyU0X0hzdIZh5lpiFq3cgGtk
 OI9arZmE14vKfUOzputa9d/tBZivEW84jRn3g0bgV5UCm05P8QwZtDpYAEUjEy6DNLDv
 IORfJ3DCJNns9al+4F+fTSw6hu1J3cwrTS7LarAAxsvlvRhXv0GwPoUaQDss14QNdxk7
 bCgBho+yZdbusGzA1pYD86hCqK3BlGUQ19vyb4WqwWoPAmyN5wLAMPt8eqwXYin2scFP
 VE8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW93sLzOhWmxfKH4IbsSFYv5olm4FIev1FlD7uHyu2ZpOCFts+uHSu1CEdzfdEjgygstr3U6qElHqQ/sxi/V2SCppecAA==
X-Gm-Message-State: AOJu0YzOtOgZc+yyp/8N6sRvc2+BW5c8qlW2SH3GWRWU2Zk8qExOlJ+k
 mPVR1t+8sNGat12HSA9SOzfmXMh80wITmF2KOTvyE8B7+JiOzmwF1lbMgWUWqXw=
X-Google-Smtp-Source: AGHT+IFfPM7/UuDwwTk71/5oYXDAHOY4cdYGkZ0KVl2lALvpF3jzsOViXtYuNpjJgJJyRaxzHheg6w==
X-Received: by 2002:a17:906:68c6:b0:a59:a7b7:2b9e with SMTP id
 a640c23a62f3a-a62641aaefdmr559239566b.8.1716830279461; 
 Mon, 27 May 2024 10:17:59 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b874sm509469266b.163.2024.05.27.10.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:17:58 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:17:55 +0200
Subject: [PATCH v2 7/8] mach-snapdragon: bump up heap size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-qcom-capsule-updates-v2-7-47583d7ad428@linaro.org>
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=P6SpwaCCPSCMWCbOveOVcwb/sHGrgjoIg93D2sF3FYk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVMA+HU6JWxPOpKiXyhPIb/kUbHFsP+Z+V5jyC
 O+zjk/fZrCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlTAPgAKCRAFgzErGV9k
 tuD3D/9BLkwSAwv0qmYmrwERtqyncMGHBhwUiHB4tVPE+4wIzRCAbjwlt2R0lBjdOvCEXrAg+db
 UmMPBKs5WfxOPMho/5sy7wA0X1S0M2OJUkJCQumme1086Eau+oEOVQcF/jAyadApdB4AU2Nej3/
 t31q54IgQwFMqkQmZuEUO4Id/xvGogT4p/sE6MCPwRpc03IZNaR8qjFid8bGlVlYFSvfLar4Wm3
 YwMvML5nqxXy6SdMzP8oLxYAUfpozagVrAxpOQASVdZxlyVHZxZwBjDgaAVIvME/56mFCYIlIAi
 5jKOi001hZeHp8vCC7PGuqsIc8jWwnuauL8bp/sMYRqIy5aY2/n6duCoowpLBvsovn/141q1at1
 BEn2ebS+J2ylSfHFUEtLQMyE9SPvplrHTzx5QCgY8iqr/6CUyy+BZRvBTLtVhdogaNyTy2dMKIa
 tOP4wsXz9Rwstm+SsNmrqx7phfNkAHDGlnj4lsM0cZD0tL+Gftlhxkpbh4J5qPX38mL5I2NjQvy
 Q5Z22eprwyVW3BjeDVEyRoOSrHkEMJWKZMVF4BVfaHTEIMHLRdoa1Obe75f20UEC4TZpIneprLz
 GA/eFwbyiLPMHTZo7DjjY2LT1PkxoCFTjnpibeNzhAl6E8ElyHuTYbAlthTcflvjSZeNrk9TWp+
 L5/f/FqvGAQI+yw==
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

For capsule updates we need more heap space for the DFU buffer. Give
ourselves a whole 8MiB!

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 536960b83c3b..5023c906bed8 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -10,8 +10,11 @@ config SYS_VENDOR
 	  Allows to specify vendor for the Snapdragon SoCs based boards.
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
 	  will be used as the custom board directory.
 
+config SYS_MALLOC_LEN
+	default 0x800000
+
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
 config SPL_SYS_MALLOC_F

-- 
2.45.0

