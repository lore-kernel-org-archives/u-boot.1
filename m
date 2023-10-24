Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736D5C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CF187996;
	Tue, 24 Oct 2023 20:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d9pM1SAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB338798F; Tue, 24 Oct 2023 20:03:47 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58BE987983
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7c011e113so51546727b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698170620; x=1698775420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IEZ9N0RUAkePSn+ygqhxkFxAy8NAFB27gZcsaZRRbp0=;
 b=d9pM1SAwdYIrZ3UOK0g/sGFJDvsuBN5lyZXvv+pqKFr1/pn8qE3uKEG1+48OiAS6B1
 a0ExURcVqd+g3zp7891HiZwTUH268c5xHl2teW628d8Hzq0+QBYR8XvNfS0EhBwU1X0Z
 MrRZ/mKRd2KchmH+rlsyW2YQJn2aA0zggMqzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170620; x=1698775420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEZ9N0RUAkePSn+ygqhxkFxAy8NAFB27gZcsaZRRbp0=;
 b=skJb8X3zvVEfPPeWdYAWTTX/BwkLX5ZmJswLrFOcKbxNopye+goBG2vQcAPKVN/boG
 sZxj6Vkmk+jQDQo6vLXIvQpO7Ysf26vl7F779ZiZDxTW4iwN7z9FyLw+ej7otZpK1wNF
 zdHo1diPPZUc/GRHYT2+2+AYi0KlVv0Uhy6b9+k1Jj5fIGsT4n2s2Gwknkki67ZIxN1f
 3wQ+Ew0gxhZXgbjyzg+jp9Dh42S8yYDT0koZZhTkQV7u8cra0f28JTX77+h/63Us71gh
 azQ9WnjwdK+BIMtlAhyc0Bqz816kBUG2imPm8afBYbUqNnWX+yIAphsCFhSVRWBIJSK0
 A90w==
X-Gm-Message-State: AOJu0YxfseRfyMezvGlEXQQJT/LZZUWqO+IVWye4Tnv+HPLWJRBDqIo4
 WjrCW0Xbm1YPb0MqDYblTfoedw==
X-Google-Smtp-Source: AGHT+IG3IUlro5+6MzL3WxdMVO2HeSZDgCfsl8aERt+erXKu7tuR/t/3PFeVAmkhG6hkPCDzyfljEg==
X-Received: by 2002:a0d:d5d0:0:b0:5a7:d9e6:8fd4 with SMTP id
 x199-20020a0dd5d0000000b005a7d9e68fd4mr14972385ywd.12.1698170619957; 
 Tue, 24 Oct 2023 11:03:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 a66-20020a0df145000000b0058427045833sm4259074ywf.133.2023.10.24.11.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:03:39 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:03:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Message-ID: <20231024180337.GB496310@bill-the-cat>
References: <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
 <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
 <20230925141906.GW305624@bill-the-cat>
 <914d3ebf-12d8-4651-a598-ca8edf6d5171@amd.com>
 <20230925143325.GZ305624@bill-the-cat>
 <c1fb916e-7269-485e-a77a-ce28a079c7fe@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RFLy92ENAUPE/CGS"
Content-Disposition: inline
In-Reply-To: <c1fb916e-7269-485e-a77a-ce28a079c7fe@amd.com>
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


--RFLy92ENAUPE/CGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 02:33:26PM +0200, Michal Simek wrote:
> Hi Tom,
>=20
> On 9/25/23 16:33, Tom Rini wrote:
> > On Mon, Sep 25, 2023 at 04:21:17PM +0200, Michal Simek wrote:
> > >=20
> > >=20
> > > On 9/25/23 16:19, Tom Rini wrote:
> > > > On Mon, Sep 25, 2023 at 04:10:38PM +0200, Michal Simek wrote:
> > > > > Hi Simon,
> > > > >=20
> > > > > On 9/25/23 16:01, Simon Glass wrote:
> > > > > > Hi Michal,
> > > > > >=20
> > > > > > On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.c=
om> wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 9/25/23 15:10, Simon Glass wrote:
> > > > > > > > Hi Michal,
> > > > > > > >=20
> > > > > > > > On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@a=
md.com> wrote:
> > > > > > > > >=20
> > > > > > > > > Hi Simon,
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > On 9/23/23 20:13, Simon Glass wrote:
> > > > > > > > > > Current alignment which is using 16 bytes is not correc=
t in connection to
> > > > > > > > > > trace_clocks description and it's length.
> > > > > > > > > > That's why use start_addr variable and record proper si=
ze based on used
> > > > > > > > > > entries.
> > > > > > > > > >=20
> > > > > > > > > > Fixes: be16fc81b2ed ("trace: Update proftool to use new=
 binary format").
> > > > > > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >=20
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - s/start_addr/start_ofs/g'
> > > > > > > > > >=20
> > > > > > > > > >       tools/proftool.c | 31 +++++++++++++++++++++++++++=
++--
> > > > > > > > > >       1 file changed, 29 insertions(+), 2 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > Applied to u-boot-dm, thanks!
> > > > > > > > >=20
> > > > > > > > > FYI: I have merged it to my tree and already sent pull re=
quest to Tom.
> > > > > > > > > Without it I couldn't pass CI loop to get all reviewed fe=
atures in.
> > > > > > > > >=20
> > > > > > > > > https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7=
d40c4f5@amd.com/
> > > > > > > >=20
> > > > > > > > Ah OK, well that's fine. It was in my patchwork queue still=
, which
> > > > > > > > suggests that the patches were not set to 'applied'?
> > > > > > >=20
> > > > > > > I am not using patchwork. But I expect my reply to cover lett=
er was recorded there.
> > > > > >=20
> > > > > > Probably. If you reply to each patch, it shows up in the patch,=
 but
> > > > > > the cover letter is hidden somewhere else.
> > > > >=20
> > > > > I have never started to like patchwork. I installed that client l=
ong time
> > > > > ago, I also have account for quite a long time.
> > > > >=20
> > > > > > If you are not using patchwork, how come you are a custodian? Is
> > > > > > someone else dealing with patchwork for you?
> > > > >=20
> > > > > Not really. I am just keep track on it via emails.
> > > > >=20
> > > > > DT folks did wire CI loop on every patch which they get. I am not=
 aware
> > > > > about any feature like this which would bring me something. That'=
s why I am
> > > > > considering patchwork as unneeded layer. And I also don't think t=
hat I have
> > > > > read anywhere that all custodians should be using patchwork.
> > > >=20
> > > > Right, patchwork isn't required, but can be helpful.  Part of how
> > > > patchwork is maintained for everyone (in U-Boot) is that I have a s=
cript
> > > > that will update the status of patches to accepted and add the gith=
ash,
> > > > based on the "patchwork hash" of a given commit.  There's a number =
of
> > > > automated tooling things that other projects use which could be hel=
pful
> > > > here, but due to lack of time/resources, we haven't tried them here.
> > >=20
> > > Can you share that script? I am happy to run it and pretty much close=
 my list.
> > > I am using b4 for applying patches that's why all message-ids are lis=
ted in
> > > the history which will uniquely identify that patches.
> >=20
> > If you like, yes, you can run the following.  Note that when I run it
> > myself between tags, it will still re-update things.  This requires
> > having patchwork cloned from git as well and is a slight modification of
> > both tools/patchwork-update-commits and tools/post-receive.hook:
> >=20
> > #!/bin/bash
> >=20
> > # Patchwork - automated patch tracking system
> > # Copyright (C) 2010 martin f. krafft <madduck@madduck.net>
> > #
> > # SPDX-License-Identifier: GPL-2.0-or-later
> >=20
> > # Git post-receive hook to update Patchwork patches after Git pushes
> > set -u
> >=20
> > PW_DIR=3D/home/trini/work/u-boot/patchwork/patchwork
> >=20
> > #TODO: the state map should really live in the repo's git-config
> > STATE_MAP=3D".git/refs/heads/master:Accepted"
> >=20
> > # ignore all commits already present in these refs
> > # e.g.,
> > #   EXCLUDE=3D"refs/heads/upstream refs/heads/other-project"
> > EXCLUDE=3D""
> >=20
> > do_exit=3D0
> > trap "do_exit=3D1" INT
> >=20
> > get_patchwork_hash() {
> >      local hash
> >      hash=3D$(git diff "$1~..$1" | python3 $PW_DIR/hasher.py)
> >      echo "$hash"
> >      test -n "$hash"
> > }
> >=20
> > get_patchwork_hash_harder() {
> >      local hash
> >      hash=3D$(git diff "$1~..$1" | sed -e 's/^ $//g' | python3 $PW_DIR/=
hasher.py)
> >      echo "$hash"
> >      test -n "$hash"
> > }
> >=20
> > get_patch_id() {
> >      local id
> >      id=3D$(curl -s "http://patchwork.ozlabs.org/api/patches/?project=
=3Duboot&hash=3D$1" | \
> >           jq '.[-1] | .id')
> >      echo "$id"
> > }
> >=20
> > set_patch_state() {
> >      pwclient update -s "$2" -c "$3" "$1" 2>&1
> > }
> >=20
> > update_patches() {
> >      local cnt; cnt=3D0
> >      for rev in $(git rev-parse --not ${EXCLUDE} |
> >                   git rev-list --stdin --no-merges --reverse "${1}".."$=
{2}"); do
> >          if [ "$do_exit" =3D 1 ]; then
> >              echo "I: exiting..." >&2
> >              break
> >          fi
> >          hash=3D$(get_patchwork_hash "$rev")
> >          if [ -z "$hash" ]; then
> >              echo "E: failed to hash rev $rev." >&2
> >              continue
> >          fi
> >          id=3D$(get_patch_id "$hash")
> >          if [ "$id" =3D "null" ]; then
> >              hash=3D$(get_patchwork_hash_harder "$rev")
> > 	    id=3D$(get_patch_id "$hash")
> > 	fi
> > 	if [ "$id" =3D "null" ]; then
> >              echo "E: failed to find patch for rev $rev." >&2
> >              continue
> >          fi
> >          reason=3D"$(set_patch_state "$id" "$3" "$rev")"
> >          if [ -n "$reason" ]; then
> >              echo "E: failed to update patch #$id${reason:+: $reason}."=
 >&2
> >              continue
> >          fi
> >          echo "I: patch #$id updated using rev $rev." >&2
> >          cnt=3D$((cnt + 1))
> >      done
> >=20
> >      echo "I: $cnt patch(es) updated to state $3." >&2
> > }
> >=20
> > oldrev=3D$1
> > newrev=3D$2
> > refname=3D".git/refs/heads/master"
> > found=3D0
> > for i in $STATE_MAP; do
> >      key=3D"${i%:*}"
> >      if [ "$key" =3D "$refname" ]; then
> >          update_patches "$oldrev" "$newrev" ${i#*:}
> >          found=3D1
> >          break
> >      fi
> > done
> > if [ $found -eq 0 ]; then
> >      echo "E: STATE_MAP has no mapping for branch $refname" >&2
> > fi
> >=20
>=20
> Sorry for delay on this. I played with your script and also look at git-pw
> client and cleaned my queue.
> Pretty much incorrect series, rfcs, etc should be only patches listed.
>=20
> If you are running it between tags there is no need for me to run it.

I do this after each tag so yes, you don't have to run it as well if
it's not helpful to you (it may be helpful to custodians that do use
patchwork, perhaps with the upstream commit they're basing their PR on
and then their own tag for me, to then clean up their queue?).

--=20
Tom

--RFLy92ENAUPE/CGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4BvkACgkQFHw5/5Y0
tyxN6gv9HLfsE6mAevaqI0ewPLh8rDuYeLO+M7h+PuRLIhZ1kmG9rrsLXwGJD4aq
Q7Eb67vT7nQHzvWzu0t+wDGgqn1Tqpnz+NhcQ29IIri0RcM3B5a+a5KqObziLgTE
ZUwKbAhyyaPOOXnvfiJjtmWn8dWHvCb4L0sTTScWjHRJKtRz99ITS/fbWuavSIBB
dTZk0gqD+EtaiWyYuBIxlFGQsNd62wTL2uhcRwttH1WAhdvUhpwqcx5mrYuhKY7Q
+OZgiYv1HYVcTkp+RPg6uyq2Fm7av13crn8nyTo3Hr2qg5s+I4s8DHOcMGk/zpwv
CshfH6oEHE3h+dQvqdkCSl8hjbkBKFQJApp8/AFvc4+9KNgFoWWZnxRECOH2GqXc
uCEoxM9r7PFVmFkyNGN+Pe21X4/y4iIZVRrXaEAIdJZkBZki9Hc+DYUJl/PTGlXN
f6tH5j4YlQ2LNi+sS4EWlvXuDM/5L8i97UjrAWxvNolb7D28XASLuXFL3Q+74OUF
jjY6UUt5
=U1D8
-----END PGP SIGNATURE-----

--RFLy92ENAUPE/CGS--
