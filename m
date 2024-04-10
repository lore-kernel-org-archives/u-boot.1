Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69036CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 13:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A44C8701E;
	Wed, 10 Apr 2024 15:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a0mAAS6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCC98701E; Wed, 10 Apr 2024 15:31:22 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2BB85B66
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 15:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2a58d2e5be8so396038a91.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712755879; x=1713360679; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LURJ/+mm4mOpLq7u+JX3H+nl9t66hmWgq63Q/2498ZI=;
 b=a0mAAS6JTKyuafzca6Fbz2dMYihkrDpRZlhWbjgh5ej1jXINA3JkaHjKdeoOZYGdEP
 xBpNUNiwOhZ0br60toqU3E8iy5Fp20WTPLCbMpfkbkZKr3v5lyJynxQ9RssQgbRcS7Z5
 /lV3Lxb87+sKsthlCP+iDW5PeB1nZS76+wbM/N1+/+fUeWhtXO/GrqZLdnhzF2SvALpu
 HFh0ge7tfQ/oi8RDCnlXWqcdhkvVEoyfl5F2sVy9VzD6/vvgOhUkYSPotawQHNfTUSaA
 x7GG0pr1CZ9jDNRwzFx6p/MRHWG0vld0fmDrftosMO8xnidPYzfAbhEyJSE06EvklCkB
 m8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712755879; x=1713360679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LURJ/+mm4mOpLq7u+JX3H+nl9t66hmWgq63Q/2498ZI=;
 b=NobNwLsz+4RvFubgkg8JSGgUJRmykgfUZTlEH1JtoY95MBoCa2U0InS0oIcqF+gkhN
 hMEov59ELj/jHS14hVMsDti2pFcqPFsY2DiVt2hYPFLD4/yQ3e9kUxEKqjtW/nd/GwdJ
 MLYC6jotkjHy1QllObr+YLsdNmjzYzjL8Hyh4taff9WqLkksg4h3/XbOG+lECE8E5pbB
 Z8PBUImf5JEaOu7HVUKbzHsQX6qVH7NqW7HAX21go5KtSjgJ4veLQWouw6NUq+xV3aCe
 iHRpcNVZxTFOfS1BfRPwFxwOKWa9cIx2jjmKqEFcIFVzHK/Jwg4RkW+RjON4a4CCf1sr
 0mWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBatFonR8WUiANydVyvbDGvSfQOIyBk4yYr/qvVPwInZbhX+3TrlaPfEtMKhlZLewLiJmjGYWbwid8cZzAAldvPl/ctw==
X-Gm-Message-State: AOJu0YxF0u0cIDX5PZtB0HblkQCJ2IRi6yUff+QYfMiQ2/DLyvkJy9pj
 hxjfopvBMThaTCTJ68KphPGV9mYiyQMqDqFgfvMg8YWvL6pRft1HU/C7x196Rkz4/b9uhcuuoBj
 wEVHP5UjcXJ9soYrP/F4VbeJ1Lyc=
X-Google-Smtp-Source: AGHT+IECdWjgEuZUsI9UO5y5stdoRQaMkM6bkpi0Jsbake9haMZjJyJhxCfjrLWssoxO0do9/EfVcDVyYxHPaWwtSl4=
X-Received: by 2002:a17:90a:f690:b0:29c:7487:43b8 with SMTP id
 cl16-20020a17090af69000b0029c748743b8mr2466001pjb.1.1712755879191; Wed, 10
 Apr 2024 06:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DXy8nuVPx-8uSpcVvyLFSb++S6ad64Gg0MWM3guxGZvw@mail.gmail.com>
 <20240323143454.GA3442575@bill-the-cat>
 <20240325203742.kan3xp5i3aqcd5ve@frhdebian>
 <CAOMZO5DqXHd-a6hhL9K9uAN_VF7rHBKaJ67mHX=7x_pXxcttfA@mail.gmail.com>
In-Reply-To: <CAOMZO5DqXHd-a6hhL9K9uAN_VF7rHBKaJ67mHX=7x_pXxcttfA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Apr 2024 10:31:07 -0300
Message-ID: <CAOMZO5C6ji9kpGspccUZ4pTCO7yp5fr3kaxDai9QphAtoPX-NQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
To: Hiago De Franco <hiagofranco@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 u-boot@lists.denx.de, Marc Zyngier <maz@kernel.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>, Stefano Babic <sbabic@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Sat, Mar 30, 2024 at 5:03=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tom,
>
> On Mon, Mar 25, 2024 at 5:37=E2=80=AFPM Hiago De Franco <hiagofranco@gmai=
l.com> wrote:
>
> > > How much testing has this seen outside of imx?
> >
> > Tom, I tested with the AM62 TI arm processor (Toradex Verdin AM62) and
> > it works fine.
>
> Do you think this one can be applied to next?
>
> Then we would have time for more testing until 2024.07.

Can this go in now?

Thanks
