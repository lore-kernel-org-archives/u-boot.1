Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B890FD637B1
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 20:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000118916C;
	Wed, 13 Nov 2024 21:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="czw7+7AF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A2188FFC; Wed, 13 Nov 2024 21:25:06 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 826618916C
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 21:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so5417015f8f.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 12:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731529503; x=1732134303; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ejxCBGne56YZ1pzK24sue9k10wCyNYdiaBDy1uMvq2k=;
 b=czw7+7AFy1vLik1X8scSl7DPa78mD1k8+9QiYkY4kzGjzSWi4NaM86J3rP6sPEBhki
 YRGg2zH5WSH6UHZd22Xq8KIZGiHGgUZUGwK59wTcuwwK1mDOb/deiekbgl2286T5wHrt
 iGhagAwEgMbsK98Wa3XII6+b/hJLkFkTpB9wa6FaTV/lxePmmbMqbKaPVcnij77oTZvv
 x6TAbH3qGzgEfG2hXAhoqeBorc3bEhGLF11eGfLI/bsmBbjMFgMYVyhim+68xbmZT59j
 IH1tlJgBSX6Vw0oWih2ejYBT+cSLGZRSG1DydlFVXyH1vtsai5HwESWRIdGb4RuM5cpG
 9RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731529503; x=1732134303;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejxCBGne56YZ1pzK24sue9k10wCyNYdiaBDy1uMvq2k=;
 b=L6gzagdxcHyBS+BoxrWQg6YigXKRr8Kr4vCVLxHbYP38iNhySQTMdqASHqKfEk/zqw
 JAokyr+JiNoVzGPINIdRFpJR0QXYElWA5EnvtvMD7NadUyMcbGghzy6ERcW3E781esoB
 0kPw7FM7/BwNtTm9jjUYy7InNvRyoZ7kxUPK4Et1tk6CmlFMfdvri30s9+HMDTxddhAB
 WmLmdRwkKpPNf4tNoUqbBDgROUwddyoCXEzjZobu3tcc5ra/4UNS6trWMKBDaai2nJ7E
 9NMFzun5gCwgn3unYrrTlhjFOG1L41lCAji/I08uLOw8KT12xmBsOV3kpuOCb2cGvi5M
 qTWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdYIg/X0vz/JxdIR1cqPb+lBnCz7ablqFzDqkW5ncdhhxfZ7xDweJTdM801OYgLx8rjdJ7wWM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5FG8NcHjX89CGCMnRpHjfqY0sv45vhpODjiOsXZhfj8Jkt6Si
 Ha0FAq+nE3EmC+F7BpuPaS88mcxECOfG3H+Xgt4IxHlL1QH2+9W5
X-Google-Smtp-Source: AGHT+IHfZSuKvELDudHRF7adHNmQEw9P9eNLDNrTMeh31Q8GLKCPVWbQE10/1BnQSSEFD48+dZDmTQ==
X-Received: by 2002:a5d:47cc:0:b0:382:13e2:545c with SMTP id
 ffacd0b85a97d-38213e25482mr586271f8f.6.1731529502636; 
 Wed, 13 Nov 2024 12:25:02 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04136sm19185308f8f.97.2024.11.13.12.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:25:01 -0800 (PST)
Message-ID: <67350b1d.5d0a0220.2d4a95.bc9a@mx.google.com>
X-Google-Original-Message-ID: <ZzULG8BUCg8th120@Ansuel-XPS.>
Date: Wed, 13 Nov 2024 21:24:59 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/8] led: update LED boot/activity to new property
 implementation
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241113180059.GV3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113180059.GV3600562@bill-the-cat>
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

On Wed, Nov 13, 2024 at 12:00:59PM -0600, Tom Rini wrote:
> On Sun, Nov 10, 2024 at 12:50:19PM +0100, Christian Marangi wrote:
> 
> > This series is split in 2 part.
> > 
> > While adapting the LED boot and activity code to the new property
> > accepted by Rob in dt-schema repository, a big BUG was discovered.
> > 
> > The reason wasn't clear at start and took me some days to figure it
> > out.
> > 
> > This was triggered by adding a new phandle in the test.dts to
> > introduce test for the new OPs.
> > 
> > This single addition caused the sandbox CI test to fail in the
> > dm_test_ofnode_phandle_ot test.
> > 
> > This doesn't make sense as reverting the change made the CI test
> > to correctly finish. Also moving the uboot node down
> > after the first phandle (in test.dts the gpio one) also made
> > the CI test to correctly finish.
> > 
> > A little bit of searching and debugging made me realize the
> > parse phandle OPs didn't support other.dts at all and they
> > were still referencing phandle index from test.dts.
> > (more info in the related commit)
> > 
> > In short the test was broken all along and was working by
> > pure luck. The first 4 patch address and fix the problem for good.
> > 
> > The other 4 patch expand and address the property change for
> > LED boot/activity.
> > 
> > Posting in a single series as changes are trivial and just
> > to speedup review process. (and also because the second
> > part depends on the first)
> > 
> > All CI tested with azure pipeline.
> > 
> > Changes v2:
> > - Fix handling of flat tree for phandle
> > - Fix test and other.dts changes
> > 
> > Christian Marangi (8):
> >   dm: core: implement oftree variant of parse_phandle OPs
> >   test: dm: fix broken dm_test_ofnode_phandle_ot and get_by_phandle_ot
> >   dm: core: implement ofnode/tree_parse_phandle() helper
> >   test: dm: Expand dm_test_ofnode_phandle(_ot) with new
> >     ofnode/tree_parse_phandle
> >   dm: core: implement phandle ofnode_options helper
> >   test: dm: Add test for ofnode options phandle helper
> >   led: update LED boot/activity to new property implementation
> >   test: dm: Update test for LED activity and boot
> > 
> >  arch/sandbox/dts/other.dts |  31 ++++++++-
> >  arch/sandbox/dts/test.dts  |  16 +++--
> >  drivers/core/of_access.c   |  61 ++++++++++++-----
> >  drivers/core/ofnode.c      | 124 ++++++++++++++++++++++++++++++++-
> >  drivers/led/led-uclass.c   |  30 +++++---
> >  include/dm/of_access.h     |  86 +++++++++++++++++++++++
> >  include/dm/ofnode.h        | 107 +++++++++++++++++++++++++++++
> >  test/dm/led.c              |  18 +++--
> >  test/dm/ofnode.c           | 136 ++++++++++++++++++++++++++++++++-----
> >  9 files changed, 551 insertions(+), 58 deletions(-)
> 
> My main issue with the series is a lack of documentation updates, as the
> biggest challenge thus far has been that for example Peter couldn't
> figure out how to make use of this on PinePhone. We generate
> documentation today based on include/led.h for this API, yes? Thanks.
> 

Hi Tom,

actually quite the oppisite, led.h describe how these works and was
instructed to first have the options property merged in dt-schema. [1]

Here we have all the option documented under a yaml.

I notice there is a series from Simon that is also pushing a .yaml
here locally in U-Boot and I was waiting for that to be merged to also
include the additional entry there.

Also led.h description and API have info on where to look about the
handling of /options/u-boot/

I feel the main problem with documentation is currently the fact that we
are migrating to a more robust schema and people are used to using Doc
directory? Anyway happy to get any hint on how to improve this.

[1] https://github.com/devicetree-org/dt-schema

-- 
	Ansuel
