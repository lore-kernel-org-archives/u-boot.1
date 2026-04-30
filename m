Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEAFCD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419B8845E9;
	Fri,  1 May 2026 00:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="vKzTHc3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE387845E3; Fri,  1 May 2026 00:00:37 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF42C845C8
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 03ebeeae-44e0-11f1-8ff3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 03ebeeae-44e0-11f1-8ff3-005056999439;
 Fri, 01 May 2026 00:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=CvWERdNVs8CQN3AAXyGLcx26hJ4j6ECW3s60P1XKp/Q=;
 b=vKzTHc3K3j7tPMzR1wO0BlfliGfUCtLEQuMj7yLvozt/XHedzF99so+g5WdZpXHrQ6YE6TMaPN+U5
 7gitEqlMsTiSt1JjdmcHCzMTMA/NlRPRpD9Doh1eIs4XC+qfmHUVPvFNdXcE4TN+NRw5L87uXU7gyo
 PzBt4bsx3pZ5lacRm+rc4/ZSG7/ELzNgmIMsshh8qafS+q1IGLKGD/rh5524ZBp6l1bpinoWtHdlG9
 TDJrDCehJ3kVq/XEJyGmOgrPPdJJ28pmIzlB1A1lRUy0zD0daOjYMnQm5EOFnE8MbE5QYlds6M+Wrd
 dRevIo0y/dCCzrEFO70RdszC+bg+Q/A==
X-KPN-MID: 33|5LIKcoMi4QNVtO4AtTDoBpnCnke1yE7XFKCF3joQRYo/8V1nxBUJZO8GuOh/2Vc
 db0dy197FiG/GEdPWzdWjTV3DpUOlMHSL7R8tSFPdOXA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6bmgynLlXxS7c+r3k5Be5hYHqXXYgziAxVep6ckZT3/xeJv4ezxKETW+y6fsRE+
 rDBEDzcvgEyxhmRnz7rBhXg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 0374595f-44e0-11f1-bffa-00505699772e;
 Fri, 01 May 2026 00:00:35 +0200 (CEST)
Date: Fri, 01 May 2026 00:00:34 +0200
Message-Id: <87bjf085x9.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, trini@konsulko.com, kettenis@openbsd.org,
 j@jannau.net
In-Reply-To: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:25:45 +0200)
Subject: Re: [PATCH 0/3] Switch Apple silicon boards to upstream device trees
References: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
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
> Date: Thu, 30 Apr 2026 23:25:45 +0200
> 
> The Linux device trees for Apple silicon devices cover now most of the
> hardware as u-boot's internal device trees for M1 devices. Linux has in
> addition device trees M2 and M1 and M2 Pro/Max/Ultra devices which were
> never added in u-boot.
> The most common use case for u-boot on Apple silicon devices does not
> use DTBs from u-boot but passes runtime modified device trees from an
> earlier boot loader (m1n1).
> This change regresses support for the DWC3 based USB-C ports and the SPI
> based keyboard on M1 and M1 Pro/Max notebooks. The regression for the
> USB-C ports will be fixed when dts/upstream is synced to Linux v7.0.
> The dt-bindings and device tree nodes for the SPI keyboard has still to
> be submitted upstream.
> These regression are in my opinion acceptable due to the limited use of
> u-boot's DTBs for these targets.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Thanks Janne,

This was on my list of things to do, but never quite reached the top
of the TODO list.

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
>  configs/apple_m1_defconfig                         |    2 +-
>  doc/board/apple/m1.rst                             |   15 +-
>  .../pinctrl/apple,pinctrl.yaml                     |  106 --
>  19 files changed, 11 insertions(+), 2705 deletions(-)
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260109-apple-dt-upstream-6daf03510fec
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
> 
