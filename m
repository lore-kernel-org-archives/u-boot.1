Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7257BC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B0386D4C;
	Wed, 20 Dec 2023 11:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="AJ2QcAPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFA886D37; Wed, 20 Dec 2023 11:31:12 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD90986D37
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d7f90a4c-9f22-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d7f90a4c-9f22-11ee-90ec-00505699b430;
 Wed, 20 Dec 2023 11:30:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=6COKHe+dAlhy3h95rrKN1ogizoXXRBfEsdDXCXEeMCM=;
 b=AJ2QcAPZyIdFzmnbpAqbngTQ6SEeDqxjc04tzW4gGiIHj3IYkMsDCuB3gTN9C+Tlh3G1xknIhtVJ1
 YEB82Egoj4PT8s7fERvxylTkxyOABH1yhCbzk9mhW703lCLaR32pg1e8MK765yi5ooFpWb6uaXrN0+
 wZRoVrpSrCkvhdIAca/BsbR3UrVF9CZR6uHLvlylg5EchRCxEd/l6Z6BZtjqwF+IKeQklvOcmThoLl
 1OglxqZarq/7BR2tZTOANjEH/X+TToK59UR7kz2XnY3KngEvSXaeHQ+WF+iqvebhky/vsagPeO5Xt9
 KAULoaOk3jlK4k0KssfdJgIkVhRCsAQ==
X-KPN-MID: 33|I/7CcNsCg2DQDjuW2+o/J4riyZvrIsKhvdPEHTe+j9BccAJdO/rI6/9ZhmHUr3t
 PMXhI/QvOYDTJvpaJvwMY0g==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|AfU6XijHSUwkmkJqy9PrtllZlto3qQxxpxqAarsJern7Ruhoc5yt3MpjhDFbdbm
 ipV1xCuJFsnZ8IxlStfz63w==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e2957771-9f22-11ee-ad2d-005056998788;
 Wed, 20 Dec 2023 11:31:08 +0100 (CET)
Date: Wed, 20 Dec 2023 11:31:07 +0100
Message-Id: <87msu5np1w.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Sean Anderson <seanga2@gmail.com>
Cc: sjg@chromium.org, Csokas.Bence@prolan.hu, u-boot@lists.denx.de
In-Reply-To: <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com> (message from
 Sean Anderson on Tue, 19 Dec 2023 23:45:48 -0500)
Subject: Re: Passing boot logs to Linux?
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> Date: Tue, 19 Dec 2023 23:45:48 -0500
> From: Sean Anderson <seanga2@gmail.com>
> 
> On 12/19/23 23:11, Simon Glass wrote:
> > Hi Csókás,
> > 
> > On Tue, 19 Dec 2023 at 13:15, Csókás Bence <Csokas.Bence@prolan.hu> wrote:
> >>
> >> Hi!
> >>
> >> Is passing the U-Boot boot log to Linux supported yet? We are working
> >> with a third-party solution, which works, but is a bit hacky, so I was
> >> wondering if an official solution has been merged yet.
> >>
> >> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
> >> everything to a membuff, but I don't know if that can be exported to
> >> Linux yet. And if not in the tree yet, would such a patch be welcome?
> > 
> > Not yet, but yes I would like to see this.
> 
> I think most of the infrastructure is already here. We could use
> either console recording (as mentioned above), which is more
> complete, or a new LOG_DRIVER (which would have the advantage of
> omitting things like countdowns).
> 
> In terms of sending things to Linux, I think the natural choice
> would be pstore, which we already have a parser for.

Well, this should be OS-agnostic of course ;)

What is pstore?  Is this documented somewhere?
