Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3872E94623
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 23:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0861A83CB9;
	Tue, 10 Feb 2026 00:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JC0aibr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E87ED83C5E; Tue, 10 Feb 2026 00:35:13 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62B8805D7
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 00:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45efe81556fso3351786b6e.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 15:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770680110; x=1771284910;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A0okE4IsBWDhPkJ8iwiybMAdsbFqk6cphcuM8fU5e7w=;
 b=JC0aibr3wNVg58IYNXi8DHYv+MyHPOYIVkmxMAaTl5mDZhVqsEejWrlQTufY0YT1Yf
 tvJJR+hO9zeJfLeT0qLAQGFb6IJrwr7h2bGrLnt/4M/jR60qXUqrV/nezUpv34z5lcap
 AM9FJQb3AkeXqJR/i6rdX6OgjI1bHWbXWr6taf26KB8ADS7yG6GHvsyJ8L5mxN8GbyH9
 6s/J4r3sXwDyODEHb5Xk23DpFX/z18SJAnx2ddLlZRXUp6bBI60iu5jzl3kqLC9HP8UH
 YqpkCHLl0dQgNacdUYxuc6goAwosEENlwKzqwc+8lWpkPZo6uCxkMKVb+FSZCBZmsop0
 KyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770680110; x=1771284910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A0okE4IsBWDhPkJ8iwiybMAdsbFqk6cphcuM8fU5e7w=;
 b=NKwSCsNHblW4U5zT9Z5mNcZ1/bzruXOUo9VwRrQXBYRr98A3AM1/F1SE9QTi2KQuLf
 /DtOQfN5OCTLumdkIaEY5aK0Io8wWAE1hz7cqxYfmEooxZEsGeT9TdmqcOUFqMSQRdv9
 G4SaR8iXSqcm2wNvOrERFyxrEpHzIV3PyavoMbbwLvEzIz2zmRyaDT7lbSu0NxuUGPPR
 8e/czzqsVaSzGUavAjY9qzGFYEdoJvxDmzYNUjVQcvJ02eDuQ4Yx812TfVEwwPOHpB/i
 fvFHnLeir1yfDP7swF2Wuru2e3wi2QtQKPhzGlt9a2AwZA+akGIZJkpINhgbB7SV95un
 9CWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaXSQdsIXBLnc3THpUqJ9WcMQO2r80fuskmSTO/IOvVHe80ZFKS90RH+i1ACKFBC5L++x7lTE=@lists.denx.de
X-Gm-Message-State: AOJu0YwEw2MfNQeWA68Ml2YX3RssTTFb6V6/wZMDekNVjJhCqRe03AXd
 iH53+euPcKnkdbsBT2LqXs42iIihfpuWasqWYVIfvQzHS3xS2nmyH1Rcw1ZSrg9vgFw=
X-Gm-Gg: AZuq6aKpJ/wu3zjPGuS8Fq51mBaEKitnlxkX8AU/rQxJxP4JL6hulouOZ8nTYutWIVl
 996ILqvbSV5ZGGctcmmhuy3GChhHvhumAEfigdcdwNlPs68n43WzqNjFI2x4VDa90bnpkxx7ZyL
 unaGX55U3Yjr1KTBBFzNxtWIDE3OJWBSpaNqhSONTIi79VhDDn2/9tOswS4TZ+lj3oecXM2Mgjm
 SPYIluYIXvZE4MWZ+AZDOdi5XSmTNXGHlhmlngIRjltik51SPGeLDDmwSPGskLBqfF07pw4HDk5
 obI6E+uGb70L4sUw5llnkESS4BqlbdAVdl+8KjyYOTmAIoIadsN91ySaWDxIrOoNnFJoB6eC9we
 5HC+lLfhQ06+h7bN2ujbBxIwodEAfeoFIhyrfu38RlavCxryr0CZwAfpuxueNX5SWnJ6M6noojk
 mwHMPJA0A9vccZ5W7/3BMJS6gyXu8Q0PQdMIte9g==
X-Received: by 2002:a05:6808:6782:b0:45c:7877:6f70 with SMTP id
 5614622812f47-46353c6384cmr140894b6e.51.1770680110585; 
 Mon, 09 Feb 2026 15:35:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4631407de2dsm5304309b6e.16.2026.02.09.15.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 15:35:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 17:34:18 -0600
Subject: [PATCH 2/3] pinctl: mediatek: increase max number of base
 addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-pinctl-mt8189-v1-2-a7a3069eda6c@baylibre.com>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
In-Reply-To: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=841; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ivw5sb2RfFpfhBX1MQqy7TReHkrCzsrcjZOGLH24VCs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpim8KOkzF32kD1he2u+jQlYZV2QaNdMSgsie/H
 LeumWtEwB+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYpvChYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2wIH/RtI4S80O3x4rwjZHUhH2UfFoF5edFjcpuDEZOG
 RJWrvFyXmiP9zEKAbi+zLn8D5Jz+axMorTCbb3OJBgj+Gfp1EIS9aISzhtaMis669pQnI9m6VJ/
 zB7KFU/6VjGKhQ40JN1nPvpXXtR8iEs4HEmrAL/gOYi0z1ePM1EyJANJbzhRoQUwUZqNwsssn17
 r2GBJw5WJk8uy1RIH4xRnXRZXkTzh9G16TxiTK5mGEB2PklWoHgMpMo9msCMch2IrJ9fH28LyEx
 n2N98bc50pb+rdchOVbj/DVECfR5ADcrlHNjizC7IEVx8vi7jqIEvdHG8RcxK/Bc7S9FevE1kjw
 htcE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 10 Feb 2026 00:43:55 +0100
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

Increase the maximum number of base addresses that can be handled by the
mediatek pinctrl driver from 10 to 15. This is needed for the MT8189
which has 15 base addresses.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 15ab3c1bf07..58f13613633 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -9,7 +9,7 @@
 #define MTK_PINCTRL_V0 0x0
 #define MTK_PINCTRL_V1 0x1
 #define BASE_CALC_NONE 0
-#define MAX_BASE_CALC 10
+#define MAX_BASE_CALC 15
 
 #define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
 

-- 
2.43.0

