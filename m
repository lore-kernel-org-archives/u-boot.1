Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC84AC56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC9A440738;
	Thu,  6 Aug 2026 16:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdKAQYzgAuFX; Thu,  6 Aug 2026 16:15:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52E45406E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032931;
	bh=wkkYGReH+ho1P51Xi3/swhElokXAzRJhpZaBY5xV7rc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RGogr3JHfwMeueBJWV4ZT9wHcQYAozF340qNC1uY1FBv0QHv3JYRp4rbmyKlAhTyh
	 jtvg3IvNyVbQQifeTs60jQ40DaJHDoAfduuYrId0ps7SF5m1AL9WJ3X8kKtFWrL+Gz
	 phYBlowERjfsTQDeoC/GZJZONVYnPxKfhgONCED9/2kjHWRqgl6b08ZbrS9LY4GlgR
	 /ONnr3eQ9KAVGlFYu8Zm6tWsiaVUxuD96mMIjfoXR2hOeko27ePsH3nAstmW9vORQp
	 JNTonq2Q4uV3xWeLlatxramMmI0dlrBGquQUFmcuAgMPw7pvmoQ2H5wq12tYEZLFOl
	 Mp3gVkkLVtf4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52E45406E7;
	Thu,  6 Aug 2026 16:15:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 195BB397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16F3A60809
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OwQjIAmZfuvi for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:15:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 137E160806
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 137E160806
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 137E160806
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:15:28 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e6b554044fso2224725a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032927; x=1786637727;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wkkYGReH+ho1P51Xi3/swhElokXAzRJhpZaBY5xV7rc=;
 b=BiMp8B0Lr4WJJFQeQmJPPoBxv0ewbTl/ZK68yYDdLXTNirCxzE6q3bnnBrhutA6gmx
 UAkADzfQPE/wRSNOHwKi0b1DN/E0tc2fLuF5Srdt+BEjTZZZ3zG/VV5dFUNCXeigw0Gu
 WAdCyKWwsXfP3KOgw0xkjZisdmOD0VGISQhDnB95IklV8yNJj3s1E+Bsd7+mE1svmk8R
 7PZ59EN3AT1C1c+Jrxrq/YZe9TIkV6TO+sZaaAVv+0aS8Z/JTtbFB4tv6xY/Xj5rgIX6
 nDJoWM8Kios+kgqju5DLo378856TtaakUiy8jp74coXUC/nWFot8mvk/jYa3QQ5B0e8h
 sUhg==
X-Gm-Message-State: AOJu0Yy7esj2xyDfRf7Epp105y7wHpKc8xEbd4Kz2YltYF9cPFu2aNq4
 AGwCK4N1vZQs89zhdMXOtwbfmp16mbRAdt1ueC2t+qIVvHrdF9jKzT4kZLL97TgsEF9PsCsonnE
 +EAMwmGM=
X-Gm-Gg: AR+sD12TTek6dpCJmY1/64LNX4O3T5QdT/6ogUnPe2kNiefi7XOSMRhUV4iqz5kr9q4
 xG6kE95zVrgHv722UDuO0TOA/MU1i2OPVrliWpN7wC2TllH5t45pHBEKjkTv4KndeHV93JNwgR4
 CT5cY6Fp6EZ0MLGKehnKKaStWb+CCriDV7RW5wqpIBF+rINEnzylm1HU95yrq/b4dtiOuSa++3m
 d43e1oZCClb0qo4c5ZkF4uXKabjGFmhZu00w5ah7FuMZ98qW2t4/nGRuqEP30vk7TXju/RDepfK
 uImDdTJxswojHmGugv/wS6J2NRCUYKdBpL3rz1Vsd4rNDIiAeVJBtUPhf5KObGvzWhZBm7d1vzS
 yTuSf/azWTMcXkGzZd+3e9gCsQsvAzuec70F1YhUyKT8wYhg4Qu2dDN8Nom2FRC0hHQrQZ390NT
 4G+SoLtXY0B9xvmTd5T4NmfVF1A4M/1SzsBNq/0Dp4mb118CfCWowLwGqy3Tu2xYCvYbScFSWGQ
 2eMy2ah6Zt9pnEf
X-Received: by 2002:a05:6830:63cd:b0:7ee:3bdc:9205 with SMTP id
 46e09a7af769-7f1e5e9c02amr10541432a34.13.1786032927514; 
 Thu, 06 Aug 2026 09:15:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:beb1:8dd1:72b8:350d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f1df568d7csm4563367a34.18.2026.08.06.09.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:15:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] net: mediatek: add mt8366 support
Date: Thu, 06 Aug 2026 11:14:58 -0500
Message-Id: <20260806-mtk-net-mt8366-support-v1-0-5eb259ff69dd@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB1IIoTUqxQXGqd2WowhE0UQ7
 95UV49v8f4DhBKTQFsdkGhj4SUU6LoC/+7DRMhjMRhlrHLK4py/GCiXdY21KGuMS8poHkqPxju
 thwbKOSZ68X6Fn91tWYcP+fyvwXn+ALRkBw56AAAA
X-Change-ID: 20260806-mtk-net-mt8366-support-2901d2c811b3
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=759; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=RXAOh8dGHR3gtCRLgKRFvWnqLWZ+lIltYyCEU4iHdSQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdLMExjw4pi0ZJanPKn+aOUErt8AgLlMQZMdqo
 wzmx/odQlaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanSzBBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZKAH/3dg7us1NEztccAXq0sQEnzG0exWtz9elPhk0TD
 frMpiQxRVtFUENjRtmvRBjkzRGInwMnZSw4di0qi3Wgl15BiIYgwdMiru6fY5Tr0lEias+PkH00
 5yZONW2xwnrYnTIGkUFdxcA+p8cLE5rO5jey2mIOo1DBARE4n7d5oqAf4hG+s9BDZJSFfyus7mQ
 4XmcutdC9qYjB/jF3w0ZszfrYnh5Egf2pZmsOCwsrZ4e72iQKCR+206wTjIlXuolRvVqHaLwD5B
 LRaoh4nJyQChGWgMp7nhKZT4c0BGppPoQiknPczA+bBEt65iCshqEWffSO5YSAnBfgwrQPEy2o5
 Ycdg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786032927; x=1786637727;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wkkYGReH+ho1P51Xi3/swhElokXAzRJhpZaBY5xV7rc=;
 b=R9/iEipgA8mrkuS2E2P6Hj/+dzBX/599dcFizYlej4jQeDvO3hI4K+W7/cFxuDDRTW
 vTCgt0Kt+LfyUlERg308Vp1lWI0zTrTrMEbcIHo8Knb8o7H+aeGhxdjyxdMJGanncoNc
 Idu9ejbeTTyIq6dcWUii0feoXeCeGhr9ds1FEtpzjR5Iru5xSnqWFOAOHZdl2nczNdLf
 A7DwsqfRFwYZSf4e9l106yuABwSuQKh3jirwLhvk4ZHTlIpLZP9/E7ez+v0nFGYOcNsB
 2lu12fUsrXNjba34BqxxLbuthGiwrEtKTp66EgGQORrb1H/WHWKuHtH3pyMD/6aMUcoO
 5FYQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=R9/iEipg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

In order to support MT8366 (Genio 360 EVK), we need to add a new
compatible string match since there are a few registers at a different
offset on this target.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (3):
      net: dwc_eth_qos_mtk: support platform-specific PERI_ETH_BASE
      net: dwc_eth_qos_mtk: add mt8366 support
      net: dwc_eth_qos: add mt8366 support

 drivers/net/dwc_eth_qos.c     |  4 +++
 drivers/net/dwc_eth_qos_mtk.c | 63 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 8 deletions(-)
---
base-commit: b2817120d3506e3c4f1329fb8745b40ae7f6ba60
change-id: 20260806-mtk-net-mt8366-support-2901d2c811b3

Best regards,
--  
David Lechner <dlechner@baylibre.com>

