Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9C5CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 16:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D369838F3;
	Sat, 11 Oct 2025 18:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f3N56uRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EC783906; Sat, 11 Oct 2025 18:46:00 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337C0838F0
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 18:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-79f79e37c04so2469231a34.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760201157; x=1760805957; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xvu5kuhHWRR6z7A9VF/MdHVx1aSJaN8TSfVhup03GQc=;
 b=f3N56uRHjMT7O7/IzDwneWPkoDolYg+WlzPmoP1fguujWZFc5IB7jRtLrPwX/yR7iq
 DTmmsagNOQI252mJcMGMZ2vjv28fJohwTZ6xnjU6VUFoVaTmmIRaj+4xNeQ+lt8/v7dy
 llMXV+cIZVBUR1LclQGJiP3ByEAxYzrgloIeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760201157; x=1760805957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvu5kuhHWRR6z7A9VF/MdHVx1aSJaN8TSfVhup03GQc=;
 b=Enl7oMkXmVNcb68G2HMNXbdAZYROZEyoId2ev29Zbmf7j7udQQRwQ6XkT6iDfIYQFc
 pxoVPD0KfkWOjYbCfBCH+Mz9MrwQAOzNOKvBNMd6UkUfzrT54v2f0W2037B9mPJtNmwX
 hcoFGgiccpygFg9vWg2EF0QZI9IgDtNqTC6JMR47jYfanRvnU1yOynsX/q74N84F316X
 Sr+C0CitduoQzmuC+hzhlzQhD2HTccfrbagMD4IjaP5CSLgei+95ac1tLLblmunxtSR+
 vDB0sBYiLlVAGEeAS372SVJZBSJgGQJcswz5lLWIDUdkcqPRXe2/SuE6XzegnKUD6bg8
 F39w==
X-Gm-Message-State: AOJu0YxvLNT1ZVkjA5J3A0/dzpi8MAq74TRnnxJbXzZ1kjkTx1kKoiZH
 MX9t/OMVExc4rivnGYjcoKvE3bMFpnJGjrckZTywIo4tISCTAxfTfqKWSe5eyCe2xPM=
X-Gm-Gg: ASbGncun423cqOYzryr2AQ3Qxvpu+6Fnq2GX0MqcF5MdCvw4ePh1MoeWFvirDc1hFm2
 Ryc6xUiMLAyJEXz3BIcDKfqt8402n3fa5e6PvqpyTDulGKv+lCPLLsLr0fBzwFc6x9g5scxNxdl
 zClkuApZDTGgNw8GuqOMFvakTC5od7TAGVQFdk016mefPU7/zuQP9LxfsFYfzppKdyXjnO0uxbJ
 bMypL0RsZ9epcUKY48nLnvvwMPl45XceHRZJa8JDMAB1CUJ5EdyyI98ZhlQumjmWASv/yWyx79k
 /tRfvHIMRY0VOqPNNRWP7sQYAyIiyWAk9JTixpo4CLhUU28zdj+tlUiceSnL3zlLrUeTTXF7L10
 K9plopdSzJnZ8gBlRP7gOCUryYf/+1sThUT79ihpK7OQv9e4/W3EPjWs8BbUAR7OSZqSrefsMud
 fsBkqNI03WLf17SwA=
X-Google-Smtp-Source: AGHT+IFSC+YJm/BxmLFrgKyRuBMvDlrpG0kKcSxGpizvNw21rnUQMos9FWzJccAZTjtvEy/Yq4DC7Q==
X-Received: by 2002:a05:6808:f14:b0:438:37eb:62c7 with SMTP id
 5614622812f47-4417b32ab4dmr8416405b6e.21.1760201156924; 
 Sat, 11 Oct 2025 09:45:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419895b2dfsm1282869b6e.24.2025.10.11.09.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 09:45:55 -0700 (PDT)
Date: Sat, 11 Oct 2025 10:45:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 4/4] boot: Move preparing bootdev into a function
Message-ID: <20251011164553.GK298503@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-5-sjg@chromium.org>
 <20251009173522.GR298503@bill-the-cat>
 <CAFLszTisxbgD3WLLQNvfi5MO1Mhbk2V_cCEnMQSod=eE8Phijg@mail.gmail.com>
 <20251010143804.GA298503@bill-the-cat>
 <CAFLszThogoq13ZrhnxkxTMQoXYPrwweriAKtDNbNKnskiAo+fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kMFGzFflgrdO0VrS"
Content-Disposition: inline
In-Reply-To: <CAFLszThogoq13ZrhnxkxTMQoXYPrwweriAKtDNbNKnskiAo+fA@mail.gmail.com>
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


--kMFGzFflgrdO0VrS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 08:20:02AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 10 Oct 2025 at 15:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 10, 2025 at 11:36:20AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 Oct 2025 at 18:35, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Oct 09, 2025 at 03:29:55AM -0600, Simon Glass wrote:
> > > >
> > > > > The code at the end of iter_inc() is already somewhat tortuous. B=
efore
> > > > > making it worse, move it into a function.
> > > >
> > > > This is not a great commit message. Taking a look at v2 as a whole,=
 the
> > > > reason to extract this logic from the end of iter_inc is because you
> > > > will be checking it in multiple places. That is a good reason to mo=
ve
> > > > the code. Adding another 5 lines of code (a single if test) alone w=
ould
> > > > not be.
> > >
> > > OK, so how about:
> > >
> > > The code at the end of iter_inc() is already somewhat tortuous. A fut=
ure
> > > series needs to call it in from two places in iter_inc(), so move it
> > > into a function.
> >
> > No, I dropped the "already somewhat tortuous" part on purpose, because
> > it's just normal regular easy to understand code. It's on that threshold
> > of indentation where you could break it out, or you could leave it, and
> > be fine. The entire reason to split it out is because it will be called
> > in multiple places.
>=20
> OK, so how about:
>=20
> We will want to use this same logic in another place within
> iter_inc(), so split it out into its own function.

Yes, that's tone-neutral and so is fine, thanks.

--=20
Tom

--kMFGzFflgrdO0VrS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOqJvQAKCRAr4qD1Cr/k
ChseAQCc3Ph5VJvOl8insyUPLNsm+dCfjt6PrS0UaWByYT6bYwD+PoAs15/HXW0o
ZbUGAVKhZVn0Tk5RjT7DAPQHDWyTIAA=
=V0Nb
-----END PGP SIGNATURE-----

--kMFGzFflgrdO0VrS--
