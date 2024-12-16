Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C99E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F402B800D2;
	Mon, 16 Dec 2024 16:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CLUui8sK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF03F80141; Mon, 16 Dec 2024 15:54:31 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BDF28003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 15:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcin.slusarz@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2eec9b3a1bbso2870164a91.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734360868; x=1734965668; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rkjc0ibneE4a3SI3+Pi9BCKzCMYrRDdY3GFWA9N+crU=;
 b=CLUui8sK/20MnMnu4JjWC9V3OZjQRLf3O0jJUkOkDsgtbMbxF/ed/fTfxWgU7OpR+5
 oDAbqcbBhunCI1dUYHRY7B/HEdCnlYokubzqRpOyQPO20GTKcZGsX1Ih2a81KTMdYtuH
 2B+2+wOpcpQY9JmeTxsz2W88kjeTp6/Mx/kLTKYfJQNIHMwlgV2rN/OcRWDflF/5++GD
 YbtSj/nVPRvIMymqUoprEVXgXBo7cGBGShopPjLDHY6Us3WltS0/A6ZIBvR2Uzq8Jdo3
 iojtXp3lAhGyI7USyK/ERf7Ujm01aHk3xTq6Inc5EoT411LdCc2FKmC0VBvorFnib+r8
 uNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734360868; x=1734965668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rkjc0ibneE4a3SI3+Pi9BCKzCMYrRDdY3GFWA9N+crU=;
 b=cUy4GXu6MVK4+RzuX5reM1zgKuSstxJEknXrBq977jP9UVXsU+9uBxhKtLgpeowBne
 zcynHOm1G3ovvQL+ffhGQ4iR8o8z+43kmFQahaJDD3T8auYnr+CX+zCe2wSdWceFNW6v
 gEv+yKEcK9mRXEzSSUsxX2mbSTvmWw+rIU8/M2ItNA81R1KWDS/pwXeD8yAk5Yb62vaW
 ENoTAiLNp0p7LdzG4WEMDZ6+YZ04GMfejY+4GkFLWU7HHGj8knOpjd6/JixzXFkXIqx8
 Iw73LKt2mvnettmA7TQOKDoF9MFvyS5EXs2/vUUiECl88Dr8qqJ74NsR72JcrAU/lF2j
 p9Dw==
X-Gm-Message-State: AOJu0Yz7rC/O7tBzuDIaVzvmXNlikeeGR3YLnitaRTYa5F2AbWqtbupq
 BGLyfI5hr4NGztMjDU0xj68pOW32YvvQLk56cSKSB50sKp/FFtJ9laRIdEJEc+FrVYy3IRapROF
 2K/VxmTMJzQSL/qSP5pQQ5Qy2Vh3OAg==
X-Gm-Gg: ASbGncsLqRga/i7O7Arb5st1ar1ZKnvexrRNMYXZqvtYTPW8M9Wp1dl7t9BVcQD/AvE
 xr8h7zE0S7SYbO6MTK7pi2WyoWckuJAO0enDz
X-Google-Smtp-Source: AGHT+IFtR7ula8zGibjV3s1GBByR8KxqIP3RzoJ7lnrEi6jmCMypE264i0TEJ3ySR00cZMvIpJ4lolQQDtTog3hotIA=
X-Received: by 2002:a17:90b:2b45:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2f28fb667a1mr19487826a91.9.1734360867566; Mon, 16 Dec 2024
 06:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20241127130419.50489-1-mslusarz@renau.com>
 <20241216134000.1b9ceacd@donnerap.manchester.arm.com>
In-Reply-To: <20241216134000.1b9ceacd@donnerap.manchester.arm.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Mon, 16 Dec 2024 15:54:23 +0100
Message-ID: <CA+GA0_vgLijyTRCZDM0xa+5dmmfGxtggzfPvb8Z9wThiRwkutw@mail.gmail.com>
Subject: Re: [PATCH] power: axp: sunxi: configure charge current
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 16 Dec 2024 16:40:29 +0100
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

pon., 16 gru 2024 o 14:40 Andre Przywara <andre.przywara@arm.com> napisa=C5=
=82(a):
>
> On Wed, 27 Nov 2024 13:04:19 +0000
> "Marcin =C5=9Alusarz" <marcin.slusarz@gmail.com> wrote:
>
> Hi Marcin,
>
> thanks for taking care of sending a mainline patch!
>
> > Allows decreasing initial charge current, e.g. when power
> > supply is too weak to support both charging and other operations.
>
> Can you explain a bit more why and where you actually need that?

One of the boards I worked on had a design flaw where the power supply
was incorrectly sized. Booting that device on AC with an almost empty
battery led to weird behavior of some connected devices because
the board was starved by battery charging. The design bug was fixed, but
old boards exist and need to work...

> The problem I have with the code is that it's doing it in the SPL, where =
I
> actually want to decrease any PMIC usage. We really only need the PMIC th=
at
> early to set the DRAM and CPU core voltage, everything else should be don=
e
> in either U-Boot proper or the kernel.

The problem with disabling (or decreasing) charging later is that it
might be too late.
While I never tracked booting failures to that problem, it's
theoretically possible.

> So how did this work before, and why it is a problem now? AXP221 points t=
o
> some older SoC, I guess?

It's an older SoC, but it's still used to develop new products :/.

> Is it that you find yourself with a somewhat weak power supply, and if th=
e
> battery is discharged, there won't be enough power left for the system to
> boot reliably?
>
> Do you know of any existing DT property for instance that could limit the
> charge current? Or is there a sysfs property only?

It's possible to limit charging via DT and tweak it after booting with
sysfs, but
in the kernel version I had to deal with, it was not possible to disable
charging completely. And as I said, I fear it might be too late to do
it after bootup.

With all that said, there's no big need to merge this patch upstream. It wo=
uld
lower the effort to update to a newer UBoot, and I thought it's generic eno=
ugh
that someone else could use it.

Cheers,
Marcin
