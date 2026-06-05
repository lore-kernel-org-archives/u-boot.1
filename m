Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDAECD6E75
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507008489D;
	Sat,  6 Jun 2026 06:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YtPazGd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F67E84936; Sat,  6 Jun 2026 00:06:21 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24BD848A1
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 00:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6913160c9ddso1111365a12.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 15:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780697178; cv=none;
 d=google.com; s=arc-20240605;
 b=WFe3+MiwwbV3A7p/jHU+kCO0mJ9DtjgyleNA7N21UIyq6wkb8HMmdIxc+vE9mVrDS6
 LJSfLMHt9XBBs+a0e4151Mjrj4dtokTCPCbwOrZA1pAedJumFaEJizy0QretKfhI/FI/
 nOQA9jnjME5ZaQSvQ57J1QU0NZtgSEM8XcO+sUTDBfllAFGUUlI9kn7p9QVG1j/tJSpN
 SPZ7V2xjaWb67kKa1bri6zx0xeXRkPvM1o7lcEPzx/danEPhCBJiQ95flEsCHmxLui6U
 00orCS8yfrjy0tdvbKfSCTR1jfsRPHUNgXIjTD14Nh9PFiii81H6w46QnDv4RtdeaAN+
 lEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vd+3wpOwtEVyL6P0JV45QWExRy1OERCUBaqxLORkWF8=;
 fh=tlAJUcGfYQaROx2vxUzvx9CdqdQ2xioF/vQg2tuVy4k=;
 b=GUCjmGs8HnItvE6OPo6O18qbXxRxcSPZEucmSK2NO77WWtn3USSGqMM0DkP1a1m9BS
 8YbqlG7RIRL/GNNTdRefVbe3rnoAxxwAUEdkrDANPvUAMqjQ/vc5EiZhx5ey7b+fPgXs
 NLZFaH19cChmW+wOuU2arygei5PMedDGQW2WS/2gta1IJJE1E1+EcI9viHGDWRH2Yb80
 kOLHoSDZk0nkn4uoyzQkKILxrqbKQOq6fLmCzMasKdF1M1eV/cR/ClFEYfQRKoao0vng
 QTqORnBUehS3POGpBzKWx+826oLfuZ/BL3pB2inZp/5Bng2KeYnXBeP039IxEflz4B9j
 500Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780697178; x=1781301978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vd+3wpOwtEVyL6P0JV45QWExRy1OERCUBaqxLORkWF8=;
 b=YtPazGd+FBBpQWX++k7J4eyv8Pnfdz4ATorMjeP9vFqoRtBqbzs/RZh5rymIxc2jIl
 L/jc/8TxCTznvnbbdzDxwfOaebgTWX9ZmiTRM3Hk6znqR0cK1VgabqaricrrK+PYlZ83
 VKR1ldUd+M+cRDCuHBY2uzWUmayCN6rPNyRAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697178; x=1781301978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vd+3wpOwtEVyL6P0JV45QWExRy1OERCUBaqxLORkWF8=;
 b=U2yKMJAwxzJFLT0Q8YfjJn6aKAfPqXUXiTXl46eaEpOBVqXr4faPCQ7MAC8Eh4OExA
 a7hl6ea8ZEx4fPSWV7YXGwb222LONlNO6pD+yQEmr+wCX20L2YRc/3n3qICbv24VVndk
 7KuUzGP9b7RN0JLDVx7qIkHS23XgvCFfV4CEUenMuVZL6GPWFCgrnDEtqvaEGlsKweBc
 x9hu8ucyPluxcKTFKX4mqh2QF7KwaLey4S26yipE2aEOjRmVJyjA1r0Nb6Rp7zNp+H6P
 OQH59TLpgug267+5W5k8cwJ9faChCHmzOCH1VpUoDWBqIOdVm1s6L8vOyP5Irvi9w9HT
 trcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ94wsYGrWlNeKFle7GlBIPLrWseFRciE7MuWgFsj5ESTjG94oa1kUj4y0vQafV7fbZUaJKMS9I=@lists.denx.de
X-Gm-Message-State: AOJu0YyWjW3B+x7osk7vd73dnfZ+/XzMzytmIE1N006Oahe3m70REaMv
 igq3k8msRI5PvleEXVutUCPhiJ9N41ZIqov2toXUrT2RU73W2Y9+X1Nyg5VhpBijGSQDXXuT1NP
 EQ2v+CtyQqyI7CmK+roE2Vt9tASA+S3HdWI5ZPMUz
X-Gm-Gg: Acq92OG/Ufddg5nvedjcm8zK7I1hVfsFmzlojIDupphEsvWTGfH/Yy72v893eJYEkDh
 nnHoW+W9S1hQF5AUF92cBKq2IearG5IsgGOYuDbzgpTyPoA+6n/27Lp6CZ9WADqPw9D0WyX3yx8
 y+tY+9winSJLa50TWRwAq4Ew6JpnPZR4zw/iL5uCJwypdhHcxacjX835bL+IzzALlUmXUd/ldnR
 axkon4drFmahiJtaeRfDkcjsXMEA35sU5fGYHOIkBsTkShuBKP0EoJy6GWcOHsBReOlZadvs/yp
 PKG9uEfxrBNvPm4F
X-Received: by 2002:a05:6402:1f45:b0:68d:9272:d07e with SMTP id
 4fb4d7f45d1cf-68fa4c19128mr2759469a12.6.1780697178300; Fri, 05 Jun 2026
 15:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
 <20260602-devfdt-spi-v2-5-08374650778a@nxp.com>
In-Reply-To: <20260602-devfdt-spi-v2-5-08374650778a@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jun 2026 16:06:04 -0600
X-Gm-Features: AVVi8Cd2UhqZRi_1jte1rbPQW9M20l0u9M9kWqK_Z389EvZEdIKhvnIroLofi4I
Message-ID: <CAFLszTi6m5T+uHhNepirLYvOq491Yb8NVftixwNd11GbQ6TccA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] spi: ti_qspi: Use device APIs
To: peng.fan@oss.nxp.com
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:47 +0200
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

On 2026-06-02T11:20:14, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> spi: ti_qspi: Use device APIs
>
> Convert the driver to use driver model APIs for phandle parsing and address
> handling instead of legacy FDT interfaces.
>
> Replace fdt_getprop() parsing of 'syscon-chipselects' with
> dev_read_phandle_with_args(), and switch address-related helpers
> from devfdt_*() to dev_read_*() variants.
>
> Also update 'num-cs' handling to use dev_read_u32_default().
>
> Remove direct dependencies on gd->fdt_blob and simplify the code while
> keeping the existing behavior.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/spi/ti_qspi.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
