Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ED7C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DD9D8119D;
	Fri,  4 Sep 2026 14:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cSldb-ghzUHx; Fri,  4 Sep 2026 14:47:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD4E7811AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788533251;
	b=M2lG1N6bLc7NVPBWi7sTWO2g9JYIo0OrVAFprLpGlnROTIZWpt+oVyNz5y0uwgs7DvpN
	 LWfmg+ZFWZ0i7HK2beLlsCrHgq6bIYlH9kugC2wloH+wGeHhx4797pv+XvqNARIO9Nm/j
	 CVEYT+bfOFIye6lMDL5VS63eOHcDC1hr0vZHZygyH25AYSAkKpAc8nlKF1SYXQZN09dSF
	 doYmHTE3a2XltSYbTBexPe3HGZ4+f8rAtjnKNVOm9/FoztUlKeylaSB/LOBDgJGRYXraT
	 JeZxiU571jnFYKZXEaoQhhkB0oVkYP7JZWRQkOBapn23mmA95By79Dn6F/q+8GODu3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788533251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p+02YZWWGP42e9qnumCD09Z4qS6auujKhuwBdnafJLw=;
	b=k8xl46tYJ+rPabg95CVjRpVy8bGJBNftCQljXjmJjiWXzGzcQkqho7i/QGZS8AEp3fYd
	 ekJjCcTt0JeTmW534PpZVKb4uAPNgeHwpqBfFT6wZeUk7hxoFH9LtNUA3HWMzpzUncqax
	 8Kt5SL8dYxOjnhbnLYd/z+S9o9FDnWBpEseh86MmfyYy1a43mSRYZMCh+qYT8KL/49nIH
	 SpV6UQacMI65/E6OwRzG0XMlds/Eq66gOkJ6YKEkNZH9nIWG36x04Foe+7ZsYaDSAtCDV
	 IXvQhhRlNiMg7943UV428ABPvxOZSNEIOsAIpMxtTWvP0CkyzcIkgAjr5GZLWeK6lhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788533251;
	bh=p+02YZWWGP42e9qnumCD09Z4qS6auujKhuwBdnafJLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zgTWpHp2uJHkr1YRiHWWikclp/N1mkxYi42p5ur0dgyhL51SLZ5N08aDSCXp6oyxZ
	 AyaJ5gF7ZdFKKKXm/QttOzAOHDYK+JimA1EosfLZCwC0b17vuK0i1WsgyhVfg9KSHi
	 y/hI4hOHyXXr3tm+GLgnc+gx1qWUytaNCm6FGrfX3tMkHJq1vyCgbDwdCjqQjy13rZ
	 hifjRqPz4pZJ0tYUmLzIhKIXrs+znobgQS4Jxc1rGaxXL2kNUTK2SdZxP6jgxj9wHc
	 WKNZTLhmUhzejfkk8v5ESMYAnJ1L7O12zZr4MNFnfSO8lUDP/L1u9NIimxrmkRmD3p
	 HBPL1xUdVdRhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD4E7811AC;
	Fri,  4 Sep 2026 14:47:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 792843DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F47840376
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qS7PBRssQBXn for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:47:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2C7C8404CE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788533247;
 b=saOZQzal89ub34PGOcYRSfjuL7QyhSvSWrd86UkYmZupZmoYZM6DggT6S17LO1IVwP47
 dXN8cJBzGgZsDa9QvgJuaLqg58AIncbdbVFlQxsqf5/0mSQ6LjFj+f+VNYK8y0eEGiUM0
 Sleu7qSqvRZuZOrZjH4u0hJ8LJvrhErXYsFQG2ncGbl8L9QOibUQ68MQAA8ZZZXAILk2s
 dXPToJ60srA/0LBC96w55dIFUZ+t1eQ8esDI+9SBSS5U9Ctii4pTHTKqolxW/YA1wRIgY
 iGExWQhpMSMjqAyIDvSsUarw1s+1BqYT3Sh8FFOzeyundkVzogSzVQmVZLc2Yquzx8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788533247;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=p+02YZWWGP42e9qnumCD09Z4qS6auujKhuwBdnafJLw=;
 b=qiS+IIPDpecz2QQtvk3AW/xCq0dIgyV+Qq4eOWJofjPsdIxjWb/FzC7RlAfVOawVjVQ4
 3ut0mb4e0ZeGHe9Z3DgIwsMdlHTgCa8ft6zN402TwPI0/Fpo9lkdVjur7dKMHLJtbEBeF
 aCUd0htAHlpcmHSRl1L5yUtsdJQudWXCd4B+Yj2+nReHw3pHBR6VBCT/GaqMWyBYvlvWH
 o64eu1Cr1O4DJoFoh5xIGidaEa8p5GR/8t7a6pjIV0s8TnoPHVRKen/bM89CI9VsjmYKb
 3QN0tWJtmf9kueRwiJxFX8B8AqWzRzR0rEMqCvwKYTP6qsPgXIIamcJLzp3ZEDk8d8g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="hjVfN/sA"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hjVfN/sA
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C7C8404CE
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:26 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4b28db31b89so707946b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788533245; x=1789138045;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p+02YZWWGP42e9qnumCD09Z4qS6auujKhuwBdnafJLw=;
 b=hjVfN/sA+ebk9UEND44nhM6/MtGKsVw2FB4R25iUmPICqkSLrAiIr3EC7FZ/cUr5QY
 qZ55oCirEdLMQem0rubZ52sIOjZDoxg+/m3hccOaJDnLM4HbTLDFo4m/KxwXLHD/b/sQ
 TkMalWQKBROLZ9pk4hpF3VqeLUNyPorHRUhnK8w8w7bLbT5ULnOUqZ5OM8ybVlx1MyDe
 TmwWUF2I8as+6+s24kCKsKBYY6NC9tvke1KHovKd9jHnHRnN7oq7sawKxMQdRe7V6oZF
 isai1rQB7u8yyZXGXswhhophiBboD/x1qIL5dO07CoCi2CO3vAHeRKWELIxRttIk3x3/
 pGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533245; x=1789138045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p+02YZWWGP42e9qnumCD09Z4qS6auujKhuwBdnafJLw=;
 b=n8kN4f6j1+TmxdFBQUag/zX7ZAce5QxjrF+j/AS4xh1B/V2+IluAcKY/7yNf8RDa1H
 WGDSCvegWZAzeujukAdMe2OSSjOwSD6uKojjoQKu0nllFhTtbmGla86hf5mQCRLilrhv
 r/gpcGAe/A+aJ4Zyw33gKfGlv4lKhPlkiSRC2N4kDir817PUWlOeZ6Im7vWW1UdIs4bb
 JXOK2DCRWma441BYuB8Oacxtwr76TThJ5wWEFKTIcHLWy/948/BW0wssHsEikdu1zAie
 FYjaSTlKNXs44+YUkDqNXmRZw0bQQDQZNbuV4j1QGsqDNth1MZugDca5OIbc/WdIsAcN
 OcwQ==
X-Gm-Message-State: AFuF++lF/GPCnCQyZ6tf+pHRmR68Ln8RNZES9tgcTe8R0TQjYy8frpjL
 Fd8uJ8Wd+nrrbq8BorHHWxI4CHevaLSkYedZNhibhuTO/g8IHfpiQ+XavaQMTv0Yb8c=
X-Gm-Gg: AYBFou3dEqyS3thuq7ggj2tiyBYiz3uMYgxkZ5QKv+MHcgUxlxIAVe8NeWCg54X+GpY
 vknd0xWIw6Dlw/yV+Bs/CVMU3vQdcWNGNtYkqzsDSehyNvKK6klqQseeeGYxBsArLUhi2FMyXeg
 3kORv0itteNfVl/Uu0W/KFANIGFFpk2kF2W2T+NCqP8rx0cB4J2P5ZdEPEQeDRMw75AypK6MbzG
 j6kFJIKF3BccTUHmUcueGHXPCEQlgL/yUHLHZ85stS7gE/nsSrzovBJW6R/vDiaMA0OmGFAszZt
 i63WDkM6Ip4lhw4fnHIZ5KceW5SvjMk1UF6HoaV1HjQsfbfLz7Ug0oKN9Q2hF8x8AAJlMXiLGQK
 88uFPJIiwTHM5g//cgxHJAxko2Wr3h+MLjXH9jCGTOMLylXuvsIxCm2KkpHi416FkzMC+pej+++
 zMwgKGTHsc0tbaLefiqetP8QTUmqxEOlNm4mBlMRZ8Pa32kkyeymV266xvrJhAK/vejg==
X-Received: by 2002:a05:6808:1828:b0:4b9:e6ab:d085 with SMTP id
 5614622812f47-4b9e6abd51bmr2209423b6e.37.1788533245454; 
 Fri, 04 Sep 2026 07:47:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47554935962sm2118988fac.12.2026.09.04.07.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:47:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 09:46:28 -0500
Subject: [PATCH 1/6] power: domain: mtk: simplify Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mtk-power-domain-mt8189-v1-1-ab9d8cd0f01a@baylibre.com>
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
In-Reply-To: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5095; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=cS0jV2EeX6DpwkvyjCgxEUh1eqgMX3xnZVI4PWp57Rw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmtnORlR0qGLF2LcKcWa6z7B3s0FTfNL/HU8tP
 u2OIMMT7AaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaprZzhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhXUIAJhiC+WOtl5ZT9DZMv37/oW4ITcevEzvL8uQnvw
 aljOHH9EeQ0PQjFD8njszIlJQtHdJaxFcCL3DtVEOn7ucCC7uCIqM/L21c5jsjzs5LV2jxOblWG
 tnzqwNZSd1TRD72YvyMccUQsqXahDqFBMsLZhpkWKGI4QH5tcI/w2xRxaIXl9uTbdJgi2UUaGfy
 FOZpZnqUIRaHPNfAHvdEH75e1aijZCsplmi9RZHcYrkVBXDGy0x3YoViT2F5XTkv269cT31JXVu
 LTve6PsH6QM76W1uriZlyQaYENbjWZJye6lqPFAkXIkkYab0iLBIvFMr4cwbxSUK04SAZJ1JGEo
 KxC8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change the MediaTek power domain Kconfig to just have a single option
for all targets. This will simplify adding new targets in the future.

Targets that have no power domain driver simply do not enable
POWER_DOMAIN, so the option can default to y.

In the Makefile, use the target config symbol to automatically select the
correct SoC data file, so a new SoC only needs a new .c file and one
Makefile line rather than a Kconfig option of its own. The SoC files are
guarded by the common option because this Makefile is shared with the
other vendors.

Note that some drivers are named after the first SoC they supported
rather than after a target, so mt2701-power-domain.c is selected by
TARGET_MT7623 and mt7622-power-domain.c by either TARGET_MT7622 or
TARGET_MT7629. Only one target can be selected at a time, so
concatenating the two symbols is safe.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/domain/Kconfig  | 47 +++++++------------------------------------
 drivers/power/domain/Makefile | 11 ++++++----
 2 files changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index bd8b1f8cf5b..13a661ce04f 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -83,49 +83,16 @@ config MESON_SECURE_POWER_DOMAIN
 	  Enable support for manipulating Amlogic Meson Secure power domains.
 	  Support for Amlogic A1 series.
 
-config MT2701_POWER_DOMAIN
-	bool "Enable the MediaTek power domain driver for MT2701 compatible SoC"
-	depends on POWER_DOMAIN && ARCH_MEDIATEK
-	select MTK_POWER_DOMAIN
-	help
-	  Enable support for manipulating MediaTek power domains via MMIO
-	  mapped registers for MT2701 compatible SoC. The driver powers
-	  the SoC power domains on and off and handles the associated bus
-	  protection bits. It is also used on MT7623.
-
-config MT7622_POWER_DOMAIN
-	bool "Enable the MediaTek power domain driver for MT7622 compatible SoC"
-	depends on POWER_DOMAIN && ARCH_MEDIATEK
-	select MTK_POWER_DOMAIN
-	help
-	  Enable support for manipulating MediaTek power domains via MMIO
-	  mapped registers for MT7622 compatible SoC. The driver powers
-	  the SoC power domains on and off and handles the associated bus
-	  protection bits. It is also used on MT7629.
-
-config MT8188_POWER_DOMAIN
-	bool "Enable the MediaTek power domain driver for MT8188 compatible SoC"
-	depends on POWER_DOMAIN && ARCH_MEDIATEK
-	select MTK_POWER_DOMAIN
-	help
-	  Enable support for manipulating MediaTek power domains via MMIO
-	  mapped registers for MT8188 compatible SoC. The driver powers
-	  the SoC power domains on and off and handles the associated bus
-	  protection steps, per-domain clocks and parent domains.
-
-config MT8366_POWER_DOMAIN
-	bool "Enable the MediaTek power domain driver for MT8366 compatible SoC"
+config MTK_POWER_DOMAIN
+	bool "Enable the MediaTek power domain driver"
 	depends on POWER_DOMAIN && ARCH_MEDIATEK
-	select MTK_POWER_DOMAIN
+	default y
 	help
 	  Enable support for manipulating MediaTek power domains via MMIO
-	  mapped registers for MT8366 compatible SoC. The driver powers
-	  the SoC power domains on and off and handles the associated bus
-	  protection steps, per-domain clocks and parent domains.
-
-config MTK_POWER_DOMAIN
-	bool
-	depends on POWER_DOMAIN && ARCH_MEDIATEK
+	  mapped registers. The driver powers the SoC power domains on and
+	  off and handles the associated bus protection steps, per-domain
+	  clocks and parent domains. The data for the SoC selected by
+	  TARGET_MTxxxx is built in automatically.
 
 config QCOM_RPMH_POWER_DOMAIN
 	bool "Enable the QCOM RPMH Power domain driver"
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 74f22d57981..dd14981fca9 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -14,11 +14,14 @@ obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) += imx8mp-mediamix.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
 obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
-obj-$(CONFIG_MT2701_POWER_DOMAIN) += mt2701-power-domain.o
-obj-$(CONFIG_MT7622_POWER_DOMAIN) += mt7622-power-domain.o
-obj-$(CONFIG_MT8188_POWER_DOMAIN) += mt8188-power-domain.o
-obj-$(CONFIG_MT8366_POWER_DOMAIN) += mt8366-power-domain.o
 obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
+ifdef CONFIG_MTK_POWER_DOMAIN
+# Some drivers are named after the first SoC they supported, not after a target.
+obj-$(CONFIG_TARGET_MT7623) += mt2701-power-domain.o
+obj-$(CONFIG_TARGET_MT7622)$(CONFIG_TARGET_MT7629) += mt7622-power-domain.o
+obj-$(CONFIG_TARGET_MT8188) += mt8188-power-domain.o
+obj-$(CONFIG_TARGET_MT8366) += mt8366-power-domain.o
+endif
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
 obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o

-- 
2.43.0

