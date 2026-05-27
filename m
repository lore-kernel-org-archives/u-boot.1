Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0F8CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 05:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B55FC844CF;
	Wed, 27 May 2026 07:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fG7E1r91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F6C18469D; Wed, 27 May 2026 07:47:45 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D6A844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd8f9725b30so1255924566b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779860862; cv=none;
 d=google.com; s=arc-20240605;
 b=IyOuxGKLCRy6Nte9ug5RKHtOpE+2QfPurEDRjSeOD/gTW9SgLjmiVhgRR+zBzrDLcP
 89tprgWBcLYbntCpWdyLxQf6oh8cLG16uSI/vsbkc7kPbyPPLs4qut0eoeIEYxpabQgB
 SElIgZp7BX5r+VSqZl+Amf4L4rA69WyKaMNPGf5uuCy5kTlhs+ItfO1w1Kk+7wPB3L8i
 Q4sgzkx6yiDuJIPcX+a5KnuIZq9A+iVLR1o7Ws5ClyGF4I3V/ZsHV02cFQlhFYJxM+7u
 MUUHhxWhLW1Faer4AAbTLj5ZiYEKkgPIFCvj5+P2/Ey+VduOaojwlzXc1gL3xe+PKwOB
 Yh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RISRoCZBTQ0MXkJsPKPoGe9Olf9SbzWivcYTucH4ZlQ=;
 fh=s//ozB9giFtaGJzyxMsnBLiI9Gy2/7GPCAEIL7xdYJ8=;
 b=GexqKpq4ZmOvLG9v6UDFPvaRWnsyHinTG0XshjbjHkHIaCqVZVMcEbQzowPikB1H3S
 RWGwBiBYlkHBL0rmjW+2wBHhD7FapYtRmQgyZhKxdRbDulszWb3UJ+P+pnNhMXTww8UW
 eHWGPz9oTssUMk7DAzPcwe1eV3faz9YsGhK38KnLyQdeDOl9L1sUkFTwXPeoYKEHI29f
 MzPY6N/335GMBjP0rqA14RK0i7qciujzKMo0D/k19TaZkob9rh4LkYaPaYddZBOKg+TR
 KZ2D5QM6P85CUQTNFivlKHJHaRajkbVZnUZV9pOEXgBjBYs/eYeB+wJMOHPnsYigcw1b
 2o8w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779860862; x=1780465662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RISRoCZBTQ0MXkJsPKPoGe9Olf9SbzWivcYTucH4ZlQ=;
 b=fG7E1r91FVS6PrC7JRYlUQotYnqQHqBoLOeEGdccLwxJuVG+tijUrLK7Amy4qINrtx
 0ePe8wz68v208Ccp/YbjjlgXHmTjo28uorCGlJMqsDvvEVGfFn8yA9ym7Tklm3op4ClF
 0tH6KC/d34Sr7wnSXk/Xyl4JEbcBF2YF/QLXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779860862; x=1780465662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RISRoCZBTQ0MXkJsPKPoGe9Olf9SbzWivcYTucH4ZlQ=;
 b=J5dT0VH1/FM9HgnKvzYlq8uX0rItCp/L2GLWwQvISa1Ez90K/q8mqRUMe3fK61qSz6
 gkHKnimF9pCcuH56HLfkSAIBoxfwkUvXgSuD+1xhVp3vuNlWwkWH1JrBBwtXnJMAb+Ss
 rt6F7PrJzyOkj83s/9WdxAW9/rYAabOFrZ5kTsJi/tktvqZZPz744JBAsjF2uiYCFcR3
 xRLkZrdR+flmiFou8SPggWSiiJfxR0qbpbsKO4GMr+z3iXDVTlwOe9azTwHuOyjvlahw
 Fu8eVn/8cu4Z9aSCRgIX0v8hvU3WOr4N3bblrcxjIWu0BWvnDzqzHTNwkvHgQruar3mi
 CWqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8f9rvcxgQsQkMWoQIvJrNiyKw5bF6VbvSsENJ2c0cw6uqvS+mKnI+kmDsivFlmQRJt5GyWETs=@lists.denx.de
X-Gm-Message-State: AOJu0YyV/QbwQ3jGvHuzDzyaI94Iz7TPZ9ffmzZV6zFhGOv8iXtDWZAI
 bx2DxykyVe25GduVNcV+mhOZ67okGozNRGzKPet5SupqYkyqcqO2151M5AlYyRGykPN6fQxS7Ux
 0g8gzaoTGeApO3k6iZTS3pLuacDeV05nUZkVP65L8oABGoMH3weIeDisGh4OKXQ==
X-Gm-Gg: Acq92OGecdUHg0wePrI000i3N50HFZq9k3tYUrgUCT/cuIfRA3Eg3oczvWdHlmx+iXa
 ht+fUeRFxjp9B3HDkfP8w1Kn10wMSOB7sgEHFg9D+Wi05SwgFfRhbMYIb7wh6kM/dciblkPG9OT
 1Fc9xYn5+UEzYXIMfvPNJtim02eDoR7fK+g7TJy5aPcim6M84Gk6N6PhhQlpjJvT+3kS1/mgSND
 CrG9ZlIPiClA3XT7Xd06qRBB9VieroZzgb6tZXrnkcAFA5SZ/5pgmdpbAk+sdp5Kbrc+FvcbIin
 tlELDadmomZ5Owr8
X-Received: by 2002:a17:907:c80c:b0:bc9:d864:2735 with SMTP id
 a640c23a62f3a-bdd2aada46fmr1329066266b.34.1779860862493; Tue, 26 May 2026
 22:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
 <20260527-devfdt-spi-v1-4-37db1f6c168a@nxp.com>
In-Reply-To: <20260527-devfdt-spi-v1-4-37db1f6c168a@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 May 2026 00:47:28 -0500
X-Gm-Features: AVHnY4J84HHUYSDcJV3NB6Ws96pt5dRMv27vkcAwOIwq8vS7qaARsU2Nw4utNqY
Message-ID: <CAFLszTgQg1BzFi=NAYfzmLdBCCRF8a3BLaA5njpLeBo=ppJVow@mail.gmail.com>
Subject: Re: [PATCH 4/5] spi: nxp: Use dev_read_addr_size_name()
To: peng.fan@oss.nxp.com
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
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

On 2026-05-27T02:35:23, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> spi: nxp: Use dev_read_addr_size_name()
>
> Use dev_read_addr_size_name() which supports both live device tree and flat
> DT backends, avoiding direct dependency on devfdt_* helpers.
>
> Also correct type of size to 'fdt_size_t'.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/spi/nxp_fspi.c | 8 ++++----
>  drivers/spi/nxp_xspi.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
