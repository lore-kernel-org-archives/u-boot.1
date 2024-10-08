Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD080CEFC30
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 16:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A50688D9E;
	Tue,  8 Oct 2024 18:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IqPIK0DK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF4A88C63; Tue,  8 Oct 2024 18:23:51 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D75E888D9E
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 18:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43056d99a5aso3921135e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728404627; x=1729009427; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a7OGYqGu5EZtnsKA8EOPjldtYVA6bSkYUKohrOQPTGg=;
 b=IqPIK0DK0tm+o3qjWjiwtN5ZO7ZL65BdyZYFlnATqtUnJOFDJ4ZsE2ioqhnu8cODGH
 Caj0/xa48YYiP06KKIecwUHjOZy2jaBIMBmetIjKrK4VIUFvaOcgE4T+exmhGvLJ2YC9
 m3QgeGYxuFav/BBUCH5gBG7H52cd+EK6sRKFLNYyXJIfYjhxG7oG2xSV6PcFn2PmlJGt
 EuKA+Dhsp7uLnv7QXvdnnjp2HWfB8owaT+7ltwwAmnF35F3ytsaW0qQJ0hm0f8y9Pj3g
 EVDKNc0fCXPsgjR2tgB38f2XHGJHlaQKytqFs3mcLfvYaz8Vj9Vt3ymuEAUgqj2v6wOA
 4o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728404627; x=1729009427;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a7OGYqGu5EZtnsKA8EOPjldtYVA6bSkYUKohrOQPTGg=;
 b=XpYmvCYFy/rElkuDusxq/6Xhd8SFjJpv3yoWNS35c5rui2lGpdsqIrxG4vejyRfw1x
 lGvQUQ3jYmPzCW6yEu/iXc6QP+L/AcU2Sj9B2yOQ4ENnaCkLv/nzgve7QSraid8OQ5lC
 ILuEgyKw3+0nwZQXp39N2gnz4wZSkL32XwRbwLgWKaO1Rk0Cop3clcUjB2pziivslyh0
 YHoGz0Y+OZp7mLyEOZtbRrPu8K69rlhT2+GwsQB683O3yDZFWfjOjLj91exuvet2n8uR
 wBaNtJShABUEGIOI/BVp+Jvf2/QpWy9phBSUNMRdsw7f6KZBeBTLZ3JtzTrzoN0dlMDi
 fs9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKlytZStWbGcLvlx9WDdH8EcQKl2zdPKnY+hZXknDXT0DmWnJc/Sz65zPZ9BWbAgMoHt9Pk6A=@lists.denx.de
X-Gm-Message-State: AOJu0Yyej4mHI8PRXO8K5MCgZZftnp/I98e+C/1US8zdj7fCFpzkVNRy
 8rEv+EbVomDA0OODQ67dwQQBghOAPzeGEaKyS1e/BWr/zPI0iF+unI7K0CW3VWU=
X-Google-Smtp-Source: AGHT+IFcbE8qdwlN5iQXHW4F0szPzEucIVp7WUWHzd+M9Hw4IS0IWTZA5wocptODo3G83so661qNmA==
X-Received: by 2002:a05:600c:5104:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-42f94b71121mr24737175e9.0.1728404627134; 
 Tue, 08 Oct 2024 09:23:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e89b42sm112810205e9.13.2024.10.08.09.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 09:23:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Oct 2024 18:23:42 +0200
Subject: [PATCH] dts: meson-g12-common-u-boot: do not disable canvas
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-u-boot-topic-g12-do-not-disable-canvas-v1-1-b89659370012@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI1cBWcC/x2NMQrDMAwAvxI0V2CbDmm+EjLItpwKghWsNBRC/
 l7T8W64u8C4CRtMwwWNTzHR2sE/Bkhvqiuj5M4QXHh650b8YFQ98NBdEq4+YFasXWQxihtjonq
 SISd2r+JHjlSgx/bGRb7/0bzc9w9/xlqveAAAAA==
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=w5EYAVkbofpjTS78oTwVI+hLmHoyio61nDbw2Z4MH+8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBVyRSzo2sjPxK6urSmcBDnsevue7ah4auY8yYUUu
 o9srrEuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwVckQAKCRB33NvayMhJ0U51D/
 0VVgMK+OjtJSL6Jvf3M/M1v4HGhYjCXvIfuni6imgaM+hmPJJYEk+P1N8w6WmuvVcYurM6C+wLE3za
 s+p+4YcwFVPi706OdzKdUQPCPexE7q1FyuUw8EeAhZkYG4TJQfcCn1BfJb7XzETKLP+No59N1Egehd
 8YAKNL56kEbC1yMX6FgSz6csFiFxZZe9pDz+RprzfbLTszkxGrTIYKDzlOb3aSO8WzS2ljkt4KtZYK
 krI/jtpnkgZmUCFo4MG4NUIPLmPfcuIqc91ZB3+fGpd1cSp3goVdxK2cXkIV9sR5H0eIm6dMuYvivt
 6/3+cenazhW+nOf+a5/O8qtGlXhV1Tbst7Jp1bWxqrEBEjwS8nGFOn4+NMfiXE3SU5m7aaxXTBW2L2
 FVj2+1phpOGVi79cY1kJ5VhxPDI5LMw4MibiTgABPTFxT3Zpt18LoJUpJ+ukvhgEiWEiZiSNkRQcbI
 6qfQXbZJsVzc3GhAMtLSXLXMA/XmQxWqZb9UVG7Qz3s3BuQiCzGKpnM6T0S0Kd0wdsAatYQkCFKPVg
 FgjTPECwtFUNOvpS55jNpGC7YKA1CPmXVa1zoeHM4e/WVZ6O38qEcbru6KlkXX//Qf7kKbZN+A5HyR
 MMm3OojDPk4Z8gIHINK4QVd3RGgU32INBXbqg6zG7iYm/UikS2jX1PwdNh4g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

We were disabling canvas, which causes meson vpu probe failure,
just stop and leave canvas alone.

Fixes: ce9fa7bffc5 ("ARM: dts: meson-g12a: add U-Boot specific DT for graphics")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/dts/meson-g12-common-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/meson-g12-common-u-boot.dtsi b/arch/arm/dts/meson-g12-common-u-boot.dtsi
index 8070b62af5b..6629f3256a8 100644
--- a/arch/arm/dts/meson-g12-common-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12-common-u-boot.dtsi
@@ -17,10 +17,6 @@
 	};
 };
 
-&canvas {
-	status = "disabled";
-};
-
 &vpu {
 	reg = <0x0 0xff900000 0x0 0x100000>,
 	      <0x0 0xff63c000 0x0 0x1000>,

---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241008-u-boot-topic-g12-do-not-disable-canvas-ece09f18ebaf

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

