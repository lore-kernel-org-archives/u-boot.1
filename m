Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7379C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 18:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95ACD879BE;
	Thu,  4 Jan 2024 19:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hz+ICJ9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE7F879D2; Thu,  4 Jan 2024 19:03:44 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D6B87811
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 19:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f95d69115so3596436d6.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704391420; x=1704996220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5JEQXFkKg4UpHs/fSuFy9M4EjL4woVB9WBrXaNkIkjQ=;
 b=hz+ICJ9PpinOQQzdRrafcj1q8QpqsHdx5LCOHoWAk9DSfTVAeYWrckn7kpZ4u7TcBk
 KH6UGA66nYbxpL5f1G+3MHiVx5JTuLSWhSnjHR0tWWl4Nw8uHUl40ShGa9EQgRrCkj4A
 tjrC8nfF9vWODlXPih1pKY6rGEWpI/sMT+U+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704391420; x=1704996220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JEQXFkKg4UpHs/fSuFy9M4EjL4woVB9WBrXaNkIkjQ=;
 b=OE92O4SZ7ZW17YeRLakUwO/qvYGEm3Q9fyQqxk9KoT+JwdGo7d0UYZlVeMFJFz4Tva
 o+Dt0BBhDeYVk+uwOeo1OPiRTsGx8qEfnEDCXWM2effTjyut0KEeV4hdiZUX9CIbLPHh
 ZK9MoB+3mAiWG5a1D+AZLR6mt43H9wNWcYBUll+Q7I9M13Dj7wGb02xjsODH5oeb1Lqp
 LWdy0Ubp5blXIlD15WQf1x34PrL6STqStuDlO0HhL3RHwtDtih4qnVjePQSvmcGlGT+h
 7vJQhtWsLEcUw5iov0Wdrs+RNkp23SHKND5gLgRqmdRpPY5cLJ5hojmdM2liD9kWqGxX
 7/2A==
X-Gm-Message-State: AOJu0YwWEck090cFlmNyfrEozZ2GJ0ek4Ru+d4olhlSNjQ1CjkF3y3s4
 dDnCMT7FmXY4jCCtAYqGap/5ZPqBnKa2Bw==
X-Google-Smtp-Source: AGHT+IH3ubdcpPKbM61wfZyT4EsQq+Of5iqpTCgMeh/IwsPck2pXW21SybhEvjsJHDrrRd6tRPa4lg==
X-Received: by 2002:a05:6214:2305:b0:67f:4527:601c with SMTP id
 gc5-20020a056214230500b0067f4527601cmr966380qvb.99.1704391420220; 
 Thu, 04 Jan 2024 10:03:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 o10-20020ad443ca000000b0067fd4a002d8sm9786183qvs.19.2024.01.04.10.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 10:03:39 -0800 (PST)
Date: Thu, 4 Jan 2024 13:03:36 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Message-ID: <20240104180336.GU1610741@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat>
 <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
 <CAFA6WYP6p=eVtmnS=Qd8xv+nCSFvzREMnRHFkLzEzENnvTxv+A@mail.gmail.com>
 <20240104135008.GQ1610741@bill-the-cat>
 <cb0ee2fb-2753-421e-9623-3cd74e6bef03@amd.com>
 <20240104153029.GT1610741@bill-the-cat>
 <785175cd-a2b8-4d5c-8f2c-326125465ed6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6yhNV1dV1BmJMjqS"
Content-Disposition: inline
In-Reply-To: <785175cd-a2b8-4d5c-8f2c-326125465ed6@amd.com>
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


--6yhNV1dV1BmJMjqS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 04:50:14PM +0100, Michal Simek wrote:
>=20
>=20
> On 1/4/24 16:30, Tom Rini wrote:
> > On Thu, Jan 04, 2024 at 03:45:10PM +0100, Michal Simek wrote:
> > > Hi Tom,
> > >=20
> > > On 1/4/24 14:50, Tom Rini wrote:
> > > > On Thu, Jan 04, 2024 at 06:52:32PM +0530, Sumit Garg wrote:
> > > > > Hi Michal,
> > > > >=20
> > > > > On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> =
wrote:
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > On 1/3/24 17:32, Tom Rini wrote:
> > > > > > > On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> > > > > > > > On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.g=
arg@linaro.org> wrote:
> > > > > > > [snip]
> > > > > > > > > +In order to maintain devicetree files sync, U-Boot maint=
ains a Git subtree for
> > > > > > > > > +devicetee-rebasing repo as `devicetee-rebasing/` sub-dir=
ectory. It is regularly
> > > > > > > > > +kept updated with every new kernel major release via sub=
tree pull as follows::
> > > > > > > >=20
> > > > > > > > I would suggest dropping "-rebasing" in the u-boot tree. (I=
 wish we
> > > > > > > > had in the original repo). I don't think it's relevant.
> > > > > > > >=20
> > > > > > > > We're not likely to regenerate the tree, but any clue what =
'git
> > > > > > > > subtree pull' would do in this case? It could happen if we =
switched to
> > > > > > > > git-filter-repo.
> > > > > > > >=20
> > > > > > > > > +
> > > > > > > > > +    git subtree pull --prefix devicetree-rebasing \
> > > > > > > > > +        git://git.kernel.org/pub/scm/linux/kernel/git/de=
vicetree/devicetree-rebasing.git \
> > > > > > > > > +        <release-tag> --squash
> > > > > > > >=20
> > > > > > > > I'd put this in a script to run. Documentation tends to be =
not quite
> > > > > > > > correct. A script could also be smarter and figure out <rel=
ease-tag>.
> > > > > > >=20
> > > > > > > Since you had mentioned elsewhere moving the kernel scripts/d=
tc/ to
> > > > > > > something using subtree, I do hope to learn some lessons from=
 what you
> > > > > > > do there. The first thing is that given the size/nature of th=
e commits,
> > > > > > > I had figured I'd be the one doing this as a subtree pull+squ=
ash then
> > > > > > > push, rather than posting to the ML since it'll be huge and
> > > > > > > un-reviewable, but with a note sent off to the ML that people=
 should be
> > > > > > > aware the next sync has been done and retest as needed. But S=
umit, were
> > > > > > > you planning to do some of this instead?  The second thing is=
 that if we
> > > > > > > move the subtree part in to dts/ instead (where we will still=
 have the
> > > > > > > Makefile/Kconfig we have today and then our Makefiles within =
the
> > > > > > > directories, this might get more complex and so really requir=
e a script
> > > > > > > to keep it from getting error prone?
> > > > > >=20
> > > > > > I played with this series and didn't really have time to dig in=
to subtree
> > > > > > mechanics but one thing I see is that when squash and merge hap=
pens you can't do
> > > > > > simple rebase anymore which is time to time very useful.
> > > > > > I see some different rebase strategies and --rebase-merges opti=
on but if this is
> > > > > > adopted it should be properly described how to rebase u-boot tr=
ee which contains
> > > > > > some subtrees.
> > > > >=20
> > > > > Did you observe any specific difference with respect to subtree m=
erge
> > > > > commits (Tom will likely do those in the beginning of next release
> > > > > cycle) when compared with normal merge commits when Tom pulls in =
code
> > > > > from different custodians like one example below? The same rebasi=
ng
> > > > > rules should apply to both types of merge commits.
> > > > >=20
> > > > > commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
> > > > > Merge: 2b28c3b871c e266d273114
> > > > > Author: Tom Rini <trini@konsulko.com>
> > > > > Date:   Mon Jan 1 12:38:15 2024 -0500
> > > > >=20
> > > > >       Merge tag 'dm-next-1124' of
> > > > > https://source.denx.de/u-boot/custodians/u-boot-dm into next
> > > > >=20
> > > > >       support propagating supernode properties with bootph schema
> > > > >       align bloblist with v0.9 of Firmware Handoff spec
> > > >=20
> > > > There's two cases. The first and uncommon case is that if you want =
to do
> > > > something like:
> > > > - Branch next
> > > > - Add this subtree, do a few subtree updates on it (like my experim=
ent
> > > >     of starting with v6.1-dts and merging up to v6.6-dts)
> > > > - Wait a while, have changes happen in next
> > > > - Rebase on to current next
> > > >=20
> > > > It gets painful and odd, but I don't know that this will ever really
> > > > happen.
> > > >=20
> > > > The second, common case is:
> > > > - Assume "next" already has this subtree + some merge commits in it.
> > > > - Make a new local branch.
> > > > - Make change in your new local branch.
> > > > - This hypothetical "next" branch moves forward with changes
> > > > - Rebase your local branch on to this "next" branch
> > > >=20
> > > > In this case things work as expected. Even if  "next" in that case =
gets
> > > > a new subtree merge that you need to rebase in.
> > > >=20
> > > > A third case that I'm not sure if really will happen or is a case w=
here
> > > > the custodian should rework their tree instead (to drop the subtree
> > > > merge) is:
> > > > - Assume "next" already has this subtree + some merge commits in it.
> > > > - Make a new local branch.
> > > > - Make a subtree merge+squash in your local branch.
> > > > - This hypothetical "next" branch moves forward with changes
> > > > - Rebase your local branch on to this "next" branch.
> > > >=20
> > > > This will then make you try and resolve some conflicts from that su=
btree
> > > > merge.  But is this a valid use case? Yes, I can see wanting to get=
 a
> > > > start on testing a dts merge before it happens, but is this a tree =
which
> > > > needs to be rebased, or just re-created as needed, if the parent br=
anch
> > > > moves forward?
> > > >=20
> > > > Can you explain a bit more your case Michal since it sounded to me =
like
> > > > you had a problem that happened rather than a worry about what might
> > > > happen?
> > >=20
> > > I remember couple of bisects which I was doing and it works fine on t=
he tree
> > > till the point you have 2 issues to deal with. It means pretty much y=
ou have
> > > config change/fix which has to be applied to see second issue.
> > >=20
> > > The normal way what I have done was simply find major version apply t=
hat fix
> > > and then take the latest tree and rebase latest on the top of it. The=
re were
> > > normally not so many conflicts to resolved (or easy to resolve/ignore=
). Then
> > > because the first fix is present all the time bisect is able to help =
me to
> > > find second issue.
> > >=20
> > > If there is subtree update the whole rebase will horribly fail.
> > >=20
> > > I see that Rob and you in DTC case just simply do c&p and create regu=
lar
> > > commit with all changes inside. From my perspective this is more
> > > straightforward to deal with which will handle all cases and it is al=
so
> > > proven over that years.
> >=20
> > Ah, bisecting.  Maybe the (annoying) answer is to turn that merge commit
> > in to a regular commit in the bisect branch?  This is a good point, and
> > I need to go and construct a bigger example tree and check around at
> > what happens.
>=20
> Sure you can do whatever you like. But I expect that at the end if this
> started to be used you will have subtree for devicetree, dtc, lwip and ma=
ybe
> something else. It means you have to start to keep track where that subtr=
ee
> are and what version is used at what time.

Yes, lwip would be a subtree too, dtc is trickier but I see and agree
with your point.

> Because dt binding is extending often likely you will need to merge it ev=
ery
> Linux release. It means you would have to do it multiple times depends on
> how many releases you are going over.

Yes, the plan is to re-sync every time our next opens with the kernel
release at the time (which maybe needs to be clearer in the docs).

> I know that Qemu is using gitmodules that's definitely another option but
> not sure if better or worse.

Yeah, submodules is harder and we're not going that path.

> I can also imagine that companies with SR IR certified firmware would keep
> downstream version where they want to just take code fixes, DT fixes and
> devicetree-rebasing tree to make sure that they are still aligned with DT
> schema. Can you simply just cherry pick that merged commit without any si=
de
> effect?

Life downstream is always fun. Personally, I would re-run the "git
subtree" command rather than cherry-pick from U-Boot itself in that
case, but it should be no different than any other commit.

>=20
> Back to my point. At the end what we need to is to document it properly h=
ow
> to deal with it.

So, here's the test I did. I went back to v2023.10, then added v6.1-dts
as a subtree.  I rebased v2024.01-rc1 on top of that, added a fake bad
commit, synced up subtrees to v6.6, and then rebased the tags along the
way to v2024.01-rc6.  I then went for a bisect back to the fake bad
commit.  Everything went fine, git didn't have troubles rebasing things
as it went.

But to re-iterate, yes, the policy around when dts and bindings will be
resynced needs to be clear and documented. Does that cover it?

--=20
Tom

--6yhNV1dV1BmJMjqS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWW8vQACgkQFHw5/5Y0
tywaLwv/byDa738OWFliNIT87VSf2oDhp5fiTjHkv5YC2XnluaGFUH1md3AA/Od3
ZRYKvU2Oc5uDazrM01RPwSTzIPJjYoGn7iF+sZjWrR4bfWPqvtTPqGCoNOi7VANU
NMP0ovn4QqARRlRjrG5Y+N6uPYV34X6AqcCK4eAssFUWGEMdGAGYj6u1bB1AQivc
Etrn5ZeaPCCXCb4DUB11EjZmy4aCDHu0VyPvdoiNjE+WL+cHR+xZTiQXnBeWw35k
hYqkyWLNJfJ5YE9f75Kxn9cCIpJ4/tzHimffreD543nUrtTPXzbWsfdds9pzR7xc
ZgxqWv+MRPR2qgiwkWMsU/KB3D/gF4qmf2Zqp+SjinW81hu9bf3jahs2LEu9b0Id
kjHecGS9u89fyaE2wc2eWlgfvyM3ciHvttxLfCeIMlmAx5CwKonpv7CwWWUx0CEX
crDFqcvGD47qbqA8KWOLTwwDvpxcxdOctssb9ozuzVcQIRsCLPuM9IIMKZo8eQnw
cS3U6e/F
=zCCD
-----END PGP SIGNATURE-----

--6yhNV1dV1BmJMjqS--
