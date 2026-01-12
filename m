Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C43DD2505C
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1287E83CBD;
	Mon, 12 Jan 2026 10:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wIsa2o52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C7D83CEA; Mon, 12 Jan 2026 10:24:43 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB2F83CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 580CBC20864;
 Mon, 12 Jan 2026 09:24:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A472660732;
 Mon, 12 Jan 2026 09:24:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 18F5A102F15A3; Mon, 12 Jan 2026 10:24:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768209879; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DLBDT3SVI6+q+vx1aw0QF/SkkSG6pMapmw+mYVAq25I=;
 b=wIsa2o52PAoJOo24ng9nf2LMTPQeJIrcPwS8J9OEi83nZ4lk/BFVVfNFp75uEmPodfT9Sj
 d2KRWVejG1eYDknEJKa8p0rAFGd6/MnPHulx6bgNmXiAw2U7+jo4subi2daPZGltH9UVuE
 WEWsnTTJhIlxFIYQXsWYS3CDW7HNHUbC04Yee0RnjXw/TjTMoFbvcBhJaYf+hobiRW7ec4
 S5/wXTvSxhsXA4B6+/T9cBku9aAdypyZsnjW1sokXb+sw9CtnRXYhEK+YBedfFE/LMTVxv
 l1y02S7kJR3BWX52ZZ0P2P3wBv2Jy2Kk5mEQnS2gaYJH9FkLDbJR/JM5tnuthQ==
Date: Mon, 12 Jan 2026 10:24:34 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, Daniel Golle
 <daniel@makrotopia.org>, E Shattow <e@freeshell.de>, Jan Kiszka
 <jan.kiszka@siemens.com>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Shiji Yang <yangshiji66@outlook.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 4/5] tools: Add dumpfwumdata tool for FWU metadata image
Message-ID: <20260112102434.1d352e6f@kmaincent-XPS-13-7390>
In-Reply-To: <10d67e2e-6515-4fb4-bf9a-77e5b0961b7b@monstr.eu>
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
 <20251228151824.25667-5-dario.binacchi@amarulasolutions.com>
 <CAHTX3dKhhuA2rbg5fiL3bZcUNJVWLCfJ9Vppr1oEB8v6_6qHDA@mail.gmail.com>
 <CABGWkvqG_6TYTvBb9NrzJpH==Kwd21ADxwOAMpuuF98z62nx5g@mail.gmail.com>
 <10d67e2e-6515-4fb4-bf9a-77e5b0961b7b@monstr.eu>
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

On Mon, 12 Jan 2026 10:05:50 +0100
Michal Simek <monstr@monstr.eu> wrote:

> On 1/11/26 16:17, Dario Binacchi wrote:
> > Hello Michal,
> >=20
> > On Mon, Jan 5, 2026 at 4:40=E2=80=AFPM Michal Simek <monstr@monstr.eu> =
wrote: =20
> >>
> >> ne 28. 12. 2025 v 16:19 odes=C3=ADlatel Dario Binacchi
> >> <dario.binacchi@amarulasolutions.com> napsal: =20
> >>>
> >>> Allow reading FWU metadata from userspace.
> >>>
> >>> According to [1], after updating the software on bank B, setting
> >>> active_index to point to it (i. e. 1) and marking it as a Valid bank,=
 it
> >>> must be possible to read this information from userspace on the next
> >>> boot to verify whether the boot chain of bank B succeeded.
> >>>
> >>> The metadata must then be updated again, marking the bank as INVALID =
if
> >>> the active_index points to bank A (i. e. 0) or as VALID if the boot w=
as
> >>> successful.
> >>>
> >>> To allow reading the active_index and bank state, this new tool has b=
een
> >>> added.
> >>>
> >>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

...

> >>> +}
> >>> +
> >>> +static int fwu_read_mdata(struct fwu_mdata *mdata, const char
> >>> *mdata_file) +{
> >>> +       FILE *mfile =3D NULL;
> >>> +       size_t ret, size =3D sizeof(struct fwu_mdata);
> >>> +
> >>> +       mfile =3D fopen(mdata_file, "r");
> >>> +       if (!mfile) {
> >>> +               fprintf(stderr, "Error: Failed to open %s\n",
> >>> +                       mdata_file);
> >>> +               return -1;
> >>> +       }
> >>> +
> >>> +       ret =3D fread(mdata, 1, size, mfile);
> >>> +       fclose(mfile);
> >>> +       if (ret !=3D size) {
> >>> +               fprintf(stderr, "Error: Failed to read from %s\n",
> >>> +                       mdata_file);
> >>> +               return -1;
> >>> +       }
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>> +int main(int argc, char *argv[])
> >>> +{
> >>> +       int c, ret;
> >>> +       struct fwu_mdata mdata;
> >>> +
> >>> +       if (argc < 3) {
> >>> +               print_usage();
> >>> +               return -EINVAL;
> >>> +       } =20
> >>
> >> above you have only help and here you are asking for 3 args which
> >> seems to me wrong. =20
> >=20
> > Thank you for your review and the feedback on my patch series.
> > After I sent the series, I realized that this series had previously
> > been posted:
> > https://lore.kernel.org/all/20251212-feature_fwumdata-v2-0-ad51572fbe79=
@bootlin.com/.
> >  From what I understand, it starts from the same need as mine, namely
> > the implementation of a tool that
> > allows reading FWU metadata from Linux. My version is definitely more
> > minimal compared to what Kory
> > has done.
> > Therefore, before sending a v2, I think it would be useful to
> > understand which of the two makes more sense
> > to move forward with. Could you help me with that? I have also CCed
> > Kory to keep the discussion shared. =20
>=20
> Kory's version looks more complete. If Kory is happy to send another vers=
ion
> I think you should test it, review it. If he is not going to send v3 I th=
ink
> you should merge your series with his and send another version.

Hello,

I was going to ping reviews on my series.
I will be glad to send a 3rd version but there will be no change from v2 as
nobody reviewed it for now, but if needed I can resend it.
It would be nice if you review and test it on you side to know if it match =
your
requirements.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
