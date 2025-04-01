Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C930C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 18:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703A280FDA;
	Tue,  1 Apr 2025 20:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K51J8Zvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD22381703; Tue,  1 Apr 2025 20:02:25 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1983B806D8
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 20:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3fec2899574so3583802b6e.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743530541; x=1744135341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=npj1PcM/YyHcAzYhfQoyePJ6mP1dtIS0Ih2pTjZhffk=;
 b=K51J8ZvyAxLQKWF/Z7KTkpbeiqlZOztcaR795OndebZOvF/tsjncBcg3GS921Ny1Cq
 DkosOMssltVYAnUcG/62XrUyKOsDOqG+jPFlJTcOhlFbaIPPAdPu3285ErsF+I/m8AA7
 vxlJ9GMLSOVRzBDfWO+b6sTiEr6EpOtj03PuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743530541; x=1744135341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npj1PcM/YyHcAzYhfQoyePJ6mP1dtIS0Ih2pTjZhffk=;
 b=MPkcZjB9nwOort6QbXYP5+klHmPiYmVQdWLKi1fQLED8jVEQggJVNBhkjNO3ROUYJa
 xEQqqCkXLNDT8pTZ6tGBMlRIdRoPj1ZpbHfWnXyeo23zf/0dRL4du5422ZVkD1nBPvsG
 bvfeDDiJHKUZrAl2YjRKE2wkjteGGXO1EQ5qpIV288jwlLJqE8ImdzN3Va9zJAa1Zxks
 GIX0kApxn0PEHpwD4ZzA8TZhivWp3LDUFeOqvB5/nnP4qQNjaanPqTzhn0yNVViH56gv
 6hFogd0X6zCCPVmgJ0CHumxsR7SIhimZ/olCqot44Ymstvt1GBuJ/BcX3DL24edOZNcU
 K5rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE0seX3Tb1THvgL80Rn3tuP07waXb7Val+D8LhjIzgKdHqeoPfHDIIS65Ly7eHnvPgLO8bfSY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt9q8bDUzrig6bZTqj27mk7D2u8XkulKB6Lvdjlni4WU8GQtEb
 s1oMbgGsX4ZgLWbXGJCb/L2L0yx7HGnyrGVzz1nbmkdlwzAWd5a6jPwbd5TAMyk=
X-Gm-Gg: ASbGncsVoFZvzV8sULFh8AkMRvKLayGOxU+SeHSEu8N7avC9EbR3xr+z7ggm8anWtBE
 7iGjy2abQYumAehXo3NElvlWubBJLVTF+YMVyez9HOEz92IoUXjSWcmJW3pUg0arnYGjsUhXo5q
 Gnw+dOkb33vD4pMiR/X5p64W2C0+wP6hGSOgCqGBohXAEIjVqrwFdzNCtDPerIc7yI3bHKbqfSm
 BxA+phXdK737FWHnrUaVa0cF9U3oBSRYxZR8Lk9UodNaLGsT0cE7P6wa9E9BKCFlTGteHaVTjpi
 Kx9RF3IKHdElzRsZiJbeIpx9WD2OWMDvpi0nAOHJCrvyKnqvIxNpvSTXmNS7FDoXMsNmSynmLYC
 jzrLgpA==
X-Google-Smtp-Source: AGHT+IEbpt4pNajlbTl40grr70rH7oUIcmTJPsCshDB1OC6yEVHb6j7HO7JbMSbiZ/U44epiKheRbg==
X-Received: by 2002:a05:6808:f8c:b0:3f9:eeca:5dcb with SMTP id
 5614622812f47-3ff0f66a21dmr8464075b6e.37.1743530540583; 
 Tue, 01 Apr 2025 11:02:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05181ecesm2011641b6e.15.2025.04.01.11.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 11:02:19 -0700 (PDT)
Date: Tue, 1 Apr 2025 12:02:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
Message-ID: <20250401180217.GO5495@bill-the-cat>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
 <67e5659b.df0a0220.19a25c.f830@mx.google.com>
 <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
 <20250401144420.GE5495@bill-the-cat>
 <7b6542f2-0a2b-48ce-aaac-0bdf2f9b2fca@linaro.org>
 <20250401164016.GF5495@bill-the-cat>
 <62fd6270-e6df-472d-b3ee-0023bfce8d27@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uQx/UlPw+yinUYuV"
Content-Disposition: inline
In-Reply-To: <62fd6270-e6df-472d-b3ee-0023bfce8d27@linaro.org>
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


--uQx/UlPw+yinUYuV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 07:28:36PM +0200, Krzysztof Kozlowski wrote:
> On 01/04/2025 18:40, Tom Rini wrote:
> > On Tue, Apr 01, 2025 at 05:27:30PM +0200, Krzysztof Kozlowski wrote:
> >> On 01/04/2025 16:44, Tom Rini wrote:
> >>> On Thu, Mar 27, 2025 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 27/03/2025 15:50, Christian Marangi wrote:
> >>>>> On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski wrote:
> >>>>>> On 14/03/2025 19:59, Christian Marangi wrote:
> >>>>>>> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This =
is not a binding and
> >>>>>>> should not be placed here. Value is derived internally in the user
> >>>>>>> driver.
> >>>>>>>
> >>>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>>> Please drop my Ack. I have never acked such patch for uboot. If I =
did,
> >>>>>> it was by mistake - probably you CC-ed me for some reason.
> >>>>>>
> >>>>>
> >>>>> Some explaination, uboot introduced the concept of upstream where t=
hey
> >>>>> "import" linux patch for dts and dt-bindings.
> >>>>
> >>>> I expected OF_UPSTREAM to be taking the sources, not patches.
> >>>>
> >>>>>
> >>>>> This and the other patch are the exact upstream patch with only the=
 path
> >>>>> changed so I keep all the patch commit message with tags and added =
the
> >>>>>
> >>>>> [ upstream commit ] thing.
> >>>>>
> >>>>> Hope Tom can better suggest how this should be done. You were CC
> >>>>> probably because the git send-email included you as present in the
> >>>>> different tags.
> >>>>
> >>>> Well, Ack is still not valid because I did not Ack exactly that chan=
ge.
> >>>> It does not matter for the ack, but for Reviewed-by it would matter,
> >>>> because it is a statement (of oversight...). I cannot control what y=
ou
> >>>> put into patches taken out of kernel, but at least do not Cc me on t=
hat.
> >>>
> >>> In specifics, yes, we should update doc/develop/devicetree/control.rst
> >>> and maybe doc/develop/sending_patches.rst to use --suppress-cc=3Dall =
for
> >>> dts/upstream.
> >>>
> >>> But in general, what do you expect people to be doing with content fr=
om
> >>> devicetree-rebasing? We're doing some direct cherry-picks in between
> >>> merging of the tags. I think it would be weird to be dropping the tags
> >>> and un-attributing peoples work.
> >>
> >>
> >> I rather expected something like how kernel is importing dtc. You just
> >> list the commits you get. If you want the full git history, then I wou=
ld
> >> expect simple git submodule. In both cases there will be no such patch=
es
> >> on the lists.
> >>
> >> For the Ack it does not matter, but I would feel uncomfortable if peop=
le
> >> were sending stripped and modified patches with my Rb tag.
> >=20
> > I guess I'm confused. Looking at
> > https://patchwork.ozlabs.org/project/uboot/patch/20250314185941.27834-6=
-ansuelsmth@gmail.com/
> > we're doing the normal thing of havig "[ upstream commit <sha>]" after
> > the imported log. When I merge the subtree and tag it indeed gives what
> > you're expecting too.
>=20
> When you merge subtree, the patch is not modified and it lives in
> separate repo. No one sends them over lists, no one modifies them.
> Unlike here (even if modification did not happen, person was touching it
> so how can anyone be sure? That's not a scripted process).

We merge the subtree on tags, and people cherry-pick commits in between
tags when needed. This is a case of the latter, which is why it says "[
upstream commit <sha> ]" in the commit message, which is the usual case.

--=20
Tom

--uQx/UlPw+yinUYuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsKiQACgkQFHw5/5Y0
tyxrKQv+NEleuc+H8Un6OJQLI16sndCk6sK/F6T85aEwh50dE3UMSfc2f3A/cHqx
mdRhJNtjbW+UKbul02PzUl6vEA+wo6ic2EW1ATDMvs3XnDyxfQdnOcskn89qVvkW
Avu69l7pDVf0TS2STriFDWHYp0YvbJYIR+46vsOR0DbY2JtLz65vxfIL2/YLnYFD
8xjzYmZlkLe/IYkfNyRGIBGoNw3zcCqleV1PjaamvTcRg3CSZDf+y3UxkXazliUD
3GLt5SQRHSEUWoCRJsk1Ia8q9JghcmwzYYBpuKkWPkqpG70slm5VDNiKHfogYqqP
uNQEjpwX7/gk1ueUyvWQFwIjEK8D/NtUyos67k/Wag1NIuFzHejE6Tmv7hgpxAPO
BhKSN7WRRAEY93R39kzJpPFjt8HChestyu+wB/S1CONPHWmO5wp2JPptyKlNXSNa
Ycts+lwrCJ2Tz0h/gh6MPqZL5U0sq+z5/O9ZecMttxZjI+YgVqvwMyCerEP2Zh/N
oWBdd5Dy
=3Qo5
-----END PGP SIGNATURE-----

--uQx/UlPw+yinUYuV--
