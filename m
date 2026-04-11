Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5131E937E4
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3ABF840D8;
	Sun, 12 Apr 2026 15:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DLXUE147";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B0398416F; Sat, 11 Apr 2026 17:39:55 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9943480077
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9d9971d059so149476266b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 08:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775921991; cv=none;
 d=google.com; s=arc-20240605;
 b=UGq3HGHvtbM1JvH0fpTq5DbpLwQGi1/EvjZ+JQjRokDdPh+ubuuaI6SzvQVBfbut1a
 eUUnk5tR0JyjMWPWvSvWXgKe5k2R5pR5ATbk/Ri7q28NjYjdn2NHPK5PstEKk+Ij4jMc
 NJ9zFYnBAcfdzFzJmRmUTBMT1iCe9qPeFcY7isnvWBquIPg9ywVpIqvkJrGSYEJhX/4W
 d34nsgrn/mnKmNK0oT1smwYm+aXSSfg8bROy7R+n7yY60zsL7OoqdLLiN5sTFSVUoyKj
 P/e5s9o5aGW/a/5tl3kka326AcCfFvQ8ZxXlu9sP+XhT3ukMI8NlAnMVdZV3kzx44xXg
 qCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UdrUfyEqULAcgfrOARrOufKicBloaOfLdXMb0ZI8uL0=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=G35PCxjjrbXzRgeFzmfrapNFFeYlmw4sVxkcqZE2onY+46Zs0LWwSZN5NWZGKEfGq7
 Umj39F5k4ECr9y9Vooyyrdlc3+UEhX3Qc0GnlDRJYrQYMvNpQc8i/lGqjmYNDUjPKx30
 59VMOG0V76dTZOHNCXgYmGro94x0zK33X+ey3z4YMwTz14s7hjqGO3XmxmABy5dX5bPM
 HvAtds+wBoGFU1UFzshrwSIDba36HJx3c3DMfH3FDVvChMj8eM2tX/FUjqULuJX/F6oC
 onwDcdEF6V0d+QnSEfUIsBwNjKWBbZISCC+Mxv2AIpji/rEgURVwSq8j5OH6IuByExer
 lkUg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775921991; x=1776526791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UdrUfyEqULAcgfrOARrOufKicBloaOfLdXMb0ZI8uL0=;
 b=DLXUE147eR6ytsBgDXu3O0YjyRVqMeKcW9i3wzG74ooQFzkftx5q4Md7Z8foFZdlYc
 i65A/Z5w21Su3ga2jPkefjdO5yWa1iwwNmKx0hweC1WOlIlsS2ImrQRKXUEAKEnFyu0F
 0cGxzM/I4ZaBeQXyd6uV9iqXtFS605SX8rRVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775921991; x=1776526791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdrUfyEqULAcgfrOARrOufKicBloaOfLdXMb0ZI8uL0=;
 b=jBDNPmJiv4ou6aFW0uehvqHdhnlvZ/2c4O+7dXYjc3KcqkJYaLtVCigf1GMSX1F8UR
 nwZaLJ0IhKeOR3ZaqR7IYlkc2rsdS8ug8V649eDbukVeO264/KLoD6v7GMzuOEK8cB++
 EjlkAva10KdepgvTOYqru8jfu11t31pVNqgp6zbpKlUtgrDM0aVY1pQQOXfMFz9VYbi7
 f+2qKMzDeTGpe7kGQwcKxgc50PT0NwaHvwj/3LGj5pEXOX0KM9jM8DygLqv1dlxzFo4d
 /D09gFPwKjncfIJTfNIymxdEyDktOKqCnF917Fr9J2tZHhAIg4tdEXgauNOLDUQLEYpw
 JFUw==
X-Gm-Message-State: AOJu0YyOaYw44CMSoN1Wo5MoB2C1w1apwY2m9BZbEiQU/dZLZt1zrB+s
 nfE3/RmlBiXEoh2vB0UmD1ab3J5ZJDexQVgMinw1HPHq8HMtPRs1gHcjJvuqwqUl5ikfvLzPB5+
 mhEu+xP53br3I3Wd7NvzKgKfzn0V3k0hOtdpmbaYa
X-Gm-Gg: AeBDievQ9kbjW5dGN6z7Cf+j60+jD7SN16HArQKzFoakVpV4uQhr83qTCnLZrViUPAy
 vZ5cFx7GN4n//Z0BEpzQvRuk28iHMaw7KxkX7Fymk/oGZSvqo/K77yH/aKSzf3ea2VFT+vcCR0X
 GcdM7l28ul54816La8303GiQHPerNxYNWUH7HG1A4wY58lTfp7ZCVBuN/QcuwsLE4msDeqTtItE
 v1UCcCr1Qq9HtKBKBuxaDBzzLS7jhjQmVYYBNSxu4UHxEdZf0gU92Gi6xuo6dQPrA0vMTpbQt1E
 PO5Xcg==
X-Received: by 2002:a17:907:e981:b0:b97:1d24:bfed with SMTP id
 a640c23a62f3a-b9d72991f8dmr426387666b.41.1775921991035; Sat, 11 Apr 2026
 08:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-2-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-2-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 09:39:39 -0600
X-Gm-Features: AQROBzD2b9X-ks8b0dsLfVn5ZY4qBEsR_MFqaEmeMgDVFAesD85kualbwckgqxc
Message-ID: <CAFLszTiRS3StJyTBw9gCiTpgA84nJifF_gdx7cDk3Y_759020g@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] of_live: support in SPL
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
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:00:19 +0200
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

Hi Michael,

On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
> of_live: support in SPL
>
> Add CONFIG_SPL_OF_LIVE and if set, initialize of_live in spl.c
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> common/spl/spl.c | 11 +++++++++++
>  dts/Kconfig      |  6 ++++++
>  lib/Makefile     |  2 +-
>  3 files changed, 18 insertions(+), 1 deletion(-)

> diff --git a/common/spl/spl.c b/common/spl/spl.c
> @@ -510,6 +511,16 @@ static int spl_common_init(bool setup_malloc)
> +     if (CONFIG_IS_ENABLED(OF_LIVE)) {
> +             int ret;

This shadows ret already declared at function scope. Please drop the
inner declaration.

> diff --git a/dts/Kconfig b/dts/Kconfig
> @@ -86,6 +86,12 @@ config OF_LIVE
> +config SPL_OF_LIVE
> +     bool "Enable use of a live tree in SPL"
> +     depends on SPL_DM && SPL_OF_CONTROL
> +     help
> +       This option enables a live tree in SPL.

The help text is sparse compared to OF_LIVE. Please can you explain
why one might enable this in SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
