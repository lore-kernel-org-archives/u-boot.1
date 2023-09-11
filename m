Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64788EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 07:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C5486CA7;
	Mon, 11 Sep 2023 09:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XYwbxQ2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A45D86D0C; Mon, 11 Sep 2023 09:07:38 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DECBA86637
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 09:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5657ca46a56so424770a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694416053; x=1695020853; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yXx8jHlcrtaoV8uJvTlJZw0CjIesHkrSxpY+s6h7af0=;
 b=XYwbxQ2eDf69a8DttMENJAlVKjFVf3fcMO4ksMM7NEzHN4YhbsZiwdBmML6xNUUS9g
 xZfIilM4KWZhnOwoPArDA3ByqiEGijvq4rG6WW3Vh2uQaElzwpmJh+B+T/yW0z7OFV0d
 v3voonUhPe1OEu7AFL6BtIwSZDPqHqQyjB/SbQThSWOKLKUulF7ByWiL2S9j7tlBQ9Di
 A/4DHNtxsOS2IqM0C0TLsBeHmRcYXYnQgA0Gkrv3yTx8NYbldFX9YtxEUhQNUKzGG9B3
 N+gZ7kKtNeram5vj+TMI9SrnGK/NSdfR326XlxeufroT4rIEoDOLI/YPHLdG9eIDXiSX
 kf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694416053; x=1695020853;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yXx8jHlcrtaoV8uJvTlJZw0CjIesHkrSxpY+s6h7af0=;
 b=JhRpg7G6WkR8FCRoXFAc+H1ArsAvwYNBmgyd/7yLPTh1mDJZkRpJhpTSIxJWE3BM9v
 DiZsI7Ezgcs8U1tNSCDeL9zHiLgt74xf0swp7XNHFUkhCBt7D/DWXN12hpOmu1mw8xdr
 6QRXFEkXrmrIPa7T5FjDbNSVbXl90oxNhR1nU5ttwUhrXKVot+GFQDqpIC8c/K0nRxl0
 q2TU6e47C4ZlOMXrZ1TkwW8fUYgx3zXC95IlQxktd65vQwJD3M3f6YfALIlGNm4L+n0i
 VOS0J10wmgmPydwTlT0LeMALemahlZwyLnW0ql2X/wGDZ9hmwORN/KSx2sWn+3KD1/mZ
 c2RQ==
X-Gm-Message-State: AOJu0YxkRCHWyTLJVcOdJUDy/YKS5sEOY1sHrBakskF3u6a2r/UdUyiN
 /fBT1kl1TuvqQpFzbs8WAJXyjw==
X-Google-Smtp-Source: AGHT+IFJaxF5WlruaqOK+x1CcrwDc9fzbanxzpoyUS7kRrQagC/dA72+WI91/EriWLZwIgpUaXiHoA==
X-Received: by 2002:a17:90a:680f:b0:268:38a7:842e with SMTP id
 p15-20020a17090a680f00b0026838a7842emr8135465pjj.2.1694416052997; 
 Mon, 11 Sep 2023 00:07:32 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:91f5:5d19:aad:686c])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a17090ab28e00b0026f3e396882sm6704563pjr.45.2023.09.11.00.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 00:07:32 -0700 (PDT)
Date: Mon, 11 Sep 2023 16:07:29 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Etienne CARRIERE <etienne.carriere@st.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v3 05/13] firmware: scmi: install base protocol to SCMI
 agent
Message-ID: <ZP68sVLKmnQfBrdo@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne CARRIERE <etienne.carriere@st.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-6-takahiro.akashi@linaro.org>
 <PAXPR10MB46873CBB983139900CB8B016FDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR10MB46873CBB983139900CB8B016FDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
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

On Fri, Sep 08, 2023 at 02:02:22PM +0000, Etienne CARRIERE wrote:
> Hello Akashi-san,
> 
> Some minor comments.
> 
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Sent: Friday, September 8, 2023 04:51
> > 
> > SCMI base protocol is mandatory, and once SCMI node is found in a device
> > tree, the protocol handle (udevice) is unconditionally installed to
> > the agent. Then basic information will be retrieved from SCMI server via
> > the protocol and saved into the agent instance's local storage.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> > v3
> > * typo fix: add '@' for argument name in function description
> > * eliminate dev_get_uclass_plat()'s repeated in inline
> > * modify the code for dynamically allocated sub-vendor/agent names
> > v2
> > * use helper functions, removing direct uses of ops
> > ---
> >  drivers/firmware/scmi/scmi_agent-uclass.c | 116 ++++++++++++++++++++++
> >  include/scmi_agent-uclass.h               |  66 ++++++++++++
> >  2 files changed, 182 insertions(+)
> > 
> > diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> > index e823d105a3eb..87a667d60124 100644
> > --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> > +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> > @@ -57,6 +57,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
> >          }
> >  
> >          switch (id) {
> > +       case SCMI_PROTOCOL_ID_BASE:
> > +               proto = priv->base_dev;
> > +               break;
> >          case SCMI_PROTOCOL_ID_CLOCK:
> >                  proto = priv->clock_dev;
> >                  break;
> > @@ -101,6 +104,9 @@ static int scmi_add_protocol(struct udevice *dev,
> >          }
> >  
> >          switch (proto_id) {
> > +       case SCMI_PROTOCOL_ID_BASE:
> > +               priv->base_dev = proto;
> > +               break;
> >          case SCMI_PROTOCOL_ID_CLOCK:
> >                  priv->clock_dev = proto;
> >                  break;
> > @@ -237,6 +243,83 @@ int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)
> >          return scmi_process_msg(protocol->parent, priv->channel, msg);
> >  }
> >  
> > +/**
> > + * scmi_fill_base_info - get base information about SCMI server
> > + * @agent:     SCMI agent device
> > + * @dev:       SCMI protocol device
> > + *
> > + * By using Base protocol commands, collect the base information
> > + * about SCMI server.
> > + *
> > + * Return: 0 on success, error code otherwise
> > + */
> > +static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
> > +{
> > +       struct scmi_agent_priv *priv = dev_get_uclass_plat(agent);
> > +       int ret;
> > +
> > +       ret = scmi_base_protocol_version(dev, &priv->version);
> > +       if (ret) {
> > +               dev_err(dev, "protocol_version() failed (%d)\n", ret);
> > +               return ret;
> > +       }
> > +       /* check for required version */
> > +       if (priv->version < SCMI_BASE_PROTOCOL_VERSION) {
> > +               dev_err(dev, "base protocol version (%d) lower than expected\n",
> > +                       priv->version);
> > +               return -EPROTO;
> > +       }
> > +
> > +       ret = scmi_base_protocol_attrs(dev, &priv->num_agents,
> > +                                      &priv->num_protocols);
> > +       if (ret) {
> > +               dev_err(dev, "protocol_attrs() failed (%d)\n", ret);
> > +               return ret;
> > +       }
> > +       ret = scmi_base_discover_vendor(dev, &priv->vendor);
> > +       if (ret) {
> > +               dev_err(dev, "base_discover_vendor() failed (%d)\n", ret);
> > +               return ret;
> > +       }
> > +       ret = scmi_base_discover_sub_vendor(dev, &priv->sub_vendor);
> > +       if (ret) {
> > +               if (ret != -EOPNOTSUPP) {
> > +                       dev_err(dev, "base_discover_sub_vendor() failed (%d)\n",
> > +                               ret);
> > +                       return ret;
> > +               }
> > +               priv->sub_vendor = "NA";
> > +       }
> > +       ret = scmi_base_discover_impl_version(dev, &priv->impl_version);
> > +       if (ret) {
> > +               dev_err(dev, "base_discover_impl_version() failed (%d)\n",
> > +                       ret);
> > +               return ret;
> > +       }
> > +
> > +       priv->agent_id = 0xffffffff; /* to avoid false claim */
> 
> I think this line should move in below instruction block, next to
> priv->agent_name = "NA", for consistency,

Yeah. Move it there.

> > +       ret = scmi_base_discover_agent(dev, 0xffffffff,
> > +                                      &priv->agent_id, &priv->agent_name);
> > +       if (ret) {
> > +               if (ret != -EOPNOTSUPP) {
> > +                       dev_err(dev,
> > +                               "base_discover_agent() failed for myself (%d)\n",
> > +                               ret);
> > +                       return ret;
> > +               }
> > +               priv->agent_name = "NA";
> > +       }
> > +
> > +       ret = scmi_base_discover_list_protocols(dev, &priv->protocols);
> > +       if (ret != priv->num_protocols) {
> > +               dev_err(dev, "base_discover_list_protocols() failed (%d)\n",
> > +                       ret);
> > +               return ret;
> 
> Value of ret here is not really relevant. I suggest to force to -EPROTO.

Certainly.

> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   * SCMI agent devices binds devices of various uclasses depeding on
> >   * the FDT description. scmi_bind_protocol() is a generic bind sequence
> > @@ -251,6 +334,39 @@ static int scmi_bind_protocols(struct udevice *dev)
> >          struct driver *drv;
> >          struct udevice *proto;
> >  
> > +       if (!uclass_get_device(UCLASS_SCMI_AGENT, 1, &agent)) {
> > +               /* This is a second SCMI agent */
> > +               dev_err(dev, "Cannot have more than one SCMI agent\n");
> > +               return -EEXIST;
> > +       }
> > +
> > +       /* initialize the device from device tree */
> > +       drv = DM_DRIVER_GET(scmi_base_drv);
> > +       name = "scmi-base.0";
> > +       ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
> > +       if (ret) {
> > +               dev_err(dev, "failed to bind base protocol\n");
> > +               return ret;
> > +       }
> > +       ret = scmi_add_protocol(dev, SCMI_PROTOCOL_ID_BASE, proto);
> > +       if (ret) {
> > +               dev_err(dev, "failed to add protocol: %s, ret: %d\n",
> > +                       proto->name, ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = device_probe(proto);
> > +       if (ret) {
> > +               dev_err(dev, "failed to probe base protocol\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = scmi_fill_base_info(dev, proto);
> > +       if (ret) {
> > +               dev_err(dev, "failed to get base information\n");
> > +               return ret;
> > +       }
> > +
> >          dev_for_each_subnode(node, dev) {
> >                  u32 protocol_id;
> >  
> > diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
> > index 3358c2b2d804..6fd6d54d6a5a 100644
> > --- a/include/scmi_agent-uclass.h
> > +++ b/include/scmi_agent-uclass.h
> > @@ -5,6 +5,7 @@
> >  #ifndef _SCMI_AGENT_UCLASS_H
> >  #define _SCMI_AGENT_UCLASS_H
> >  
> > +#include <scmi_protocols.h>
> >  #include <dm/device.h>
> >  
> >  struct scmi_msg;
> > @@ -12,16 +13,81 @@ struct scmi_channel;
> >  
> >  /**
> >   * struct scmi_agent_priv - private data maintained by agent instance
> > + * @version:           Version
> > + * @num_agents:                Number of agents
> > + * @num_protocols:     Number of protocols
> > + * @impl_version:      Implementation version
> > + * @protocols:         Array of protocol IDs
> > + * @vendor:            Vendor name
> > + * @sub_vendor:                Sub-vendor name
> > + * @agent_name:                Agent name
> > + * agent_id:           Identifier of agent
> 
> nitpicking: s/agent_id/@agent_id/

Will fix.

Thanks,
-Takahiro Akashi

> > + * @base_dev:          SCMI base protocol device
> >   * @clock_dev:         SCMI clock protocol device
> >   * @resetdom_dev:      SCMI reset domain protocol device
> >   * @voltagedom_dev:    SCMI voltage domain protocol device
> >   */
> >  struct scmi_agent_priv {
> > +       u32 version;
> > +       u32 num_agents;
> > +       u32 num_protocols;
> > +       u32 impl_version;
> > +       u8 *protocols;
> > +       u8 *vendor;
> > +       u8 *sub_vendor;
> > +       u8 *agent_name;
> > +       u32 agent_id;
> > +       struct udevice *base_dev;
> >          struct udevice *clock_dev;
> >          struct udevice *resetdom_dev;
> >          struct udevice *voltagedom_dev;
> >  };
> >  
> > +static inline u32 scmi_version(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->version;
> > +}
> > +
> > +static inline u32 scmi_num_agents(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->num_agents;
> > +}
> > +
> > +static inline u32 scmi_num_protocols(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->num_protocols;
> > +}
> > +
> > +static inline u32 scmi_impl_version(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->impl_version;
> > +}
> > +
> > +static inline u8 *scmi_protocols(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->protocols;
> > +}
> > +
> > +static inline u8 *scmi_vendor(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->vendor;
> > +}
> > +
> > +static inline u8 *scmi_sub_vendor(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->sub_vendor;
> > +}
> > +
> > +static inline u8 *scmi_agent_name(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->agent_name;
> > +}
> > +
> > +static inline u32 scmi_agent_id(struct udevice *dev)
> > +{
> > +       return ((struct scmi_agent_priv *)dev_get_uclass_plat(dev))->agent_id;
> > +}
> > +
> >  /**
> >   * struct scmi_transport_ops - The functions that a SCMI transport layer must implement.
> >   */
> > -- 
> > 2.34.1
> > 
