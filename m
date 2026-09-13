Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3625AC88E5C
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E956B80D09;
	Sun, 13 Sep 2026 23:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6xO-VrfbhkuL; Sun, 13 Sep 2026 23:20:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E7DDB80D29
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341617;
	b=tFa15yHLZmIQORKaZs6tbg5CvfxXwb9CL4b2V56AvJS7qECdKu0muAbRBpnlSFLjseRb
	 FrWESoKZf5Dsc8M+16F+qzSjpV+R1v0rCMJg3ybcb2zFq4wH1TczqQEqK2t81SC/JtO7e
	 ulVKrPKuXn0AnEutJwRGeSgAzgBis/dWoFvfJMRxfmEAYOgMWyAigCXJUe0GpYwPlMMSs
	 VUw95ym5cfoPW9EJamkY5izZ3PbaCOWdoQEqvutKvZkxUWzNFwKXQ5Un8HR1uXRgpTI5l
	 JMxBTy9y5q6HAOwaca1/z7hRDrwRzPmbkedTzKhE3QYbbUwmndnyB9vQ/TxRsgdRgFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8/1B+yn61cWw+xIp52rhz5LDssmTpOOFWUi+xJmywLA=;
	b=OUitGugvEAcAEn6uB3sxfhIpTPaZN9VSF1xsC+YWyH/4Thx7tY/Ecd40wA3Sln6/mbEh
	 v76/Xe7rrUa5NrbBwrzUV0NCUIk29wIRzw7Z6Jb+lr4+8sDPr7YjvAyn+lbT8HxYvdExM
	 x1FKfGnb/mugi3FqDPP5L25nDr/oLXSeYp+Di3wfqkF2rMRgvT0hjtucc22nfDCwXOMv0
	 Y9M3UhveY66w+z5yIP2tjijHFhnxXbK33ZKOGQBrGIe8Lcm9FZYls+fX2RZGSBAiMOWWH
	 FDbYLYh3El83oi2iEmU6yBkyjhERQbJcgH6DgZ26oCQpnCmb4dOn+RC5GHZordnsqpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=snTskYrs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341617;
	bh=8/1B+yn61cWw+xIp52rhz5LDssmTpOOFWUi+xJmywLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SRt6iP6SB2UaZCvFFDQA37ivb3i99yWKbGRwBp9K+/dB35TrTPgEe5kxYWbHHxwOt
	 0LkP7wG6x8osw0FV7tM7Vc+WwVfuwBSyUpttFywTG7b4BX7MtftA7gaLgOSORFuwom
	 XT1CrV8UZrcZ/DbnCkanKGpJ/671YMxby95119UjiHo0/IYQXnL+7N1GvbH285/161
	 a1LKuRBNyXvxrrJGEsYAGBPurOpmCVgraVXjcGvEYESuo5dmvp10x5X5w2kEIvWClW
	 7fW4bNRuwmjg+kak5j6JTsH6aQoI+sBnwpEHlG8gP6qB2/J6teglIhqJOl3qnpC6UF
	 r2k9bCKDrOq9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7DDB80D29;
	Sun, 13 Sep 2026 23:20:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ED883AF
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 052BA80D50
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kkfGy0cQg0zl for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 15:53:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5F0C980D2B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789314790;
 b=fvrEJBAvoA1yzvy4ADLt0y+fWAy/DRJjLnvki5aa510t67SQDl+CSVPY7BRvEC3O3t/f
 jWyYLFAJGc2AVjhSEeBj9rg73cNLUCxbccaTLX1Bc/lgJWEZwXvfri5eyPNlQ/WOdp2RC
 5CpMb5Thl0gzmod3Kr0obxbX6vzAleDW8BCtV9OohHx8MMKi1qR5PBmAqSij/24PXc3+k
 Ci0SGBla56gTKFEkYCNP+Nirkskblturr0XXm3Iug3ejJzRWa8+JrPGLwD6afpSGF1zQb
 qLztzfBzbPc2UZBGUyDUkyfXr5wdXXEPq0OZAVSQWBulY7SxKUBHq9LJ8AULulL4cEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789314790;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=8/1B+yn61cWw+xIp52rhz5LDssmTpOOFWUi+xJmywLA=;
 b=PRpseYPkK82IP6b/gsp4eSOmYpeoScVE3YN/7sDhrzhNNJ3cIyue/8X8BeubTgszEWHW
 ggpaOAMn6X7EeEYbXDpmtSfrg5bg3Y+ve6l4FwjjRkHiHf0yB4dOigx2IZZ0pj8roB7TW
 OsUv3oLtsC43xfRCtImSzU333C1Sryoq/scoaIqzCgfveaO2X+jnT6kYhf/9Jx9Ard1uL
 FpLBce/xd5k2ytBMMqeDeSNvw2g8cKF2f0zMw77AEo4XR/TNuYIagkUjkx2deH18efBjE
 aCdla1AEYRvuqKXvnh5+xqweA9k47ahHltpnYV0EgmYSe9y0UgahmRFVIpRLslA23lg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=snTskYrs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=snTskYrs
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com
 [IPv6:2607:f8b0:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F0C980D2B
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:53:09 +0000 (UTC)
Received: by mail-qk2-x10.google.com with SMTP id
 d75a77b69052e-52fb76c9deeso22257401cf.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789314788; x=1789919588;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8/1B+yn61cWw+xIp52rhz5LDssmTpOOFWUi+xJmywLA=;
 b=snTskYrsvopFIfiacZqe3XbPQIZYwq+CkAMLcB3ep3nTSQ7zJl5rckBzC7oTlnaYef
 I0s7VFCcDz1tq3hZuAJzukONjGRrSwLP0q3HU1+YQxDdoPkrPcM2x465YgAk5YsnAseZ
 calZcDEB5TQyEKt0JJnEXdl4GJCkMx2Aqbug4Jmk5J2KGeEyV3x6IpzzFPGPH+HZt04w
 uCcTSVy7lRuiRHzotnJsIvRJ9zHE3Afh4yoCfF3OM34Wyc7QcNUwBKwxBLeLjlCfDN7p
 TGnR1YKrzAFB7KLlb3hveLt0oY0YThV3tmARUCtHt70eaPZWMYx/uSqOPZ/cQYze8prv
 H5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789314788; x=1789919588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8/1B+yn61cWw+xIp52rhz5LDssmTpOOFWUi+xJmywLA=;
 b=EOHsnWVbeJSGIOjaDq4c1T6crDZRC5jo/zfzPN5D100XBm83heHfjgeX7ZIHIObhKZ
 6eLBoBRIGmjPYr/PgVZPRoNn85edKnkLrPZS3tmglC91mfaiRd+rhmHxTAiACvo/V567
 MHN/1e6FG505IPsi4CX9b3FD4W07CwFzgFUkhzztbDBYmSzqNWMCxRVYqn0lVAoJqbiB
 7nla2+x9Sj56r+kpRPlw622h7tEdakGFzup+D/zPxUKuBg3wIOr/j+JqwwIFakgkPD1+
 Z4167GbGn5z5hwZ5rkLl5lmaT1UmOknU/Z2FwBY6BTp2V/NJjFvZEWvIWQ1QyAbm9zZ7
 pZMA==
X-Gm-Message-State: AFuF++nqaffpExswvY8KgNhciVyJpP/mduV7paUhkaQ9jOYLFvRITLVr
 PP1PV/kh5dLmAxkGcybPexdQxKb8n0M1rStGD5PB17cZ+PS5mj57Cua+whqzXg==
X-Gm-Gg: AYBFou02pUHHS+Rnn8j3BwcdnlivX3NYcda8Eby2evZMT+QyP18rcGdPGKHX3OjDv11
 FpkdBwM0DrQGHoigcDjt5KjJh+Pms8f2w5/+ah1i30OCgAVBDHLhX4ghfdAzTLgvWiNQ6SbZJr5
 8Ed5T3gEMLlDaC3Pxi0itsPndyV/cFJBW4A3/pTYU58jFahBzROxIZPD+GT9He3eAANRuoJvyci
 6FMTdmk2ZeqI3EokmDjHFhrhmv2UKVzOqWuyEE5SekA/+DU/VVMfHgM7jcu8k2g58zTLOZDNzVm
 9frePWMrSeto6NBvI79rFlCZGi/X5R8szE6XX+DX1MPtAMDLBRrFQ8KTHCW178CoCwbH+BTQt0L
 DMLghFNmtpTDxswI1vImwcLE3skPmX5+gaV4F9XoVyA/OPm89GsLeGWKFPiO0q+pyV4tr/Wez2q
 NES+OqlEbXE/tKIyYLQM/cifw6cGzrBGLTvk/y8KQ7kELk30G9ZsPnJKG4f1VYMff0LTpLF26oP
 W/E4fS909Yaf47uooGDjhoV5aKi6AuUXjeWhUqQmalDxh5sSMYV
X-Received: by 2002:a05:622a:58c6:b0:530:98bc:3974 with SMTP id
 d75a77b69052e-530e7ee4bf4mr111080721cf.22.1789314787893; 
 Sun, 13 Sep 2026 08:53:07 -0700 (PDT)
Received: from aford-System-Version.lan (c-73-94-212-116.hsd1.mn.comcast.net.
 [73.94.212.116]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4d3a50sm72993386d6.40.2026.09.13.08.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:53:07 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH 1/3] board: beacon: Remove i.MX8MM Beacon EmbeddedWorks Devkit
 support
Date: Sun, 13 Sep 2026 10:53:01 -0500
Message-ID: <20260913155303.84201-2-aford173@gmail.com>
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

Remove the i.MX8MM Beacon EmbeddedWorks Devkit board support along
with its defconfigs, config header, U-Boot device tree overlay,
documentation and Kconfig target.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/dts/imx8mm-beacon-kit-u-boot.dtsi  |  130 --
 arch/arm/mach-imx/imx8m/Kconfig             |   11 -
 board/beacon/imx8mm/Kconfig                 |   15 -
 board/beacon/imx8mm/MAINTAINERS             |    9 -
 board/beacon/imx8mm/Makefile                |   12 -
 board/beacon/imx8mm/imx8mm_beacon.env       |   19 -
 board/beacon/imx8mm/imximage-8mm-lpddr4.cfg |    8 -
 board/beacon/imx8mm/lpddr4_timing.c         | 1979 -------------------
 board/beacon/imx8mm/spl.c                   |  128 --
 configs/imx8mm_beacon_defconfig             |  151 --
 configs/imx8mm_beacon_fspi_defconfig        |  152 --
 doc/board/beacon/beacon-imx8mm.rst          |   55 -
 doc/board/beacon/index.rst                  |    1 -
 include/configs/imx8mm_beacon.h             |   40 -
 14 files changed, 2710 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mm-beacon-kit-u-boot.dtsi
 delete mode 100644 board/beacon/imx8mm/Kconfig
 delete mode 100644 board/beacon/imx8mm/MAINTAINERS
 delete mode 100644 board/beacon/imx8mm/Makefile
 delete mode 100644 board/beacon/imx8mm/imx8mm_beacon.env
 delete mode 100644 board/beacon/imx8mm/imximage-8mm-lpddr4.cfg
 delete mode 100644 board/beacon/imx8mm/lpddr4_timing.c
 delete mode 100644 board/beacon/imx8mm/spl.c
 delete mode 100644 configs/imx8mm_beacon_defconfig
 delete mode 100644 configs/imx8mm_beacon_fspi_defconfig
 delete mode 100644 doc/board/beacon/beacon-imx8mm.rst
 delete mode 100644 include/configs/imx8mm_beacon.h

diff --git a/arch/arm/dts/imx8mm-beacon-kit-u-boot.dtsi b/arch/arm/dts/imx8mm-beacon-kit-u-boot.dtsi
deleted file mode 100644
index 00abbeb22fe..00000000000
--- a/arch/arm/dts/imx8mm-beacon-kit-u-boot.dtsi
+++ /dev/null
@@ -1,130 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2020 Compass Electronics Group, LLC
- */
-
-#include "imx8mm-u-boot.dtsi"
-
-/ {
-	aliases {
-		spi0 = &flexspi;
-	};
-
-	wdt-reboot {
-		compatible = "wdt-reboot";
-		wdt = <&wdog1>;
-		bootph-pre-ram;
-	};
-};
-
-&aips4 {
-	bootph-pre-ram;
-};
-
-&reg_usdhc2_vmmc {
-	u-boot,off-on-delay-us = <20000>;
-};
-
-&fec1 {
-	phy-reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
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
-&pca6416_0 {
-	compatible = "ti,tca6416";
-};
-
-&pca6416_1 {
-	compatible = "ti,tca6416";
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
-&reg_usbotg1 {
-
-};
-
-&uart2 {
-	bootph-pre-ram;
-};
-
-&usbmisc1 {
-	bootph-pre-ram;
-};
-
-&usbotg1 {
-	bootph-pre-ram;
-};
-
-&usbphynop1 {
-	bootph-pre-ram;
-};
-
-&usdhc2 {
-	bootph-pre-ram;
-};
-
-&usdhc3 {
-	bootph-pre-ram;
-};
-
-&i2c1 {
-	bootph-pre-ram;
-};
-
-&{/soc@0/bus@30800000/i2c@30a20000/pmic@4b} {
-	bootph-pre-ram;
-};
-
-&{/soc@0/bus@30800000/i2c@30a20000/pmic@4b/regulators} {
-	bootph-pre-ram;
-};
-
-&wdog1 {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index c03c4e72101..80486553056 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -354,16 +354,6 @@ config TARGET_VERDIN_IMX8MP
 	select IMX8M_LPDDR4
 	imply OF_UPSTREAM
 
-config TARGET_IMX8MM_BEACON
-	bool "imx8mm Beacon Embedded devkit"
-	select IMX8MM
-	select SUPPORT_SPL
-	select IMX8M_LPDDR4
-	select FSL_CAAM
-	select ARCH_MISC_INIT
-	select SPL_CRYPTO if SPL
-	imply OF_UPSTREAM
-
 config TARGET_IMX8MN_BEACON
 	bool "imx8mn Beacon Embedded devkit"
 	select IMX8MN
@@ -446,7 +436,6 @@ config TARGET_LIBREM5_DEVKIT
 endchoice
 
 source "board/advantech/imx8mp_rsb3720a1/Kconfig"
-source "board/beacon/imx8mm/Kconfig"
 source "board/beacon/imx8mn/Kconfig"
 source "board/beacon/imx8mp/Kconfig"
 source "board/bsh/imx8mn_smm_s2/Kconfig"
diff --git a/board/beacon/imx8mm/Kconfig b/board/beacon/imx8mm/Kconfig
deleted file mode 100644
index e5d8aa3ec9c..00000000000
--- a/board/beacon/imx8mm/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-if TARGET_IMX8MM_BEACON
-
-config SYS_BOARD
-	default "imx8mm"
-
-config SYS_VENDOR
-	default "beacon"
-
-config SYS_CONFIG_NAME
-	default "imx8mm_beacon"
-
-config IMX_CONFIG
-	default "board/beacon/imx8mm/imximage-8mm-lpddr4.cfg"
-
-endif
diff --git a/board/beacon/imx8mm/MAINTAINERS b/board/beacon/imx8mm/MAINTAINERS
deleted file mode 100644
index d8a5d097369..00000000000
--- a/board/beacon/imx8mm/MAINTAINERS
+++ /dev/null
@@ -1,9 +0,0 @@
-i.MX8MM Beacon EmbeddedWorks Devkit
-
-M:	Adam Ford <aford173@gmail.com>
-S:	Maintained
-F:	board/beacon/imx8mm/
-F:	include/configs/imx8mm_beacon.h
-F:	configs/imx8mm_beacon_defconfig
-F:	configs/imx8mm_beacon_fspi_defconfig
-F:	doc/board/beacon/
diff --git a/board/beacon/imx8mm/Makefile b/board/beacon/imx8mm/Makefile
deleted file mode 100644
index eb762504266..00000000000
--- a/board/beacon/imx8mm/Makefile
+++ /dev/null
@@ -1,12 +0,0 @@
-#
-# Copyright 2020 Compass Electronics Group, LLC
-#
-# SPDX-License-Identifier:      GPL-2.0+
-#
-
-obj-y += ../../nxp/common/
-
-ifdef CONFIG_XPL_BUILD
-obj-y += spl.o
-obj-y += lpddr4_timing.o
-endif
diff --git a/board/beacon/imx8mm/imx8mm_beacon.env b/board/beacon/imx8mm/imx8mm_beacon.env
deleted file mode 100644
index 00bf67edd5b..00000000000
--- a/board/beacon/imx8mm/imx8mm_beacon.env
+++ /dev/null
@@ -1,19 +0,0 @@
-boot_fit=try
-bootscript=echo Running bootscript from mmc ...; source
-console=ttymxc1
-fdt_addr=0x45000000
-fdt_file=imx8mm-beacon-kit.dtb
-finduuid=part uuid mmc ${mmcdev}:2 uuid
-image=Image
-initrd_addr=0x46000000
-loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
-loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
-loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
-mmcargs=setenv bootargs console=${console},${baudrate} root=PARTUUID=${uuid} rootwait rw ${mtdparts} ${optargs}
-mmcautodetect=yes
-mmcboot=echo Booting from mmc ...; run finduuid; run mmcargs; if run loadfdt; then booti ${loadaddr} - ${fdt_addr}; else echo WARN: Cannot load the DT; fi;
-netargs=setenv bootargs console=${console},${baudrate} root=/dev/nfs ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
-mmcdev=1
-mmcpart=1
-netboot=echo Booting from net ...; run netargs;  if test ${ip_dyn} = yes; then setenv get_cmd dhcp; else setenv get_cmd tftp; fi; ${get_cmd} ${loadaddr} ${image}; if test ${boot_fit} = yes || test ${boot_fit} = try; then bootm ${loadaddr}; else if ${get_cmd} ${fdt_addr} ${fdt_file}; then booti ${loadaddr} - ${fdt_addr}; else echo WARN: Cannot load the DT; fi; fi;
-script=boot.scr
diff --git a/board/beacon/imx8mm/imximage-8mm-lpddr4.cfg b/board/beacon/imx8mm/imximage-8mm-lpddr4.cfg
deleted file mode 100644
index 20061521f22..00000000000
--- a/board/beacon/imx8mm/imximage-8mm-lpddr4.cfg
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2021 NXP
- */
-
-
-BOOT_FROM	sd
-LOADER		u-boot-spl-ddr.bin	0x7E1000
diff --git a/board/beacon/imx8mm/lpddr4_timing.c b/board/beacon/imx8mm/lpddr4_timing.c
deleted file mode 100644
index c1498dd5eaf..00000000000
--- a/board/beacon/imx8mm/lpddr4_timing.c
+++ /dev/null
@@ -1,1979 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2019 NXP
- */
-
-#include <linux/kernel.h>
-#include <asm/arch/ddr.h>
-#include <asm/arch/lpddr4_define.h>
-
-struct dram_cfg_param lpddr4_ddrc_cfg[] = {
-	/* Start to config, default 3200mbps */
-	{ DDRC_DBG1(0),	0x00000001 },
-	{ DDRC_PWRCTL(0), 0x00000001 },
-	{ DDRC_MSTR(0),	0xa1080020 },
-	{ DDRC_RFSHTMG(0), 0x005b00d2 },
-	{ DDRC_INIT0(0), 0xC003061B },
-	{ DDRC_INIT1(0), 0x009D0000 },
-	{ DDRC_INIT3(0), 0x00D4002D },
-	{ DDRC_INIT4(0), (LPDDR4_MR3 << 16) | 0x0000 },
-	{ DDRC_INIT6(0), 0x0066004a },
-	{ DDRC_INIT7(0), 0x0006004a },
-
-	{ DDRC_DRAMTMG0(0), 0x1A201B22 },
-	{ DDRC_DRAMTMG1(0), 0x00060633 },
-	{ DDRC_DRAMTMG3(0), 0x00C0C000 },
-	{ DDRC_DRAMTMG4(0), 0x0F04080F },
-	{ DDRC_DRAMTMG5(0), 0x02040C0C },
-	{ DDRC_DRAMTMG6(0), 0x01010007 },
-	{ DDRC_DRAMTMG7(0), 0x00000401 },
-	{ DDRC_DRAMTMG12(0), 0x00020600 },
-	{ DDRC_DRAMTMG13(0), 0x0C100002 },
-	{ DDRC_DRAMTMG14(0), 0x000000E6 },
-	{ DDRC_DRAMTMG17(0), 0x00A00050 },
-
-	{ DDRC_ZQCTL0(0), 0x03200018 },
-	{ DDRC_ZQCTL1(0), 0x028061A8 },
-	{ DDRC_ZQCTL2(0), 0x00000000 },
-
-	{ DDRC_DFITMG0(0), 0x0497820A },
-	{ DDRC_DFITMG2(0), 0x0000170A },
-	{ DDRC_DRAMTMG2(0), 0x070E171a },
-	{ DDRC_DBICTL(0), 0x00000001 },
-
-	{ DDRC_DFITMG1(0), 0x00080303 },
-	{ DDRC_DFIUPD0(0), 0xE0400018 },
-	{ DDRC_DFIUPD1(0), 0x00DF00E4 },
-	{ DDRC_DFIUPD2(0), 0x80000000 },
-	{ DDRC_DFIMISC(0), 0x00000011 },
-
-	{ DDRC_DFIPHYMSTR(0), 0x00000000 },
-	{ DDRC_RANKCTL(0), 0x00000c99 },
-
-	/* address mapping */
-	{ DDRC_ADDRMAP0(0), 0x0000001f },
-	{ DDRC_ADDRMAP1(0), 0x00080808 },
-	{ DDRC_ADDRMAP2(0), 0x00000000 },
-	{ DDRC_ADDRMAP3(0), 0x00000000 },
-	{ DDRC_ADDRMAP4(0), 0x00001f1f },
-	{ DDRC_ADDRMAP5(0), 0x07070707 },
-	{ DDRC_ADDRMAP6(0), 0x07070707 },
-	{ DDRC_ADDRMAP7(0), 0x00000f0f },
-
-	/* performance setting */
-	{ DDRC_SCHED(0), 0x29001701 },
-	{ DDRC_SCHED1(0), 0x0000002c },
-	{ DDRC_PERFHPR1(0), 0x04000030 },
-	{ DDRC_PERFLPR1(0), 0x900093e7 },
-	{ DDRC_PERFWR1(0), 0x20005574 },
-	{ DDRC_PCCFG(0), 0x00000111 },
-	{ DDRC_PCFGW_0(0), 0x000072ff },
-	{ DDRC_PCFGQOS0_0(0), 0x02100e07 },
-	{ DDRC_PCFGQOS1_0(0), 0x00620096 },
-	{ DDRC_PCFGWQOS0_0(0), 0x01100e07 },
-	{ DDRC_PCFGWQOS1_0(0), 0x00c8012c },
-
-	/* frequency P1&P2 */
-	/* Frequency 1: 400mbps */
-	{ DDRC_FREQ1_DRAMTMG0(0), 0x0d0b010c },
-	{ DDRC_FREQ1_DRAMTMG1(0), 0x00030410 },
-	{ DDRC_FREQ1_DRAMTMG2(0), 0x0203090c },
-	{ DDRC_FREQ1_DRAMTMG3(0), 0x00505006 },
-	{ DDRC_FREQ1_DRAMTMG4(0), 0x05040305 },
-	{ DDRC_FREQ1_DRAMTMG5(0), 0x0d0e0504 },
-	{ DDRC_FREQ1_DRAMTMG6(0), 0x0a060004 },
-	{ DDRC_FREQ1_DRAMTMG7(0), 0x0000090e },
-	{ DDRC_FREQ1_DRAMTMG14(0), 0x00000032 },
-	{ DDRC_FREQ1_DRAMTMG15(0), 0x00000000 },
-	{ DDRC_FREQ1_DRAMTMG17(0), 0x0036001b },
-	{ DDRC_FREQ1_DERATEINT(0), 0x7e9fbeb1 },
-	{ DDRC_FREQ1_DFITMG0(0), 0x03818200 },
-	{ DDRC_FREQ1_DFITMG2(0), 0x00000000 },
-	{ DDRC_FREQ1_RFSHTMG(0), 0x000C001c },
-	{ DDRC_FREQ1_INIT3(0), 0x00840000 },
-	{ DDRC_FREQ1_INIT4(0), 0x00310000 },
-	{ DDRC_FREQ1_INIT6(0), 0x0066004a },
-	{ DDRC_FREQ1_INIT7(0), 0x0006004a },
-
-	/* Frequency 2: 100mbps */
-	{ DDRC_FREQ2_DRAMTMG0(0), 0x0d0b010c },
-	{ DDRC_FREQ2_DRAMTMG1(0), 0x00030410 },
-	{ DDRC_FREQ2_DRAMTMG2(0), 0x0203090c },
-	{ DDRC_FREQ2_DRAMTMG3(0), 0x00505006 },
-	{ DDRC_FREQ2_DRAMTMG4(0), 0x05040305 },
-	{ DDRC_FREQ2_DRAMTMG5(0), 0x0d0e0504 },
-	{ DDRC_FREQ2_DRAMTMG6(0), 0x0a060004 },
-	{ DDRC_FREQ2_DRAMTMG7(0), 0x0000090e },
-	{ DDRC_FREQ2_DRAMTMG14(0), 0x00000032 },
-	{ DDRC_FREQ2_DRAMTMG17(0), 0x0036001b },
-	{ DDRC_FREQ2_DERATEINT(0), 0x7e9fbeb1 },
-	{ DDRC_FREQ2_DFITMG0(0), 0x03818200 },
-	{ DDRC_FREQ2_DFITMG2(0), 0x00000000 },
-	{ DDRC_FREQ2_RFSHTMG(0), 0x0003800c },
-	{ DDRC_FREQ2_RFSHTMG(0), 0x00030007 },
-	{ DDRC_FREQ2_INIT3(0), 0x00840000 },
-	{ DDRC_FREQ2_INIT4(0), 0x00310008 },
-	{ DDRC_FREQ2_INIT4(0), (LPDDR4_MR3 << 16) | 0x0000 },
-	{ DDRC_FREQ2_INIT6(0), 0x0066004a },
-	{ DDRC_FREQ2_INIT7(0), 0x0006004a },
-
-	/* boot start point */
-	{ DDRC_MSTR2(0), 0x2 }, //DDRC_MSTR2
-};
-
-/* PHY Initialize Configuration */
-struct dram_cfg_param lpddr4_ddrphy_cfg[] = {
-	{ 0x1005f, 0x1ff },
-	{ 0x1015f, 0x1ff },
-	{ 0x1105f, 0x1ff },
-	{ 0x1115f, 0x1ff },
-	{ 0x1205f, 0x1ff },
-	{ 0x1215f, 0x1ff },
-	{ 0x1305f, 0x1ff },
-	{ 0x1315f, 0x1ff },
-
-	{ 0x11005f, 0x1ff },
-	{ 0x11015f, 0x1ff },
-	{ 0x11105f, 0x1ff },
-	{ 0x11115f, 0x1ff },
-	{ 0x11205f, 0x1ff },
-	{ 0x11215f, 0x1ff },
-	{ 0x11305f, 0x1ff },
-	{ 0x11315f, 0x1ff },
-
-	{ 0x21005f, 0x1ff },
-	{ 0x21015f, 0x1ff },
-	{ 0x21105f, 0x1ff },
-	{ 0x21115f, 0x1ff },
-	{ 0x21205f, 0x1ff },
-	{ 0x21215f, 0x1ff },
-	{ 0x21305f, 0x1ff },
-	{ 0x21315f, 0x1ff },
-
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
-
-	{ 0x200c5, 0x19 },
-	{ 0x1200c5, 0x7 },
-	{ 0x2200c5, 0x7 },
-
-	{ 0x2002e, 0x2 },
-	{ 0x12002e, 0x2 },
-	{ 0x22002e, 0x2 },
-
-	{ 0x90204, 0x0 },
-	{ 0x190204, 0x0 },
-	{ 0x290204, 0x0 },
-
-	{ 0x20024, 0xab },
-	{ 0x2003a, 0x0 },
-
-	{ 0x120024, 0xab },
-	{ 0x2003a, 0x0 },
-
-	{ 0x220024, 0xab },
-	{ 0x2003a, 0x0 },
-
-	{ 0x20056, 0x3 },
-	{ 0x120056, 0xa },
-	{ 0x220056, 0xa },
-
-	{ 0x1004d, 0xe00 },
-	{ 0x1014d, 0xe00 },
-	{ 0x1104d, 0xe00 },
-	{ 0x1114d, 0xe00 },
-	{ 0x1204d, 0xe00 },
-	{ 0x1214d, 0xe00 },
-	{ 0x1304d, 0xe00 },
-	{ 0x1314d, 0xe00 },
-
-	{ 0x11004d, 0xe00 },
-	{ 0x11014d, 0xe00 },
-	{ 0x11104d, 0xe00 },
-	{ 0x11114d, 0xe00 },
-	{ 0x11204d, 0xe00 },
-	{ 0x11214d, 0xe00 },
-	{ 0x11304d, 0xe00 },
-	{ 0x11314d, 0xe00 },
-
-	{ 0x21004d, 0xe00 },
-	{ 0x21014d, 0xe00 },
-	{ 0x21104d, 0xe00 },
-	{ 0x21114d, 0xe00 },
-	{ 0x21204d, 0xe00 },
-	{ 0x21214d, 0xe00 },
-	{ 0x21304d, 0xe00 },
-	{ 0x21314d, 0xe00 },
-
-	{ 0x10049, 0xfbe },
-	{ 0x10149, 0xfbe },
-	{ 0x11049, 0xfbe },
-	{ 0x11149, 0xfbe },
-	{ 0x12049, 0xfbe },
-	{ 0x12149, 0xfbe },
-	{ 0x13049, 0xfbe },
-	{ 0x13149, 0xfbe },
-
-	{ 0x110049, 0xfbe },
-	{ 0x110149, 0xfbe },
-	{ 0x111049, 0xfbe },
-	{ 0x111149, 0xfbe },
-	{ 0x112049, 0xfbe },
-	{ 0x112149, 0xfbe },
-	{ 0x113049, 0xfbe },
-	{ 0x113149, 0xfbe },
-
-	{ 0x210049, 0xfbe },
-	{ 0x210149, 0xfbe },
-	{ 0x211049, 0xfbe },
-	{ 0x211149, 0xfbe },
-	{ 0x212049, 0xfbe },
-	{ 0x212149, 0xfbe },
-	{ 0x213049, 0xfbe },
-	{ 0x213149, 0xfbe },
-
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
-
-	{ 0x20018, 0x3 },
-	{ 0x20075, 0x4 },
-	{ 0x20050, 0x0 },
-	{ 0x20008, 0x2ee },
-	{ 0x120008, 0x64 },
-	{ 0x220008, 0x19 },
-	{ 0x20088, 0x9 },
-
-	{ 0x200b2, 0x1d4 },
-	{ 0x10043, 0x5a1 },
-	{ 0x10143, 0x5a1 },
-	{ 0x11043, 0x5a1 },
-	{ 0x11143, 0x5a1 },
-	{ 0x12043, 0x5a1 },
-	{ 0x12143, 0x5a1 },
-	{ 0x13043, 0x5a1 },
-	{ 0x13143, 0x5a1 },
-
-	{ 0x1200b2, 0xdc },
-	{ 0x110043, 0x5a1 },
-	{ 0x110143, 0x5a1 },
-	{ 0x111043, 0x5a1 },
-	{ 0x111143, 0x5a1 },
-	{ 0x112043, 0x5a1 },
-	{ 0x112143, 0x5a1 },
-	{ 0x113043, 0x5a1 },
-	{ 0x113143, 0x5a1 },
-
-	{ 0x2200b2, 0xdc },
-	{ 0x210043, 0x5a1 },
-	{ 0x210143, 0x5a1 },
-	{ 0x211043, 0x5a1 },
-	{ 0x211143, 0x5a1 },
-	{ 0x212043, 0x5a1 },
-	{ 0x212143, 0x5a1 },
-	{ 0x213043, 0x5a1 },
-	{ 0x213143, 0x5a1 },
-
-	{ 0x200fa, 0x1 },
-	{ 0x1200fa, 0x1 },
-	{ 0x2200fa, 0x1 },
-
-	{ 0x20019, 0x1 },
-	{ 0x120019, 0x1 },
-	{ 0x220019, 0x1 },
-
-	{ 0x200f0, 0x660 },
-	{ 0x200f1, 0x0 },
-	{ 0x200f2, 0x4444 },
-	{ 0x200f3, 0x8888 },
-	{ 0x200f4, 0x5665 },
-	{ 0x200f5, 0x0 },
-	{ 0x200f6, 0x0 },
-	{ 0x200f7, 0xf000 },
-
-	{ 0x20025, 0x0 },
-	{ 0x2002d, LPDDR4_PHY_DMIPinPresent },
-	{ 0x12002d, LPDDR4_PHY_DMIPinPresent },
-	{ 0x22002d, LPDDR4_PHY_DMIPinPresent },
-	{ 0x200c7, 0x21 },
-	{ 0x200ca, 0x24 },
-	{ 0x1200c7, 0x21 },
-	{ 0x1200ca, 0x24 },
-	{ 0x2200c7, 0x21 },
-	{ 0x2200ca, 0x24 },
-};
-
-/* ddr phy trained csr */
-struct dram_cfg_param lpddr4_ddrphy_trained_csr[] = {
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
-struct dram_cfg_param lpddr4_fsp0_cfg[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x54000, 0x0 },
-	{ 0x54001, 0x0 },
-	{ 0x54002, 0x0 },
-	{ 0x54003, 0xbb8 },
-	{ 0x54004, 0x2 },
-	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },//PHY Ron/Rtt
-	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
-	{ 0x54007, 0x0 },
-	{ 0x54008, 0x131f },
-	{ 0x54009, 0xc8 },
-	{ 0x5400a, 0x0 },
-	{ 0x5400b, 0x2 },
-	{ 0x5400c, 0x0 },
-	{ 0x5400d, 0x0 },
-	{ 0x5400e, 0x0 },
-	{ 0x5400f, 0x0 },
-	{ 0x54010, 0x0 },
-	{ 0x54011, 0x0 },
-	{ 0x54012, (LPDDR4_CS << 8) | (0x110 & 0xff) },
-	{ 0x54013, 0x0 },
-	{ 0x54014, 0x0 },
-	{ 0x54015, 0x0 },
-	{ 0x54016, 0x0 },
-	{ 0x54017, 0x0 },
-	{ 0x54018, 0x0 },
-	{ 0x54019, 0x2dd4 },
-	{ 0x5401a, (0x31 & 0xff00) | LPDDR4_MR3 },
-	{ 0x5401b, 0x4d66 },
-	{ 0x5401c, 0x4d08 },
-	{ 0x5401d, 0x0 },
-	{ 0x5401e, LPDDR4_MR22_RANK0/*0x16*/ },
-	{ 0x5401f, 0x2dd4 },
-	{ 0x54020, (0x31 & 0xff00) | LPDDR4_MR3 },
-	{ 0x54021, 0x4d66 },
-	{ 0x54022, 0x4d08 },
-	{ 0x54023, 0x0 },
-	{ 0x54024, LPDDR4_MR22_RANK1/*0x16*/ },
-	{ 0x54025, 0x0 },
-	{ 0x54026, 0x0 },
-	{ 0x54027, 0x0 },
-	{ 0x54028, 0x0 },
-	{ 0x54029, 0x0 },
-	{ 0x5402a, 0x0 },
-	{ 0x5402b, 0x1000 },
-	{ 0x5402c, LPDDR4_CS },
-	{ 0x5402d, 0x0 },
-	{ 0x5402e, 0x0 },
-	{ 0x5402f, 0x0 },
-	{ 0x54030, 0x0 },
-	{ 0x54031, 0x0 },
-	{ 0x54032, 0xd400 },
-	{ 0x54033, (LPDDR4_MR3 << 8) | (0x312d & 0xff) },
-	{ 0x54034, 0x6600 },
-	{ 0x54035, 0x84d },
-	{ 0x54036, 0x4d },
-	{ 0x54037, (LPDDR4_MR22_RANK0 << 8)/*0x1600*/ },
-	{ 0x54038, 0xd400 },
-	{ 0x54039, (LPDDR4_MR3 << 8) | (0x312d & 0xff) },
-	{ 0x5403a, 0x6600 },
-	{ 0x5403b, 0x84d },
-	{ 0x5403c, 0x4d },
-	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8)/*0x1600*/ },
-	{ 0x5403e, 0x0 },
-	{ 0x5403f, 0x0 },
-	{ 0x54040, 0x0 },
-	{ 0x54041, 0x0 },
-	{ 0x54042, 0x0 },
-	{ 0x54043, 0x0 },
-	{ 0x54044, 0x0 },
-	{ 0xd0000, 0x1 },
-};
-
-/* P1 message block paremeter for training firmware */
-struct dram_cfg_param lpddr4_fsp1_cfg[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x54000, 0x0 },
-	{ 0x54001, 0x0 },
-	{ 0x54002, 0x101 },
-	{ 0x54003, 0x190 },
-	{ 0x54004, 0x2 },
-	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },/* PHY Ron/Rtt */
-	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
-	{ 0x54007, 0x0 },
-	{ 0x54008, 0x121f },
-	{ 0x54009, 0xc8 },
-	{ 0x5400a, 0x0 },
-	{ 0x5400b, 0x2 },
-	{ 0x5400c, 0x0 },
-	{ 0x5400d, 0x0 },
-	{ 0x5400e, 0x0 },
-	{ 0x5400f, 0x0 },
-	{ 0x54010, 0x0 },
-	{ 0x54011, 0x0 },
-	{ 0x54012, (LPDDR4_CS << 8) | (0x110 & 0xff) },
-	{ 0x54013, 0x0 },
-	{ 0x54014, 0x0 },
-	{ 0x54015, 0x0 },
-	{ 0x54016, 0x0 },
-	{ 0x54017, 0x0 },
-	{ 0x54018, 0x0 },
-	{ 0x54019, 0x84 },
-	{ 0x5401a, (0x31 & 0xff00) | LPDDR4_MR3 },
-	{ 0x5401b, 0x4d66 },
-	{ 0x5401c, 0x4d08 },
-	{ 0x5401d, 0x0 },
-	{ 0x5401e, LPDDR4_MR22_RANK0/*0x16*/ },
-	{ 0x5401f, 0x84 },
-	{ 0x54020, (0x31 & 0xff00) | LPDDR4_MR3 },
-	{ 0x54021, 0x4d66 },
-	{ 0x54022, 0x4d08 },
-	{ 0x54023, 0x0 },
-	{ 0x54024, LPDDR4_MR22_RANK1/*0x16*/ },
-	{ 0x54025, 0x0 },
-	{ 0x54026, 0x0 },
-	{ 0x54027, 0x0 },
-	{ 0x54028, 0x0 },
-	{ 0x54029, 0x0 },
-	{ 0x5402a, 0x0 },
-	{ 0x5402b, 0x1000 },
-	{ 0x5402c, LPDDR4_CS },
-	{ 0x5402d, 0x0 },
-	{ 0x5402e, 0x0 },
-	{ 0x5402f, 0x0 },
-	{ 0x54030, 0x0 },
-	{ 0x54031, 0x0 },
-	{ 0x54032, 0x8400 },
-	{ 0x54033, (LPDDR4_MR3 << 8) | (0x3100 & 0xff) },
-	{ 0x54034, 0x6600 },
-	{ 0x54035, 0x84d },
-	{ 0x54036, 0x4d },
-	{ 0x54037, (LPDDR4_MR22_RANK0 << 8)/*0x1600*/ },
-	{ 0x54038, 0x8400 },
-	{ 0x54039, (LPDDR4_MR3 << 8) | (0x3100 & 0xff) },
-	{ 0x5403a, 0x6600 },
-	{ 0x5403b, 0x84d },
-	{ 0x5403c, 0x4d },
-	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8)/*0x1600*/ },
-	{ 0x5403e, 0x0 },
-	{ 0x5403f, 0x0 },
-	{ 0x54040, 0x0 },
-	{ 0x54041, 0x0 },
-	{ 0x54042, 0x0 },
-	{ 0x54043, 0x0 },
-	{ 0x54044, 0x0 },
-	{ 0xd0000, 0x1 },
-};
-
-/* P1 message block paremeter for training firmware */
-struct dram_cfg_param lpddr4_fsp2_cfg[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x54000, 0x0 },
-	{ 0x54001, 0x0 },
-	{ 0x54002, 0x102 },
-	{ 0x54003, 0x64 },
-	{ 0x54004, 0x2 },
-	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },//PHY Ron/Rtt
-	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
-	{ 0x54007, 0x0 },
-	{ 0x54008, 0x121f },
-	{ 0x54009, 0xc8 },
-	{ 0x5400a, 0x0 },
-	{ 0x5400b, 0x2 },
-	{ 0x5400c, 0x0 },
-	{ 0x5400d, 0x0 },
-	{ 0x5400e, 0x0 },
-	{ 0x5400f, 0x0 },
-	{ 0x54010, 0x0 },
-	{ 0x54011, 0x0 },
-	{ 0x54012, (LPDDR4_CS << 8) | (0x110 & 0xff) },
-	{ 0x54013, 0x0 },
-	{ 0x54014, 0x0 },
-	{ 0x54015, 0x0 },
-	{ 0x54016, 0x0 },
-	{ 0x54017, 0x0 },
-	{ 0x54018, 0x0 },
-	{ 0x54019, 0x84 },
-	{ 0x5401a, (0x31 & 0xff00) | LPDDR4_MR3 },
-	{ 0x5401b, 0x4d66 },
-	{ 0x5401c, 0x4d08 },
-	{ 0x5401d, 0x0 },
-	{ 0x5401e, LPDDR4_MR22_RANK0/*0x16*/ },
-	{ 0x5401f, 0x84 },
-	{ 0x54020, (0x31 & 0xff00) | LPDDR4_MR3 },
-	{ 0x54021, 0x4d66 },
-	{ 0x54022, 0x4d08 },
-	{ 0x54023, 0x0 },
-	{ 0x54024, LPDDR4_MR22_RANK1/*0x16*/ },
-	{ 0x54025, 0x0 },
-	{ 0x54026, 0x0 },
-	{ 0x54027, 0x0 },
-	{ 0x54028, 0x0 },
-	{ 0x54029, 0x0 },
-	{ 0x5402a, 0x0 },
-	{ 0x5402b, 0x1000 },
-	{ 0x5402c, LPDDR4_CS },
-	{ 0x5402d, 0x0 },
-	{ 0x5402e, 0x0 },
-	{ 0x5402f, 0x0 },
-	{ 0x54030, 0x0 },
-	{ 0x54031, 0x0 },
-	{ 0x54032, 0x8400 },
-	{ 0x54033, (LPDDR4_MR3 << 8) | (0x3100 & 0xff) },
-	{ 0x54034, 0x6600 },
-	{ 0x54035, 0x84d },
-	{ 0x54036, 0x4d },
-	{ 0x54037, (LPDDR4_MR22_RANK0 << 8)/*0x1600*/ },
-	{ 0x54038, 0x8400 },
-	{ 0x54039, (LPDDR4_MR3 << 8) | (0x3100 & 0xff) },
-	{ 0x5403a, 0x6600 },
-	{ 0x5403b, 0x84d },
-	{ 0x5403c, 0x4d },
-	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8)/*0x1600*/ },
-	{ 0x5403e, 0x0 },
-	{ 0x5403f, 0x0 },
-	{ 0x54040, 0x0 },
-	{ 0x54041, 0x0 },
-	{ 0x54042, 0x0 },
-	{ 0x54043, 0x0 },
-	{ 0x54044, 0x0 },
-	{ 0xd0000, 0x1 },
-};
-
-/* P0 2D message block paremeter for training firmware */
-struct dram_cfg_param lpddr4_fsp0_2d_cfg[] = {
-	{ 0xd0000, 0x0 },
-	{ 0x54000, 0x0 },
-	{ 0x54001, 0x0 },
-	{ 0x54002, 0x0 },
-	{ 0x54003, 0xbb8 },
-	{ 0x54004, 0x2 },
-	{ 0x54005, ((LPDDR4_PHY_RON << 8) | LPDDR4_PHY_RTT) },//PHY Ron/Rtt
-	{ 0x54006, LPDDR4_PHY_VREF_VALUE },
-	{ 0x54007, 0x0 },
-	{ 0x54008, 0x61 },
-	{ 0x54009, 0xc8 },
-	{ 0x5400a, 0x0 },
-	{ 0x5400b, 0x2 },
-	{ 0x5400c, 0x0 },
-	{ 0x5400d, 0x0 },
-	{ 0x5400e, 0x0 },
-	{ 0x5400f, 0x100 },
-	{ 0x54010, 0x1f7f },
-	{ 0x54011, 0x0 },
-	{ 0x54012, (LPDDR4_CS << 8) | (0x110 & 0xff) },
-	{ 0x54013, 0x0 },
-	{ 0x54014, 0x0 },
-	{ 0x54015, 0x0 },
-	{ 0x54016, 0x0 },
-	{ 0x54017, 0x0 },
-	{ 0x54018, 0x0 },
-	{ 0x54019, 0x2dd4 },
-	{ 0x5401a, (0x31 & 0xff00) | LPDDR4_MR3 },
-	{ 0x5401b, 0x4d66 },
-	{ 0x5401c, 0x4d08 },
-	{ 0x5401d, 0x0 },
-	{ 0x5401e, LPDDR4_MR22_RANK0/*0x16*/ },
-	{ 0x5401f, 0x2dd4 },
-	{ 0x54020, (0x31 & 0xff00) | LPDDR4_MR3 },
-	{ 0x54021, 0x4d66 },
-	{ 0x54022, 0x4d08 },
-	{ 0x54023, 0x0 },
-	{ 0x54024, LPDDR4_MR22_RANK1/*0x16*/ },
-	{ 0x54025, 0x0 },
-	{ 0x54026, 0x0 },
-	{ 0x54027, 0x0 },
-	{ 0x54028, 0x0 },
-	{ 0x54029, 0x0 },
-	{ 0x5402a, 0x0 },
-	{ 0x5402b, 0x1000 },
-	{ 0x5402c, LPDDR4_CS },
-	{ 0x5402d, 0x0 },
-	{ 0x5402e, 0x0 },
-	{ 0x5402f, 0x0 },
-	{ 0x54030, 0x0 },
-	{ 0x54031, 0x0 },
-	{ 0x54032, 0xd400 },
-	{ 0x54033, (LPDDR4_MR3 << 8) | (0x312d & 0xff) },
-	{ 0x54034, 0x6600 },
-	{ 0x54035, 0x84d },
-	{ 0x54036, 0x4d },
-	{ 0x54037, (LPDDR4_MR22_RANK0 << 8)/*0x1600*/ },
-	{ 0x54038, 0xd400 },
-	{ 0x54039, (LPDDR4_MR3 << 8) | (0x312d & 0xff) },
-	{ 0x5403a, 0x6600 },
-	{ 0x5403b, 0x84d },
-	{ 0x5403c, 0x4d },
-	{ 0x5403d, (LPDDR4_MR22_RANK1 << 8)/*0x1600*/ },
-	{ 0x5403e, 0x0 },
-	{ 0x5403f, 0x0 },
-	{ 0x54040, 0x0 },
-	{ 0x54041, 0x0 },
-	{ 0x54042, 0x0 },
-	{ 0x54043, 0x0 },
-	{ 0x54044, 0x0 },
-	{ 0xd0000, 0x1 },
-};
-
-/* DRAM PHY init engine image */
-struct dram_cfg_param lpddr4_phy_pie[] = {
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
-	{ 0x90038, 0xf },
-	{ 0x90039, 0x7c0 },
-	{ 0x9003a, 0x139 },
-	{ 0x9003b, 0x44 },
-	{ 0x9003c, 0x630 },
-	{ 0x9003d, 0x159 },
-	{ 0x9003e, 0x14f },
-	{ 0x9003f, 0x630 },
-	{ 0x90040, 0x159 },
-	{ 0x90041, 0x47 },
-	{ 0x90042, 0x630 },
-	{ 0x90043, 0x149 },
-	{ 0x90044, 0x4f },
-	{ 0x90045, 0x630 },
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
-	{ 0x90057, 0x630 },
-	{ 0x90058, 0x179 },
-	{ 0x90059, 0x1 },
-	{ 0x9005a, 0x618 },
-	{ 0x9005b, 0x109 },
-	{ 0x9005c, 0x40c0 },
-	{ 0x9005d, 0x630 },
-	{ 0x9005e, 0x149 },
-	{ 0x9005f, 0x8 },
-	{ 0x90060, 0x4 },
-	{ 0x90061, 0x48 },
-	{ 0x90062, 0x4040 },
-	{ 0x90063, 0x630 },
-	{ 0x90064, 0x149 },
-	{ 0x90065, 0x0 },
-	{ 0x90066, 0x4 },
-	{ 0x90067, 0x48 },
-	{ 0x90068, 0x40 },
-	{ 0x90069, 0x630 },
-	{ 0x9006a, 0x149 },
-	{ 0x9006b, 0x10 },
-	{ 0x9006c, 0x4 },
-	{ 0x9006d, 0x18 },
-	{ 0x9006e, 0x0 },
-	{ 0x9006f, 0x4 },
-	{ 0x90070, 0x78 },
-	{ 0x90071, 0x549 },
-	{ 0x90072, 0x630 },
-	{ 0x90073, 0x159 },
-	{ 0x90074, 0xd49 },
-	{ 0x90075, 0x630 },
-	{ 0x90076, 0x159 },
-	{ 0x90077, 0x94a },
-	{ 0x90078, 0x630 },
-	{ 0x90079, 0x159 },
-	{ 0x9007a, 0x441 },
-	{ 0x9007b, 0x630 },
-	{ 0x9007c, 0x149 },
-	{ 0x9007d, 0x42 },
-	{ 0x9007e, 0x630 },
-	{ 0x9007f, 0x149 },
-	{ 0x90080, 0x1 },
-	{ 0x90081, 0x630 },
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
-	{ 0x9009b, 0xa },
-	{ 0x9009c, 0x10 },
-	{ 0x9009d, 0x109 },
-	{ 0x9009e, 0x2 },
-	{ 0x9009f, 0x10 },
-	{ 0x900a0, 0x109 },
-	{ 0x900a1, 0x5 },
-	{ 0x900a2, 0x7c0 },
-	{ 0x900a3, 0x109 },
-	{ 0x900a4, 0x10 },
-	{ 0x900a5, 0x10 },
-	{ 0x900a6, 0x109 },
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
-	{ 0x4000b, 0x623 },
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
-	{ 0x4000e, 0x623 },
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
-	{ 0x900a7, 0x0 },
-	{ 0x900a8, 0x790 },
-	{ 0x900a9, 0x11a },
-	{ 0x900aa, 0x8 },
-	{ 0x900ab, 0x7aa },
-	{ 0x900ac, 0x2a },
-	{ 0x900ad, 0x10 },
-	{ 0x900ae, 0x7b2 },
-	{ 0x900af, 0x2a },
-	{ 0x900b0, 0x0 },
-	{ 0x900b1, 0x7c8 },
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
-	{ 0x90113, 0x0 },
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
-	{ 0x90146, 0xc },
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
-	{ 0x90158, 0x0 },
-	{ 0x90159, 0x400 },
-	{ 0x9015a, 0x10e },
-	{ 0x9015b, 0x8 },
-	{ 0x9015c, 0xe8 },
-	{ 0x9015d, 0x109 },
-	{ 0x9015e, 0x0 },
-	{ 0x9015f, 0x8140 },
-	{ 0x90160, 0x10c },
-	{ 0x90161, 0x10 },
-	{ 0x90162, 0x8138 },
-	{ 0x90163, 0x10c },
-	{ 0x90164, 0x8 },
-	{ 0x90165, 0x7c8 },
-	{ 0x90166, 0x101 },
-	{ 0x90167, 0x8 },
-	{ 0x90168, 0x0 },
-	{ 0x90169, 0x8 },
-	{ 0x9016a, 0x8 },
-	{ 0x9016b, 0x448 },
-	{ 0x9016c, 0x109 },
-	{ 0x9016d, 0xf },
-	{ 0x9016e, 0x7c0 },
-	{ 0x9016f, 0x109 },
-	{ 0x90170, 0x0 },
-	{ 0x90171, 0xe8 },
-	{ 0x90172, 0x109 },
-	{ 0x90173, 0x47 },
-	{ 0x90174, 0x630 },
-	{ 0x90175, 0x109 },
-	{ 0x90176, 0x8 },
-	{ 0x90177, 0x618 },
-	{ 0x90178, 0x109 },
-	{ 0x90179, 0x8 },
-	{ 0x9017a, 0xe0 },
-	{ 0x9017b, 0x109 },
-	{ 0x9017c, 0x0 },
-	{ 0x9017d, 0x7c8 },
-	{ 0x9017e, 0x109 },
-	{ 0x9017f, 0x8 },
-	{ 0x90180, 0x8140 },
-	{ 0x90181, 0x10c },
-	{ 0x90182, 0x0 },
-	{ 0x90183, 0x1 },
-	{ 0x90184, 0x8 },
-	{ 0x90185, 0x8 },
-	{ 0x90186, 0x4 },
-	{ 0x90187, 0x8 },
-	{ 0x90188, 0x8 },
-	{ 0x90189, 0x7c8 },
-	{ 0x9018a, 0x101 },
-	{ 0x90006, 0x0 },
-	{ 0x90007, 0x0 },
-	{ 0x90008, 0x8 },
-	{ 0x90009, 0x0 },
-	{ 0x9000a, 0x0 },
-	{ 0x9000b, 0x0 },
-	{ 0xd00e7, 0x400 },
-	{ 0x90017, 0x0 },
-	{ 0x9001f, 0x2a },
-	{ 0x90026, 0x6a },
-	{ 0x400d0, 0x0 },
-	{ 0x400d1, 0x101 },
-	{ 0x400d2, 0x105 },
-	{ 0x400d3, 0x107 },
-	{ 0x400d4, 0x10f },
-	{ 0x400d5, 0x202 },
-	{ 0x400d6, 0x20a },
-	{ 0x400d7, 0x20b },
-	{ 0x2003a, 0x2 },
-	{ 0x2000b, 0x5d },
-	{ 0x2000c, 0xbb },
-	{ 0x2000d, 0x753 },
-	{ 0x2000e, 0x2c },
-	{ 0x12000b, 0xc },
-	{ 0x12000c, 0x19 },
-	{ 0x12000d, 0xfa },
-	{ 0x12000e, 0x10 },
-	{ 0x22000b, 0x3 },
-	{ 0x22000c, 0x6 },
-	{ 0x22000d, 0x3e },
-	{ 0x22000e, 0x10 },
-	{ 0x9000c, 0x0 },
-	{ 0x9000d, 0x173 },
-	{ 0x9000e, 0x60 },
-	{ 0x9000f, 0x6110 },
-	{ 0x90010, 0x2152 },
-	{ 0x90011, 0xdfbd },
-	{ 0x90012, 0x60 },
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
-	{ 0x2003a, 0x2 },
-	{ 0xc0080, 0x2 },
-	{ 0xd0000, 0x1 },
-};
-
-struct dram_fsp_msg lpddr4_dram_fsp_msg[] = {
-	{
-		/* P0 3000mts 1D */
-		.drate = 3000,
-		.fw_type = FW_1D_IMAGE,
-		.fsp_cfg = lpddr4_fsp0_cfg,
-		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp0_cfg),
-	},
-	{
-		/* P0 3000mts 2D */
-		.drate = 3000,
-		.fw_type = FW_2D_IMAGE,
-		.fsp_cfg = lpddr4_fsp0_2d_cfg,
-		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp0_2d_cfg),
-	},
-	{
-		/* P1 400mts 1D */
-		.drate = 400,
-		.fw_type = FW_1D_IMAGE,
-		.fsp_cfg = lpddr4_fsp1_cfg,
-		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp1_cfg),
-	},
-	{
-		/* P1 100mts 1D */
-		.drate = 100,
-		.fw_type = FW_1D_IMAGE,
-		.fsp_cfg = lpddr4_fsp2_cfg,
-		.fsp_cfg_num = ARRAY_SIZE(lpddr4_fsp2_cfg),
-	},
-};
-
-/* lpddr4 timing config params on EVK board */
-struct dram_timing_info dram_timing = {
-	.ddrc_cfg = lpddr4_ddrc_cfg,
-	.ddrc_cfg_num = ARRAY_SIZE(lpddr4_ddrc_cfg),
-	.ddrphy_cfg = lpddr4_ddrphy_cfg,
-	.ddrphy_cfg_num = ARRAY_SIZE(lpddr4_ddrphy_cfg),
-	.fsp_msg = lpddr4_dram_fsp_msg,
-	.fsp_msg_num = ARRAY_SIZE(lpddr4_dram_fsp_msg),
-	.ddrphy_trained_csr = lpddr4_ddrphy_trained_csr,
-	.ddrphy_trained_csr_num = ARRAY_SIZE(lpddr4_ddrphy_trained_csr),
-	.ddrphy_pie = lpddr4_phy_pie,
-	.ddrphy_pie_num = ARRAY_SIZE(lpddr4_phy_pie),
-};
diff --git a/board/beacon/imx8mm/spl.c b/board/beacon/imx8mm/spl.c
deleted file mode 100644
index 1e5935788ff..00000000000
--- a/board/beacon/imx8mm/spl.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <cpu_func.h>
-#include <hang.h>
-#include <init.h>
-#include <log.h>
-#include <spl.h>
-#include <asm/io.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/imx8mm_pins.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/boot_mode.h>
-#include <asm/arch/ddr.h>
-#include <asm/sections.h>
-
-#include <dm/uclass.h>
-#include <dm/device.h>
-#include <dm/uclass-internal.h>
-#include <dm/device-internal.h>
-
-#include <power/pmic.h>
-#include <power/bd71837.h>
-
-int spl_board_boot_device(enum boot_device boot_dev_spl)
-{
-	switch (boot_dev_spl) {
-	case SD2_BOOT:
-	case MMC2_BOOT:
-		return BOOT_DEVICE_MMC1;
-	case SD3_BOOT:
-	case MMC3_BOOT:
-		return BOOT_DEVICE_MMC2;
-	case USB_BOOT:
-		return BOOT_DEVICE_BOARD;
-	case QSPI_BOOT:
-		return BOOT_DEVICE_NOR;
-	default:
-		return BOOT_DEVICE_NONE;
-	}
-}
-
-static void spl_dram_init(void)
-{
-	ddr_init(&dram_timing);
-}
-
-void spl_board_init(void)
-{
-	arch_misc_init();
-}
-
-#ifdef CONFIG_SPL_LOAD_FIT
-int board_fit_config_name_match(const char *name)
-{
-	/* Just empty function now - can't decide what to choose */
-	debug("%s: %s\n", __func__, name);
-
-	return 0;
-}
-#endif
-
-static int power_init_board(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = pmic_get("pmic@4b", &dev);
-	if (ret == -ENODEV) {
-		puts("No pmic\n");
-		return 0;
-	}
-	if (ret != 0)
-		return ret;
-
-	/* decrease RESET key long push time from the default 10s to 10ms */
-	pmic_reg_write(dev, BD718XX_PWRONCONFIG1, 0x0);
-
-	/* unlock the PMIC regs */
-	pmic_reg_write(dev, BD718XX_REGLOCK, 0x1);
-
-	/* increase VDD_SOC to typical value 0.85v before first DRAM access */
-	pmic_reg_write(dev, BD718XX_BUCK1_VOLT_RUN, 0x0f);
-
-	/* increase VDD_DRAM to 0.975v for 3Ghz DDR */
-	pmic_reg_write(dev, BD718XX_1ST_NODVS_BUCK_VOLT, 0x83);
-
-	/* lock the PMIC regs */
-	pmic_reg_write(dev, BD718XX_REGLOCK, 0x11);
-
-	return 0;
-}
-
-void board_init_f(ulong dummy)
-{
-	struct udevice *dev;
-	int ret;
-
-	arch_cpu_init();
-	timer_init();
-
-	/* Clear the BSS. */
-	memset(__bss_start, 0, __bss_end - __bss_start);
-
-	ret = spl_early_init();
-	if (ret) {
-		debug("spl_early_init() failed: %d\n", ret);
-		hang();
-	}
-
-	ret = uclass_get_device_by_name(UCLASS_CLK,
-					"clock-controller@30380000",
-					&dev);
-	if (ret < 0) {
-		printf("Failed to find clock node. Check device tree\n");
-		hang();
-	}
-
-	preloader_console_init();
-	enable_tzc380();
-
-	power_init_board();
-
-	/* DDR initialization */
-	spl_dram_init();
-
-	board_init_r(NULL, 0);
-}
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
deleted file mode 100644
index 32339e7f6e2..00000000000
--- a/configs/imx8mm_beacon_defconfig
+++ /dev/null
@@ -1,151 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX8M=y
-CONFIG_TEXT_BASE=0x40200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_ENV_SOURCE_FILE="imx8mm_beacon"
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xFFFFDE00
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-beacon-kit"
-CONFIG_TARGET_IMX8MM_BEACON=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x920000
-CONFIG_SPL_TEXT_BASE=0x7E1000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x910000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SYS_LOAD_ADDR=0x40480000
-CONFIG_SPL=y
-CONFIG_IMX_BOOTAUX=y
-CONFIG_FIT=y
-CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; fi;"
-CONFIG_DEFAULT_FDT_FILE="imx8mm-beacon-kit.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-# CONFIG_BOARD_INIT is not set
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
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="u-boot=> "
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
-# CONFIG_CMD_CRC32 is not set
-CONFIG_CMD_CLK=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_SDP=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_PMIC=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM=y
-CONFIG_SPL_CLK_COMPOSITE_CCF=y
-CONFIG_CLK_COMPOSITE_CCF=y
-CONFIG_SPL_CLK_IMX8MM=y
-CONFIG_CLK_IMX8MM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x42800000
-CONFIG_FASTBOOT_BUF_SIZE=0x20000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=2
-CONFIG_MXC_GPIO=y
-CONFIG_DM_PCA953X=y
-CONFIG_DM_I2C=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_BAR=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_MTD=y
-CONFIG_PHY_GIGE=y
-CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_SPL_PHY=y
-CONFIG_SPL_NOP_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX8M=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
-CONFIG_DM_PMIC_BD71837=y
-CONFIG_SPL_DM_PMIC_BD71837=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_BD71837=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SERIAL=y
-CONFIG_MXC_UART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_NXP_FSPI=y
-CONFIG_SYSRESET=y
-CONFIG_SPL_SYSRESET=y
-CONFIG_SYSRESET_PSCI=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_USB=y
-CONFIG_SPL_USB_HOST=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_MXC_USB_OTG_HACTIVE=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_CI_UDC=y
-CONFIG_SDP_LOADADDR=0x40400000
-CONFIG_SPL_USB_SDP_SUPPORT=y
-# CONFIG_WATCHDOG_AUTOSTART is not set
-CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
deleted file mode 100644
index 8c66fad7390..00000000000
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ /dev/null
@@ -1,152 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX8M=y
-CONFIG_TEXT_BASE=0x40200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SF_DEFAULT_SPEED=40000000
-CONFIG_SF_DEFAULT_MODE=0
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xFFFFDE00
-CONFIG_IMX_CONFIG="board/nxp/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg"
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-beacon-kit"
-CONFIG_TARGET_IMX8MM_BEACON=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x920000
-CONFIG_SPL_TEXT_BASE=0x7E2000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x910000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SYS_LOAD_ADDR=0x40480000
-CONFIG_SPL=y
-CONFIG_FIT=y
-CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; fi;"
-CONFIG_DEFAULT_FDT_FILE="imx8mm-beacon-kit.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-# CONFIG_BOARD_INIT is not set
-CONFIG_SPL_MAX_SIZE=0x25000
-CONFIG_SPL_PAD_TO=0x0
-CONFIG_SPL_BOARD_INIT=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
-CONFIG_SPL_I2C=y
-CONFIG_SPL_NOR_SUPPORT=y
-CONFIG_SPL_POWER=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="u-boot=> "
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
-# CONFIG_CMD_CRC32 is not set
-CONFIG_CMD_CLK=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_SDP=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_PMIC=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM=y
-CONFIG_SPL_CLK_COMPOSITE_CCF=y
-CONFIG_CLK_COMPOSITE_CCF=y
-CONFIG_SPL_CLK_IMX8MM=y
-CONFIG_CLK_IMX8MM=y
-CONFIG_MXC_GPIO=y
-CONFIG_DM_PCA953X=y
-CONFIG_DM_I2C=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_BAR=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_MTD=y
-CONFIG_PHY_GIGE=y
-CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_SPL_PHY=y
-CONFIG_SPL_NOP_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX8M=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
-CONFIG_DM_PMIC_BD71837=y
-CONFIG_SPL_DM_PMIC_BD71837=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_BD71837=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SERIAL=y
-CONFIG_MXC_UART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_NXP_FSPI=y
-CONFIG_SYSRESET=y
-CONFIG_SPL_SYSRESET=y
-CONFIG_SYSRESET_PSCI=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_USB=y
-CONFIG_SPL_USB_HOST=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_MXC_USB_OTG_HACTIVE=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_CI_UDC=y
-CONFIG_SDP_LOADADDR=0x40400000
-CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_SPL_USB_SDP_SUPPORT=y
-CONFIG_IMX_WATCHDOG=y
-CONFIG_SPL_CRC32=y
-CONFIG_FSPI_CONF_HEADER=y
-CONFIG_FSPI_CONF_FILE="fspi_header.bin"
diff --git a/doc/board/beacon/beacon-imx8mm.rst b/doc/board/beacon/beacon-imx8mm.rst
deleted file mode 100644
index 8bf983bff77..00000000000
--- a/doc/board/beacon/beacon-imx8mm.rst
+++ /dev/null
@@ -1,55 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-U-Boot for the Beacon EmbeddedWorks i.MX8M Mini Devkit
-======================================================
-
-Quick Start
------------
-
-- Build the ARM Trusted firmware binary
-- Get DDR firmware
-- Build U-Boot
-- Burn U-Boot to microSD Card
-- Boot
-
-Get and Build the ARM Trusted firmware
---------------------------------------
-
-.. code-block:: bash
-
-    $ git clone https://github.com/nxp-imx/imx-atf.git -b v2.6
-    $ make PLAT=imx8mm bl31 CROSS_COMPILE=aarch64-linux-gnu-
-    $ cp build/imx8mm/release/bl31.bin ../
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
-    $ make imx8mm_beacon_defconfig
-    $ make CROSS_COMPILE=aarch64-linux-gnu-
-
-Burn U-Boot to microSD Card
----------------------------
-
-.. code-block:: bash
-
-    $ sudo dd if=flash.bin of=/dev/sd[x] bs=1024 seek=33
-
-Boot
-----
-
-Set baseboard DIP switches for micoSD Card:
-- S11 (1:8) 01101000
-- S10 (1:8) 11001000
-- S17 (1:8) 0110xxxx
diff --git a/doc/board/beacon/index.rst b/doc/board/beacon/index.rst
index bf62b09fbad..3b99e76f6d5 100644
--- a/doc/board/beacon/index.rst
+++ b/doc/board/beacon/index.rst
@@ -7,5 +7,4 @@ Beacon
    :maxdepth: 2
 
    beacon-imx8mp
-   beacon-imx8mm
    beacon-imx8mn
diff --git a/include/configs/imx8mm_beacon.h b/include/configs/imx8mm_beacon.h
deleted file mode 100644
index 2ec7f3d8b6f..00000000000
--- a/include/configs/imx8mm_beacon.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2020 Compass Electronics Group, LLC
- */
-
-#ifndef __IMX8MM_BEACON_H
-#define __IMX8MM_BEACON_H
-
-#include <linux/sizes.h>
-#include <asm/arch/imx-regs.h>
-
-#define UBOOT_ITB_OFFSET			0x57C00
-#define FSPI_CONF_BLOCK_SIZE		0x1000
-#define UBOOT_ITB_OFFSET_FSPI  \
-	(UBOOT_ITB_OFFSET + FSPI_CONF_BLOCK_SIZE)
-#ifdef CONFIG_FSPI_CONF_HEADER
-#define CFG_SYS_UBOOT_BASE  \
-	(QSPI0_AMBA_BASE + UBOOT_ITB_OFFSET_FSPI)
-#else
-#define CFG_SYS_UBOOT_BASE	\
-	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
-#endif
-
-#ifdef CONFIG_XPL_BUILD
-/* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
-#define CFG_MALLOC_F_ADDR		0x930000
-/* For RAW image gives a error info not panic */
-
-#endif
-
-/* Link Definitions */
-
-#define CFG_SYS_INIT_RAM_ADDR        0x40000000
-#define CFG_SYS_INIT_RAM_SIZE        0x200000
-
-#define CFG_SYS_SDRAM_BASE		0x40000000
-#define PHYS_SDRAM			0x40000000
-#define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
-
-#endif
-- 
2.53.0

