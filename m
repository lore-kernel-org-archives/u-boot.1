Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE80606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b7qTHzUC;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ngRbucVe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19D30818AC;
	Sat, 24 Oct 2026 13:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLXFi-AEgPY4; Sat, 24 Oct 2026 13:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25B278194A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847042;
	b=QNXB7fZ7B9NPaEyOptKQBVLNQIhwCBnBJeEICw8slnwgjYvtzeT9bR9mTvov+DeV34xe
	 XSKh2159U1P2r0jtn8560uhCsLQijlj0tMgMZ3kq790FwAdnQ7cGrsJi/lHl5b6OPGmkA
	 XzwT2vxeUjGIj6ujb+An62E0pseIAGH36wkIA0j+8izXiOwWARZJyrBWvzv62ycBENhO+
	 j/wGOCaBx+YIfoCHC8OE3Zj314uqm6XKsQoozGA8LCTJE78Q+UwH8a99hWeeA1sSCllH/
	 uOfwAWHqYl0Iyi9noOMLk7yR/aUVD2kY7t2okibh3YSRnKYa6e806Q/5fvQsjmGrPHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z40RL7nsmcyfTIW12BA1MNGPBtwWOtodUIonpS3+r94=;
	b=aWzzMHYG7Dwy46HnzxWNOYf+RbgIfLj5yR9NlnD0J8AnGNLqU6+Y34N/0IhIFq4ln4J8
	 6LGA+Ds41S5ui9UaSFmXtcmlpiGQfx2GpLC9IDT/ef2WUl3DKihlgfwZSkjBQjWfm173+
	 ZMz2zXubyLpvIxGafWm1HgvfYoanxH3xnPM6rRNxfmQbPce38kLP5bAtk+Oaj7qpBsSKM
	 l2ZXkB/aaQV0OjhmMDPcvRGBBali6iGADe294x3qfk9V9SqNI4Zmgj1rvRmHTLQG6OsZi
	 Xfv9ujuJrkvnNcwITgXqR7mpWvfkTY4F+ZbstjAVBFiHFqo44ju1ypieA1lIcYmSJxw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847042;
	bh=z40RL7nsmcyfTIW12BA1MNGPBtwWOtodUIonpS3+r94=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b7qTHzUCzNSkENG83IBvtn4w6eVH1I8Nhg0usR5D7edcGtTbXlbFcIlFt9fTAgDU/
	 BW8G8Iejm0xi4dxrAuB2dTaLcFYmUyyoyIKO0VoVMc7HIM3aiIW949r05ZZUGztqmU
	 rRuarLJ2G1gwYq6lRAcSojvarY0Vkx439Ah8sl22ZCjdTVSvCp75XsNvyI/GWZsVlj
	 PBRfxPcO5nIDxUzqXeDizJIqykgRvgRly4SiAUsf2tkHJhdYszBrRE45OZA9YtPS/W
	 GL4PNVa5Msq51JEvafZbBplEnqloD6zH4Kkecsudhrf6YIuZ/2NNLIzK9a9XPKv+Iv
	 fhSkZYdaDLJcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25B278194A;
	Sat, 24 Oct 2026 13:04:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B123235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D36240ADB
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JIyWaw_O9wa0 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:01:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E88D40AB8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825264;
 b=JeTn+17i/RUyBz+m3scsVwc5wqhOxj8aJ2NXj6kPb0kvMS+6kP8Z19ypQV0F5QeCzo4E
 IJ6mZq4hJ/6plq7qstGlZnqu3/6fULsgppVnXzrktm+r580BRrEEva9rFoMcUqllsq8oj
 aBZgBb8nCCmEjsestsDvXwO6gQl72fL9DXatPR/P0igJ1tKjQvLLLNxOxIVgXdddifiFf
 6EOPtoRU1dsmxe6ZYet1PNoCyESFhOQMmoBT/1xkrR8zpir94D8ZLlwNkk0elJexNGpxy
 nuz18RLcvH8deI8Yw1PomO9VtzIPwKl2xFBUdW2m+FGQrlSi213ZXpHcR7gxtRZ86Wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825264;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=z40RL7nsmcyfTIW12BA1MNGPBtwWOtodUIonpS3+r94=;
 b=liXwBECLUKP49Qvwu4XzIF/v9yP9hR/GcBx6VSqwqdravZfqYZPp6BQBldymczeBRpkQ
 j2A5yhX0mWabkRhTjJPiehGQVwXFX1yq8anKOuZHj/td3J+Y6k3r1UcUSKE7TO83ZB71y
 ZINpJPgnzxVZ0RBT+Mv4XXXU8XYK4QUaS3x3xmNUAvAeewtCWQLrUnpVK2PeAP4SnntEZ
 AQvA2kyvS5om3w61pRow6wheqMZMgEsyHM2maVY1/a/DoW8UTfAwlbxTIKIeNIi7kJdk9
 +Z3m9VdB8I79VXdv4peF7tGWHGD+OlEroIe5NQPVeFmMTVh3fMlkEqcUSNMnTEHEeSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ngRbucVe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ngRbucVe
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E88D40AB8
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:01:04 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso2494143a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825262; cv=none;
 d=google.com; s=arc-20260327;
 b=Jb92899srVKgW1Ona/nbeUSmZoa6OJAtxePnt4m8B5nMyLMdKvKniMQA7ygkXZqkbH
 fSYIzVwU1DIL2WL4yZWZpTxFPqmR2VHIOwTNomUvIfkGjbj6oqBdlYzzCHgRRVCc07Gd
 350EtKbPHjS8zs2pVryTXpusCLFXSqPVU6sSLtKLZYZAtHcjcNXPySsfdm2a2xImbK8k
 uL8DwazacLaIb/qTJaPb7AtINenwyUdke+tstzyNFx95bBy7OGDdVmABGJT5vz9eV4Qx
 gsTlh6W0KHPYGvBU4sCHf6bLSV27KxkHwjzAbUbq9NBKYr6d8lgzcWFYbvJHjWLiXQVt
 6jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=z40RL7nsmcyfTIW12BA1MNGPBtwWOtodUIonpS3+r94=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=mmWolpMDIzNPF+uo/0FS6Ga2tJ/rWKaDkfq3vajqRNve0MxZoXDXiwx/6MM6kQlnhM
 JVQV1KlC1dz9ynl+9uwkoEJAuP+EIbxHYN4WtbmrVBMQXriyd8bLGvhb+0xrqZGgadB0
 iroN0AIKJhCiT6CtW2kHiei6gwkyzvp+D9fMakVZ1vDRKure0jRO7DT8ZBmX3MF8I8by
 Y+H76Q88pFzp2RQme1F+jgUnstuI9OtO2EYnMdrMiuyvrX6UvYCxgfFxThCzCnbaH9s6
 7UoXZ/sXrhYHFOLWuXgpemzJz/R6w3uB4mJQ85dJmRoqDVcgNagC2LySMGDqGAFvu31b
 tfzg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825262; x=1793430062;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z40RL7nsmcyfTIW12BA1MNGPBtwWOtodUIonpS3+r94=;
 b=ngRbucVenKgSYxZI4Zi0D/mVu5kqAWCQiNQ9UlVvNDlXZA8H8dc5cjCpfmmiDarHWF
 KRCSKwtZ2qkVxX6Y7HDEqrkQ8PPbBYiuhkQ6QGEQdhalJQvIcxpGcY6FyrC6UC4xm599
 wtu36U4M9JJKwmhPZA9I3TE01xATYM9F467ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825262; x=1793430062;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z40RL7nsmcyfTIW12BA1MNGPBtwWOtodUIonpS3+r94=;
 b=szn/kmdHGTTdzKMT+FB0Ybp+K9yHBy6x2Oq4wI4ozZkHbMmCtFKhqnckaun4i4UlyC
 ccSoo6yKwlxRY26m7hhWmAqFSPqaCWvhQ8rGghTuIAxxM9VtXVkXf4iGWnXYLrd49lPI
 2ggQuGqrPSby0ppGuMDTmzGboG0DOny030pt7kpOoTnpniDlqyMWWZ1XzNnJRJyM++1G
 ttG6Qewek54NsjhsLxS0LCq53WN2y3jutbiLBBHfCNpmRXG4CIRj3OBqM7js8r12Eggp
 WYpDClQfkbBXjNyqgTCLuWdBpKS+yNPC2OmH4nJQNdIw9ITkWJ01eXSjcy0ZhQbuFpmW
 19Dg==
X-Gm-Message-State: AFq9FYLLxYejlo/R+0V2spvhPi/xg/glYAOsr8NZ/oqxNQHK+kdWrQTq
 WkDITJFVrjTtnW0S2oRZrkc7na2YUCsronfs/urAVoTRpt5+AhZw+hQAsMOcnNkkkQzjskzN0Xl
 fOEtvOuPK6ukvbcO8RSY2eXEbBD2zXNurg0wIIrC8
X-Gm-Gg: AYBFou0SQD9YZF3LEqY73X/y46Tk+yUrxSv4qCFkA553IdX4evZEHM6Z9Y27b+mqGyf
 2r8pIUpA6339FqphN+BsaaU5Mc8x6zMBWb3OMOxWrZLFhv1990wGqyEvZqppzXBzrrcPUNgeB93
 rAZWWZgX4hnvFQoUD6KIWufKyeV9ShTNo4oZIbKbd/err0r+6qYRnGXXO8F/wTPcaPv+V2ErvjR
 udiVOJ0mzjYKn+LmDmwvIY37TA6oXFndmQHPdbRmI0J4ot5RV1ijIm/LdP8Jpv6w7KR37ZFdbWY
 JLHYgcCHhiEbTMiS/TxNLDBc8Ufu55vdHvM4A8WdkDeQ+H6D2B9YjDKqzwlPOEZzTIYBMbDUhqs
 8G1IWQZd+12EKxC+nyRLw4EZlrzKrcR7Icrs=
X-Received: by 2002:a05:6402:2815:b0:6b1:cea1:a011 with SMTP id
 4fb4d7f45d1cf-6b4429ffe50mr1741762a12.0.1792825262212; Sat, 24 Oct 2026
 00:01:02 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:01:00 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 14:16:44 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-23-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-23-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:01:00 -0700
X-Gm-Features: AclHuK9MOmPDgW5wxeP9ruPhYOm72TyG8wxZL8oD1tGF--_1Kk1tO5p1vipIBzA
Message-ID: <CAFLszTjbN+Mqo8=NvUghz654qyEx8sSE+5RDnWnjrpeBN-oRog@mail.gmail.com>
Subject: Re: [PATCH v3 23/23] doc: spl: Describe compressing the U-Boot payload
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> doc: spl: Describe compressing the U-Boot payload
>
> Kconfig help has room for what a symbol does, not for the reasoning behind
> reaching for it. Describe the trade-off compression makes, what separates
> the algorithms, and the addressing constraint that decides whether it works
> on a given board at all, so the help text can stay to the point.

The Kconfig help from patch 20 still has most of this: the choice help
gives the measure-it-yourself advice and the per-algorithm help
repeats the ratio/speed notes almost word for word, so there are now
two copies to keep in sync. Please can you trim the Kconfig help to
what each option does and point to doc/develop/spl.rst for the
reasoning?

>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  doc/develop/spl.rst | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)

> diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
> @@ -151,6 +151,80 @@ NOTE: U-Boot migrated to a new schema for the u-boot,dm-* tags in 2023. Please
> +choice to binman, which uses the tool's own default except for lz4, where it
> +passes 5. Both are only offered on platforms
> +which select CONFIG_HAVE_SPL_FIT_COMPRESSION, declaring that whatever builds
> +their FIT honours them: binman for every in-tree user today, though nothing
> +in the mechanism requires that. Elsewhere the choice is hidden and
> +CONFIG_SPL_FIT_UBOOT_COMP reads "none", so an image description may reference
> +it unconditionally.

This paragraph wraps early after 'platforms', so please reflow it.

It would also be worth adding a short example of what a platform needs
in its binman description once it selects HAVE_SPL_FIT_COMPRESSION,
i.e. the compression and compress properties, plus compress-level
guarded by the level being non-zero, as in rockchip-u-boot.dtsi, with
a link to the compress-level section in binman.rst. That is what
someone adding the next platform will be looking for.

> diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
> @@ -151,6 +151,80 @@ NOTE: U-Boot migrated to a new schema for the u-boot,dm-* tags in 2023. Please
> +checksum of its output, produces a corrupt image without noticing. The image's
> +hash only covers the compressed data, so SPL checks the layout itself and
> +refuses to load the image, naming both addresses: before decompressing,
> +against as much of the output as the input is long, and after, against the
> +whole of it. This is conservative, as input sitting just above the output can
> +survive if the output grows by less than the gap between them, but no layout
> +is meant to rely on that.

This is hard to follow, and the before/after detail is about the
implementation, which the comments in spl_fit_decompress() already
cover. For this doc I think it is enough to say that SPL refuses an
image whose compressed input overlaps the decompressed output, and
prints both addresses. What do you think?

> diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
> @@ -151,6 +151,80 @@ NOTE: U-Boot migrated to a new schema for the u-boot,dm-* tags in 2023. Please
> +A board whose CONFIG_SYS_LOAD_ADDR sits just above or just below
> +CONFIG_TEXT_BASE therefore needs that address moved clear of the unpacked image
> +before compression can be used, allowing for the image growing over time.

Moving CONFIG_SYS_LOAD_ADDR also changes the default $loadaddr in
U-Boot proper, so boot scripts or distro-boot setups that rely on the
old value will see a different address. Please can you mention that
here, so a board maintainer knows the change is not limited to SPL?

Regards,
Simon
