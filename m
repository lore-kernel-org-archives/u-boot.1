Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5D9CD8CAC
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 17:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C946A86B29;
	Tue, 10 Oct 2023 19:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TVBSlePB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8799C86B84; Tue, 10 Oct 2023 16:57:58 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE21B86BD0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so978359866b.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696949875; x=1697554675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/xYi/UoFLZktIk4JyrmyzNKbzCV9phF9qWayLQ8nc+Q=;
 b=TVBSlePBGprFlfVkB5GDgDW7/N5NNeTV4LXZcSqj/wYWzjc9Zh73kXc83nOH+hh6Tj
 XjBTpBm/S9n3IUXW3ueFgC8e4BAH3TFa3SSVyUl+4UytzgjXnTbKQpHHbAOKeJeBZX7H
 H6PCLZ1YHW59RpYG6rnIjO4nWZEy2ZJH6gwjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949875; x=1697554675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xYi/UoFLZktIk4JyrmyzNKbzCV9phF9qWayLQ8nc+Q=;
 b=ijP8y5BmV50ciikdmKKY48MzkplOtP9j9QdU6skCI37JB0nvv42rTpLqq7BH96gXDo
 TRk6qCUHYh9/N0UknWueIJLOA4QBw5/Nj+oNK6fRV1/NBLs+Qzu3W9lIs5DpRkjGPhEt
 6cuDYFNDcIUhuUvqQQRJ75wq19D/0lGpQyc++B/bnPw0oeyFAMJl1z+0iNAonE/iL2dr
 /1zomzunNc3csPGYfEruthZYAahh1OC8hGSHkKFS49lEyjHAH+7ZKdvMcEMEWh9RgGy6
 WeorqT4PwnAcnZap7oYoF/IfwL0Oc0SbYfIKT8lFEGRsac+KzAwatz4iUiwd//1ng6TP
 N4TQ==
X-Gm-Message-State: AOJu0YxR2duhtswDnY+Y7mNvt9GvwyfiODH6SEPybrnpa+Hms9xqFiGD
 rhgO43KQ22BQDnAcpTv/ZR7jr0QIEiWhfYw1KpeQ3w==
X-Google-Smtp-Source: AGHT+IG0rZTqIZsI811Ro6nTAoyvwy8UjzuRw51saAhD7TB5mabTFFgWWwQ1z/MQb1Wxwwm/VKDmdjvrmp1gSDPT+38=
X-Received: by 2002:a17:906:1d:b0:9b2:9a0e:9972 with SMTP id
 29-20020a170906001d00b009b29a0e9972mr17160297eja.13.1696949875088; Tue, 10
 Oct 2023 07:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230925003732.GN305624@bill-the-cat>
In-Reply-To: <20230925003732.GN305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Oct 2023 08:57:44 -0600
Message-ID: <CAPnjgZ0ftGXFn+a_WeVSY4mSWzcRz0kEq-+n8i0Yv3yjFLjMxA@mail.gmail.com>
Subject: Re: [PATCH 00/25] Tidy up use of CONFIG_CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>, 
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Fabio Estevam <festevam@denx.de>, 
 Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerry Van Baren <vanbaren@cideas.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rick Chen <rick@andestech.com>, Safae Ouajih <souajih@baylibre.com>, 
 Sean Anderson <sean.anderson@seco.com>, Stefano Babic <sbabic@denx.de>, 
 Stephen Warren <swarren@wwwdotorg.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, 
 Tom Warren <twarren@nvidia.com>, Troy Kisky <troykiskyboundary@gmail.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
X-Mailman-Approved-At: Tue, 10 Oct 2023 19:54:35 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Sun, 24 Sept 2023 at 18:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 24, 2023 at 02:39:18PM -0600, Simon Glass wrote:
>
> > It should be possible to disable CONFIG_CMDLINE and have all commands
> > and related functionality dropped from U-Boot. This is useful when
> > trying to reduce the size of U-Boot.
> >
> > Recent changes have stopped this from working.
> >
> > This series repairs the feature for sandbox and adds a test to stop it
> > breaking again.
> >
> > Note that quite a lot of functionality is lost of CONFIG_CMDLINE is
> > disabled, e.g. networking and most booting options. Further work is
> > needed to make the option more generally useful.
>
> I worry there's a lot of "make it compile, deal with it later" in here
> rather than unwinding so that $X works with CMDLINE disabled or we truly
> must have CMDLINE.  Perhaps it would be better to start with to take one
> of the platforms that enables say networking in SPL, where we
> functionally don't have a cmdline, and make that build with CMDLINE off.
> Having *PL build and link and work with CMDLINE disabled would possibly
> save some space too, which is always a good thing there.

So long as it gets us closer to the goal, I think the work is valuable.
Also it prevents additional regressions from creeping in, at least for
sandbox. I am under no illusions about how big an effort this is, but we
have to start somewhere. To me the easiest first step would be to decouple
bootm functionality from the bootm command. Likely that would be <40
patches.

Regards,
Simon
