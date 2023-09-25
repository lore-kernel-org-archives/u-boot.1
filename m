Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57089CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C355C86C28;
	Mon, 25 Sep 2023 16:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tgEitP4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F7486C67; Mon, 25 Sep 2023 16:33:31 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC6BE86B89
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59e88a28b98so95851197b3.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695652407; x=1696257207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NbC26kCsxcCSBzcUob79LsDSHg6ubCg9tUBJ8hMX42Q=;
 b=tgEitP4rhCTn2dwIjTXmEba5J7CllbnUtg8QV9letQLxB/8Hmkl95X6LGFHjL0E933
 NMmoQ7pLrbJUBgNH1MP3H2JVr4iGx5akvzBQxOSVusRoOOceH7zTc05OvEoT165OQ/7q
 Mr3TMgEC/VmEFks2NFavPSEXlktfVJ24TMPnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695652407; x=1696257207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbC26kCsxcCSBzcUob79LsDSHg6ubCg9tUBJ8hMX42Q=;
 b=TVK72GpQmPh8V4/Nn9XYfrREJpbaYo6ubo8HLTikJRQbSfX5GdeNLCct5DexwrF47y
 Zi+amURo60UTdJpKfsuqf9KW80jmbDXTeAaTmviiv9bpDdsYEJ0mxUFCAkU+WxpVn8xA
 m9W9SDKE3hb0PjjVfG/TfD0flAil82lMGeTkHRW8OWh+L2+jXEtIMow/M0aSgLQfi+Ov
 bR+9TCJF32hu5+dS8JbrSRgXRFVgaq/jM00KdFJqT53ZEzJecbXef9kJDZXJdlNVWCwT
 DmeDH35qXCn/nfA4qwVTUkdvVWyL82F9mUBjAAeWHVUIq2xu6ZkmLCO6UpWEqcAoEGYj
 fb5g==
X-Gm-Message-State: AOJu0YxcPJnURK2rLviKQQU8VPb865o52GYdGRntVQMYxNQECN8QNTpA
 Qh8gmtfnzM38ySshZ0XUpJwfZw==
X-Google-Smtp-Source: AGHT+IHygKdPZXuAPrF52ZicZzlurYHH9AYALVjReE97omG1vElS6bVugejxqSJ7/UVwUjxWUqsFaA==
X-Received: by 2002:a81:48c8:0:b0:586:a680:250 with SMTP id
 v191-20020a8148c8000000b00586a6800250mr5060960ywa.5.1695652407586; 
 Mon, 25 Sep 2023 07:33:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 h68-20020a0df747000000b0059adc0c4392sm2399921ywf.140.2023.09.25.07.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:33:27 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:33:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Message-ID: <20230925143325.GZ305624@bill-the-cat>
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
 <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
 <20230925141906.GW305624@bill-the-cat>
 <914d3ebf-12d8-4651-a598-ca8edf6d5171@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lz+CPq1EggoV+Gtt"
Content-Disposition: inline
In-Reply-To: <914d3ebf-12d8-4651-a598-ca8edf6d5171@amd.com>
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


--Lz+CPq1EggoV+Gtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 04:21:17PM +0200, Michal Simek wrote:
>=20
>=20
> On 9/25/23 16:19, Tom Rini wrote:
> > On Mon, Sep 25, 2023 at 04:10:38PM +0200, Michal Simek wrote:
> > > Hi Simon,
> > >=20
> > > On 9/25/23 16:01, Simon Glass wrote:
> > > > Hi Michal,
> > > >=20
> > > > On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> =
wrote:
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > On 9/25/23 15:10, Simon Glass wrote:
> > > > > > Hi Michal,
> > > > > >=20
> > > > > > On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.c=
om> wrote:
> > > > > > >=20
> > > > > > > Hi Simon,
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 9/23/23 20:13, Simon Glass wrote:
> > > > > > > > Current alignment which is using 16 bytes is not correct in=
 connection to
> > > > > > > > trace_clocks description and it's length.
> > > > > > > > That's why use start_addr variable and record proper size b=
ased on used
> > > > > > > > entries.
> > > > > > > >=20
> > > > > > > > Fixes: be16fc81b2ed ("trace: Update proftool to use new bin=
ary format").
> > > > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >=20
> > > > > > > > Changes in v2:
> > > > > > > > - s/start_addr/start_ofs/g'
> > > > > > > >=20
> > > > > > > >      tools/proftool.c | 31 +++++++++++++++++++++++++++++--
> > > > > > > >      1 file changed, 29 insertions(+), 2 deletions(-)
> > > > > > > >=20
> > > > > > > > Applied to u-boot-dm, thanks!
> > > > > > >=20
> > > > > > > FYI: I have merged it to my tree and already sent pull reques=
t to Tom.
> > > > > > > Without it I couldn't pass CI loop to get all reviewed featur=
es in.
> > > > > > >=20
> > > > > > > https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c=
4f5@amd.com/
> > > > > >=20
> > > > > > Ah OK, well that's fine. It was in my patchwork queue still, wh=
ich
> > > > > > suggests that the patches were not set to 'applied'?
> > > > >=20
> > > > > I am not using patchwork. But I expect my reply to cover letter w=
as recorded there.
> > > >=20
> > > > Probably. If you reply to each patch, it shows up in the patch, but
> > > > the cover letter is hidden somewhere else.
> > >=20
> > > I have never started to like patchwork. I installed that client long =
time
> > > ago, I also have account for quite a long time.
> > >=20
> > > > If you are not using patchwork, how come you are a custodian? Is
> > > > someone else dealing with patchwork for you?
> > >=20
> > > Not really. I am just keep track on it via emails.
> > >=20
> > > DT folks did wire CI loop on every patch which they get. I am not awa=
re
> > > about any feature like this which would bring me something. That's wh=
y I am
> > > considering patchwork as unneeded layer. And I also don't think that =
I have
> > > read anywhere that all custodians should be using patchwork.
> >=20
> > Right, patchwork isn't required, but can be helpful.  Part of how
> > patchwork is maintained for everyone (in U-Boot) is that I have a script
> > that will update the status of patches to accepted and add the githash,
> > based on the "patchwork hash" of a given commit.  There's a number of
> > automated tooling things that other projects use which could be helpful
> > here, but due to lack of time/resources, we haven't tried them here.
>=20
> Can you share that script? I am happy to run it and pretty much close my =
list.
> I am using b4 for applying patches that's why all message-ids are listed =
in
> the history which will uniquely identify that patches.

If you like, yes, you can run the following.  Note that when I run it
myself between tags, it will still re-update things.  This requires
having patchwork cloned from git as well and is a slight modification of
both tools/patchwork-update-commits and tools/post-receive.hook:

#!/bin/bash

# Patchwork - automated patch tracking system
# Copyright (C) 2010 martin f. krafft <madduck@madduck.net>
#
# SPDX-License-Identifier: GPL-2.0-or-later

# Git post-receive hook to update Patchwork patches after Git pushes
set -u

PW_DIR=3D/home/trini/work/u-boot/patchwork/patchwork

#TODO: the state map should really live in the repo's git-config
STATE_MAP=3D".git/refs/heads/master:Accepted"

# ignore all commits already present in these refs
# e.g.,
#   EXCLUDE=3D"refs/heads/upstream refs/heads/other-project"
EXCLUDE=3D""

do_exit=3D0
trap "do_exit=3D1" INT

get_patchwork_hash() {
    local hash
    hash=3D$(git diff "$1~..$1" | python3 $PW_DIR/hasher.py)
    echo "$hash"
    test -n "$hash"
}

get_patchwork_hash_harder() {
    local hash
    hash=3D$(git diff "$1~..$1" | sed -e 's/^ $//g' | python3 $PW_DIR/hashe=
r.py)
    echo "$hash"
    test -n "$hash"
}

get_patch_id() {
    local id
    id=3D$(curl -s "http://patchwork.ozlabs.org/api/patches/?project=3Duboo=
t&hash=3D$1" | \
         jq '.[-1] | .id')
    echo "$id"
}

set_patch_state() {
    pwclient update -s "$2" -c "$3" "$1" 2>&1
}

update_patches() {
    local cnt; cnt=3D0
    for rev in $(git rev-parse --not ${EXCLUDE} |
                 git rev-list --stdin --no-merges --reverse "${1}".."${2}")=
; do
        if [ "$do_exit" =3D 1 ]; then
            echo "I: exiting..." >&2
            break
        fi
        hash=3D$(get_patchwork_hash "$rev")
        if [ -z "$hash" ]; then
            echo "E: failed to hash rev $rev." >&2
            continue
        fi
        id=3D$(get_patch_id "$hash")
        if [ "$id" =3D "null" ]; then
            hash=3D$(get_patchwork_hash_harder "$rev")
	    id=3D$(get_patch_id "$hash")
	fi
	if [ "$id" =3D "null" ]; then
            echo "E: failed to find patch for rev $rev." >&2
            continue
        fi
        reason=3D"$(set_patch_state "$id" "$3" "$rev")"
        if [ -n "$reason" ]; then
            echo "E: failed to update patch #$id${reason:+: $reason}." >&2
            continue
        fi
        echo "I: patch #$id updated using rev $rev." >&2
        cnt=3D$((cnt + 1))
    done

    echo "I: $cnt patch(es) updated to state $3." >&2
}

oldrev=3D$1
newrev=3D$2
refname=3D".git/refs/heads/master"
found=3D0
for i in $STATE_MAP; do
    key=3D"${i%:*}"
    if [ "$key" =3D "$refname" ]; then
        update_patches "$oldrev" "$newrev" ${i#*:}
        found=3D1
        break
    fi
done
if [ $found -eq 0 ]; then
    echo "E: STATE_MAP has no mapping for branch $refname" >&2
fi

--=20
Tom

--Lz+CPq1EggoV+Gtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURmjUACgkQFHw5/5Y0
tyw1xgv+OleRMc37KWoBSO114/luYX3jQ/mt0BYYhv20sPAhFpqtb7v36oj+8tau
TI//ORI9B1v0xKqHibAcNvNGykPx45YVTqAP/uqHDh7c5qAwp/CDISupThSuHoq+
SHZH4impzSw5UFtqTdbpt9PsqwjcIzDFsq4Ri48H5UASPqExtCn7VKWbvlOCo5xZ
40l/qG2jlBTrMMyf47S/IxT6LvxhJvbfxUrLVowMksvcYNEwq3QlkPuCiD+fKFtm
MP7su7cxcQtiKry1dTX3avw9CNiItd80W5Gaj+useKu19g5Ld1rYGn91EYkyww2J
Gc72aPF8fWIb62gPCk3AN9rJyycuynKBfgosMZ+GAm5QZUwov1/0ea075a6zrrud
uYV32L4lRz5HFM2zj2vSR/3oRkcZO23cjRMh3fuqhqJIQi1qIaWMNBYEmf8DzgnC
PedBLT3eCMdeNPwsjAvHBjJy/GZ3q/fEdJB3nAlXeOOIm+LvevQQdyXUJ3U9q4F8
lVVP8OAq
=oo+s
-----END PGP SIGNATURE-----

--Lz+CPq1EggoV+Gtt--
