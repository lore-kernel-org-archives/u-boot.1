Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425BCC79F9F
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 15:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D406405E6;
	Sun,  6 Sep 2026 15:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e7SEapFs8Tw4; Sun,  6 Sep 2026 15:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DE7504060E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788708640;
	b=bgDvoV0z1+I35q6Y+ncrKBYQlOYUMR3IzsUgOWg9HOAS0b89rTdHqKivD+9LFJV9428J
	 Gnd/YhTXgLFJ3uXnHzEbWx89/3stEJFUuvTOdOwvjhIYsUqCowDVebpysQPpYkRIYPzmj
	 jpjrHQFdi7i2Am0OPGmEmqSyY/pmc/33PHrRRy1BkhcoSaTZ4pdYacbPfKefxRoP6Cj2G
	 HMX0eOa/LG78m8QTwJpMhe6X8YECumyJVW6/nwM4LPyY5h6s4J5boxU/ngskQ7IqR0fKm
	 H9gat50eY6WKQZIYKGB3JWpff8v1tR24MC9lkWD94fR6ZOcZibowS70ZIukG4b5V8Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788708640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5GvNF/Q+Fmf0Ts/lJxIDXe3PjV7vyPXsd8Mc+yWbbpk=;
	b=mWPJuv0nLO/hLLA89b8nOR3+RpGt9u4UL9N96jSLA8XlM9Wq/TTWIIbJYqr1vuqA79kb
	 RV2AzBHOzn9Ao6vnDHEh9uQ/cG0oE/nf2Np4Q8iOqs8/EYCTsNthAJS2P32JLfqU20WPv
	 BvCunK2Ko22qZMyWCSrooUMmRR2FXJyNCiBLVn07PDUix3jnjsCJVFW9tIK/q/VfPKXIZ
	 OXQKvqToGzoLjSwGbYDbFxKk5sXhNheoIVEKOfMsODRfBL6WsQnq65nExDgZEr+BX1mdN
	 yBuURoR+ma7XCmfjttzY5LBxwzgWT54ata6CWYniURfIU6MaLmUvKMDjCuWEGnmu38g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788708640;
	bh=5GvNF/Q+Fmf0Ts/lJxIDXe3PjV7vyPXsd8Mc+yWbbpk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ia06lSn27kQXCuySg/xiOwC/dgOHw/hrRtn78of9ZgQmwN3UdabhzxlrR0vioJUuz
	 zV3cF4VIUoAQw+wuk8JjG+SBFpd+23SPkQWQbM1Sp8SbDDvVAr1EI/0MDdFXiP/QA2
	 C2v6opwZc+9A1+Xbo4KG2WyPzBEPfh4pJw2Jv8z1JERrwrvkCkFVUEAtOaaGqg92F2
	 gPoxsljzN8kCtfjl0ROvBG+EkhwCuCFXCJEc0qGcLWjq60PnFcRjwratEpzLMRCnCE
	 mQFp4e5U+s7EoGzxGGYrJ8JnbWWmklcAfIl3lUQtd5PSbbJeSalzVYub+6MjljeGy9
	 msYwFDUb5OTJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE7504060E;
	Sun,  6 Sep 2026 15:30:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF279388
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE31780C06
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_C48b2ghWiB for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 15:30:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 32CF480C16
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788708634;
 b=rI39c8rKMlR9JrTg6qI3uD17eM8kRocjQOzR/Yif6tsnFX/SYgBKRXDBdb6OlLb7ZQys
 9Fk1vOfh+HIJw2hnDA/WnB5hWp29KmWl0MiBJa9pmg5NMt7s0TgkVt+5PV7nCp0WvLrc7
 ZhZeZmJt0Ee3aIzf8EBtJyk9iZjJSC9w+r4CNfacPEQTqLErjImozAFlSGggGaUEaaWbv
 Az4KsU3WOyhOCpu5KrLF10Ywvdfd0P2tmdVkVt/0dqqzp0FXGsd3u3hhRmONEx+JaC96U
 Re9derSj1TzMgUxtiDPQAxSP4a9/GS2ArycbWBj4KKKsThDKnymfHVhTBHFMiqrQOWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788708634;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=5GvNF/Q+Fmf0Ts/lJxIDXe3PjV7vyPXsd8Mc+yWbbpk=;
 b=qrYku+L+P/g8mQgCs6TwbMFl3o/a2qYzVi65/GKhJHoIRKwJRk6RfWXapyuC8wPbtTEm
 usQ5CA0Bda/5kJ+KBYX+DOaqQV9MO56gOu1A/DsEKmxW4xd26ny6acJ0o+/JhcMzP3tdK
 W0/c6l/W8f3N47eDKQ/cVqoPeVX7jmfd1rB+MGV4ptWDN8Qv5Fa5KB8xchgg5gnPHFMvl
 CU2Kg5TQ8lu72OlilktLxoyDkaZS/PAlrDDOqc37NF+Gmk7/WGXR/Xrzl+ixAphucX1Mj
 umf4r5zMDSHq+RIOslrflgYQamToMxLfQoZOh70FNfBMs9crwsRD7/R22S7WU2HJBZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TdJkDCL2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TdJkDCL2
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32CF480C16
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:33 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so19718375e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788708632; x=1789313432;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5GvNF/Q+Fmf0Ts/lJxIDXe3PjV7vyPXsd8Mc+yWbbpk=;
 b=TdJkDCL2+7gywyJ5ZKccFn3XTJFtgFjsKv/aIvLNOGuGNXSFs0pslVT58FKYsxvouD
 RXEAV1bMSeKSBt9pC3XqmouWGawHyZ4ummxYcQM/lokQWF6W9Qg9/Oye/1V/pOp0/z2Q
 wf8kGy1H71JM++8ZyDraOlEPx0OwkxMcKH+SvepYUVe7Rd0Q6CYDgd7wQ1C4dC6aStgj
 BVtnuppUXt4JTU0UrruZb/B2DKm7Y7tTlE8LkzYQILDrXQuVnzI5H6NZrCelBQ0l/pet
 2EfWRcONgX87RaSHHmiEV1N1TCn2fiEd+mpkUMa5Eoe5rW+TlHwk03okUpGdKSYrsjyZ
 xAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788708632; x=1789313432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5GvNF/Q+Fmf0Ts/lJxIDXe3PjV7vyPXsd8Mc+yWbbpk=;
 b=ExXrMB+tRy4fsr9AAOxN64s1kq+HJh59NZlGAefZDeYjo1IEyM3gXmaZW88KQ89zMB
 jhu2zSBVvSOTlcUTrB5CYvAqVSwwcg4lpkXDSYzur3dSOK5j3m3oWkMEgaKLR+pBOdJJ
 2hbmNPEZE0jNXxjW0UYLmmRxO09dg2pR1/LoG1z3ufTA/jA/bJ2zeY27cCktyYVq97PP
 xYM88ncBrnt5snwQG4HvspveubBr0QNncc41MX0FKLwBHBskkkbXb3q0ZEOASqgD/1im
 rar6Eqrp707+e2299mzhYm7HV2xxn2ZTZQO8QLHkze26lWTVV8Nfxh3ZhBwbf4q+MQwp
 1Snw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh7D6T4+O1JydvFUa27fp+rcJG0Z4xNb5xfP/UpB7fIgyq6aEB28eeHiVgS5dlmnuetPdyBoU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nl/UheQ6936nHZ3AP47w+r7jljvv73BN4VSRe00YQi9SvUQpzE
 iVSi3YCnAK5KzaEO8dZe0B+AZjT1EOtEabk4bzlgYxVnOec5SuDvTGw+HmMmSzK/3g0=
X-Gm-Gg: AYBFou1WtoEQUEqIjvOoCtMTOJKNivGBxDkVs9/4GMZ1dq5B4FXVHxkz7FQxeekDYKz
 wjWhDrnT87aFNXrbWZtFewH6AreCVXSBSXefxvU0Kr7m5OCng4C7cBtjimwIxd9B/5Keiv4n5GY
 lgzpXjts4/PpmCFlJq/v6sEDs05qxCa4cVu7syLbNSmq/2qinFbqrS0u/gcRWzv+rusf3XJeTS8
 cMU8nGcxSv5cgz/x/0f9d4hBHgTQxGE9PLskLfE1d+q8VR6+gjQO+H/8s7uSNKHCqrhW8Iobwnv
 89pK6LXAsC1wairu9ZZG990MI7UKLsL6qAqTV6rm6xGK9C0inDdVP8CBNVRbozzje+EtBzwLhA4
 1JGC4KGTy5wcM/kFdTrIxaWnaS6rIr4fqkf6ljW2OzK1qwEQS01ycgKgRn6sNQaPjFQbLbkp3Pk
 K7ymyA+Cn2bPy/YVopblaUM0ELdSFFfWhmsE6H3HmYbuys6JSB76QcMpWAvEAxRJZU5glU87MFW
 084v1iAP2GP+9nylWHMBD40uRNl1FhjIzStT4ieZwjNl2jSlKGM
X-Received: by 2002:a05:600c:3511:b0:49c:fa20:cc01 with SMTP id
 5b1f17b1804b1-49cfa20ccddmr171249415e9.24.1788708631708; 
 Sun, 06 Sep 2026 08:30:31 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm238069605e9.6.2026.09.06.08.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:30:31 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 17:30:23 +0200
Subject: [PATCH v6 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-mt8390-spl-v6-6-4d4a11d5741d@baylibre.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

Document the common Genio 510 and Genio 700 eMMC boot chain,
board-specific external firmware prerequisites, binman build invocation
and generated images.

Define the binary layout and execution-state ABI between an external DDR
loader and SPL using the corresponding Kconfig symbols. Different loader
implementations remain compatible when they satisfy this contract. Also
require firmware handed to the RAM SPL loader to be a directly parseable
FIT rather than a compressed FIT container.

Describe FIT signing, storage mapping and installation with Genio Tools.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 board/mediatek/MAINTAINERS              |   1 +
 doc/board/mediatek/index.rst            |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst | 274 ++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 57bb3095305..aa862a4e1ea 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -30,6 +30,7 @@ F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
+F:	doc/board/mediatek/mt8188-genio-evk.rst
 
 MT8195/MT8395
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
index c55d5aeb5c4..7ca1bd9fde2 100644
--- a/doc/board/mediatek/index.rst
+++ b/doc/board/mediatek/index.rst
@@ -7,3 +7,4 @@ Mediatek
    :maxdepth: 2
 
    mt7621
+   mt8188-genio-evk
diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
new file mode 100644
index 00000000000..90bdd5cc3c8
--- /dev/null
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -0,0 +1,274 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (C) 2026 BayLibre SAS
+
+MediaTek Genio 510 and Genio 700 EVKs
+======================================
+
+The Genio 510 and Genio 700 EVKs use the same MT8188-family boot flow:
+
+================  ======  ====================================
+Board             SoC     Defconfig
+================  ======  ====================================
+Genio 510 EVK     MT8370  ``mt8370_genio_510_evk_defconfig``
+Genio 700 EVK     MT8390  ``mt8390_genio_700_evk_defconfig``
+================  ======  ====================================
+
+The configurations share their SPL addresses, size limits, drivers and
+firmware-image layout. Each board retains its own control devicetree, DRAM
+size and external platform firmware.
+
+Boot chain
+----------
+
+The normal eMMC boot chain is::
+
+   BootROM
+     -> platform DDR loader
+     -> U-Boot SPL
+     -> Arm Trusted Firmware-A (BL31)
+     -> OP-TEE (BL32)
+     -> U-Boot proper (BL33)
+
+The BootROM loads a MediaTek image from the eMMC boot0 hardware partition to
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``. This image contains a platform DDR loader
+followed by U-Boot SPL. The DDR loader initializes DRAM, copies the fixed
+``CONFIG_SPL_MAX_SIZE`` byte SPL region from offset
+``CONFIG_MTK_GENIO_DDR_LOADER_SIZE`` to ``CONFIG_SPL_TEXT_BASE`` and enters
+SPL at EL3 with exceptions masked.
+
+SPL reads a FIT image from partition 1 of the eMMC user area. The FIT contains
+Arm Trusted Firmware-A (BL31), OP-TEE (BL32), U-Boot proper (BL33) and the
+U-Boot control devicetree. It is an ordinary, directly parseable FIT whose
+first word is the FDT magic; the complete FIT container must not be compressed.
+The supplied configurations use uncompressed FIT payloads; compressed payloads
+require the corresponding SPL decompression support. SPL uses the
+standard FIT and Arm Trusted Firmware support to hand off to BL31.
+
+The DDR loader is a platform firmware component built separately from U-Boot
+and supplied to binman as an external blob.
+
+DDR-loader handoff contract
+---------------------------
+
+The DDR loader and U-Boot SPL have no parameter-block or firmware-call
+interface. Their contract consists of a fixed image layout, initialized DRAM
+and the execution state at the SPL entry point. Different DDR-loader
+implementations may be used as long as they satisfy this contract for the
+selected board. The BootROM loads the eMMC boot0 payload to
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
+
+   offset 0                                     +----------------------+
+                                                | DDR loader           |
+                                                |                      |
+   offset CONFIG_MTK_GENIO_DDR_LOADER_SIZE      +----------------------+
+                                                | U-Boot SPL           |
+                                                | CONFIG_SPL_MAX_SIZE  |
+   image end                                    +----------------------+
+
+The DDR loader then performs the following handoff::
+
+   initialize and train DRAM
+
+   copy:
+     source      = CONFIG_MTK_GENIO_BROM_LOAD_ADDR
+                   + CONFIG_MTK_GENIO_DDR_LOADER_SIZE
+     destination = CONFIG_SPL_TEXT_BASE
+     size        = CONFIG_SPL_MAX_SIZE
+
+   enter:
+     PC          = CONFIG_SPL_TEXT_BASE
+     state       = AArch64 EL3h
+     exceptions  = masked
+     x0..x7      = 0
+
+The loader must copy the complete fixed-size SPL window, make the copied image
+coherent, leave the MMU and caches disabled and enter SPL with no live
+dependency on its own runtime state. The MMU and caches must be disabled at
+entry, and all writes performed by the loader must be visible to the CPU.
+SPL does not consume DRAM geometry, a devicetree or boot-source information
+from registers.
+
+SPL obtains platform information from its embedded control devicetree and
+initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
+drivers.
+
+There is no runtime negotiation of these values. A replacement DDR loader is
+compatible only if it initializes the selected board's DRAM and follows the
+same image-layout and entry-state contract. It may represent the corresponding
+addresses, offsets and sizes using any implementation-specific mechanism; the
+contract does not require particular variable or build-symbol names.
+
+Firmware image prerequisites
+----------------------------
+
+The following external binaries are required to assemble the complete
+firmware images:
+
+``ddr-loader.bin``
+   A MediaTek DDR loader built for the target board and configured to satisfy
+   the handoff contract above. The input may be shorter than the configured
+   loader region; binman pads it with zeroes to the offset reserved before
+   SPL.
+
+``BL31``
+   The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
+   built for the MT8188 platform. It is loaded and entered at
+   ``CONFIG_MTK_GENIO_BL31_LOAD_ADDR``.
+
+``TEE``
+   The U-Boot build variable naming the OP-TEE binary. A standard OP-TEE v1
+   ``tee.bin`` image is supported. Binman removes its header and derives the
+   load and entry addresses from it when creating the FIT.
+
+These binaries must match the selected board, its memory layout and its
+firmware security policy. In particular, a common image layout does not make
+DDR-loader or OP-TEE binaries interchangeable between the two boards. BL31 and
+OP-TEE must agree on the secure-memory layout. SPL passes OP-TEE's entry point
+in the standard BL31 parameters; ``CONFIG_SPL_ATF_NO_PLATFORM_PARAM`` suppresses
+only the separate platform parameter. Place
+``ddr-loader.bin`` in a directory which can be passed to binman with
+``BINMAN_INDIRS``.
+
+Building
+--------
+
+Select the defconfig for the target board. For example, for Genio 700::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ export KBUILD_OUTPUT=build
+   $ make mt8390_genio_700_evk_defconfig
+   $ make
+
+Use ``mt8370_genio_510_evk_defconfig`` instead for Genio 510.
+
+The default configuration builds U-Boot proper and SPL without requiring
+external firmware.
+
+This produces ``build/u-boot.bin`` and ``build/spl/u-boot-spl.bin`` without
+building ``mtk-boot.bin`` or ``bootloaders.img``. The DDR loader and BL31 are
+not needed in this case.
+
+Enabling SPL also stops automatic generation of the standalone
+``u-boot-mtk.bin`` BootROM image. ``u-boot.bin`` remains available for use as
+BL33 in the legacy FIP flow.
+
+Complete firmware images
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Enable ``CONFIG_MTK_GENIO_BOOT_IMAGES`` to assemble the complete firmware
+images.
+Packaging disables ``CONFIG_SPL_BINMAN_SYMBOLS``: U-Boot proper is in the
+separate firmware FIT, not adjacent to SPL in the BootROM payload.
+For example, with the DDR loader in
+``/path/to/firmware/ddr-loader.bin``::
+
+   $ export BL31=/path/to/bl31.bin
+   $ export TEE=/path/to/tee.bin
+   $ make mt8390_genio_700_evk_defconfig
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable MTK_GENIO_BOOT_IMAGES
+   $ make olddefconfig
+   $ make BINMAN_INDIRS=/path/to/firmware
+
+``TEE`` must be set for both configuration and compilation. U-Boot uses its
+presence during configuration to enable the support needed to preserve the
+OP-TEE reserved-memory nodes in the devicetree passed to the operating system.
+Do not deploy images if binman reports that it used fake or missing external
+blobs.
+
+Binman produces two deployable images and one intermediate payload in the
+build directory:
+
+``mtk-boot.bin``
+   A MediaTek eMMC image with load and entry address
+   ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``. It contains the DDR loader, padded to
+   ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by U-Boot SPL padded to
+   ``CONFIG_SPL_MAX_SIZE``. The fixed regions make every byte copied by the
+   external loader part of the BootROM-loaded image.
+
+``mtk-boot-payload.bin``
+   The raw DDR-loader and SPL payload contained in ``mtk-boot.bin``, without
+   the MediaTek BootROM header. This is an intermediate input for external
+   MediaTek secure-boot tooling and must not be flashed directly.
+
+``bootloaders.img``
+   A FIT image containing BL31, U-Boot proper, OP-TEE and the U-Boot control
+   devicetree. Each component has a SHA-256 hash.
+
+Binman also creates ``mtk-boot.map`` and ``bootloaders.map``. These show the
+offset and size of every component. The FIT can be inspected with::
+
+   $ dumpimage -l build/bootloaders.img
+
+Signed bootloader FIT
+~~~~~~~~~~~~~~~~~~~~~
+
+The default ``bootloaders.img`` contains hashes but is not authenticated.
+Enable ``CONFIG_SPL_FIT_SIGNATURE`` and its RSA/SHA-256 dependencies to sign
+the FIT configuration and require verification by SPL. Binman expects an
+RSA-3072 private key and certificate named ``bootloaders.key`` and
+``bootloaders.crt`` in one of the directories passed through
+``BINMAN_INDIRS``.
+
+For example, after enabling ``CONFIG_MTK_GENIO_BOOT_IMAGES`` as above::
+
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable FIT_SIGNATURE \
+         --enable RSA \
+         --enable SHA256 \
+         --enable SPL_FIT_SIGNATURE \
+         --enable SPL_RSA \
+         --enable SPL_SHA256
+   $ make olddefconfig
+   $ make BINMAN_INDIRS=/path/to/firmware-and-keys
+
+The configuration signature covers BL31, U-Boot proper, OP-TEE and the U-Boot
+control devicetree. Binman injects the corresponding public key into the SPL
+control devicetree and marks it as required for FIT configurations.
+
+This signs the firmware FIT loaded by SPL, not the BootROM payload. To build a
+BootROM-authenticated image, pass ``mtk-boot-payload.bin`` to the platform
+secure-boot tooling and let that tooling create the final MediaTek wrapper.
+Key provisioning, rollback protection and BootROM authentication policy are
+outside U-Boot.
+
+Installing
+----------
+
+Use the board provisioning tools to place the images as follows:
+
+===================  ================================================
+Image                Destination
+===================  ================================================
+``mtk-boot.bin``     Start of the eMMC boot0 hardware partition
+``bootloaders.img``  GPT partition 1 in the eMMC user area
+===================  ================================================
+
+The standard Genio 510 and Genio 700 partition layouts name GPT partition 1
+``bootloaders``. SPL selects the partition by number through
+``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it by name.
+
+Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
+the platform recovery path and any backup bootloader partition while testing.
+Selection of a backup partition is not implemented by this SPL configuration.
+
+Using Genio Tools
+~~~~~~~~~~~~~~~~~
+
+Install `Genio Tools
+<https://genio.mediatek.com/doc/iot-yocto/latest/tools/genio-tools.html>`_ and
+obtain a `prebuilt Genio image
+<https://genio.mediatek.com/doc/iot-yocto/latest/sw/yocto/download.html>`_.
+The image must be compatible with the target board. ``genio-flash`` needs its
+extracted directory for partition metadata and the download bootstrap. To
+update only the primary boot chain while retaining the backup bootloader
+partition, run::
+
+   $ genio-flash -P /path/to/genio-image \
+         mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
+         bootloaders:/absolute/path/to/build/bootloaders.img
+
+Genio Tools uses the default bootstrap from the image directory. Keep
+``bootloaders_b`` unchanged until the new images have been tested. Add
+``--dry-run`` to check the selected files and partitions without accessing the
+board.

-- 
2.55.0

