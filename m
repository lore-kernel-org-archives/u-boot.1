Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260C2C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 22:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C328560C26;
	Fri, 18 Sep 2026 22:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6slbfhXFdfuz; Fri, 18 Sep 2026 22:18:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9B58860C11
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789769904;
	b=TgxsoVrRTdHe4FlZ+qq1vxq86zVBKG0rmaJOKP8k/p7XI7drLKzjzhS+ID0CBqXJh9M3
	 JZAB3kdNDw6hRQsRyf8tfb2XAuDsmoesydkToP9ETBv3DL6GC+PZSasnsZs6KAoVUYCPE
	 etrKZ9mXoepD9P+dWjhOwc0jAupwYfu02a3YjcxzHoFPSPMNk+DBzUANYtlWLCPeB7T5W
	 nIamJjWdnaYaEtLo0Y3hOkb5OmvlNkRDUFYP2uCT078M4bWkQs5Kn8viUkLpPx++hNnNt
	 brjG0kTh35BKf7XdxvmwpDjrLCUDeeZG0pRTMJpDcGQMVyKLCtMlhfIK8he4dIRVwIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789769904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i66rm4cFaKCsJjK/xUK7CFlrz/MrZqKmNAFEj1Y51L0=;
	b=ODsE5tmjfvCCq8Pn48ozoSpkoUSBXSWgNsgrIUVPDhQkdu1ksUSk4Oz/IHEJQiBO6iFd
	 RjojFNTWw6Mv9wL9jO2n378zfWjMNoNdlm/FBVAdHmtroPS2sh9JbdtZefH989uGcc14A
	 nncXEhgl/zXUw/rYmHMUgELRcX7q+HJ1O+9S0r7uv5I0muvRls1vXgSw7wgKOX0vDdDHb
	 gk6yJ35s7T0awvmqdAVJQJP0lhx5MtqDlv0TkwdB+rQCfMTvVac/9wkJdhZy3XMUrFo8p
	 GlfkIK+C7jkU4ioTUqWQ3y5TSE+V141plW/MUfIbaCCO0BACPsSpsnRY58abEdR6Bwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789769904;
	bh=i66rm4cFaKCsJjK/xUK7CFlrz/MrZqKmNAFEj1Y51L0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DinwyIj9xXlXn11+K0FfFY3FixYdU816bb844fXw9WLMxo7WFy5JM2KRRM4iht9g5
	 OOnzEFO+6y/v+8EMifO8zqkbkJfiRzNs8VjWeZ3DNkPfV7IKtXVSoXSia/rZm1t0kt
	 hxE1zp4J52e/sEHRuYNyZ8WRdlS0+DNGG8ApRNv01g5MidUNhBbWz7biEGdam81lLL
	 7PRrQdFQ8S7CIelY4umJ2Vg+pvJMymPDcGl4Cx6migYN+Q8jubuivQImMZ0+R4G9Pd
	 gX2JcI8P0gnADQ6qLXjfcWa4vu/NzNvSv7ok/V9CyDCqXpN4LMJ7IZHXdnls0j7zoD
	 arfyHVGRrHR6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B58860C11;
	Fri, 18 Sep 2026 22:18:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B824E23A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9CEE81204
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8OTlBdxMFU4B for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 22:18:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 94E1081202
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789769901;
 b=kMZzypoasWEyF0p77LUC1Vpu0i6kHjoOKnWscoHt3okMIVD4ERqrpvsTL5qQF56cheWN
 K/Md6m3+TQUwwQcQmF+kog50RXu9ct6hQ2ht2ILWVRYBjaIABbVaZvkwetlqZw//om714
 aVe3Cj6Oe9Dqw2W6+N/wjMWzOCdMal0uzA12osAJ42PERS8C6QHpm2xgPxrGwT81vKSKW
 OySgtdhnjmJktW+hEyysXMDY9HCZ6ZH8qupuHCtwSMWfIXf6iyq17RVCcaPDY9vUcBiQy
 A8+0p1H224/nyNW7cai44Pn7pB7aDEqcY7zt8LtIkU2BlZbwQ8WbZvNRG6T9hIJUNuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789769901;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=i66rm4cFaKCsJjK/xUK7CFlrz/MrZqKmNAFEj1Y51L0=;
 b=Lw9phnqYkhFj6xV32LX+f0embQXQTaQO/ZhRYiER1JH9uA41C3J46EleJkDBVaGH24Q7
 kPdU200AVrBaRuMQH2RuGoA8/idTu/szw8D/2Bob9ZQr+7MRYXCMPfCow2ef69ywY/Xak
 XJGGiTSL59cGswDVPTluX1jvQg12RXl/l2qNBlZ5LrhUVSGeVPS+XLl6Ggabkb1GCv1Rw
 HKHFYjLkPO5u+pcqY4W0Dj6V3EM/ewwzrazaNR1pmhAhG8MpYAdQnsl2zyD4RcuB8tZuC
 bZVCrDWAxRKyYjQx8O6guNtssKMw5hT5VwwL38LDjQoqgaql86UbVNBLkmsxPhPLeow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bf5jZphp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bf5jZphp
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94E1081202
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:18 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6c2613d8157so543497eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789769897; x=1790374697;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i66rm4cFaKCsJjK/xUK7CFlrz/MrZqKmNAFEj1Y51L0=;
 b=bf5jZphpqJfeB2k1Ak7fUm2FhnuWDhaG9YdUeeI5YE+r5G/sBosr4+tqcAJeK7G+Fd
 4FmiiFsYKTcxTBf7sUGWNRkBHEZfpwPqZkSywEG67UEEZNEPsDhoNw0FhgAgvwQyg4LH
 vNtMX3Tu6VTNQAvAZaVUCqq0F72vbSAspXUDYWEGkwi0Ma0kiCvd/eeuFNhJTnwI7UUM
 thSAihWP+ku+gqJT9PJVfi7RVH+yA3WAZKhFUpHfjDekmjKIup2GXUVk4RMHhMMThpzm
 n24FBtSi4O+fQGfyDVAxWM42UerXVplwlvyrHDzy9U1NISqHYI9KCQZ/AY/VOmJZJ8M4
 p/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789769897; x=1790374697;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i66rm4cFaKCsJjK/xUK7CFlrz/MrZqKmNAFEj1Y51L0=;
 b=eV5MF2h3PGNeJj4mpRk5t/RyptflFteygclwzWxYeX3LSyJbhqOFHnbQA1HV2vVOxo
 zIje+siTtyEwEXdBJ6sSc7sFBra5FWJmTwZ/entNZYSMeT85YJMzTCAXHib9YZACvnxk
 WXO0/iQKJDLbseipqwt7FtaRO6Cg66UYdG2ROwWhX9U1WA+l7Rxgtc/C00bAdC+GWs1Z
 6UApbxeGibUs39iEbNO6F3bh924VaO4j4PoiBZUPE7KFe6C3MDy1PRfhulkuLCjoRKIP
 wHzX9zLQ84g/amdottmuRdvMAI+FQz4avt65R3so7fK2lZ96s9BR0F2Ms7u5BnjkXVRs
 v91w==
X-Gm-Message-State: AFuF++nt5XAT2l2juhXvpRnfz2W/JPJ8oDuUovKaN+vx8Xrxgt94cN2L
 F3ZnfTHWsDNQ59xoejhd0FjElt/yohGxt+JYEv9v8AGe3YFLt56o8mxI3Vw1JAMwvXA=
X-Gm-Gg: AYBFou1vSWrctLG4y+VIQtt0CI3ncMTt0AgC/gB6EflJn9WKK5R1+TDp+tC5OE9O6ET
 0EVazB3I+/nHwsErOYU+feSp5gnU3LoXJMAROhMBV0FZXiWnbd6HO01hixS9+lh2K8FbYaAyevV
 cM0//YjW8Z353chuS4RJDqWh8Zu99HEBOtIifethfe8LH0Remlel/8F5JBhJkCuAaKMV8jeMrCk
 p5yVls74+d24LP6pMK5FFjChpnt1fqSdUuvkQuFcXtsGYt7q7RpDClD9sWjzABK5sb2RxWzh0/C
 Ode7XrRR1GDEfeJMEQtM3CtDi5TsR/1jPFsyNJXLpiCd+jqhRfWARe4kOZc6/1/SO6SgGfglXWQ
 VP4nt5J3rnfsgHn/xJpBgigLXaEGgig9amRNBVgw2fXPpwWE5HYN4m7oeabKdvZEhouwAigFSvZ
 y4LshQVqEqG03YX7Pr13UOLGHFxu3ZgGsrabSp3mHXfsSKwY0/AggavFmGTfZ6VMewK/cyj9Wf
X-Received: by 2002:a05:6820:168b:b0:6b6:f16d:d672 with SMTP id
 006d021491bc7-6ca9a63e9c6mr3619388eaf.16.1789769897236; 
 Fri, 18 Sep 2026 15:18:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:921:e69:d103:4708])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd34f2d2fdsm1426959eaf.8.2026.09.18.15.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:18:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v5 0/4] arm: mediatek: Genio 360 EVK bringup
Date: Fri, 18 Sep 2026 17:17:32 -0500
Message-Id: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRwY7CIBAG4FcxnBeDM6WAp30P46HAWNG1daFt1
 pi++1JrsmZjj38yfD+ZubNEMVBi29WdRRpCCm2Tg/xYMXesmpp48DkzEFAKBYZfujOvqQktx1J
 wG0NT91fuCS15B+RMwfLba6RD+Hm4u/2cU29P5LoJmyaOIXVtvD2Kh800N3dogQsdw4YLXoqSK
 P9ESis/bXX7CjbS2rUXNtUM8AqpJQgypBxqFGCUN+oNhC8QyCUIM6RJGTKoNVT+DVT8QUbAElR
 kCDzqgwRwCuw/aJxXGOm7zxfqnnsdx1/Uw79svwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5152; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=65HqKKRA88c4jTxlcTANgk+zTSJInO472WWeDkargHA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqrbh//7UapXW8Uxsf0vFdT3Al8rMD2zS4y+kz6
 1ObQzRMn9SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaq24fxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmGcH/RFJi252ZRXW+HoqfJI3Q0rlhk3gOtVxsjLCJn7
 IVcnOlVmwG4DirPdjR4iXpz7dX2aBV2XIvJZxLXJCSrBcdTRvFEE+UUsSEBXsx/64YAIPm6Omui
 GSNlOREh4qY1OBeRIEIjX2w5I9yDttp8m2eV2lbOgVpGGzScBjyngRUDR06A5pRziDIxZ6vj2tf
 TsUX1age52/T2r5BvCuBiGTKY8ca+Uu7alnW8wHf/pf8RPwy4WmpIPKx/fPUcCGvYORk/F365Ho
 79OKT/fMqB6VvBFCxKsPumhhP0IoH26E5gZbM+qTvJeFrO7y/EF6ANnK4Gj4GgUbDtqalGhNzrc
 i870=
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
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi      | 507 ++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts              |  14 +
 arch/arm/dts/mt8366.dtsi                           | 774 +++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                     |  12 +-
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/cpu.c                       |   3 +-
 arch/arm/mach-mediatek/mt8366/Makefile             |   3 +
 arch/arm/mach-mediatek/mt8366/init.c               |  58 ++
 board/mediatek/MAINTAINERS                         |   9 +
 configs/mt8366_genio_360_evk_defconfig             |  63 ++
 include/dt-bindings/gce/mt8366-gce.h               | 858 +++++++++++++++++++++
 .../memory/mediatek,mt8366-memory-port.h           | 263 +++++++
 13 files changed, 2564 insertions(+), 2 deletions(-)
---
base-commit: 938e2774f01674a3a38cc6df5d20401cf09b1401
change-id: 20260729-mtk-genio-360-bringup-de3bedc2ec94

Best regards,
--  
David Lechner <dlechner@baylibre.com>

