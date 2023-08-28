Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BF8C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FCCE8654E;
	Mon, 28 Aug 2023 19:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kec0ShwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7DA86552; Mon, 28 Aug 2023 19:56:22 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E77186522
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5920efd91c7so40690567b3.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245377; x=1693850177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mYaEHmERvHq14VdKDotQkz/ye/JDmXVAkgt/7kSqbCs=;
 b=Kec0ShwALVPHNn6XHFXnUeBo3vqQyFPAKnQLIAH/OEMF4gEiRg8p0s5rbRAXffgFPr
 NsmJJ9dmCrPuthZxBOHJMwlwbuUJI8jFEgEFLGPhTeZOmqLQO0wVpIz/T3AR9FcPyJNP
 eVecUz1/PekSTdY1t9o6NL9IPH8cezKIByh10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245377; x=1693850177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYaEHmERvHq14VdKDotQkz/ye/JDmXVAkgt/7kSqbCs=;
 b=bJ08rE2EwNjwrTjjQp0EhNbz/elwbRt9sE7czJSqAAIMNUHz7yfTLZ9uQjNXMR78jQ
 mGCRc/JtpVIHkMuA48rVIu5Xf0KK1ulmYeJJ3O5BQ+Q4DWWSy9HGyU+xOP0tMT3Zg+9l
 mgklG8HJaYZpMVAYIETFoiqWXWug1U6+mEN8JzRp+t4YSAjOgGNSZJTxK4ym98Y0pT1D
 tD9gXTgKr9DBW0/o/zUDwV2Qv1LklZsVyDBlGGfVQhFcUHHnTIb8DN/mhg3tKG6V1zg6
 4ZAhtSE6+kt688GK3C198QRWrbSWY/0kxvQRL30G6SLQxO9eOis3G2T8h+T5Wx9PzXjn
 IS2Q==
X-Gm-Message-State: AOJu0Yzae0A/6q6shdh8xrolIQ9Nop/otEI8pWPGgvSJmxw0cjjd7aCw
 RfcLTBG/hj9c48080k300NQisZ1Gz8M4N/DumC9Cpw==
X-Google-Smtp-Source: AGHT+IFZhHyXxU4mK58kJVS2rSppbZSRzsXWuOOwSXUfcbssaZio/mE650D3BTGWIt0GNkE5ukEPwoCBrjg+UTN5SMw=
X-Received: by 2002:a25:685:0:b0:d7b:37de:2f6e with SMTP id
 127-20020a250685000000b00d7b37de2f6emr1846047ybg.39.1693245376665; Mon, 28
 Aug 2023 10:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230824030304.1555547-1-sjg@chromium.org>
 <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
In-Reply-To: <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:55 -0600
Message-ID: <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Dillon Min <dillon.minfei@gmail.com>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>, Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Alper,

On Sun, 27 Aug 2023 at 13:17, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-08-24 06:02 +03:00, Simon Glass wrote:
> > In this early stage of using binman to produce output files, we are mostly
> > seeing people using common extensions such as '.bin' and '.rom'
> >
> > But unusual extensions appear in some places.
> >
> > We would like 'buildman -k' to keep the build outputs, but this is hard if
> > there is no consistency as to the extension used.
> >
> > This series adjusts binman to enforce just 4 extensions for output images:
> >
> >    .bin
> >    .rom
> >    .itb
> >    .img
> >
> > Other extensions will produce an error. With this rule observed, buildman
> > can keep the required files.
>
> I dislike this limitation. We know what files we will generate, they are
> listed in binman dtb, so we can add something like `binman build --ls`
> to print their names/paths for buildman to preserve them.

Yes, it would be good to have that...

But why do you dislike the limitation? Do you think extensions provide
useful information? I suppose one problem is that *.bin might pick up
private blobs that happen to be in the source directory?

>
> Regarding the output directory suggestion, I think the binman outputs
> (not temporary/intermediate files) should be in the same directory as
> make outputs

Agreed

>, and the Makefile should default to O=build to achieve the
> "output dir". I'm not sure if that's going to happen.

I would quite like the 'non-output' file (i.e. things that are not a
binman image) to appear in a 'binman-work' subdir of the output dir.
What do you think?

Regards,
Simon
