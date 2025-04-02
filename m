Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69946C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D18181F69;
	Wed,  2 Apr 2025 16:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QCWHDjQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A76A81F6B; Wed,  2 Apr 2025 16:16:38 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8971480FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-601a46ee19fso3471383eaf.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743603391; x=1744208191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OjRkGd2E/HmsNrSBfBUzPnYd/IxILLsd5KrInMoZJ5U=;
 b=QCWHDjQn+HGPKhbDptphIOUpmw9ZNs4dM+9eAf7JqHW36FIzRJPWhZPxIjofWD6eIf
 K5xsFLA7wGCYZGgm8gDCCTwX/BOvQIHI1cxAd2vp42JJ9XeJU4b5kO6ZRrT8StAH3Lt0
 87fW46B/pL0AS2wff0f4iMjedRZFvrbbqii3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743603391; x=1744208191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjRkGd2E/HmsNrSBfBUzPnYd/IxILLsd5KrInMoZJ5U=;
 b=k8zOJ7xgzYG+D9YWTd019XTsqOyAcnOtGJykMhcrr/ZDMA9ybdtzu+0ochVetz0SRg
 k0gPlU8kMR12EzhnPNNZ7vdPzQUPLlzC9qLpPqoO8Why9KrIbtEl4d3lU+bj8Ill/RCR
 IZML0W+LmYU1f/6E0KNu9bAZnQ3S5zo7XcEzjqfxMlvE+weF9V66EUqk+My3Z/bEyKGd
 MA4hW+65P01kwF4SZ/o7fDACmnJfHGxKiU7qE1Hmz73Ia4xjDpg534hR+dW/dt18TppL
 /RHV60QU8EfnGaH4Vg047YvGRK9eNh6AIJEyhdGwllXCtbyDB3EPWXceFAsJ5NV1L5Bo
 ALdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcUy8Vw5h+THhL70tj3zHRNVGwd2gB0igr1H4SjY9h/IvTrmBQO5SBmDrVDbUqk3zs4ReKzw8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5ttpvZLh8LsXPcMedw0rg2o5ULfQqOvzWJKDek8bU67uvLV5y
 A12yxhm6amxmns9h2Oas/4qSBnfuo91MelbEdHO4FswrcykYjldHHaKPDpYCOK4=
X-Gm-Gg: ASbGncuWPY17SMbWd17c65rdqCvD04A1gxRA4KMPKo+88ye+iYFphPDczNqEZLefsim
 UsNCsEN7HH5h+Yy3SdWojDuC4WNBPg7AmvWl+0fr98gaPTIqRhzupLCp0oww7RRB3Is5n0nHkrn
 e8qHia/P1qId8gt6rgVSBATIYG1ASe1rBucPlbZKpPnokSCsRv1G8R/RICfmwnXO/5KD+3RxhOE
 6aAlBHWndOWDI8ibaXadLD8bUOUsvYHWJr7NTPYPnLqGf4jGNBJqJ69rPukavnNTbAARdyAensS
 m0U3eopx/Dz3ftYV2JP+qby8XHLB9Ynhapz9RvMCUDWqPHhdFySnC2uuKnqLsbxuuI21nW9ZZpc
 S5FREPQ==
X-Google-Smtp-Source: AGHT+IFguOw0CgtUpyBJA/tI36ongpdEVdsFbRb/RLaaIPv/Fi7AgXUiaTymg/WP8iawktSCuG0a6g==
X-Received: by 2002:a05:6820:99c:b0:603:f7d2:dd7c with SMTP id
 006d021491bc7-603f7d2de02mr3271851eaf.4.1743603391198; 
 Wed, 02 Apr 2025 07:16:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602845f9d35sm2224818eaf.31.2025.04.02.07.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:16:30 -0700 (PDT)
Date: Wed, 2 Apr 2025 08:16:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
Message-ID: <20250402141627.GR5495@bill-the-cat>
References: <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
 <67e5659b.df0a0220.19a25c.f830@mx.google.com>
 <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
 <20250401144420.GE5495@bill-the-cat>
 <7b6542f2-0a2b-48ce-aaac-0bdf2f9b2fca@linaro.org>
 <20250401164016.GF5495@bill-the-cat>
 <62fd6270-e6df-472d-b3ee-0023bfce8d27@linaro.org>
 <20250401180217.GO5495@bill-the-cat> <Z-zjdhegA-W23qc9@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B8MFP8UtEx9yL+io"
Content-Disposition: inline
In-Reply-To: <Z-zjdhegA-W23qc9@sumit-X1>
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


--B8MFP8UtEx9yL+io
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 12:42:54PM +0530, Sumit Garg wrote:
> Sorry for jumping in late in this thread as it is still using my old
> Linaro email ID which should be disabled by now.
>=20
> On Tue, Apr 01, 2025 at 12:02:17PM -0600, Tom Rini wrote:
> > On Tue, Apr 01, 2025 at 07:28:36PM +0200, Krzysztof Kozlowski wrote:
> > > On 01/04/2025 18:40, Tom Rini wrote:
> > > > On Tue, Apr 01, 2025 at 05:27:30PM +0200, Krzysztof Kozlowski wrote:
> > > >> On 01/04/2025 16:44, Tom Rini wrote:
> > > >>> On Thu, Mar 27, 2025 at 03:58:52PM +0100, Krzysztof Kozlowski wro=
te:
> > > >>>> On 27/03/2025 15:50, Christian Marangi wrote:
> > > >>>>> On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski w=
rote:
> > > >>>>>> On 14/03/2025 19:59, Christian Marangi wrote:
> > > >>>>>>> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. T=
his is not a binding and
> > > >>>>>>> should not be placed here. Value is derived internally in the=
 user
> > > >>>>>>> driver.
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > >>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > >>>>>> Please drop my Ack. I have never acked such patch for uboot. I=
f I did,
> > > >>>>>> it was by mistake - probably you CC-ed me for some reason.
> > > >>>>>>
> > > >>>>>
> > > >>>>> Some explaination, uboot introduced the concept of upstream whe=
re they
> > > >>>>> "import" linux patch for dts and dt-bindings.
> > > >>>>
> > > >>>> I expected OF_UPSTREAM to be taking the sources, not patches.
> > > >>>>
> > > >>>>>
> > > >>>>> This and the other patch are the exact upstream patch with only=
 the path
> > > >>>>> changed so I keep all the patch commit message with tags and ad=
ded the
> > > >>>>>
> > > >>>>> [ upstream commit ] thing.
> > > >>>>>
> > > >>>>> Hope Tom can better suggest how this should be done. You were CC
> > > >>>>> probably because the git send-email included you as present in =
the
> > > >>>>> different tags.
> > > >>>>
> > > >>>> Well, Ack is still not valid because I did not Ack exactly that =
change.
> > > >>>> It does not matter for the ack, but for Reviewed-by it would mat=
ter,
> > > >>>> because it is a statement (of oversight...). I cannot control wh=
at you
> > > >>>> put into patches taken out of kernel, but at least do not Cc me =
on that.
> > > >>>
> > > >>> In specifics, yes, we should update doc/develop/devicetree/contro=
l.rst
> > > >>> and maybe doc/develop/sending_patches.rst to use --suppress-cc=3D=
all for
> > > >>> dts/upstream.
> > > >>>
> > > >>> But in general, what do you expect people to be doing with conten=
t from
> > > >>> devicetree-rebasing? We're doing some direct cherry-picks in betw=
een
> > > >>> merging of the tags. I think it would be weird to be dropping the=
 tags
> > > >>> and un-attributing peoples work.
> > > >>
> > > >>
> > > >> I rather expected something like how kernel is importing dtc. You =
just
> > > >> list the commits you get. If you want the full git history, then I=
 would
> > > >> expect simple git submodule. In both cases there will be no such p=
atches
> > > >> on the lists.
> > > >>
> > > >> For the Ack it does not matter, but I would feel uncomfortable if =
people
> > > >> were sending stripped and modified patches with my Rb tag.
> > > >=20
> > > > I guess I'm confused. Looking at
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20250314185941.278=
34-6-ansuelsmth@gmail.com/
> > > > we're doing the normal thing of havig "[ upstream commit <sha>]" af=
ter
> > > > the imported log. When I merge the subtree and tag it indeed gives =
what
> > > > you're expecting too.
> > >=20
> > > When you merge subtree, the patch is not modified and it lives in
> > > separate repo. No one sends them over lists, no one modifies them.
> > > Unlike here (even if modification did not happen, person was touching=
 it
> > > so how can anyone be sure? That's not a scripted process).
> >=20
> > We merge the subtree on tags, and people cherry-pick commits in between
> > tags when needed. This is a case of the latter, which is why it says "[
> > upstream commit <sha> ]" in the commit message, which is the usual case.
>=20
> Although we have tooling to pick patches from devicetree-rebasing tree
> but I can see Krzysztof's concerns here. We can't be sure if developer
> has touched the cherry picked patch or not but I suppose there would be
> similar concerns for the stable backports for Linux too. So IMHO, it's
> really upto maintainer applying those cherry-picked patches to see if
> there is any difference from upstream.
>=20
> However, there is an additional process change what we can do here is
> for the developer to list just the commit IDs for the patches to be
> cherry picked in dts/upstream in the cover letter. This way the
> maintainer can just directly use the tooling to cherry pick those
> patches before applying the patch-set.
>=20
> Tooling already available for cherry-picking subtree commits as:
>=20
> $ ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>

For U-Boot at least, at the end of the day the cherry-picks are a
temporary measure. We do pick up and merge each release tag in turn (and
so yeah, I should grab the newest one already) and if the merge doesn't
Just Work, I drop in the correct file from upstream to resolve the merge
conflict.

--=20
Tom

--B8MFP8UtEx9yL+io
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftRrQACgkQFHw5/5Y0
tyymhgv8CJZ8rdXljFiQkjqC+awan6mQUb41FH8FzNiSXES7pRtBmy4ambQYK6HA
WfMLzxzBSWtVvsKmfUXu3NvQm/3s/NDkcOIygn3ek/dVV3Yn/5WAK9btex/PS6j4
U0tEhtsI2oQpv8fDKjLc+dz0r0Qhzaia9+XZXwnaRQJ8T9R4BCfMX57ezWHRRNDt
/6WxCl0jSayk8eBtBf0SFtnQz0IsSYaM4nimVCql8XNigcGJa6wiA8d3kgzcnyvN
mS1zKTLIdmaMQe9yrW3AmQ0wImHr5bC+T3d/m8pdDdlIC4GTyOu8w9vH75H5rHTw
DGcSy7SNPUIVYmkkSvNDCGWW5foj8QZ3tXs2u7jHgTOocDvZyV4xwE5eK0LDGKEc
asVorU8NodSmybVecJRhTM42K/zaEELvcGM3yfzMfY3oag4sRm3O5O6J3wJdhKBE
dM1OkfBrrh6CWXv4Wp/fsGFFDzyvlTCszW1TQZo3+69s/hGxj96hXMwcuFu00yZc
zcNMLoiv
=AXHr
-----END PGP SIGNATURE-----

--B8MFP8UtEx9yL+io--
