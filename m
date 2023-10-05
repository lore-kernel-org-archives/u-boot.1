Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767A3E8FDC3
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 09:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C6A86977;
	Thu,  5 Oct 2023 11:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xvkVuG5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DCE386A24; Thu,  5 Oct 2023 11:58:18 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AF586958
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 11:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-690fe1d9ba1so172292b3a.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696499893; x=1697104693; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUZIKL4z4jWQGBxmg0ok4SClLF+HfAfAxKjN/WrHABQ=;
 b=xvkVuG5IIyQk+pqLlwCP19LZulPBvEn9FTSvVRI1I2DDlvgzNEWX8Abb3mXvfTpt0I
 gqye7uzSJMr93IdWbChQq0sE98KWjGNh/15kzz4KfttLKEWMjh3gw1qxcT/V4UEmvgnz
 GasswpuI1YhfD+eGUK8UDINLD6NZxsTuPi5aZ/aegEkSUTaQCtXKK+5OgwxBdS2J3b6r
 b4JLzUZqpaDYbYsduSiZsqtCGq2/cBzKlH9N5fFr8RxWXshum8xnpOdOSJiryh4qAdMG
 JWRTJsjYEX986yAx/KY8WGDAhbASRtnwge47YusnYnncNtMtR+tVY58NbMiBp1Ut1SGN
 ZAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696499893; x=1697104693;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUZIKL4z4jWQGBxmg0ok4SClLF+HfAfAxKjN/WrHABQ=;
 b=g8OuwjhZoiMELJwKAZN3R398iEsR+2lM9skP0TXgqp2zh7mnm0NOm+uexIRaIqoUIp
 cEpVNUgEun4XP9kLMoF02FI1z3vL21XHFY+Bo4/9Tv7q06fp+xgW+mmpmt4CajLUJIh+
 HJYBYbDv8H1hRYddqJNnRmtXrm8IrdrcXsOedEO+uK6gazu5TXwDUuawQkxtennqT5CY
 sIalchsop5WmisJLfc2GV91EnerwqSWASNaaBVMC4PGYfi/bUU4BpwBWemNUb/DTXrO6
 1+4Hjcbzfnpcyh5nAa7rkiblEmhvUA1EfJQ/4f4AqPdfJ1MK2JVmI0CLL6WQ3JiXpfOE
 H4Xw==
X-Gm-Message-State: AOJu0Yzc2yAcUUXqn8SUxc4pNlFMjjHTUMxfAoXhHrVEDFUfxyMID6jo
 rNomU/usAQ8/m/aNBTaH289NRg==
X-Google-Smtp-Source: AGHT+IE9bKt+BgdGnFPp1+0m0k39mvbPWOj+ANxivdwE3fy//r+S0yUDVmrhr0mH77S2NYjaSx18pg==
X-Received: by 2002:a17:902:d2c1:b0:1c1:fbec:bc32 with SMTP id
 n1-20020a170902d2c100b001c1fbecbc32mr4941411plc.6.1696499893400; 
 Thu, 05 Oct 2023 02:58:13 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:a16d:fce2:497:afb7])
 by smtp.gmail.com with ESMTPSA id
 jh13-20020a170903328d00b001bba7aab822sm1223113plb.5.2023.10.05.02.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 02:58:12 -0700 (PDT)
Date: Thu, 5 Oct 2023 18:58:09 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 Etienne CARRIERE <etienne.carriere@st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 05/16] firmware: scmi: implement SCMI base protocol
Message-ID: <ZR6IsSHuCqigfrIM@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 Etienne CARRIERE <etienne.carriere@st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-6-takahiro.akashi@linaro.org>
 <fb8782c98aee403b94c1aef98edf695d@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8782c98aee403b94c1aef98edf695d@foss.st.com>
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

Hi Etienne,

On Thu, Oct 05, 2023 at 07:06:47AM +0000, Etienne CARRIERE - foss wrote:
> Hello Akashi-san,
> 
> 
> > From: U-Boot <u-boot-bounces@lists.denx.de> on behalf of AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Sent: Tuesday, September 26, 2023 8:57 AM
> > 
> > SCMI base protocol is mandatory according to the SCMI specification.
> > 
> > With this patch, SCMI base protocol can be accessed via SCMI transport
> > layers. All the commands, except SCMI_BASE_NOTIFY_ERRORS, are supported.
> > This is because U-Boot doesn't support interrupts and the current transport
> > layers are not able to handle asynchronous messages properly.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> > v3
> > * strncpy (TODO)
> > * remove a duplicated function prototype
> > * use newly-allocated memory when return vendor name or agent name
> > * revise function descriptions in a header
> > v2
> > * add helper functions, removing direct uses of ops
> > * add function descriptions for each of functions in ops
> > ---
> 
> This patch v5 looks good to me. 2 suggestions.
> 
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com> with comments addressed or not.
> I have successfully tested the whole PATCH v5 series on my platform.

Thank you for your review and testing.

> 
> >  drivers/firmware/scmi/Makefile |   1 +
> >  drivers/firmware/scmi/base.c   | 657 +++++++++++++++++++++++++++++++++
> >  include/dm/uclass-id.h         |   1 +
> >  include/scmi_protocols.h       | 351 ++++++++++++++++++
> >  4 files changed, 1010 insertions(+)
> >  create mode 100644 drivers/firmware/scmi/base.c
> > 
> > diff --git a/drivers/firmware/scmi/Makefile b/drivers/firmware/scmi/Makefile
> > index b2ff483c75a1..1a23d4981709 100644
> > --- a/drivers/firmware/scmi/Makefile
> > +++ b/drivers/firmware/scmi/Makefile
> > @@ -1,4 +1,5 @@
> >  obj-y  += scmi_agent-uclass.o
> > +obj-y  += base.o
> >  obj-y  += smt.o
> >  obj-$(CONFIG_SCMI_AGENT_SMCCC)         += smccc_agent.o
> >  obj-$(CONFIG_SCMI_AGENT_MAILBOX)       += mailbox_agent.o
> > diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
> > new file mode 100644
> > index 000000000000..dba143e1ff5d
> > --- /dev/null
> > +++ b/drivers/firmware/scmi/base.c
> > @@ -0,0 +1,657 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * SCMI Base protocol as U-Boot device
> > + *
> > + * Copyright (C) 2023 Linaro Limited
> > + *             author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + */
> > +
> > +#include <common.h>
> > +#include <dm.h>
> > +#include <scmi_agent.h>
> > +#include <scmi_protocols.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <asm/types.h>
> > +#include <dm/device_compat.h>
> > +#include <linux/kernel.h>
> > +
> > +/**
> > + * scmi_generic_protocol_version - get protocol version
> > + * @dev:       SCMI device
> > + * @id:                SCMI protocol ID
> > + * @version:   Pointer to SCMI protocol version
> > + *
> > + * Obtain the protocol version number in @version.
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> > +int scmi_generic_protocol_version(struct udevice *dev,
> > +                                 enum scmi_std_protocol id, u32 *version)
> > +{
> > +       struct scmi_protocol_version_out out;
> > +       struct scmi_msg msg = {
> > +               .protocol_id = id,
> > +               .message_id = SCMI_PROTOCOL_VERSION,
> > +               .out_msg = (u8 *)&out,
> > +               .out_msg_sz = sizeof(out),
> > +       };
> > +       int ret;
> > +
> > +       ret = devm_scmi_process_msg(dev, &msg);
> > +       if (ret)
> > +               return ret;
> > +       if (out.status)
> > +               return scmi_to_linux_errno(out.status);
> > +
> > +       *version = out.version;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * scmi_base_protocol_version_int - get Base protocol version
> > + * @dev:       SCMI device
> > + * @version:   Pointer to SCMI protocol version
> > + *
> > + * Obtain the protocol version number in @version for Base protocol.
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> 
> I think these inline description comment for scmi_base_protocol_xxx_int()
> would better be placed as description for the exported functions scmi_base_protocol_xxx() and scmi_base_discover_xxx(). Either in the .c file or in the header file.
> 
> Especially regarding the function scmi_base_discover_vendor()/_discover_sub_vendor()/_discover_agent() where caller is responsible for freeing the output string.

Yes, I will add comments.

> 
> > +static int scmi_base_protocol_version_int(struct udevice *dev, u32 *version)
> > +{
> > +       return scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_BASE,
> > +                                            version);
> > +}
> > +
> > +/**
> > + * scmi_protocol_attrs_int - get protocol attributes
> > + * @dev:               SCMI device
> > + * @num_agents:                Number of SCMI agents
> > + * @num_protocols:     Number of SCMI protocols
> > + *
> > + * Obtain the protocol attributes, the number of agents and the number
> > + * of protocols, in @num_agents and @num_protocols respectively, that
> > + * the device provides.
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> > +static int scmi_protocol_attrs_int(struct udevice *dev, u32 *num_agents,
> > +                                  u32 *num_protocols)
> > +{
> > +       struct scmi_protocol_attrs_out out;
> > +       struct scmi_msg msg = {
> > +               .protocol_id = SCMI_PROTOCOL_ID_BASE,
> > +               .message_id = SCMI_PROTOCOL_ATTRIBUTES,
> > +               .out_msg = (u8 *)&out,
> > +               .out_msg_sz = sizeof(out),
> > +       };
> > +       int ret;
> > +
> > +       ret = devm_scmi_process_msg(dev, &msg);
> > +       if (ret)
> > +               return ret;
> > +       if (out.status)
> > +               return scmi_to_linux_errno(out.status);
> > +
> > +       *num_agents = SCMI_PROTOCOL_ATTRS_NUM_AGENTS(out.attributes);
> > +       *num_protocols = SCMI_PROTOCOL_ATTRS_NUM_PROTOCOLS(out.attributes);
> > +
> > +       return 0;
> > +}
> > +
> (snip)
> > +
> > +/**
> > + * scmi_base_probe - probe base protocol device
> > + * @dev:       SCMI device
> > + *
> > + * Probe the device for SCMI base protocol and initialize the private data.
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> > +static int scmi_base_probe(struct udevice *dev)
> > +{
> > +       int ret;
> > +
> > +       ret = devm_scmi_of_get_channel(dev);
> > +       if (ret) {
> > +               dev_err(dev, "get_channel failed\n");
> > +               return ret;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +struct scmi_base_ops scmi_base_ops = {
> 
> Could be static.

Yes.

> By the way, struct scmi_base_ops is defined in the header file but I don't think it needs to be known from other drivers/env, even in the case of the sandbox tests.
> Maybe struct scmi_base_ops could be defined in this source file.

Right, but all DM devices declare its own operations arrays in headers.
Although I don't have a strong opinion, I'd like to follow this tradition.

-Takahiro Akashi


> Regards,
> Etienne
> 
> 
> > +       /* Commands */
> > +       .protocol_version = scmi_base_protocol_version_int,
> > +       .protocol_attrs = scmi_protocol_attrs_int,
> > +       .protocol_message_attrs = scmi_protocol_message_attrs_int,
> > +       .base_discover_vendor = scmi_base_discover_vendor_int,
> > +       .base_discover_sub_vendor = scmi_base_discover_sub_vendor_int,
> > +       .base_discover_impl_version = scmi_base_discover_impl_version_int,
> > +       .base_discover_list_protocols = scmi_base_discover_list_protocols_int,
> > +       .base_discover_agent = scmi_base_discover_agent_int,
> > +       .base_notify_errors = NULL,
> > +       .base_set_device_permissions = scmi_base_set_device_permissions_int,
> > +       .base_set_protocol_permissions = scmi_base_set_protocol_permissions_int,
> > +       .base_reset_agent_configuration =
> > +                       scmi_base_reset_agent_configuration_int,
> > +};
> > +
> > +int scmi_base_protocol_version(struct udevice *dev, u32 *version)
> > +{
> > +       const struct scmi_base_ops *ops = device_get_ops(dev);
> > +
> > +       if (ops->protocol_version)
> > +               return (*ops->protocol_version)(dev, version);
> > +
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +int scmi_base_protocol_attrs(struct udevice *dev, u32 *num_agents,
> > +                            u32 *num_protocols)
> > +{
> > +       const struct scmi_base_ops *ops = device_get_ops(dev);
> > +
> > +       if (ops->protocol_attrs)
> > +               return (*ops->protocol_attrs)(dev, num_agents, num_protocols);
> > +
> > +       return -EOPNOTSUPP;
> > +}
> > +
> (snip)
