Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68DAD6B076
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D7A83FF8;
	Thu, 29 Jan 2026 16:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q73P+BXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0028B83FF9; Thu, 29 Jan 2026 16:32:06 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BAFF83B32
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d1866473b0so665239a34.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:32:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769700723; cv=none;
 d=google.com; s=arc-20240605;
 b=MXnH6q1j9ldX8/ZIbu7T+jKHh8/YZMx6SNbt7EfxSrRMdH+V9YZuQKhdMIKUbANYNL
 Z0Ohe2qiu9XV14yg3WaT4bMkkPz8ho2t+v7offrkj/Jt5w2sbcXQYY+D8DoopOvC1+YV
 yRzmV9dMFQCO50tIiOw8aQfKbiyjFMZhlKGNi2n4vdR1x2Qfh4ASm8AOwgWydmmp62/C
 MlSyneI42Oi0LNwSJPKlQin4TMLzsFgSUXtFWVLB/BOSKTDNE2+75Aj0WVu1XuBZjHAA
 p+7vu6KZfNp8ecEUlfxRsW+0c/xfdz/xMkiIApteTBF9dqUnlL1C1MSTGQ7R2a0NGrxD
 6x8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QFDTlKK1O5QKYA2gsLMIU0TGBaZEskhbV63GGuC82+Y=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=AykAsheD/pbZuETCwPdc51Hidmveox0Q01di7p1btUWkS/B9gUQpokB6e3KfOKCxEe
 mtUYXOEVCY4RjYA+HM7Hksf55pGzlZRDpDDq0eRK2jgvDtW9knOKOzGjQpIjEvunNojL
 0z31wuY3JtaS/ssdtsDKoSWq1ByfbnRKzFxbV2oMQV6nhbWgQMtSL87CTaoVVt6pOolg
 cLg4VGROPS35D/cyWOCVwYSwEmH3C1z1pU3RKOMIDWB0eAIDgAFjbq++5yJK98gWmugb
 xKBsrUAAh+Ys2NK/kfRj4lZbVHiFanyMdkI2qivbvtszQYt5PaAs71IVXhdjocS0rtq8
 vFLA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769700723; x=1770305523; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFDTlKK1O5QKYA2gsLMIU0TGBaZEskhbV63GGuC82+Y=;
 b=Q73P+BXSApe31CPQR68PqW2BSW9IRZtk3nDcHeqrdTbkJOiDfEbcT/45vXH1SrRYK0
 dyH8DCOhDpvikSDlxBS5LQBX0djZoZsPtylcKx/nSXZ56MoTX9c9j2oxo5fQ7iDbucsC
 sETPmmh9oxviT+RlpLk+eog+rMu9cVOoIBCXB3g2cUzDS5kA38f+kkDP7syoRc5KjFPB
 qGZ5KEjlgp9lNMFj/V8EPdP0X0uz5XlwmAxHApSKQlbrtpGyGv97+kcen1JYXvwIvXHY
 WNmEsVz9/7fVunpQXpZPiHGL6SCwRz0ldBUs8SS3O2rZsn/Z6weU2+NRfDN/ghq91Pa/
 fUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700723; x=1770305523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QFDTlKK1O5QKYA2gsLMIU0TGBaZEskhbV63GGuC82+Y=;
 b=EAOR0SqtMT5qcazBc9BrqZu2WA6NY6MmOwUbjw41gDRXFB8nky7ERmJo2dY4Nwr+pN
 zlBRluVngv51eGY0PCF/bxSR2DJns3BdW6Sf1GX4MJj1bSXXgRV90gQiFQzNUsoJJDV7
 wDhVHJi3DeXBVjZOYR93xG1qhljcGF9EFNymuJgwQMtuT8lsMgDz716iLnF73DTro/9m
 LglnAdn+GAXh2V4aNcbKtCFE0uHktuTY9xJ9fcY6CKqWaXcu7WOH4CxX/p+YVVVVkmPu
 Ca0t/ANf9JsuvwoMZJqQxOviRk6iEGMpfDYNEcCWWlzBzP7dM2ZuWbKLNBw2R2Nik3b7
 U+dQ==
X-Gm-Message-State: AOJu0YysvRdd2oEJ2amR9e1RbrqVJABOMcOBv6OQAhRZS1VFGyFPdwoc
 RKRHM4vySIyCLXiIDoXXiL6ykR8hzWzYORNLKVEpoVJCzSwNeHgp+O3bKhMn2K1DFXWP5URBg1X
 JwetatUuntkX/iywS2iWOB3iFqlRfzxU=
X-Gm-Gg: AZuq6aLRHG6fJN2cQlzgMy9Y7MlMJJR3jjSS6sgjkAfZ57ghpXp0MGk6T+yIkL7J1HX
 yrl7ZS19wdhzvCNbBbm9BwO+HeLnCQE7ZUZZdj4g9tDjGawn63Lbvp/7UE+GuzUrohrO2dfj/l2
 Td/0y7zdFTO/Ko0GlLdCQQtxqXukcZCLhaKKGdl14Kis9Q/NP3hA/7++HuBg/odPxKdqXY5b8mt
 /cdbJztOhTDhAt9ZFC26EyLihZleSZFld84dYtQcE9PDAhzM5snCdHYBMlEMSlsx7pmQktC
X-Received: by 2002:a05:6830:6d18:b0:7cf:d91b:c49e with SMTP id
 46e09a7af769-7d1850e67b2mr5931934a34.18.1769700722527; Thu, 29 Jan 2026
 07:32:02 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
 <20260129145416.GR3416603@bill-the-cat>
 <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
 <20260129151919.GU3416603@bill-the-cat>
 <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
 <20260129152644.GW3416603@bill-the-cat>
In-Reply-To: <20260129152644.GW3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 29 Jan 2026 23:31:51 +0800
X-Gm-Features: AZwV_QgcdPe1FGTxw8D_4MSNbfGQF9BnDD3Mq5hse9lfJw7Su5Ing0qpQMIzlTI
Message-ID: <CAN7C2SA85pMyF_Mn4YrwQnaLD4Ks8y3Zr3RGn1hkEds6nM1SYg@mail.gmail.com>
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

On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:
> > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> > > > > > > > All Cyclone V boards are unable to boot, not sure this patc=
h is the fix?
> > > > > > >
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > > Yes, those commits were unintentional and have been reverted.
> > > > > >
> > > > > > Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae5dc8=
d50a
> > > > > > Same situation that the boards are unable to enter the SPL phas=
e.
> > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works prope=
rly.
> > > > > > After that things are broken.
> > > > >
> > > > > Please give
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20260129035512.6=
39362-1-marek.vasut+renesas@mailbox.org/
> > > > > a try as I think it might have been working before by alignment l=
uck
> > > > > rather than design.
> > > >
> > > > Hi Tom,
> > > >
> > > > It is the revert itself that is broken.
> > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > >
> > > >
> > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 - 22:56:1=
7 +0800)
> > > > Trying to boot from MMC1
> > > >
> > > > Which revert is correct.
> > > >
> > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > > >
> > > > Then all these broken I don't understand why even file diff cannot
> > > > show any changes.
> > > >
> > > > Do you mean the revert is broken and fixed by alignment?
> > >
> > > I mean that arbitrary changes (as part of testing these things, the
> > > "-dirty" in the version string would lead to failing trees now passin=
g)
> > > can make the difference between pass/fail to boot. Did you try Marek'=
s
> > > patch I linked to?
> >
> > Yes, I had tried. Cannot boot same as I had mentioned failing commit #.
> > I apply that patch on the latest master commit.
>
> The other, maybe, thing is you need a bigger SPL_SYS_MALLOC_F_LEN ?
> Otherwise, you'll need to dig more and see why the device tree isn't
> being found where expected on your platform, and possibly where it is
> instead.

No the failing point is done after

f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
Revert "arm: spl: Correct alignment of .rel.dyn section"
This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.com>

This commit I tried to boot and works..

Then this commit

dc2d8423b19d30472b02e02b41504226908a4291
count rel_dyn
Signed-off-by: Tom Rini <trini@konsulko.com>

I manually replaced the old Makefile.xpl and also worked it boot.

Then 431f1ce46bbffff0db8f03437a34400b11b30175

Revert a number of incorrect commits
As part of debugging the appended device tree failure, I inadvertently
committed some changes as I was debugging to master, and not a private
branch, and pushed them as part of the release. This reverts commit
dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.com>

This is the point that everything no longer boots.

But between those commits there are no extra codes.

After that all things no longer work.

Thanks

>
> --
> Tom
