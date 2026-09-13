Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3933C88E64
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62C0280D21;
	Sun, 13 Sep 2026 23:21:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sSBZU9uhy_o2; Sun, 13 Sep 2026 23:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA43180D34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341620;
	b=i8NRSftPxs0VJ2ulViEGn0eRx499I8C9RNnIxYRuwHYqFOeVRJFg8s2AHbM8SBpzbepZ
	 njfKbuPjHCrYN8XOYlO/EFe/woTCTdImJZqgOnt7T9XUQjyZXkhggtLGEWKyC2Dgj54M+
	 TlSwlyXKmxgz71Ip73dM1t3h/LSXMu6Noa45n6UGkUngxAwCeaIo+C6NKQB4LNsQiTokJ
	 zN/GdSZ50aQQF6Gf2oSYFsuuoP49OCmXGq/Ok9HG9iVb/PHN7Tac3uZqCENMGZqgc0Ltd
	 Ngv2c7gyNtsjaI+4kMMAe7rkSOAsnzcABvIVf7c/KHY2co/cisvw7qJp946ivXkLT8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ncs9UZejZ4YCYvWPRPL5chZNf1ar3iZekdUlUX8q6H8=;
	b=dIuy0ucsZwWklVa5JzMkGbLkquGK+Hykcl4lD1jHT7Hn6W0oZvmficZeR5gAvx6RpJwM
	 YmmeGwCN84MRyXNe+IEb+0xGivINNNESePId85wc6wNu8XG4fLQHQJ2MHs7qySQ0Mx4BZ
	 wJsVfq3wfSSH5I9WW2oWKxk8yAhSeKB7KqEDMMrqZJbc0yopeCFmqrYG9IRVHYcLJBSGb
	 RMooVqw4rRNanZT1A5vwbe2hmI5QxSO1SaAK9oBwVZBgBpdPepjOS+LkouJQoj4yYPQVb
	 7muzmKw3R5eXLlEsGYMtC6u7lxf5lUqqNbsPsz3GYIY9q5UTWIjrHX+Qn57st4gtBPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341619;
	bh=ncs9UZejZ4YCYvWPRPL5chZNf1ar3iZekdUlUX8q6H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Agg4c5GymUjXIMjsO1Sm6rMSdomaAbCnuRq34NUJXONhQSiy+SGRKfOO2gLaeqQH8
	 wO8ok643N5oNyAJKscpaQ4sOP8BD+UcBQbIbJTA3VRTkJK04l0w/P0OeD+vwlY7NNx
	 1IYeGpZYXA8WKXSNWOwhSXHuxoRbqt40H+uPVGLv1i1UqWPr6Vqg9CB+R2XUOEpBbM
	 3+i5EXajmp54ddwwnvKdzLUQMAX3lAN92m37i2xl6oMXVnf/bPo8Bs/YXN05YifDZN
	 oyEmK9AF5cx2INS4AnT6WK28ZJq9W0RxCpWjLmfluK0Jf/Z02jIbHq+WxJGTHBwHW6
	 1mFH8dJ4EW2/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA43180D34;
	Sun, 13 Sep 2026 23:20:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 341C723F
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A0214058C
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rln8v0qHE1H1 for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 15:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 193B2405A3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789314793;
 b=gTRfdb2Aml9Wl08L4p8lva8cneEUWypCZVSlWhrGbTZminBvKVzZa4/8uMC9Z3Pzn4mc
 yq5cABZXeZE34aCFIk9UgS7Co264yKjHM7s/lLJE8M/ZC6JZun86HuGOOjtnpHVeSFUud
 pJlz8NcimhY+8eei21QZjTSXr3SgZ4tQB5X/DeHyZiuXsJ70BPOdJXEXPGmfLDp+O/pRU
 kEAAh+dNyuwsyRTJNCy/36QP3E1eLeenrGd4h5B67xUFLsNk0WcXFQrTAL7pGGkelBrHh
 hp5FGqZFh1zlrVB23XoMAHHukJ2xyB5kFMK9lvCU14Bblw03oWddr621+rKmNpj2oIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789314793;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ncs9UZejZ4YCYvWPRPL5chZNf1ar3iZekdUlUX8q6H8=;
 b=hOjRGR0Z1UHFMlGeOyGpALFv0HCFd/UbYWaFh+KkH/XgKsF82DK8qmQ4Fv9TQDhU9Z7+
 YFA9ZvSm+jObA6J+ghKsVHiw3pFcGf1QmTSljgV3egjf4sAMCYkgOBa+sDEdQpVsm/9IW
 ArXB4X8gjU4u+3jfv68jCOg62CEhlfJBnjJMOVb6jnpO8fPvDNlvHuXFreKP8n6oBluy8
 Ed6hNghG52BGkTlsM8R1LS1YLh6FgfZfTaUdFcEaU9KQdkZhwYP07852OJVA7xuQyuoa0
 yWU1jG7D6hLe7UY16wrb3OTdqnfLeRDl58j3GAcJFQlhKfHl4BBA+hAAczs76Cv2GXQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dq75PyPo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dq75PyPo
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com
 [IPv6:2607:f8b0:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 193B2405A3
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:12 +0000 (UTC)
Received: by mail-qv2-x10.google.com with SMTP id
 6a1803df08f44-9105d241693so16562226d6.0
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789314791; x=1789919591;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ncs9UZejZ4YCYvWPRPL5chZNf1ar3iZekdUlUX8q6H8=;
 b=dq75PyPoUX0uNeL8AjpCpR014EwzF0ygRPAZQ+esU+OKRNUki7aWlD35lxkGebeDRZ
 sM7SD2vckwfDVNj2IJa94xYE1huQ+f9+Pszc7ZnrgiRxl3dX0Pux7BQmeC3OI3NXemdm
 tZt6zt9cXvsi8XNi5zNtDyzrBxYQFx2xw//A0Np81RgtFwRXoE/NgGoIm/Ojj6Rw5LY3
 NTFnCx7QW0FA6D9dntz89dozlMAxtfVlsQEWNh3DlBdmQFxOpd53hgJTc99gyfi1DTqN
 9nVhG5pk5LKk+Sr8uNtbTIjXNUxJyyMX8xjcO5CkK2Ec/nMotJPbIzrasdbdmahb6LuC
 jKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789314791; x=1789919591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ncs9UZejZ4YCYvWPRPL5chZNf1ar3iZekdUlUX8q6H8=;
 b=Ixm0Lz/H9t/gtqYdnREYxmgP2fw8JHL4nqC9p85YYP4hwyTSHSLNQxvqxIA4lmXPt/
 DxTLg7T3Xh4nuXV4wBVXy5QRtn4DzDN0PapoZJ024ddd+VqQeXaAbE9bXZuCr9NInBfA
 Z49oqXghtbe+HOFKwOTw3QIpRx3fSwR++4g3i6l8dzXEfHBbexZusyEEWt5hNGe0LDzY
 S1bQDZ93BF+a6aDvI90Qqmf/im0RQhlqd2rbwxCMD55fuGN2DNMN8EOUC2gHr+QvCe5A
 tu6w+TL9kOCNbMyx3Om46jyaJZdYNjKldbYlJBAZE6t9b1FXcK0jeI5id0S1gfdzERkL
 RzjA==
X-Gm-Message-State: AFuF++nAVUU/kbRMmOnQwXDya7MGXZspsYRIxOpqq+bZRp3mbV0he5oZ
 fbzxoKJh8NTv8AZbebeztfb2PXekTpZCDz7HjyutA11J2eJb7+tPn1qr5VnQKQ==
X-Gm-Gg: AYBFou0/xf5lE8IoGvcmqdYPFfvp4woSdJdzeN91tW007tbHlcB2jZPvyV2uXhsjQWY
 RZGDyeZNBkgdMFsXKf1ZNY0DK3/6waupbveKlBmGhx371ErDGK65PboE6Izyed/p1jQvqVtwGG/
 8LbM761HB8T2+LRiKvd8tKL7U3JU7j/8N2qNCLpsXvLsR/HdRVhbI+jrD81CSSU90gWRi0hgQ7C
 i+etYuCk6Wh42XP4K/Vix9ksStwO8zvcSNdrQ1d75feelXR448L+25+FT1oP5IGCrsRonSh1drQ
 vSe/ZylPPh+2i4cyX/IpnZX3TPj8MPKTKG6RCJnhitFATxKxyE2SOY7MTnadod5yuGOTXsab9Le
 /99P1uu6c8tEJueaVUIAUPVPkF53WnubU3d6Xa7s4duHD5x3VBq9I5/Of8WPIFmbplN2nJIgawE
 Kpnegrr6o57dEFRY7fEQiWhyHs1+n+ggtplz49H+fFH87+zH6heO57N3Fx1rB6m7evD8egRdN9s
 qJ5d/UNNxBrt/PtHcqA+mHzpUxLt3+cHIr/JV1FaLblsgLNxqmo
X-Received: by 2002:a05:6214:c69:b0:910:4874:66e5 with SMTP id
 6a1803df08f44-912120d61f1mr207910576d6.21.1789314790395; 
 Sun, 13 Sep 2026 08:53:10 -0700 (PDT)
Received: from aford-System-Version.lan (c-73-94-212-116.hsd1.mn.comcast.net.
 [73.94.212.116]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4d3a50sm72993386d6.40.2026.09.13.08.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:53:09 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH 3/3] board: beacon: Remove i.MX8MP Beacon EmbeddedWorks Devkit
 support
Date: Sun, 13 Sep 2026 10:53:03 -0500
Message-ID: <20260913155303.84201-4-aford173@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913155303.84201-1-aford173@gmail.com>
References: <20260913155303.84201-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 23:20:05 +0000
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

Remove the i.MX8MP Beacon EmbeddedWorks Devkit board support along
with its defconfig, config header, U-Boot device tree overlay,
documentation and Kconfig target. This was the last Beacon board, so
drop the Beacon documentation index as well.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi  |  196 --
 arch/arm/mach-imx/imx8m/Kconfig             |   11 -
 board/beacon/imx8mp/Kconfig                 |   16 -
 board/beacon/imx8mp/MAINTAINERS             |    6 -
 board/beacon/imx8mp/Makefile                |   13 -
 board/beacon/imx8mp/imx8mp_beacon.c         |   34 -
 board/beacon/imx8mp/imx8mp_beacon.env       |   19 -
 board/beacon/imx8mp/imximage-8mp-lpddr4.cfg |    9 -
 board/beacon/imx8mp/lpddr4_timing.c         | 1881 -------------------
 board/beacon/imx8mp/spl.c                   |  126 --
 configs/imx8mp_beacon_defconfig             |  179 --
 doc/board/beacon/beacon-imx8mp.rst          |   52 -
 doc/board/beacon/index.rst                  |    9 -
 doc/board/index.rst                         |    1 -
 include/configs/imx8mp_beacon.h             |   25 -
 15 files changed, 2577 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
 delete mode 100644 board/beacon/imx8mp/Kconfig
 delete mode 100644 board/beacon/imx8mp/MAINTAINERS
 delete mode 100644 board/beacon/imx8mp/Makefile
 delete mode 100644 board/beacon/imx8mp/imx8mp_beacon.c
 delete mode 100644 board/beacon/imx8mp/imx8mp_beacon.env
 delete mode 100644 board/beacon/imx8mp/imximage-8mp-lpddr4.cfg
 delete mode 100644 board/beacon/imx8mp/lpddr4_timing.c
 delete mode 100644 board/beacon/imx8mp/spl.c
 delete mode 100644 configs/imx8mp_beacon_defconfig
 delete mode 100644 doc/board/beacon/beacon-imx8mp.rst
 delete mode 100644 doc/board/beacon/index.rst
 delete mode 100644 include/configs/imx8mp_beacon.h

diff --git a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
deleted file mode 100644
index 380146596c0..00000000000
--- a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
+++ /dev/null
@@ -1,196 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2022 Logic PD, Inc DBA Beacon EmbeddedWorks
- */
-
-#include "imx8mp-u-boot.dtsi"
-
-/ {
-	/* U-Boot does not yet have a proper PCIe clk driver */
-	pcie0_refclk: clock-pcie {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	wdt-reboot {
-		compatible = "wdt-reboot";
-		wdt = <&wdog1>;
-		bootph-pre-ram;
-	};
-};
-
-&pcie_phy {
-	clocks = <&pcie0_refclk>;
-};
-
-&{/soc@0/bus@30800000/i2c@30a20000/pmic@25} {
-	bootph-pre-ram;
-};
-
-&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
-	bootph-pre-ram;
-};
-
-&ethphy0 {
-	reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-	reset-assert-us = <15000>;
-	reset-deassert-us = <100000>;
-};
-
-&fec {
-	phy-reset-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <15>;
-	phy-reset-post-delay = <100>;
-};
-
-&flexspi {
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_400M>;
-};
-
-&gpio1 {
-	bootph-pre-ram;
-};
-
-&gpio2 {
-	bootph-pre-ram;
-};
-
-&gpio3 {
-	bootph-pre-ram;
-};
-
-&gpio4 {
-	bootph-pre-ram;
-};
-
-&gpio5 {
-	bootph-pre-ram;
-};
-
-&i2c1 {
-	bootph-pre-ram;
-};
-
-&i2c2 {
-	bootph-pre-ram;
-};
-
-&i2c3 {
-	bootph-pre-ram;
-};
-
-&pca6416 {
-	compatible = "ti,tca6416";
-	label = "exp4";
-};
-
-&pca6416_1 {
-	compatible = "ti,tca6416";
-	label = "exp4";
-};
-
-&pca6416_3 {
-	compatible = "ti,tca6416";
-	label = "exp2";
-};
-
-&pinctrl_i2c1 {
-	bootph-pre-ram;
-};
-
-&pinctrl_pmic {
-	bootph-pre-ram;
-};
-
-&pinctrl_reg_usdhc2_vmmc {
-	bootph-pre-ram;
-};
-
-&pinctrl_uart2 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc2_gpio {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc2 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc3 {
-	bootph-pre-ram;
-};
-
-&pinctrl_wdog {
-	bootph-pre-ram;
-};
-
-&reg_usdhc2_vmmc {
-	bootph-pre-ram;
-	u-boot,off-on-delay-us = <20000>;
-};
-
-&tpm {
-	compatible = "tcg,tpm_tis-spi";
-};
-
-&uart2 {
-	bootph-pre-ram;
-};
-
-&usdhc1 {
-	bootph-pre-ram;
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC1>;
-	assigned-clock-rates = <400000000>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_400M>;
-};
-
-&usdhc2 {
-	bootph-pre-ram;
-	sd-uhs-sdr104;
-	sd-uhs-ddr50;
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
-	assigned-clock-rates = <400000000>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_400M>;
-};
-
-&usdhc3 {
-	bootph-pre-ram;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
-	assigned-clock-rates = <400000000>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_400M>;
-};
-
-&usb3_0 {
-	dma-ranges = <0x40000000 0x40000000 0xc0000000>;
-};
-
-&usb3_1 {
-	dma-ranges = <0x40000000 0x40000000 0xc0000000>;
-};
-
-&usb_dwc3_0 {
-	compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
-	assigned-clocks = <&clk IMX8MP_CLK_HSIO_AXI>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
-	assigned-clock-rates = <400000000>;
-};
-
-&usb_dwc3_1 {
-	compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
-	assigned-clocks = <&clk IMX8MP_CLK_HSIO_AXI>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
-	assigned-clock-rates = <400000000>;
-};
-
-&usdhc1 {
-	status = "disabled";
-};
-
-&wdog1 {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 6f150f2d01b..4ef35004c57 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -238,16 +238,6 @@ config TARGET_IMX8MP_DATA_MODUL_EDM_SBC
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
 
-config TARGET_IMX8MP_BEACON
-	bool "imx8mm Beacon Embedded devkit"
-	select IMX8MP
-	select SUPPORT_SPL
-	select IMX8M_LPDDR4
-	select FSL_CAAM
-	select ARCH_MISC_INIT
-	select SPL_CRYPTO if SPL
-	imply OF_UPSTREAM
-
 config TARGET_IMX8MP_DEBIX_MODEL_A
 	bool "Polyhex i.MX8M Plus Debix Model A SBC"
 	select IMX8MP
@@ -426,7 +416,6 @@ config TARGET_LIBREM5_DEVKIT
 endchoice
 
 source "board/advantech/imx8mp_rsb3720a1/Kconfig"
-source "board/beacon/imx8mp/Kconfig"
 source "board/bsh/imx8mn_smm_s2/Kconfig"
 source "board/cloos/imx8mm_phg/Kconfig"
 source "board/compulab/imx8mm-cl-iot-gate/Kconfig"
diff --git a/board/beacon/imx8mp/Kconfig b/board/beacon/imx8mp/Kconfig
deleted file mode 100644
index b0dd98cf9fd..00000000000
--- a/board/beacon/imx8mp/Kconfig
+++ /dev/null
@@ -1,16 +0,0 @@
-if TARGET_IMX8MP_BEACON
-
-config SYS_BOARD
-	default "imx8mp"
-
-config SYS_VENDOR
-	default "beacon"
-
-config SYS_CONFIG_NAME
-	default "imx8mp_beacon"
-
-config IMX_CONFIG
-	default "board/nxp/imx8mp_evk/imximage-8mp-lpddr4.cfg"
-
-
-endif
diff --git a/board/beacon/imx8mp/MAINTAINERS b/board/beacon/imx8mp/MAINTAINERS
deleted file mode 100644
index 3750551a4aa..00000000000
--- a/board/beacon/imx8mp/MAINTAINERS
+++ /dev/null
@@ -1,6 +0,0 @@
-i.MX8MP Beacon EmbeddedWorks Devkit
-M:	Adam Ford <aford173@gmail.com>
-S:	Maintained
-F:	board/beacon/imx8mp/
-F:	include/configs/imx8mp_beacon.h
-F:	configs/imx8mp_beacon_defconfig
diff --git a/board/beacon/imx8mp/Makefile b/board/beacon/imx8mp/Makefile
deleted file mode 100644
index 669b54d63e7..00000000000
--- a/board/beacon/imx8mp/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright 2022 Logic PD, Inc dba Beacon EmbeddedWorks
-#
-
-obj-y += imx8mp_beacon.o
-obj-y += ../../nxp/common/
-
-ifdef CONFIG_XPL_BUILD
-obj-y += spl.o
-obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
-endif
diff --git a/board/beacon/imx8mp/imx8mp_beacon.c b/board/beacon/imx8mp/imx8mp_beacon.c
deleted file mode 100644
index 541a4b00eba..00000000000
--- a/board/beacon/imx8mp/imx8mp_beacon.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/* Copyright 2023 Logic PD, Inc dba Beacon EmbeddedWorks */
-
-#include <init.h>
-#include <miiphy.h>
-#include <asm/arch/sys_proto.h>
-
-static void setup_fec(void)
-{
-	struct iomuxc_gpr_base_regs *gpr =
-		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
-
-	/* Enable RGMII TX clk output */
-	setbits_le32(&gpr->gpr[1], BIT(22));
-}
-
-#if IS_ENABLED(CONFIG_NET_LEGACY)
-int board_phy_config(struct phy_device *phydev)
-{
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-	return 0;
-}
-#endif
-
-int board_init(void)
-{
-	int ret = 0;
-
-	if (CONFIG_IS_ENABLED(FEC_MXC))
-		setup_fec();
-
-	return ret;
-}
diff --git a/board/beacon/imx8mp/imx8mp_beacon.env b/board/beacon/imx8mp/imx8mp_beacon.env
deleted file mode 100644
index ec9fbd33323..00000000000
--- a/board/beacon/imx8mp/imx8mp_beacon.env
+++ /dev/null
@@ -1,19 +0,0 @@
-boot_fdt=try
-boot_fit=no
-console=ttymxc1,115200
-fdt_addr=0x43000000
-fdt_addr_r=0x43000000
-fdt_file=imx8mp-beacon-kit.dtb
-finduuid=part uuid mmc ${mmcdev}:2 uuid
-image=Image
-kernel_addr_r=0x40480000
-loadfdt=echo ${fdt_file}; fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdt_file}
-loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
-mmcargs=setenv bootargs console=${console}  root=PARTUUID=${uuid} rootwait rw ${mtdparts} ${optargs}
-mmcboot=echo Booting from mmc ...; run finduuid; run mmcargs; if test ${boot_fit} = yes || test ${boot_fit} = try; then bootm ${loadaddr}; else if run loadfdt; then booti ${loadaddr} - ${fdt_addr_r}; else echo WARN: Cannot load the DT; fi; fi;
-mmcdev=1
-mmcpart=1
-netargs=setenv bootargs ${jh_clk} console=${console} root=/dev/nfs ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
-netboot=echo Booting from net ...; run netargs;  if test ${ip_dyn} = yes; then setenv get_cmd dhcp; else setenv get_cmd tftp; fi; ${get_cmd} ${loadaddr} ${image}; if test ${boot_fit} = yes || test ${boot_fit} = try; then bootm ${loadaddr}; else if ${get_cmd} ${fdt_addr_r} ${fdt_file}; then booti ${loadaddr} - ${fdt_addr_r}; else echo WARN: Cannot load the DT; fi; fi;
-optargs=audit=0 video=LVDS-1:d video=LVDS-2:d
-scriptaddr=0x40480000
diff --git a/board/beacon/imx8mp/imximage-8mp-lpddr4.cfg b/board/beacon/imx8mp/imximage-8mp-lpddr4.cfg
deleted file mode 100644
index 6dedf1724ab..00000000000
--- a/board/beacon/imx8mp/imximage-8mp-lpddr4.cfg
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2021 NXP
- */
-
-
-ROM_VERSION	v2
-BOOT_FROM	sd
-LOADER		u-boot-spl-ddr.bin	0x920000
diff --git a/board/beacon/imx8mp/lpddr4_timing.c b/board/beacon/imx8mp/lpddr4_timing.c
deleted file mode 100644
index ae0b84870ed..00000000000
--- a/board/beacon/imx8mp/lpddr4_timing.c
+++ /dev/null
@@ -1,1881 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/* Copyright 2022 Logic PD, Inc dba Beacon EmbeddedWorks */
-
-#include <linux/kernel.h>
-#include <asm/arch/ddr.h>
-
-struct dram_cfg_param ddr_ddrc_cfg[] = {
-	/** Initialize DDRC registers **/
-	{ 0x3d400304, 0x1 },
-	{ 0x3d400030, 0x1 },
-	{ 0x3d400000, 0xa3080020 },
-	{ 0x3d400020, 0x1322 },
-	{ 0x3d400024, 0x1e84800 },
-	{ 0x3d400064, 0x3d017c },
-#if IS_ENABLED(CONFIG_IMX8M_DRAM_INLINE_ECC)
-	{ 0x3d400070, 0x1027f54 },
-#else
-	{ 0x3d400070, 0x7027f90 },
-#endif
-	{ 0x3d400074, 0x790 },
-	{ 0x3d4000d0, 0xc00307a3 },
-	{ 0x3d4000d4, 0xc50000 },
-	{ 0x3d4000dc, 0xf4003f },
-	{ 0x3d4000e0, 0x330000 },
-	{ 0x3d4000e8, 0x660048 },
-	{ 0x3d4000ec, 0x160048 },
-	{ 0x3d400100, 0x2028112a },
-	{ 0x3d400104, 0x8083f },
-	{ 0x3d40010c, 0xe0e000 },
-	{ 0x3d400110, 0x12040a12 },
-	{ 0x3d400114, 0x2050f0f },
-	{ 0x3d400118, 0x1010009 },
-	{ 0x3d40011c, 0x501 },
-	{ 0x3d400130, 0x20800 },
-	{ 0x3d400134, 0xe100002 },
-	{ 0x3d400138, 0x184 },
-	{ 0x3d400144, 0xc80064 },
-	{ 0x3d400180, 0x3e8001e },
-	{ 0x3d400184, 0x3207a12 },
-	{ 0x3d400188, 0x0 },
-	{ 0x3d400190, 0x49f820e },
-	{ 0x3d400194, 0x80303 },
-	{ 0x3d4001b4, 0x1f0e },
-	{ 0x3d4001a0, 0xe0400018 },
-	{ 0x3d4001a4, 0xdf00e4 },
-	{ 0x3d4001a8, 0x80000000 },
-	{ 0x3d4001b0, 0x11 },
-	{ 0x3d4001c0, 0x1 },
-	{ 0x3d4001c4, 0x1 },
-	{ 0x3d4000f4, 0xc99 },
-	{ 0x3d400108, 0x9121c1c },
-#if IS_ENABLED(CONFIG_IMX8M_DRAM_INLINE_ECC)
-	{ 0x3d400200, 0x13 },
-	{ 0x3d40020c, 0x13131300 },
-	{ 0x3d400210, 0x1f1f },
-	{ 0x3d400204, 0x50505 },
-	{ 0x3d400214, 0x4040404 },
-	{ 0x3d400218, 0x68040404 },
-#else
-	{ 0x3d400200, 0x16 },
-	{ 0x3d40020c, 0x0 },
-	{ 0x3d400210, 0x1f1f },
-	{ 0x3d400204, 0x80808 },
-	{ 0x3d400214, 0x7070707 },
-	{ 0x3d400218, 0x68070707 },
-#endif
-	{ 0x3d40021c, 0xf08 },
-	{ 0x3d400250, 0x1705 },
-	{ 0x3d400254, 0x2c },
-	{ 0x3d40025c, 0x4000030 },
-	{ 0x3d400264, 0x900093e7 },
-	{ 0x3d40026c, 0x2005574 },
-	{ 0x3d400400, 0x111 },
-	{ 0x3d400404, 0x72ff },
-	{ 0x3d400408, 0x72ff },
-	{ 0x3d400494, 0x2100e07 },
-	{ 0x3d400498, 0x620096 },
-	{ 0x3d40049c, 0x1100e07 },
-	{ 0x3d4004a0, 0xc8012c },
-	{ 0x3d402020, 0x1020 },
-	{ 0x3d402024, 0x30d400 },
-	{ 0x3d402050, 0x20d000 },
-	{ 0x3d402064, 0x60026 },
-	{ 0x3d4020dc, 0x840000 },
-	{ 0x3d4020e0, 0x330000 },
-	{ 0x3d4020e8, 0x660048 },
-	{ 0x3d4020ec, 0x160048 },
-	{ 0x3d402100, 0xa040105 },
-	{ 0x3d402104, 0x30407 },
-	{ 0x3d402108, 0x203060b },
-	{ 0x3d40210c, 0x505000 },
-	{ 0x3d402110, 0x2040202 },
-	{ 0x3d402114, 0x2030202 },
-	{ 0x3d402118, 0x1010004 },
-	{ 0x3d40211c, 0x301 },
-	{ 0x3d402130, 0x20300 },
-	{ 0x3d402134, 0xa100002 },
-	{ 0x3d402138, 0x27 },
-	{ 0x3d402144, 0x14000a },
-	{ 0x3d402180, 0x640004 },
-	{ 0x3d402190, 0x3818200 },
-	{ 0x3d402194, 0x80303 },
-	{ 0x3d4021b4, 0x100 },
-	{ 0x3d4020f4, 0xc99 },
-	{ 0x3d403020, 0x1020 },
-	{ 0x3d403024, 0xc3500 },
-	{ 0x3d403050, 0x20d000 },
-	{ 0x3d403064, 0x3000a },
-	{ 0x3d4030dc, 0x840000 },
-	{ 0x3d4030e0, 0x330000 },
-	{ 0x3d4030e8, 0x660048 },
-	{ 0x3d4030ec, 0x160048 },
-	{ 0x3d403100, 0xa010102 },
-	{ 0x3d403104, 0x30404 },
-	{ 0x3d403108, 0x203060b },
-	{ 0x3d40310c, 0x505000 },
-	{ 0x3d403110, 0x2040202 },
-	{ 0x3d403114, 0x2030202 },
-	{ 0x3d403118, 0x1010004 },
-	{ 0x3d40311c, 0x301 },
-	{ 0x3d403130, 0x20300 },
-	{ 0x3d403134, 0xa100002 },
-	{ 0x3d403138, 0xa },
-	{ 0x3d403144, 0x50003 },
-	{ 0x3d403180, 0x190004 },
-	{ 0x3d403190, 0x3818200 },
-	{ 0x3d403194, 0x80303 },
-	{ 0x3d4031b4, 0x100 },
-	{ 0x3d4030f4, 0xc99 },
-	{ 0x3d400028, 0x0 },
-};
-
-/* PHY Initialize Configuration */
-struct dram_cfg_param ddr_ddrphy_cfg[] = {
-	{ 0x100a0, 0x0 },
-	{ 0x100a1, 0x1 },
-	{ 0x100a2, 0x2 },
-	{ 0x100a3, 0x3 },
-	{ 0x100a4, 0x4 },
-	{ 0x100a5, 0x5 },
-	{ 0x100a6, 0x6 },
-	{ 0x100a7, 0x7 },
-	{ 0x110a0, 0x0 },
-	{ 0x110a1, 0x1 },
-	{ 0x110a2, 0x3 },
-	{ 0x110a3, 0x4 },
-	{ 0x110a4, 0x5 },
-	{ 0x110a5, 0x2 },
-	{ 0x110a6, 0x7 },
-	{ 0x110a7, 0x6 },
-	{ 0x120a0, 0x0 },
-	{ 0x120a1, 0x1 },
-	{ 0x120a2, 0x3 },
-	{ 0x120a3, 0x2 },
-	{ 0x120a4, 0x5 },
-	{ 0x120a5, 0x4 },
-	{ 0x120a6, 0x7 },
-	{ 0x120a7, 0x6 },
-	{ 0x130a0, 0x0 },
-	{ 0x130a1, 0x1 },
-	{ 0x130a2, 0x2 },
-	{ 0x130a3, 0x3 },
-	{ 0x130a4, 0x4 },
-	{ 0x130a5, 0x5 },
-	{ 0x130a6, 0x6 },
-	{ 0x130a7, 0x7 },
-	{ 0x1005f, 0x1ff },
-	{ 0x1015f, 0x1ff },
-	{ 0x1105f, 0x1ff },
-	{ 0x1115f, 0x1ff },
-	{ 0x1205f, 0x1ff },
-	{ 0x1215f, 0x1ff },
-	{ 0x1305f, 0x1ff },
-	{ 0x1315f, 0x1ff },
-	{ 0x11005f, 0x1ff },
-	{ 0x11015f, 0x1ff },
-	{ 0x11105f, 0x1ff },
-	{ 0x11115f, 0x1ff },
-	{ 0x11205f, 0x1ff },
-	{ 0x11215f, 0x1ff },
-	{ 0x11305f, 0x1ff },
-	{ 0x11315f, 0x1ff },
-	{ 0x21005f, 0x1ff },
-	{ 0x21015f, 0x1ff },
-	{ 0x21105f, 0x1ff },
-	{ 0x21115f, 0x1ff },
-	{ 0x21205f, 0x1ff },
-	{ 0x21215f, 0x1ff },
-	{ 0x21305f, 0x1ff },
-	{ 0x21315f, 0x1ff },
-	{ 0x55, 0x1ff },
-	{ 0x1055, 0x1ff },
-	{ 0x2055, 0x1ff },
-	{ 0x3055, 0x1ff },
-	{ 0x4055, 0x1ff },
-	{ 0x5055, 0x1ff },
-	{ 0x6055, 0x1ff },
-	{ 0x7055, 0x1ff },
-	{ 0x8055, 0x1ff },
-	{ 0x9055, 0x1ff },
-	{ 0x200c5, 0x18 },
-	{ 0x1200c5, 0x7 },
-	{ 0x2200c5, 0x7 },
-	{ 0x2002e, 0x2 },
-	{ 0x12002e, 0x2 },
-	{ 0x22002e, 0x2 },
-	{ 0x90204, 0x0 },
-	{ 0x190204, 0x0 },
-	{ 0x290204, 0x0 },
-	{ 0x20024, 0x1e3 },
-	{ 0x2003a, 0x2 },
-	{ 0x120024, 0x1e3 },
-	{ 0x2003a, 0x2 },
-	{ 0x220024, 0x1e3 },
-	{ 0x2003a, 0x2 },
-	{ 0x20056, 0x3 },
-	{ 0x120056, 0x3 },
-	{ 0x220056, 0x3 },
-	{ 0x1004d, 0xe00 },
-	{ 0x1014d, 0xe00 },
-	{ 0x1104d, 0xe00 },
-	{ 0x1114d, 0xe00 },
-	{ 0x1204d, 0xe00 },
-	{ 0x1214d, 0xe00 },
-	{ 0x1304d, 0xe00 },
-	{ 0x1314d, 0xe00 },
-	{ 0x11004d, 0xe00 },
-	{ 0x11014d, 0xe00 },
-	{ 0x11104d, 0xe00 },
-	{ 0x11114d, 0xe00 },
-	{ 0x11204d, 0xe00 },
-	{ 0x11214d, 0xe00 },
-	{ 0x11304d, 0xe00 },
-	{ 0x11314d, 0xe00 },
-	{ 0x21004d, 0xe00 },
-	{ 0x21014d, 0xe00 },
-	{ 0x21104d, 0xe00 },
-	{ 0x21114d, 0xe00 },
-	{ 0x21204d, 0xe00 },
-	{ 0x21214d, 0xe00 },
-	{ 0x21304d, 0xe00 },
-	{ 0x21314d, 0xe00 },
-	{ 0x10049, 0xeba },
-	{ 0x10149, 0xeba },
-	{ 0x11049, 0xeba },
-	{ 0x11149, 0xeba },
-	{ 0x12049, 0xeba },
-	{ 0x12149, 0xeba },
-	{ 0x13049, 0xeba },
-	{ 0x13149, 0xeba },
-	{ 0x110049, 0xeba },
-	{ 0x110149, 0xeba },
-	{ 0x111049, 0xeba },
-	{ 0x111149, 0xeba },
-	{ 0x112049, 0xeba },
-	{ 0x112149, 0xeba },
-	{ 0x113049, 0xeba },
-	{ 0x113149, 0xeba },
-	{ 0x210049, 0xeba },
-	{ 0x210149, 0xeba },
-	{ 0x211049, 0xeba },
-	{ 0x211149, 0xeba },
-	{ 0x212049, 0xeba },
-	{ 0x212149, 0xeba },
-	{ 0x213049, 0xeba },
-	{ 0x213149, 0xeba },
-	{ 0x43, 0x63 },
-	{ 0x1043, 0x63 },
-	{ 0x2043, 0x63 },
-	{ 0x3043, 0x63 },
-	{ 0x4043, 0x63 },
-	{ 0x5043, 0x63 },
-	{ 0x6043, 0x63 },
-	{ 0x7043, 0x63 },
-	{ 0x8043, 0x63 },
-	{ 0x9043, 0x63 },
-	{ 0x20018, 0x3 },
-	{ 0x20075, 0x4 },
-	{ 0x20050, 0x0 },
-	{ 0x20008, 0x3e8 },
-	{ 0x120008, 0x64 },
-	{ 0x220008, 0x19 },
-	{ 0x20088, 0x9 },
-	{ 0x200b2, 0x104 },
-	{ 0x10043, 0x5a1 },
-	{ 0x10143, 0x5a1 },
-	{ 0x11043, 0x5a1 },
-	{ 0x11143, 0x5a1 },
-	{ 0x12043, 0x5a1 },
-	{ 0x12143, 0x5a1 },
-	{ 0x13043, 0x5a1 },
-	{ 0x13143, 0x5a1 },
-	{ 0x1200b2, 0x104 },
-	{ 0x110043, 0x5a1 },
-	{ 0x110143, 0x5a1 },
-	{ 0x111043, 0x5a1 },
-	{ 0x111143, 0x5a1 },
-	{ 0x112043, 0x5a1 },
-	{ 0x112143, 0x5a1 },
-	{ 0x113043, 0x5a1 },
-	{ 0x113143, 0x5a1 },
-	{ 0x2200b2, 0x104 },
-	{ 0x210043, 0x5a1 },
-	{ 0x210143, 0x5a1 },
-	{ 0x211043, 0x5a1 },
-	{ 0x211143, 0x5a1 },
-	{ 0x212043, 0x5a1 },
-	{ 0x212143, 0x5a1 },
-	{ 0x213043, 0x5a1 },
-	{ 0x213143, 0x5a1 },
-	{ 0x200fa, 0x1 },
-	{ 0x1200fa, 0x1 },
-	{ 0x2200fa, 0x1 },
-	{ 0x20019, 0x1 },
-	{ 0x120019, 0x1 },
-	{ 0x220019, 0x1 },
-	{ 0x200f0, 0x660 },
-	{ 0x200f1, 0x0 },
-	{ 0x200f2, 0x4444 },
-	{ 0x200f3, 0x8888 },
-	{ 0x200f4, 0x5665 },
-	{ 0x200f5, 0x0 },
-	{ 0x200f6, 0x0 },
-	{ 0x200f7, 0xf000 },
-	{ 0x20025, 0x0 },
-	{ 0x2002d, 0x0 },
-	{ 0x12002d, 0x0 },
-	{ 0x22002d, 0x0 },
-	{ 0x2007d, 0x212 },
-	{ 0x12007d, 0x212 },
-	{ 0x22007d, 0x212 },
-	{ 0x2007c, 0x61 },
-	{ 0x12007c, 0x61 },
-	{ 0x22007c, 0x61 },
-	{ 0x1004a, 0x500 },
-	{ 0x1104a, 0x500 },
-	{ 0x1204a, 0x500 },
-	{ 0x1304a, 0x500 },
-	{ 0x2002c, 0x0 },
-};
-
-/* ddr phy trained csr */
-struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
-	{ 0x200b2, 0x0 },
-	{ 0x1200b2, 0x0 },
-	{ 0x2200b2, 0x0 },
-	{ 0x200cb, 0x0 },
-	{ 0x10043, 0x0 },
-	{ 0x110043, 0x0 },
-	{ 0x210043, 0x0 },
-	{ 0x10143, 0x0 },
-	{ 0x110143, 0x0 },
-	{ 0x210143, 0x0 },
-	{ 0x11043, 0x0 },
-	{ 0x111043, 0x0 },
-	{ 0x211043, 0x0 },
-	{ 0x11143, 0x0 },
-	{ 0x111143, 0x0 },
-	{ 0x211143, 0x0 },
-	{ 0x12043, 0x0 },
-	{ 0x112043, 0x0 },
-	{ 0x212043, 0x0 },
-	{ 0x12143, 0x0 },
-	{ 0x112143, 0x0 },
-	{ 0x212143, 0x0 },
-	{ 0x13043, 0x0 },
-	{ 0x113043, 0x0 },
-	{ 0x213043, 0x0 },
-	{ 0x13143, 0x0 },
-	{ 0x113143, 0x0 },
-	{ 0x213143, 0x0 },
-	{ 0x80, 0x0 },
-	{ 0x100080, 0x0 },
-	{ 0x200080, 0x0 },
-	{ 0x1080, 0x0 },
-	{ 0x101080, 0x0 },
-	{ 0x201080, 0x0 },
-	{ 0x2080, 0x0 },
-	{ 0x102080, 0x0 },
-	{ 0x202080, 0x0 },
-	{ 0x3080, 0x0 },
-	{ 0x103080, 0x0 },
-	{ 0x203080, 0x0 },
-	{ 0x4080, 0x0 },
-	{ 0x104080, 0x0 },
-	{ 0x204080, 0x0 },
-	{ 0x5080, 0x0 },
-	{ 0x105080, 0x0 },
-	{ 0x205080, 0x0 },
-	{ 0x6080, 0x0 },
-	{ 0x106080, 0x0 },
-	{ 0x206080, 0x0 },
-	{ 0x7080, 0x0 },
-	{ 0x107080, 0x0 },
-	{ 0x207080, 0x0 },
-	{ 0x8080, 0x0 },
-	{ 0x108080, 0x0 },
-	{ 0x208080, 0x0 },
-	{ 0x9080, 0x0 },
-	{ 0x109080, 0x0 },
-	{ 0x209080, 0x0 },
-	{ 0x10080, 0x0 },
-	{ 0x110080, 0x0 },
-	{ 0x210080, 0x0 },
-	{ 0x10180, 0x0 },
-	{ 0x110180, 0x0 },
-	{ 0x210180, 0x0 },
-	{ 0x11080, 0x0 },
-	{ 0x111080, 0x0 },
-	{ 0x211080, 0x0 },
-	{ 0x11180, 0x0 },
-	{ 0x111180, 0x0 },
-	{ 0x211180, 0x0 },
-	{ 0x12080, 0x0 },
-	{ 0x112080, 0x0 },
-	{ 0x212080, 0x0 },
-	{ 0x12180, 0x0 },
-	{ 0x112180, 0x0 },
-	{ 0x212180, 0x0 },
-	{ 0x13080, 0x0 },
-	{ 0x113080, 0x0 },
-	{ 0x213080, 0x0 },
-	{ 0x13180, 0x0 },
-	{ 0x113180, 0x0 },
-	{ 0x213180, 0x0 },
-	{ 0x10081, 0x0 },
-	{ 0x110081, 0x0 },
-	{ 0x210081, 0x0 },
-	{ 0x10181, 0x0 },
-	{ 0x110181, 0x0 },
-	{ 0x210181, 0x0 },
-	{ 0x11081, 0x0 },
-	{ 0x111081, 0x0 },
-	{ 0x211081, 0x0 },
-	{ 0x11181, 0x0 },
-	{ 0x111181, 0x0 },
-	{ 0x211181, 0x0 },
-	{ 0x12081, 0x0 },
-	{ 0x112081, 0x0 },
-	{ 0x212081, 0x0 },
-	{ 0x12181, 0x0 },
-	{ 0x112181, 0x0 },
-	{ 0x212181, 0x0 },
-	{ 0x13081, 0x0 },
-	{ 0x113081, 0x0 },
-	{ 0x213081, 0x0 },
-	{ 0x13181, 0x0 },
-	{ 0x113181, 0x0 },
-	{ 0x213181, 0x0 },
-	{ 0x100d0, 0x0 },
-	{ 0x1100d0, 0x0 },
-	{ 0x2100d0, 0x0 },
-	{ 0x101d0, 0x0 },
-	{ 0x1101d0, 0x0 },
-	{ 0x2101d0, 0x0 },
-	{ 0x110d0, 0x0 },
-	{ 0x1110d0, 0x0 },
-	{ 0x2110d0, 0x0 },
-	{ 0x111d0, 0x0 },
-	{ 0x1111d0, 0x0 },
-	{ 0x2111d0, 0x0 },
-	{ 0x120d0, 0x0 },
-	{ 0x1120d0, 0x0 },
-	{ 0x2120d0, 0x0 },
-	{ 0x121d0, 0x0 },
-	{ 0x1121d0, 0x0 },
-	{ 0x2121d0, 0x0 },
-	{ 0x130d0, 0x0 },
-	{ 0x1130d0, 0x0 },
-	{ 0x2130d0, 0x0 },
-	{ 0x131d0, 0x0 },
-	{ 0x1131d0, 0x0 },
-	{ 0x2131d0, 0x0 },
-	{ 0x100d1, 0x0 },
-	{ 0x1100d1, 0x0 },
-	{ 0x2100d1, 0x0 },
-	{ 0x101d1, 0x0 },
-	{ 0x1101d1, 0x0 },
-	{ 0x2101d1, 0x0 },
-	{ 0x110d1, 0x0 },
-	{ 0x1110d1, 0x0 },
-	{ 0x2110d1, 0x0 },
-	{ 0x111d1, 0x0 },
-	{ 0x1111d1, 0x0 },
-	{ 0x2111d1, 0x0 },
-	{ 0x120d1, 0x0 },
-	{ 0x1120d1, 0x0 },
-	{ 0x2120d1, 0x0 },
-	{ 0x121d1, 0x0 },
-	{ 0x1121d1, 0x0 },
-	{ 0x2121d1, 0x0 },
-	{ 0x130d1, 0x0 },
-	{ 0x1130d1, 0x0 },
-	{ 0x2130d1, 0x0 },
-	{ 0x131d1, 0x0 },
-	{ 0x1131d1, 0x0 },
-	{ 0x2131d1, 0x0 },
-	{ 0x10068, 0x0 },
-	{ 0x10168, 0x0 },
-	{ 0x10268, 0x0 },
-	{ 0x10368, 0x0 },
-	{ 0x10468, 0x0 },
-	{ 0x10568, 0x0 },
-	{ 0x10668, 0x0 },
-	{ 0x10768, 0x0 },
-	{ 0x10868, 0x0 },
-	{ 0x11068, 0x0 },
-	{ 0x11168, 0x0 },
-	{ 0x11268, 0x0 },
-	{ 0x11368, 0x0 },
-	{ 0x11468, 0x0 },
-	{ 0x11568, 0x0 },
-	{ 0x11668, 0x0 },
-	{ 0x11768, 0x0 },
-	{ 0x11868, 0x0 },
-	{ 0x12068, 0x0 },
-	{ 0x12168, 0x0 },
-	{ 0x12268, 0x0 },
-	{ 0x12368, 0x0 },
-	{ 0x12468, 0x0 },
-	{ 0x12568, 0x0 },
-	{ 0x12668, 0x0 },
-	{ 0x12768, 0x0 },
-	{ 0x12868, 0x0 },
-	{ 0x13068, 0x0 },
-	{ 0x13168, 0x0 },
-	{ 0x13268, 0x0 },
-	{ 0x13368, 0x0 },
-	{ 0x13468, 0x0 },
-	{ 0x13568, 0x0 },
-	{ 0x13668, 0x0 },
-	{ 0x13768, 0x0 },
-	{ 0x13868, 0x0 },
-	{ 0x10069, 0x0 },
-	{ 0x10169, 0x0 },
-	{ 0x10269, 0x0 },
-	{ 0x10369, 0x0 },
-	{ 0x10469, 0x0 },
-	{ 0x10569, 0x0 },
-	{ 0x10669, 0x0 },
-	{ 0x10769, 0x0 },
-	{ 0x10869, 0x0 },
-	{ 0x11069, 0x0 },
-	{ 0x11169, 0x0 },
-	{ 0x11269, 0x0 },
-	{ 0x11369, 0x0 },
-	{ 0x11469, 0x0 },
-	{ 0x11569, 0x0 },
-	{ 0x11669, 0x0 },
-	{ 0x11769, 0x0 },
-	{ 0x11869, 0x0 },
-	{ 0x12069, 0x0 },
-	{ 0x12169, 0x0 },
-	{ 0x12269, 0x0 },
-	{ 0x12369, 0x0 },
-	{ 0x12469, 0x0 },
-	{ 0x12569, 0x0 },
-	{ 0x12669, 0x0 },
-	{ 0x12769, 0x0 },
-	{ 0x12869, 0x0 },
-	{ 0x13069, 0x0 },
-	{ 0x13169, 0x0 },
-	{ 0x13269, 0x0 },
-	{ 0x13369, 0x0 },
-	{ 0x13469, 0x0 },
-	{ 0x13569, 0x0 },
-	{ 0x13669, 0x0 },
-	{ 0x13769, 0x0 },
-	{ 0x13869, 0x0 },
-	{ 0x1008c, 0x0 },
-	{ 0x11008c, 0x0 },
-	{ 0x21008c, 0x0 },
-	{ 0x1018c, 0x0 },
-	{ 0x11018c, 0x0 },
-	{ 0x21018c, 0x0 },
-	{ 0x1108c, 0x0 },
-	{ 0x11108c, 0x0 },
-	{ 0x21108c, 0x0 },
-	{ 0x1118c, 0x0 },
-	{ 0x11118c, 0x0 },
-	{ 0x21118c, 0x0 },
-	{ 0x1208c, 0x0 },
-	{ 0x11208c, 0x0 },
-	{ 0x21208c, 0x0 },
-	{ 0x1218c, 0x0 },
-	{ 0x11218c, 0x0 },
-	{ 0x21218c, 0x0 },
-	{ 0x1308c, 0x0 },
-	{ 0x11308c, 0x0 },
-	{ 0x21308c, 0x0 },
-	{ 0x1318c, 0x0 },
-	{ 0x11318c, 0x0 },
-	{ 0x21318c, 0x0 },
-	{ 0x1008d, 0x0 },
-	{ 0x11008d, 0x0 },
-	{ 0x21008d, 0x0 },
-	{ 0x1018d, 0x0 },
-	{ 0x11018d, 0x0 },
-	{ 0x21018d, 0x0 },
-	{ 0x1108d, 0x0 },
-	{ 0x11108d, 0x0 },
-	{ 0x21108d, 0x0 },
-	{ 0x1118d, 0x0 },
-	{ 0x11118d, 0x0 },
-	{ 0x21118d, 0x0 },
-	{ 0x1208d, 0x0 },
-	{ 0x11208d, 0x0 },
-	{ 0x21208d, 0x0 },
-	{ 0x1218d, 0x0 },
-	{ 0x11218d, 0x0 },
-	{ 0x21218d, 0x0 },
-	{ 0x1308d, 0x0 },
-	{ 0x11308d, 0x0 },
-	{ 0x21308d, 0x0 },
-	{ 0x1318d, 0x0 },
-	{ 0x11318d, 0x0 },
-	{ 0x21318d, 0x0 },
-	{ 0x100c0, 0x0 },
-	{ 0x1100c0, 0x0 },
-	{ 0x2100c0, 0x0 },
-	{ 0x101c0, 0x0 },
-	{ 0x1101c0, 0x0 },
-	{ 0x2101c0, 0x0 },
-	{ 0x102c0, 0x0 },
-	{ 0x1102c0, 0x0 },
-	{ 0x2102c0, 0x0 },
-	{ 0x103c0, 0x0 },
-	{ 0x1103c0, 0x0 },
-	{ 0x2103c0, 0x0 },
-	{ 0x104c0, 0x0 },
-	{ 0x1104c0, 0x0 },
-	{ 0x2104c0, 0x0 },
-	{ 0x105c0, 0x0 },
-	{ 0x1105c0, 0x0 },
-	{ 0x2105c0, 0x0 },
-	{ 0x106c0, 0x0 },
-	{ 0x1106c0, 0x0 },
-	{ 0x2106c0, 0x0 },
-	{ 0x107c0, 0x0 },
-	{ 0x1107c0, 0x0 },
-	{ 0x2107c0, 0x0 },
-	{ 0x108c0, 0x0 },
-	{ 0x1108c0, 0x0 },
-	{ 0x2108c0, 0x0 },
-	{ 0x110c0, 0x0 },
-	{ 0x1110c0, 0x0 },
-	{ 0x2110c0, 0x0 },
-	{ 0x111c0, 0x0 },
-	{ 0x1111c0, 0x0 },
-	{ 0x2111c0, 0x0 },
-	{ 0x112c0, 0x0 },
-	{ 0x1112c0, 0x0 },
-	{ 0x2112c0, 0x0 },
-	{ 0x113c0, 0x0 },
-	{ 0x1113c0, 0x0 },
-	{ 0x2113c0, 0x0 },
-	{ 0x114c0, 0x0 },
-	{ 0x1114c0, 0x0 },
-	{ 0x2114c0, 0x0 },
-	{ 0x115c0, 0x0 },
-	{ 0x1115c0, 0x0 },
-	{ 0x2115c0, 0x0 },
-	{ 0x116c0, 0x0 },
-	{ 0x1116c0, 0x0 },
-	{ 0x2116c0, 0x0 },
-	{ 0x117c0, 0x0 },
-	{ 0x1117c0, 0x0 },
-	{ 0x2117c0, 0x0 },
-	{ 0x118c0, 0x0 },
-	{ 0x1118c0, 0x0 },
-	{ 0x2118c0, 0x0 },
-	{ 0x120c0, 0x0 },
-	{ 0x1120c0, 0x0 },
-	{ 0x2120c0, 0x0 },
-	{ 0x121c0, 0x0 },
-	{ 0x1121c0, 0x0 },
-	{ 0x2121c0, 0x0 },
-	{ 0x122c0, 0x0 },
-	{ 0x1122c0, 0x0 },
-	{ 0x2122c0, 0x0 },
-	{ 0x123c0, 0x0 },
-	{ 0x1123c0, 0x0 },
-	{ 0x2123c0, 0x0 },
-	{ 0x124c0, 0x0 },
-	{ 0x1124c0, 0x0 },
-	{ 0x2124c0, 0x0 },
-	{ 0x125c0, 0x0 },
-	{ 0x1125c0, 0x0 },
-	{ 0x2125c0, 0x0 },
-	{ 0x126c0, 0x0 },
-	{ 0x1126c0, 0x0 },
-	{ 0x2126c0, 0x0 },
-	{ 0x127c0, 0x0 },
-	{ 0x1127c0, 0x0 },
-	{ 0x2127c0, 0x0 },
-	{ 0x128c0, 0x0 },
-	{ 0x1128c0, 0x0 },
-	{ 0x2128c0, 0x0 },
-	{ 0x130c0, 0x0 },
-	{ 0x1130c0, 0x0 },
-	{ 0x2130c0, 0x0 },
-	{ 0x131c0, 0x0 },
-	{ 0x1131c0, 0x0 },
-	{ 0x2131c0, 0x0 },
-	{ 0x132c0, 0x0 },
-	{ 0x1132c0, 0x0 },
-	{ 0x2132c0, 0x0 },
-	{ 0x133c0, 0x0 },
-	{ 0x1133c0, 0x0 },
-	{ 0x2133c0, 0x0 },
-	{ 0x134c0, 0x0 },
-	{ 0x1134c0, 0x0 },
-	{ 0x2134c0, 0x0 },
-	{ 0x135c0, 0x0 },
-	{ 0x1135c0, 0x0 },
-	{ 0x2135c0, 0x0 },
-	{ 0x136c0, 0x0 },
-	{ 0x1136c0, 0x0 },
-	{ 0x2136c0, 0x0 },
-	{ 0x137c0, 0x0 },
-	{ 0x1137c0, 0x0 },
-	{ 0x2137c0, 0x0 },
-	{ 0x138c0, 0x0 },
-	{ 0x1138c0, 0x0 },
-	{ 0x2138c0, 0x0 },
-	{ 0x100c1, 0x0 },
-	{ 0x1100c1, 0x0 },
-	{ 0x2100c1, 0x0 },
-	{ 0x101c1, 0x0 },
-	{ 0x1101c1, 0x0 },
-	{ 0x2101c1, 0x0 },
-	{ 0x102c1, 0x0 },
-	{ 0x1102c1, 0x0 },
-	{ 0x2102c1, 0x0 },
-	{ 0x103c1, 0x0 },
-	{ 0x1103c1, 0x0 },
-	{ 0x2103c1, 0x0 },
-	{ 0x104c1, 0x0 },
-	{ 0x1104c1, 0x0 },
-	{ 0x2104c1, 0x0 },
-	{ 0x105c1, 0x0 },
-	{ 0x1105c1, 0x0 },
-	{ 0x2105c1, 0x0 },
-	{ 0x106c1, 0x0 },
-	{ 0x1106c1, 0x0 },
-	{ 0x2106c1, 0x0 },
-	{ 0x107c1, 0x0 },
-	{ 0x1107c1, 0x0 },
-	{ 0x2107c1, 0x0 },
-	{ 0x108c1, 0x0 },
-	{ 0x1108c1, 0x0 },
-	{ 0x2108c1, 0x0 },
-	{ 0x110c1, 0x0 },
-	{ 0x1110c1, 0x0 },
-	{ 0x2110c1, 0x0 },
-	{ 0x111c1, 0x0 },
-	{ 0x1111c1, 0x0 },
-	{ 0x2111c1, 0x0 },
-	{ 0x112c1, 0x0 },
-	{ 0x1112c1, 0x0 },
-	{ 0x2112c1, 0x0 },
-	{ 0x113c1, 0x0 },
-	{ 0x1113c1, 0x0 },
-	{ 0x2113c1, 0x0 },
-	{ 0x114c1, 0x0 },
-	{ 0x1114c1, 0x0 },
-	{ 0x2114c1, 0x0 },
-	{ 0x115c1, 0x0 },
-	{ 0x1115c1, 0x0 },
-	{ 0x2115c1, 0x0 },
-	{ 0x116c1, 0x0 },
-	{ 0x1116c1, 0x0 },
-	{ 0x2116c1, 0x0 },
-	{ 0x117c1, 0x0 },
-	{ 0x1117c1, 0x0 },
-	{ 0x2117c1, 0x0 },
-	{ 0x118c1, 0x0 },
-	{ 0x1118c1, 0x0 },
-	{ 0x2118c1, 0x0 },
-	{ 0x120c1, 0x0 },
-	{ 0x1120c1, 0x0 },
-	{ 0x2120c1, 0x0 },
-	{ 0x121c1, 0x0 },
-	{ 0x1121c1, 0x0 },
-	{ 0x2121c1, 0x0 },
-	{ 0x122c1, 0x0 },
-	{ 0x1122c1, 0x0 },
-	{ 0x2122c1, 0x0 },
-	{ 0x123c1, 0x0 },
-	{ 0x1123c1, 0x0 },
-	{ 0x2123c1, 0x0 },
-	{ 0x124c1, 0x0 },
-	{ 0x1124c1, 0x0 },
-	{ 0x2124c1, 0x0 },
-	{ 0x125c1, 0x0 },
-	{ 0x1125c1, 0x0 },
-	{ 0x2125c1, 0x0 },
-	{ 0x126c1, 0x0 },
-	{ 0x1126c1, 0x0 },
-	{ 0x2126c1, 0x0 },
-	{ 0x127c1, 0x0 },
-	{ 0x1127c1, 0x0 },
-	{ 0x2127c1, 0x0 },
-	{ 0x128c1, 0x0 },
-	{ 0x1128c1, 0x0 },
-	{ 0x2128c1, 0x0 },
-	{ 0x130c1, 0x0 },
-	{ 0x1130c1, 0x0 },
-	{ 0x2130c1, 0x0 },
-	{ 0x131c1, 0x0 },
-	{ 0x1131c1, 0x0 },
-	{ 0x2131c1, 0x0 },
-	{ 0x132c1, 0x0 },
-	{ 0x1132c1, 0x0 },
-	{ 0x2132c1, 0x0 },
-	{ 0x133c1, 0x0 },
-	{ 0x1133c1, 0x0 },
-	{ 0x2133c1, 0x0 },
-	{ 0x134c1, 0x0 },
-	{ 0x1134c1, 0x0 },
-	{ 0x2134c1, 0x0 },
-	{ 0x135c1, 0x0 },
-	{ 0x1135c1, 0x0 },
-	{ 0x2135c1, 0x0 },
-	{ 0x136c1, 0x0 },
-	{ 0x1136c1, 0x0 },
-	{ 0x2136c1, 0x0 },
-	{ 0x137c1, 0x0 },
-	{ 0x1137c1, 0x0 },
-	{ 0x2137c1, 0x0 },
-	{ 0x138c1, 0x0 },
-	{ 0x1138c1, 0x0 },
-	{ 0x2138c1, 0x0 },
-	{ 0x10020, 0x0 },
-	{ 0x110020, 0x0 },
-	{ 0x210020, 0x0 },
-	{ 0x11020, 0x0 },
-	{ 0x111020, 0x0 },
-	{ 0x211020, 0x0 },
-	{ 0x12020, 0x0 },
-	{ 0x112020, 0x0 },
-	{ 0x212020, 0x0 },
-	{ 0x13020, 0x0 },
-	{ 0x113020, 0x0 },
-	{ 0x213020, 0x0 },
-	{ 0x20072, 0x0 },
-	{ 0x20073, 0x0 },
-	{ 0x20074, 0x0 },
-	{ 0x100aa, 0x0 },
-	{ 0x110aa, 0x0 },
-	{ 0x120aa, 0x0 },
-	{ 0x130aa, 0x0 },
-	{ 0x20010, 0x0 },
-	{ 0x120010, 0x0 },
-	{ 0x220010, 0x0 },
-	{ 0x20011, 0x0 },
-	{ 0x120011, 0x0 },
-	{ 0x220011, 0x0 },
-	{ 0x100ae, 0x0 },
-	{ 0x1100ae, 0x0 },
-	{ 0x2100ae, 0x0 },
-	{ 0x100af, 0x0 },
-	{ 0x1100af, 0x0 },
-	{ 0x2100af, 0x0 },
-	{ 0x110ae, 0x0 },
-	{ 0x1110ae, 0x0 },
-	{ 0x2110ae, 0x0 },
-	{ 0x110af, 0x0 },
-	{ 0x1110af, 0x0 },
-	{ 0x2110af, 0x0 },
-	{ 0x120ae, 0x0 },
-	{ 0x1120ae, 0x0 },
-	{ 0x2120ae, 0x0 },
-	{ 0x120af, 0x0 },
-	{ 0x1120af, 0x0 },
-	{ 0x2120af, 0x0 },
-	{ 0x130ae, 0x0 },
-	{ 0x1130ae, 0x0 },
-	{ 0x2130ae, 0x0 },
-	{ 0x130af, 0x0 },
-	{ 0x1130af, 0x0 },
-	{ 0x2130af, 0x0 },
-	{ 0x20020, 0x0 },
-	{ 0x120020, 0x0 },
-	{ 0x220020, 0x0 },
-	{ 0x100a0, 0x0 },
-	{ 0x100a1, 0x0 },
-	{ 0x100a2, 0x0 },
-	{ 0x100a3, 0x0 },
-	{ 0x100a4, 0x0 },
-	{ 0x100a5, 0x0 },
-	{ 0x100a6, 0x0 },
-	{ 0x100a7, 0x0 },
-	{ 0x110a0, 0x0 },
-	{ 0x110a1, 0x0 },
-	{ 0x110a2, 0x0 },
-	{ 0x110a3, 0x0 },
-	{ 0x110a4, 0x0 },
-	{ 0x110a5, 0x0 },
-	{ 0x110a6, 0x0 },
-	{ 0x110a7, 0x0 },
-	{ 0x120a0, 0x0 },
-	{ 0x120a1, 0x0 },
-	{ 0x120a2, 0x0 },
-	{ 0x120a3, 0x0 },
-	{ 0x120a4, 0x0 },
-	{ 0x120a5, 0x0 },
-	{ 0x120a6, 0x0 },
-	{ 0x120a7, 0x0 },
-	{ 0x130a0, 0x0 },
-	{ 0x130a1, 0x0 },
-	{ 0x130a2, 0x0 },
-	{ 0x130a3, 0x0 },
-	{ 0x130a4, 0x0 },
-	{ 0x130a5, 0x0 },
-	{ 0x130a6, 0x0 },
-	{ 0x130a7, 0x0 },
-	{ 0x2007c, 0x0 },
-	{ 0x12007c, 0x0 },
-	{ 0x22007c, 0x0 },
-	{ 0x2007d, 0x0 },
-	{ 0x12007d, 0x0 },
-	{ 0x22007d, 0x0 },
-	{ 0x400fd, 0x0 },
-	{ 0x400c0, 0x0 },
-	{ 0x90201, 0x0 },
-	{ 0x190201, 0x0 },
-	{ 0x290201, 0x0 },
-	{ 0x90202, 0x0 },
-	{ 0x190202, 0x0 },
-	{ 0x290202, 0x0 },
-	{ 0x90203, 0x0 },
-	{ 0x190203, 0x0 },
-	{ 0x290203, 0x0 },
-	{ 0x90204, 0x0 },
-	{ 0x190204, 0x0 },
-	{ 0x290204, 0x0 },
-	{ 0x90205, 0x0 },
-	{ 0x190205, 0x0 },
-	{ 0x290205, 0x0 },
-	{ 0x90206, 0x0 },
-	{ 0x190206, 0x0 },
-	{ 0x290206, 0x0 },
-	{ 0x90207, 0x0 },
-	{ 0x190207, 0x0 },
-	{ 0x290207, 0x0 },
-	{ 0x90208, 0x0 },
-	{ 0x190208, 0x0 },
-	{ 0x290208, 0x0 },
-	{ 0x10062, 0x0 },
-	{ 0x10162, 0x0 },
-	{ 0x10262, 0x0 },
-	{ 0x10362, 0x0 },
-	{ 0x10462, 0x0 },
-	{ 0x10562, 0x0 },
-	{ 0x10662, 0x0 },
-	{ 0x10762, 0x0 },
-	{ 0x10862, 0x0 },
-	{ 0x11062, 0x0 },
-	{ 0x11162, 0x0 },
-	{ 0x11262, 0x0 },
-	{ 0x11362, 0x0 },
-	{ 0x11462, 0x0 },
-	{ 0x11562, 0x0 },
-	{ 0x11662, 0x0 },
-	{ 0x11762, 0x0 },
-	{ 0x11862, 0x0 },
-	{ 0x12062, 0x0 },
-	{ 0x12162, 0x0 },
-	{ 0x12262, 0x0 },
-	{ 0x12362, 0x0 },
-	{ 0x12462, 0x0 },
-	{ 0x12562, 0x0 },
-	{ 0x12662, 0x0 },
-	{ 0x12762, 0x0 },
-	{ 0x12862, 0x0 },
-	{ 0x13062, 0x0 },
-	{ 0x13162, 0x0 },
-	{ 0x13262, 0x0 },
-	{ 0x13362, 0x0 },
-	{ 0x13462, 0x0 },
-	{ 0x13562, 0x0 },
-	{ 0x13662, 0x0 },
-	{ 0x13762, 0x0 },
-	{ 0x13862, 0x0 },
-	{ 0x20077, 0x0 },
-	{ 0x10001, 0x0 },
-	{ 0x11001, 0x0 },
-	{ 0x12001, 0x0 },
-	{ 0x13001, 0x0 },
-	{ 0x10040, 0x0 },
-	{ 0x10140, 0x0 },
-	{ 0x10240, 0x0 },
-	{ 0x10340, 0x0 },
-	{ 0x10440, 0x0 },
-	{ 0x10540, 0x0 },
-	{ 0x10640, 0x0 },
-	{ 0x10740, 0x0 },
-	{ 0x10840, 0x0 },
-	{ 0x10030, 0x0 },
-	{ 0x10130, 0x0 },
-	{ 0x10230, 0x0 },
-	{ 0x10330, 0x0 },
-	{ 0x10430, 0x0 },
-	{ 0x10530, 0x0 },
-	{ 0x10630, 0x0 },
-	{ 0x10730, 0x0 },
-	{ 0x10830, 0x0 },
-	{ 0x11040, 0x0 },
-	{ 0x11140, 0x0 },
-	{ 0x11240, 0x0 },
-	{ 0x11340, 0x0 },
-	{ 0x11440, 0x0 },
-	{ 0x11540, 0x0 },
-	{ 0x11640, 0x0 },
-	{ 0x11740, 0x0 },
-	{ 0x11840, 0x0 },
-	{ 0x11030, 0x0 },
-	{ 0x11130, 0x0 },
-	{ 0x11230, 0x0 },
-	{ 0x11330, 0x0 },
-	{ 0x11430, 0x0 },
-	{ 0x11530, 0x0 },
-	{ 0x11630, 0x0 },
-	{ 0x11730, 0x0 },
-	{ 0x11830, 0x0 },
-	{ 0x12040, 0x0 },
-	{ 0x12140, 0x0 },
-	{ 0x12240, 0x0 },
-	{ 0x12340, 0x0 },
-	{ 0x12440, 0x0 },
-	{ 0x12540, 0x0 },
-	{ 0x12640, 0x0 },
-	{ 0x12740, 0x0 },
-	{ 0x12840, 0x0 },
-	{ 0x12030, 0x0 },
-	{ 0x12130, 0x0 },
-	{ 0x12230, 0x0 },
-	{ 0x12330, 0x0 },
-	{ 0x12430, 0x0 },
-	{ 0x12530, 0x0 },
-	{ 0x12630, 0x0 },
-	{ 0x12730, 0x0 },
-	{ 0x12830, 0x0 },
-	{ 0x13040, 0x0 },
-	{ 0x13140, 0x0 },
-	{ 0x13240, 0x0 },
-	{ 0x13340, 0x0 },
-	{ 0x13440, 0x0 },
-	{ 0x13540, 0x0 },
-	{ 0x13640, 0x0 },
-	{ 0x13740, 0x0 },
-	{ 0x13840, 0x0 },
-	{ 0x13030, 0x0 },
-	{ 0x13130, 0x0 },
-	{ 0x13230, 0x0 },
-	{ 0x13330, 0x0 },
-	{ 0x13430, 0x0 },
-	{ 0x13530, 0x0 },
-	{ 0x13630, 0x0 },
-	{ 0x13730, 0x0 },
-	{ 0x13830, 0x0 },
-};
-
-/* P0 message block paremeter for training firmware */
-struct dram_cfg_param ddr_fsp0_cfg[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x54003, 0xfa0 },
-	{ 0x54004, 0x2 },
-	{ 0x54005, 0x2228 },
-	{ 0x54006, 0x14 },
-	{ 0x54008, 0x131f },
-	{ 0x54009, 0xc8 },
-	{ 0x5400b, 0x2 },
-	{ 0x5400f, 0x100 },
-	{ 0x54012, 0x310 },
-	{ 0x54019, 0x3ff4 },
-	{ 0x5401a, 0x33 },
-	{ 0x5401b, 0x4866 },
-	{ 0x5401c, 0x4800 },
-	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x3ff4 },
-	{ 0x54020, 0x33 },
-	{ 0x54021, 0x4866 },
-	{ 0x54022, 0x4800 },
-	{ 0x54024, 0x16 },
-	{ 0x5402b, 0x1000 },
-	{ 0x5402c, 0x3 },
-	{ 0x54032, 0xf400 },
-	{ 0x54033, 0x333f },
-	{ 0x54034, 0x6600 },
-	{ 0x54035, 0x48 },
-	{ 0x54036, 0x48 },
-	{ 0x54037, 0x1600 },
-	{ 0x54038, 0xf400 },
-	{ 0x54039, 0x333f },
-	{ 0x5403a, 0x6600 },
-	{ 0x5403b, 0x48 },
-	{ 0x5403c, 0x48 },
-	{ 0x5403d, 0x1600 },
-	{ 0xd0000, 0x1 },
-};
-
-/* P1 message block paremeter for training firmware */
-struct dram_cfg_param ddr_fsp1_cfg[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x54002, 0x101 },
-	{ 0x54003, 0x190 },
-	{ 0x54004, 0x2 },
-	{ 0x54005, 0x2228 },
-	{ 0x54006, 0x14 },
-	{ 0x54008, 0x121f },
-	{ 0x54009, 0xc8 },
-	{ 0x5400b, 0x2 },
-	{ 0x5400f, 0x100 },
-	{ 0x54012, 0x310 },
-	{ 0x54019, 0x84 },
-	{ 0x5401a, 0x33 },
-	{ 0x5401b, 0x4866 },
-	{ 0x5401c, 0x4800 },
-	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x84 },
-	{ 0x54020, 0x33 },
-	{ 0x54021, 0x4866 },
-	{ 0x54022, 0x4800 },
-	{ 0x54024, 0x16 },
-	{ 0x5402b, 0x1000 },
-	{ 0x5402c, 0x3 },
-	{ 0x54032, 0x8400 },
-	{ 0x54033, 0x3300 },
-	{ 0x54034, 0x6600 },
-	{ 0x54035, 0x48 },
-	{ 0x54036, 0x48 },
-	{ 0x54037, 0x1600 },
-	{ 0x54038, 0x8400 },
-	{ 0x54039, 0x3300 },
-	{ 0x5403a, 0x6600 },
-	{ 0x5403b, 0x48 },
-	{ 0x5403c, 0x48 },
-	{ 0x5403d, 0x1600 },
-	{ 0xd0000, 0x1 },
-};
-
-/* P2 message block paremeter for training firmware */
-struct dram_cfg_param ddr_fsp2_cfg[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x54002, 0x102 },
-	{ 0x54003, 0x64 },
-	{ 0x54004, 0x2 },
-	{ 0x54005, 0x2228 },
-	{ 0x54006, 0x14 },
-	{ 0x54008, 0x121f },
-	{ 0x54009, 0xc8 },
-	{ 0x5400b, 0x2 },
-	{ 0x5400f, 0x100 },
-	{ 0x54012, 0x310 },
-	{ 0x54019, 0x84 },
-	{ 0x5401a, 0x33 },
-	{ 0x5401b, 0x4866 },
-	{ 0x5401c, 0x4800 },
-	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x84 },
-	{ 0x54020, 0x33 },
-	{ 0x54021, 0x4866 },
-	{ 0x54022, 0x4800 },
-	{ 0x54024, 0x16 },
-	{ 0x5402b, 0x1000 },
-	{ 0x5402c, 0x3 },
-	{ 0x54032, 0x8400 },
-	{ 0x54033, 0x3300 },
-	{ 0x54034, 0x6600 },
-	{ 0x54035, 0x48 },
-	{ 0x54036, 0x48 },
-	{ 0x54037, 0x1600 },
-	{ 0x54038, 0x8400 },
-	{ 0x54039, 0x3300 },
-	{ 0x5403a, 0x6600 },
-	{ 0x5403b, 0x48 },
-	{ 0x5403c, 0x48 },
-	{ 0x5403d, 0x1600 },
-	{ 0xd0000, 0x1 },
-};
-
-/* P0 2D message block paremeter for training firmware */
-struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x54003, 0xfa0 },
-	{ 0x54004, 0x2 },
-	{ 0x54005, 0x2228 },
-	{ 0x54006, 0x14 },
-	{ 0x54008, 0x61 },
-	{ 0x54009, 0xc8 },
-	{ 0x5400b, 0x2 },
-	{ 0x5400f, 0x100 },
-	{ 0x54010, 0x1f7f },
-	{ 0x54012, 0x310 },
-	{ 0x54019, 0x3ff4 },
-	{ 0x5401a, 0x33 },
-	{ 0x5401b, 0x4866 },
-	{ 0x5401c, 0x4800 },
-	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x3ff4 },
-	{ 0x54020, 0x33 },
-	{ 0x54021, 0x4866 },
-	{ 0x54022, 0x4800 },
-	{ 0x54024, 0x16 },
-	{ 0x5402b, 0x1000 },
-	{ 0x5402c, 0x3 },
-	{ 0x54032, 0xf400 },
-	{ 0x54033, 0x333f },
-	{ 0x54034, 0x6600 },
-	{ 0x54035, 0x48 },
-	{ 0x54036, 0x48 },
-	{ 0x54037, 0x1600 },
-	{ 0x54038, 0xf400 },
-	{ 0x54039, 0x333f },
-	{ 0x5403a, 0x6600 },
-	{ 0x5403b, 0x48 },
-	{ 0x5403c, 0x48 },
-	{ 0x5403d, 0x1600 },
-	{ 0xd0000, 0x1 },
-};
-
-/* DRAM PHY init engine image */
-struct dram_cfg_param ddr_phy_pie[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x90000, 0x10 },
-	{ 0x90001, 0x400 },
-	{ 0x90002, 0x10e },
-	{ 0x90003, 0x0 },
-	{ 0x90004, 0x0 },
-	{ 0x90005, 0x8 },
-	{ 0x90029, 0xb },
-	{ 0x9002a, 0x480 },
-	{ 0x9002b, 0x109 },
-	{ 0x9002c, 0x8 },
-	{ 0x9002d, 0x448 },
-	{ 0x9002e, 0x139 },
-	{ 0x9002f, 0x8 },
-	{ 0x90030, 0x478 },
-	{ 0x90031, 0x109 },
-	{ 0x90032, 0x0 },
-	{ 0x90033, 0xe8 },
-	{ 0x90034, 0x109 },
-	{ 0x90035, 0x2 },
-	{ 0x90036, 0x10 },
-	{ 0x90037, 0x139 },
-	{ 0x90038, 0xb },
-	{ 0x90039, 0x7c0 },
-	{ 0x9003a, 0x139 },
-	{ 0x9003b, 0x44 },
-	{ 0x9003c, 0x633 },
-	{ 0x9003d, 0x159 },
-	{ 0x9003e, 0x14f },
-	{ 0x9003f, 0x630 },
-	{ 0x90040, 0x159 },
-	{ 0x90041, 0x47 },
-	{ 0x90042, 0x633 },
-	{ 0x90043, 0x149 },
-	{ 0x90044, 0x4f },
-	{ 0x90045, 0x633 },
-	{ 0x90046, 0x179 },
-	{ 0x90047, 0x8 },
-	{ 0x90048, 0xe0 },
-	{ 0x90049, 0x109 },
-	{ 0x9004a, 0x0 },
-	{ 0x9004b, 0x7c8 },
-	{ 0x9004c, 0x109 },
-	{ 0x9004d, 0x0 },
-	{ 0x9004e, 0x1 },
-	{ 0x9004f, 0x8 },
-	{ 0x90050, 0x0 },
-	{ 0x90051, 0x45a },
-	{ 0x90052, 0x9 },
-	{ 0x90053, 0x0 },
-	{ 0x90054, 0x448 },
-	{ 0x90055, 0x109 },
-	{ 0x90056, 0x40 },
-	{ 0x90057, 0x633 },
-	{ 0x90058, 0x179 },
-	{ 0x90059, 0x1 },
-	{ 0x9005a, 0x618 },
-	{ 0x9005b, 0x109 },
-	{ 0x9005c, 0x40c0 },
-	{ 0x9005d, 0x633 },
-	{ 0x9005e, 0x149 },
-	{ 0x9005f, 0x8 },
-	{ 0x90060, 0x4 },
-	{ 0x90061, 0x48 },
-	{ 0x90062, 0x4040 },
-	{ 0x90063, 0x633 },
-	{ 0x90064, 0x149 },
-	{ 0x90065, 0x0 },
-	{ 0x90066, 0x4 },
-	{ 0x90067, 0x48 },
-	{ 0x90068, 0x40 },
-	{ 0x90069, 0x633 },
-	{ 0x9006a, 0x149 },
-	{ 0x9006b, 0x10 },
-	{ 0x9006c, 0x4 },
-	{ 0x9006d, 0x18 },
-	{ 0x9006e, 0x0 },
-	{ 0x9006f, 0x4 },
-	{ 0x90070, 0x78 },
-	{ 0x90071, 0x549 },
-	{ 0x90072, 0x633 },
-	{ 0x90073, 0x159 },
-	{ 0x90074, 0xd49 },
-	{ 0x90075, 0x633 },
-	{ 0x90076, 0x159 },
-	{ 0x90077, 0x94a },
-	{ 0x90078, 0x633 },
-	{ 0x90079, 0x159 },
-	{ 0x9007a, 0x441 },
-	{ 0x9007b, 0x633 },
-	{ 0x9007c, 0x149 },
-	{ 0x9007d, 0x42 },
-	{ 0x9007e, 0x633 },
-	{ 0x9007f, 0x149 },
-	{ 0x90080, 0x1 },
-	{ 0x90081, 0x633 },
-	{ 0x90082, 0x149 },
-	{ 0x90083, 0x0 },
-	{ 0x90084, 0xe0 },
-	{ 0x90085, 0x109 },
-	{ 0x90086, 0xa },
-	{ 0x90087, 0x10 },
-	{ 0x90088, 0x109 },
-	{ 0x90089, 0x9 },
-	{ 0x9008a, 0x3c0 },
-	{ 0x9008b, 0x149 },
-	{ 0x9008c, 0x9 },
-	{ 0x9008d, 0x3c0 },
-	{ 0x9008e, 0x159 },
-	{ 0x9008f, 0x18 },
-	{ 0x90090, 0x10 },
-	{ 0x90091, 0x109 },
-	{ 0x90092, 0x0 },
-	{ 0x90093, 0x3c0 },
-	{ 0x90094, 0x109 },
-	{ 0x90095, 0x18 },
-	{ 0x90096, 0x4 },
-	{ 0x90097, 0x48 },
-	{ 0x90098, 0x18 },
-	{ 0x90099, 0x4 },
-	{ 0x9009a, 0x58 },
-	{ 0x9009b, 0xb },
-	{ 0x9009c, 0x10 },
-	{ 0x9009d, 0x109 },
-	{ 0x9009e, 0x1 },
-	{ 0x9009f, 0x10 },
-	{ 0x900a0, 0x109 },
-	{ 0x900a1, 0x5 },
-	{ 0x900a2, 0x7c0 },
-	{ 0x900a3, 0x109 },
-	{ 0x40000, 0x811 },
-	{ 0x40020, 0x880 },
-	{ 0x40040, 0x0 },
-	{ 0x40060, 0x0 },
-	{ 0x40001, 0x4008 },
-	{ 0x40021, 0x83 },
-	{ 0x40041, 0x4f },
-	{ 0x40061, 0x0 },
-	{ 0x40002, 0x4040 },
-	{ 0x40022, 0x83 },
-	{ 0x40042, 0x51 },
-	{ 0x40062, 0x0 },
-	{ 0x40003, 0x811 },
-	{ 0x40023, 0x880 },
-	{ 0x40043, 0x0 },
-	{ 0x40063, 0x0 },
-	{ 0x40004, 0x720 },
-	{ 0x40024, 0xf },
-	{ 0x40044, 0x1740 },
-	{ 0x40064, 0x0 },
-	{ 0x40005, 0x16 },
-	{ 0x40025, 0x83 },
-	{ 0x40045, 0x4b },
-	{ 0x40065, 0x0 },
-	{ 0x40006, 0x716 },
-	{ 0x40026, 0xf },
-	{ 0x40046, 0x2001 },
-	{ 0x40066, 0x0 },
-	{ 0x40007, 0x716 },
-	{ 0x40027, 0xf },
-	{ 0x40047, 0x2800 },
-	{ 0x40067, 0x0 },
-	{ 0x40008, 0x716 },
-	{ 0x40028, 0xf },
-	{ 0x40048, 0xf00 },
-	{ 0x40068, 0x0 },
-	{ 0x40009, 0x720 },
-	{ 0x40029, 0xf },
-	{ 0x40049, 0x1400 },
-	{ 0x40069, 0x0 },
-	{ 0x4000a, 0xe08 },
-	{ 0x4002a, 0xc15 },
-	{ 0x4004a, 0x0 },
-	{ 0x4006a, 0x0 },
-	{ 0x4000b, 0x625 },
-	{ 0x4002b, 0x15 },
-	{ 0x4004b, 0x0 },
-	{ 0x4006b, 0x0 },
-	{ 0x4000c, 0x4028 },
-	{ 0x4002c, 0x80 },
-	{ 0x4004c, 0x0 },
-	{ 0x4006c, 0x0 },
-	{ 0x4000d, 0xe08 },
-	{ 0x4002d, 0xc1a },
-	{ 0x4004d, 0x0 },
-	{ 0x4006d, 0x0 },
-	{ 0x4000e, 0x625 },
-	{ 0x4002e, 0x1a },
-	{ 0x4004e, 0x0 },
-	{ 0x4006e, 0x0 },
-	{ 0x4000f, 0x4040 },
-	{ 0x4002f, 0x80 },
-	{ 0x4004f, 0x0 },
-	{ 0x4006f, 0x0 },
-	{ 0x40010, 0x2604 },
-	{ 0x40030, 0x15 },
-	{ 0x40050, 0x0 },
-	{ 0x40070, 0x0 },
-	{ 0x40011, 0x708 },
-	{ 0x40031, 0x5 },
-	{ 0x40051, 0x0 },
-	{ 0x40071, 0x2002 },
-	{ 0x40012, 0x8 },
-	{ 0x40032, 0x80 },
-	{ 0x40052, 0x0 },
-	{ 0x40072, 0x0 },
-	{ 0x40013, 0x2604 },
-	{ 0x40033, 0x1a },
-	{ 0x40053, 0x0 },
-	{ 0x40073, 0x0 },
-	{ 0x40014, 0x708 },
-	{ 0x40034, 0xa },
-	{ 0x40054, 0x0 },
-	{ 0x40074, 0x2002 },
-	{ 0x40015, 0x4040 },
-	{ 0x40035, 0x80 },
-	{ 0x40055, 0x0 },
-	{ 0x40075, 0x0 },
-	{ 0x40016, 0x60a },
-	{ 0x40036, 0x15 },
-	{ 0x40056, 0x1200 },
-	{ 0x40076, 0x0 },
-	{ 0x40017, 0x61a },
-	{ 0x40037, 0x15 },
-	{ 0x40057, 0x1300 },
-	{ 0x40077, 0x0 },
-	{ 0x40018, 0x60a },
-	{ 0x40038, 0x1a },
-	{ 0x40058, 0x1200 },
-	{ 0x40078, 0x0 },
-	{ 0x40019, 0x642 },
-	{ 0x40039, 0x1a },
-	{ 0x40059, 0x1300 },
-	{ 0x40079, 0x0 },
-	{ 0x4001a, 0x4808 },
-	{ 0x4003a, 0x880 },
-	{ 0x4005a, 0x0 },
-	{ 0x4007a, 0x0 },
-	{ 0x900a4, 0x0 },
-	{ 0x900a5, 0x790 },
-	{ 0x900a6, 0x11a },
-	{ 0x900a7, 0x8 },
-	{ 0x900a8, 0x7aa },
-	{ 0x900a9, 0x2a },
-	{ 0x900aa, 0x10 },
-	{ 0x900ab, 0x7b2 },
-	{ 0x900ac, 0x2a },
-	{ 0x900ad, 0x0 },
-	{ 0x900ae, 0x7c8 },
-	{ 0x900af, 0x109 },
-	{ 0x900b0, 0x10 },
-	{ 0x900b1, 0x10 },
-	{ 0x900b2, 0x109 },
-	{ 0x900b3, 0x10 },
-	{ 0x900b4, 0x2a8 },
-	{ 0x900b5, 0x129 },
-	{ 0x900b6, 0x8 },
-	{ 0x900b7, 0x370 },
-	{ 0x900b8, 0x129 },
-	{ 0x900b9, 0xa },
-	{ 0x900ba, 0x3c8 },
-	{ 0x900bb, 0x1a9 },
-	{ 0x900bc, 0xc },
-	{ 0x900bd, 0x408 },
-	{ 0x900be, 0x199 },
-	{ 0x900bf, 0x14 },
-	{ 0x900c0, 0x790 },
-	{ 0x900c1, 0x11a },
-	{ 0x900c2, 0x8 },
-	{ 0x900c3, 0x4 },
-	{ 0x900c4, 0x18 },
-	{ 0x900c5, 0xe },
-	{ 0x900c6, 0x408 },
-	{ 0x900c7, 0x199 },
-	{ 0x900c8, 0x8 },
-	{ 0x900c9, 0x8568 },
-	{ 0x900ca, 0x108 },
-	{ 0x900cb, 0x18 },
-	{ 0x900cc, 0x790 },
-	{ 0x900cd, 0x16a },
-	{ 0x900ce, 0x8 },
-	{ 0x900cf, 0x1d8 },
-	{ 0x900d0, 0x169 },
-	{ 0x900d1, 0x10 },
-	{ 0x900d2, 0x8558 },
-	{ 0x900d3, 0x168 },
-	{ 0x900d4, 0x70 },
-	{ 0x900d5, 0x788 },
-	{ 0x900d6, 0x16a },
-	{ 0x900d7, 0x1ff8 },
-	{ 0x900d8, 0x85a8 },
-	{ 0x900d9, 0x1e8 },
-	{ 0x900da, 0x50 },
-	{ 0x900db, 0x798 },
-	{ 0x900dc, 0x16a },
-	{ 0x900dd, 0x60 },
-	{ 0x900de, 0x7a0 },
-	{ 0x900df, 0x16a },
-	{ 0x900e0, 0x8 },
-	{ 0x900e1, 0x8310 },
-	{ 0x900e2, 0x168 },
-	{ 0x900e3, 0x8 },
-	{ 0x900e4, 0xa310 },
-	{ 0x900e5, 0x168 },
-	{ 0x900e6, 0xa },
-	{ 0x900e7, 0x408 },
-	{ 0x900e8, 0x169 },
-	{ 0x900e9, 0x6e },
-	{ 0x900ea, 0x0 },
-	{ 0x900eb, 0x68 },
-	{ 0x900ec, 0x0 },
-	{ 0x900ed, 0x408 },
-	{ 0x900ee, 0x169 },
-	{ 0x900ef, 0x0 },
-	{ 0x900f0, 0x8310 },
-	{ 0x900f1, 0x168 },
-	{ 0x900f2, 0x0 },
-	{ 0x900f3, 0xa310 },
-	{ 0x900f4, 0x168 },
-	{ 0x900f5, 0x1ff8 },
-	{ 0x900f6, 0x85a8 },
-	{ 0x900f7, 0x1e8 },
-	{ 0x900f8, 0x68 },
-	{ 0x900f9, 0x798 },
-	{ 0x900fa, 0x16a },
-	{ 0x900fb, 0x78 },
-	{ 0x900fc, 0x7a0 },
-	{ 0x900fd, 0x16a },
-	{ 0x900fe, 0x68 },
-	{ 0x900ff, 0x790 },
-	{ 0x90100, 0x16a },
-	{ 0x90101, 0x8 },
-	{ 0x90102, 0x8b10 },
-	{ 0x90103, 0x168 },
-	{ 0x90104, 0x8 },
-	{ 0x90105, 0xab10 },
-	{ 0x90106, 0x168 },
-	{ 0x90107, 0xa },
-	{ 0x90108, 0x408 },
-	{ 0x90109, 0x169 },
-	{ 0x9010a, 0x58 },
-	{ 0x9010b, 0x0 },
-	{ 0x9010c, 0x68 },
-	{ 0x9010d, 0x0 },
-	{ 0x9010e, 0x408 },
-	{ 0x9010f, 0x169 },
-	{ 0x90110, 0x0 },
-	{ 0x90111, 0x8b10 },
-	{ 0x90112, 0x168 },
-	{ 0x90113, 0x1 },
-	{ 0x90114, 0xab10 },
-	{ 0x90115, 0x168 },
-	{ 0x90116, 0x0 },
-	{ 0x90117, 0x1d8 },
-	{ 0x90118, 0x169 },
-	{ 0x90119, 0x80 },
-	{ 0x9011a, 0x790 },
-	{ 0x9011b, 0x16a },
-	{ 0x9011c, 0x18 },
-	{ 0x9011d, 0x7aa },
-	{ 0x9011e, 0x6a },
-	{ 0x9011f, 0xa },
-	{ 0x90120, 0x0 },
-	{ 0x90121, 0x1e9 },
-	{ 0x90122, 0x8 },
-	{ 0x90123, 0x8080 },
-	{ 0x90124, 0x108 },
-	{ 0x90125, 0xf },
-	{ 0x90126, 0x408 },
-	{ 0x90127, 0x169 },
-	{ 0x90128, 0xc },
-	{ 0x90129, 0x0 },
-	{ 0x9012a, 0x68 },
-	{ 0x9012b, 0x9 },
-	{ 0x9012c, 0x0 },
-	{ 0x9012d, 0x1a9 },
-	{ 0x9012e, 0x0 },
-	{ 0x9012f, 0x408 },
-	{ 0x90130, 0x169 },
-	{ 0x90131, 0x0 },
-	{ 0x90132, 0x8080 },
-	{ 0x90133, 0x108 },
-	{ 0x90134, 0x8 },
-	{ 0x90135, 0x7aa },
-	{ 0x90136, 0x6a },
-	{ 0x90137, 0x0 },
-	{ 0x90138, 0x8568 },
-	{ 0x90139, 0x108 },
-	{ 0x9013a, 0xb7 },
-	{ 0x9013b, 0x790 },
-	{ 0x9013c, 0x16a },
-	{ 0x9013d, 0x1f },
-	{ 0x9013e, 0x0 },
-	{ 0x9013f, 0x68 },
-	{ 0x90140, 0x8 },
-	{ 0x90141, 0x8558 },
-	{ 0x90142, 0x168 },
-	{ 0x90143, 0xf },
-	{ 0x90144, 0x408 },
-	{ 0x90145, 0x169 },
-	{ 0x90146, 0xd },
-	{ 0x90147, 0x0 },
-	{ 0x90148, 0x68 },
-	{ 0x90149, 0x0 },
-	{ 0x9014a, 0x408 },
-	{ 0x9014b, 0x169 },
-	{ 0x9014c, 0x0 },
-	{ 0x9014d, 0x8558 },
-	{ 0x9014e, 0x168 },
-	{ 0x9014f, 0x8 },
-	{ 0x90150, 0x3c8 },
-	{ 0x90151, 0x1a9 },
-	{ 0x90152, 0x3 },
-	{ 0x90153, 0x370 },
-	{ 0x90154, 0x129 },
-	{ 0x90155, 0x20 },
-	{ 0x90156, 0x2aa },
-	{ 0x90157, 0x9 },
-	{ 0x90158, 0x8 },
-	{ 0x90159, 0xe8 },
-	{ 0x9015a, 0x109 },
-	{ 0x9015b, 0x0 },
-	{ 0x9015c, 0x8140 },
-	{ 0x9015d, 0x10c },
-	{ 0x9015e, 0x10 },
-	{ 0x9015f, 0x8138 },
-	{ 0x90160, 0x104 },
-	{ 0x90161, 0x8 },
-	{ 0x90162, 0x448 },
-	{ 0x90163, 0x109 },
-	{ 0x90164, 0xf },
-	{ 0x90165, 0x7c0 },
-	{ 0x90166, 0x109 },
-	{ 0x90167, 0x0 },
-	{ 0x90168, 0xe8 },
-	{ 0x90169, 0x109 },
-	{ 0x9016a, 0x47 },
-	{ 0x9016b, 0x630 },
-	{ 0x9016c, 0x109 },
-	{ 0x9016d, 0x8 },
-	{ 0x9016e, 0x618 },
-	{ 0x9016f, 0x109 },
-	{ 0x90170, 0x8 },
-	{ 0x90171, 0xe0 },
-	{ 0x90172, 0x109 },
-	{ 0x90173, 0x0 },
-	{ 0x90174, 0x7c8 },
-	{ 0x90175, 0x109 },
-	{ 0x90176, 0x8 },
-	{ 0x90177, 0x8140 },
-	{ 0x90178, 0x10c },
-	{ 0x90179, 0x0 },
-	{ 0x9017a, 0x478 },
-	{ 0x9017b, 0x109 },
-	{ 0x9017c, 0x0 },
-	{ 0x9017d, 0x1 },
-	{ 0x9017e, 0x8 },
-	{ 0x9017f, 0x8 },
-	{ 0x90180, 0x4 },
-	{ 0x90181, 0x0 },
-	{ 0x90006, 0x8 },
-	{ 0x90007, 0x7c8 },
-	{ 0x90008, 0x109 },
-	{ 0x90009, 0x0 },
-	{ 0x9000a, 0x400 },
-	{ 0x9000b, 0x106 },
-	{ 0xd00e7, 0x400 },
-	{ 0x90017, 0x0 },
-	{ 0x9001f, 0x29 },
-	{ 0x90026, 0x68 },
-	{ 0x400d0, 0x0 },
-	{ 0x400d1, 0x101 },
-	{ 0x400d2, 0x105 },
-	{ 0x400d3, 0x107 },
-	{ 0x400d4, 0x10f },
-	{ 0x400d5, 0x202 },
-	{ 0x400d6, 0x20a },
-	{ 0x400d7, 0x20b },
-	{ 0x2003a, 0x2 },
-	{ 0x200be, 0x3 },
-	{ 0x2000b, 0x465 },
-	{ 0x2000c, 0xfa },
-	{ 0x2000d, 0x9c4 },
-	{ 0x2000e, 0x2c },
-	{ 0x12000b, 0x70 },
-	{ 0x12000c, 0x19 },
-	{ 0x12000d, 0xfa },
-	{ 0x12000e, 0x10 },
-	{ 0x22000b, 0x1c },
-	{ 0x22000c, 0x6 },
-	{ 0x22000d, 0x3e },
-	{ 0x22000e, 0x10 },
-	{ 0x9000c, 0x0 },
-	{ 0x9000d, 0x173 },
-	{ 0x9000e, 0x60 },
-	{ 0x9000f, 0x6110 },
-	{ 0x90010, 0x2152 },
-	{ 0x90011, 0xdfbd },
-	{ 0x90012, 0x2060 },
-	{ 0x90013, 0x6152 },
-	{ 0x20010, 0x5a },
-	{ 0x20011, 0x3 },
-	{ 0x40080, 0xe0 },
-	{ 0x40081, 0x12 },
-	{ 0x40082, 0xe0 },
-	{ 0x40083, 0x12 },
-	{ 0x40084, 0xe0 },
-	{ 0x40085, 0x12 },
-	{ 0x140080, 0xe0 },
-	{ 0x140081, 0x12 },
-	{ 0x140082, 0xe0 },
-	{ 0x140083, 0x12 },
-	{ 0x140084, 0xe0 },
-	{ 0x140085, 0x12 },
-	{ 0x240080, 0xe0 },
-	{ 0x240081, 0x12 },
-	{ 0x240082, 0xe0 },
-	{ 0x240083, 0x12 },
-	{ 0x240084, 0xe0 },
-	{ 0x240085, 0x12 },
-	{ 0x400fd, 0xf },
-	{ 0x10011, 0x1 },
-	{ 0x10012, 0x1 },
-	{ 0x10013, 0x180 },
-	{ 0x10018, 0x1 },
-	{ 0x10002, 0x6209 },
-	{ 0x100b2, 0x1 },
-	{ 0x101b4, 0x1 },
-	{ 0x102b4, 0x1 },
-	{ 0x103b4, 0x1 },
-	{ 0x104b4, 0x1 },
-	{ 0x105b4, 0x1 },
-	{ 0x106b4, 0x1 },
-	{ 0x107b4, 0x1 },
-	{ 0x108b4, 0x1 },
-	{ 0x11011, 0x1 },
-	{ 0x11012, 0x1 },
-	{ 0x11013, 0x180 },
-	{ 0x11018, 0x1 },
-	{ 0x11002, 0x6209 },
-	{ 0x110b2, 0x1 },
-	{ 0x111b4, 0x1 },
-	{ 0x112b4, 0x1 },
-	{ 0x113b4, 0x1 },
-	{ 0x114b4, 0x1 },
-	{ 0x115b4, 0x1 },
-	{ 0x116b4, 0x1 },
-	{ 0x117b4, 0x1 },
-	{ 0x118b4, 0x1 },
-	{ 0x12011, 0x1 },
-	{ 0x12012, 0x1 },
-	{ 0x12013, 0x180 },
-	{ 0x12018, 0x1 },
-	{ 0x12002, 0x6209 },
-	{ 0x120b2, 0x1 },
-	{ 0x121b4, 0x1 },
-	{ 0x122b4, 0x1 },
-	{ 0x123b4, 0x1 },
-	{ 0x124b4, 0x1 },
-	{ 0x125b4, 0x1 },
-	{ 0x126b4, 0x1 },
-	{ 0x127b4, 0x1 },
-	{ 0x128b4, 0x1 },
-	{ 0x13011, 0x1 },
-	{ 0x13012, 0x1 },
-	{ 0x13013, 0x180 },
-	{ 0x13018, 0x1 },
-	{ 0x13002, 0x6209 },
-	{ 0x130b2, 0x1 },
-	{ 0x131b4, 0x1 },
-	{ 0x132b4, 0x1 },
-	{ 0x133b4, 0x1 },
-	{ 0x134b4, 0x1 },
-	{ 0x135b4, 0x1 },
-	{ 0x136b4, 0x1 },
-	{ 0x137b4, 0x1 },
-	{ 0x138b4, 0x1 },
-	{ 0x20089, 0x1 },
-	{ 0x20088, 0x19 },
-	{ 0xc0080, 0x2 },
-	{ 0xd0000, 0x1 }
-};
-
-struct dram_fsp_msg ddr_dram_fsp_msg[] = {
-	{
-		/* P0 4000mts 1D */
-		.drate = 4000,
-		.fw_type = FW_1D_IMAGE,
-		.fsp_cfg = ddr_fsp0_cfg,
-		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg),
-	},
-	{
-		/* P1 400mts 1D */
-		.drate = 400,
-		.fw_type = FW_1D_IMAGE,
-		.fsp_cfg = ddr_fsp1_cfg,
-		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp1_cfg),
-	},
-	{
-		/* P2 100mts 1D */
-		.drate = 100,
-		.fw_type = FW_1D_IMAGE,
-		.fsp_cfg = ddr_fsp2_cfg,
-		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp2_cfg),
-	},
-	{
-		/* P0 4000mts 2D */
-		.drate = 4000,
-		.fw_type = FW_2D_IMAGE,
-		.fsp_cfg = ddr_fsp0_2d_cfg,
-		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg),
-	},
-};
-
-/* ddr timing config params */
-struct dram_timing_info dram_timing = {
-	.ddrc_cfg = ddr_ddrc_cfg,
-	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg),
-	.ddrphy_cfg = ddr_ddrphy_cfg,
-	.ddrphy_cfg_num = ARRAY_SIZE(ddr_ddrphy_cfg),
-	.fsp_msg = ddr_dram_fsp_msg,
-	.fsp_msg_num = ARRAY_SIZE(ddr_dram_fsp_msg),
-	.ddrphy_trained_csr = ddr_ddrphy_trained_csr,
-	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
-	.ddrphy_pie = ddr_phy_pie,
-	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
-	.fsp_table = { 4000, 400, 100, },
-};
-
-#if IS_ENABLED(CONFIG_IMX8M_DRAM_INLINE_ECC)
-void board_dram_ecc_scrub(void)
-{
-	ddrc_inline_ecc_scrub(0x0, 0x3ffffff);
-	ddrc_inline_ecc_scrub(0x20000000, 0x23ffffff);
-	ddrc_inline_ecc_scrub(0x40000000, 0x43ffffff);
-	ddrc_inline_ecc_scrub(0x4000000, 0x7ffffff);
-	ddrc_inline_ecc_scrub(0x24000000, 0x27ffffff);
-	ddrc_inline_ecc_scrub(0x44000000, 0x47ffffff);
-	ddrc_inline_ecc_scrub(0x8000000, 0xbffffff);
-	ddrc_inline_ecc_scrub(0x28000000, 0x2bffffff);
-	ddrc_inline_ecc_scrub(0x48000000, 0x4bffffff);
-	ddrc_inline_ecc_scrub(0xc000000, 0xfffffff);
-	ddrc_inline_ecc_scrub(0x2c000000, 0x2fffffff);
-	ddrc_inline_ecc_scrub(0x4c000000, 0x4fffffff);
-	ddrc_inline_ecc_scrub(0x10000000, 0x13ffffff);
-	ddrc_inline_ecc_scrub(0x30000000, 0x33ffffff);
-	ddrc_inline_ecc_scrub(0x50000000, 0x53ffffff);
-	ddrc_inline_ecc_scrub(0x14000000, 0x17ffffff);
-	ddrc_inline_ecc_scrub(0x34000000, 0x37ffffff);
-	ddrc_inline_ecc_scrub(0x54000000, 0x57ffffff);
-	ddrc_inline_ecc_scrub(0x18000000, 0x1bffffff);
-	ddrc_inline_ecc_scrub(0x38000000, 0x3bffffff);
-	ddrc_inline_ecc_scrub(0x58000000, 0x5bffffff);
-	ddrc_inline_ecc_scrub_end(0x0, 0x5fffffff);
-}
-#endif
diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
deleted file mode 100644
index e82e385b774..00000000000
--- a/board/beacon/imx8mp/spl.c
+++ /dev/null
@@ -1,126 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2022 Logic PD, Inc dba Beacon EmbeddedWorks
- *
- */
-
-#include <hang.h>
-#include <init.h>
-#include <log.h>
-#include <spl.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/imx8mp_pins.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/arch/ddr.h>
-#include <power/pmic.h>
-#include <power/pca9450.h>
-#include <dm/uclass.h>
-#include <dm/device.h>
-
-int spl_board_boot_device(enum boot_device boot_dev_spl)
-{
-	return BOOT_DEVICE_BOOTROM;
-}
-
-void spl_dram_init(void)
-{
-	ddr_init(&dram_timing);
-}
-
-void spl_board_init(void)
-{
-	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
-		struct udevice *dev;
-		int ret;
-
-		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(caam_jr), &dev);
-		if (ret)
-			printf("Failed to initialize caam_jr: %d\n", ret);
-	}
-	/*
-	 * Set GIC clock to 500Mhz for OD VDD_SOC. Kernel driver does
-	 * not allow to change it. Should set the clock after PMIC
-	 * setting done. Default is 400Mhz (system_pll1_800m with div = 2)
-	 * set by ROM for ND VDD_SOC
-	 */
-	if (!IS_ENABLED(CONFIG_IMX8M_VDD_SOC_850MV)) {
-		clock_enable(CCGR_GIC, 0);
-		clock_set_target_val(GIC_CLK_ROOT, CLK_ROOT_ON | CLK_ROOT_SOURCE_SEL(5));
-		clock_enable(CCGR_GIC, 1);
-	}
-}
-
-#if CONFIG_IS_ENABLED(DM_PMIC_PCA9450)
-int power_init_board(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = pmic_get("pmic@25", &dev);
-	if (ret == -ENODEV) {
-		puts("No pmic@25\n");
-		return 0;
-	}
-	if (ret != 0)
-		return ret;
-
-	/* BUCKxOUT_DVS0/1 control BUCK123 output */
-	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
-
-	/*
-	 * increase VDD_SOC to typical value 0.95V before first
-	 * DRAM access, set DVS1 to 0.85v for suspend.
-	 * Enable DVS control through PMIC_STBY_REQ and
-	 * set B1_ENMODE=1 (ON by PMIC_ON_REQ=H)
-	 */
-	if (CONFIG_IS_ENABLED(IMX8M_VDD_SOC_850MV))
-		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
-	else
-		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
-
-	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
-
-	/* Kernel uses OD/OD freq for SOC */
-	/* To avoid timing risk from SOC to ARM,increase VDD_ARM to OD voltage 0.95v */
-	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
-
-	return 0;
-}
-#endif
-
-#if IS_ENABLED(CONFIG_SPL_LOAD_FIT)
-int board_fit_config_name_match(const char *name)
-{
-	/* Just empty function now - can't decide what to choose */
-	debug("%s: %s\n", __func__, name);
-
-	return 0;
-}
-#endif
-
-void board_init_f(ulong dummy)
-{
-	int ret;
-
-	arch_cpu_init();
-
-	ret = spl_early_init();
-	if (ret) {
-		debug("spl_init() failed: %d\n", ret);
-		hang();
-	}
-
-	preloader_console_init();
-
-	enable_tzc380();
-
-	power_init_board();
-
-	/* DDR initialization */
-	spl_dram_init();
-}
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
deleted file mode 100644
index 8359f748244..00000000000
--- a/configs/imx8mp_beacon_defconfig
+++ /dev/null
@@ -1,179 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARM_SMCCC=y
-CONFIG_ARCH_IMX8M=y
-CONFIG_TEXT_BASE=0x40200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_ENV_SOURCE_FILE="imx8mp_beacon"
-CONFIG_SF_DEFAULT_SPEED=40000000
-CONFIG_SF_DEFAULT_MODE=0
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xFFFFDE00
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-beacon-kit"
-CONFIG_TARGET_IMX8MP_BEACON=y
-CONFIG_DM_RESET=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x960000
-CONFIG_SPL_TEXT_BASE=0x920000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x98fc00
-CONFIG_SPL_BSS_MAX_SIZE=0x400
-CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_SYS_LOAD_ADDR=0x40480000
-CONFIG_SPL=y
-CONFIG_ARMV8_SPL_EXCEPTION_VECTORS=y
-CONFIG_ARMV8_SET_SMPEN=y
-# CONFIG_PSCI_RESET is not set
-CONFIG_ARMV8_EA_EL3_FIRST=y
-CONFIG_IMX_BOOTAUX=y
-CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
-CONFIG_PCI=y
-# CONFIG_ANDROID_BOOT_IMAGE is not set
-CONFIG_FIT=y
-CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
-CONFIG_DEFAULT_FDT_FILE="imx8mp-beacon-kit.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-# CONFIG_SYS_DEVICE_NULLDEV is not set
-CONFIG_SPL_MAX_SIZE=0x26000
-CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_BOOTROM_SUPPORT=y
-CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
-CONFIG_SPL_I2C=y
-CONFIG_SPL_POWER=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_SYS_PROMPT="u-boot=> "
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
-# CONFIG_CMD_CRC32 is not set
-CONFIG_CMD_CLK=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_SDP=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_TPM=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eth1"
-CONFIG_SPL_DM=y
-CONFIG_CLK_COMPOSITE_CCF=y
-CONFIG_SPL_CLK_IMX8MP=y
-CONFIG_CLK_IMX8MP=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x42800000
-CONFIG_FASTBOOT_BUF_SIZE=0x20000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_UUU_SUPPORT=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
-CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
-CONFIG_GPIO_HOG=y
-CONFIG_MXC_GPIO=y
-CONFIG_DM_PCA953X=y
-CONFIG_DM_I2C=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_BAR=y
-CONFIG_SPI_FLASH_ATMEL=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_MTD=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_DWC_ETH_QOS=y
-CONFIG_DWC_ETH_QOS_IMX=y
-CONFIG_FEC_MXC=y
-CONFIG_RGMII=y
-CONFIG_MII=y
-CONFIG_PHY_ANEG_TIMEOUT=20000
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_NVME_PCI=y
-CONFIG_PCIE_DW_IMX=y
-CONFIG_PHY=y
-CONFIG_PHY_IMX8MQ_USB=y
-CONFIG_PHY_IMX8M_PCIE=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX8M=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
-CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
-CONFIG_DM_PMIC=y
-CONFIG_DM_PMIC_PCA9450=y
-CONFIG_SPL_DM_PMIC_PCA9450=y
-CONFIG_DM_REGULATOR_PCA9450=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-# CONFIG_DM_RNG is not set
-CONFIG_DM_SERIAL=y
-CONFIG_MXC_UART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_NXP_FSPI=y
-CONFIG_MXC_SPI=y
-CONFIG_SYSRESET=y
-CONFIG_SPL_SYSRESET=y
-CONFIG_SYSRESET_PSCI=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_TPM2_TIS_SPI=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_DM_USB_GADGET=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
-CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_MX7 is not set
-CONFIG_USB_DWC3=y
-CONFIG_USB_DWC3_GENERIC=y
-CONFIG_USB_HOST_ETHER=y
-CONFIG_USB_ETHER_ASIX=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
-CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
-CONFIG_USB_FUNCTION_ACM=y
-CONFIG_USB_ETHER=y
-CONFIG_USB_ETH_CDC=y
-# CONFIG_WATCHDOG_AUTOSTART is not set
-CONFIG_IMX_WATCHDOG=y
-CONFIG_TPM=y
-# CONFIG_SPL_SHA512 is not set
-# CONFIG_SPL_SHA384 is not set
diff --git a/doc/board/beacon/beacon-imx8mp.rst b/doc/board/beacon/beacon-imx8mp.rst
deleted file mode 100644
index 375931c07d1..00000000000
--- a/doc/board/beacon/beacon-imx8mp.rst
+++ /dev/null
@@ -1,52 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-U-Boot for the Beacon EmbeddedWorks i.MX8M Plus Devkit
-======================================================
-
-Quick Start
------------
-
-- Build the ARM Trusted firmware binary
-- Get DDR firmware
-- Build U-Boot
-- Burn U-Noot to microSD Card
-- Boot
-
-Get and Build the ARM Trusted firmware
---------------------------------------
-
-.. code-block:: bash
-
-    $ git clone https://github.com/nxp-imx/imx-atf.git -b v2.6
-    $ make PLAT=imx8mp bl31 CROSS_COMPILE=aarch64-linux-gnu-
-    $ cp build/imx8mn/release/bl31.bin ../
-
-Get the DDR firmware
---------------------
-
-.. code-block:: bash
-
-    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.15.bin
-    $ chmod +x firmware-imx-8.15.bin
-    $ ./firmware-imx-8.15
-    $ cp firmware-imx-8.15/firmware/ddr/synopsys/lpddr4*.bin .
-
-Build U-Boot
-------------
-
-.. code-block:: bash
-
-    $ make imx8mp_beacon_defconfig
-    $ make CROSS_COMPILE=aarch64-linux-gnu-
-
-Burn U-Boot to microSD Card
----------------------------
-
-.. code-block:: bash
-
-    $ sudo dd if=flash.bin of=/dev/sd[x] bs=1024 seek=32
-
-Boot
-----
-Set baseboard DIP switch:
-S17: 1100XXXX
diff --git a/doc/board/beacon/index.rst b/doc/board/beacon/index.rst
deleted file mode 100644
index 1fe1046a4ce..00000000000
--- a/doc/board/beacon/index.rst
+++ /dev/null
@@ -1,9 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-Beacon
-======
-
-.. toctree::
-   :maxdepth: 2
-
-   beacon-imx8mp
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 4103fef8d8f..cc1d181a8e1 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -19,7 +19,6 @@ Board-specific doc
    aspeed/index
    asus/index
    atmel/index
-   beacon/index
    beagle/index
    broadcom/index
    bsh/index
diff --git a/include/configs/imx8mp_beacon.h b/include/configs/imx8mp_beacon.h
deleted file mode 100644
index b36dae7c34f..00000000000
--- a/include/configs/imx8mp_beacon.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2023 Logic PD, Inc dba Beacon EmbeddedWorks
- */
-
-#ifndef __IMX8MP_BEACON_H
-#define __IMX8MP_BEACON_H
-
-#include <asm/arch/imx-regs.h>
-
-#define CFG_SYS_UBOOT_BASE	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
-
-/* Link Definitions */
-
-#define CFG_SYS_INIT_RAM_ADDR	0x40000000
-#define CFG_SYS_INIT_RAM_SIZE	0x80000
-
-/* Totally 6GB DDR */
-#define CFG_SYS_SDRAM_BASE		0x40000000
-#define PHYS_SDRAM			0x40000000
-#define PHYS_SDRAM_SIZE			0xC0000000	/* 3 GB */
-#define PHYS_SDRAM_2			0x100000000
-#define PHYS_SDRAM_2_SIZE		0xC0000000	/* 3 GB */
-
-#endif
-- 
2.53.0

