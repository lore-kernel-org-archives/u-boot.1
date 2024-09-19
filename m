Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33241CF3963
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 18:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C12B8927B;
	Thu, 19 Sep 2024 20:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WSngMYb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87FED89194; Thu, 19 Sep 2024 20:26:22 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A5E8927B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 20:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f78b28ddb6so11816841fa.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726770380; x=1727375180; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Er3K0b/z21VuAlC5PrRsOddadQ7MOsIyZpVX/r2Fs6k=;
 b=WSngMYb/9/uRVKXk5P1KU5k1IRuzGbPkgtpGFxQU8qVDFvUspbLzIxVuFv0wkN+G99
 9Lp4eFIv2PbUakAUeBlRw5HuwOmnQVTc4IDVqyzFShU0SaRRLWpj0kFuW/hdiDnBxgTW
 iIUq0XqsdaE6pekIMxGgIaYVGmt5ARXUdtaeZ8lBfhdGVIrzpwvcxcOZvshmUR586hO/
 YkK6CpLaZoLngADA/34NstkrB6Coo0JIvhS4YXskMQm/opw4SKpPxirwyggZEL9je17Z
 gS4v6Ay6+qxK34KB2E/ikDM6fgLVt5qUtYLgiyDug0W9vihVyPM2FFAidso0gAjk/9mN
 vqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726770380; x=1727375180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er3K0b/z21VuAlC5PrRsOddadQ7MOsIyZpVX/r2Fs6k=;
 b=kUmaxFHiqHtkUMZJICCWHdr3e4hgTIwr4O0MQFvpr7uUUig81swUSLM72g1qNZS+9O
 lTnPtR3B3253mCpvb7JkCzyYpkDbwVDPyM4B2dde0WBaMO01AzaEZS94P2jnAPgExfsD
 BhT0QjsWO9HFHKCIlwcpWrOF7MizR06xOfnWVjgK4ItXDiVWfbjvz1GMief+LQISPTic
 UFyFKb+cICf2K4VuCY83qPNqY5tMiUeFAONe3zBkcgE2x8D8KyVUlaE8xpzaQFkYaq8/
 0WVu+kNxdSlwx7mIxCtdRBjV8DUIpvUxNnO/dble/mBwU3Mcgkad9XT2RmLXtrfnyIuE
 Yevw==
X-Gm-Message-State: AOJu0Yxt6K5uvkbqz7gO6Ti67aG9cH+IG/raDPQCmX9fJY+AsdNTrRn5
 YSADhnr/1rrSFyDNU9FGUmNnrcWdQ+v+jeGmNhmrrlZGgLLoeMyFBrvmKQJK9Ynx3NTW3tGR0Ah
 Jp6RrG/Gh869bf9BvDX2LAp+rozw=
X-Google-Smtp-Source: AGHT+IGyCeT0vwxIaM4C3CWU0hG2/uuMp678l0LRSHIUn6LVvxm1ZoOczhtvzYNwPIoWm+8F5F1Q7Xz9M62Y1cH7ZYg=
X-Received: by 2002:a05:651c:1992:b0:2f7:4fac:f695 with SMTP id
 38308e7fff4ca-2f7cb2eb81bmr3194861fa.14.1726770379535; Thu, 19 Sep 2024
 11:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240919144507.249682-1-konnorrigby@gmail.com>
 <CAOMZO5DKD0ZziHb8YmKdz_yxCx--vLyydC4wFK5MEQVvB8mddg@mail.gmail.com>
 <CABT61E519kNCDyCXh_kY9vLib+fEsR+JiHqKKaRvfZh0YbSXAQ@mail.gmail.com>
 <CABT61E4kB6vdfSG4Hm2C7fGFqnpCuo-AfJ1QZb_HmYObBK96Og@mail.gmail.com>
In-Reply-To: <CABT61E4kB6vdfSG4Hm2C7fGFqnpCuo-AfJ1QZb_HmYObBK96Og@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 Sep 2024 15:26:07 -0300
Message-ID: <CAOMZO5CCfCy1b5n5AqyPXUbaxZYr4rz+7TX2LJ-57JwVYWk+iA@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: fix board_mmc_init for google coral
To: Connor Rigby <konnorrigby@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Marco Antonio Franchi <marcofrk@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Connor,

(Adding the list bak on Cc)

On Thu, Sep 19, 2024 at 12:55=E2=80=AFPM Connor Rigby <konnorrigby@gmail.co=
m> wrote:
>
> Looks like latest does in fact work as you say. Sorry for the noise, shou=
ld have checked this first!
>
> U-Boot 2024.10-rc5 (Aug 30 2024 - 18:42:43 +0000)
>
> CPU:   Freescale i.MX8MQ rev2.0 at 1000 MHz
> Reset cause: POR
> Model: Google i.MX8MQ Phanbell
> DRAM:  1 GiB
> Core:  67 devices, 18 uclasses, devicetree: separate
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1

Ok, great. I'm glad it is working.
