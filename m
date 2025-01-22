Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05B8C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABD080817;
	Wed, 22 Jan 2025 16:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JiPdh8jS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6AB80882; Wed, 22 Jan 2025 16:03:11 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471CF80817
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so1196695166b.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 07:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737558189; x=1738162989; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bIyxH1LXi8PUKwh6GYxvjHvPoSODwAkEn3cMB/LudYM=;
 b=JiPdh8jSok2iuNccyTvKlXMYVuEDXVjeR9tdFYr2zqZZa8HprGVEQ1X8Bc09CstUD0
 qF+dMWrvT16UcU4A2eeb9u1ku++hBWVvlJI0lZKY4YIu565cPOPjRr7c2SUTYgh3tp4e
 TBME05kXQd3qXy/Ho3maQkMUul+sSkjCYkvEj5z0/+37d1i776qoOejEyOlSkz0nn22v
 2Ev3utrKCxZCGAhopk3fdDeUMGtFvLEt1i5KTU7s2Vrc9GVv3gRD7JOi4yP54kDc9PT/
 UKuwW1I5sZVKltfblvSy6zYm8rYcmIdNTOfR9HbSxYQ7ziLslnF71/e55QrZ3FLJMqZ3
 MJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737558189; x=1738162989;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIyxH1LXi8PUKwh6GYxvjHvPoSODwAkEn3cMB/LudYM=;
 b=VW+8fH3+xeClePhDqIsSt4A4NqVSTd1kR00ZqF7QGtP8gkZEfVYpK+sJhK3AybdJjb
 osQQBLSz5Vn65VfFOTjHRIy/hBi1O+eYI46yDKmDUrFX+CdK5QofjqTDpvu3S7CB0TtK
 ZWZyw4/7FBgSmbfkdQqp//p9Ofpu/bnocCZZb6HrQQfhZtMUajFPvT0NYCQw6sdJ1rRx
 IoalEb2RMNnsqRCzha5A3w3vJsHf9VDY4xpduRVBZc40c4CrS27kRxZo2noHe6pP79Lu
 fu5WXQ6yzsHSYK9z8DvjrH6y3wrPVDWHcxzLw1arwtBCRGTLkuWZl6W1lTKU5/o2G6PI
 EIOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9JQqQIEEvEd0qoueAg6TprrFm8iNIsRP0aylKy1wUlP046WmHPmiymkcQ5YHTmPwHHIxSb9I=@lists.denx.de
X-Gm-Message-State: AOJu0Yys5/ktXC4UVa7S+sJaQ+X8354GucUuY3bvIVTMwjFx+nF+XvL8
 QWXZsIi7Od5DA7PKVB1hNIF8sAoPkLnRsfm60qPZ07rj8Bz4DFT2Q73fgnYuHg0=
X-Gm-Gg: ASbGncvGVJSNfuS20w2AA05XTBv8cvf3D6rsLi2pbIZklGwnFF7Qg5RmnU3YjGaQ+7F
 atN4FuO+LseuRy9aQ0I2BWwTKtxR55PgEQh6CH1YI6yxN88Yf3dDaJNfBYevjcTZT2jYlzwE2Kc
 fDvAbiAhxgPFVaduN1YFbm8mpO4FvKqeD4ylGfauq5M5G0+TCoM+gncDzRRzOIdspd5NaS1XilG
 B4dOiPrejImDNgkrDlq9g+x8oID0/rBqkyR0cglSIV6pSlCRtSeCId/FHfYVpieGnOMLGbg77kn
 L0VIUDDgrHkQ
X-Google-Smtp-Source: AGHT+IE1V5Uj97b69BLxpUFu+bcjdFEvKddzffRkZbgbdwV4gy36gQOyZGzBiQxICIA08OrGdhzEAw==
X-Received: by 2002:a17:907:c15:b0:aa6:9624:78f7 with SMTP id
 a640c23a62f3a-ab38b112933mr1992631366b.17.1737558186757; 
 Wed, 22 Jan 2025 07:03:06 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223fesm930214166b.105.2025.01.22.07.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 07:03:05 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 22 Jan 2025 16:02:52 +0100
Subject: [PATCH 2/2] qcom_defconfig: enable PINCTRL_QCOM_SC7280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-pinctrl-sc7280-v1-2-8bdba72e6366@linaro.org>
References: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
In-Reply-To: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Markus Bauer <Markus.Bauer2@tria-technologies.com>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=626;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0gur/pG6mikwvx2MM1fdVxw9/4TxgkBImbRhrTXfIh4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvSJHMtCFpp7Sl+S7Zi3UorVyOTofxFph3tMwu6X1wZ5e
 Bm/M3nVUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZikcvwP6zxhDYnU2isbll1
 gGy/UdnV9096FtjZHVlgxHTNiD1hI8M/Hfl1u5a482V6l85a4Trv2ufszI55jprhk/1ie/4+mq1
 hCAA=
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index cd94315f1765..7a60464120dc 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -92,8 +92,9 @@ CONFIG_PINCONF=y
 CONFIG_PINCTRL_QCOM_APQ8016=y
 CONFIG_PINCTRL_QCOM_APQ8096=y
 CONFIG_PINCTRL_QCOM_QCM2290=y
 CONFIG_PINCTRL_QCOM_QCS404=y
+CONFIG_PINCTRL_QCOM_SC7280=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_PINCTRL_QCOM_SM6115=y
 CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_PINCTRL_QCOM_SM8250=y

-- 
2.48.0

