Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D553C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 13:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 701FC84A26;
	Wed,  1 Jul 2026 15:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ESut5eVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF76684B62; Wed,  1 Jul 2026 15:48:07 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65DD8484C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 15:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e9bc8dd61fso588178a34.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782913684; x=1783518484; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7mMIHvBL6MIgj5C0kAXMGOjgZktbjmJTiveK5Lc3LQw=;
 b=ESut5eVFHqNlADUnes7gWfXvKJsAamq3FYzk+2vRNfKwc+SE2P7ibuD9l9UPxXFxcJ
 hgJehdpme7nvn+LAqwfINVT+PJwN9DdzO6fMGAPETnhdHFQ9nIB8cMqo6nJ86a6P9y8W
 NRd7c2TNfLghao3uz3Heamvd9du2uJCF8YlQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782913684; x=1783518484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mMIHvBL6MIgj5C0kAXMGOjgZktbjmJTiveK5Lc3LQw=;
 b=Xe9q9yftLHfWxiC3bSEoDkoRaA1lNaKmq7YHCDytXedByz4sZOiItOXiXy+XKRHPM/
 Bv/lCEoj9GyJLQDT8EejgAh3DGn67kDW5jC7GrjjJxHKvFvWu1ETmrrhSocbTu+weGLk
 9t8TuBS9U6T3dunKBtF4MQbp0bUxs9BTSEk3ftY9nhvK7k/T/LrLR5Mo5ihuVTOKAvqG
 QmrRZm/s/s0+oA73YDAV2frF4VtACibooyIIO4Xqb2D3bE6J53eBNvA1x5mpMc2wxGkb
 /+YNzYZUH8Uga4u4MsimDq+h8UpeM+mFtIdHCGabD9y23tse4xvR6JoaMPkdwarl4DqT
 dfLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uZJTokOKyG2Z3xiQsMw89a06BRmKgzJJr5v3MZvwv7DmGBLZEwbeK2fD3GgeYEURFo8POHk0=@lists.denx.de
X-Gm-Message-State: AOJu0YwPt01LIxi5KwXTTf2eMSfdaRRvqKSE+jYCmqEB5MyW3Qc7EtgG
 tUrFUVdpHW5+VoxDnsI6DKjRW45BAf0VnkPLj5z6brUr9DmtgqnEypqRxO/Wx0eBdWg=
X-Gm-Gg: AfdE7cnNIL+J+Y3uZ0Z2SzSKXvpOT27j5gvI68d910HmvnjxWZEY5EbNAMYNtaqduZp
 2ysriRoQ3NXsJhJF2TfjMCoZ9iz4f1FWCYWrU6gWbBumEKVBYubNRoaNob3igV7zMwOE0FPEbot
 BZfEvBDU4M0Vpa0qM93cAPNaF7hu7Sv8m9e2nO3o2fbFMjtUv/w6utQmCR6YrcGbK3JGB4Ms+mB
 WXClEBixRu0GLVLwyK8Q0qOtdtw1ImihSmP//Fa4HKFDjF1nZ3BlYdCYgimS6zYB9hd7kIyrbVD
 JbR1hsLh+IsVGn20IrMTuveqoq9NktOnAfn1b63Rh4VaRVqKQq1reTLIXUXRY17TU7vlWmte/yL
 2Dmlrw0v0qVCIOdQcan3XMms9MG8q8cD2EeFXHwaI/NElKw/h11zsdyEgO9FOxMuDTtOgDKlnYx
 h0vcI8U1P+7NFZ1TceDWNZWo0wTAGYxijfAPAvzyFO4OSUM3zWBE8+njt1FyNb44a8I8h2T9s6x
 ekilH8l5iHTTbaXWQ9IIEJRX6MQAJIGWEzHNA==
X-Received: by 2002:a05:6830:2317:b0:7e9:cf5d:b7c3 with SMTP id
 46e09a7af769-7eb5051c90emr630553a34.23.1782913684268; 
 Wed, 01 Jul 2026 06:48:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9ec307edesm4873172a34.21.2026.07.01.06.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 06:48:03 -0700 (PDT)
Date: Wed, 1 Jul 2026 07:48:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: U-Boot Concept Tree Proposal
Message-ID: <20260701134801.GG749385@bill-the-cat>
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
 <20260629222142.GA749385@bill-the-cat>
 <12db3d24-12aa-4655-9889-7b6917b14b12@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NW5poi9dU7iU/Bkg"
Content-Disposition: inline
In-Reply-To: <12db3d24-12aa-4655-9889-7b6917b14b12@amd.com>
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


--NW5poi9dU7iU/Bkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 10:33:03AM +0200, Michal Simek wrote:
>=20
>=20
> On 6/30/26 00:21, Tom Rini wrote:
> > On Fri, Jun 26, 2026 at 08:07:16PM +0200, Quentin Schulz wrote:
> >=20
> > [snip]
> > > I'll finish that my gut feeling (shared with some of my current and f=
ormer
> > > colleagues) is that U-Boot is disappointingly unstable. Unlike the Li=
nux
> > > kernel, U-Boot suffers from fewer eyes looking at code, fewer people
> > > developing it, fewer people testing master or even any recent release=
 (the
> > > number of reports we have for bugs on releases from years ago...), an=
d lack
> > > of proper and extensive CI test infrastructure (and if we have some, =
it's
> > > heavily centralized into a handful of people's offices). I loathe eve=
ry time
> > > I need to update U-Boot because I don't know what I'll have to debug =
for
> > > days or if I really do test everything there's to test (is it my faul=
t for
> > > not keeping up with master, yes, but I shouldn't feel this way).
> > > So I really think we could have much more confidence in code being me=
rged if
> > > we had more testing, possibly on real hardware, possibly by companies
> > > offering to do some proper CI (e.g. like Intel is doing with Yocto, s=
pending
> > > days testing release candidates before the project tags a release). M=
aybe
> > > with distros slowly adopting Aarch64 and U-Boot with it we'll have mo=
re
> > > coverage. I know you've worked on labgrid support for U-Boot and you =
have
> > > some merge request(s) still open there but it seems you're hitting th=
e same
> > > wall there you're hitting here.
> >=20
> > Thanks for the feedback here. I've been staying out of this general
> > thread as I believe my thoughts are well known already.
> >=20
> > For the specific topic here, part of it comes down I believe to a very
> > uneven level of testing. Both AMD/Xilinx and TI (and in turn, a number
> > of their vendors) have labs and run tests with a good deal of frequency.
> > I suspect NXP has some testing going on too, and this isn't an intended
> > as an exhaustive list. But others really are very much volunteer lead
> > and getting a reliable and remote lab setup really is a lot of work, so
> > no one has done it. Rockchip is an unfortunate example here that I know
> > you run in to. I have an rk3399 I've been trying to find time and space
> > to get up in the sage lab, for example, but it's still just not there.
>=20
> This is a topic which we should talk about more.
> It is clear that we can't expect that internal labs will join our project
> because it is very difficult to provide an access through infrastructure.
> Also you can't wait for companies to finish their testing before release.
>=20
> But on the other hand developers have enough HW on their desks which
> shouldn't be that difficult to share. That's why I think we should provide
> much easier
> way how to share these HW and wire it up with u-boot CI. That could also
> allow to connect custom qemu models instead of just upstream version.

I recently looked at how kernelci handles things currently, and since
it's a "push" service, not a "pull" service, I think there's some
lessons we can learn there, and build on. But that's its own whole
separate topic. One of many that has been delayed by the PLC having to
deal with a number of other issues related to the U-Boot name and
u-boot.org domain.

--=20
Tom

--NW5poi9dU7iU/Bkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakUajQAKCRAr4qD1Cr/k
Cr7gAP9y9a4aO7jgL0SVEG+kActVpKOe2kK4iOZmMi8FFFZpYQEAso7WBlvNYTdJ
S81AL6vBgU+0qFVzRxcYyfg8bTQ55gc=
=Iqol
-----END PGP SIGNATURE-----

--NW5poi9dU7iU/Bkg--
