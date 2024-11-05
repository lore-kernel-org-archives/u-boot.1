Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD06D40CE8
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 23:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38B889048;
	Wed,  6 Nov 2024 00:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D0n8Q0We";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DE2088E96; Wed,  6 Nov 2024 00:00:34 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45FD988EBB
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 00:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b14df8f821so521047285a.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 15:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730847631; x=1731452431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zc7Yast4JJD7Aj7yJzQhvhfZFkMPGcivkfu1LZ5PkVU=;
 b=D0n8Q0We0wEOsYnBHlXAzn20B0rpXS5pRKRukntbjfMZ1kgLCagkecLd52dKRqQsPj
 PiQMlS/dyOhIaD0fKgjENGT0QXYkZlhglG2Yc0ny3zVhRQZ/GWgbudFBRM15mI5Co7bH
 SQ7f4c7/8YmecwqpYHZk2DadpPDAyU4WKReVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847631; x=1731452431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zc7Yast4JJD7Aj7yJzQhvhfZFkMPGcivkfu1LZ5PkVU=;
 b=tdp44tjCb62Ednkmz6ujA88RHv7LPjsA/Tl2HchY98nJA/V0ZtHnsYgNX6nO0jKyny
 peZcqCjGgv+yP2uU4lB9rPG+1i1Nfpv3HbjVKRat/3tY7lhkc8uh+lSt0jJzQvgWJ8nc
 8IU7NdPNUXaEOWNK1yOnxtBcjnaaNIYVXPff/uGbb7kK3SZg98e9b9QkH9f4bfXSAKs9
 iO4l9MsIgWL+tbQhSB8xSa+juOSsH5uXxak3eC05G3MC5jGtCXyBNXbc2faycA8gaNRM
 HARXCtA+rm3U+evuv+4Dw4ZHreb0CCR+L1kAQf+q4GiKy+kE0A/DQqsfnYCMTvJpjpef
 9v1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIwoug2BVnQBcmXUqcnmjMguPX4fZOYEhKv6+b/hduAsQhp+AFEnH5RIMzmmlAg/N9Ia/duJc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1gXfuSBlv0p5QJqNwr8ByKFrl0PPMFGv1ICjgnHJKnUL6xX7Y
 tnoXTuayQvOVYGGsu6NKqP64PxyimpHNGpOHhDIeCltfi0xKK3SRshw2qZb993Y=
X-Google-Smtp-Source: AGHT+IHSI7ZoU5lTHM4dK4h6p3UsZo6esstbpWJsaRyA8mBrBOPKsNHxfnUP0KbDwyyKo3qevx7KFQ==
X-Received: by 2002:a05:620a:1a93:b0:7b1:4e01:547c with SMTP id
 af79cd13be357-7b2fb987f3amr2486674785a.27.1730847631072; 
 Tue, 05 Nov 2024 15:00:31 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a813a7sm570161285a.100.2024.11.05.15.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 15:00:30 -0800 (PST)
Date: Tue, 5 Nov 2024 17:00:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
Message-ID: <20241105230026.GP3600562@bill-the-cat>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
 <20241105154741.GI3600562@bill-the-cat>
 <CAFLszTjntxJShjnWK++NkonNrPdL0S-=zWf-N_AWUaZmfmArtg@mail.gmail.com>
 <20241105182619.GL3600562@bill-the-cat>
 <c8ad5da6-ba6b-4465-b00a-c7539c6f6bb1@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l1gSZVcays1OtbaT"
Content-Disposition: inline
In-Reply-To: <c8ad5da6-ba6b-4465-b00a-c7539c6f6bb1@iopsys.eu>
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


--l1gSZVcays1OtbaT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 09:59:57PM +0300, Mikhail Kshevetskiy wrote:
>=20
> On 05.11.2024 21:26, Tom Rini wrote:
> > On Tue, Nov 05, 2024 at 09:07:17AM -0700, Simon Glass wrote:
> >> Hi Tom,
> >>
> >> On Tue, 5 Nov 2024 at 08:47, Tom Rini <trini@konsulko.com> wrote:
> >>> On Tue, Nov 05, 2024 at 08:15:25AM -0700, Simon Glass wrote:
> >>>> Hi Peter,
> >>>>
> >>>> On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> w=
rote:
> >>>>> On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
> >>>>>> Hi Tom,
> >>>>>>
> >>>>>> On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>> On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wro=
te:
> >>>>>>>
> >>>>>>>> Legacy TCP stack is bad. Here are some of the known issues:
> >>>>>>>>  * tcp packet from other connection can break a current one
> >>>>>>>>  * tcp send sequence always starts from zero
> >>>>>>>>  * bad tcp options processing
> >>>>>>>>  * strange assumptions on packet size for selective acknowledge
> >>>>>>>>  * tcp interface assumes one of the two scenarios:
> >>>>>>>>      - data downloading from remote host to a board
> >>>>>>>>      - request-response exchange with a small packets
> >>>>>>>>    so it's not possible to upload large amount of data from the
> >>>>>>>>    board to remote host.
> >>>>>>>>  * wget test generate bad tcp stream, test should fail but it pa=
sses instead
> >>>>>>>>
> >>>>>>>> This series of patches fixes all of the above issues.
> >>>>>>> I know Peter asked on the last one, but I want to ask as well. Wi=
th lwIP
> >>>>>>> merged, why do we want to add features to the old stack? I can see
> >>>>>>> fixing issues, but not adding new functionality as well. Thanks.
> >>>>>>>
> >>>>>> Let's apply this. It has tests and the old stack is still used by a
> >>>>>> lot of boards. At present lwip is only used on one. There is more =
work
> >>>>>> to do on the new stack, including finishing off the sandbox
> >>>>>> implementation.
> >>>>> I agree with applying the fixes pieces, I do not agree with apply t=
he
> >>>>> HTTP server pieces. This series should actually be split into 3
> >>>> But what is your objection?
> >>>>
> >>>> I would much rather just apply it ASAP. It has already gone through =
12
> >>>> versions, during which lwip has been prepared and applied.
> >>> Yes, and to be blunt, the first bit of feedback I provided was "can y=
ou
> >>> please look at the lwIP series instead?".
> >>>
> >>>> The HTTP server is a useful feature and we should be able to use it =
to
> >>>> test networking in U-Boot in a more self-contained and performant
> >>>> manner.
> >>> I very much do not want to add more features to the legacy TCP stack.
> >>> We're likely, long term, to still need some cut-back version of the o=
ld
> >>> stack for the limited SPL cases.
> >> This series has been in progress for a long time and it seems unfair
> >> to just drop it, with one one board on the new stack.
> > Well, I continue to not say that we should drop the series, but that we
> > should take the fixes and not the new features. Because as far as I can
> > tell, the current TCP stack is in such a shape that it's not
> > production-usable anywhere and so the number of users argument is
> > irrelevant.
> >
> I expected something like this when lwip was finally merged.
> I was a bit surprised when Simon decide to merge this patch series.
>=20
> At the moment we have no plans to update u-boot or backport lwip patches
> to u-boot-2023.10.

I'm sure it would be engineering-wise prohibitive. And, thank you for
contributing your TCP related fixes upstream, it is appreciated and in
the absence of the lwIP work would have been entirely uncontroversial.

> So we will use our solution based on a legacy stack. I understand that
> we should switch to lwip somewhere in the future. Unfortunately it's=A0
> not a fast and easy process (update u-boot, rewrite http based firmware
> upgrade, test new u-boot for several hardware configurations, test
> customer devices migrations and so on).

That is always a challenge, yes.

> Also we are limited in resources, so I am able to put my hands on u-boot
> only from time to time.
> So this is a long story.
>=20
> Tom, Simon, Peter: what patches do you want to accept?

In a quick look, 1-10 look like bugfixes to the stack with 11 being
netcat and 12/13 being httpd, and I assume that's what Peter meant by 3
series instead of 1. So those first 10. And thanks again!

--=20
Tom

--l1gSZVcays1OtbaT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqo34ACgkQFHw5/5Y0
tyxWUwv/WNu+bAV74kBfHT5Ei42B3/lgnV4FEuN5xsvWJWTi0C9rhT8v/6BmmVB3
4ib/yQsRhFdWum/vRCT8Jm5Bm2L5s/TCeho8l8uRFcLrQsvHmhBXykI5dubuxl2k
dw+mnkGjM4a/zE47ANv65IHMwgl8q5zFjaFBTkANzJgbjLNUFu9W6ZZm3/tB6+ua
7k1KuFy9a0NvCLqVJXFexz60phu/SjLiRxdB1ywu/Pt+yARHrY0xJE9N4deituo7
UE5Bg9r3YxbVSR8OdWhiL5SqUMdFPTGTGFJ+4AhshDKyWNoPmsLTLqyNtQgJ2M2V
L/4kAwx9vTH7oAQZIzpSSLegcJTNllWHO7+OU8VQSkff3KNCvgaVt1o6KsMWWcg+
fGE7Jz+GG4HOEiZpPIh0RRAlP2x17kEk50qHmr7gUrtlAtoL6bHwXDQeH+GfENHI
3Xxv07uxQUAktM+6iAeoZVRhNExbvTxmeAVy8eUgzGZl+HaXIdHeyW5PZ285aK3o
/+HnuyYP
=njfS
-----END PGP SIGNATURE-----

--l1gSZVcays1OtbaT--
