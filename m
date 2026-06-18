Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2936CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 23:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B91AB84671;
	Fri, 19 Jun 2026 01:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="LyOyHBvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F40A846E1; Fri, 19 Jun 2026 01:48:31 +0200 (CEST)
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16288460E
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 01:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1781826507; x=1782085707;
 bh=9HhIC29hMVPRygcwczwuYjrPkRb2QiUjxgpZQOpPIxQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LyOyHBvQP4k9Q0h+VSj8C/T3oeFLJWFiRZiBmlVEemZJn9mfhzkHuykahJR5m+kxG
 PmOgpOO2qpDz2qM505ULV8m73M7V919ioTUnBf2TXNdbrllDn2KAHwZtCGMvWapfy/
 P+Vlqnxno6OpDpOcjqdekUXynV97kmORopM0knuI567GO4AOUEzJfhQ3I3avAqN9E/
 2CF7eKm5PC4P58CemMSY1w3OTQ/O78KE6faLb0lCa39Z1uUljPYQAZQTTdtxicddVw
 L+fgAURYSOj2hTUSaBb901cUOGev+XUHN2IJZBIKOjTWtjc4DkGLqs8toszwJDu6nq
 hDwDuWCzB6AYw==
Date: Thu, 18 Jun 2026 23:48:24 +0000
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
From: Sam Day <me@samcday.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] cmd: fastboot: Add keyed abort option
Message-ID: <0XlljVtpUbM_toRIsxmCcT9kvIUKxSwWAj8q3uUXpbjbNbBiThvWXUvS1o-IY00pY4jTF5F3u_bzQ4dW7K5IfnEC9PGh2sGNOaf62WmzDT4=@samcday.com>
In-Reply-To: <87wlw0gf4c.fsf@kernel.org>
References: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
 <20260602-fastboot-abort-keyed-v1-1-414aac5a06b8@samcday.com>
 <CAFLszTgX3x2hoFTWVy2WCuKRuZAB_T+QLAp13YTkhbM8wpkZRg@mail.gmail.com>
 <87wlw0gf4c.fsf@kernel.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 398e1669d329b61f51cca1656aaba5d1b3a139ed
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

Hello Mattijs & Simon,

On Monday, 15 June 2026 at 10:30 PM, Mattijs Korpershoek <mkorpershoek@kern=
el.org> wrote:

> Hi Simon,
>=20
> On Sun, Jun 14, 2026 at 05:49, Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi Sam,
> >
> > On 2026-06-02T08:45:46, Sam Day via B4 Relay
> > <devnull+me.samcday.com@kernel.org> wrote:
> >> cmd: fastboot: Add keyed abort option
> >>
> >> Works the same as CONFIG_CMD_UMS_ABORT_KEYED does: any keypress will
> >> abort fastboot mode (rather than only ctrl-c).
> >>
> >> Signed-off-by: Sam Day <me@samcday.com>
> >>
> >> cmd/Kconfig    | 6 ++++++
> >>  cmd/fastboot.c | 9 ++++++++-
> >>  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> >> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> >> @@ -103,8 +103,15 @@ static int do_fastboot_usb(int argc, char *const =
argv[],
> >>       while (1) {
> >>               if (g_dnl_detach())
> >>                       break;
> >> -             if (ctrlc())
> >> +             if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
> >> +                     if (tstc()) {
> >> +                             getchar();
> >> +                             puts("\rOperation aborted.\n");
> >> +                             break;
> >> +                     }
> >> +             } else if (ctrlc()) {
> >>                       break;
> >> +             }
> >
> > I wonder if you could create a shared function (gadget_abort_check()
> > ?) to keep this and the code in usb_mass_storage.c in sync?
>=20
> While I usually advocate to avoid code duplication, I don't think it's
> needed to create a new function here. It's only a couple of very simple
> lines.
>=20
> To me this can stay as is.

I lean this way too, so I opted to leave this code as it is.

>=20
> >
> >> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> >> @@ -103,8 +103,15 @@ static int do_fastboot_usb(int argc, char *const =
argv[],
> >> +             if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
> >> +                     if (tstc()) {
> >> +                             getchar();
> >> +                             puts("\rOperation aborted.\n");
> >> +                             break;
> >> +                     }
> >
> > Can you please update doc/android/fastboot.rst to mention the new
> > Kconfig and the abort behaviour. There is currently nothing in that
> > file about how to leave fastboot mode at all.
>=20
> For the current behaviour, I have send:
> https://lore.kernel.org/all/20260615-fastboot-doc-ctrl-c-v1-1-f932dea17c0=
a@kernel.org/

Thanks, I've added that as a dependency to the v2 of this series, and
supplemented it with a paragraph about CONFIG_CMD_FASTBOOT_ABORT_KEYED.

Cheers,
-Sam

>=20
> >
> > Regards,
> > Simon
> 
