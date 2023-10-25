Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9138C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3E987AD7;
	Wed, 25 Oct 2023 16:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X7ojB1yM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3194E87129; Wed, 25 Oct 2023 16:19:43 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B36287AD8
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-49e035bdca7so2116765e0c.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698243577; x=1698848377; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rSJiUsvVOM3niewUpPWZnPtEeSh2EUBi038CW2xlVrE=;
 b=X7ojB1yMco9iM/R6DllOvH8uxOxRsK9PrdylEu4PDU+wOTPAF67LX2B7G5eM+6q6gC
 +IXkRCpSpfcQXBiueGk1UtcxILnhfF+WiEa5MUoSWo+ZnnN2MnQGZ54n9YV7KnaM5qF8
 x7SW5yLWwLH38aWd+yaJjBe7yzG7KE2nPeU1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698243577; x=1698848377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSJiUsvVOM3niewUpPWZnPtEeSh2EUBi038CW2xlVrE=;
 b=ryU8v1ybq/onqTZAnpz+l+wc/rl/IUb6Na/DDww36abMoZj5vAZdN5hlcdIhXBzsg9
 csnV88Jf/gz5zmX3x+dqgluaW3qghTcMH1O/eDsVxk6NVWg3YIcssZRTqOwiSZEL2btm
 xO950ORfcIzfit2v+s/j/zlg/kUICDYS70iUhzQ1x6Nvd+SALC5/Qh+Y3okXc/hHgzqF
 MYGaMd7q95qUfvWT/clH8ptW3VgFQ8eCA4LI/pu+HF94nKDu5MjzQ/bLKCsPGHFRH+bT
 XoPl64Sp9Wce/61nDFaoQ32D09mJavwme2CMGazXSGatLlCqfsA9dEonlTFaIAOKXydO
 3xDA==
X-Gm-Message-State: AOJu0YwjPGzgm4bUZEh2bu7vY0ZUNa2ozIikke8SclJ/gl3GcYgeqoXK
 dWXcnlCWJKZchnVk+TbmRZkfSw==
X-Google-Smtp-Source: AGHT+IFsMUKN63N1/C+ZSL5jOConJI3l0Ad3y3X4rffUqv7EoE8a8EkAvO+kCT2N7ku4jPQVl6Wftw==
X-Received: by 2002:a1f:9d4e:0:b0:49a:b737:4dfa with SMTP id
 g75-20020a1f9d4e000000b0049ab7374dfamr12672561vke.4.1698243577157; 
 Wed, 25 Oct 2023 07:19:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 j9-20020ac84409000000b0041811e71890sm4246260qtn.33.2023.10.25.07.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 07:19:36 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:19:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Message-ID: <20231025141934.GO496310@bill-the-cat>
References: <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
 <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
 <20230925141906.GW305624@bill-the-cat>
 <914d3ebf-12d8-4651-a598-ca8edf6d5171@amd.com>
 <20230925143325.GZ305624@bill-the-cat>
 <c1fb916e-7269-485e-a77a-ce28a079c7fe@amd.com>
 <20231024180337.GB496310@bill-the-cat>
 <cefd9ab1-9ce0-46da-a969-9fb09e55d4fa@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xjmU2ua4DICA6oeK"
Content-Disposition: inline
In-Reply-To: <cefd9ab1-9ce0-46da-a969-9fb09e55d4fa@amd.com>
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


--xjmU2ua4DICA6oeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 09:33:03AM +0200, Michal Simek wrote:
>=20
>=20
> On 10/24/23 20:03, Tom Rini wrote:
> > On Tue, Oct 24, 2023 at 02:33:26PM +0200, Michal Simek wrote:
> > > Hi Tom,
> > >=20
> > > On 9/25/23 16:33, Tom Rini wrote:
> > > > On Mon, Sep 25, 2023 at 04:21:17PM +0200, Michal Simek wrote:
> > > > >=20
> > > > >=20
> > > > > On 9/25/23 16:19, Tom Rini wrote:
> > > > > > On Mon, Sep 25, 2023 at 04:10:38PM +0200, Michal Simek wrote:
> > > > > > > Hi Simon,
> > > > > > >=20
> > > > > > > On 9/25/23 16:01, Simon Glass wrote:
> > > > > > > > Hi Michal,
> > > > > > > >=20
> > > > > > > > On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@a=
md.com> wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > On 9/25/23 15:10, Simon Glass wrote:
> > > > > > > > > > Hi Michal,
> > > > > > > > > >=20
> > > > > > > > > > On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.sim=
ek@amd.com> wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > Hi Simon,
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > On 9/23/23 20:13, Simon Glass wrote:
> > > > > > > > > > > > Current alignment which is using 16 bytes is not co=
rrect in connection to
> > > > > > > > > > > > trace_clocks description and it's length.
> > > > > > > > > > > > That's why use start_addr variable and record prope=
r size based on used
> > > > > > > > > > > > entries.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Fixes: be16fc81b2ed ("trace: Update proftool to use=
 new binary format").
> > > > > > > > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > > > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >=20
> > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > - s/start_addr/start_ofs/g'
> > > > > > > > > > > >=20
> > > > > > > > > > > >        tools/proftool.c | 31 ++++++++++++++++++++++=
+++++++--
> > > > > > > > > > > >        1 file changed, 29 insertions(+), 2 deletion=
s(-)
> > > > > > > > > > > >=20
> > > > > > > > > > > > Applied to u-boot-dm, thanks!
> > > > > > > > > > >=20
> > > > > > > > > > > FYI: I have merged it to my tree and already sent pul=
l request to Tom.
> > > > > > > > > > > Without it I couldn't pass CI loop to get all reviewe=
d features in.
> > > > > > > > > > >=20
> > > > > > > > > > > https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-7=
26f7d40c4f5@amd.com/
> > > > > > > > > >=20
> > > > > > > > > > Ah OK, well that's fine. It was in my patchwork queue s=
till, which
> > > > > > > > > > suggests that the patches were not set to 'applied'?
> > > > > > > > >=20
> > > > > > > > > I am not using patchwork. But I expect my reply to cover =
letter was recorded there.
> > > > > > > >=20
> > > > > > > > Probably. If you reply to each patch, it shows up in the pa=
tch, but
> > > > > > > > the cover letter is hidden somewhere else.
> > > > > > >=20
> > > > > > > I have never started to like patchwork. I installed that clie=
nt long time
> > > > > > > ago, I also have account for quite a long time.
> > > > > > >=20
> > > > > > > > If you are not using patchwork, how come you are a custodia=
n? Is
> > > > > > > > someone else dealing with patchwork for you?
> > > > > > >=20
> > > > > > > Not really. I am just keep track on it via emails.
> > > > > > >=20
> > > > > > > DT folks did wire CI loop on every patch which they get. I am=
 not aware
> > > > > > > about any feature like this which would bring me something. T=
hat's why I am
> > > > > > > considering patchwork as unneeded layer. And I also don't thi=
nk that I have
> > > > > > > read anywhere that all custodians should be using patchwork.
> > > > > >=20
> > > > > > Right, patchwork isn't required, but can be helpful.  Part of h=
ow
> > > > > > patchwork is maintained for everyone (in U-Boot) is that I have=
 a script
> > > > > > that will update the status of patches to accepted and add the =
githash,
> > > > > > based on the "patchwork hash" of a given commit.  There's a num=
ber of
> > > > > > automated tooling things that other projects use which could be=
 helpful
> > > > > > here, but due to lack of time/resources, we haven't tried them =
here.
> > > > >=20
> > > > > Can you share that script? I am happy to run it and pretty much c=
lose my list.
> > > > > I am using b4 for applying patches that's why all message-ids are=
 listed in
> > > > > the history which will uniquely identify that patches.
> > > >=20
> > > > If you like, yes, you can run the following.  Note that when I run =
it
> > > > myself between tags, it will still re-update things.  This requires
> > > > having patchwork cloned from git as well and is a slight modificati=
on of
> > > > both tools/patchwork-update-commits and tools/post-receive.hook:
> > > >=20
> > > > #!/bin/bash
> > > >=20
> > > > # Patchwork - automated patch tracking system
> > > > # Copyright (C) 2010 martin f. krafft <madduck@madduck.net>
> > > > #
> > > > # SPDX-License-Identifier: GPL-2.0-or-later
> > > >=20
> > > > # Git post-receive hook to update Patchwork patches after Git pushes
> > > > set -u
> > > >=20
> > > > PW_DIR=3D/home/trini/work/u-boot/patchwork/patchwork
> > > >=20
> > > > #TODO: the state map should really live in the repo's git-config
> > > > STATE_MAP=3D".git/refs/heads/master:Accepted"
> > > >=20
> > > > # ignore all commits already present in these refs
> > > > # e.g.,
> > > > #   EXCLUDE=3D"refs/heads/upstream refs/heads/other-project"
> > > > EXCLUDE=3D""
> > > >=20
> > > > do_exit=3D0
> > > > trap "do_exit=3D1" INT
> > > >=20
> > > > get_patchwork_hash() {
> > > >       local hash
> > > >       hash=3D$(git diff "$1~..$1" | python3 $PW_DIR/hasher.py)
> > > >       echo "$hash"
> > > >       test -n "$hash"
> > > > }
> > > >=20
> > > > get_patchwork_hash_harder() {
> > > >       local hash
> > > >       hash=3D$(git diff "$1~..$1" | sed -e 's/^ $//g' | python3 $PW=
_DIR/hasher.py)
> > > >       echo "$hash"
> > > >       test -n "$hash"
> > > > }
> > > >=20
> > > > get_patch_id() {
> > > >       local id
> > > >       id=3D$(curl -s "http://patchwork.ozlabs.org/api/patches/?proj=
ect=3Duboot&hash=3D$1" | \
> > > >            jq '.[-1] | .id')
> > > >       echo "$id"
> > > > }
> > > >=20
> > > > set_patch_state() {
> > > >       pwclient update -s "$2" -c "$3" "$1" 2>&1
> > > > }
> > > >=20
> > > > update_patches() {
> > > >       local cnt; cnt=3D0
> > > >       for rev in $(git rev-parse --not ${EXCLUDE} |
> > > >                    git rev-list --stdin --no-merges --reverse "${1}=
".."${2}"); do
> > > >           if [ "$do_exit" =3D 1 ]; then
> > > >               echo "I: exiting..." >&2
> > > >               break
> > > >           fi
> > > >           hash=3D$(get_patchwork_hash "$rev")
> > > >           if [ -z "$hash" ]; then
> > > >               echo "E: failed to hash rev $rev." >&2
> > > >               continue
> > > >           fi
> > > >           id=3D$(get_patch_id "$hash")
> > > >           if [ "$id" =3D "null" ]; then
> > > >               hash=3D$(get_patchwork_hash_harder "$rev")
> > > > 	    id=3D$(get_patch_id "$hash")
> > > > 	fi
> > > > 	if [ "$id" =3D "null" ]; then
> > > >               echo "E: failed to find patch for rev $rev." >&2
> > > >               continue
> > > >           fi
> > > >           reason=3D"$(set_patch_state "$id" "$3" "$rev")"
> > > >           if [ -n "$reason" ]; then
> > > >               echo "E: failed to update patch #$id${reason:+: $reas=
on}." >&2
> > > >               continue
> > > >           fi
> > > >           echo "I: patch #$id updated using rev $rev." >&2
> > > >           cnt=3D$((cnt + 1))
> > > >       done
> > > >=20
> > > >       echo "I: $cnt patch(es) updated to state $3." >&2
> > > > }
> > > >=20
> > > > oldrev=3D$1
> > > > newrev=3D$2
> > > > refname=3D".git/refs/heads/master"
> > > > found=3D0
> > > > for i in $STATE_MAP; do
> > > >       key=3D"${i%:*}"
> > > >       if [ "$key" =3D "$refname" ]; then
> > > >           update_patches "$oldrev" "$newrev" ${i#*:}
> > > >           found=3D1
> > > >           break
> > > >       fi
> > > > done
> > > > if [ $found -eq 0 ]; then
> > > >       echo "E: STATE_MAP has no mapping for branch $refname" >&2
> > > > fi
> > > >=20
> > >=20
> > > Sorry for delay on this. I played with your script and also look at g=
it-pw
> > > client and cleaned my queue.
> > > Pretty much incorrect series, rfcs, etc should be only patches listed.
> > >=20
> > > If you are running it between tags there is no need for me to run it.
> >=20
> > I do this after each tag so yes, you don't have to run it as well if
> > it's not helpful to you (it may be helpful to custodians that do use
> > patchwork, perhaps with the upstream commit they're basing their PR on
> > and then their own tag for me, to then clean up their queue?).
>=20
> Actually I have updated that git filter above just to list sha1 from git =
for
> me as committer and that could serve purpose for custodians for cleaning =
up
> the queue.
> Would be maybe worth to commit this script to u-boot repository that other
> custodians can start to use it.

It's just some small tweaks to the upstream git hook.  I should write=20
doc/develop/patchwork.rst and mention that hook, and some work flows, as
the most generic answer here.  And I'm also not super proud of that set
of hacks to an upstream script :)

--=20
Tom

--xjmU2ua4DICA6oeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5I+0ACgkQFHw5/5Y0
tyzS5gv/frr37l12MKnXPzNqctXMmo3gWWLhwBwsSSwAYjddYx+aPrG0BEPDNppu
UrCQstuFzU1mtfquftV/47grGK+YLHgjdoxnXUX11OroceQNIwt9oEXqoStEcExs
1F95cKN3TVJkW3HO0MRpUx6qKDG7IIcWWGwxx95BbjXGgIjihYM089bwVvIJMWx1
QYglLQ/TBIl4dnwyHyq84jJNW5www3X5X1xohje6uMDZ9AaOcY33koIJLZDSEEYO
3e0QnAcbKyCyfDhUDT7PkBQ5Of3u94CKx+qLXOX8ZvwENmr6/50uXlciHPsf3EaT
DeLGYuLN1wvOzhf638mj6qNLKzggKK2mog99Ia9N9D8HRIrlHykjz7/6DOnDxxTO
0FBt13CSvu5+La25gDHXLYtj4uMrmL0O0uRfVQ3S9bRxDjgxpT6Y/wfkOhmI1jyr
VFnxiqGpuRTLqJF4ewtIyLdoZWtIc8q9q6UwhBS2ezbOrPvy4/90ecSZs2ISxyw1
VEqm/d0k
=VCnk
-----END PGP SIGNATURE-----

--xjmU2ua4DICA6oeK--
