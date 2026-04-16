Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3635EF4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C46A841C2;
	Fri, 17 Apr 2026 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p7cv17Rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22635841C2; Thu, 16 Apr 2026 16:14:48 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D92B7840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-682d981b025so4648840eaf.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776348884; cv=none;
 d=google.com; s=arc-20240605;
 b=crjhlo218rDJhPgK4BvtTwioxhHIoVxdi4qi/H+IgFDxMk81mYBahYcj3clma++drU
 fDmwirhst99ZaIU+1FCl1CXMiytQeYkBDb9Plnc7K5OtlEtS89XO8c5fC/KNL8sl6Kqm
 G1azl2w6nRPI6mbfRT+4HJ+gU40Bzn8BEb2vywz4J3Q0sKZr3bFN2SFSI/PJNGUw2r9L
 +n+zObCJTQnjVUMVRPvTH6wBCwwSlNvNvKlWTKT8y84QyvdbrufqzG9IgUvttkMXeuly
 1NOZ8C/2dvZTGqlBvnlu2eWvO3ssXUbTp9EnFdzEQ6eg/BHZCSHhFHAvrunt1IowASrC
 nC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I0Mbuw+Q21h5LUxSor/aYdCN0I/SyVdluDFm6m0zpIA=;
 fh=q8q6SoLD90WiZ7KnMGBG8IoDapUJmaCCtJlmDpWNZnA=;
 b=W4A0gxnJDoTi1gxFO6YkuhJHdhID40gC7Cpv2jaUiILusDslNUIH2izRo4JKe3nJN3
 DgJclB1yS+FgA3ZmGDYLY4R/x5u6pgWz/WB/TwNn3FFhDipuKOfjYxAf1pD/DMcCj0HU
 qLhAaNJ7KtTw2M8eZOV/imkXi5UtglMfXmw/NZDN++bQB56BiO+BFQlH/BXfDv8Y06fO
 efQ1koNuQoHTvpfxFD6lh+2RTDTQoHwgYHQdfB/4SoQeP4Xzj27zHQKRicAKa4GcBS0Z
 GGStyxYaBczImPqqx8SMqfLZIubXDDauGpP4wKF+ZgfIiBlshe50ss/wf67cfs9XOUY8
 4tLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776348884; x=1776953684; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I0Mbuw+Q21h5LUxSor/aYdCN0I/SyVdluDFm6m0zpIA=;
 b=p7cv17Rtx4S+oEtyEoZkb/GLgx+3ObM/WDASpmmrVjcA67oMl9l44nFb2AfIJ2aNDB
 ZPBynTAIx9mJxlHu4FD2AWF8lHlRniuKWMeIP7GaN2eCp0lMtzHpoupHyvLnHTDN6eU5
 525lcC5A7JTF8+ofzwauhPfOGbUEpY7bspcTJHCsw6dR3K0HFcnu4ptp5lAWshQOdAJz
 QUSGOONyvabzuNXar/QV2ZecuTQykA3dgYkJumN37lE23jX7xqSTflmuqt2CdJg0NIxl
 G+NUzkII6zz3VQpmIQitPJ/bkpUDn2POZbz8Z45gXfoZlKfqRt2DkMWzEax/l3nmV23C
 j12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776348884; x=1776953684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0Mbuw+Q21h5LUxSor/aYdCN0I/SyVdluDFm6m0zpIA=;
 b=F7ZaJwPbN8h3wkKN5JsF91EemkGNYyBA/Q5NPuFFeceFKidmcqTwrTY8kbPMMOAMvP
 dOoA2pbtwahB2Shn7CAIZF+wDELdro+s4jPfj3rm2RXxyySC1QmOTzbYAfzil3hK43gP
 yA31SJooRTw9Z4lDazvUQ2IrJeraBKpdXMRq2gIr/7IQxBVeZ/rV7OV6jya68QA1NwNV
 s2rg+qvtTlemNjPhu/DjLJ3fuTxgqjErCrNlNgqMvnMe6kFNUacZClGJMvrzdMitHweU
 axZ7sMOayuZ4TCgS3mzQw+8Z/crqKaky6sv2TEhB+1DnlEVLCaKZrtGHMlOZutGBMaJ2
 NdCA==
X-Gm-Message-State: AOJu0Yzlq1/iI7lWGUj9t+FrkZYE8sTVXPygSEyjjvVTxsbphM21m/SJ
 6cLcE8Ud6+mCko7MN2UL3dBS1Wkzg3bt2aOzSCjGAC+1h/AI50jzY9FE0bxsl4tbCsO03GHn2Vh
 d0X8ZFmxRCYkjyhTgfRipw1kWjUT9LIM=
X-Gm-Gg: AeBDietYcoXFTSbRThCx2MS85YDm0iewWC3iTAyuhgIFbbM+cqDuodSUm/judF4qWxk
 1sKpT7//JKdEvyxXha6MQ8ofFzj4c0H/kOWkqHrH8TGWHxeBZCf2sk467W1Mu1Jd7OyqqzPZQzr
 QtPlPkXTS0Y1P80WbSj+H4ch3uWYAJabCK2QpeEJaumkwww6TKgzfFxruCRMlRHblP6L0RzerC8
 MRW9YxpmhN4EZT3BUChhOZCRduEOuCNj8amRD/maKGlamsph5kqUaRUa0V2AfhP/2Tuxgl4agx4
 q5x0PZE=
X-Received: by 2002:a05:6820:162c:b0:693:b272:73e9 with SMTP id
 006d021491bc7-693b2727c3cmr2929991eaf.42.1776348884519; Thu, 16 Apr 2026
 07:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260415172113.273702-1-micbis.openwrt@gmail.com>
 <aaa1648f-7aa0-4a76-b21f-3566bf40f528@mailbox.org>
In-Reply-To: <aaa1648f-7aa0-4a76-b21f-3566bf40f528@mailbox.org>
From: Michele Bisogno <micbis.openwrt@gmail.com>
Date: Thu, 16 Apr 2026 16:14:33 +0200
X-Gm-Features: AQROBzDngIMKMorPF71TpKSKiqtlIgmmuh92e6JcDQyqKmkXry0g28V4-RwtLl4
Message-ID: <CAP8xZ6mEb8A8epx+j_f=NS80hdOD7MvzzuUHDb3R70WgXioBjw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: renesas: add support for RZ/G2L SoC
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, paul@pbarker.dev, 
 jh80.chung@samsung.com, peng.fan@nxp.com, lukma@denx.de, 
 mkorpershoek@kernel.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi Marek,

Thank you for the review and the link to the Linux implementation.

> Regulator change should be a separate patch please.

I agree. I will split the regulator changes into a separate patch
for the v2 series to keep the subsystem changes distinct.

> drivers/usb/gadget/rcar is pulled from Linux 1b4861e32e46...
> but none of these changes in this patch are even in Linux next.

The RZ/G2L support in Linux relies heavily on DMA for data transfers.
In U-Boot, we are primarily using the PIO path. The refactoring
in fifo.c (switching to ioread8/iowrite8) was found to be necessary
to handle trailing bytes and alignment specifically for the RZ/G2L
bus when DMA is not active.

Additionally, the usb_del_gadget_udc() change in common.c addresses
a re-entrancy bug unique to U-Boot's gadget lifecycle. Without
this, the UDC list becomes stale, causing the board to crash if
a command like 'ums' is executed more than once.

> The addition of RZ/G2L into USBHS driver in Linux was much simpler

I agree that moving the RZ/G2L specifics in common.c to a platform
dependent file (similar to Linux) would be the cleaner long-term
architecture. However, doing so would require a much more invasive
refactoring of the existing driver structure. I opted for these
minimal changes to maintain stability for existing R-Car Gen3
users while enabling RZ/G2L support.

I will prepare a v2 series with the patches split as requested.

Kind regards,
Michele
