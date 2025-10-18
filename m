Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AE8CCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 13:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C718A83869;
	Sat, 18 Oct 2025 15:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dE/etVNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BF083796; Sat, 18 Oct 2025 10:35:04 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3958D836D1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 10:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63c3429bb88so2060528a12.2
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760776501; x=1761381301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GyQWOulrh/Eer1xNnW7Kyg8KGv0rCXH9pL1ZkY7eaSU=;
 b=dE/etVNmRLHVCCCes719rEjW74AMgHoDjcuxrjiJA9wP2ztPiFL2gTA/9fyEYsC9wD
 kk2pcRstXFK9tZZQC/hCIUtCpGDmDeqYa2qA47iZZbyEIBxiVycz17RZnt90oKUdrPIW
 ZUtRr3MLrjviBobFf+5mw5/+EWf325jZFsV/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760776501; x=1761381301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GyQWOulrh/Eer1xNnW7Kyg8KGv0rCXH9pL1ZkY7eaSU=;
 b=gMTzYV5r16lZlHYsWuIIOI9CuttU1FENRjvpvVxp8ujYrySqwSGozokkxtxaeQ/cqE
 Qcs0lxaW64Y33G8m3RCG+9wLOAl+rZZbsNa+rs+5IGz4wolalV6j6iNArI2PTBms8BXF
 mmANWSgfYup+4wW12rTJsXIcoRvqkzEBDgnJVu8iC7517icS9tfa+jGhEEX7BsnzDHzg
 SWcu8+9AH0j1lXEWRoW/F1m4dJl0nruQwxcti3wEZ3obBtqqy1eNy7qNysE0KXrMfgwT
 BTv55F+IUL/2gydfGzFFaCL4i4QlO7/4KEEHvCnsop/teEYy5uIyGCamNrR6vvfr4zaU
 /EMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/xCym7AhcqD7gzZCmb6PhmZOqerzdsXieZ8XbKkb1ZO0v5t0f1YKajRGlgAir1WMKoalt6s=@lists.denx.de
X-Gm-Message-State: AOJu0YyECWWnzcCG3wN0Jb8YUjx3vR26FfKyRqYpWcqgQMJWHjmFq3wJ
 cymncMZFcBYiZP/OzklpzPxJ+gu0vcNTBbcZ2PIsQPFGhyh5KYPH8zbG76gdJqPmoDLvcwgpsB5
 aiRhYf/ma0A9aLpqxd1faL74icskBWSCOPOMCBhRV
X-Gm-Gg: ASbGncs6Bs+TMwnnpXcV92LMLzVN6WhTor1L9ysriWlHUT9zjV1fGOccuDgqCPUWKqC
 EEFm2+3p0fqVfx7GfA5xCPd7QQOH8NXcNrVlbC2wFnE6GVJ60Wlei0DXLLS1SvXWSk7tNSBa7pT
 HjsIxMRNbUDt9JwL0YnfDMajj6ES5wgYzM164Ir2sDjX/M3Lygcjj79N/ZpVaIVsW79XnloIbFk
 oKJ0QvtKb4rn4tkOOV6HjCiszlmS9EH0OxWwpPIbb7WA7VlygLr7PQXXuY/ThaG9/LLsgs=
X-Google-Smtp-Source: AGHT+IGWGGbVkCD3XOXmUZtpd0mvxQ85Bf+KNTpUMy0MxPwXGTLHNb9i04xYr36/ycvqCIxLVPMPa77V3aHPjtVYa5s=
X-Received: by 2002:a05:6402:286:b0:637:c0c3:fbc1 with SMTP id
 4fb4d7f45d1cf-63c1f6d3244mr4188243a12.30.1760776501460; Sat, 18 Oct 2025
 01:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-1-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-1-5f80f827407e@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Oct 2025 09:34:48 +0100
X-Gm-Features: AS18NWBnLaAN6fZ9FkElI-GXJyJ7IwNjlDP4wjDRZycZoPdxyTeUW7J3w9JNY2U
Message-ID: <CAFLszTiPBOmz88HXUAM6Qdrth9xm5sgeyRxVO=GV_1GVAFucSA@mail.gmail.com>
Subject: Re: [PATCH 01/24] clk: meson: Remove negative error returns from
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
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
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
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 18 Oct 2025 15:53:45 +0200
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

Hi Andrew,

On Wed, 15 Oct 2025 at 15:32, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> clk_get_rate() returns a ulong so do not attempt to pass negative error
> codes through it.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/clk/meson/a1.c   | 10 +++++-----
>  drivers/clk/meson/axg.c  | 10 +++++-----
>  drivers/clk/meson/g12a.c | 36 ++++++++++++++++++------------------
>  drivers/clk/meson/gxbb.c | 20 ++++++++++----------
>  4 files changed, 38 insertions(+), 38 deletions(-)
>

Don't change the driver interface...just update the uclass.

Regards,
Simon
