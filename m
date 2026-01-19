Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DA1CCF2D2
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EF78397D;
	Mon, 19 Jan 2026 10:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="an2dD0Mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30EA839E8; Mon, 19 Jan 2026 10:33:52 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F3D8397D
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BEEA1C2033F;
 Mon, 19 Jan 2026 09:33:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BA38F60731;
 Mon, 19 Jan 2026 09:33:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 34D5110B698D8; Mon, 19 Jan 2026 10:33:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768815229; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5mSIuc6ow3e3SceSgFi9pJf3tJyRmy04B3DRB48VUQI=;
 b=an2dD0MtgntkhRfNiIghLzXw0dsE7j46HX/0kIkqzZuxPp6WfFAhqlXZi9Jg9IO0OhgBAY
 FLr4OZylfOFoDdAocwmKXNZ8vcRJvf0EMIoZUdYL2Bjmu1rJBcwTVBt2J74mkqXBYrGlEE
 /wwjl6GcEaJZoZesEflALYrgqH1s07u2t19D+1ripT9IbKLsXtPfVahUqQoKpFC5MwM3Xw
 U+yl5x5gexPFw4f/My5+/B7dr5a9Niz3C52AGQouaavFMtFJlhBBhJsnhBkb3M/V1JPUVx
 207PaCHhk1O/Xqj1h9XYyFcJYwuFzS4RkrzcJwD4EqpKv2Hyw5g/uVYFA8iM2A==
Date: Mon, 19 Jan 2026 10:33:42 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michal Simek <monstr@monstr.eu>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Daniel Golle <daniel@makrotopia.org>, E
 Shattow <e@freeshell.de>, Jan Kiszka <jan.kiszka@siemens.com>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 4/5] tools: Add dumpfwumdata tool for FWU metadata image
Message-ID: <20260119103342.3ab7883f@kmaincent-XPS-13-7390>
In-Reply-To: <CABGWkvoArBqhSuwLKOn+FyUHaEkVuoSoKq7MHdqM3KE3_t8RGw@mail.gmail.com>
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
 <20251228151824.25667-5-dario.binacchi@amarulasolutions.com>
 <CAHTX3dKhhuA2rbg5fiL3bZcUNJVWLCfJ9Vppr1oEB8v6_6qHDA@mail.gmail.com>
 <CABGWkvqG_6TYTvBb9NrzJpH==Kwd21ADxwOAMpuuF98z62nx5g@mail.gmail.com>
 <10d67e2e-6515-4fb4-bf9a-77e5b0961b7b@monstr.eu>
 <20260112102434.1d352e6f@kmaincent-XPS-13-7390>
 <CABGWkvoArBqhSuwLKOn+FyUHaEkVuoSoKq7MHdqM3KE3_t8RGw@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Sat, 17 Jan 2026 12:11:18 +0100
Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> Hello Kory,
>=20
> On Mon, Jan 12, 2026 at 10:24=E2=80=AFAM Kory Maincent
> <kory.maincent@bootlin.com> wrote:
> >
> > On Mon, 12 Jan 2026 10:05:50 +0100
> > Michal Simek <monstr@monstr.eu> wrote:
> > =20
> > > On 1/11/26 16:17, Dario Binacchi wrote: =20
> > > > Hello Michal,
> > > >
> > > > On Mon, Jan 5, 2026 at 4:40=E2=80=AFPM Michal Simek <monstr@monstr.=
eu> wrote: =20
> > > >>
> > > >> ne 28. 12. 2025 v 16:19 odes=C3=ADlatel Dario Binacchi
> > > >> <dario.binacchi@amarulasolutions.com> napsal: =20
> > > >>>
> > > >>> Allow reading FWU metadata from userspace.
> > > >>>
> > > >>> According to [1], after updating the software on bank B, setting
> > > >>> active_index to point to it (i. e. 1) and marking it as a Valid b=
ank,
> > > >>> it must be possible to read this information from userspace on the
> > > >>> next boot to verify whether the boot chain of bank B succeeded.
> > > >>>
> > > >>> The metadata must then be updated again, marking the bank as INVA=
LID
> > > >>> if the active_index points to bank A (i. e. 0) or as VALID if the
> > > >>> boot was successful.
> > > >>>
> > > >>> To allow reading the active_index and bank state, this new tool h=
as
> > > >>> been added.
> > > >>>
> > > >>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.co=
m> =20
> >
> > ...
> > =20
> > > >>> +}
> > > >>> +
> > > >>> +static int fwu_read_mdata(struct fwu_mdata *mdata, const char
> > > >>> *mdata_file) +{
> > > >>> +       FILE *mfile =3D NULL;
> > > >>> +       size_t ret, size =3D sizeof(struct fwu_mdata);
> > > >>> +
> > > >>> +       mfile =3D fopen(mdata_file, "r");
> > > >>> +       if (!mfile) {
> > > >>> +               fprintf(stderr, "Error: Failed to open %s\n",
> > > >>> +                       mdata_file);
> > > >>> +               return -1;
> > > >>> +       }
> > > >>> +
> > > >>> +       ret =3D fread(mdata, 1, size, mfile);
> > > >>> +       fclose(mfile);
> > > >>> +       if (ret !=3D size) {
> > > >>> +               fprintf(stderr, "Error: Failed to read from %s\n",
> > > >>> +                       mdata_file);
> > > >>> +               return -1;
> > > >>> +       }
> > > >>> +
> > > >>> +       return 0;
> > > >>> +}
> > > >>> +
> > > >>> +int main(int argc, char *argv[])
> > > >>> +{
> > > >>> +       int c, ret;
> > > >>> +       struct fwu_mdata mdata;
> > > >>> +
> > > >>> +       if (argc < 3) {
> > > >>> +               print_usage();
> > > >>> +               return -EINVAL;
> > > >>> +       } =20
> > > >>
> > > >> above you have only help and here you are asking for 3 args which
> > > >> seems to me wrong. =20
> > > >
> > > > Thank you for your review and the feedback on my patch series.
> > > > After I sent the series, I realized that this series had previously
> > > > been posted:
> > > > https://lore.kernel.org/all/20251212-feature_fwumdata-v2-0-ad51572f=
be79@bootlin.com/.
> > > >  From what I understand, it starts from the same need as mine, name=
ly
> > > > the implementation of a tool that
> > > > allows reading FWU metadata from Linux. My version is definitely mo=
re
> > > > minimal compared to what Kory
> > > > has done.
> > > > Therefore, before sending a v2, I think it would be useful to
> > > > understand which of the two makes more sense
> > > > to move forward with. Could you help me with that? I have also CCed
> > > > Kory to keep the discussion shared. =20
> > >
> > > Kory's version looks more complete. If Kory is happy to send another
> > > version I think you should test it, review it. If he is not going to =
send
> > > v3 I think you should merge your series with his and send another
> > > version. =20
> >
> > Hello,
> >
> > I was going to ping reviews on my series.
> > I will be glad to send a 3rd version but there will be no change from v=
2 as
> > nobody reviewed it for now, but if needed I can resend it.
> > It would be nice if you review and test it on you side to know if it ma=
tch
> > your requirements. =20
>=20
> I'll be resuming work on swupdate for our STM32MP-based custom board shor=
tly
> and will test your series as soon as possible.
>=20
> Just one question: I was expecting the introduction of a tool to read the
> data contained in fwu-metadata. Why does your new tool also add write
> functionality, considering that mkfwumdata already exists?

Hello,

Because we don't want to generate a new FWU metadata every time and then wr=
ite
it on the FWU metadata partition. It is better to read and edit part of it
directly with the same tool.
The way I saw it was that mkfwumdata should only to be used on the host sid=
e to
generate the first FWU metadata.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
