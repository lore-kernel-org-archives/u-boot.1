Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E6C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CBB80793;
	Wed, 15 Jan 2025 14:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cS05rW7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5043B806EB; Wed, 15 Jan 2025 11:33:17 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5429F80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so1037266866b.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736937195; x=1737541995; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YwvDyRW3CRzpKu/P9AI/1hV9Th8nYlEc+glsnXx6a1M=;
 b=cS05rW7gCo0EJ+Mepd+qbs1OtMLd3oTCCg/EA1H8kZiB80oAm5rny3YvsbO6AO3hoo
 1JZ9TfYkgdh2Db3y5p+LmmA7h2s6XkpGq/VbmStwRiB7wvHUEGNiEYYw/bbhp4VoruY3
 bgfk/xogfPaljw/r6Om4tY3V+lN9rpp7oiYc26QM3fpxnHM4EMqIjN55gmhuhl88p/Tt
 U7BXHi4djIQRJIYwRDisgRekMn5oUJAWLZ+/WU4R16/XIaFkq24rbkW21nGGcpUXDlm7
 vIFJVFhv/okMrOufcqtVtlBlbtjgWoBdUukxTX4XyQC89EkrQ6Syn5hFba1UUCy0nAgD
 KDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736937195; x=1737541995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwvDyRW3CRzpKu/P9AI/1hV9Th8nYlEc+glsnXx6a1M=;
 b=HnfDU2W3IIlCKu4RlcwFYGwf88Gp5hS1S25nZlYACv39EJa9lI0RqcAyXj2XkTO1FL
 u/RfCacXhJ1GpZo6u0ZUqui4DVbQfGEKlUKCJrdMaRaOkl25lMHL5vtpUQd+jseIN5Nm
 0NjIL4GU53nFksiHn/UYBhVCcnbl97YOfvbLcnV533RP4EqqWs6WXOAi488pTHb4BKU2
 7ONcldjRnx6IIG2bNrYUZKAtp7BZMGKE+f2QOHp/GtZ3PQuKj6+98cQ+6mhUNBaamXcK
 hGYe79hIhORhKEFi+Qsn4eQ5PP/nm0rtekENLKkQc/yZTY9LFj5ZyiP4Fc+c8lkRoJ5N
 GtyA==
X-Gm-Message-State: AOJu0YzTbqW7fc3N4DXtTnDzJf5FTtV7pKg9eJuNVKdRH15T3Nk33tKB
 q4IGCq2JocwivKUn/2UTq1anfLTaGIfth04Aksdo/l42UCpUSP29SztaEebWo7w=
X-Gm-Gg: ASbGncu/2x/j3FWNFuakog2bs2keLgAIZywAzDQa0GV2Nr04H6KEuuAO5ElzbuBKDGJ
 I5nWfGynVGSkJJrLzpwh83ZDVhogTIk108gr3CDCt43WIL1gfaCH90jTxfSngqGMYGuhxarX6Cr
 byx4dEqcW7/sbndMai6ve4EnCHjp+u79HJRGKgB5oAnGz+1YrGyAp7AVQZcON1fnEeaz5sudjco
 LsaMtni0Hsm1wbnvxOCG3d0KuXMiXWiRjKf6KlXPX186CKXcTzUVymv9WJUy6nDUpBJu00=
X-Google-Smtp-Source: AGHT+IF16k3LG+SuxhAPjBIw+bPNbRbimrC5SBW6zxZEPi65RNZnifbHg3ORlGr9BnwgO7zODl5yQg==
X-Received: by 2002:a17:906:d555:b0:ab2:fc5d:1795 with SMTP id
 a640c23a62f3a-ab2fc5d1d7emr1622953966b.37.1736937193194; 
 Wed, 15 Jan 2025 02:33:13 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af24bsm742045166b.134.2025.01.15.02.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:33:12 -0800 (PST)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Wed, 15 Jan 2025 10:32:59 +0000
Subject: [PATCH 2/2] board: rockpi4-rk3399: update email address for
 Christopher Obbard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-wip-obbardc-update-email-v1-2-0b4cd69c91fd@linaro.org>
References: <20250115-wip-obbardc-update-email-v1-0-0b4cd69c91fd@linaro.org>
In-Reply-To: <20250115-wip-obbardc-update-email-v1-0-0b4cd69c91fd@linaro.org>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=810;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=HjNbOLD83EtM4dnSMhNGUhZ2y9YSTOKc3iMipLt4rVU=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBnh47mOxSrUn0vUH9wgR6b0CAL+inxjOojfuje1
 5gyhClDykiJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ4eO5gAKCRBjTcTwaHBG
 +C0LD/9ko+aImWNRSExRJcGXh3SdqH7xiWOwK5DvUAELp8z9sR3lK0001w1O8AMmHyLBF+mDxEm
 ie1/gtTpIWtb7A3mQsz2+fvJ4V8oO6/NHM1tyn5+RpNseog5Ao4lFGqqUDAjXuKOMExasMQKbu5
 EDNafJjORwQdtxTbv+LxTKfWFA4nvpLVn7lqtOOzh4qa3r85/hm/SVT+un62E9AC683SHAHuKcq
 VbDbA8ajuSBk+kMwmXZYMJv+iWOjo8dnEo0BIrETq41IhNembcJiuVOx+v4ZbQPe2A+Azrh/53u
 Z8dUgu1j8MSeYQ+8Bsy6VKhsskJiw3avzOeT3Mom2WxI7bAB0Mu0IwWq1KdZ1BWGTzLWNO3S+/B
 FUnTA3kWsHweerA4VgH+7erePAh5bL2Wd8i/k0p/RTqm5WOV41jUZKvnUQpp6DsOUk9qBFxQ6mu
 O/u2yqYpZy4DOqz/kzu92rHERyXk51+XU9LvUh84ZAl+Wn7bJeEqw22qChpE2Wsa4m4GpSOKpM0
 lGv+u6C/TnN5iEsHfDYCAkAkTOAQH62yoZkMrhbaeyp9s6qP4i23haXX13gXa6ngkEmQORNRnBu
 gEHjmBu1TjaBmeyLZu4cNpq0e0bAJXhwRTCkPJQObkfQf8yzp9qEA2oZ97633X2mL3cjmFHBVD0
 Oa3U85bgjLtWAsw==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Mailman-Approved-At: Wed, 15 Jan 2025 14:37:07 +0100
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

Update my email address.

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 board/radxa/rockpi4-rk3399/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/radxa/rockpi4-rk3399/MAINTAINERS b/board/radxa/rockpi4-rk3399/MAINTAINERS
index da5273fb9a39c38473272c388182b9c4f32caa12..f50d9289ed67bde6b32f075ec137a38605b88d14 100644
--- a/board/radxa/rockpi4-rk3399/MAINTAINERS
+++ b/board/radxa/rockpi4-rk3399/MAINTAINERS
@@ -15,7 +15,7 @@ F:	configs/rock-4c-plus-rk3399_defconfig
 F:	arch/arm/dts/rk3399-rock-4c-plus*
 
 ROCK-4SE
-M:	Christopher Obbard <chris.obbard@collabora.com>
+M:	Christopher Obbard <christopher.obbard@linaro.org>
 R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	configs/rock-4se-rk3399_defconfig

-- 
2.47.1

