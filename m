Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B755C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 19:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 063F680EBA;
	Wed,  2 Sep 2026 19:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNjDOkXTuV_Y; Wed,  2 Sep 2026 19:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1DC1D80EDC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788378185;
	b=cQ3+SNAnB29d207Zij1g+r8xmvWoVZAEr1sPlHZGAM/5hegMa5Fg7dtHb2H4EKWCYd7Q
	 aW5fvUeWkZCw41idCdKstqfDaZncJTnExke6NG+nh71jU9GdDFN/7OSqrQQ7hgzPdCsOI
	 hfs3i0WdD0pXNx6B1MFCGoqw4hbJMmVw5XZHJ3JjNd1kJXnMJyleBgpMziONhhnB0anLg
	 KimwUThAaXLFlNXCM8Mib1s1ZbPyDVrbLtOOtg7SrJlLD4SSIy9v+oCnmB87izxGyC4ez
	 YheIWKAkQ0JUjaAyRsbLtVCZ9oS8CM+5o3VnAJ2Syof8c+Ix9W0U5umdqDy6iQDD9YQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788378185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
	b=kZbfzhJU5wg6HGIF/2zamD/tYI+CB4VsFdnSIBAEgjszBxGUfIZq9bOGP2bM/h5lTASR
	 4c8Nq6WQrBrBqsO+SNj8tqlrqw6nntJl4KT8Q9rSKok4c0lVoPcGyLVAcTyC4Wryfg0Lr
	 pMjfkC5qOzuB2acOtVcMxvdEmTDxYiZFvrUhCqLCrEXeNNSdraJJVG0QJp/GWgDqVtwNg
	 gxyTmVo/P/reNRtA4BF2Sv7SgHfbC4o833ziGh0o15ftjWJHOpj3Iww6XInVC1ssCCh9E
	 3+gg07X0asUhywpWzm/txoFOQ4mQYTlO47UT/gtVgT2SxhOhqxIyiqTwnnzy7TLcKXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788378185;
	bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tn8TDvx0Fz2RRsPGeENPx0NfzI19UZ3yK1l6EShGUBKaYpriw+KgWpGclb1soG8pw
	 tEfYH2mTelCzx+4uIos9LJCkD4ebeY7cEojMLJQk3fU4rq68+qY3vioVVMGYhZuyH9
	 GDjXkZuf3Z+IfcTTUSq/d8rCC4l+qlq/tyWEocIKRXqUVYjMvig2bF1uGtwW3UA0Qx
	 ebE2KJvMx+6dlY+bRXUAgUi3CZOvS/VoHoFDNiJSQMT9Tghyu6l9GB81m+VnYiz28u
	 Ym9DKjBpyRN93jzr99P9lR6fXfuUTS6Q154GelbAu88XsNv+cXonL4M+D6iKG6Ibtm
	 bYD5zXc2ahNKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DC1D80EDC;
	Wed,  2 Sep 2026 19:43:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01D911D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4F7240A55
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YtQZoCff-c1b for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 19:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 36AD340806
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788378182;
 b=cWQS5vwoJCpFgZRLzCjE+ygVHeDjpjR6i37gIRr/Wyz12Uh8wOszMITli5EPNxRayv9z
 6QWqCoF+XxQtDec6Y1wOtPzLB4YRD2Bp31DXpMCRtoEZG2OYlDtR6B2HBS/s2rjufISTT
 wm+DZxPqV94IMedBJYwuLKAvU6X/TR/gGVzDOHuaY9HyFLiKq97emS4EaJ1XXQ/mtvbNz
 pWTQkQPPDs81McFW+n5I2wg/D7hIelq14ctq/1BwMRc862wd6I0A59tPU1DXSIjNXqt5t
 kJOePBaxNP90zgAk7cMBAHrepOyL/wXb9txm97MUQIyfIUtweElLugQZZtKrJX/NxoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788378182;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
 b=CXL6fAkDeWgWIRFhFY/FrglvJ/oO3ErYgxdemAaov4A4ZSRFEeQHRK0SXfmr1hiihEBQ
 oPOVQuwzJTMCfMRLwqEKN5Hj7HdNYSucGjD2hVHV5Uf4P2IIDmFjZ3tuY8+rCc8CiwSvu
 N/LdVBY9pdywlgaMfdWzBfuMqB8um69RpGR817viCip3CSXoIe6wnRBYbdHXAyLb+tAyn
 FRc6+iWxUbcPLB0mm901Ucbg+zHwXiiqQtwRIa4IjoLg1bB8ShC/TryLSmKznPUcIPb9N
 Fel6Vqyw5hRGnq6ZaWmPnnGTHUxfZ6gu6P6CNNoB0VC//pWuxLy7kGPDt4JXBv+56Gg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Zf9j1zuc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Zf9j1zuc
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36AD340806
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:00 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4a40bcc8d69so1249661b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788378180; x=1788982980;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
 b=Zf9j1zucRS7lEmpmh8r8gREcFzEFZOSCW3xcu/KKYNpQcqB2j6fQFfFcI1aV3VrU5e
 Ss40jbWfSaI9nE0DdmWPYPNq58B/ibAY4Dm9yoX2q8eLo0UGKZhqPV0dkm95MA6pDA9V
 v0sjix2mnWiUGO54KzpV4kgslBO/yp+fshagKxMeLv7udOGYZLqcg4OAw2PYSLIyHsM8
 +malnHsQzGqtisR6OldDAWOYBwXbYT+A9lzumFVjZHEq/DwPtMs8MmHcoQdsDayxcsNN
 jdXLfZle5m+iyjcM1ywqS3IKSrjltiqrWyftenZq5++knhC58w6ElpyIuRVzZHLG+dXH
 zKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788378180; x=1788982980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RbojSCkN2gvUN8mn4UQRbJrSsinVmpY0DLpVt+t9Tl8=;
 b=rPSxhryOBssTK+d5JPiCjOh0jWk6bfb4b2fsTkW5c8mnCCfAyRMcaYRVcWkQUiR4UN
 F1XsxIC7rHeSOh1H7YpNI5B7cRCdTsGSBHA6LHILEw3mzbB143tlePqI+y9JzA0/G6iB
 87WcXx8Mxwqjz0HsbOc29xEBXnhKcuQiPC/1/ZSZAj0FJB8vIbuu0I4Hnwnpw15zl9Ls
 uLMsRAVYoJn2VQ7PrTx8dLwQLZoxneODb3yxDETx1UyzVw8d5xS4VVKIhnMsrgfBkvD8
 gffzB5d/MKzfhMDL7C3saDnREWPmYfVFs9UpaA73TkJIx65t4Q0xYKCHFldAl8ADL2RO
 ZntA==
X-Gm-Message-State: AFuF++nkChhN08GMn8d+aeVmO3zRw5FepC3Sr5iWVFbr90bX7WyMMfYk
 AqEeTUIEwHmVpYpTREPbLgVmUuhr0vwzz3Pj6tzo/xgru0HX2FK/bnBn6sjd1woVnFY=
X-Gm-Gg: AR+sD10rz9d6uECEyFiV9ZPm+LGT+IWWrsbwNT3u7uuHp6tq9YsXFKdIKBFbTVDnkC+
 pwd5oOLzp0pDWqKS6WumE3kSqR3n/CSZgkkeAthMcdGCX+t/+1rYdtgEcooFqTZHXacymhzaNxA
 83H3rEpWG92CEQzD3OhXL38GhojAx/gEa1rS5EqgHrBxu+HjSLZD/nseTu7SVqGVV/VXjASNKLd
 1Ffryc9MMORr3TalvUtomxl/FP6vW4/42DDPCDzeft7/RtxFLN0xbP8cbG+7Bl+tSK+JozxaekQ
 UORy/LfGipzvYKlXYnzforfyO2KY4+lQ+9RkJ1z+gGuTSJi1yBCvxLFG1dDWNMWMaQVrNiNsKZC
 8UbYfUAei4lP2W+qu0YhYpM7DFBQ9giSi5cSlfUitnk6EhCWDoUx4h9jtHc3DTRpfem3MlECzOQ
 SKQedqE+P+H6krpjuhvLY4OLGuwxrzQrLVTuJyni2fq5MSdsoz2G/HFFCwl/oa5kkflg==
X-Received: by 2002:a05:6820:1c95:b0:6b1:7251:41d5 with SMTP id
 006d021491bc7-6b47e9b10b5mr4957110eaf.3.1788378179674; 
 Wed, 02 Sep 2026 12:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f336c72fdsm4241804fac.17.2026.09.02.12.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 12:42:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Sep 2026 14:42:16 -0500
Subject: [PATCH v4 2/4] arm: mediatek: add MT8366 application processor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-mtk-genio-360-bringup-v4-2-2d38f522c72b@baylibre.com>
References: <20260902-mtk-genio-360-bringup-v4-0-2d38f522c72b@baylibre.com>
In-Reply-To: <20260902-mtk-genio-360-bringup-v4-0-2d38f522c72b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5191; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HJCfz15+Sxa+9bL2L74ghUglAyOGtOTeF7Az5gZEt98=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmHwmfkvnkNHxQSZbkuFLJGQL5viIbHsh7W2Xq
 JdFs4FvsvKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaph8JhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ANSoIAJMeFf0JE95pS23Y5LPc8QucyXnOq9+W6UyNwhm
 cIZoSaKE+pP+fzvqdGHw326olrpH60fdBAi3nC/gMGOl6jS4QleTPfuzaJBcBWl80hmJtulsdTj
 RJSIY5umuzi8FUVFWWRp+faLtfWdiZcK0GQF/hhztgpcq3OKV63ddg6OgESeOlgN7Yd8smAQzjz
 pnhP8IiLxIrjYrilZ/kM9+wkpLMtcCLQgf95T+j+x4WcTIhK/IN7pgDt5oexYZ/jKk3po0diWlh
 l8hRR7b2ZNhISy0EEeGzgkj62VeRr9UH0tjBfbgBH0Wo5ro4wAGQ/gCZkvdGXVsq1wcyrlax6ly
 IMCc=
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
index 5e6c50ca64d..c278b220773 100644
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
@@ -207,7 +217,7 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config MTK_TZ_MOVABLE
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
index 00000000000..13123be068e
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8366/init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Baylibre, SAS
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Chris Chen <chris-qj.chen@mediatek.com>
+ */
+
+#include <fdtdec.h>
+#include <stdio.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <dm/uclass.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <wdt.h>
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
2.43.0

