Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF075C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 18:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D3288001;
	Tue, 19 Mar 2024 19:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TGV3keml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B8288047; Tue, 19 Mar 2024 19:38:54 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F80888001
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 19:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-60a046c5262so56942087b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710873531; x=1711478331; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb6cXTX8wl8i9OYTIIA5VODXwi2hscx7mpd1vPMVnVQ=;
 b=TGV3kemlg+T2OzWSyOFjV2k5SCQrElIvN6potV7Md0SUId47kFGJlG7uPK1TQ6dxpm
 biiFmVPhpPgYjo/mc9nSKw4KXKLD5J7nNHokV4uvn0tjBpKC0chvHFCnx0fBFlWHckaf
 17WtQF0aYEze+UjcEzDqaIB/I3ANMqXkVWXaJl2NsIgLIY8t3dQyrqHJ+/c6pRrjccD4
 kOU0OhS8E49QUjJtHR02GANm6tQFL6BvDEFRFqRsvdVqs4njThXZy98B3PQssz1dUnDV
 QEH/HKjTYYLAcqByDI28xDwdjzDB/8YxXOxHaWHJcdKzGMLaBIsjnvcOABChiHaq691W
 X68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710873531; x=1711478331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tb6cXTX8wl8i9OYTIIA5VODXwi2hscx7mpd1vPMVnVQ=;
 b=LtFIIu+UGeFCENQqrZ92VhMVup7IG2ujXFIq9lLNSHkVgl1n/eICHxZ6+YdQloJGoh
 CEyB9LJcAHZEMHufiR+Gh4wUk9GG0/7FJuvYdqwgFO8VlQjNX9UJwPNKHAEqxBojm+Jx
 tULdAufJ09etHFtvvNw1Y8zUK/T2l0BH85XkSy2UDYld9kCJ6UBjIUncFqyMPqzaHDI1
 Hm7WhQVQnec6Ov9wQ6BrEMVGHzgHeM623/45mWvbbxqE98wkq3GSPqcsnXw5RNjwl3dX
 tZCoccCxG2WPa3RnQf9DH9qrtaQKZVvTTi95FxTaH2JDPuvSga/Mbqg8zCoFEHX47knF
 6FNQ==
X-Gm-Message-State: AOJu0YxTIyRCJ0N6tXl7Kjvb24vJFn4D3JngPx+SzBI/Iladdipin1ma
 A3g98Lvv1Aob05t11GxVTofnWY4hZZ53czLrdseAY+aZDmPHjsrWYEckTD2gt+kWiedla/TqVNx
 42dF1WfpN/wTTebCFDxdKekeX+hR8PpEy15WprQ==
X-Google-Smtp-Source: AGHT+IHqw86RTR/mDEV0kgaStxRUm0wl1XCEzRM25bzddipLCKRjANxBcnW6lV/pgXsMX5l0uEirjAkFNAkuz2Eq32A=
X-Received: by 2002:a81:8607:0:b0:60c:cc04:5f05 with SMTP id
 w7-20020a818607000000b0060ccc045f05mr3833043ywf.10.1710873530839; Tue, 19 Mar
 2024 11:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240308021858.28249-1-semen.protsenko@linaro.org>
In-Reply-To: <20240308021858.28249-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 19 Mar 2024 13:38:40 -0500
Message-ID: <CAPLW+4=j88CCjkWK163iQSuW3RiV9q7DrsixrmWKpjhQzFmMvA@mail.gmail.com>
Subject: Re: [PATCH 0/4] clk: exynos: Prepare clocks for eMMC enablement
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Minkyu Kang <mk7.kang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Lukasz, Sean, Tom,

If there are no comments on this series, can you please apply it?

Thanks!

On Thu, Mar 7, 2024 at 8:18=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> This short series features a couple of Exynos850 clock driver fixes and
> adds new clocks needed for further eMMC and SD card enablement.
>
> Sam Protsenko (4):
>   clk: exynos: Re-arrange clocks in Exynos850 CMU_TOP
>   clk: exynos: Don't expose prototypes for not used functions
>   clk: exynos: Fix incorrect clock lookup for non-top CMUs
>   clk: exynos: Add CMU_CORE and CMU_HSI for Exynos850
>
>  drivers/clk/exynos/clk-exynos850.c | 326 ++++++++++++++++++++++++++---
>  drivers/clk/exynos/clk-pll.c       |   6 +-
>  drivers/clk/exynos/clk-pll.h       |   6 +
>  drivers/clk/exynos/clk.c           |  47 +++--
>  drivers/clk/exynos/clk.h           |  70 +++++--
>  5 files changed, 384 insertions(+), 71 deletions(-)
>
> --
> 2.39.2
>
