Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614E9C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 09:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F87D803DF;
	Thu,  5 Jun 2025 11:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K6dzYZYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F033B80050; Thu,  5 Jun 2025 11:06:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D1781E25
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 11:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3AF965C5A1A;
 Thu,  5 Jun 2025 09:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C96AC4CEE7;
 Thu,  5 Jun 2025 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749114397;
 bh=994rQ55/xtsBas5Yagz2nV8pFDkFNfcLQbZ4ACHmpR0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=K6dzYZYC6Y5NmDnYR65hDK/tB5fuFrF835F0tKb6DkNA2tc+KucMvZKvyB8aHWl18
 +GJFLIcHY3Du/+NYLoQLR9vglNt51ZHDCE1WLOCGZ+8+2aDLPubujIw+VeafJebz+l
 w8uJ/aO7fCB/FH9IXnKBthBgvhSOLV0sAEWqa2NTlEpZQ4PL68Lc9tFbFB9NE+Infz
 i9mNDSG9YxkOK3ZBvkpmMJsVFKdVC0BI/xg/N+oiXqF+JUq+RC1sCRGOUv23sg1gmI
 Uanh1B0EvnP1srG4m9IGLLJ62Ncye5/kqVKyggdZn/Y1q3SBC4j4zOmd6Ux6ZqhrKh
 pRiMu7kTgmPAw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Shmuel Melamud <smelamud@redhat.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Shmuel Leib Melamud via B4 Relay
 <devnull+smelamud.redhat.com@kernel.org>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] renesas: Renesas R-Car Gen4 watchdog driver
In-Reply-To: <CAMFVLy3mBpTsLD4nKr=cfY0oRYbkRf9rszKYAY3vxhJ81_X=2w@mail.gmail.com>
References: <20250603-us-renesas-watchdog-v3-0-af3a65afd03e@redhat.com>
 <20250603-us-renesas-watchdog-v3-2-af3a65afd03e@redhat.com>
 <87bjr3ubwe.fsf@kernel.org>
 <CAMFVLy3mBpTsLD4nKr=cfY0oRYbkRf9rszKYAY3vxhJ81_X=2w@mail.gmail.com>
Date: Thu, 05 Jun 2025 11:06:35 +0200
Message-ID: <8734ce36ck.fsf@kernel.org>
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

Hi Shmuel,

On jeu., juin 05, 2025 at 06:33, Shmuel Melamud <smelamud@redhat.com> wrote:

> On Wed, Jun 4, 2025 at 12:02=E2=80=AFPM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Shmuel,
>>
>> Thank you for the patch.
>>
>> On Tue, Jun 03, 2025 at 06:06, Shmuel Leib Melamud via B4 Relay <devnull=
+smelamud.redhat.com@kernel.org> wrote:
>>
>> > From: Shmuel Leib Melamud <smelamud@redhat.com>

[...]

>> >
>> > +
>> > +static int rwdt_start(struct udevice *dev, u64 timeout, ulong flags)
>> > +{
>> > +     struct rwdt_priv *priv =3D dev_get_priv(dev);
>> > +     u64 max_timeout;
>> > +     u8 val;
>> > +
>> > +     max_timeout =3D DIV_BY_CLKS_PER_SEC(priv, 65536);
>>
>> Why 65536. This number is used here ...
>
> 65536 here is the maximal value of the counter plus 1. If we divide it
> by the number of impulses per second, we get the maximal timeout in
> seconds.
>
>> > +     timeout =3D min(max_timeout, timeout / 1000);
>> > +
>> > +     /* Stop the timer before we modify any register */
>> > +     val =3D readb_relaxed(&priv->wdt->csra) & ~RWTCSRA_TME;
>> > +     writel_relaxed(val | CSR_MASK, &priv->wdt->csra);
>> > +     /* Delay 2 cycles before setting watchdog counter */
>> > +     rwdt_wait_cycles(priv, 2);
>> > +
>> > +     while (readb_relaxed(&priv->wdt->csra) & RWTCSRA_WRFLG)
>> > +             cpu_relax();
>> > +
>> > +     writel_relaxed((65536 - MUL_BY_CLKS_PER_SEC(priv, timeout)) | CN=
T_MASK,
>> > +                    &priv->wdt->cnt);
>>
>> ... and here. Can we move it to a define to document its meaning?
>
> 65536 here is for negation. Since the counter is incremented on every
> impulse, the timeout is the number of impulses that are left till
> overflow of the counter.
>
> In both cases it is the maximal value of the counter, so maybe it
> makes sense to add a define for it.

Yes, please move this to a #define. With this constant moved to a
#define, you can add the following to v4 patch:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Thanks,
Mattijs

>
>> > +
