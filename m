Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEE6E776D4
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 00:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D648186DDE;
	Tue,  3 Oct 2023 02:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K3LmWlgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B0686DE7; Tue,  3 Oct 2023 02:22:52 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7004386DCA
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 02:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d8682b713c4so78621276.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 17:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696292569; x=1696897369; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9OuhKxRr8cfmm2xi778wO2tX2r5BrqVtjcFjka2x3I=;
 b=K3LmWlgJ2BaGNXQpNBduX/j1c8NwTjJy2vWZVw86inYbkaL6xXxREb5uKcymbZH11T
 +HenqGd0JfV3T0kOyfhBAgTXOU6qsX+rb363D5Z6igrjfzzs04RvH35YUrYc3qM3yoNQ
 1O+S4k0/tbDl2EOrF7XJbysXNLs2l3V391UNMJUE85c+YTLNJVxMWMbX6UWlsxgGfJ1Q
 D0SKIbNAtV00B6pggdws7je/KWiaTtvcJ2QlJoiF8d/7jSy9fwQzmz3uSBZQBD6Ffzgy
 el0qOY4heVb7GPHTrCrbkn0wT+d80pCmF7kHo+itaHwNq5+slh7LEMoIq8fTNtWQ6Vn/
 K90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696292569; x=1696897369;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h9OuhKxRr8cfmm2xi778wO2tX2r5BrqVtjcFjka2x3I=;
 b=O4hLZzQE2Cfeq9d9G4Zeh2hIXqtSqamQVJQRuSlotaAGl6JgOzz90EOtjNAmRyJz6U
 Vja30osgmeiIcIiD6Fpb0t8a3Dl+2PTSCkUyP9qVah68uOaYlD4m6Lk9pVMX716HpAx8
 FVmsCUsPAMcavjEhRbb8+v3ILTFrPSMYPQLXC3ZKZFBtimfY7P+UN8Gjv9V88shxrCCV
 R9TlaOwym+t1MlJH1kSWdP6Fw+N/KRH092jo/yINn7Cp6H6o56dsZivJovrcNJ+6QSzD
 GjIzNA9Fox88WZQKUcTYydOp/1/RMQIR6JfIOOcwA7HE5wbyFS8z1xUVhfCeW5nMv9Ef
 b4vQ==
X-Gm-Message-State: AOJu0YyUHYFGzGqH0k2ozHcTcL7XTY2DDZUzLCDPNLN1mG51N1GpXtOD
 lgDUhj/raDahKB64PURvTvcFFA==
X-Google-Smtp-Source: AGHT+IF9gNWb5Lk8HBrLc0Sv19Xm0FCGvng31Eg/rZ99Qq8yvwTlAQ/4WK2l+6vrrTuAwSBpMAVVoA==
X-Received: by 2002:a25:ac43:0:b0:d85:aebb:86ca with SMTP id
 r3-20020a25ac43000000b00d85aebb86camr9142636ybd.5.1696292568996; 
 Mon, 02 Oct 2023 17:22:48 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:783d:e8bb:e013:a869])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a63af11000000b0057c44503835sm49592pge.65.2023.10.02.17.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 17:22:48 -0700 (PDT)
Date: Tue, 3 Oct 2023 09:22:45 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH 3/4] sandbox: add SCMI power domain protocol support for
 testing
Message-ID: <ZRte1Xr0c0rS7K1w@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, trini@konsulko.com,
 etienne.carriere@st.com, u-boot@lists.denx.de
References: <20230926070043.738340-1-takahiro.akashi@linaro.org>
 <20230926070043.738340-4-takahiro.akashi@linaro.org>
 <CAPnjgZ20qGzZD=jNh0c2cucN-M8AKnvSh_kD0bL9=JeCC+doLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ20qGzZD=jNh0c2cucN-M8AKnvSh_kD0bL9=JeCC+doLA@mail.gmail.com>
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

Hi Simon,

Thank you for the review.

On Sun, Oct 01, 2023 at 07:17:17PM -0600, Simon Glass wrote:
> Hi AKASHI,
> 
> On Tue, 26 Sept 2023 at 01:01, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > SCMI power domain management protocol is supported on sandbox
> > for test purpose. Add fake agent interfaces and associated
> > power domain devices.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  arch/sandbox/dts/test.dts                    |   6 +
> >  arch/sandbox/include/asm/scmi_test.h         |  20 ++
> >  configs/sandbox_defconfig                    |   1 +
> >  drivers/firmware/scmi/sandbox-scmi_agent.c   | 265 ++++++++++++++++++-
> >  drivers/firmware/scmi/sandbox-scmi_devices.c |  10 +
> >  5 files changed, 301 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> nit below
> 
> >
> > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> > index 36de6a37cf6d..38fcf42cd23d 100644
> > --- a/arch/sandbox/dts/test.dts
> > +++ b/arch/sandbox/dts/test.dts
> > @@ -693,6 +693,11 @@
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >
> > +                       pwrdom_scmi: protocol@11 {
> > +                               reg = <0x11>;
> > +                               #power-domain-cells = <1>;
> > +                       };
> > +
> >                         clk_scmi: protocol@14 {
> >                                 reg = <0x14>;
> >                                 #clock-cells = <1>;
> > @@ -1589,6 +1594,7 @@
> >
> >         sandbox_scmi {
> >                 compatible = "sandbox,scmi-devices";
> > +               power-domains = <&pwrdom_scmi 2>;
> >                 clocks = <&clk_scmi 2>, <&clk_scmi 0>;
> >                 resets = <&reset_scmi 3>;
> >                 regul0-supply = <&regul0_scmi>;
> > diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
> > index ccb0df6c148f..1b0f4464b98f 100644
> > --- a/arch/sandbox/include/asm/scmi_test.h
> > +++ b/arch/sandbox/include/asm/scmi_test.h
> > @@ -6,10 +6,21 @@
> >  #ifndef __SANDBOX_SCMI_TEST_H
> >  #define __SANDBOX_SCMI_TEST_H
> >
> > +#include <power-domain.h>
> > +
> >  struct udevice;
> >  struct sandbox_scmi_agent;
> >  struct sandbox_scmi_service;
> >
> > +/**
> > + * struct sandbox_scmi_pwd
> > + * @id:                Identifier of the power domain used in the SCMI protocol
> 
> @pstate ?

Yes, I will add a comment.

-Takahiro Akashi


> > + */
> > +struct sandbox_scmi_pwd {
> > +       uint id;
> > +       u32 pstate;
> > +};
> > +
> >  /**
> >   * struct sandbox_scmi_clk - Simulated clock exposed by SCMI
> >   * @id:                Identifier of the clock used in the SCMI protocol
> > @@ -45,6 +56,8 @@ struct sandbox_scmi_voltd {
> >
> 
> [..]
> 
> Regards,
> Simon
