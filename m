Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007F8FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7728467F;
	Tue, 28 Apr 2026 20:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="nMF3fCAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8C484682; Tue, 28 Apr 2026 20:18:14 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5D580433
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4042fe53946so5271160fac.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777400290; x=1778005090;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSqS+suLQj0cf9riz4Q4EUObH6yvVsT/LhycWg1aM6w=;
 b=nMF3fCADAknAGwsvi5X2YHrNNnBt1XyRU7+Ehp/gd6NF8PN9bc+dhQWdynHHnLkSa2
 ceaESWy9n4/KAzeDPP9brhfJnKniH68I+LYBu5ZXNGjMJiWimaYEW9/Bg+9Q+T34ALQJ
 eegC5FlWJO/6Yr0EZtt5A2Z2A5NX45P+UyYSKJ77d6UypOIL4Y4ivfawrAENPc0ndFqU
 7AQK4QKYaJmVMPbRKnMlnDMzWG3Kzh6tDw1VrZM3MDEpSvNFN8wx29pZ8iy+/dQ/I5eQ
 OQPdL79rCC5OnEELcceIOlTgvGSTHom+jmAUB3x+zRabi47TI4LTuJ161bLnznogrN0s
 ZP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400290; x=1778005090;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sSqS+suLQj0cf9riz4Q4EUObH6yvVsT/LhycWg1aM6w=;
 b=Yw9iVCvahiyZPpyuKb2Gch+bhOctnel1+mrJCotKKQom5fZ77gZ4uMnpcKisIPYcqo
 l7NTQ6Sa0QMyqLGKBNmbj/RDfdVt3HP/o2OihkiYn7IRD9f8kfza0HElDty+4pyMTmX8
 U4+VN4K/2kTgX4QvwEtdNpvQsg/gzkBxK7Qe1MBoEdRUpAjfciLH7VPOYmsFp8WhZkgX
 iMsjshC5fSwl0/oK8qSRQ5TvWxjaY6pHdFeSCuFl30wQDDkuOh+upQFlmnPwz0ldzTNr
 WtpaeIMT7rdRGhaIbn71msxpMq//WjqttHZMx1nYR3+nc5dYmcP1t6OKngbf8S26rwxe
 iEfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QHg6F4VQWpB2SMCPd9x6Yb29Invm8M2+g3e70DzlCPB5dOq/fS0FseNpqVwzMf8jaSDTbsDI=@lists.denx.de
X-Gm-Message-State: AOJu0YzPBPc0j/OjJRI+loJ++q6FwzItg7bOu9jWDn3nZQIRze5l9rFI
 lzwSzjbCdXM0nMjWWq4I+r5NzpSISfNfjxLcanH9bROxHkK+7TaHlY9rT2DzT2w4eiQ=
X-Gm-Gg: AeBDiesf+u+okvRynO4H19wi9l3jXDbCaHsSLpaKQPlNtNPDI4EPBjQxxtWGK5Dqegi
 WLCCNRY3HJ8wnYkY1Y1UcW2UvDVd0q+c2rkYU7GOm+1m88+vuKTVqLRUXE/Hx1MUA5GK4QZCwp5
 DSw0c+MoRp7JbhrpXqCoGwsSvrVB6F4UiYvVU3PfJ+VRJ02XXZLIFNxfxJHKwBgC3K9sY1HkR/a
 Cj7W5tdBKylsOmCzDzlwDI2ZWCtUUXvlKzqYF86rVvy4g8vEc5S+vYgLInd6xgolNzzlLVnyMlm
 AVdYRAaXHxpc+ezKNQK1Q4qfK/Gik11vtVkqNSS/kq0H2aAR3rIxr9mhms/r9hbDYljKKVSMEk2
 jrMUjD+PEjhph8wuK3VL8A65ArZDOrx8KgQGUeMZBF+YVo+ESV3YZJuauJ/7w25Mq7B7aWlMHVe
 yZhruW9dTE4twbo58dtrfD223FoRmeZY0ay4D+Dr8=
X-Received: by 2002:a05:6871:e78f:b0:42f:ba47:36f5 with SMTP id
 586e51a60fabf-433f396963emr2385752fac.17.1777400290144; 
 Tue, 28 Apr 2026 11:18:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340d333d15sm44884fac.1.2026.04.28.11.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:18:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
Subject: Re: [PATCH 0/8] spi: mtk_snor: various fixes and improvements
Message-Id: <177740027770.3382222.17634141846940816734.b4-ty@b4>
Date: Tue, 28 Apr 2026 13:17:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=rYKVRpGoNAx6Gv80XJLeDViuaFjNwwxfdRRCVzGhtjA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp8PnZS89kMM1tGYPOd0PSY4lxv9W9brBo3kVo1
 j1M9LoWmZqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafD52RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AU00H/iL1AcMvt1VRlJdZ5IAi3sGvbDCFMVgzzVw8XA1
 hGiHSXdKgP/Lp6r9xIzrc9nlzy3XCuKxe+BNE4z/UqPz4vhSf1oc4GcA7K0t3Vvg7qJmo2Hb+5i
 j/x0/tA1zkliRQHQ0Wn6Wcga7oGMB8i52/ZM77iRyo+Yyxzdd9aZQQ7Rc1QDFrb5h0PjI339xGv
 c6LYRFrgoaq1ktMNr+mr9urdf9R2phrbGrW+TF9FJwNBuiFZaLbDQ9j9D3WMIkv3LO0RTPStec5
 rVcj3erNxzE+nE8ukwFP99hz413iOeLL/fc2M4hJF3eh3UxVpn+EtGiwPzQmLlUh7qOKuvFfhAf
 x/Ms=
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

On Mon, 06 Apr 2026 15:13:26 -0500, David Lechner wrote:
> spi: mtk_snor: various fixes and improvements
> 
> This series contains some downstream patches that I have split up into
> logical commits. I have tested these patches on Genio 720 EVK by reading
> and writing the environment from the flash memory on the EVK.
> 
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/8] spi: mtk_snor: clean up comments
      commit: 4f9842e4799c6c3c98cc27c723ba223b42d739d8
[2/8] spi: mtk_snor: avoid alloc in mtk_snor_cmd_program()
      commit: 4eac47d4eb661c019b84723628bab2f0c826403f
[3/8] spi: mtk_snor: conditionally copy tx/rx data
      commit: 3b0a037052a24f8449c9fafd02034307e30a3c97
[4/8] spi: mtk_snor: check return value of mtk_snor_cmd_exec()
      commit: 55944a68d550d00df494a5c75685f00cbf0998f0
[5/8] spi: mtk-snor: add bounds checking in mtk_snor_cmd_program()
      commit: 78950bb20707417657d9122d50325bda9c9aa8b9
[6/8] spi: mtk_snor: support newer SOCs
      commit: 1cfcd7100d54b706b7d4ee17dd016b83e5eb88ff
[7/8] spi: mtk_snor: fix zeroed data in DMA read bounce path
      commit: 28bd63967784d1dbeff75289560e71fd1deac902
[8/8] spi: mtk_snor: Remove status register write procedure in probe()
      commit: 655daae25ea6cd54264e1acaac2dfa8528a10fa7

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

