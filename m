Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA87CD4F5E
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 12:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD7D83FF5;
	Thu, 21 May 2026 14:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VS4KRCOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D8A843B6; Thu, 21 May 2026 14:23:36 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C983805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 14:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4903974854dso5487725e9.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779366213; x=1779971013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OkISSDwoDixkov1V+zvkSNp+TKwNqmLkRa03dFQ2QD0=;
 b=VS4KRCOvTawLoFHXJGDFX5m2BXuUqwI6YaudcTuAa8dNM6pBCEjKXjkaxkYKYx/s9e
 xWBwPraGZpqCA/eAr3j7NmmNKiPvwUiUfvFy90RoKfFehY3c3LG2CcggksXUMQVBzRyS
 i3s86Q7wWUvHN+2heAcqRC1A/G3VIDa3fpkwtDYTDTgtkxB3hyFhX0Mgk52wXLrBpJGY
 EFNM1wB/rePSHZSy9tPa6gO3BvvP2UTkx4slqkmDNfKoKuNo8EhcqRYTiNvTImsHqDNb
 iTxo6enBNnDvHDvzw/PadOFtiyx9OpK/PUnDqgZEBnXv1Rl0axrE54bxfsC98nxJO/AY
 OWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779366213; x=1779971013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkISSDwoDixkov1V+zvkSNp+TKwNqmLkRa03dFQ2QD0=;
 b=ADQpWBiBIjWWyn6pd076fY6l1kGwbuc8Twtdc7fV2QPrvxSuYo1cU6CkAPQssbfyIC
 EpJdzOfjlLY3zwpGwV0DnO83WGjcn+TVuVZySw48P5M7ZeSx31ovWT6vgTyI+DCa1Mzy
 DGqaSZP9IDZo12DIsvXFNjXZpgTq+iAwpGlgtdAD427/+pBAzgVD20bm5ghVixOlYEh2
 wDGmwzh52LjpCiTmXyxLzY5v38u+6PzUvZKZbqGfeIWtAE+jxz9kV5yEvSWFstLH4YR/
 xsLh04giwhCB4Ue7+EF4tXB2c063hDzp0jlV/mUT7p5OH+Wrn/8ttBwUmZvTfqonEeCp
 htyg==
X-Gm-Message-State: AOJu0YxQdPYmachiTonHGmpvMIbBmTbTXV5SdrfVVoagJU9LtzO1/Hl6
 H1Czo+ybQArcBXeFYuoCRSKT51w1Js9eIGAIncgEkGczt5F0omsYMUf5pPoLTN+hNFk=
X-Gm-Gg: Acq92OEzSre1I+OQs01G0q+2B/ukQZLFJlcxGdOjvI8aNWeWqwpGB+j+gIeHR5e8A+I
 5HLxE9ljdBvQzb0bDiZNubKeumU0FcVWmi9jzBlWg9gkinofQ8aOIydibSgykv7uallLA8Cu0K3
 AGxAJX7mRkkfMitaYh/ce/IO+DKMjS4KP0LcCPFiY8qOqhWtXI0lHA3Ve2KDR8Q+VEW/iteXsi4
 qWfMdWKF91ygfRO0Y3HIjXRFrQ1455CgpJhwgU0dKCEjUA4g+UzhFJI5IE+Nqxfo9URheh9fVVX
 USzEZVT6r2VNEOznyDwRpGUojqDntBGqpnReHtBqUKYYbJElmFFjlM+ar9MAK6LhwB9AZ5qYX09
 vIqsToBifBrx+So1NZ6uZOnDk9ZIgULFnmJPjXzPId8CoZBQa5l0KD+8vQqqFOksHxJ/nloeHl+
 //x4t2X1JxblsmaanfGBN/pzqEg5Q8
X-Received: by 2002:a05:600c:41d3:b0:48f:e6de:1cb9 with SMTP id
 5b1f17b1804b1-4903608931bmr24031435e9.19.1779366212702; 
 Thu, 21 May 2026 05:23:32 -0700 (PDT)
Received: from linaro.org ([77.64.147.221]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035adbb48sm15148945e9.0.2026.05.21.05.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 05:23:32 -0700 (PDT)
Date: Thu, 21 May 2026 14:23:26 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v7 6/6] configs: qcom: use mkmbn and stop building ELF
 files
Message-ID: <ag75Ptql-v0Z7PjX@linaro.org>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
 <20260511-b4-qcom-tooling-improvements-v7-6-0c06346e79a9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-6-0c06346e79a9@linaro.org>
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

On Mon, May 11, 2026 at 03:57:48PM +0200, Casey Connolly wrote:
> With mkmbn integrated we now no longer need CONFIG_REMAKE_ELF to then
> run qtestsign and can instead just enable QCOM_GENERATE_MBN to have
> mkmbn emit an MBN file directly.
> 
> While we're here, finally rename the db410c and 820c defconfigs to have
> the qcom_ prefix.
> 
> Tested on qcs6490 and sm8550.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> [...]
>  configs/{dragonboard410c_defconfig => qcom_dragonboard410c_defconfig} | 2 +-
. [...]
>  7 files changed, 6 insertions(+), 6 deletions(-)
> 
> [...]
> diff --git a/configs/dragonboard410c_defconfig b/configs/qcom_dragonboard410c_defconfig
> similarity index 98%
> rename from configs/dragonboard410c_defconfig
> rename to configs/qcom_dragonboard410c_defconfig
> index 51ad265688c4..e93f5f3094f4 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/qcom_dragonboard410c_defconfig
> @@ -11,9 +11,9 @@ CONFIG_ENV_OFFSET=0x0
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/apq8016-sbc"
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_SYS_LOAD_ADDR=0x80080000
>  CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
> -CONFIG_REMAKE_ELF=y
> +CONFIG_QCOM_GENERATE_MBN=y
>  CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_BOOTSTD_FULL=y
>  CONFIG_OF_BOARD_SETUP=y

Thanks, this simplifies testing U-Boot changes a lot!

Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org> # db410c

Thanks,
Stephan
