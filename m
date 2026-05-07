Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA46CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 20:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0741384BBE;
	Thu,  7 May 2026 22:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="SK3k7L29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BF384BD4; Thu,  7 May 2026 22:18:26 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9FC284BB7
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 22:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e4f8d4e3-4a51-11f1-89ea-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e4f8d4e3-4a51-11f1-89ea-00505699b430;
 Thu, 07 May 2026 22:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=51JlgF9kb3cHYAy1WBMUT3SsqXMidJIuMBP61VZxks8=;
 b=SK3k7L29NeZCOnP6S2Xf+lEZby1jR9sJWCTrOKbSNoYnj7cJVAfQjvUcPWerIoFw2PvT7IQoAHeLz
 snPc4I/If/jyAnN26PkEBcQcnjtfUFW7pS89D2avnlaJafq6JpWE0ysTKE7HU+gdPR2Zxr4U+KibfT
 Zq5eqK+DLkUn21NO2KmSqnXyG1n4qQXMoLeyG04Ud1y+IZoj9ifp1hecgZo8nssopV7pvhp1hFcVzD
 9ecHgAGDPmxTZxvsojJtcvt55UGCPyFRG/cE10zJmwPVHF6hE83pzOKDjLBxqCQTeAGL339m6fHiUV
 lh+zA6x24fpCfvbEWvU49mYP0IFEMJQ==
X-KPN-MID: 33|HBjFLBCPWiKue3yIBPwznpGaNTfmhPueZ3vMqcIs9K9U6eLXnZCXzY+D59SZTZW
 W8I/WLN62IWPYyuiNQmiFNABAb417dGRS6Mva309TLsY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|lOZmSI2tLUplpoRQSBYPqC4yn1j6jF2PhmX+uU41ppwTP7xZ5ZERFhycCW6Lykw
 OlDj8r/V5p/9HvlstKpkmWg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e48f83bc-4a51-11f1-abaf-00505699b758;
 Thu, 07 May 2026 22:18:21 +0200 (CEST)
Date: Thu, 07 May 2026 22:18:21 +0200
Message-Id: <87pl37as8i.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, trini@konsulko.com, kettenis@openbsd.org,
 j@jannau.net
In-Reply-To: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
 (message from Janne Grunau on Thu, 07 May 2026 10:05:48 +0200)
Subject: Re: [PATCH v2 0/3] Switch Apple silicon boards to upstream device
 trees
References: <20260507-apple-dt-upstream-v2-0-35181f2b0509@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Thu, 07 May 2026 10:05:48 +0200
> 
> The Linux device trees for Apple silicon devices cover now most of the
> hardware as u-boot's internal device trees for M1 devices. Linux has in
> addition device trees M2 and M1 and M2 Pro/Max/Ultra devices which were
> never added in u-boot.
> The most common use case for u-boot on Apple silicon devices does not
> use DTBs from u-boot but passes runtime modified device trees from an
> earlier boot loader (m1n1).
> This change regresses support for the SPI on M1 and M1 Pro/Max notebooks
> as SPI keyboard support is not in upstream Linux. This regression is in
> my opinion acceptable due to the limited use of u-boot's DTBs for these
> targets.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - Add CONFIG_OF_UPSTREAM_BUILD_VENDOR=y and
>   CONFIG_OF_UPSTREAM_VENDOR="apple" to build all apple DTBs

Ooh, that's even better.

> - rebased onto v2026.07-rc1 for Linux v7.0 based DTs in dts/upstream
> - Link to v1: https://patch.msgid.link/20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net

Still:

Acked-by: Mark Kettenis <kettenis@openbsd.org>

for the series.

> ---
> Janne Grunau (3):
>       doc: board: apple: Mention M2 and M2 Pro/Max/Ultra SoCs
>       doc: device-tree-bindings: Remove apple,pinctrl.yaml
>       arm: dts: Switch Apple silicon devices to dts/upstream
> 
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/dts/Makefile                              |    7 -
>  arch/arm/dts/t8103-j274-u-boot.dtsi                |    1 -
>  arch/arm/dts/t8103-j274.dts                        |  129 ---
>  arch/arm/dts/t8103-j293-u-boot.dtsi                |    1 -
>  arch/arm/dts/t8103-j293.dts                        |  116 --
>  arch/arm/dts/t8103-j313-u-boot.dtsi                |    1 -
>  arch/arm/dts/t8103-j313.dts                        |  111 --
>  arch/arm/dts/t8103-j456-u-boot.dtsi                |    1 -
>  arch/arm/dts/t8103-j456.dts                        |  117 --
>  arch/arm/dts/t8103-j457-u-boot.dtsi                |    1 -
>  arch/arm/dts/t8103-j457.dts                        |  105 --
>  arch/arm/dts/t8103-jxxx.dtsi                       |  143 ---
>  arch/arm/dts/t8103-pmgr.dtsi                       | 1138 --------------------
>  arch/arm/dts/t8103-u-boot.dtsi                     |   25 -
>  arch/arm/dts/t8103.dtsi                            |  696 ------------
>  configs/apple_m1_defconfig                         |    4 +-
>  doc/board/apple/m1.rst                             |   15 +-
>  .../pinctrl/apple,pinctrl.yaml                     |  106 --
>  19 files changed, 13 insertions(+), 2705 deletions(-)
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260109-apple-dt-upstream-6daf03510fec
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
