Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38479CD13DA
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 09:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABC580F0E;
	Sat,  2 May 2026 11:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="V4CNyLpA";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqiXXnY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1E783642; Sat,  2 May 2026 11:00:16 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC7580077
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 11:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 345FA7A00E6;
 Sat,  2 May 2026 05:00:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Sat, 02 May 2026 05:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1777712408; x=1777798808; bh=XIFnpAsjBR
 XRgLZQQGfwG3DfDjFXeh1nmdkLg+FUCIY=; b=V4CNyLpAL6cLEtp90n1n9ItCKf
 D6uVVRfMrReJH1gzj4LOc/1o1giHJ5n/qlTaGwTO/6kIEIjou1PKngYVg6hPY24d
 PgJP03YhEsePffvlQ//fTd4vJZH+w5slFfn28Fi9zcYmUEjYgDGUvq1w52g39Mxi
 7mBOst0TRTELtcO/CJMGUcwe3Dzc5SxljT+uqHPhQRzfLOPyuWa7+qcchajGk8Ux
 Bc933A3pcAiGHZxyQ0PD2kFyrHwDhh430fAOZbifiVdtGMlvX+UHE4C5SdyDhlqV
 wgGEglsEHOhA48Xo14hxC+x+8EkE3VFH0C0V27TATPMWls+Xt5Xp7B4nm28w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1777712408; x=1777798808; bh=XIFnpAsjBRXRgLZQQGfwG3DfDjFXeh1nmdk
 Lg+FUCIY=; b=KqiXXnY4XH+LumsVxp+gptxVc3+wlwCVe0FPOyRqegavqufUVvE
 7ReXI3m/cKTvy2hNUyATfAlU93ykBcPNEY8qOsI+aDhbhYPt8KfMP367PukdAXxN
 1bJfFYDwR9hCPEWFcl2+/jFxcBKH8Ilej/HWm7EDhofG7O6nLDNmXbCK++g+I9QM
 ZBe0sWPr+aI+jdPKyfN8JonfXInj07Mg51zBs0EIx43dn9rl32hdiWkukWECvDE9
 scRmbMw4uSW6VBexbaWTEZtLT23/CvNrp8/qrVzB7xtv2TrU+K7tSs54iATKLcJS
 B4XwL9XKT8fr/Xh+Jy3EjmvJzKf+5DJxQfA==
X-ME-Sender: <xms:GL31aS4GaGn_20j1bpsSBMVjSl_SSR3I5QNaZ5MzbAg1I_2Q8TMTXg>
 <xme:GL31afL9vSGjHTpuQypzBuz2zv9strTCfptkUDsM0U7XpcQQfjik_lbXFhN5YXIkA
 poAqWOJ0j5T5jGJ38qLg3KhfFERvWgQO5tbUhED_5GB_4-0kNqpvt8>
X-ME-Received: <xmr:GL31aa4P7-9-MOLoK1AIxqee2PBp49lYDFofNXiHv7CCY2fFi3KuZVOkI1vSV__TOBvXbyTVzcwMSRy3DPdIA3eYiOx2Pr5KhU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelvdeiiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghnnhgvucfi
 rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvff
 evleegudejfeefheehkeehleehfefgjefffeetudegtefhuedufeehfeetnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
 hnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehtrhhinhhise
 hkohhnshhulhhkohdrtghomhdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghs
 ugdrohhrgh
X-ME-Proxy: <xmx:GL31aax8qbNrGcwFfiBe5yRPImunYytw-tRrf9ivwu4UfMb5yCvMYg>
 <xmx:GL31aWYeTuYwIKkAJS6F5kvT1Oj4iNskd5ru7_J8nKWDzbdksJzSrA>
 <xmx:GL31aUSfbSa7C_1vrXaSIJ_BoAcNIgz820mG7W82SEbY2HVaiZcYpw>
 <xmx:GL31aYyoogdMPPgDxyC05zFoynkxd0OgAg7RnLc1o36uk5CttSIX-Q>
 <xmx:GL31aXJGwbNHxwvdamePNKCfsUeuKIc5onXK1POKVnYPXbYZ2DVLtg_2>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 May 2026 05:00:07 -0400 (EDT)
Date: Sat, 2 May 2026 11:00:05 +0200
From: Janne Grunau <j@jannau.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH 3/3] arm: dts: Switch Apple silicon devices to dts/upstream
Message-ID: <20260502090005.GA219066@robin.jannau.net>
References: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
 <20260430-apple-dt-upstream-v1-3-dda66c16e0da@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430-apple-dt-upstream-v1-3-dda66c16e0da@jannau.net>
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

On Thu, Apr 30, 2026 at 11:25:48PM +0200, Janne Grunau wrote:
> The device tree on Apple silicon devices is passed from a previous
> bootloader stage. The bootloader fills in dynamic information so
> u-boot can not use its own device tree.
> As documented in doc/board/apple/m1.rst it is possible to build boot
> bundles (bootloader + device tree + gzipped u-boot binary). These are
> useful for testing.
> Instead of using u-boot's own device trees for M1 (t8103) devices use
> upstream device trees from dts/upstream/src/arm64/apple. The u-boot
> device trees have not seen updates since 2022. The upstream linux device
> trees have feature parity for the M1 devices. In addition linux has
> device trees for M1 Pro/Max/Ultra, M2 and M2 Pro/Max/Ultra devices.
> Keep t8103-j274 as default device tree to avoid further updates.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm/Kconfig                    |    1 +
>  arch/arm/dts/Makefile               |    7 -
>  arch/arm/dts/t8103-j274-u-boot.dtsi |    1 -
>  arch/arm/dts/t8103-j274.dts         |  129 ----
>  arch/arm/dts/t8103-j293-u-boot.dtsi |    1 -
>  arch/arm/dts/t8103-j293.dts         |  116 ----
>  arch/arm/dts/t8103-j313-u-boot.dtsi |    1 -
>  arch/arm/dts/t8103-j313.dts         |  111 ----
>  arch/arm/dts/t8103-j456-u-boot.dtsi |    1 -
>  arch/arm/dts/t8103-j456.dts         |  117 ----
>  arch/arm/dts/t8103-j457-u-boot.dtsi |    1 -
>  arch/arm/dts/t8103-j457.dts         |  105 ----
>  arch/arm/dts/t8103-jxxx.dtsi        |  143 -----
>  arch/arm/dts/t8103-pmgr.dtsi        | 1138 -----------------------------------
>  arch/arm/dts/t8103-u-boot.dtsi      |   25 -
>  arch/arm/dts/t8103.dtsi             |  696 ---------------------
>  configs/apple_m1_defconfig          |    2 +-
>  doc/board/apple/m1.rst              |    5 +-
>  18 files changed, 4 insertions(+), 2596 deletions(-)

snip

> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> index 1ce69f2882a..d0cfd5f5591 100644
> --- a/configs/apple_m1_defconfig
> +++ b/configs/apple_m1_defconfig
> @@ -1,6 +1,6 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_APPLE=y
> -CONFIG_DEFAULT_DEVICE_TREE="t8103-j274"
> +CONFIG_DEFAULT_DEVICE_TREE="apple/t8103-j274"

in addition we want

CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
CONFIG_OF_UPSTREAM_VENDOR="apple"

which keeps the current behavior and builds all dtbs

I'll send a v2 in the next few days.

Janne
