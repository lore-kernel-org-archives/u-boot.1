Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271D6E81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E82805D7;
	Mon,  9 Feb 2026 18:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZsMWLjW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2D380325; Mon,  9 Feb 2026 17:40:26 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 593BE80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d1851d85daso1182097a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770655223; x=1771260023;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O/D6UJIErIuubAh79jr2Jk9DAzywbEtP3NW2ik1LJEw=;
 b=ZsMWLjW25ZF6BTzZ4Yi8n/EhsfH+Ud2k1OMBy2E1XZ5jz1zsAXs/c5nPTR1SBG7vNx
 c2odv+WSWfxAUqiIhyCbZ2qkD1d5y9Z9+xPKjGSUVVQ5HG8Eobjqy0Fndg0Co4HTpCad
 3U6h20HjvtcZHCPDM2tQbtLvbX/xKtoK4oOBBD9HtHr5NNaX8ctA90GP6fscRXLozcEW
 c/uxOivHFzSaodF2YG5RCXY3lpayszwXWXWlGkfI0I4l0pfotCCruRRsgettcN8wcP6k
 Zk/NVyz6o2z7/9ISMgxxs7oaNfBZ4PUrDijLdVYsAjaTNoN6VfgtYAiKMTbEbsAl+v0E
 PC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770655223; x=1771260023;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/D6UJIErIuubAh79jr2Jk9DAzywbEtP3NW2ik1LJEw=;
 b=bWFCwytVznv3SCCm37ZgGSAX57XKyhrDN6bEPApOp94flUSYrkffXlDcKEZb3eqV0w
 bPk+Mt4gffhJvv+ZC0TcZzVY6Nbh3/WFLojYn+SLj8jX8gkXzmEvez0OaMN2nWcLZVq0
 ANsBLnGLOrl3mVjLBZ9pkbqu5Pt9LKpO5tY9G+QCbhzZ8geHkGM6K13iBPJX0nRdolX6
 q1emV7+UpH5aLLOLsq67h8GwiS0Vq9Pf5PLjfeQKnZpYpnL6CYlVX+sRDt9OMCx0XIRy
 JcjG/G8/YrPbfmcDv6Fz2OzOXeFrMvlUWNgRVYttNKDuwttLTbN+mwvTwTp8P8kkBc7L
 Q+kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUirLSMXki40FDZbjRohiJJSLWcbS7H8ghv1pBStk9g2rWqayUXnoE2vLRNjYQ4T0+O3QjuaSU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7iwYPpBs/u3Xho0owJWGirQKr5R39cVy0aVM1raBVwXClY/NV
 Azqikfn226Ps4QAkfb5TEeDNyGVx1NR21w9gg47EHgpP5S8YljxSHMxSmImx3TxHBTw=
X-Gm-Gg: AZuq6aIyK8Izn09C/W09yRI5N8Y3ktWAB+b9H9/avk5uItL/qWRCBrl5NT+9DtLTAFc
 ax0zzFO5/0655V+ZEU/lCDrV3gfRJP6Ta6yTmphSqkoHdsdqyMptM60GESVZ+6+wdYhDEsBULGz
 fxTnPR1NqOSH/nA7+/BCbnlxejGMm6sPJCkjLVFl5jA8v6iHoPYSkBIQSVsx3X0hAqmPsDp+aza
 tAaT1DbzpeJeZGITPkp9y4MTbfoPwhUJuyci2gOARh7CrgKPT8Xa9CJc8/s1WmSV8dkbnyeTvzT
 lC4ci9VKkV8iWmVRdjmf4vEuubUfErLTnqKBPvLhhp/GT0n50mWoX8Zi2T1S8j7/Madm1utb4TE
 YMb319M08XfJugm2OGfW5rfd7Cj+D86/OTtzlG98SU5ig86ZtiMP+6gcZiwx3jSJ8KXcDKks9v9
 +dBGcONuhXLzwJhUU=
X-Received: by 2002:a05:6830:6518:b0:7ca:c723:6f42 with SMTP id
 46e09a7af769-7d464406028mr5778758a34.10.1770655222977; 
 Mon, 09 Feb 2026 08:40:22 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785d7esm7731139a34.15.2026.02.09.08.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:40:22 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/7] arm: mediatek: clean up some redundant board init
Date: Mon, 09 Feb 2026 10:39:25 -0600
Message-Id: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NOQ7CMBCF4atEUzPIdhYDFfdAKbwMZEQ22UlEF
 OXumJyA8nvF/zaIFJgi3LINAi0ceegT1CkD15j+Rcg+GZRQlVCixG56Y2dcg64l0+M8op/Hlp2
 ZKKKpvLa6KHOpr5ASY6Anf478o05uOE5DWI+3Rf7WP8OLRIFW+8IUuZMXsndr1pZtoLMbOqj3f
 f8CW90NucsAAAA=
X-Change-ID: 20260205-mtk-mach-clean-up-duplicates-a6d7b7453179
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Tx7BYgkFxC+1qXVMt5TM5rryQBw0s57Due636D7hB4U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpig3B3n7JyehNoy0ijPzlPfX2/PYSTIuRllplx
 cdpOEfymRmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoNwRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArMoH/09aVLX6wFbWpRQz70nX9uTWkmrla69euySKRbN
 l9pxifpDOAR4jID3Ydl+RvCVd5OEMkq+NWKnrFkAnBJ3GInkuCxD2zE6+03qeObesXNc2XWZiYy
 dfuPMZZHh1a2efA+tOWuaxCVI08VuQuGVV/XEZhJ/BJ64ao3LmvFu6M9J4YTdYy3NLGsPjwZ5Nm
 kKjDI9EdrOBHjO7Nd1Un0rQh4I2hM6BbqW4DHn/Bm0GTbSy5xLG+tYwRP74M2KSTeDFJ/7YbqVK
 L9p3CFrs9LK3GZ9HuMoP+MN8m5/fQk8V84hpKg7ev1LVl11X0yBGsTeuB7X0234xJACTl8DcxEc
 mvdI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:12:16 +0100
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

Before adding more targets, we take a moment to clean up some some
redundant code in existing Mediatek SoC support.

The first three patches are removing no-op functions. The last patch
generalizes the mem_map code so that it can be shared between all
Mediatek ARMv8 SoCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Also delete no longer needed init.h header.
- Don't delete defconfig maintainer entries.
- New patch to move MAINTAINERS files.
- New patch to add CONFIG_MTK_MEM_MAP_DDR_BASE_PHY.
- Link to v1: https://lore.kernel.org/r/20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com

---
David Lechner (7):
      arm: mediatek: use default weak mtk_soc_early_init()
      board: mediatek: mt8390_evk: remove empty board_init()
      arm: mediatek: mt8183: remove unused function
      arm: mediatek: make mtk_pll_early_init() static
      board/mediatek: move EVK MAINTAINERS to common file
      arm: mediatek: consolidate ARMv8 memory maps
      arm: mediatek: add CONFIG_MTK_MEM_MAP_DDR_BASE_PHY

 arch/arm/mach-mediatek/Kconfig              | 27 +++++++++++++++++++++++
 arch/arm/mach-mediatek/Makefile             |  1 +
 arch/arm/mach-mediatek/armv8-mem-map.c      | 24 ++++++++++++++++++++
 arch/arm/mach-mediatek/init.h               | 11 ----------
 arch/arm/mach-mediatek/mt7622/init.c        | 20 -----------------
 arch/arm/mach-mediatek/mt7623/init.c        |  5 -----
 arch/arm/mach-mediatek/mt7629/init.c        |  2 +-
 arch/arm/mach-mediatek/mt7981/init.c        | 21 ------------------
 arch/arm/mach-mediatek/mt7986/init.c        | 21 ------------------
 arch/arm/mach-mediatek/mt7987/init.c        | 21 ------------------
 arch/arm/mach-mediatek/mt7988/init.c        | 21 ------------------
 arch/arm/mach-mediatek/mt8183/init.c        | 30 -------------------------
 arch/arm/mach-mediatek/mt8188/init.c        |  5 -----
 arch/arm/mach-mediatek/mt8365/init.c        |  5 -----
 arch/arm/mach-mediatek/mt8512/init.c        | 21 ------------------
 arch/arm/mach-mediatek/mt8516/init.c        | 22 +------------------
 arch/arm/mach-mediatek/mt8518/init.c        | 21 ------------------
 arch/arm/mach-mediatek/spl.c                |  5 ++++-
 board/mediatek/{mt8390_evk => }/MAINTAINERS |  6 ++++-
 board/mediatek/mt8365_evk/MAINTAINERS       |  5 -----
 board/mediatek/mt8365_evk/Makefile          |  3 ---
 board/mediatek/mt8365_evk/mt8365_evk.c      | 28 ------------------------
 board/mediatek/mt8390_evk/Makefile          |  3 ---
 board/mediatek/mt8390_evk/mt8390_evk.c      | 34 -----------------------------
 configs/mt8390_evk_defconfig                |  1 +
 25 files changed, 64 insertions(+), 299 deletions(-)
---
base-commit: 42b3ee7fa5248ad89467aaf2585f4a08aedd4731
change-id: 20260205-mtk-mach-clean-up-duplicates-a6d7b7453179

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

