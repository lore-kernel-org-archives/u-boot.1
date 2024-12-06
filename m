Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C68E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77BA89622;
	Fri,  6 Dec 2024 18:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LEASU2eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C34989627; Fri,  6 Dec 2024 18:30:08 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E6589535
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so1884300f8f.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733506205; x=1734111005; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=o8DEeyNyCGr7evEv4zdu5qmCS+4ppsBVk398uqUMh9s=;
 b=LEASU2eUyDRXfzmVdUE4qPry6G8sj7oSmEZfKJV1ykLB/KKjXP4y8yIF80pDO2OKIn
 mFIaOTf7GR2Q6cpdfpW53kPtxKLDovag6/iPMj06G/1XG+0QzyiYihm0bOTnF5OvfW8G
 vjurgwU8uQeAHtfpk3aMpDzDIGeDc+NtcXCLCemalOwmyWThza7txCwXKNdo/8Cdx8i3
 A2+1ouzFUTXQM1Leh/3vsGYB1YQgSz/ZDxhI9sW/tMKekCKzacHQPNdQgo0kIN8iJC4L
 eJ91/1jHxMu9QwrAr8p4aNk1Ft2hrVKthfD6Nkta6YbbyYqeIC84P6E79BQBTh63Reud
 vSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733506205; x=1734111005;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8DEeyNyCGr7evEv4zdu5qmCS+4ppsBVk398uqUMh9s=;
 b=AGDgq4H2J0jYnyGttgkJv63O4goM0x9f74cMauXst/8l+brWNBxXE2icKRx5UpyRUQ
 IG7JFLT9vblGkuoEyfLNy4N9b1WpSXl9a/fEzMAWSEU95N7z6J6x3DD794SqVElkKUPI
 VHNj2W9B5OeT2k3ywpoOotCx21lgbiSgpi0c12plKY75Zi7ryB7wKniqf8uU6OmqeEra
 s/AQd60P2zVjyuqUoiKDpnpHmbxQ8oxe7gZMx6ogTsnmZq9eDE+m5Ze1oFNHRuR2FPDI
 jOgkZl4ynKA1qOx2Xx4LIFvPNl/ugkBhO/vaHb//kKtxS2OuUN9TuH2b2QWLTNZlOfgo
 oTsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZZyxW5LkOt6C3/JJxi7Y0t6iXwA2bMu9zta75Hf7PzSoZWlP1LwLBKvBHSm4FsUUVwP/zCGM=@lists.denx.de
X-Gm-Message-State: AOJu0YxUEx9tBg4926GxJ1is3WHxp5ero1jNKoJOLS1jH5KwXNcGfgAt
 gSZV2QQvjKrm7dKN0QVIMyt/sRUAwz7K1wGLkzcvm0TjFMsZpnb+
X-Gm-Gg: ASbGncvc3NWz1HKpk95yZghjfGvbWeHtD40aWgu8vtS6H772KXhFYAWiUdc5zVfvag2
 tqnOZ6h68BYjUFOJXgF/iqM+IRioRRfut3U4ZY5e99orEVHS99xE0C61FOjQQserbhgidX5E/oT
 qcmFyRBFuI31QHGx1yOKbo4WvRUGvGWKgQZU36iDPJ5IYBXTONipvYaM6/wNTiGQE+Un4bmnwjn
 dnOEx4kSi4wwoN4JsyhW34M+T4daqZlRtNaKBb8MHSpZQIXYbVsmSKjQi5EohxXsCFOELtkDEIl
 nztPJQ==
X-Google-Smtp-Source: AGHT+IE+CdlB/kyPtXTUoUrs+WZ6tBe3x7rwInLjYwSxB3GSrXpZ5tiYpIsHEEOZHmlor72FJeM/xA==
X-Received: by 2002:a5d:5f8c:0:b0:385:ea11:dd92 with SMTP id
 ffacd0b85a97d-3862b34e410mr3035515f8f.15.1733506204479; 
 Fri, 06 Dec 2024 09:30:04 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862e767db6sm1530235f8f.26.2024.12.06.09.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:30:03 -0800 (PST)
Message-ID: <6753349b.5d0a0220.d8cca.5513@mx.google.com>
X-Google-Original-Message-ID: <Z1M0mLpg6dHi6N81@Ansuel-XPS.>
Date: Fri, 6 Dec 2024 18:30:00 +0100
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
 <67350b1d.5d0a0220.2d4a95.bc9a@mx.google.com>
 <20241123024113.GM3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123024113.GM3600562@bill-the-cat>
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

On Fri, Nov 22, 2024 at 08:41:13PM -0600, Tom Rini wrote:
> On Wed, Nov 13, 2024 at 09:24:59PM +0100, Christian Marangi wrote:
> > On Wed, Nov 13, 2024 at 12:00:59PM -0600, Tom Rini wrote:
> > > On Sun, Nov 10, 2024 at 12:50:19PM +0100, Christian Marangi wrote:
> > > 
> > > > This series is split in 2 part.
> > > > 
> > > > While adapting the LED boot and activity code to the new property
> > > > accepted by Rob in dt-schema repository, a big BUG was discovered.
> > > > 
> > > > The reason wasn't clear at start and took me some days to figure it
> > > > out.
> > > > 
> > > > This was triggered by adding a new phandle in the test.dts to
> > > > introduce test for the new OPs.
> > > > 
> > > > This single addition caused the sandbox CI test to fail in the
> > > > dm_test_ofnode_phandle_ot test.
> > > > 
> > > > This doesn't make sense as reverting the change made the CI test
> > > > to correctly finish. Also moving the uboot node down
> > > > after the first phandle (in test.dts the gpio one) also made
> > > > the CI test to correctly finish.
> > > > 
> > > > A little bit of searching and debugging made me realize the
> > > > parse phandle OPs didn't support other.dts at all and they
> > > > were still referencing phandle index from test.dts.
> > > > (more info in the related commit)
> > > > 
> > > > In short the test was broken all along and was working by
> > > > pure luck. The first 4 patch address and fix the problem for good.
> > > > 
> > > > The other 4 patch expand and address the property change for
> > > > LED boot/activity.
> > > > 
> > > > Posting in a single series as changes are trivial and just
> > > > to speedup review process. (and also because the second
> > > > part depends on the first)
> > > > 
> > > > All CI tested with azure pipeline.
> > > > 
> > > > Changes v2:
> > > > - Fix handling of flat tree for phandle
> > > > - Fix test and other.dts changes
> > > > 
> > > > Christian Marangi (8):
> > > >   dm: core: implement oftree variant of parse_phandle OPs
> > > >   test: dm: fix broken dm_test_ofnode_phandle_ot and get_by_phandle_ot
> > > >   dm: core: implement ofnode/tree_parse_phandle() helper
> > > >   test: dm: Expand dm_test_ofnode_phandle(_ot) with new
> > > >     ofnode/tree_parse_phandle
> > > >   dm: core: implement phandle ofnode_options helper
> > > >   test: dm: Add test for ofnode options phandle helper
> > > >   led: update LED boot/activity to new property implementation
> > > >   test: dm: Update test for LED activity and boot
> > > > 
> > > >  arch/sandbox/dts/other.dts |  31 ++++++++-
> > > >  arch/sandbox/dts/test.dts  |  16 +++--
> > > >  drivers/core/of_access.c   |  61 ++++++++++++-----
> > > >  drivers/core/ofnode.c      | 124 ++++++++++++++++++++++++++++++++-
> > > >  drivers/led/led-uclass.c   |  30 +++++---
> > > >  include/dm/of_access.h     |  86 +++++++++++++++++++++++
> > > >  include/dm/ofnode.h        | 107 +++++++++++++++++++++++++++++
> > > >  test/dm/led.c              |  18 +++--
> > > >  test/dm/ofnode.c           | 136 ++++++++++++++++++++++++++++++++-----
> > > >  9 files changed, 551 insertions(+), 58 deletions(-)
> > > 
> > > My main issue with the series is a lack of documentation updates, as the
> > > biggest challenge thus far has been that for example Peter couldn't
> > > figure out how to make use of this on PinePhone. We generate
> > > documentation today based on include/led.h for this API, yes? Thanks.
> > > 
> > 
> > Hi Tom,
> > 
> > actually quite the oppisite, led.h describe how these works and was
> > instructed to first have the options property merged in dt-schema. [1]
> > 
> > Here we have all the option documented under a yaml.
> > 
> > I notice there is a series from Simon that is also pushing a .yaml
> > here locally in U-Boot and I was waiting for that to be merged to also
> > include the additional entry there.
> > 
> > Also led.h description and API have info on where to look about the
> > handling of /options/u-boot/
> > 
> > I feel the main problem with documentation is currently the fact that we
> > are migrating to a more robust schema and people are used to using Doc
> > directory? Anyway happy to get any hint on how to improve this.
> > 
> > [1] https://github.com/devicetree-org/dt-schema
> 
> So Peter, does this bring you what you were asking for in terms of
> details, or can you explain what's still missing from your point of
> view? Thanks!
> 

Hi Tom,

any idea how to improve this and get it trought?

-- 
	Ansuel
