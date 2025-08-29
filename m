Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34760C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B5BF83622;
	Fri, 29 Aug 2025 10:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ymAPHjj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4185683621; Fri, 29 Aug 2025 10:16:51 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C22835C7
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b7e69570bso4619785e9.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455409; x=1757060209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpQbMYELfA70OkGS5PhCabcYe9TWQ7O1IluSRYEHDpQ=;
 b=ymAPHjj2rUnPHmu25Wz09y6Mcup0Q1z5IS66diKK81aR/NEzvdZjJhb3K+NO+rAjGq
 RFuasTJqYtZbYqKxiSEAR1ic/gUlURqbT+Ybhw89VHonA1+lHPUGspzdtFRSw30XAoYt
 v+9R7snoCDvazcex4JsNEug0/Zk1vrjmjiXiphFoDn0VyWi2dhUbGZ2vQ0NI6Kfy6kUu
 PWD6v70LCTyzD3pVy2P1YOT2q1hc1+ZOVXM3c7XR1T+WjO2tkQY/preuwlwTmv37LHes
 BuIomYj6zKxo95ewGEEyktRqO0UrGX0/cvLXAHwo/hOgZPuWLxO37h1H3IJNG24I/1J8
 x8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455409; x=1757060209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpQbMYELfA70OkGS5PhCabcYe9TWQ7O1IluSRYEHDpQ=;
 b=T7vI1uSN53UjCzsKNNlGZZmRMbHMW9eCL0rsRyvymfbyNBJYD+kLtQkx4b21yn/qOH
 SPRsxZ2zPLxBVdHe0wkqNAvzvjl2N8UdebBaJl3ajRR8JOxSsDD/hStzFCnPGjde5Iwd
 wWsVs0DLrs4U4a1bu1OtRpGMrqBoXU0qGodu45eGYxcbqryjwfTsDSKIzzswZGu4hLN5
 85VIa/0Wvv8OGkav74F0jMJS9zPNcbEBPpDjH5agaUm8cYWkbnD85+15bP6oZgPL7PpJ
 3pmRzoryQ8rvCskT+PlfPYVVeWfoAdTxfmPErPB1gt2NFfIAm+HLPHd01MLNSL8rax0g
 9uxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd4DmrU7RldCkgiqkkRiSlTFBdbrbt6tPOisNRloaEQXZ0dIRbfpKcezia0h/YB0e25jiYWj0=@lists.denx.de
X-Gm-Message-State: AOJu0YxK+u+UUkbaIZP+dWvOywRl4zrORNE14KhUw8HuAzTWwQsKf4mv
 iCqHDXQhuX9ZyA9pMquYXHcErONQiDLQrsv6OdmMWMtOso1l9z5EDsjv/Tv1Je/ynrk=
X-Gm-Gg: ASbGncujoodeopsMmawHsT4E6/D+DXNsh/c8bw78DtCkkJYA/HFBJjRDCgroyEdhI2U
 DzFddSd4j4lIpdX1l73XPZWXQPX/G1uO5PMeYGMuzkYSEUDusGl5g2b15qLeZe7wDzPVzr/YeHn
 j7XsvV2AxQc2HkIzeEGsANgo9oSGJLyiXA/tTfVBqC7ToeAR1sgoeO9rrWf3/KuxtaQ7Iq8VMbE
 HiMHNPJ1wOHAMjbHxF4zFIzXz6STz0OZUCBB6GKKZT89EiAdZ4nlpeOCVIg/TU+5brLiGXa7hN5
 KZqyVUZYR6ukePf0a0MYnqDe8XTWAgy2XObzoFRum0grAfK14gkjCAa0cwAjfARWJxT6B6LIEbv
 Lnue105Llk3TW94+K1Hd+7f/reJz3Fkjiznoj7Jw5wGDaognJXfNIY2to9oDwPWVbQw+U8Y0Bqx
 0erTV8BMtw4CPCaRSzeAcQblDGF9RzPYJJcRZK2jVmUK2pJqYu/j81ag4tEy6tuyEwhmZMRCUiY
 gj5UFWZfP7kX098xW4IcBr4LqSOK2bacaI=
X-Google-Smtp-Source: AGHT+IHN/zPZdAqkBSbqjXg0QX2umWlrgzfhQ7XVmXxqamU4a8HBeJ6m09I8Gqg+hD3cue6E3gLDLw==
X-Received: by 2002:a05:600c:3589:b0:45b:765a:a8ff with SMTP id
 5b1f17b1804b1-45b765aaa1emr48554765e9.11.1756455408586; 
 Fri, 29 Aug 2025 01:16:48 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm2449008f8f.12.2025.08.29.01.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:16:48 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Yifeng Zhao <yifeng.zhao@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 u-boot@lists.denx.de
Subject: [PATCH 4/8] tools: rkcommon: Mark rkcommon_is_header_v2() as static
Date: Fri, 29 Aug 2025 11:16:18 +0300
Message-ID: <20250829081628.2327372-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
References: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
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

The function is only used locally. Enabling -Wmissing-prototypes
triggers a warning. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/rkcommon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index a0caa029cc04..d191ea72c633 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -279,7 +279,7 @@ bool rkcommon_need_rc4_spl(struct image_tool_params *params)
 	return info->spl_rc4;
 }
 
-bool rkcommon_is_header_v2(struct image_tool_params *params)
+static bool rkcommon_is_header_v2(struct image_tool_params *params)
 {
 	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
 
-- 
2.50.1

