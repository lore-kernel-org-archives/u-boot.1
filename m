Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12156C004C0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 15:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C944871A2;
	Mon, 23 Oct 2023 17:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="pp/Ud2OS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ACEE877C2; Mon, 23 Oct 2023 17:37:39 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9CA387073
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 17:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 1546fb2f-71ba-11ee-b94e-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 1546fb2f-71ba-11ee-b94e-005056992ed3;
 Mon, 23 Oct 2023 17:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=RORPlbKodT0/9YpKReTen+UuQrCYGXD8m0fA7Cpg5po=;
 b=pp/Ud2OSqpJXvfsXCRIWXBZoMpUW8OGma5o0hG5vF0BrZqp9ggkha5CdnU1u1dkwTVPVVXFqbDbw3
 4I32kStoQ3umytBcn1d2YSET2FxuC4IYjemPFoAhVsUEjbC+h7gGt9fwIU+HjrNvsYvPPq5rwruIQu
 J1sDevLQMZ5Dm2ZK4+SWwJz6+Ukb3wssnkkAvXdZ2nNEQjduDO+UiRUTelGcccbSB5P3lI2G9rXpoE
 4XANn0v8TzBSn/q395oAPOxuJsK6RFotg1pO7BaBdkEo+ebzUn+HtIEvHK0qVo4mgKDRZR6YTrUkbr
 OSrP5kvIiOnBCL0isP1YnPPUoEafs5A==
X-KPN-MID: 33|BmINb15qSA7phltsJTtEpecNFe7TZzciyijUZvSzw9sKfabW8waG6y5I84JuJpN
 Hqz1L+SOQIIp1Z06ygU76ZTAejBW1ZnwXMFdeEBK6PM4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BrAcXLAY/WN6ZwKfN3/uxCAGL1k3t1Y0iKT85u3d9RclKQR7xgsoxtioQUXvVmI
 RBv4eN0FjtlKTnVAewj5L9w==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 15f90fd2-71ba-11ee-9dc8-00505699772e;
 Mon, 23 Oct 2023 17:37:34 +0200 (CEST)
Date: Mon, 23 Oct 2023 17:37:34 +0200
Message-Id: <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@google.com>
Cc: heinrich.schuchardt@canonical.com, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, dianders@google.com, trini@konsulko.com
In-Reply-To: <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
 (message from Simon Glass on Mon, 23 Oct 2023 00:08:40 -0700)
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
 <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
 <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
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

> From: Simon Glass <sjg@google.com>
> Date: Mon, 23 Oct 2023 00:08:40 -0700
> 
> > > fdt_node_check_compatible() does most of the work...then you need to
> > > check which FDT has the most specific match (i.e. latest in the string
> > > list). That handles things like board revisions, variants, etc.
> > >
> > > My concern is about adding a feature when there is already a defined
> > > spec and mechanism for this to work. What happens when we load the
> > > file and the compatible is wrong?
> > >
> > > At best, I see the filename as a hint.
> > >
> > > [Perhaps this is the wrong time to ask, but why are kernels +DT not
> > > shipped in FIT on ARM?]
> >
> > FIT is U-Boot specific. For Linux distributions it is easier to use a
> > firmware agnostic method of booting.
> 
> I'd like to suggest that distros use both. Then U-Boot can work as it
> was designed and we can avoid these work-arounds.
> 
> FIT is actually implemented in various other bootloaders. In fact
> perhaps grub is the only one that doesn't? I can't think of any
> others.

Simon, please stop pushing this.  OpenBSD's bootloader does not
support FIT and we have no interest in supporting it.  Our users
expect to be able to just copy a new kernel in place and use it and
our OS upgrade procedure depends on this as well.  And this is
incompatble with FIT.  I've explained this about a dozen times to you
now.
