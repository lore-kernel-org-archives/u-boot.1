Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC30BCCD19A
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 13:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA1983804;
	Thu, 16 Oct 2025 15:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="SQQysX8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16122829E7; Thu, 16 Oct 2025 06:54:20 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02E180077
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 06:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0C89B20D0D;
 Thu, 16 Oct 2025 06:54:17 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MW2-OO5HRg8L; Thu, 16 Oct 2025 06:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760590456; bh=fs4oHPb2OIxpefS5s1KkAXnUyfFBSX6CJU84Y8g5d+s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SQQysX8u10sxBE4WuRt0pN6u2eXeg2DI/Xo2XjMDKPMXG3Ck5hp6oq/C0j7/KpxT9
 kJQDTKhRkH+oZsUQ9LjCHCB800uZTg0JzHTWoiyP67RMW870PCbh3W8hthi/B4VTOA
 vI8uR2EHRDLVE1THqQV+Nt0lqqzFVW35QoBoikBWaSXpC3gDOWv9KY9iVMITWaIwuL
 q3QRc0hVfy1Vv6Y2A4kK/oEF4sw7fR+J2YVZquLQhVQ6F1VT+hMw5WJLHGxc9mR23L
 tOteALgE77bdo7/EcnYI7anESZXEKlFXYOpaENlEDYrAaSIvl0KElcPSzHjOqvGiFw
 kCP1skA4/IVDA==
Date: Thu, 16 Oct 2025 04:53:40 +0000
From: Yao Zi <ziyao@disroot.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de, Paul Barker <paul@pbarker.dev>,
 uboot-snps-arc@synopsys.com, Dai Okamura <okamura.dai@socionext.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ye Li <ye.li@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
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
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Jonathan Currier <dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH 04/24] clk: thead: th1520-ap: Remove negative error
 returns from clk_get_rate
Message-ID: <aPB6VPMiOcUknoJO@pie>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-4-5f80f827407e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-clk_ops-v1-4-5f80f827407e@linaro.org>
X-Mailman-Approved-At: Thu, 16 Oct 2025 15:06:00 +0200
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

On Wed, Oct 15, 2025 at 03:32:09PM +0100, Andrew Goodbody wrote:
> clk_get_rate() returns a ulong so do not attempt to pass negative error
> codes through it.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I want to switch to ccf_clk_* in the future, but this patch looks good
to me as a fix alone.

Acked-by: Yao Zi <ziyao@disroot.org>

Tested on Lichee Pi 4A board with no regression found.

Best regards,
Yao Zi

> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index 6899e1b595a7148a118d3a615d5dfea4b4fb5b96..e913621967eb131b534e8f5b928687967a02a30e 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -985,7 +985,7 @@ static ulong th1520_clk_get_rate(struct clk *clk)
>  
>  	ret = clk_get_by_id(clk->id, &c);
>  	if (ret)
> -		return ret;
> +		return 0;
>  
>  	return clk_get_rate(c);
>  }
> 
> -- 
> 2.47.3
> 
