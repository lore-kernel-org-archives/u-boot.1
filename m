Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6707CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 00:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6328086CE8;
	Thu, 12 Oct 2023 02:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wonq5r+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF6B86C37; Thu, 12 Oct 2023 02:41:17 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BAA86CE8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 02:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-690fe1d9ba1so87368b3a.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 17:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697071264; x=1697676064; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+uV+cUC106sSZ8BDaOwh69WudzH8ihEp+5x85P4h10=;
 b=Wonq5r+tC4m44IhuI3pJQopE+vyt7qfoAwDisTSdqFwGiUP4n+4zV4RHU2bH2yhVDg
 R5RHZqTsu9O5clAgTV2/RyHYpQwLktORJdLwnzWUd+7m5mlelvnr7V6f2baoxrlvNVey
 fXpDEn1BAL7BvWFyJDwRxT/WB3i7rQmeiRKoRH526hSG1wIFtzmz8Z+uS5QT6lOIMXJT
 aLP0w2jUrOAngW1v0p/yOAiRMOuqS6UU7q4FyVlHPoHpbcJ+NIcq5bmSDJGFDW2F3Upc
 Y0CHBXL4AYX/6bh7hSJuawiGYynBAVkfvb7g6kDNB9Oqk/uEaSYznfSX0L1CB+UzoPgK
 zvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697071264; x=1697676064;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t+uV+cUC106sSZ8BDaOwh69WudzH8ihEp+5x85P4h10=;
 b=p9YdHXCprwcJqRXePUHdpOzodbAGH3moQxfkQZMLORkMKHh328X3ktxmzESkDOHp+0
 PctNKKzbjjycUrmEEy0rz+z5XEKCE3pv99FQouSqAlCdCtQeq6ZXRf1M3vSqyOu7Xzlu
 jxXjLSowOkBen9qesH+nCBv1gVfka7OT0O3eKWrcAmP9NcNlJsdVPjqTiBTIujdl80Hy
 R5XafAbVOlTSVxOy9K+J24WQ5qbtCXoQMiDdzNOvBhhrbFAG+c7a0E20ZgMfy5RY4KMx
 qpRmidltnZs+OvP32KToALvdBRsEyWVKbsgfcarrAhEkvRgzsZUjuaYJqMZ31gJrMf3w
 gXpA==
X-Gm-Message-State: AOJu0Yw0OPrPCpvkIXKZN3aTlRjJHM95UY0xq+MWMklNLfP/RXtMyeJv
 IcQ4dFj2MjZqhcJb1E3wC/u1XA==
X-Google-Smtp-Source: AGHT+IFuB+q3IKfH+wXy1uYnuxB/YnoBSQ8Q5BfWaHm8YqzEEB/l5LI0ajZy9wSRE1cEvDN6psHPnw==
X-Received: by 2002:a17:902:e74b:b0:1c7:1eed:10f2 with SMTP id
 p11-20020a170902e74b00b001c71eed10f2mr25645412plf.2.1697071263897; 
 Wed, 11 Oct 2023 17:41:03 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:f7a8:3d44:f8cb:28e])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902c18400b001c9db8f9e36sm472909pld.232.2023.10.11.17.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 17:41:03 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:41:00 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 Etienne CARRIERE <etienne.carriere@st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/14] firmware: scmi: add a version check against
 base protocol
Message-ID: <ZSdAnCsGhOPhxAYo@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 Etienne CARRIERE <etienne.carriere@st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
 <20231011100707.1007417-9-takahiro.akashi@linaro.org>
 <571b810596424ea6a5feba27b417487a@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571b810596424ea6a5feba27b417487a@foss.st.com>
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

Thank you again for your review.

On Wed, Oct 11, 2023 at 03:44:36PM +0000, Etienne CARRIERE - foss wrote:
> > From: U-Boot <u-boot-bounces@lists.denx.de> on behalf of AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Sent: Wednesday, October 11, 2023 12:07 PM
> > 
> > In SCMI base protocol version 2 (0x20000), new interfaces,
> > BASE_SET_DEVICE_PERMISSIONS/BASE_SET_PROTOCOL_PERMISSIONS/
> > BASE_RESET_AGENT_CONFIGURATION, were added. Moreover, the api of
> > BASE_DISCOVER_AGENT was changed to support self-agent discovery.
> > 
> > So the driver expects SCMI firmware support version 2 of base protocol.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> > v6
> > * new commit
> > ---
> >  drivers/firmware/scmi/base.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
> > index ee84e261945a..1d41a8a98fc6 100644
> > --- a/drivers/firmware/scmi/base.c
> > +++ b/drivers/firmware/scmi/base.c
> > @@ -481,6 +481,7 @@ static int scmi_base_reset_agent_configuration_int(struct udevice *dev,
> >   */
> >  static int scmi_base_probe(struct udevice *dev)
> >  {
> > +       u32 version;
> >         int ret;
> > 
> >         ret = devm_scmi_of_get_channel(dev);
> > @@ -488,6 +489,13 @@ static int scmi_base_probe(struct udevice *dev)
> >                 dev_err(dev, "get_channel failed\n");
> >                 return ret;
> >         }
> > +       ret = scmi_base_protocol_version_int(dev, &version);
> > +       if (ret) {
> > +               dev_err(dev, "getting protocol version failed\n");
> > +               return ret;
> > +       }
> > +       if (version < SCMI_BASE_PROTOCOL_VERSION)
> > +               return -EINVAL;
> 
> LGTM. The open source SCMI server implementations I'm aware of (scp-firmware, tf-a and optee-os) all report SCMI Base protocol version v2.0.

Yeah, I also confirmed this.

> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> 
> That said, maybe a more flexible implementation would support both version v1.0 (0x10000) and v2.0

SCMI v2.0 (not the base protocol, but the specification itself)
introduced base protocol v2.0 and the spec was published in 2019.
Along with the status of the existing SCMI server implementation (as you
mentioned above), I doubt any chance that there comes up any new SCMI with
the base protocol v1.0 in the future.

> but disable permission commands for v1.0 compliant servers. Maybe in a later change, if there is a need for.

Yes, we can make a tweak later. But anyhow "permission" commands are
categorized as optional even in v2.0 (i.e. the firmware may still return
SCMI_NOT_SUPPORTED) and U-Boot has no framework to utilize them for now.

BTW, I will not add a version check against all the existing protocols
(you implemented) as they utilize only the interfaces defined in each one's v1.0.

Thanks,
-Takahiro Akashi

> I fear using such strict minima protocol version values for other SCMI procotols make U-Boot client too restrictive.
> 
> BR,
> Etienne
> 
> > 
> >         return ret;
> >  }
> > --
> > 2.34.1
> > 
> > 
