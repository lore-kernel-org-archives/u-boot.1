Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F9BC369D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6ECA83019;
	Thu, 17 Apr 2025 14:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bbd1vzpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CDFB81F45; Thu, 17 Apr 2025 14:35:05 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A88483046
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301c4850194so497675a91.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744893298; x=1745498098; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFNGPgNPLTq72hFOpsZAxji4N4YBtoIOGZUYwACIkZw=;
 b=Bbd1vzpPCJZWsrdJCbrk8a17USyfW02Vlq4bSCE+l5LOUDKak2UXHAr2tM8miqrSPU
 HQcEAqyCj+7uRghflymsTeszK7SWtE+uQ315aSqV+Y+BZplprhR6w5VvaO7IS8/uy/BK
 BmrY78BAzgt2d3mDabiFr2F62t5PTrJeQMf+rb4RSk3lZQV0eJD4zUQaYjyrYyKT33II
 MhuZGGiz3oyEcT/pbG/L+6kPoEPe26oxfUH/XCqyWDoYMDVQxgjxGV/KA5CzJJwSfT8z
 +/N/cUX5ea7rB4KfxT2U6sS/poq8smlTCdu9/dy/OJncYCONlAKI31Act00OV3o2TeiU
 teig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744893298; x=1745498098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFNGPgNPLTq72hFOpsZAxji4N4YBtoIOGZUYwACIkZw=;
 b=B9HYBJcYUKNmQqgZOlNdTRjXu/QYQoxyErJujLFlx396rF0b2doJqMzWYiJkile2wP
 mVD8TuFy/18dF4x4fKw6ue8TZ6uxrlIiUnOC8aDOTgQsAzlTiog3rsGinwpGJq1HEaf3
 1edxOeoGhNdw+/Mb2JUaG1rOfPGzVhHqc7KDvpMSqHVI0JNn0Vn486AUO7ySQ3AjV7Td
 ZZb/tk/oQqc5gYlhP+jGh8ZvGtTW1N78Nzb+WUte1ExZK+aESldbeQP69RK4zkVLw2oR
 9Dd/xO+GcHwVkmIZBeQtYI7qH9nRohsVw692A9Qg3/jr3NDsdp18bAauU0kXlgzxZMlH
 ngCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQipwwojyD/j0CxWtzvqnsQvFonBAIdsDXdaqzGRrDqu9L5mDM2JCCDPzjThpN3HrgivHNyoo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy96lBJjjYJApAZJZIasshEhE/X29tPI2IoLBmVbV+vOV9R3PQI
 7A+/JV1V3STPNEFEbqF999fwZaytFAjt5ikxSWJ5cUbbeBt0wlOQ9DbBwTWNj1Rwls0K1+o11V7
 mnZP1xxmf5dgBjRirhmduBR0b1QY=
X-Gm-Gg: ASbGncsvFqTV48FDU0oIIiZWbBYDsJq3RDwXhVaaOmEJBJXBLbbGw/es9kmT8i30H/E
 WVF7Rf6BPzdjOZ77WvA7WOiWgsW2Enza0MfAkR/iVLSp9R2pgPy7RPy8fI9L5Y+XYhvXUL4Ji6p
 Mp7lo7IwM0cv9pl5ca7XyWvLWCI2mF5+Wo
X-Google-Smtp-Source: AGHT+IFOtd4af3Goz0AKprMSARvNl6nP37fS9zdIsgT/gRcn/beqSVFDpcY0nW1Qc+H9DLGsjq8a9pDvMAjwQwjnHtc=
X-Received: by 2002:a17:90b:5864:b0:301:a0e9:66f with SMTP id
 98e67ed59e1d1-30863f1994dmr10250712a91.14.1744893297919; Thu, 17 Apr 2025
 05:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
 <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
 <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
 <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
 <b35218ca-df17-4423-9932-a2ad0ba14e50@denx.de>
 <CAOMZO5CA0_GUr2uQtQgFHe-9wVDCOQwo5HZzZ4sibXEPMpe8cA@mail.gmail.com>
 <580024ad-b22e-424c-a1a2-84dcdc6d24ff@denx.de>
 <CAHCN7xKvdKCnU-PRuGiNuDG9hGuk1Ea=jGtsuGaHd4CCxQximA@mail.gmail.com>
 <6040628f-8463-4f56-8395-9c4a509d3b18@denx.de>
In-Reply-To: <6040628f-8463-4f56-8395-9c4a509d3b18@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 17 Apr 2025 07:34:46 -0500
X-Gm-Features: ATxdqUE1N7St-nknChkNG0fftjGAdzVRksl77uTzXVBGzOdUXKwzmjz5go2_yks
Message-ID: <CAHCN7xLYWOiT94xcXmN=oRv8_e8nh0JVu6OJmnm=n+ZU-Hx08g@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Francesco Dolcini <francesco@dolcini.it>, 
 Fabio Estevam <festevam@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

On Thu, Apr 17, 2025 at 6:31=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/17/25 12:51 PM, Adam Ford wrote:
> > On Thu, Apr 17, 2025 at 2:24=E2=80=AFAM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 4/17/25 1:58 AM, Fabio Estevam wrote:
> >>> On Wed, Apr 16, 2025 at 8:47=E2=80=AFPM Marek Vasut <marex@denx.de> w=
rote:
> >>>
> >>>> You are not supposed to use "clock-output-names" for clock look up.
> >>>> You are supposed to use "clocks"/"clock-names" DT properties and the=
n
> >>>> resolve the remote clock from information in those.
> >>>
> >>> What do you think about registering the osc clocks like this?
> >>>
> >>> https://paste.debian.net/1369857/
> >>
> >> It would be good to include the patch inline in this email, not in a
> >> link to some paste site which will go away.
> >>
> >> This also does not work in case 24 MHz or 32 kHz clock are provided by
> >> something else than an xtal , and it will also lead to instantiation o=
f
> >> the same clock twice. The clock are already described in DT as
> >> fixed-clock , there is fixed clock driver which binds to those clock
> >> based on their DT description , the problem here seems to be related t=
o
> >> the look up of those 24 MHz or 32 kHz clock, not their (re)registratio=
n.
> >
> >
> > Since that patch changed the lookup of the clock name broke USB on
> > multiple boards, I would like to recommend we revert it until a proper
> > solution is found.
> This would also re-introduce the bogus clock-osc-24m look up, which
> requires workarounds in DT, so no. Let's actually fix this instead of
> reinstating broken workarounds.
>
> Does clk_resolve_parent_clk() in clk_mux_fetch_parent_index() not
> resolve the mux index correctly or something ? Do you by any chance have
> some -u-boot.dtsi modification to the clock-controller@30380000 node
> which changes clocks/clock-names somehow ? Which mux does not get
> correctly resolved here ? Is there a simple reproducer ?

I am not modifying my clock-controller node, but I did spend a little
time looking at how Linux reviews the parent clock names.

In Linux, of_clk_get_parent_name() will look for 'clock-output-names'
and return that value if it's present. If we go with your proposal, I
feel like we'd have to traverse to the top of the clock tree to get
the CCM's clock associated with osc_24m, and then compare the clock it
returns with the clock we want to see if they match.

If we follow the Linux method where we try to fetch the parent clock
name and use the name associated with it, we could simplify this.
Another possibiltiy, is to change the name of the clock at the of
registration to match the name returned from clock-output-names.

adam
