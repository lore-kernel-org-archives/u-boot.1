Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC3CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 14:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B56B8460E;
	Wed, 24 Jun 2026 16:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GI4n9fs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F8A849BF; Wed, 24 Jun 2026 16:52:09 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B339E80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 16:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6da33a561so733854a34.3
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782312725; x=1782917525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3DD+OVN4UCGT92O72z0IOw251/I58NPs/xo6oBatmY=;
 b=GI4n9fs2VHWh9n4d1g1aZI984uPTtc9efyLK9x/dHhYncLe85UpH4xEnZDg1xxVII6
 K/cBB926Nx4Q1Plkq18rfRmGft5t29909NA8V+OOUpRZw1sQwjbe8i/fherBYDYeJ914
 5CU93M3WgiMyNudsgxDWamDTmr4ivCGCa6hx/r7zk1V8HKDNtRSsWtXUd9PDLj08CSH+
 +/pPCDPju7rjND2hGMZIRGruCOwJ10iBVkFBp3//IPwUTVeo+uoItgFrfq/c6STZuWvP
 RTGDXV87syek3x0R0BnsEF4L9GZeYrYgy1zwS6VU0iOlMSBabDzt/JEK9HcA6aDA6xGM
 oYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782312725; x=1782917525;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m3DD+OVN4UCGT92O72z0IOw251/I58NPs/xo6oBatmY=;
 b=putZcXO86bfKfkN/xXr55rEUA8tTQ3tAfc3IzAEA6YF5CXD5moyvMWu654S7zsOMRa
 z4FHnD6LbN2POw+WIrmdBpumIMKXk6veW+JL9+ViFicqiDZ8RmaNMSKSIi60aJviwjKg
 QtvHrv/lF1eZrYK5o2YFg6sGWwDR7+TdAWnnosJLn14DzKy/wFjbpRGuz3vqOUdYU5I2
 rosO0/OJzuel8ZhtSeRSLeJxKOo3BlhgJpPZwefCKjpnxMJVB6CS8l2H+u70epIoDTup
 rbcRDtEAL/ASPOuzwuQHqY5e2ZaLlhd9QRvecQldTH0bEQO3VAp6iRIApvRLPWpRwlC5
 ixUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RWso6M/bz83DRHkDX+UfcqB8/+gIZKj1G9kph7lvESB1ONETdtwEdcDsI7a6zClRVNDJ2n54=@lists.denx.de
X-Gm-Message-State: AOJu0YxcvUVISg4rCWXvt7WyuMEG0jG+qTsIFKgkSxrGHNZjysU/Zvil
 NMozVGmgfKWU5wOTRYjqQICywML75lfy5eToMTvbsC3xpqvvDkO3mqSJf4w8FNSRF/0=
X-Gm-Gg: AfdE7cnu3O9QdCvt+pz9v/84g5S5huRosx+AkMV4aOqdBO8H5bgqIueFK5fmIDYyc7+
 3aBo0ycHtbBwTJrsyenZi1CqfLS/GeCVhcODG/dSN+g3mlX3hYQg0VNMNXRGyYjUpDZKCFcWKfd
 Do/gxaMuSqgDJf/OaU1WFANmeLAaBGmZQZ5XnvFws5DPV1HMX0w5ROtLMJNfl+gWQO6f3gfjb7Z
 7OhtAvKpUv8lTWSj53DitCQ77sxQUb0Ri8OwnsewDfyOuD14y8lVtFiEKOoCsY3GNqpQSEumbKO
 MJKJ/+OR32WE8jCqMLKZbZnzcvrjdoQfPn91fDGFqW15Ocffrhrui8RNBjxQX1B9QPptKveyCKU
 /l18blBMq20SbaHZYc0JJKRxnjRp1RGzPyVgsdbjamVitLMgMnfnIAeslubD7pOA5ZFQfmVrqXt
 SdKJdneNDcLauMjSSR6Q==
X-Received: by 2002:a05:6830:4c0c:b0:7e6:fd45:9cbc with SMTP id
 46e09a7af769-7e986a8f246mr3700129a34.14.1782312725492; 
 Wed, 24 Jun 2026 07:52:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e944296d7asm11481082a34.19.2026.06.24.07.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:52:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260611-mtk-pick-dt-mt6359-unique-names-v1-1-601546be1210@baylibre.com>
References: <20260611-mtk-pick-dt-mt6359-unique-names-v1-1-601546be1210@baylibre.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt6359: give regulators unique names
Message-Id: <178231271387.3619522.3038568095627357795.b4-ty@b4>
Date: Wed, 24 Jun 2026 09:51:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=348; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=gLL/Tn2kBdNNVw+dqs8AmWqrAuobw+S00+VSbDSrh48=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqO+8MDni3iAjhSAZOXNjgg+HXKKnaX9RBNHnBo
 0frx87m0riJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajvvDBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHBEIAI1/Ucjp2nIRzJuU63m+OxYdggk/ybLcT2MlC0P
 zeEkDzGDtrAUd0pCUmyfVwAb/4gJbPLIZw0NNKyJw9UAr26deM/b7SzlKrnKcaG7xjEYD/1qpyH
 mmg7gKPnSRSxcgtTKUKxVUduxr5otUTTxLRDTIzyTv+j0kUzc5ZZMbS3WMqSjO/kcAQ+snVFSPm
 i8/aqXnnTWRZkkbiZKY2KAejXBVjFq2ITDFgCyn/Y5nF7/oOpk7jt8PTPDhoTBcoqjiq2+6lDac
 eSiPNaF/nrhCshqmkB8zC4L5jv5KiLjggfKzUTrPqpX5+pKm3hvHQCJ4HB/P/hM+L35zK4VFr2A
 dysg=
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

On Thu, 11 Jun 2026 19:12:20 -0500, David Lechner wrote:
> arm64: dts: mediatek: mt6359: give regulators unique names

Applied to mediatek-for-master, thanks!

[1/1] arm64: dts: mediatek: mt6359: give regulators unique names
      commit: 7aedd1f7fb5ead34df91979bdf9459dac6613a0c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

