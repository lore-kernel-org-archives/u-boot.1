Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D93FC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613CB879F5;
	Wed, 25 Oct 2023 16:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="gn96QFtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4D487AC8; Wed, 25 Oct 2023 16:05:17 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C90486F39
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 7b8ee9bc-733f-11ee-abd3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7b8ee9bc-733f-11ee-abd3-005056999439;
 Wed, 25 Oct 2023 16:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=coj8VNtwS9nw+KUcS5rc4lDQM3ZtDlEmtTu8G+dlnOE=;
 b=gn96QFtIAtBA2Xj+gtBHJS993LsxyjmoL67wCGCCjfX93rqS28NakxCxyYSIlrJHs0alrHzE879vO
 h38fh0THLy6MQytjNmnHNtVbEfjt2E+9kshAYe0U6A2MuUYkC6OKxKEshSe///B/ouVXFywffOip6P
 1+8iq/gurtsrfuE6P7ONCeCMWrIJtwICLmGJHdmdbSpBiUNuWUdAFulxaKd7C3HXaXncAgF0p7XpzF
 7MTLfOr2RGb5273yp0Pe14fUOqnQia/viRQh/u5Mh8IiwmDmkaCvfIYmv/duUwdxHbjYRfd+BoIgYT
 vrbS5KRAfJLXHHR8ohIlPXaJb+DQfog==
X-KPN-MID: 33|76kseCCGi4k/tRs2lUMyoTHLkPKlVDOvyXkRnKTR7wqr2f8judXLFs/jEm69s0T
 7u/90IiGB2cNuf7jvEDCD7gSLf8pI755gm4R/I7ZB804=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Iz0nkXF+94Z+NfcExXZu5LH4SgUauO1C9vL85XHavrspgEuKyniaPfRok+6ITHz
 vds/v/NdNf0j+cZEBZjaaZg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 83759bc1-733f-11ee-ac7a-00505699b758;
 Wed, 25 Oct 2023 16:05:13 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:05:11 +0200
Message-Id: <87cyx2re5k.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: caleb.connolly@linaro.org, dsankouski@gmail.com,
 vladimir.zapolskiy@linaro.org, rfried.dev@gmail.com,
 xypron.glpk@gmx.de, u-boot@lists.denx.de
In-Reply-To: <CAPnjgZ3HM-f_Af0uKEz+4vDT0f4-6AWhOOEaDNqYWko70f6rvA@mail.gmail.com>
 (message from Simon Glass on Tue, 24 Oct 2023 12:34:39 -0700)
Subject: Re: [PATCH] arm: init: add an option to use FDT from previous
 bootloader
References: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
 <CAPnjgZ3mcyST+6dLk1r=cXwQDFT1CNAfOXXfbMaSFGt+HqCiCg@mail.gmail.com>
 <df7c8647-abfe-43a8-869d-6a570a109f9c@linaro.org>
 <CAPnjgZ3HM-f_Af0uKEz+4vDT0f4-6AWhOOEaDNqYWko70f6rvA@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Tue, 24 Oct 2023 12:34:39 -0700
> 
> > This mechanism of retrieving the DTB is also used on the apple M1 I
> > think, and any other board where we're booting U-Boot as a drop-in for
> > the kernel on arm64.
> 
> I believe M1 is an open source project so perhaps they could adopt
> firmware handoff when it is finalised.

Hi Simon,

I'll repeat what I've said before; handoff for M1 is deliberately 100%
compatible with handoff to the Linux kernel such that it is possible
to bypass U-Boot and directly boot a Linux kernel.  This is a feature
the Asahi Linux developers depend on.

If you want us to make changes here, you need to convince the Linux
kernel developers to adjust Documentation/arch/arm64/bootig.rst to
allow for the firmware handoff convention.
