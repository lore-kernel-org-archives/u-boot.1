Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A771CD6B06E
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E3883F32;
	Thu, 29 Jan 2026 16:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DgpQbtkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1EC083FD4; Thu, 29 Jan 2026 16:25:17 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A32883A64
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1959ba05cso429509a34.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769700314; cv=none;
 d=google.com; s=arc-20240605;
 b=IINK++J294o6ZosIAe7WXrWU9gXdSAIkQE3DGW4wFz/kscpND2cDriGNi37UYf24Ql
 FD+XqHsXTBUKJ5SuVklBOq/Olw4ZICOBvUm2eiFAw+M+/pbD3i59qwC973r6hHnTBBQ1
 Oc/O+PBSexfVDhkIOdYsKKQofR+61HYD1Z4Cb+qmrowy8rgd4VfotQFS1OPa4OubqvR6
 MBDbHRILPeccuKilkpa469npy2XkchuJ8b1t+CMZrjHvuhg/mWF0xtFM4HE8Cs+4IzDt
 CDfKbiOlFR0ZAaHdQOpsF1iFi9aczGHBxLiTEzMy/ap9dzSKLooSDX4dY0ePuj/MsEY6
 A0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NqarIv4F5I3up9C7YwjtuD12HhISE+BHfcEq84+Tu5o=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=Ro0GdWqIpPaMWqFFgLQzfQ88zJf4xVZxRW0Z3dSpNKmiSyVK632moDJRB5UN0UHyHU
 B+CHtP9OY6y/zu8H+X08gEUX7SuRojJEvezfZhtf6i4UQ2EmfePfa0T2LK3imDrnheG9
 +QlFN2C9zDu42kXKwnXmUvcyEnZKQh1khBFjbp0K7R687mIhqhNwpP60cS2cqTxIZHsF
 zHFcEuhhE6jtqfvYnT5qwWIQzpJ7wa/SuMafC8lwcSbobjuv4iNa797IOzHE7Vv6PB7x
 Eh9givHY5b1C8K1LV+KaGPYrnsoyUQzcRR9OWKyJL75/vkM/jJn+Q6apQqdnCSlzk6Dk
 BKvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769700314; x=1770305114; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqarIv4F5I3up9C7YwjtuD12HhISE+BHfcEq84+Tu5o=;
 b=DgpQbtkwyon2Owv7NwLkQ4Qq2eZhTu3PuxEcnRl/6dGdzH+VjBBwUFHc+/GfiSzXZ5
 ixhQAv+BpELPcrXCud/bmI+mpFlukUIh8QD9imhLZgO2qcWzEukuKZQ0BYBcFO09fP/S
 8f/ByF2WJdOmO3I7cLMe2O5US523/kdwJoTq6/daA4EX+x8ScTO4mrMC0ADweEZwxmu9
 4utiMHWEBk3UzksWlpE0iKyXx/By5X6hECOI4QK/EVF+9xaYVZ4wynkNHb7U7tsYn2Pb
 MBrJYz43wTbEnNeD6I5vucTTtSYa/RPetM0wauzyAt3aggRtqtAjj8xiZgBFFuqk/xC6
 NV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700314; x=1770305114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NqarIv4F5I3up9C7YwjtuD12HhISE+BHfcEq84+Tu5o=;
 b=vLcEAYqThlYR3PdAJkspo0Y9pfrKHRkC8JVwpC69z/tBkFvZGqzMcRb16OnBlhpRuv
 jB4/IG31CxWSpZlGJz5U39vkrIEfESGpUyRa4t/sl4QoapJFtISxv4YteungnLhkXf9e
 oHSZMjkMEGGmOKdJcbVy596dBr8XePimvBYf2spyzsYY/CgTvgjcubQ1d6EGdtoefQ5p
 ANn3r/iyChFdzrZ+qlyeNkEwd2XomDNUttcLD75kcNjkbWbBJXYFeRry8sh2I9rNXvct
 3SjsHonuMnqQsPRszZzuhj/Aw5E185AIUkIJNnq4VEdTzYrXDlZARYVxXYQ/jWFOAgrN
 MsQw==
X-Gm-Message-State: AOJu0YwR1uFh9RuXNAKgYEw4gXRKKsczEwxJ4bYX/V7Fm1gqcy/xdTdc
 Pm3bo4fokCfTTrDSE4vlrW9kqHIky7PzPgW+cyxg/soRj+KMFxESGBCXRgAGeaP8C38l501r2nM
 mDZstP3wnwUNMIaJ2cXI4dWHu2yAnHyw=
X-Gm-Gg: AZuq6aLqj8T/WujmQqx4dN3RuRnFpAmRVLABzFUcqsAJu7RyuLPQLNrn4vbY9AozuPc
 frfGbshwEogf8RHFrq5UDL7rC0qC4YIHTuWniWB0EqYmQB3sSJfpBtzkZ++A4HemAGltGaTg87E
 8TKBxG6JKZD4ZENtwDnIPGJQm34lUjgscomBT6CX8tCzHRCY1tyYYKdeuTQ+mqK3ODXwEdS7EI3
 j8aGkNx28jekyMJsHbOXZItDkcNNeV2+knbZeDzOz/4KoURSnqDCDwKVG9kmg7bO8MTRCTL
X-Received: by 2002:a05:6830:8293:b0:7c7:62bd:7fac with SMTP id
 46e09a7af769-7d184fef210mr5375223a34.9.1769700314054; Thu, 29 Jan 2026
 07:25:14 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
 <20260129145416.GR3416603@bill-the-cat>
 <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
 <20260129151919.GU3416603@bill-the-cat>
In-Reply-To: <20260129151919.GU3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 29 Jan 2026 23:25:03 +0800
X-Gm-Features: AZwV_QgbuUXVt0HFR00kqmz5Et4wVw-VzU4Vwveq7visf8BVRS16wXE0GPdDZYY
Message-ID: <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:
> > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> > > > > > All Cyclone V boards are unable to boot, not sure this patch is=
 the fix?
> > > > >
> > > >
> > > > Hi Tom,
> > > >
> > > > > Yes, those commits were unintentional and have been reverted.
> > > >
> > > > Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae5dc8d50a
> > > > Same situation that the boards are unable to enter the SPL phase.
> > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works properly.
> > > > After that things are broken.
> > >
> > > Please give
> > > https://patchwork.ozlabs.org/project/uboot/patch/20260129035512.63936=
2-1-marek.vasut+renesas@mailbox.org/
> > > a try as I think it might have been working before by alignment luck
> > > rather than design.
> >
> > Hi Tom,
> >
> > It is the revert itself that is broken.
> > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> >
> >
> > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 - 22:56:17 +0=
800)
> > Trying to boot from MMC1
> >
> > Which revert is correct.
> >
> > But once dc2d8423b19d30472b02e02b41504226908a4291
> > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> >
> > Then all these broken I don't understand why even file diff cannot
> > show any changes.
> >
> > Do you mean the revert is broken and fixed by alignment?
>
> I mean that arbitrary changes (as part of testing these things, the
> "-dirty" in the version string would lead to failing trees now passing)
> can make the difference between pass/fail to boot. Did you try Marek's
> patch I linked to?

Yes, I had tried. Cannot boot same as I had mentioned failing commit #.
I apply that patch on the latest master commit.

Thanks

>
> --
> Tom
