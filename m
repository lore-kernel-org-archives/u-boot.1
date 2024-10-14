Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE76D18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6DA6891CE;
	Tue, 15 Oct 2024 00:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LI/WaszM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C12489215; Tue, 15 Oct 2024 00:43:16 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B74891AA
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7afc591c69cso328186185a.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728945792; x=1729550592; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u3psiFT+neP/OrRNma+9kDxdfc4QTgDA74Vwsy7cCrU=;
 b=LI/WaszM9XVNLi4x49ENF2KvrPpT5hDeo/szBqC0kW7ljCwhoiy+VxkkPEcKgfvm27
 04TXSUkrTeqLef8tU0bqm/7W/7AO617eiZJZ5KMMs2GsQhxvFo8OSA5cJlJZ9xSpl5ta
 IWGge9Op5/S1JtEEeFkjDTuwxNJ/JcH3JFKnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945792; x=1729550592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3psiFT+neP/OrRNma+9kDxdfc4QTgDA74Vwsy7cCrU=;
 b=wmWoluvmVPFhenW0rE/YNrdtU4tka4e+HlEFjZxemobVlxcnSS1FJe64PxLyaJ3d/w
 uem3mK0yz9vldROUrdxkKL3J24HnSOufNXXNwOTXFcSlgWJdACsGrCPHWS9iHH9PmYl6
 op5hPl3h3EJnyoFyG7q3iZIqnAF2zWW7Dhhw6Bq3pH+fwjtZqRPPDP18A5N7s+4oe5Wl
 MpSnYOUehcmk/VkzOVJOtVRRrqsFOmrM6n+JXqEW5WqRxL4j0o6C3PSu45OcOV5KBmCU
 WyOsux2NtcXD6xw9n7K6Q+xBz+r89j/785MsnPbHlS9J0JRhCpAVIHERwCWrtUSjQQ7B
 OYjQ==
X-Gm-Message-State: AOJu0Yyk1a7jHKdoASbP9LDxCaeDJQqHzLVv8xrThiFGgozyJ0ZWXuQ6
 KE0CbMgkIeGA6hvgnklqw1sgcL4lspfdeX8acQoOMZ2Z8NuIXYG7lXI9joikwtY=
X-Google-Smtp-Source: AGHT+IH/EXvxYYfDLAgetdu8wFT48vIof7NhiS1mAukFE0N54tfuGmgXoa5rKGQgir8rL2RzAkC9IQ==
X-Received: by 2002:a05:620a:7209:b0:7ac:c359:f132 with SMTP id
 af79cd13be357-7b11a37a38bmr2123523085a.26.1728945792136; 
 Mon, 14 Oct 2024 15:43:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b136395215sm2521985a.75.2024.10.14.15.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:43:11 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:43:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 3/3] RFC: CI: Skip building dtc for world builds
Message-ID: <20241014224306.GG53053@bill-the-cat>
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-4-sjg@chromium.org>
 <CAFLszThRC=YvhPaiQD2bnvNFsGZZVexa3cx=NZ6PaBEdB-7Z2A@mail.gmail.com>
 <20241010190110.GV14210@bill-the-cat>
 <CAFLszTjFeT+OKLrUT1Ck_D15nqxoJcq18LMmWFbJAwQocEvm4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="glFSo4oqzsOBqRI1"
Content-Disposition: inline
In-Reply-To: <CAFLszTjFeT+OKLrUT1Ck_D15nqxoJcq18LMmWFbJAwQocEvm4A@mail.gmail.com>
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


--glFSo4oqzsOBqRI1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 01:13:26PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 10 Oct 2024 at 13:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 10, 2024 at 12:50:11PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 15 Aug 2024 at 13:58, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This is quite a significant waste of time in the world builds as dt=
c is
> > > > built separately for each board. Skip this to speed up the builds.
> > > >
> > > > Unfortunately the newer dtc produces a lot of warnings, which cause=
s CI
> > > > to fail. I am not sure what we can do about this.
> > >
> > > What do you think about this one?
> > >
> > > We could install an older dtc in the container, perhaps?
> >
> > Is backporting applying whatever dtc flags we need to ignore problems
> > that Linux isn't enforcing so difficult? That would then tell us just
> > how much work it is / isn't to deal with the rest of the dts files (or
> > poke maintainers to switch to OF_UPSTREAM where the issues are likely
> > fixed).
>=20
> That could work. Shall I give it a try and then we apply this patch if
> I figure it out?

Sure, thanks.

--=20
Tom

--glFSo4oqzsOBqRI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNnncACgkQFHw5/5Y0
tyxA4Av/azz4L23qaDNAiv/1Y62MjiohCzClud9m1ljPmt3HBBkAwKoWC7B1L3FR
oPVLesKrgx/fe+0o8gW4QUUuhVhQj9yT88HrSUCF84bO/viXrD4N6MXPxgPUr8kF
OC/f7W5T+lBGaShXxseUAUlcbhRH7pp1QJPCE2g5UxT+6lWtgl4p0422hd6EuG9P
u7hGyIlIdNhQXaQ7rjFC3Y3eldZfcJMjg52dGzemVGi+GsgOEzJxpjukcsKjp0Im
JpEhMBs8CP5ofxodcsXBWWS7vl/oBpnoFshu/uFP/of3bfnVfdn+fE6up+ZVWkiv
qAei4wIdCbVS63LaJqrZg0ZAAKaJg9XdmW5tu0cZkSUyYAWt9cEmM83Jr7ZPNoKw
aiIp7zaLMhUZY7MI/qhJfDSBps7AUNoFkUKIfWWf/a2L8mq/tLhBWsw2EHAmR+bA
0xxYUU7qn3mkVlIY4zk5U4bkMgUYg0DHDsEev55Q+2wjc+qL2UpPJiKfsr1qVCnI
uzPUoLYe
=F9xs
-----END PGP SIGNATURE-----

--glFSo4oqzsOBqRI1--
