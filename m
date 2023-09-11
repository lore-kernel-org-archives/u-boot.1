Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D22EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 05:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735B786CEC;
	Mon, 11 Sep 2023 07:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L2hdp7P2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299CE86CF6; Mon, 11 Sep 2023 07:15:03 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46269863D3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 07:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68cb5278e3fso828878b3a.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 22:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694409298; x=1695014098; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgo0O4t7kicjwmZd9yP7weMZKsysmNttFAt3TuNdO6I=;
 b=L2hdp7P2cojjs5Udyh4je7wow/XRxZx6euqxIJzQLveLLVnmfoQyum0KJiyxsPTaeL
 p2h9ofjSQIlKlD3dgvwb6sBt76qRi0qrx9crkkSzq9nMUk2JtOCTsn0QkePBdpEhEGGG
 qT0YJ+nkY+8GfL0s79W2ZzJlgG3B1KTlpqh66EMuZmITHfCJUgYIUu+dW/9Qq4jFMvyK
 Se6YLXfJ/LGHx+4QjAwUTJzM6zk1nhulQDDle73qxcOkJGQJebxvSx4d3WiBHl/x5idg
 Ybmw+nYvTNYv7CUADwWkyLaa9w+Wcok7QJrSKMSTjUnzmEJj2FUWeSU9kTxnkoI/rE3g
 YllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694409298; x=1695014098;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vgo0O4t7kicjwmZd9yP7weMZKsysmNttFAt3TuNdO6I=;
 b=vz2pjKBuldcDmcdp9dgHkDR2cmIgrfg3x6OuJIgcMQdQLwks8Pfs6dJ3UpGpApxn8O
 py+ylPZdQqnHqJxBP4psGdlve1JC2Z7rEkTqZayF0m5RlkrrlmvkNx/aTvuiWJGf6lcX
 tbq6zko024mxjs33oXsGs6E/T1E6beXHlRRJ5NYifXdOObK22PaLMD7i4es1FA9+hXzq
 Y+FnJr2zcPtrHFlDPaNYGCGZjLzZwAFNxBhUPCYvV5lKC6PciUzG5G2QvEXVUAvw6ZsK
 aQPxfajaVvJAM0nW3hGaq2tK+LmpHvo8IDmzInASI58RbU/68SqTzBG2zggxN2esSHfk
 9kyg==
X-Gm-Message-State: AOJu0YxDhtZ6ZJk26IiWNBtzaYesCyW+JY/mEoPm5IR8IeWDmSAl+oY/
 BiPPavmyXEO401RFHD4KiW76ag==
X-Google-Smtp-Source: AGHT+IGaxAL5ZBCztFvrdh1x9JPq+HymqH/m8goF3P77Vc6I79cwGA2dbRfJfEIPTsVewtA/ZI3TwQ==
X-Received: by 2002:a05:6a21:194:b0:13f:65ca:52a2 with SMTP id
 le20-20020a056a21019400b0013f65ca52a2mr12859675pzb.5.1694409298288; 
 Sun, 10 Sep 2023 22:14:58 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:91f5:5d19:aad:686c])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a170902da8300b001bba1475c92sm5391554plx.113.2023.09.10.22.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 22:14:57 -0700 (PDT)
Date: Mon, 11 Sep 2023 14:14:54 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Subject: Re: [RFC 3/6] pinctrl: add scmi driver
Message-ID: <ZP6iTtWaq2EoUi8s@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-4-takahiro.akashi@linaro.org>
 <CAPnjgZ00tEakxn4qq+o5W2Ks-bq+YW=JngJhE-zoqJYtjBFwtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ00tEakxn4qq+o5W2Ks-bq+YW=JngJhE-zoqJYtjBFwtA@mail.gmail.com>
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

On Sun, Sep 10, 2023 at 01:13:27PM -0600, Simon Glass wrote:
> Hi AKASHI,
> 
> On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > This DM-compliant driver deals with SCMI pinctrl protocol and presents
> > pinctrl devices exposed by SCMI firmware (server).
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/pinctrl/Kconfig        |  11 +
> >  drivers/pinctrl/Makefile       |   1 +
> >  drivers/pinctrl/pinctrl-scmi.c | 537 +++++++++++++++++++++++++++++++++
> >  3 files changed, 549 insertions(+)
> >  create mode 100644 drivers/pinctrl/pinctrl-scmi.c
> 
> 
> [..]
> 
> +
> > +U_BOOT_DRIVER(scmi_pinctrl) = {
> > +       .name = "scmi_pinctrl",
> > +       .id = UCLASS_PINCTRL,
> > +       .ops = &scmi_pinctrl_ops,
> > +       .probe = scmi_pinctrl_probe,
> > +       .priv_auto      = sizeof(struct scmi_pinctrl_priv),
> > +};
> > --
> > 2.34.1
> >
> 
> Where is the compatible string for this driver?

Nothing defined.

As I mentioned in the cover letter, pinctrl driver consists of
two layers:
- helper functions which directly manipulate protocol interfaces.
- DM-compliant (that you doubt about :) pinctrl driver.

All the SCMI-based drivers (existing ones, clock, reset and voltage domain,
except base) follow this scheme.

According to the DT bindings for SCMI protocols, they are sub-nodes
of scmi node and identified by "reg" properties. When the *bind* takes
place, scmi_bind_protocols() will enumerate all the sub-nodes and
try to bind associated protocol drivers (pinctrl in my patch) based
on "reg" value.

So there is no need to have a "compatible" property for each protocol.
Do you think it is ugly?
I suppose the corresponding kernel code, scmi_probe() in
drivers/firmware/arm_scmi/driver.c, has a similar logic although
it seems a bit more complicated.

-Takahiro Akashi

> 
> Regards,
> Simon
