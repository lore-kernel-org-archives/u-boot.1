Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55ECC982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 22:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E7AE40D1A;
	Fri, 18 Sep 2026 22:18:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pp3uPYgMCjIB; Fri, 18 Sep 2026 22:18:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B0D8940D07
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789769914;
	b=CyFSwWf/W95IBspBD3l2LX7kA3JqozuQ2dgO6cFvARM+gscYQFtrBPw7i/NsG1F5Dh5z
	 X1BHQJ2BdWNlVKPVmbWcHiBTFgzcMtU0EH7YH5iza2WKmpTg38pX6EIoCSjPsTcKFlH46
	 8MjFxXZs6Cq6xK74JrXjde1V3K+2bnQ39RUHsqgMYCq4Pw0Yq1+LY9oSeCdDXrPHS6o6I
	 tZoem4AVVR3qIRvOASPogInWLmbvpZfO9EVkABynJ2VuQS8kl7PAV+cSY/70xLxC5JVs1
	 JumIysyKaMW5Vinr7JQw0ktEKoLVwr+f+g9FNUYvAWPha4i5TJ3zJa+YTN4wUHHsGLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789769914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U/zuI2teqFc/0F87VGR6iczgwf08kyWPooW7otPSaFM=;
	b=hofJHuOH1+QxW3ll1RqzTQpgdTrO+uzj8+1/QgFH/bGW0LETy8eDMPoHT7yzwgLuUCF1
	 cFHlJEu7hgUTehLGGEgD5Gh7WMNTOvyjsnXB0OFjuE1aRZD03/hMZmJIPr8mFl9DQok1t
	 K1ORse4TOx4G+lk1d0joYDm5Ywqk9JdF9LDJJ+l9+j+y3S8vIpIL5vvS907th1RoxAB2P
	 7YCuqvuwaZisjZCpcGkmhKaZwRACN8JJKpIb/en5Z6CAUheqw7VqAH+jvDWKYpWU9zsgE
	 LZE1eHsx3yap1IMO11JF6xkjI4+b/URgwDI+5ELoaoY6k0fXYkYuWCdnfmoSWMyhn9g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789769914;
	bh=U/zuI2teqFc/0F87VGR6iczgwf08kyWPooW7otPSaFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IdxZPVol20nPVGz04/5TwD1uIl7w1PpnHbYCvCqTpoaOiTFrMJcd+2sR5g6eQJS94
	 IE1EltcgwpF2CG154Nj/7BiTKePZLOCifEt4SlMLVJ2a2E90dO88ykEepSJcSKD5v7
	 mjZXCQrWGVZcs7HYpriyz8gEvMbU2V1RHIEVUakqqj3+GK3qlJ/UQaASOIAJk9Zk0T
	 nfMgzHkBRb9jTV4mzlPqpoK5J7gfG8ldi9po4cU++NCFkEeKDiPlSPptaCLsmQ0Pfb
	 PAuk4DwmVbspTmDDRY2Or8TOLCWeCDxds+Q5GDrPSMZ+jEGaiIR0DN9vs/L9T7oAm8
	 pccK6WJsXOvOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0D8940D07;
	Fri, 18 Sep 2026 22:18:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08A071E9
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3CCC400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOBdMtGQ6kv7 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 22:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3860440022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789769911;
 b=Z/tSnY7T9K2ZoccBbeLCn3339IXeqt+fS/SgtnfIIvJ+In3vlqrLgL66LWVytYmCLvcK
 lpIKH2q9LZ/80qe2Adewnb5MUqQsiGJ19rXUacS6H5ZyyCh8cd6I23MD9ZAk32EC1vpAM
 16M/ha9uO+KOASihhzR7ZNnTLthqqKSSVjTdyC9ZVo/2XKQa02TUOPa8b4VPb5P/ZdIeF
 epo+ix78djc5TS2ZFioy9RwSSNW4WlyV0LCC1B47UjevTobJqTYVF7m1Ke8sogplT/13Q
 jpCA1EZZamxzCKKT2wYSkgqPA1P39itnbBcp890Co5EeHFSsorhrnOkJLwUQP6C1PqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789769911;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=U/zuI2teqFc/0F87VGR6iczgwf08kyWPooW7otPSaFM=;
 b=pdINf9cFjR7cmilzRwQUmXJVGHTvjAhZ3tHpXmsW0DvqkvSpOu4Oj6NDLhgAHJTaSg+F
 EBWBMKzXZ/wZxw/YUfG10RCyPr4u5Uc74J9jf92qxDuMk4WuyDLhF/7F25AvxmRmtSeMx
 XCxPdFML45CkDCSjNWOyvUWEqwlDhBJfOvnmKtnGdVdyP5TOCMs7cOubZ4CupUAfY7YkY
 46ZOPS/x6j6EqQ+ne0B0fxskXpxOP+rWjsjs/bXImGxXfmUUv+nE5898fp/VNQap17mKb
 byHKUwUw3kD2V+ONgB4AyOGSiddEIKB2RSy3D4aYZDu0OV9NGlINLf14kZl5l3p5gnw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q1UcbWPi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Q1UcbWPi
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3860440022
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:30 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9b2f1dso682232fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789769909; x=1790374709;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U/zuI2teqFc/0F87VGR6iczgwf08kyWPooW7otPSaFM=;
 b=Q1UcbWPiY5skVuT+CaywjC6pPIkys6j2acOMe3dPRmWXDLxldEnKgCKQs3wdNdzaqH
 ZZ42ESa2e7rQQEZ31vuED9OB9RZSItKl7WcCkiZPto0n26xRxTt/8G9IcVPzjMZQOdf4
 2FfmTEd14XrXwpNVgaJQ9u9xGjr8m2U8YPocBYowUGDlwNR8BtmT3jRuPxVjWY5qKiC5
 sGUd6k6X3c0lcZp6g3pcfUvIiVlxyFkcXNakwhQV7v6RC1dd+AO34Df1ARTZDO+/OCfA
 QnLyly57PI2vSnuy8aPQkdVULWJvFVMcewIsh/jmHoP1ppuECMYMXJEoaOz/JlQB+7Gu
 L0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789769909; x=1790374709;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U/zuI2teqFc/0F87VGR6iczgwf08kyWPooW7otPSaFM=;
 b=LLwqW3ROs3SKIo1kQiG6QAz560Bvi08eVnOQnk2WZAyw1FG86kBB7WcpENAPQnXH4f
 6d82vlZ2FbGbjnqGqsRLUUzO9JsKZP8Qu4hcwQB85oMPHEtaP5Yzt87Ww8lFLooeQ3wS
 ztwT0T3zMBDbByh3kIpL09Cdm1rMU4CP7VMcyCzLz4WcWc5F2Vx9vpqItVwSQswRBI5m
 TxD2Iic4UE+3pi82h4LJhkZZndIONM5SYbG1tBnYD0ruZ5Qim3fpRUt+gPGp+mGxsTDP
 Q6SHxP0zpD+Hr3Uz1gfsxOPsxWC+AW8C4tO3W15/ZyI5wXhBnGb1OgK/VFxTbrUCE2cK
 FluA==
X-Gm-Message-State: AFuF++k3x4Db5XOUepu49l0zHMJLvetD07gPNIIToSycCyYGHlYbqe/+
 LwgvC4HOrL5oPTqhXeU2SGJjjHbLhv6LH66VBF2g5ckAzK0nteXVi9UC9OPGwibHD8c=
X-Gm-Gg: AYBFou1rsuY6BOemFyRHAR0J4bH5+F4LgBaLotH+UwC9H0AxG2iaooCPRWALNNUrXKw
 Ai57D2HekZXprviCmcZabOPEmopZrW2xZ+bhizi3WwI6tSEOz8ABSKpZv4COsquqyxihtU8djKt
 Ma/ifaI5gpNvhI3N8dy65xPnKfd8qmpr52AkToX8kugPhNoadWRfvrp1GZH2mPTHtC6hu5fOnRn
 b1Pfioi72qhGy4YeZ3mKt8HmcoLfN8sfbJbBwPFD48mktYuzhWZgh62NVqBmLbNErvkvINO5j2q
 4sRMtWALWGQGDYU1VKFur21ZWy9Hl4JnMKpt/FH56ggjzXkgZ+4Gb3zsO+uPjKQNR2e7XNm04DL
 a57fsuncgfVBKNZ4NKSUPQQFQoWqzRz66PKQrGGzypvt7xU4/eAwXofLiCvxuyWle5tX0sruM2E
 Mm1xJ1xlYaLHQKqngBJNIuMy9KGWh73OegORIjZgLihRaWiTArdxYUrPeLyDwOJfyod2AbAP0oe
 zJltqqdyH9J
X-Received: by 2002:a05:6820:f008:b0:6b1:4aa8:7d7e with SMTP id
 006d021491bc7-6ca914983b7mr3292293eaf.14.1789769909391; 
 Fri, 18 Sep 2026 15:18:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:921:e69:d103:4708])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd34f2d2fdsm1426959eaf.8.2026.09.18.15.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:18:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Sep 2026 17:17:36 -0500
Subject: [PATCH v5 4/4] board: mediatek: add Genio 360 EVK defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-mtk-genio-360-bringup-v5-4-31451a136f96@baylibre.com>
References: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
In-Reply-To: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=YqO5YILSuVYT+tfAdiIy1M0QT6JXv/cT7g2bUDs/Qck=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqrbifJkna8z6FXOiP57fl2e35ovzdV9PHD1nIf
 rEJ4OHijQ2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaq24nxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvnQH/ReSkd78KmFkXoPX0QvnEhSYUjhpr/wjFjTpJnx
 LyU8mgbO6i/c4966fzF/JsbDwiBb9a2SUYQDDP3T1d5e5EQq3qiankoitfS9D41Q48CBY+6VfGL
 1cYJuxooAOPg1ymqFxFJ/ddw23cOp74DM8v7CA3R6r31FB93It8HFzvvKmDCCqU1WU3WQxrOkv8
 QcNPyLicEt8q5tEWK+YgGG/u+3y9nRMzD1iNMHqeqV4t44/jXEOkSKp535YoNajIVpSg0CptgFB
 JldclFQe0ZTZzNRy9ybZunA0PoOfvUMSfkIz5e+qpk/bO3fvhG8Z1b6ay+85un7QEBBXiyhDeMS
 xF6A=
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a new defconfig for the MediaTek Genio 360 Evaluation Kit.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  9 +++++
 configs/mt8366_genio_360_evk_defconfig | 63 ++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 47f91d6e81c..873179a765e 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -14,6 +14,15 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
+MT8366
+M:	Macpaul Lin <macpaul.lin@mediatek.com>
+S:	Maintained
+F:	arch/arm/dts/mt8366-genio-360-evk-common.dtsi
+F:	arch/arm/dts/mt8366-genio-360-evk.dts
+F:	arch/arm/dts/mt8366.dtsi
+F:	configs/mt8366_genio_360_evk_defconfig
+F:	include/dt-bindings/gce/mt8366-gce.h
+
 MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
new file mode 100644
index 00000000000..abc3667d566
--- /dev/null
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -0,0 +1,63 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="mt8366-genio-360-evk"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_TARGET_MT8366=y
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_NET_LWIP=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MT8366_POWER_DOMAIN=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_FS_FAT=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_MTK=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_AN8801=y
+CONFIG_PHY_ETHERNET_ID=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_MT6358=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTK_SNOR=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_USB_MTU3=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

-- 
2.43.0

