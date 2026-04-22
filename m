Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58107F94CBC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C227D8419C;
	Wed, 22 Apr 2026 04:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WPF99O+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5488283936; Wed, 22 Apr 2026 03:12:50 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5574B805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c745e18a0so800084766b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820368; cv=none;
 d=google.com; s=arc-20240605;
 b=bkQcy0w17N8lzqIjQZZ8g6WmDaNryAB+rTUXk5dRLID/YZAOoN56+l2F7Yb/Cyt2nm
 f+nFRwa7RldLsSaWkha/em9HJaXb2fvnsUThFpa91X3F9A2rUV5crtQEGXpoTvt74Zfj
 i+Gsjg2m212XcNgaMiX5fBW1FGe+w4BZI2AYSCOMjK0wCIsvNqQr2dtEcW5VeQfbq+PL
 lxZ7AQ6uQYraexeFA6GzrkOsqcZFRmJv4gs6xrGqzln4IJKmfz7FwL9rxF4Oh0dXHSiK
 OtPK1U1jBo+w5syvG/eKL4RBTqjfp4ZPywvNG1rCHfFJ/ga2EySbvv6fSrxAJEv3OC/3
 nhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZLGuXnMHOGZw3UYKDd3Qy0+02zQyiX5FON+bgqXoBtQ=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=W6ZQFl6WcEKSv0iz5IW0ukRqqyaZzLjZGZFCTBqhUN8JGl6f2ZsxN8edj0pwR2C3cA
 vHcd8mquwGow5+tf6HV26YIna1BXyWQ0w3zrU3722Sn83q8raq3SLB+UDwUepJwSICVA
 LnaYnF/us8XyFiFgLSRIcNStmlY2kaSUdaefXS70dZ3XUerHnwPLfHGEa+++7/1klFgt
 LyjecUhIaqgg/eG0f6LJ6COBTfmMWmMEnRkxorPHmM+SUC4wBOyfMIbXsX582v2szJ7p
 6rccX5k/eNWu8e3wM9jEObianWp0J1aqqcWbDqg/LQYzEGVAURfJYDchXgtmrePJP8is
 rzlw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820368; x=1777425168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLGuXnMHOGZw3UYKDd3Qy0+02zQyiX5FON+bgqXoBtQ=;
 b=WPF99O+Gqz706OudkFGP5GU9vtsMc8VWYWaeEjlcPJ7xgU1qJx81XHJnwa15obJD9z
 LCH3pwCB5+didhm7APnOQzRm+e/kvNWVWJf0E2npiXYnKsLN3U0lNjzQUynXpNbfPLjV
 i3VjyxFjObb8TnJI9FMZjwdeDEV92zOGRNR98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820368; x=1777425168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLGuXnMHOGZw3UYKDd3Qy0+02zQyiX5FON+bgqXoBtQ=;
 b=C22UaqB189Ivab+pyQl92w5r/tWKhKk9bnApTC+9fUCfBrhpgb4ZILfra1peq7R/Nx
 TH12/tl9pvmF+nNhEno96IZbk33zHr9tjjbL7n0+gjjXoI9O8MeCAvnEUsSzygtYMd4b
 UjPI0V/rDrAvj3ddqqNfgE+ESgtPxZIA+nvJDxtXsGJFkkjY6h6fAjOQppwnTORTmWQj
 kaVhk+2ysLpfTmyktOAsnnVkWXAGV3WhhZBFQRYTYpuak8FPQQ+08tzewDmekh3FsQRC
 bkjOgJl0s2DR2VaERcQ8Xx8shDpcEoeMqt2f/zd2KtGsBZf66lYohOqAonpRQYbhLQDp
 /RBw==
X-Gm-Message-State: AOJu0Yxte2tSE5A/H6y1mWLRd2tdaEnTeStb8rUXd6W566eNXF6y5roy
 tsa5f0oKIeEfF3lfljytPJaZ6yB3Ug6QjegORUR9Lzlve9LM/EzWXpeFjXDxxtQ3EX1bbjuvwuX
 T8LN1YZl7oPUe+NiE9iGnQtJ6bnODl9XaePnNDM6b
X-Gm-Gg: AeBDiev1HIIK4LkS60ZGuWw8363y+qu6pngRl+yaoqVIY14+7USo7Ztg7a0KkbpVFLs
 CtlA59Bqi4aPBW0U40puSUIBfKYAydqp6C1ADUFASH5CeKgPznqIUx3sJQNQtH1H5iz7N1w/a8o
 /Arw156ffklifAU3wyFqx1lFivANnrLEcOvBeS82ESMTxVwqAx0ugn83fwUhugPV2EipJd6bEVC
 e3lN8JbEP+Fwv4rzKFFkiWWWN5gtf/h39o9mJDL6e2xk4uUpCLDi+RtqWtLSes31UMB12mr0L21
 AHKK9m0tNRZD3/tC2Ppq
X-Received: by 2002:a17:906:9f90:b0:b9d:4508:9260 with SMTP id
 a640c23a62f3a-ba422ce64dbmr857243166b.32.1776820367664; Tue, 21 Apr 2026
 18:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-6-efee3f76754d@seznam.cz>
In-Reply-To: <20260421-qcom_spl-v3-6-efee3f76754d@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:12:34 +1200
X-Gm-Features: AQROBzDhGmcgs-ZHel9drq9p_rCRcOm33vhWStxpmhBKyaBrdYpbktzvS3TlCrU
Message-ID: <CAFLszTiq4S-9tBcNVk6w1OvrKaxP_Vm1_LVARei-xOnrbYe4XA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] mach-snapdragon: Kconfig: fix duplicate
 SYS_MALLOC_LEN
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 22 Apr 2026 04:42:51 +0200
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

On 2026-04-21T19:43:46, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/mach-snapdragon/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
