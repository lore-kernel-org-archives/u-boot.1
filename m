Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7EDCA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BEE380B33;
	Mon,  5 Oct 2026 22:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-5M7AqdAkCi; Mon,  5 Oct 2026 22:11:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 49D6D80AEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791238275;
	b=izhq1ongSkJ8vhyj7TZzL28bOzeMpdg0pZIedfrcDImPKPj88Vg0Q9RNhzPT/xnPX+ht
	 xvvaQpoLfTXuscWbUFd7zstIP34x5zY2K0Hwabacj9hQ/R94iiaMbyRdUTYGAQnPSIH3b
	 eiqJ/7dF5Y2pZzRg6O9LmYTEZKN+nGSYRJkzuKQvZCBTH3DdcsBrUGgdh5q+JvS+8+Mt4
	 520xFL3NDeQ9lfW+6MLQGCAae1+w8spZFlonSlwyeoogI8Eq7VmupiCj6dNtjgNl04xqk
	 NJnG4jD7qEzvM/HE1VuQgznsykFsC46X22ceeMVvMkGqdjUtLiAq5lfOMX/VNjT4zPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791238275;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jqo/pxbhGjXSMiyhaYnGMP9/6jyd9HvkdhhWjfbrCm4=;
	b=lp9CkAY0Ur7vIOhMVN0UaCurBjGddVVoF9EnRHxy6h6Ms1rOYFnOJ8fRKQDLH1PxD4NS
	 S4bJMFslPHi4jpzf4FEK5Wb0ClieGX9X2wEoU6MtaoNv0w/yDWscCBUUdvrsK6Mxxiwg/
	 zwbswc9rR6QWbNUEsGBCRAJeB77yTQ5f4FtNdA9XB1PAK0f+UkkAcwIj9vZQHV74ue7kl
	 CttpZMZ/NMmCxw6ZFMFq/c/go8f6k784ddIhRrSLZl4O3fhYa9tEvsRySRcmePFWH8dPv
	 oGe4NwtA+5Gk9F/6ZVkdki8TP6idE7SbONRumbaD2m55Miy9f7GwT5SKNAu3WY6QTDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791238275;
	bh=Jqo/pxbhGjXSMiyhaYnGMP9/6jyd9HvkdhhWjfbrCm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fe/rg9jo0Da6e2hMFS0ttUAb/ezkDCDeP3aZ3wsG4eSZ7Dvebf3f9lNb1dqb7TxG/
	 lGJg7N1VwSvFGGX6sxiUbw13bD3q0kCa3Tl91PJlDBd8SWx2d+CI5qjd2wtNv+naJm
	 D5yQay46+6arW5i4mLqofa5P6sdfA1jIFJNfOil1IiCufXJI4YAi8QtMBma2Odvw5j
	 I5mO6wFEkHXaJQwGOgwxG9K4Kcjh8XLsEREDccbjMBhIqF9mnQEkyke6d16nhMihPv
	 Liinab6b6PVHogWZvXQEogbHkDZWjrfD/ebGLmA7Mu7wbAfKGWeTS3X4VpEdSvmmrp
	 YqJNpRhycFpbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49D6D80AEA;
	Mon,  5 Oct 2026 22:11:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6052E1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51926606E5
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3k7JubLCIG_E for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 854476065C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791238108;
 b=LMbn2kY+hfOxJT34rOci3w2LElz+6rkKpdfRNc0K5eV+WTOqewhkv6RY+GEM/VIeSXn8
 bA0/gR27g7a0YmtEmMwwHHTL/cW7pGgQrIzzkY9pGogz1czD++yRTc8tjt2xhfwbxS0mM
 YQdmY5/2K1ga3ausd6t5VXWWgbzGma0gtSahNy+n+2BiCIACzzEdICmjak8zYPYC/32XH
 T68foDt4NQciTd2zF/BYWr9raSIvLMmsPs+/OYPYDMbHiDqQO+oT3sk9qmkU2u3DW5dVf
 I08xXjTp/PMDbE2qHyyQqALycoy18OU42DYfP37HODw1yD9S555XmhUW/w62Cy6R08Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791238108;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Jqo/pxbhGjXSMiyhaYnGMP9/6jyd9HvkdhhWjfbrCm4=;
 b=PQKGko7afMQ70G7XmWGz815k4bwye4w34dNPKc+eXD8s7hjSK3NyJ1otrpjNYNIbYmtM
 Gl4J7Vl1tPhIXxeWE0yjbAdFfZPLf5KmfHu2/XqbJbzMzpViPX7hBs5MECxkD/WuNfOlH
 pWiQJ4Sx5dy0NXgzzRvwchLjN79F1dCHSDDrKt7uNbQ8cucCbNppxkhyfLsMbecZJycvw
 0I3Eehfh+psC8ov4B83B7VEvFcabnhsNjoI16Scy7B+0C9sUjm3oh7Rj2i3SOw2KGbaic
 euyu88l5PdA9IZ6nmZuXbiCstKM8aJw1CGlWerKzdUw5H0BwDCgCvEpmNme0xOniztA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZaJrU9a4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZaJrU9a4
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 854476065C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:27 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6b0496f4bbcso1311651eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791238107; x=1791842907;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jqo/pxbhGjXSMiyhaYnGMP9/6jyd9HvkdhhWjfbrCm4=;
 b=ZaJrU9a41QVZz80c7tPpVWD/0yBf0xoHnphJ+72ROiACO7w6CFP0IaC51uZPGNde3q
 Z4gaywhlV3B0VYhRSfMmY3v7vP+hJJuyjn1LJtZ7cDtyUvR5QBz5ykv376ADvhyjelFg
 oCTTPBCoOCGWodPTL/lp8fru3BUMVyWjiBxEaklhbfmIDhG03Tf8KXl2uVxiSJ9i3L5J
 TjIqBEd2eAO6rwSQpw70hE7Bk0tktF6niVbRuxz3CovgzsZ3oQGAgK9153qtdW0qXZIu
 EQYshf0Lar6i6zQ7qIVJSz2dxx6f/vmRq2EBZL6U/D1QXX70xdP3zoi0tDOEcx7FaeqD
 TzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791238107; x=1791842907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jqo/pxbhGjXSMiyhaYnGMP9/6jyd9HvkdhhWjfbrCm4=;
 b=OFXyeKQa7hMNa9n32B2ffaiYNQv0qqtlOhG+Kv9SetjuS+oFnt9apzeSmLPpRVZFYH
 PWCHrIjyYQ5cHk7hMxtT8ge1/mdSeQkAg+WikoJ8ieuJtmfiivevpuPsGo+OJQ4gH62X
 JY3sZnuHdBeU0o6mtIHd7Xb4CMQAq9fpbqDHICpjcTaM+zwwnzJ34QIzZFf59/eJVPnK
 NbSit6yY2SXfxxUcREtuYDzLzlMItf6KsaJn78X2OHEZbgfY7gaLH/SIHsmJZhi5N/qn
 mrNPEQ1mqzmQhJ/71jx/VmmbXj5ZeDzD3nCpEoBfuFi+ipN8EXJlhiY3VcM2OkIsk0yq
 sLeg==
X-Gm-Message-State: AFuF++l5y1BH9IKKzB8ypNIFJZ2KcvPp91iPpmxHjQrBcEt/qc8LwAYu
 1AxrsB9DZuyCJ++VoS99r5aW308DOXBoaEUo1FTk360cS+xFA/rw6ADw3MFxtEVGtow=
X-Gm-Gg: AYBFou0jNSYpTj22Lf/RnR0EFowveB+UzxvR8ShsskJEI3ijkpOSWl6e+e1X4BqLpbl
 ptDybpJ/RToNNAZ7TP5Z5Ktci0jHjS0IoefhFEavWLTlXikipxN/a7km+/JODKxkVK+w+wlBFBu
 4KF/winLmey80c/dLgGHRuqFPsVDphG1vzRpks3Ge+pNAUsYU1/aoEq6cOUyFRzdAhMaj0Udm98
 cNjRWiRdtu2bXfj4mVglcHQaVLgZ1jdn5bYIhw6t6g+truyxPtP2DV2j/EdDVq5hFNNZbDdIM7U
 0v9V1tTJtIf8OIpzUkSb6aSO2NoQrWbvnO7nj5KjKPeo5sS/TMrzLimLWNvHRuuq5WAi1IZQTcs
 YFH3uaXsQVuQho0we0rrdkvN1PfF5b8buQ9/aPFia6lJ++nMP85QkPEn9EbTMRZua1J1knIjGs9
 p81yUAQ8TAX9rztDSXkU+42R/WP8FYkqniT9suXmJx/JRRuJrAJR30HtCxyuul5Ojxntm0DR007
 ctxdKXDCahYBA==
X-Received: by 2002:a05:6820:1529:b0:6dc:e1c3:b2ac with SMTP id
 006d021491bc7-6e09ef48507mr6180030eaf.73.1791238106766; 
 Mon, 05 Oct 2026 15:08:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8281db4582esm655718a34.3.2026.10.05.15.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:08:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 17:07:48 -0500
Subject: [PATCH v6 2/4] arm: mediatek: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-mtk-genio-360-bringup-v6-2-630f99bf3ce3@baylibre.com>
References: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
In-Reply-To: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5188; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OqxN5EUtLkK4pfdSPmAbbg+1IXry84hgngJQst38bfw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxB/Deme2w2Rnv2LGmZB7x7Af3qQqL5BuaOQKX
 j1rU5y6/Y+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQfwxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVOQH/3IwANdtzHQ6ayh4gf3TqHvOrhSHPQf0Ua9SODu
 zglmm+vCHxWhjAIk2ChA0Ip3G9EfoYFGq/Imvf+tCwMW0nEKNvO/FwQ1tPjgjiFtvzq3Hcvynzk
 FWnHtFrYDtwHFb2gG0SipS5vr+LbbXWp4wmCXzIOvYvEH02t57q0ItQXPyoD0c3gNsiXTWmlG2g
 Eb0LbizpKjseUpAwFhKEu+HCaNGPWsPsMT5wZpOnlIi6QOVMi9mu8Klut3OVehz5KG5GCMj75MG
 odpqtT3RsH29vkYIE9NJ7/UxGnKaujB2sdEOYQBGndetRa4l7rJ92PS0SQ835lVwS9YAtxmcvoJ
 i14k=
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

From: Chris Chen <chris-qj.chen@mediatek.com>

Add basic support for the MT8366 application processor including init
Kconfig target.

Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig         | 12 ++++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/cpu.c           |  3 +-
 arch/arm/mach-mediatek/mt8366/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8366/init.c   | 58 ++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index e572cfe8571..16287d0bf2a 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -119,6 +119,15 @@ config TARGET_MT8365
 	  It is including UART, SPI, USB2.0 dual role, SD and MMC cards, NAND, PWM,
 	  I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.
 
+config TARGET_MT8366
+	bool "MediaTek MT8366 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8366 is a ARM64-based SoC with a single-core Cortex-A76 and
+	  a five-core Cortex-A55. It is including UART, SPI, USB3.0 dual role,
+	  SD and MMC cards, PWM, I2C, I2S, S/PDIF, and several LPDDR4x
+	  options.
+
 config TARGET_MT8512
 	bool "MediaTek MT8512 SoC"
 	select ARM64
@@ -159,6 +168,7 @@ config MTK_MEM_MAP_DDR_BASE_PHY
 config MTK_MEM_MAP_DDR_SIZE
 	hex "DDR .size in mem_map"
 	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188 || TARGET_MT8195
+	default 0x100000000 if TARGET_MT8366
 	default 0xc0000000 if TARGET_MT8365
 	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
@@ -208,7 +218,7 @@ config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
 	default "media=emmc;arm64=1" if TARGET_MT8188
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config MTK_GENIO_BOOT_IMAGES
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..51bf5789bb5 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_TARGET_MT8188) += mt8188/
 obj-$(CONFIG_TARGET_MT8189) += mt8189/
 obj-$(CONFIG_TARGET_MT8195) += mt8195/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
+obj-$(CONFIG_TARGET_MT8366) += mt8366/
 obj-$(CONFIG_TARGET_MT8512) += mt8512/
 obj-$(CONFIG_TARGET_MT8516) += mt8516/
 obj-$(CONFIG_TARGET_MT8518) += mt8518/
diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index 56a41e42df6..04ede8823b0 100644
--- a/arch/arm/mach-mediatek/cpu.c
+++ b/arch/arm/mach-mediatek/cpu.c
@@ -39,7 +39,8 @@ void enable_caches(void)
 u32 mediatek_sip_part_name(void)
 {
 	if (CONFIG_IS_ENABLED(TARGET_MT8188) || CONFIG_IS_ENABLED(TARGET_MT8189) ||
-	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365)) {
+	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365) ||
+	    CONFIG_IS_ENABLED(TARGET_MT8366)) {
 		struct arm_smccc_res res __maybe_unused;
 
 		arm_smccc_smc(MTK_SIP_PLAT_BINFO, 0, 0, 0, 0, 0, 0, 0, &res);
diff --git a/arch/arm/mach-mediatek/mt8366/Makefile b/arch/arm/mach-mediatek/mt8366/Makefile
new file mode 100644
index 00000000000..661744a4398
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8366/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += init.o
diff --git a/arch/arm/mach-mediatek/mt8366/init.c b/arch/arm/mach-mediatek/mt8366/init.c
new file mode 100644
index 00000000000..df9c9a7bb2c
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8366/init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 BayLibre, SAS
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Chris Chen <chris-qj.chen@mediatek.com>
+ */
+
+#include <fdtdec.h>
+#include <stdio.h>
+#include <wdt.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <dm/uclass.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+
+#include "../cpu.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
+	 * MMC requires DMA buffer allocated below SZ_4G.
+	 */
+	return min(gd->ram_top, SZ_4G);
+}
+
+void reset_cpu(void)
+{
+	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
+		psci_system_reset();
+	} else {
+		struct udevice *wdt;
+
+		uclass_first_device(UCLASS_WDT, &wdt);
+		if (wdt)
+			wdt_expire_now(wdt, 0);
+	}
+}
+
+int print_cpuinfo(void)
+{
+	u32 part = mediatek_sip_part_name();
+
+	if (part)
+		printf("CPU:   MediaTek MT%.4x\n", part);
+	else
+		printf("CPU:   MediaTek MT8366 series\n");
+
+	return 0;
+}

-- 
2.53.0

