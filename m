Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81610EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 06:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80EF386D09;
	Mon, 11 Sep 2023 08:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r36UoCBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BCC86D0A; Mon, 11 Sep 2023 08:56:28 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56BFB86B33
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 08:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1befe39630bso9080155ad.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 23:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694415383; x=1695020183; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=djUuHXWWmMYd/yW2RlOjDbK/aEnnNPvVEqNmXG1+sPQ=;
 b=r36UoCBiekDo2Hm+sFo+35JV6xy1QlzMw2SH1wWfF/SkWfRV4FU9Wof2c6aevSEEE1
 NbY6IOi6vAo+dbtL1Xg9ipLsSYatJOthnshWKyHMY8h1MLrScutPyjLQaMCLgXfZeu20
 ObZ0o5Dq5BMUCu8lkkJMZpgNDPki/F0iR9VIAIDKMYiApc5Ree0eCyPoZY4n4TU+ExkO
 oQq2YL8F7+bTR4r9CZuMec0XFyWCFVVTKcTcfZHpquZKMSW0Kgc1rfjOw+SVJYuaF/Kn
 yXWwO25aplg6YWiMrywtq23di7rNUpSibyDgunenjgRPC9O5ttOuAJNYn2iDxfQjcJpe
 y23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694415383; x=1695020183;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djUuHXWWmMYd/yW2RlOjDbK/aEnnNPvVEqNmXG1+sPQ=;
 b=Pbm+FwpVkYI+U3i7RQLTAjWNSOotzf7vfQI04/G9V/Wur2bW5k2GD6VB3RzsMjNSO3
 h5eG3E21QmAliDV37KpDyqarYjkXV/S4dvxm3+gQ4GkFjy8V6jHnjikWAFZBwHz8z6fz
 tBGMLOxIR9UeK+rtH/LwGyuvF/fNY6cgFv7BtxAPFiaZXvQjBuQkWLEDcbbO1jmAby4s
 Ng0iUeI5pBW5jM6HE38U4+f1EzCxZrmiNaeBA2QG3hOTT4XnGuYayqWx3M8/s33EP/gz
 CkV9uQUgRldHXM968pBMJ9gVB3lAuE5+tvySFrE70EgJyriPDLOHCyTQbePYLrDtmJmT
 SsMg==
X-Gm-Message-State: AOJu0YxTeCg9XmX/rT8TyWk2ibU63+9m71QVyxkOpEUYqZsMrprF2AaZ
 WA2io2msFoVyaht0ul6Z2hQhPg==
X-Google-Smtp-Source: AGHT+IF3QTuQmYVqXypihHNElNSzs+R+rKmhpIs0Al64SUTZAV1d/slXGthPMBWhUSsu8fzsEbVQQw==
X-Received: by 2002:a17:902:d4c3:b0:1c3:411c:9b98 with SMTP id
 o3-20020a170902d4c300b001c3411c9b98mr10821375plg.3.1694415383343; 
 Sun, 10 Sep 2023 23:56:23 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:91f5:5d19:aad:686c])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a170902bc4700b001b7ffca7dbcsm5623506plz.148.2023.09.10.23.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:56:23 -0700 (PDT)
Date: Mon, 11 Sep 2023 15:56:20 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Etienne CARRIERE <etienne.carriere@st.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v3 04/13] firmware: scmi: framework for installing
 additional protocols
Message-ID: <ZP66FEs/M1taoEMK@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne CARRIERE <etienne.carriere@st.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-5-takahiro.akashi@linaro.org>
 <PAXPR10MB4687A7E0331B9FD9206F1E8AFDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR10MB4687A7E0331B9FD9206F1E8AFDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
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

On Fri, Sep 08, 2023 at 02:01:52PM +0000, Etienne CARRIERE wrote:
> 
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Sent: Friday, September 8, 2023 04:51
> >  
> > This framework allows SCMI protocols to be installed and bound to the agent
> > so that the agent can manage and utilize them later.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> > v3
> > * move "per_device_plat_auto" from a earlier patch
> > * fix comments in "scmi_agent_priv"
> > * modify an order of include files in scmi_agent.h
> > v2
> > * check for availability of protocols
> > ---
> >  drivers/firmware/scmi/scmi_agent-uclass.c | 101 +++++++++++++++++++++-
> >  include/scmi_agent-uclass.h               |  15 +++-
> >  include/scmi_agent.h                      |  14 +++
> >  3 files changed, 126 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> > index 94e54eeb066b..e823d105a3eb 100644
> > --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> > +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> > @@ -38,6 +38,86 @@ static const struct error_code scmi_linux_errmap[] = {
> >          { .scmi = SCMI_PROTOCOL_ERROR, .errno = -EPROTO, },
> >  };
> >  
> > +/*
> > + * NOTE: The only one instance should exist according to
> > + * the current specification and device tree bindings.
> > + */
> > +struct udevice *scmi_agent;
> > +
> > +struct udevice *scmi_get_protocol(struct udevice *dev,
> > +                                 enum scmi_std_protocol id)
> > +{
> > +       struct scmi_agent_priv *priv;
> > +       struct udevice *proto;
> > +
> > +       priv = dev_get_uclass_plat(dev);
> > +       if (!priv) {
> > +               dev_err(dev, "No priv data found\n");
> > +               return NULL;
> > +       }
> > +
> > +       switch (id) {
> > +       case SCMI_PROTOCOL_ID_CLOCK:
> > +               proto = priv->clock_dev;
> > +               break;
> > +       case SCMI_PROTOCOL_ID_RESET_DOMAIN:
> > +               proto = priv->resetdom_dev;
> > +               break;
> > +       case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
> > +               proto = priv->voltagedom_dev;
> > +               break;
> > +       default:
> > +               dev_err(dev, "Protocol not supported\n");
> > +               proto = NULL;
> > +               break;
> > +       }
> > +       if (proto && device_probe(proto))
> > +               dev_err(dev, "Probe failed\n");
> > +
> > +       return proto;
> > +}
> > +
> > +/**
> > + * scmi_add_protocol - add protocol to agent
> > + * @dev:       SCMI agent device
> > + * @proto_id:  SCMI protocol ID
> > + * @proto:     SCMI protocol device
> > + *
> > + * Associate the protocol instance, @proto, to the agent, @dev,
> > + * for later use.
> > + *
> > + * Return:     0 on success, error code otherwise
> > + */
> > +static int scmi_add_protocol(struct udevice *dev,
> > +                            enum scmi_std_protocol proto_id,
> > +                            struct udevice *proto)
> > +{
> > +       struct scmi_agent_priv *priv;
> > +
> > +       priv = dev_get_uclass_plat(dev);
> > +       if (!priv) {
> > +               dev_err(dev, "No priv data found\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       switch (proto_id) {
> > +       case SCMI_PROTOCOL_ID_CLOCK:
> > +               priv->clock_dev = proto;
> > +               break;
> > +       case SCMI_PROTOCOL_ID_RESET_DOMAIN:
> > +               priv->resetdom_dev = proto;
> > +               break;
> > +       case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
> > +               priv->voltagedom_dev = proto;
> > +               break;
> > +       default:
> > +               dev_err(dev, "Protocol not supported\n");
> > +               return -EPROTO;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  int scmi_to_linux_errno(s32 scmi_code)
> >  {
> >          int n;
> > @@ -164,12 +244,14 @@ int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)
> >   */
> >  static int scmi_bind_protocols(struct udevice *dev)
> >  {
> > +       struct udevice *agent;
> 
> nit: my build reported 'agent' here is not used in the scope of this patch.
> Strictly speaking, it should be brought by patch v3 05/13.
> ("firmware: scmi: install base protocol to SCMI agent")

You're right.
I will move this variable declaration to patch#5.

-Takahiro Akashi

> BR,
> etienne
> 
> > (snip)
