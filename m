Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41872CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5E9D60760;
	Mon,  5 Oct 2026 22:11:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8Be0Z4lbIuz; Mon,  5 Oct 2026 22:11:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6E497606E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791238277;
	b=CDPYLxB1qwYp4l9qt/4ZKVCfeKUp5mnf/rUI/WAH4MziJ4InlxEYEkZdF5xbuan80ZQy
	 1nJQgKjwPnjF+8i/1zjqDoXYnmoZzzkf8MzUerHsjaPOz1P3Mp2McfMDOFUNa7oX8KFNr
	 j1ThsmMtFQRcDRasPX5mNmgwClesM/VRyXAciG4P4kBG1TdyJi0swidvKnblnfwPm3sxv
	 bWxAlVGcJ57Iw451BQhEDf3W9qA1rkKTahdfMlIiIE9booFfuCEAsMOb6M2mRHySfzQsN
	 iliEk3VbDQEF69GnRIiGn4ey0iRiG5qBDPjO0U1KmyTwgGByZCb9z8u/GCjoBb5j57Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791238277;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=teReiJHTqOTNwNHJPY4D6DpaP6vqazYCT8X9brF0nkw=;
	b=rIRL/NudAKx2rnttiz0QH3AzWwUtFqJW3/jcqYXBpHeoPujvf3aKMVcgB4JGLA80opC0
	 795iDZs5GazM12rrnYMjvKqUs07B4KLVRNPAqh5amegPqa0HYZIQ1suEtqvxQR7/avFln
	 KSoP7AI94fl889sUVYyPLm5FDa55bo8eqcZPXKxKLMKgKDNz9zh63yzoyQ8EJMtwu6MCk
	 LG3BKeVlMNyETOFGI9nUf02e39S35mqw5nc345yDOp7hdfbHCE0lutP5W/MkOjMSaUCAm
	 1tY9SyxBy8d6xgS6sHqw7ufVgdgOV8lhFa1Fai9vPtAf32QOAYLFqHi0qBh8kx5dtIA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791238277;
	bh=teReiJHTqOTNwNHJPY4D6DpaP6vqazYCT8X9brF0nkw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0hWQYlq9kFNyVQG6l2jkJJNSX7+g+oHB7fJRl9BzwMKaFz9DNKHQOha+VzOxz6b6g
	 ILP7Y4lo841G5sazSz/jxFCjwQyrXRw+B177F+uahTevQq+z82ANJr2U0EfRaa/dx+
	 fkmLhffKPWxpR+Rl247phdgZHjKTzMLTvjfkHtEDtaMVXXEwWkOuWXXhEf5Yo8df3P
	 6qvSj7a/4qGvCOBL4PqwiKKG8z1+3gz3XtIwZ2zr9YnE9ac67Y6+U0MC5dFGw3Qw5B
	 kU1x9uJ3zBN2vUsA7JhOK+V5E6ROHeE+G00LeuI/UdtNDbQsKNypxcdnfdvf1uTij/
	 erPYftnvL2QJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E497606E5;
	Mon,  5 Oct 2026 22:11:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FF9B34E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 606FF80A87
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6oOlzMHYyVOQ for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6DDE180A66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791238108;
 b=IOYbZhSkdVwasmeBcFUXMqtuaSLMAkEW+yVzMC4HZh9E936EyqPIbHMXLZ+cWOssaEBx
 8z+esLO/C3SOv5fc2WnAPIjLwrkrQjeDJMm44xml1VB9dC2D8fPGF3kAC44GEKLEuBk40
 F8/MnOzRPHCg//6VfoaIx3PGL196iH+n1Fu7U8lDcvT2xTQO2D9loq8EXWQx3+JRb2IrY
 E/v4hJQgK5P1PRtmfkSUAMOb6B3Lex9bwqJe5HAIgbxn5bAMT2yYd6oMWBuAoZxZ4kFXW
 NlJspvAPRvm1mEFlroOQ8fdyC3XEkDIa0ImaZVFXB9yn1sTf3J1Fx7jvItb1bBl326Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791238108;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=teReiJHTqOTNwNHJPY4D6DpaP6vqazYCT8X9brF0nkw=;
 b=dCTBVPtKbs1gcVNdwclyBAv8yC4EhrSdbIdGJx7Rut1m4SvpYLnZF6Gn2wwjKqFn+J67
 Krj9dVuB+JBAmeihjz00kimsd2C3qHtGX9Ls7j2FX0z8gfnsXOUhdi+iN26vDWi+3x9gB
 d4rsXyjpa/csK8tt25ErwPco4sKzVuhJ/XbKdEdFbUcib16O/MyoiYgQuIFqJXeJkQ2a5
 pX8ho0TcOfXHVdG0mRF4BjihTicsaE+4SoyJro/PYXtIfieTSKCzBzRglY+yH5MZVsTzH
 Jd/BVHEPOhReVQiZ0SyXgSeXA0QpUAfmiMMRbGzKw0Nh453LcD/aoxQkrulXVY+p9QQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D7+OObKT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D7+OObKT
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DDE180A66
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:25 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7f48c750afcso1624742a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791238104; x=1791842904;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=teReiJHTqOTNwNHJPY4D6DpaP6vqazYCT8X9brF0nkw=;
 b=D7+OObKTbfIOzi/AP4e9fgpfvuiBmfbQtmh5C2acv3Mu45ho6NPDoLuPpoo1MDi09j
 qpmjy2FhFataJBIu/akts8JB2QzO9NuwavmNSt2tc7G2qvuQhj+JjONp1dQvSRYDrPfT
 sNpZOFwGPEL7fvMMNEzTw3enUQ6p6j1dKuXFvgaWNxsiV2Z/fj11AA0k45js87L6kMz4
 igMeHpXG5IEm/pDyUJfSkJNU+Edg6GuCPFLoKTvIg+Pq38AGc3kPC6+b1yjHCfUrRyX9
 rHygms4VPdmusXMdyHQ+g2N0oogxgH64aLrI+YbncswWL0GQAnUy60YQu5NWPAdvu3JH
 cNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791238104; x=1791842904;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=teReiJHTqOTNwNHJPY4D6DpaP6vqazYCT8X9brF0nkw=;
 b=XvG+FxPrktOP4CdHeBFfPz23ywgCFhfvb/S/Kyz8xdzVOeebvxcT+MO/lK5Y/cfvQo
 FedPFG9/fjskuq8u3W0LTkKKHOale+rn93ZdXscDJVou6AYgaj4I7xoWVJHh3T4aEEt/
 FNU57eJSJFiWCrJNUND74s9MTIl1Lvdaf/3schhHfnn6xqCa+Zthu2wb457rWDqojiAu
 rL2BP1i0ZofumiqR71QXxBN2hZboRm1SQ2scDWWSM6zQ/Tx2RKMp5AUnd0vCsB0dx6HY
 aELEOk5CfEBeSBiQR9W85dzDUymBOeMMF8gsQWkMNqi32doainUjmJtBF/YGXV6pc4Vy
 2eHw==
X-Gm-Message-State: AFuF++ki1cXR0p03pa2BkoS9m7YsrouqQLZBVzOD1L78pGSBU2vGH8nb
 5/0GX06dxg0+hKeljVDNAl4OtdjTIrYJhpfpCLzEgA1FuGCaRgzEiXlFJXgAxmulDHQ=
X-Gm-Gg: AYBFou25njlXgEq7XFomqV2QrHB0mzy3+Hc8eyFyepA3E4owydWu/tau19OxiLcFedj
 bF0eM44aTFlpUqYkQ6CwaWsv9eZXgxGTh+7vPzWQuZy+DZcXagm+nwzckiILOG98gsgdZO+IpzS
 SjEnedxlmbniCrD0sRdodp0AOZzgp9TBTgzVkgfeW9i5Ke7TkzhhxBVTkVYqGfFiBKQV1XUYDfE
 Wd3C3e5t6X/iMIzY6UGdPUYkBkzV9IskDzd+mfeL+ty9abeoNiDLUh2ldcvKPnBMEQW+E0rp19b
 yxZyqUQTVk/QFxQaHu0/iLLuzf6VYPghHhmMOu4MHuYQjO9MFAmQj80Cf2XRZAo+LOP7pNXmB2e
 dKSRIpvC+xsEQoSvio8X5r8ZC2oumZtHDOAcdaM91CV2lyVgXRuTpB3Of1T8006Ous0BS/69z00
 no0T8azLa6bW0dQHgUttHiRCNlNc+h/zOr7+AcFJ/njTEVNvP2HOlgoTbCxxs9nPDy/RQYN/7Zr
 hpgtS8Ts7khLA==
X-Received: by 2002:a05:6830:4409:b0:81d:7923:b61f with SMTP id
 46e09a7af769-823fc833069mr9806452a34.5.1791238104628; 
 Mon, 05 Oct 2026 15:08:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8281db4582esm655718a34.3.2026.10.05.15.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:08:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v6 0/4] arm: mediatek: Genio 360 EVK bringup
Date: Mon, 05 Oct 2026 17:07:46 -0500
Message-Id: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRy07EIBQG4FdpWIuBQ7lNjPE9jIsCpyNqL0KnO
 pnMu0unC0cz3XES+H7gP5GMKWImu+pEEs4xx6Evg7qriH9t+j3SGMpMgIFiGiztpne6xz4OVCh
 GXYr9/jDSgMJh8IDe1qScHRO28fviPr+scz64N/TTgi07XmOehnS8BM982bdmGCY2MmZOGVVMI
 ZabSOnkk2uOH9ElvPdDR5aYGa4hvQVBgbQXRjCwOlh9AxJXEMgtSBTIoLZohTHQhBtQ/QtZBlt
 QXSAIwrQSwGtwNyB5BXGzBckCCV5L3nChWqv+Qee1i4Sfh1L1tBZEOsy5uVS9qx6WBM7Y+ubxK
 zVjWRmh1FIAp8EpJwJYj/zvvz0urbomIy1DF6dd5QK0UtvaaYTaK2A1NM5xC7y1HpiwzgJDBuV
 a5x9Y2b/BiQIAAA==
X-Change-ID: 20260729-mtk-genio-360-bringup-de3bedc2ec94
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6184; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fsEt3epStOjpACsEoqWJWs2GoqTOYYtYbyxnXTenZjs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxB+2G+Ky4Qv3rUoybxBu4kHGGhI4kTC1Wc3vl
 XIKRndlhqOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQfthYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0+8H/iDWDQyrWgYk9M3LXD3DraAci0va9Nz3LC+fAYo
 25fNUn5rUzGLhg51G4Ts6Xhj7a9vhZrCRyX9Th9kB9N+gsS4RT8yRCUp1YvOqTEEypPJNqb46jB
 ht5pjbF9z2nestRM9grF2bFigTTAwlmzWH0AkiWkP+cuuiW+vPklKbM7nFF5vMUuolnzCPvuw4a
 bAFGwWjOnSR6GoCpHUlnYjlP0UQmi3fw3B68MPNcak36P8b/ovUouQb5JTYi4/5+4yovPStP6+J
 7ommaO3bnGncR20mD6AGlgkWS5hprF7s1VD9b55eOjJ1G0FcQmQ7Hu1hMEK8X+0VxRq8jDvCEPz
 k7hc=
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

This series is doing a basic bringup of the MediaTek Genio 360
Evaluation Kit board. This contains a new application processor
(MT8366) that hasn't been seen in U-Boot yet, so basic support for
that is added as well. Clock, pinctrl, net, phy, spi, power drivers
to add support for any missing compatibles were sent as standalone
patches.

There isn't an upstream devicetree at this point, so most of this is
picking up the downstream devicetree along with a little init code
and a defconfig.

This has been tested on Genio 360 EVK booting to eMMC, microSD card,
and USB storage and booting from eMMC and SPI NOR flash as well as
testing that networking is working.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v6:
- Rebased on next and dropped CONFIG_MT8366_POWER_DOMAIN from the
  defconfig, since the per-SoC symbol no longer exists.
- Split the mtk-pwrap mt8366 compatible into a separate patch, which
  this series depends on.
- mt8366.dtsi: fixed the GIC redistributor base (0x0c100000 ->
  0x0c040000) and dropped the GICC/GICH/GICV regions.
- mt8366.dtsi: dropped the mediatek,mt8195-pwrap fallback compatible.
- Moved the serial0 alias to the board dtsi and set stdout-path to
  "serial0:921600n8".
- Changed the board compatible to "mediatek,mt8366-evk".
- Renamed the ethernet PHY label to eth_phy0.
- Fixed the BayLibre spelling, include order and a multi-line comment.
- Patch 1 commit message now covers all mt8366 compatibles that lack a
  binding.
- Link to v5: https://patch.msgid.link/20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com

Changes in v5:
- mt8366.dtsi: fixed the MSDC1 top base (0x11e90000 -> 0x11c70000).
- mt8366.dtsi: fixed the uart0 interrupt type.
- mt8366.dtsi: added a "mediatek,mt8366-wdt" compatible to the watchdog.
- mt8366.dtsi: dropped the ethernet clk-csr property.
- mt8366.dtsi: dropped reg from the T-PHY parent nodes.
- mt8366.dtsi: dropped the larb0 and larb1 aliases.
- mt8366.dtsi: dropped the clock names that no binding defines and no
  driver requests ("macro" on the MMC nodes, "axi_f", "axi_h" and "axi_p"
  on the SPI NOR).
- Board DT: restored spi-max-frequency on the SPI NOR flash.
- Board DT: dropped the dsi reserved-memory region, which has no consumer.
- Board DT: dropped the unreferenced usb_p0_vbus regulator.
- defconfig: enabled CONFIG_MMC_HS200_SUPPORT to match the hs200 and hs400
  capabilities the board DT declares.
- Link to v4: https://patch.msgid.link/20260902-mtk-genio-360-bringup-v4-0-2d38f522c72b@baylibre.com

Changes in v4:
- Rebased on mediatek-for-next.
- mt8366.dtsi: sorted the children of soc { } by unit address.
- mt8366.dtsi: renamed the remaining pure clock providers to
  clock-controller@ for consistency.
- mt8366.dtsi: dropped the duplicated "ss-img1" clock from the ISP_IMG1
  power domain.
- mt8366.dtsi: added the gce-timer clock to the GCE mailbox.
- mt8366.dtsi: restored power-domains on ethernet@11019000 and
  usb@11210000.
- mt8366-gce.h: normalized the indentation to tabs.
- Kconfig: dropped UFS from the MT8366 help text.
- Board DT: added mmc0, mmc1 and ethernet0 aliases.
- Board DT: fixed the microSD card-detect pinmux (GPIO2 -> GPIO94) and
  dropped the duplicate pins-insert group from mmc1_pins_uhs.
- Board DT: restored the explicit MSDC drive-strength and R1R0 bias
  values.
- Board DT: added the Ethernet PHY reset GPIO.
- Board DT: renamed the SPI NOR pins0 group to pins-ck-io.
- Board DT: added a comment explaining the "rgmii-rxid" phy-mode.
- defconfig: dropped CONFIG_PHY_MTK_XSPHY, which nothing in the DT uses.
- MAINTAINERS: added include/dt-bindings/gce/mt8366-gce.h.
- Link to v3: https://patch.msgid.link/20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com

Changes in v3:
- Dropped unused/unverified nodes: cpus, i2c and spi.
- Aligned bindings with upstream where possible.
- Added power domain, display and PWM nodes.
- Enabled power domains and FAT in defconfig.
- Link to v2: https://patch.msgid.link/20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com

Changes in v2:
- Updated devicetrees to align better with know similar upstream bindings.
- Added nodes for mm1, pmic/pwrap, snor.
- Added more options in defconfig to enable gpios, regulators, phy, net,
  snor, usb.
- Dropped clock dt-binding header patch (will merge the one from v1 with
  the clock driver patch if we don't need a v2 of the clock driver patch).
- Dropped the pinctrl dt-binding header patch (will send with pinctrl
  driver patch v2 instead).
- Link to v1: https://patch.msgid.link/20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com

---
Chris Chen (1):
      arm: mediatek: add MT8366 application processor

Macpaul Lin (3):
      arm: dts: add MT8366 application processor
      arm: dts: mediatek: add Genio 360 EVK
      board: mediatek: add Genio 360 EVK defconfig

 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi      | 509 ++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts              |  14 +
 arch/arm/dts/mt8366.dtsi                           | 770 ++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                     |  12 +-
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/cpu.c                       |   3 +-
 arch/arm/mach-mediatek/mt8366/Makefile             |   3 +
 arch/arm/mach-mediatek/mt8366/init.c               |  58 ++
 board/mediatek/MAINTAINERS                         |   9 +
 configs/mt8366_genio_360_evk_defconfig             |  62 ++
 include/dt-bindings/gce/mt8366-gce.h               | 858 +++++++++++++++++++++
 .../memory/mediatek,mt8366-memory-port.h           | 263 +++++++
 13 files changed, 2561 insertions(+), 2 deletions(-)
---
base-commit: bd2f5794b7e24c62042abb1921f9c2039b920e02
change-id: 20260729-mtk-genio-360-bringup-de3bedc2ec94
prerequisite-message-id: <20261005-mtk-pwrap-mt8366-v1-1-db6b3d29ce17@baylibre.com>
prerequisite-patch-id: 5b95782db6163f6c4fcc6b484f03a103d3a5c69f

Best regards,
--  
David Lechner <dlechner@baylibre.com>

