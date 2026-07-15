Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4ABC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 13:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72F784A4F;
	Wed, 15 Jul 2026 15:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="J8HJFaoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC1BC84A67; Wed, 15 Jul 2026 15:11:35 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BFB84A4B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a1160a2c42so3586256eaf.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784121092; x=1784725892; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wQxlvUo3g1sMeEMc9Hp8jMqLn/1X5Kihx832qgreBjk=;
 b=J8HJFaoGmXnBPc2ZiHN1KVlbG2jaTQ/MU1qvdDsd0WkILhC2Ngu+sowsqCjivCUuWB
 Gq8KprP1NSjIdsmVQ0D73iJeDfp+/hbRP0Kti1cZuVTdA9Pbo2cZ8eExfAFCiKgyMHrG
 rpzIdeOGNs9Zm5gQGgzwpkaMs+6VGs4uH6iYyEL9l9MyuG4OTkjzlBgNuUdatjoigZdp
 j7kQk14b5XX5a9xsN2F7Ay7s8uB6CXu6HEEDlD3QgOl4KPYxpjZTpk266KRaTorS1tQe
 VQRlx/Fg86+8/AEmUNrudtRqb+52bYbO0X3ushvpivD+c0QBKCCKD3D7ivsC+53I306W
 TLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784121092; x=1784725892;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wQxlvUo3g1sMeEMc9Hp8jMqLn/1X5Kihx832qgreBjk=;
 b=DXWp2ASPXpyGw569zUxtDAZm8wjwE9IJoHAsv+ofOIK9wILxmhAAbnK9OD3dtpeTyd
 mDHUfNszZSgctOHPl5z5vOfmGyJNe+Q0G4d8eQferUEtl72J9wwclP0ZbvALgMma3Qhu
 CoZshLGQAj09BWZ7Ygvtl6YF9bssjX4+x/HG0fbIf8HQlZHuyW6waOEm2eKRbijP7YeQ
 UPGLZyRRsfNqeKcCNv654Ww1anErQ9+5lPewnbuRmE2T6qt4zw87MdWJ8bsXLWVhnC7m
 lNS+cnSGb1EXnoYLjIiZOjne7DOIYmfwi/aJhTWb8kwYbquZ8WSqnJCo4wrPOcjombS3
 1Z7Q==
X-Gm-Message-State: AOJu0YzHrog+kT/DUBgABytqlS8YDU8hx8/yUgz4nyyCerfJyoML3vZK
 meWQpKkEKxx0jUWiqlA7aCz3jeDEpz8PooFcdavL94lGwtV2R1R7WuteC1ILscLN5Rk=
X-Gm-Gg: AfdE7claWAlSubJ0pnfWK78q7R97kNdJo+gM+KHcmecq3jrEo4hzxJhBPd/HVSBEuts
 2fSXHCjPH48VVc9cCkXF0a4r558TXzNYYWzpi3Izq++NvgBO/eziaLx4+Jm2gMrJHgUBYZYFa9P
 cD6DqU9p0CGHqjHszjNymdh0JJNZ6aBMCelape2YltFn/MSwQfv+WkKSDfVImEwS+TYRYEQMRse
 dGYaTrWNOHLEjDhqvJdOSwdATqBFHVk3yrD8Iv8Ufzr7694K6EynvnlqQZf0/kmrzpSal7QrxP3
 RoowcxnjDytqAurVh2movzKX7X6hjAlKmeXk3sL5coXX9d0smB8gDjNb5rBpKDLBCzrzvMzsCRy
 T++yLFUcT8wEcCvvSuLrYfxH03R2Sa3TPSFp5BeTS4EbO+9Xd+Zvuf/WN1m6I+pQPu4an/68lDE
 HjaCx1IT7TXRQJ/QP93w==
X-Received: by 2002:a05:6820:a0d:b0:6a3:8b32:3ecf with SMTP id
 006d021491bc7-6a3cba7295bmr3706697eaf.12.1784121092287; 
 Wed, 15 Jul 2026 06:11:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2b99:1202:cb56:140a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451ec3a6c19sm12952486fac.1.2026.07.15.06.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:11:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>
In-Reply-To: <20260701-fix-genio-510-genio-700-dts-override-v1-1-cb571f8c9296@baylibre.com>
References: <20260701-fix-genio-510-genio-700-dts-override-v1-1-cb571f8c9296@baylibre.com>
Subject: Re: [PATCH] arm: dts: mediatek: add U-Boot dtsi overrides for
 Genio 510 and Genio 700
Message-Id: <178412107977.1218700.5625289741319598045.b4-ty@b4>
Date: Wed, 15 Jul 2026 08:11:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=377; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=r9H1eZRQYuCFFGl9eYyZLamctg+3iJOhSm0gdbDTvtU=; 
 b=owEBgwF8/pANAwAKAcLMIAH/AY/AAcsmYgBqV4b71p5aMc8dWYhyZ2kzUizV6sJtSKRhrC/Rj
 yuEX+0dpUqJAUkEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaleG+xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtTIH+OR/oXPPfu3Nm0cizhBKWuf3xEORGCQogiq7bWQ
 +XuWauReg/qUdWR9q2my9kc7QzVxXc04Bes135PdZUal3b9jI0rRuomcos293yfpMLq7trUGb34
 xwIvT+zW3Ho+sqtroBSwB7bnTlj83Yk3Bwtp0ikoeeiyoYlcEjwbgtgSui264mKFODJ7LSd3TOG
 ZrQvQrn9gs4KLDRlIK0X4P0g9oATsRqzdNaTmwHdqwFqhMV1P9oa0D/hVWbcqTicr08g3WmM/O1
 IpDnGNRnHdqGR3Ecg0sOZUd6mlKizm0bMA5GYoblr5IAgK5q9s90THhktBo27a+t0vrw3PV3k8y
 +fg==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Wed, 01 Jul 2026 17:05:12 +0200, Julien Stephan wrote:
> arm: dts: mediatek: add U-Boot dtsi overrides for Genio 510 and Genio 700

Applied to mediatek-for-main, thanks!

[1/1] arm: dts: mediatek: add U-Boot dtsi overrides for Genio 510 and Genio 700
      commit: 0ac6a148d192595db97178fc96d70c61accabd4b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

