Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00865E743F2
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 07:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4801886E9C;
	Fri, 29 Sep 2023 09:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="NiTYgayF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E9586E9E; Fri, 29 Sep 2023 09:56:05 +0200 (CEST)
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692F88652B
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 09:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vitali64pmemail@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1695974162; x=1696233362;
 bh=u1DreufG8B3KRen1XkY7ofdFbAW0Q+5NvuOu4DFyDyc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=NiTYgayFpIwnUG/U+dC7/jpaSe9bvSs583wya6DAlA32qLQ3fGb570+NXJNr9BBy9
 8OHtN9h1XriHkseWIgY4pdAcJeFxttCFVjDnndDGvANztCFBXqT1wba52SyoESMbLW
 MNEmuZwe6BlsbNt+gTKElGl+sQb6d3JT5dfQgveC8UPXFWN8RFQ1K6F6L4RQd1q1uE
 VTwzPV214LDWIqFKPPSXheKSKHy2UXjlxfCvjtmannpyGkuSFiudlfF4QYH5EFidqX
 Hqa3BzkXM3Hk2UYf9lQdO71fAD/f2RXjiyqW530oe7xneSnO8qqvpyBQ7VTzwGzVXw
 wnMHShUYaJHWQ==
Date: Fri, 29 Sep 2023 07:55:57 +0000
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: u-boot@lists.denx.de, Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
Message-ID: <CVV8NAVG276M.59MVJQCUQRZQ@flaptop>
In-Reply-To: <CAPnjgZ3ThwoeEiiei53ZdCb1MvkDA8yaZTStpZ6LWauE7q+88w@mail.gmail.com>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
 <CAPnjgZ3ThwoeEiiei53ZdCb1MvkDA8yaZTStpZ6LWauE7q+88w@mail.gmail.com>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri Sep 29, 2023 at 1:42 AM CEST, Simon Glass wrote:
> On Wed, 27 Sept 2023 at 15:44, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > spl_board_prepare_for_boot() is not called before jumping/invoking atf,
> > optee, opensbi or linux images.
> >
> > Jump to image at the end of board_init_r() to fix this.
> >
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> > This patch have dependencies on the following patches:
> >
> > spl: add __noreturn attribute to spl_invoke_opensbi function
> > https://patchwork.ozlabs.org/patch/1827057/
> >
> > spl: add __noreturn attribute to spl_invoke_atf function
> > https://patchwork.ozlabs.org/patch/1831366/
> >
> > spl: Drop the switch() statement for OS selection
> > from the "spl: Preparation for Universal Payload" series
> > https://patchwork.ozlabs.org/patch/1839731/
> > ---
> >  common/spl/spl.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Very nice to see this!

Nice indeed!

