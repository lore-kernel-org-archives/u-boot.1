Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547ABCCD184
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 05:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722B783710;
	Fri, 17 Oct 2025 07:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eKc5+3cG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F6983775; Fri, 17 Oct 2025 06:04:27 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D901836C1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so17897995ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 21:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760673863; x=1761278663; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3IDJ+vLRLRjQM/X27foHFqyNmEo5T95YhlhbnJkmvE=;
 b=eKc5+3cG8PdnAbaeq96jkJN5a3mu7xu1bgMUgYqgt8Pl/lao859wmBtXfPEXHgpuKb
 egF6VjPlaulTwG2Hk8m6zd0cSw4FodfZ+za0VT8XTL5oFqce/RT1oTO0gqBeezCRaeqf
 JKvGWnLQuhbjCertS5Kw5axBCFWu1U15XZeaQcPVSyZpSDPIKthWhI9BrLOq2NvvJqLm
 lyLJ4eggGmblzOggpEkN27/LPyT7l8w5dRcSFlD0I5RFv6sw5O8iPnyiW3AaD2eWopXS
 5VgFxsdDSiQz6PVs5IymQeSki83UhLk0sSxaJ/6W0j7/eP5jp6tohhC30h0nt9PNv1g0
 Wb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760673863; x=1761278663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I3IDJ+vLRLRjQM/X27foHFqyNmEo5T95YhlhbnJkmvE=;
 b=rnRRTWKXFNYPohWphFYGxbf6qTS/uH9XKz7jcegfoVWm3yarOquKPjFVvWdiHEoMwJ
 tehf8eYKtcP3gMFUbWEdBpzuueNuW08ul5frUD/FZpZp5slQa7MatQhsgYUTHMMzXBFv
 7PDyq+z7WMSejF8TWszt4XXOLIzIUHbEAgEibxuhDjqc9kc+anoG5xYGxnfkFYeXOa9K
 B4oZGECLoSYCczgirVrH8CAnh+Ev0U3sQ1WalY+3c7AMeyQCSVs8bAlKQgS/Sq+4XAnD
 GzNcgdw95ECGm7JJkzGNfnasMViJPj4njyah0ge8izm/j4x17px+5uMmEp8MdIlgI6U2
 ydow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzkOiXnNitqsSPd2BaU67cahNSBwIfYAPnb08jWJe5RDuPYJ4wrKrSOIfa89YsLpiDxfijhhE=@lists.denx.de
X-Gm-Message-State: AOJu0Yykcq59xydu+xvYWOOQx8fqLDOfNqxaKdOhXL+z4z/3wpNd4hqT
 i9f0do0SY8HL4i31+VsQQf1QxF1PFDueJUKo7zdMLnswhqhnHD5odwd3RMsKyHT2/qUQKjEtjd2
 EcltbkWLlpkXmGrvA3M9IDb5/SfTfBw==
X-Gm-Gg: ASbGncuqldjFXQHvS016W/3YO+VyJIm8/Pm9lAI4l8pOQKskpNtixGYOzlumBBi/yBs
 FckWtNoRxqpxhOjlko2JyAWy6G7LDUzv187I/u+ARvGAegfr3TNp0jORwWyBHzaAoAuMQA3M72H
 6Kh3iYL5ffnkF38WMY/7oKggtzIJW9gFnBHKo4eNnDvUufocytIPQtm8EVwix8ECJV4BhU70wVN
 2ghEEE87G8YoWGR2gI60UtTeGFjs7WOddpJyEmkIayX9804nlC4LehbMTcdxs6eXraQCRdxOZdb
 RqD7GwbTsTMqAMTKF86+i10Gbi+Y8wZxfDBafA==
X-Google-Smtp-Source: AGHT+IHmzB317oQkQHpHZys/FCDRniELEzvLa5cBeIzNljKywnu98WHQOROmEkt1+b0K86qlXFzZhCreAxtHUKqwOEE=
X-Received: by 2002:a17:902:f541:b0:28d:1939:f9c8 with SMTP id
 d9443c01a7336-290cb0803d5mr30672475ad.26.1760673863365; Thu, 16 Oct 2025
 21:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-21-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-21-5f80f827407e@linaro.org>
From: Greg Malysa <malysagreg@gmail.com>
Date: Fri, 17 Oct 2025 00:02:55 -0400
X-Gm-Features: AS18NWDw-WCq3s6Td5-JQy4J-j4STU-cSY6siJRlDbWGdZZhreSlSr0RoZPk1VQ
Message-ID: <CABdDSeVJnZfp86yDXw6sh4cioKTsYj3NcGy_sgVMdja0K_pApg@mail.gmail.com>
Subject: Re: [PATCH 21/24] clk: adi: Remove negative error returns from
 clk_get_rate
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
 Dai Okamura <okamura.dai@socionext.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 adsp-linux@analog.com, 
 uboot-stm32@st-md-mailman.stormreply.com, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Yao Zi <ziyao@disroot.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Heiko Schocher <hs@nabladev.com>, Jonathan Currier <dullfire@yahoo.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 17 Oct 2025 07:24:02 +0200
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

On Wed, Oct 15, 2025 at 10:33=E2=80=AFAM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> clk_get_rate() returns a ulong so do not attempt to pass negative error
> codes through it.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/clk/adi/clk-shared.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/adi/clk-shared.c b/drivers/clk/adi/clk-shared.c
> index dcadcafa9d236882af8c7b397eeeeb44461a23cb..600e22940e8cb60b1e510a74e=
e8068ccf0c7848a 100644
> --- a/drivers/clk/adi/clk-shared.c
> +++ b/drivers/clk/adi/clk-shared.c
> @@ -16,7 +16,7 @@ static ulong adi_get_rate(struct clk *clk)
>
>         ret =3D clk_get_by_id(clk->id, &c);
>         if (ret)
> -               return ret;
> +               return 0;
>
>         return clk_get_rate(c);
>  }
>
> --
> 2.47.3
>

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Tested on my sc573 and sc598 boards, looks good.

Thanks,
Greg
