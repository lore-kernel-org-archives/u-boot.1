Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41531CD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 18:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E94F846A4;
	Sun, 14 Jun 2026 20:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBEaEEmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1444E84704; Sun, 14 Jun 2026 20:57:20 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B460783FEE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 20:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so19897475e9.0
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781463437; x=1782068237; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rJB9IDMlraHJ945EvTaIIDZEh5awO551JOsV/PmwabQ=;
 b=UBEaEEmYxJXY/xffxW7C9CVoBX5qW31al5m9s2Vdrv0QOXHT8XCeDcLU38JPoKC05Z
 qApOIRFUWkHu4q4l0TT+AM5EUePAyCdWuNm6GP9QWWXL0fQ2m6hz+HKoj/6QCzjfGd2r
 ncpzAXnlmSWLEnGrzadx4sC16O9ZouLycUDxeBPDcNDIviAKO8iGagqvcQwsSpJqigBo
 wxTPeEhi/m/blGE/lYC5Ac6W6k6IOVC8APQ4C/O1d3uNH6MK5IDjh9LrtIDv9+AoWk1B
 go+ZwacimmOAV8YAYQ8m1eoiQN0sr1yIuTYzkKTIuPJIGDaw9sob1fZb71rbNgcRjsYp
 qHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463437; x=1782068237;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJB9IDMlraHJ945EvTaIIDZEh5awO551JOsV/PmwabQ=;
 b=JIZI6LBoBjE2F8ildMY2xY7y2WCP96ZlcRVaBMhqLgm9Wpvr565UvaYkMJ+h5IECQs
 cI3FHmnxUAUDklm+CYXlioNMq97xTRSXOvxUpdrqBPZX4zLitBDUtxhHVz71mmkSFUcJ
 bMxoC4+c2MoWyPKonQnE72jpTU+SLOSFDsCnbyCdE/TzlH4ypZpGXxleTuIp0B31weTd
 odIWINSRak9cy8DtucRB/oD5U16gUnuZaE3UCLhI4KmWucx0Ve0F9D1xHDwpLAgIvcC3
 sIHHQyTTrfnzzZhhH7ZzUOqlj1x2rrQo8N4nxYxXk35LJXQDaKkgAQuTTRI+f9y8+4Hb
 1RCw==
X-Gm-Message-State: AOJu0Yxc9net6SHUDWE1DZZL6jFx2dK8f28+/Qp/nzf06vZS8ZkRKXPr
 exHy7XmSwgl7/8u049dbe9Rtsk3x7L16ik3+AssNI5tIj7xmxcX24c9+
X-Gm-Gg: Acq92OE0WM5F+pbhBOe8yqIBdhdBW0eQEj5G7P5HLbOndpM+SJCW53VHNulhNEjGI8O
 +oMO37xrkyUT0+yaDgfx0oaX1YY/iYNJVSnUh7NR5CNZs43sJzxEH8rBh9n0F/bfqRYTzF0ghas
 nbNeKgU7txuk451jeIwlMhCSPVS5q+F91Dmtj3myxBRbg43dVGXmU9oX6H2xeAGS3sUyM6Nz5q3
 UY4YJw2SEvWOj2i8/KfleFmKsG959KR6QrG1QyYDFSKK6bNbhOFszdc7AvU+7XMWUwwMEBxv6Ie
 bySSdvuKO9hKRBTRvLaj62418jGyFU0E8IeQe2RtVaT2nyy7UCwqDxV3LvGBfVgXS8tKZre2nj6
 AY6bKkP99MLxK0gtXyT/XDTeJkFjrcbIeBVZrPq0vmQ64FqQ7mbvSyORfGp0gDxsXoUJVNKj6Qf
 e6hTEOnqrXyZfmcDSscnAZW25ERUBvLXpWtT4dPf7wbibJLP0SPr4Rlo5m64Gjm90MEkvXp619q
 S8t2o0=
X-Received: by 2002:a05:600c:4712:b0:490:b55c:cec3 with SMTP id
 5b1f17b1804b1-490ec4dc8d8mr152101585e9.12.1781463436868; 
 Sun, 14 Jun 2026 11:57:16 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net
 ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220308f13sm192320965e9.5.2026.06.14.11.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 11:57:15 -0700 (PDT)
Message-ID: <b0ff98144d34468c133cd62935afc546135b47ec.camel@gmail.com>
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, =?ISO-8859-1?Q?Andr=E9?= Przywara
 <andre.przywara@arm.com>, Cody Eksal <masterr3c0rd@epochal.quest>
Date: Sun, 14 Jun 2026 20:57:21 +0200
In-Reply-To: <ai6yjsgw-3hnNgNM@collins>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
 <ai6yjsgw-3hnNgNM@collins>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
MIME-Version: 1.0
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

Hi Paul,

On Sun, 2026-06-14 at 15:54 +0200, Paul Kocialkowski wrote:
> > Currently some ARM-based platforms reserve TF-A memory in their own way=
s:
> > - Mediatek gets BL31 region via SMC call in ft_system_setup()
> > - K3 uses CONFIG_K3_ATF_LOAD_ADDR, effectively in ft_system_setup()
> >=20
> > And others like Allwinner simply forget to do it, which results in Linu=
x
> > overwriting TF-A and crashing.
>=20
> To be fair we've been adding the reserved memory regions statically in
> the Linux device-trees to mitigate the issue.

once for H616, but it could be the only SoC among ARM64 platforms doing
this and discouraged for A133:
https://lore.kernel.org/all/b428d57ba5464f1226daf099877f4c25fa4fc191.camel@=
gmail.com/

> But another thing we do overwrite current is the cpu idle states, which
> are added by fdt_add_cpu_idle_states in tf-a. These are only set when the
> SCP firmware is available (which is checked at run-time) and they are
> never propagated to the final device-tree. Including the definitions
> statically would result in cpu idle calls done even without the SCP
> firmware, which would probably fail (although maybe some states can
> still be supported).

Do you refer to some unmerged code? Didn't find it in the current TF-A
sources...

> Also note that the usual way to deal with this is to not load any
> device-tree when booting the kernel, which will implicitly let U-Boot
> use its current device-tree for Linux (with the modifications brought by
> tf-a).

?!
We definitely want to load the very device tree coming in the FIT image
and pass it to the kernel from this FIT image. Sometimes people would
have several DTs to chose from. The thing in U-Boot is basically to
get U-Boot up and running. OF_UPSTREAM is rather to reduce the traffic
on the U-Boot mailing list and maintainers effort, but in most of the
cases we shall expect this DT to be not from the kernel we actually load.

> But of course I agree that it is very desirable to "forward" the
> device-tree modifications to the kernel device-tree so we are not stuck
> with whatever device-tree U-Boot was built with.
>=20
> > Unfortunately seems that the things are not much better on TF-A side an=
d
> > there is no universal way to get the reserved memory region across
> > platforms. But there is at least a most common way in TF-A, namely
> > reserving=C2=A0 memory range in the FDT, in particular:
> > - Allwinner	("tf-a@40000000" node)
> > - ARM FPGA	("tf-a@80000000" node)
> > - Xilinx	("tf-a" node)
>=20
> RaspberryPi seems to be using "atf@0". Generally speaking the property
> is a free-form argument to fdt_add_reserved_memory in tf-a and I don't
> think we can have a common way to match them.
>=20
> Introducing a Kconfig property for the prefix would be a satisfying
> solution in my opinion.

This was a very conservative patch solving the A133 case, but actually
I don't see anything wrong with just copying all the reserved areas from
the U-Boot live tree to the device tree we are going to pass to the
kernel. Maybe fdtdec_add_reserved_memory() needs to be taught to detect
overlapping ranges and extend them properly, or maybe yet another function
has to be created for this purpose, to avoid duplicated reserved-memory
nodes by all means, but would also solve the PSCI cpuidle issue, as well
as potentially Raspi case of TF-A side and simplify TI K3 on U-Boot side.

> > While this patch aims to improve the situation for Allwinner platforms,
> > it's deliberately adding more generic code to pave the potential way of
> > unification for other platforms.
> >=20
> > Note that fdtdec_add_reserved_memory() has a check for an already exist=
ing
> > carveout with exactly matching boundaries and will not create a duplica=
te
> > even if the name doesn't match. It would not however detect an already
> > existing bigger carveout fully containing the one requested.
> >=20
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > ---
> > The patch has been developed to faciliate Allwinner A133 SoC support, w=
here
> > most of the work currently happens on TF-A [1] and Linux [2] sides, but
> > I wanted to send this patch upfront to get the first feedback and becau=
se
> > already supported H616 SoC would already benefit from the patch.
>=20
> Thanks for looking at this!
>=20
> Like I said, I guess the same needs to be done for the cpuidle psci
> nodes.

See above, maybe there is a way to carefully copy all /reserved-memory node=
s?
Maybe this full copy shall be configurable, but with a proper overlapping-a=
ware
implementation maybe even a Kconfig option is not required...

--=20
Alexander Sverdlin.
