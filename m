Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E57C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 13:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C6E812BC;
	Fri,  2 May 2025 15:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fYtN5/72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4116F81E72; Fri,  2 May 2025 15:12:11 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DEB801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 15:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso2906600a12.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746191528; x=1746796328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N/tA4DcY8MFREvYVjAtAxPjfT37qyiCx/CumSja3Wxo=;
 b=fYtN5/72AS4Jy8kbYGIVcyZpfML5urFVt5KNyu51qLG4cgfRvTwQiRh1f/GpHRAcov
 tDSpPzmnxVsWIT+fMVhjQLdOrlKYtHGF9LpoCURQaBEAHCNp3HbtzzlDfie0QnB2u7yM
 MEaH75xSNsGMOmwtt/aw7RYyajsbq5roswYDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746191528; x=1746796328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N/tA4DcY8MFREvYVjAtAxPjfT37qyiCx/CumSja3Wxo=;
 b=tne2Q+3F8W54XS5I2h7kJdCMOmfeRU5LwRNxCOv+pdLTiCB5IQBC+KsX7ubx3gi6R4
 vjC0MNwDJHEVPMELRYSILkjJrkn/rj2bms5i2oXR3o0pA+JqMCB/T757sPfpIxNtpuE9
 PM2KJZzzVS9TLmlIDbTlbMBgB8sJC3mxByv3396nJjHCfxHQbvqud3Gf3ga81sDYW1EO
 Q3EBz4/eHJW15yHxBKXJisWV2YaUj7dA9SwxeekKvnf98Lj+uqy2IlRpWINijPxomfUr
 h8FuwDzoTYJN9G5NX86Cu8slxPoRFdE1EEhFITPiXkGyF6NkqD6cLLUzTKcj1u71rrYm
 nSEg==
X-Gm-Message-State: AOJu0YzWUcuLUxLAMZBaLdRX+m/CI8ji6+gOuwHSIggfYgpCksbQQWyi
 4OHQGk/sowenWMWJAy23+GtujO9Rg6tSBz5wuXsSJX6tJQQ2c9ZsIumrVj4MqZtwhpCspsZ30ik
 MKe8oay2ykPvP85/qNh7HcpzyKO8K5TKshVsj
X-Gm-Gg: ASbGnctLBsHjfu17lwoSbtJIpzCwWK3PLIqVj2d7OieQeAYeBf5Sd0W7gwd9ypHR2Ct
 P0TBOFjSbWo9SQ9Ur7m56CN7BiDzCBxc5Ri230pieiS7EgT2TQI1DAf1AI0HGXyAtIXgqryCwKS
 knoHVY7iM+H3Z7abkPwSg8ulw=
X-Google-Smtp-Source: AGHT+IFIWTv08oYvEPw765oJJgWHB9S7HIruzCiOucySiwShArYUT1bOKskExzMBzrvpkYHThmwLWGXOISQ1Uexa0gk=
X-Received: by 2002:a05:6402:50c8:b0:5f8:b48a:a2d with SMTP id
 4fb4d7f45d1cf-5fa78018af5mr2503657a12.10.1746191528257; Fri, 02 May 2025
 06:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
In-Reply-To: <20250501153316.GH1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 07:11:56 -0600
X-Gm-Features: ATxdqUFFQrYEQ5oJMaGtHfvKXCa_Y6JIpVabNwsxeD_PFx3NGu2RbnRkmyJRmx4
Message-ID: <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Oliver Graute <oliver.graute@kococonnector.com>
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

Hi Tom,

On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > > > This file reads from the environment but does not include the correct
> > > > header. Update it.
> > > >
> > > > Drop the unnecessary config.h while we are here.
> > >
> > > Are you sure about that? It was explicitly added in commit
> > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
> > > includes") probably because of CFG_SYS_... usage.
> >
> > Well I assumed it wouldn't build if it had it, but perhaps that is
> > incorrect? I understood that CFG_ things had to be values and you
> > couldn't #idef them?
>
> The cases where in that series I added config.h were for good reason,
> either failure to build or tricky size change reasons. All were
> intentional. An audit-and-remove of config.h would be it's own series as
> yes, there's perhaps not the need now as whatever complex chain was
> unwound.

Oh dear, OK. I'll respin the series.

Hmm but I see you have sent a series that does some similar tweak[1].
What was the goal there?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=455004
