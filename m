Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F026FC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 798AC865AF;
	Thu, 24 Aug 2023 16:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Th19DhK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3F28653D; Thu, 24 Aug 2023 16:43:47 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E954865AF
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-523b066d7ceso8595997a12.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692888223; x=1693493023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lS9AnjAc5vOpuaRheWKVWJTcL0st0cTATH/ZCzfIwTc=;
 b=Th19DhK4azYhc3GWFjyenE6eBPTCCrC+A7s4/pJ0z8Ux3bPKzKwxy+soEXvV+5EDe2
 O6x2IpaJz3C//W94RGWzzgv3Ni5DEHB/D+ZAreaBj8PsJzg+/ILEv6CEH3yiI6rGZWUQ
 lpFrwdaG9XIfx5ucI5XEOihpvIwyUfjX0SxPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888223; x=1693493023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lS9AnjAc5vOpuaRheWKVWJTcL0st0cTATH/ZCzfIwTc=;
 b=dLezp1gLcvhtlcKhw12Elcrb3YSX2FRnUA8qMtcKnqu79M51bTXo9oR+lAUJ7rVu3B
 IBvyv6Qv5cVuoDYC/h6961LVolYuQ36tREIjbNMBKcncIOxfxnaQa5yniQAiEacNwnrs
 nBPEK91TuDAzhNEjdnJmeJM5Ng9I3DyjRAzIUhpbvZ+phtCh6P96Hiej97gSWASPVzay
 WakQEAlGQk0B2gBiIabFhtzfeAKgGBjpt/EJ+58PLUiE8RB7bwCK+UiEK1ZVMR1hdMiz
 q32aZOFEwQzGM4K1hXMoHXfVti/AEW0W7KSNdwvqURBwufhhCJ5WNmO7ljlic8oVUcs5
 +6Hw==
X-Gm-Message-State: AOJu0Yy94I6StwlkBxCWmLoLKaTOIuwbTAs3p12ebLXupM3fjCm02p6p
 6l77Pw2rsELrtPnzH7fZZrMqahwf3yQ7gricuroIuw==
X-Google-Smtp-Source: AGHT+IH7UhTc7N76QmBeYUbPfTk5vH0JaT962GuPchS5LH7KrCulJ8BrDim3EPG7eLfbLivyKCPewLfu+PSYHt2Yz1I=
X-Received: by 2002:aa7:df89:0:b0:523:38eb:395f with SMTP id
 b9-20020aa7df89000000b0052338eb395fmr11656959edy.2.1692888223537; Thu, 24 Aug
 2023 07:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <9f4019b9e46d3fae5bbfad6d06ff6bf9@walle.cc>
In-Reply-To: <9f4019b9e46d3fae5bbfad6d06ff6bf9@walle.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Aug 2023 08:43:32 -0600
Message-ID: <CAPnjgZ0MNb5aAtmz9Yk+JiHxQt+qwhQW=WccgiiRRqfQ-a1OBQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
To: Michael Walle <michael@walle.cc>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
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

Hi Michael,

On Thu, 24 Aug 2023 at 01:32, Michael Walle <michael@walle.cc> wrote:
>
> Hi,
>
> > This series adjusts binman to enforce just 4 extensions for output
> > images:
> >
> >    .bin
> >    .rom
> >    .itb
> >    .img
> >
> > Other extensions will produce an error. With this rule observed,
> > buildman
> > can keep the required files.
>
> How does this work? I didn't get all the patches from this series, which
> makes
> it really hard to review or ack the individual patches.
>
> Are we just whitelisting any files with these extension? Honestly, this
> sounds like an arbitrary restriction to me. But maybe I'm missing some
> context.

You can see the full series here:

https://patchwork.ozlabs.org/project/uboot/list/?series=370121

Regards,
Simon
