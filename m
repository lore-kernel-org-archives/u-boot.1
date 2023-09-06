Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8506FEE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 00:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC1B86431;
	Thu,  7 Sep 2023 02:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NOrn8Brz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B18C86594; Thu,  7 Sep 2023 02:08:32 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9A686308
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 02:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68e38caa352so89975b3a.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694045308; x=1694650108; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ey1smN4KwGztx1wTxn4UJh/7a+oNcVDDNFq4cBhpQS8=;
 b=NOrn8Brzpw+H9eBGHfPMsX7ryqYlGJ02F5ZEydqECiNY3J2ViPz4l/nNI26uEStK6j
 9Gh1CLMi2Go5/H3QkHDk3eUqbyDdLno/C/EaWt072hdBoEfvK81iJ8zhh0AC6Fnup267
 FOodR9YcZAVCbSqwI54piT+jN5Ab1M/E3XINI2x3HZ2soP1R0n6zeLV54WRafNbX8QgK
 XjXY1b4gQ0w34nvSH3NlgDMbQGNaTjh/ok/Og35VZaPfSJb4e8ySNCd7Ge4ZzxQWWIWp
 +S3B+GtOaMwn2yjeCRNhmg4AZp+AHMmfBoq09sPjwzjLkTuclVhNwkUlfvZkMMM7wGZh
 +0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694045308; x=1694650108;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ey1smN4KwGztx1wTxn4UJh/7a+oNcVDDNFq4cBhpQS8=;
 b=d6NqwpdiaX2L82V6WP82jQfNZ5CRcta1ArqVqWKvzBVUX4R7uJXX4xsBy8NTpidsVv
 J4Gl03b3Em8+wTcs1zHwjborLMmF1iGMrqHnRCWNG8TJj1RFaZcZEyTjfGoORzJ7Rfph
 36emvSuCOnzyK0eJifNOvP4hFJCAEjqNKJaZEVlTyNLYy9thPrYZq15bMEWfY8zuSoyq
 Isdr5jYbrTDFwBlftSDrHbWbrs/zrfRSsSE4HGB45wU6CmmWdlmcalcQ60lozMogy9Ow
 coP9C2SJuCplDedL1kUjaZFYZWfAANdZC8kA2rTZGlW/wdQgmcoTIL+9+ONnS1rC9qgh
 WVgg==
X-Gm-Message-State: AOJu0Yx47Jg05uwNI/BPR0k2qlqvNQFn8qJmUrqvlYQ4WRWL+Iycdqgj
 ZtBjqCylIRtqrAuJaTPXv4syqBtm2HjW07O1pwOrAQ==
X-Google-Smtp-Source: AGHT+IHlwgci+7IaBX+8jg5Rqlcf40X8GWrJ6lzrhtPlODJF69VjdKWXlWqm084a2X5++8QOh5Duqw==
X-Received: by 2002:a17:902:e74d:b0:1b8:aded:524c with SMTP id
 p13-20020a170902e74d00b001b8aded524cmr20099523plf.1.1694043481518; 
 Wed, 06 Sep 2023 16:38:01 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:90bf:a1fa:8da1:9b9d])
 by smtp.gmail.com with ESMTPSA id
 jo6-20020a170903054600b001b86492d724sm11566117plb.223.2023.09.06.16.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 16:38:01 -0700 (PDT)
Date: Thu, 7 Sep 2023 08:37:58 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Subject: Re: [RFC 4/6] gpio: add scmi driver based on pinctrl
Message-ID: <ZPkNVr2nn0zW38dF@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 etienne.carriere@st.com, sjg@chromium.org, linus.walleij@linaro.org,
 Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-5-takahiro.akashi@linaro.org>
 <523ca6eb-3737-d090-8006-f127eda2330b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523ca6eb-3737-d090-8006-f127eda2330b@amd.com>
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

On Wed, Sep 06, 2023 at 04:56:56PM +0200, Michal Simek wrote:
> 
> 
> On 9/6/23 04:40, AKASHI Takahiro wrote:
> > This DM-compliant driver deals with SCMI pinctrl protocol and presents
> > gpio devices exposed by SCMI firmware (server).
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >   drivers/pinctrl/pinctrl-scmi.c | 544 ++++++++++++++++++++++++++++++++-
> >   1 file changed, 539 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> > index 3ebdad57b86c..73d385bdbfcc 100644
> > --- a/drivers/pinctrl/pinctrl-scmi.c
> > +++ b/drivers/pinctrl/pinctrl-scmi.c
> > @@ -11,21 +11,20 @@
> >   #include <malloc.h>
> >   #include <scmi_agent.h>
> >   #include <scmi_protocols.h>
> > +#include <asm-generic/gpio.h>
> >   #include <dm/device_compat.h>
> > +#include <dm/device-internal.h>
> > +#include <dm/lists.h>
> >   #include <dm/pinctrl.h>
> >   /**
> >    * struct scmi_pin - attributes for a pin
> >    * @name:	Name of pin
> > - * @value:	Value of pin
> > - * @flags:	A set of flags
> >    * @function:	Function selected
> >    * @status:	An array of status of configuration types
> >    */
> >   struct scmi_pin {
> >   	char		*name;
> > -	u32		value;
> > -	u32		flags;
> 
> 
> You have added this in 3/6 then there is no reason to remove it in this version.

Right.
It was my mistake in a last-minute cleanup.
The hunk should be merged in 3/6.

BTW, this part of code, holding status of every pin's pinconf properties
locally, is a bit clumsy. I'd remove the whole code if possible.

-Takahiro Akashi


> M
