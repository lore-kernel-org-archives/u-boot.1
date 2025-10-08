Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF931CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC83839DE;
	Wed,  8 Oct 2025 16:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rc6OAEpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF33983C91; Wed,  8 Oct 2025 16:31:20 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA7C8839DD
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so7842065e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759933878; x=1760538678; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ocgch+o3mh9DDw3N3PV1ykL2Xm70gKgK8XhP8oy5TAc=;
 b=Rc6OAEppHdW3a06qXBGCCfx9q2bRyxgxOrWhEUZsI+E4+B//x1k5/Ff6AGU/o9Zai6
 +VDb7eSwx18qSBXcIhcIVySCQ4gk/jQpiLFLTh5hS14HZKoJZZ3J8tf10B7O3oyCf/dX
 J/GqnWyBp50A2mX20DN0kbTZGI5laPQLdb/Kups0iqtRxpqi3K2A2ad9eG0g9haf1urG
 xnXp21t26sxW9VrHm7j75FGzYfZdDp0p67RONnv1x3xDUnBFySkk6dGGh+LOQgDFfOoS
 eBx8Cp1QakzMnSbA5TqSbMqmeG6AOjiak2c+cyJQygXbFlKPxGr6rDwq3en7zOZBkDRN
 1OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759933878; x=1760538678;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ocgch+o3mh9DDw3N3PV1ykL2Xm70gKgK8XhP8oy5TAc=;
 b=SoaG2KzSji+Tcav0RvZ/i6BlysEPbhd9aMaKRHzqaV7hhmXNx92Ce7vWgKhr+pUjvv
 FXti/dTm2CR4mGXNqLniNQA1xfd/6ZiMz6MiND/qodhzR5Mc1LUzGSBM6+eyZwWfY44q
 E6PAq9+YfXr3ePa0cpK3t09CR3u4j6RmmWeni0A1lO0Z3dzXzWZziiAVEuhl+Nij9ohY
 x8eViiI4jgNj/NSybgKtsUvKf1JixGaMxsgm9yVcfiby6ZiDDoeaGWY5TbfdNwIydy1b
 E8f8X8NcGbUjtJvWU5ULmUKj/WEa2GC7+5YlBxIMFFQ+HZBiCY1QOk/wNREDREQymXFn
 a6Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkoYlNmpAVP9nWC132c7tfT6ewqL9/WoWxE96RnhRakQwOn1g7ZRtBKh1D9LOfsjikAi3WEtQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzmZ2hd0d3tNfEyV1BCkQLqjpi0szkAeK30DDDLSfYooRSljD8/
 ajDe27QlzZ7alQw48+6+kMTE07sFhowtxyDgwWZWTss6rZACBqkHVAiL
X-Gm-Gg: ASbGncsZeE/Nuz45bbpw+d3O3vZUHxkbA6QFluU3l3+d+fXEB9rN3G6cDTZAwSlirOg
 uf91SZlLmW3TuX+o3yljWwh7Ij8Ue+GGPSCHyIbghOf8eILETG7pVan9Xvkgd6/GsLOkfbOn0vp
 OaDfLAJAl2y9njUda/mmfI6JYNYzaksSw8BxGr+GeUj1UMVVZxVvIBC9Nw0U1j4VR8xHIIzsoTI
 C6xARuH6kiUIFyNWbfe78ywYBM29SD1jtxiDwkgo3t7aIqym5haWkyU1FWbglgHP5WyO7d4Ikqt
 82AnI2r1xU/6MJxg8Usvh2GAtDG4iVc3Y6sBlSEj/AXRzswKZF9Gp52/EZRefUfO0ZtLo16hjU1
 Y8oiOU0pVvK0UIR8mHA+ZzImJ6HGnBz/zJGX1bBG2tOAFrMmacMimay1udSpSGO76a7kTSsfdlj
 vvezChp2oc01Iw3h029oNiaS1plnY5sw/43+ee9sqRpgos2RTj9YcChbjx
X-Google-Smtp-Source: AGHT+IHIjYWK5t2vaZOJIMtKm46c4NzEM/GovfSVNR950Ykle5FfEYHODOGgcq/5fLkAnzNgv/RxFw==
X-Received: by 2002:a05:600c:609b:b0:456:13b6:4b18 with SMTP id
 5b1f17b1804b1-46fa9b106cbmr29800485e9.31.1759933878118; 
 Wed, 08 Oct 2025 07:31:18 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf16ac01sm1976295e9.11.2025.10.08.07.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 07:31:17 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:31:17 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: dts: imx8mp-toradex-smarc: migrate to OF_UPSTREAM
Message-ID: <aqiht24bdhy77o4b3uk22kyzjcoki546ea56jskrowfpgjb4dn@fqbaeq3truy3>
References: <20251007074503.21624-1-ernest.vanhoecke@toradex.com>
 <CAOMZO5CU5BtAa0DVjSOSa0-Sg2G1CJ6m49VVj2QHWh1=qCC_cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CU5BtAa0DVjSOSa0-Sg2G1CJ6m49VVj2QHWh1=qCC_cg@mail.gmail.com>
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

Hi Fabio,

On Wed, Oct 08, 2025 at 10:50:42AM -0300, Fabio Estevam wrote:
> Hi Ernest,
> 
> On Tue, Oct 7, 2025 at 4:45 AM Ernest Van Hoecke
> <ernestvanhoecke@gmail.com> wrote:
> 
> > diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
> > index 74416a788473..c5da27bc366e 100644
> > --- a/arch/arm/mach-imx/imx8m/Kconfig
> > +++ b/arch/arm/mach-imx/imx8m/Kconfig
> > @@ -296,6 +296,7 @@ config TARGET_TORADEX_SMARC_IMX8MP
> >         select IMX8MP
> >         select SUPPORT_SPL
> >         select IMX8M_LPDDR4
> > +       imply OF_UPSTREAM
> ....
> 
> > +CONFIG_OF_UPSTREAM=y
> 
> As you use 'imply OF_UPSTREAM' in the Kconfig, this
> CONFIG_OF_UPSTREAM=y line is not needed and can be removed, right?

Yes, that is correct, I will incorporate that for v2 if you prefer.

Thanks,
Ernest
