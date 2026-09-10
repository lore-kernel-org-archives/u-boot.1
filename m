Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299D7C79FB7
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD43C40A3E;
	Thu, 10 Sep 2026 06:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3TYnN7Br8ZiK; Thu, 10 Sep 2026 06:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E68D240A47
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789021590;
	b=P7R+XYhkiVRa1T4I5HBzcgbm1dhYs3qStnuVZj9eL/Hljg4s6aaWvujd1j2Ih9XZTJXS
	 WqJgVhDDy5CG6ZZKSW04pr7pAeLmH9pOvo7rR4ugIY4X9KK0tno23QlkaLNlQOSoq/LTB
	 3RPSpXrVChtCUoqatMImMvJKoZoZRQ32dD2bYRLnZjiNBkTy7fn+0WAAuvN+7kCR29SzC
	 7udvGvc9WZ7de/q8KVaC65rHXm5HvcaGX8L6zkYVuplW6x0BTSKigcG60j1XrwxvpMSOj
	 RUT65Uj5Xt1iAPknd/bsQfv64OxcG0XnE/Wc9Xb9VV4xU9w9uD7Cz6Q/0jlCmOQfejw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789021590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Z40Ti75lV9XoYqcGXfglU4hchKjTV1nigUDhu7Lr0ik=;
	b=MDrIN+S/4hJHdLdd5W1whPTpZdUqLq2yWcunC8+MFmOIsKv8ZBIduWhtT6u1iauUVk/q
	 nnSb6YzQtKQgzOg2IwVUzYbhI+5NPJbYy6z9iRyJ3PCjK+xNzqWhAUNMSDJD0nolw3U+V
	 FHp78YSFtv0OTnyb3xHbe2BGHDl6kYZ9ei7OQMbsqyTAtbKKxFxs19nQ2HWU/gT81zncg
	 FGoy26Ol1ltv8r9/28p2Nk1t5RP6UrNsPJGjXpUkrgM40XQuFkTCiXAqADZ+yUCi1imjn
	 vglb+FIUYXho1z3NBOfG+PCVfUAkxdRzgEIVISsBdylaMf1R4nIQ6YuysCg8JxFHNjQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789021590;
	bh=Z40Ti75lV9XoYqcGXfglU4hchKjTV1nigUDhu7Lr0ik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=frf90k1jdij3ehAKxTuKnK6eAKYcSNoT1oDoFzYBs+J/5OKazuKI37Z3Q2XaphvSl
	 NayDHWfy/mMyEPV6IwxrCMTtKmWleuhkJyGRzke7TtE3ZJg/C647DYpf2PtYpXmvnp
	 TrZN8Q68zlQHZTRIzd1LXkzOy0Uf+CeWkxqkj8iQaBLZJ4/ZD5+XY+RQGsI9Hr9ms1
	 OHQeXQv/chwhB7uz7n8FsA7A5w3qXN1gM8FFsWYG18krJ37ttIB7QPLeWKfs3NV6z4
	 q2emEtUkH564amPlGQwlhJ1nJngiS7VVcGzGDRCPjWc6uShH5lCsL2mKdVViQaN8Fo
	 +B2Y9yiuwRWRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E68D240A47;
	Thu, 10 Sep 2026 06:26:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 35C223AF
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 325C980F0B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id weUdckhCVwgi for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 84B7080EEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789021581;
 b=Rbnpiiwk3wXDJ+GigkmzUeJGRcOBAZYVgqJQMPz/LJY7DtVqyAT2ebJdqEDwzzusnqA0
 VFsL05cUXNIHl0Q3H/ild+xbt/+4L/bWdsUbcIse7zD8cUouEJu+KJJ3zj2a0C81svoMf
 d6KMechglNj1BuXfS6IZYcCC2VjnM0iWnkcnDG0fCNCUaPaC877aLb/pp6DCR6LbbckIC
 HWt1RBzEeoWtUeCgHQXP4tTpKObKBB1iti6/y4FVA7+CeupU+BsVBDr9/l5GF7KeVVflS
 FtYURxMsls0ZlGx5oCu6uw0HrVakVd9lMCQ64GBw96mrstsxvY9SHwbmXoktBUaekrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789021581;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=Z40Ti75lV9XoYqcGXfglU4hchKjTV1nigUDhu7Lr0ik=;
 b=s1DOsK9Go8CJbZl7y2fk8dVrCgmhNdjaRWwOd1X7T46RWnCS8agCFVH1J9NVAnzvoeZ9
 b0H9yhhZufGS6gVNSbsfbtcUA3sLQTg/9EPxRiffJB1Cp6rxoFykgPe6KAlL9WuEMtgHi
 rADVgNmqu+bOwXSwWtK/K8dqrLuaA2sSZCg/dLshNy4oVtYJcf1qQT4QRWe75U7yGJjh2
 wHwuZbXCxsx0zvrmuq1V+cRFcCcXcvB+Vs/WkQ/wIkw47zA3TvO066sUeQYjD4yUZN5oj
 PNZ9bwdwOusJnT8gkvqeRcZR7aH124k11dKrY6Bsbe8f3WXfOied/BjleeUKnn0cHQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gpsyr0g3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gpsyr0g3
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84B7080EEE
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:19 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso64178975e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789021578; x=1789626378;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z40Ti75lV9XoYqcGXfglU4hchKjTV1nigUDhu7Lr0ik=;
 b=gpsyr0g3HJA2FRTIUsiDvty87Bs/FbHRNpIRzyFbnd51b4LVjRHNy9ojbjgU3Ms3nq
 AWAT1HEK1gZfc6E/k6lG8muHTha/fm8Yb9aVrqUzIsZl2uqVhaLO6cNzfPx4kgSzy+Hn
 jpLmsf5JZOv31y2QAUQUwGZguB0HKFyXeFAacrlo473XKy8DLPd+BU2gcxJJ0bs9xvsa
 Q+0SEAXjRcQnnITN2oZMnWdi5A5SJfUse/4SDy0cgkPgQopyuuV9yvfn4EhDf/42kVD3
 aqJziq2x33Iqz4pd94VJp1IPwpCRllEgOwRnMd4kJFzmaSlLThqLTpQJrkVDqnWmniAz
 ZqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789021578; x=1789626378;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z40Ti75lV9XoYqcGXfglU4hchKjTV1nigUDhu7Lr0ik=;
 b=Dx7K+/mOjJsO85q4xxyf8v39mxMGBV5iwkoeC88vR7xQeK3yW0+OAqlgWiKZePEZUj
 sd7p5XvZqfNiTwzC4zMXWGHrRAK9SAYCGneisRRoxe4MGkKo6fZp8CxAZRFl2Kym+aE2
 GJlF0ZXcpGbKwkLPgZpPTpIjBnxU3giwElMFTMaogdlwoEYfeVwDZwKI6d3DcOPJrjcq
 /nkN0onrXE/cu0OXkm4kJUk7ewo1H1iqWzmeOBWTLs/t9dvej30GqPOnkmkeuH1od51I
 9coE5rR8PfSUztuE8H1gV3P3PPm9dUG33bT89Cf4B9Kewe1nJRHeJcJTcS3UIbDnEbfw
 S1dQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhT0Am/L1SpdfI77gX6PCGh56kTDj4H5irIgG6SCJWBveFshLKfOSZSW5miug+7lj5G21zf8M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ms2SgUEX6T/qUBCD06zRM96hPXlyijRUuhNv0PpdaNZAVhOU7a
 Rr3hb3bDQunn8tzurtnkh6mXW2eAqGMLpVvEUwA898iuxIslv6Gps28zeXYInCgFhr4=
X-Gm-Gg: AYBFou3BdVRWTaYO5XXRAue1rB4F+zaPuQb602JColtQSdzRp3FJhuRzhvwZ0Um5ZtO
 4JJAYBMbWje5KoziDe9TOKwbx3YWs+9Sp1r/ifmVLDlbOAO0FYsBhnDHrUl7oSPXdamflOW4rDA
 yZjAekmhIjegadpxiRJeRTGFTTIPmLQt4CTINzALaVY6fY8CYVlZyunM6T2D65y/fsMZedTvj4i
 DEYyNyOeuRzXf7xFyMHu6wLilJvX2eNZGmFIoJgZGRa//96splBl+rMorTDj8zL1gy+XwT6RbRm
 AhAEMOnGMciTto0ZXIccV6hY6vZb5gGLaJbC4GP/yVdPaosi1LdH5ZELoMyZKmfiWInHwkJlftg
 6fJsc85PryzJkYmRXd9xyyIJ8CMpE53TpboW1a6z6JCwVzVtjm3GdjQ4KILI637Ma8bku1gysdk
 uzrQzmAk8FNBH31sbVvNeLlkNlHQS1RLfYUE1p2ap6CuZ3G1KJK2GmYjRpCTGlRAj5E4FDxXCd7
 36U4rKbE5PabYLZUpBxRWEk38OQgJ1N/txRM/taGNPNp/+IBVPfsRmRzZAut4lRdIDou670jYFA
 9OhJyWFT8311KMzB6ykYFWOHUA==
X-Received: by 2002:a05:600c:4691:b0:49c:fea1:f792 with SMTP id
 5b1f17b1804b1-49cfea1f79cmr356061015e9.12.1789021577898; 
 Wed, 09 Sep 2026 23:26:17 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm52279585e9.9.2026.09.09.23.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 23:26:17 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 10 Sep 2026 08:25:55 +0200
Subject: [PATCH v7 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ccaione-upstream-mt8390-spl-v7-6-0a5cf09c5761@baylibre.com>
References: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
In-Reply-To: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
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
 <pablo.sun@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
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

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 board/mediatek/MAINTAINERS              |   1 +
 doc/board/mediatek/index.rst            |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst | 281 ++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 4a574250fb1..5b0d79320bd 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -30,6 +30,7 @@ F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
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
index 00000000000..e36e8faeb48
--- /dev/null
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -0,0 +1,281 @@
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
+``CONFIG_MTK_GENIO_DDR_LOADER_SIZE`` reserves space for the DDR loader and
+sets the offset of the following SPL region. ``CONFIG_SPL_MAX_SIZE`` is the
+size of that SPL region. Neither size needs to be equal to or larger than
+the other. Genio 510 and Genio 700 reserve 0x4b000 bytes (300 KiB) for the
+loader and 0xaf000 bytes (700 KiB) for SPL. Each binary must fit its own
+region, and the layout must match the loader's source offset and copy length.
+The loader copies only the SPL region to DRAM.
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
+   loader region; binman pads it with zeros to the offset reserved before
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
+only the separate platform parameter. Place ``ddr-loader.bin`` in a directory
+which can be passed to binman with ``BINMAN_INDIRS``.
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

