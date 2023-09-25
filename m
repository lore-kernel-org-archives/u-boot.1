Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0C0CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FCB386BAE;
	Mon, 25 Sep 2023 16:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hfnF7A2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5242F86BE6; Mon, 25 Sep 2023 16:28:30 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0589886B89
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59e88a28b98so95683917b3.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695652106; x=1696256906; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RkVH/B8/Pvu7PMfEOTKcdGITyDXnc+yXRUzFj08jNlg=;
 b=hfnF7A2I9DQZctUzqakHT5WeKbAB1QBJ4bEPM+i7QUaG9+SqXoAR0cU0GKqvs1c2Xd
 WUavdrKJS1HmaGxp73L8calo53qBogt+FJZmp1nMjp8Pnq8gxn+TZgdsXR6vAAU4UqR0
 PpLdjSiousSOQgyZGqDz/44gTiTAQg8vNAmlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695652106; x=1696256906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkVH/B8/Pvu7PMfEOTKcdGITyDXnc+yXRUzFj08jNlg=;
 b=ukzwao3JMa1hR9DzUN84CmAwasDtDWujej64vzZ+HOSxxFxUCMHE7CeuX9r+OYKX9E
 P7Q3HQ6KC9HAZFhWVPQSQZvu+BxWxE+hLlC+5PxIdecEs6NqDNgR3p+szkQots2Lyaos
 C8x1laCSQHIwCSDCD4ddNbM5RsCcXUpnnosBhEQKrMROZd/fWNbNAiTe0OR1m8FW1Sqd
 FlZPgnQTpU5Gj4pG1LSeQ4/uCXZUeGcoOzMQk3gZ3eCQAphSAVZJ+BdPD97M6JI4QjMV
 T5x3s/djktT0d6izUEVj3IvADu3UrUbeRDb14WCGe5QtnxY9kepB0HUilWcYrph6efda
 CeDw==
X-Gm-Message-State: AOJu0YyvAlYv+zBQj+yZVkX/q6rtpfw0GxlocEc+nibEfQx6/V4cbh+t
 hDkxDGUEXSMz0096G3L4wBcvFA==
X-Google-Smtp-Source: AGHT+IGibPlEibbc0DI5QJlwyre8ykYUa4sx99rBw1cm2A0qFzSGoMHj0PX2En1IB7h0DqLlFoPS0A==
X-Received: by 2002:a81:4e56:0:b0:5a1:d4a5:7ddc with SMTP id
 c83-20020a814e56000000b005a1d4a57ddcmr130599ywb.8.1695652106609; 
 Mon, 25 Sep 2023 07:28:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 x202-20020a81a0d3000000b0057399b3bd26sm2427641ywg.33.2023.09.25.07.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:28:26 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:28:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Message-ID: <20230925142824.GY305624@bill-the-cat>
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PwKjuZ1Krt4OdLAy"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--PwKjuZ1Krt4OdLAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 08:01:41AM -0600, Simon Glass wrote:
> Hi Michal,
>=20
> On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
> >
> >
> >
> > On 9/25/23 15:10, Simon Glass wrote:
> > > Hi Michal,
> > >
> > > On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> wr=
ote:
> > >>
> > >> Hi Simon,
> > >>
> > >>
> > >> On 9/23/23 20:13, Simon Glass wrote:
> > >>> Current alignment which is using 16 bytes is not correct in connect=
ion to
> > >>> trace_clocks description and it's length.
> > >>> That's why use start_addr variable and record proper size based on =
used
> > >>> entries.
> > >>>
> > >>> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary form=
at").
> > >>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> > >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> > >>> ---
> > >>>
> > >>> Changes in v2:
> > >>> - s/start_addr/start_ofs/g'
> > >>>
> > >>>    tools/proftool.c | 31 +++++++++++++++++++++++++++++--
> > >>>    1 file changed, 29 insertions(+), 2 deletions(-)
> > >>>
> > >>> Applied to u-boot-dm, thanks!
> > >>
> > >> FYI: I have merged it to my tree and already sent pull request to To=
m.
> > >> Without it I couldn't pass CI loop to get all reviewed features in.
> > >>
> > >> https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd=
=2Ecom/
> > >
> > > Ah OK, well that's fine. It was in my patchwork queue still, which
> > > suggests that the patches were not set to 'applied'?
> >
> > I am not using patchwork. But I expect my reply to cover letter was rec=
orded there.
>=20
> Probably. If you reply to each patch, it shows up in the patch, but
> the cover letter is hidden somewhere else.

Patchwork doesn't, but b4 does, handle tags sent to the cover letter
rather than individually.  Patchwork does have a link to the cover
letter, on individual patch links under the "expand" link on the
"Series" line.

--=20
Tom

--PwKjuZ1Krt4OdLAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURmQgACgkQFHw5/5Y0
tywDowwAo16kN/iM546nCV6V6c2J+7Hkm0b70RwmYME3N6BPgL4xzU4Vie8MxBuk
2CK/xXqIryhaTauFBwrn1105NPhamwgVKbt4n2o60ja8qHjn9bSw2jrTE/o9cvK9
4MJWY9a+eYR5ty46W6btGY0Fl+0qA3G13UWmW4hFKZho/FCYxSCKwpkk6dunh1Hu
9nAfdzdM0Iz4MFNfPABq6GliwKQkz2vVodn1moKMaE1OGdGtNeJV1NaNx3ULgYXb
WGQPbZJqATr5x0bBaB4KsNYRX1Odydk865Kk/3B0gWS0QWam8LqJXuPi9DHawYW5
zXh6bKH7u5jVr5tAmfCVPqN9P088rsOx2SiHdeMXVmSnJ7Rwkppuoj3fzUTVadx4
/iw+6R4IqZwB+CG3yMLgQZgwcm5NCK33ZnxeMItrwZkRdrHiTXEB9E+MIHjOiifB
B4/gsrs5+CJCAO3Wd+zwZnU8oQssrA/PbJzaOTKIAsOWlwqhFdJjQ7hMC1ZsT4c4
5N3dD7aB
=tAf1
-----END PGP SIGNATURE-----

--PwKjuZ1Krt4OdLAy--
