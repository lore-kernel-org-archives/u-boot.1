Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B751EC5AD44
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 19:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74B4160656;
	Sat,  8 Aug 2026 19:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NINqxLFnXxp5; Sat,  8 Aug 2026 19:27:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F3FC6065D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786217221;
	bh=a5hPxJUGzljVrdcBaah0xApiTuRNNO49jZTqJk95lrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S62mGyc4b0/v1Ug1V2/0RoZdZEaMhu9qIa+quvyTWRqFF+15RzE8TujKW/ejc/Jh9
	 YoZRQxpBNQlqiZtQkdby6pa+kTbznlGWcSuQB892+t8teoyefby8uqjiNjwDjDkKif
	 joTi0lkbcdB4mr6SRvL69kg2lA9rRGf2CGBo9enROKmzmUJv7sWAjxM0RijqVn08IR
	 Peb9yNYHes3AMMsKu868EFyHgI3fx0DGeGSsdU38d7Qa8gKaW8ccVzyvLbkn4m9eaA
	 wA0wBTG6LfGmGjzhkQsd/FI+/o8q3bAuS+VQ1AJeifgqt5p1IhMmvWUq8oq1h0T0YU
	 KgwFzE6E8sZ0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F3FC6065D;
	Sat,  8 Aug 2026 19:27:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8F1C10E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF306403E4
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aG8G7hI0em5S for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 19:26:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8C75940367
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C75940367
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C75940367
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 19:26:58 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so568934966b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 12:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786217216; cv=none;
 d=google.com; s=arc-20260327;
 b=cozuXvvM8gkxrSU+uCdeNw6DYJoTdl31OPzeoxWnsGFhJZSPQq9qfeHJV9A+4/GtJr
 Jlx6XcltZcaTUsR4vQh2grJaKwmnpa++h8GMhyQmxJaQPVYxXcemrbQWz/KbOItNzwPk
 Xix4mOUEVQ+pnNc7RhfgQygdtMwL0VDWFcqcAqR1EbovRGA2xIuVGoX/x3dlCG2v8cJg
 uXxCzrzenfvVZ8g0II4Y5NNJRf75pipv4vl9AXjf+mgqjNsNo5iTagh6u+Xx0zLDvn03
 vDbOsR5C5CwRtCMYG2CQqws7xNyj5Cf7srSrPe98eq2v2ITzTQwybY1H5KoGqYpIDv2r
 C7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a5hPxJUGzljVrdcBaah0xApiTuRNNO49jZTqJk95lrw=;
 fh=BCHElbQHYDcvBCVF75Xda/GZMEncWTEMAUFxkBzn7ZM=;
 b=ceX6QXFbvnrtlDy2W6Q3DmQk2GEKMtEbGYKt3PyZZo4lP4mgJnFxBKq6wMRbQxhi03
 jsfDJFf6hG5vosu2nwdZGymU5WT3hj9UeqrG+zAOAbF0gZJSTxBj/Bkr5GwdqZuooLS4
 7ITNJVGGvFOYvQqfnRXrl+AacZtTFSActJI8AoZCkGq667ujjpXF+a78ijspmDTMs+MG
 cVPaN7IArYRO85MnfGRpFdS3Fu54YaIce4ek/qKJzejpBQLckvXAw6Jg2gCcKw0clMXQ
 BcFT7dDfYD5E5RPmp5BP88rarLdHhgA/IRdPq8vwuh3v/mXiYh6VtuqZ8MJHn2/3IRXN
 77Vg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786217216; x=1786822016;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a5hPxJUGzljVrdcBaah0xApiTuRNNO49jZTqJk95lrw=;
 b=H5sN3zgZ1sylAfrSx2WEW6gtBnr86x/aNrMgXGGW0UWf0UeZjSYwO3/+lq9EsJFPLs
 zJdNvdT/tXlfrgX2WbBombDe+TilfcYtKsq0Ub0ZFstDeQbftpJA55fE6JrrdCX+eUFV
 EE1d4mFFo6VBLR+nStvv8sbJ5D4eh7hq3hzij0pdKS++GyYSX12NPbcBzkJxMCVr4FsF
 BE5hdVeLNPzE3dlxUs6i7RsLeXgWEH+g7liW4dbZt9ck+gWhpWYHu+e6mkrDASfnd+Tp
 /AJ0h7FsX8ny2TaPNL6Rp+tCaS8ej+Oq00nsuqYjk0sNEexhs7gFStsRID+urGs6+hzn
 ZTMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnikQkAw0LmwdeN4JYZle7sxLpwCUByoRCa9M8a6BdFGTIWiYKoL3Ild1uj2gmK5qxEo6IlVE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwIWYYyiB1EUKhp+orZMFu+GxQ4bybAK3hH2ATuZC5S7d6fQaCm
 gPrTniW5O/iBFIGZOODulyJvH6qsYv5Cc9rSeVJavXzUODHmSakIsi0fYjH9KnHsLmDBtVLPu/H
 NndHjbzcuIft75g6lWIOICVkHiUmMB2yUuwwu4qGpYELIX6Fjy4Es
X-Gm-Gg: AR+sD11KZCbRcUi0xURYnj2jX/tSlwtagDrfc2K3AGDGEkYorAZjjDCRyB6JefPn/e0
 WUtcr952Q2K4/hYwlpObXIvbj/cVUC7OZGouX+Mc9rUYgSIUKha63Nf1M2FYJ07338FBctkmhrB
 wiHzQ47yJGh9I9HSdnCww2g0bT7pkuvhbQe45zKlMGPl5XZTe+M+TOGLZ4KQzI8l2MbAV1M7Y2Q
 CCjfamxI1yEB/8jByIgJNdaS1PCLDnjd+Jk1Q2dza6d8gba+vtndPLS8vk75FihYlpHgt9BCWf+
 W/CTTDZyiELXHcUiQs8SlWG9aRnALmh2jVRmLyRogRpLRdf6cxGLLgDJugjSaCZAk3vUEIFTr+E
 =
X-Received: by 2002:a17:907:1a91:b0:c1f:2cb2:c448 with SMTP id
 a640c23a62f3a-c208d3f3393mr292125866b.7.1786217215741; Sat, 08 Aug 2026
 12:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
 <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
 <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
 <20260808181058.GB394392@bill-the-cat>
 <CAKTNdwHED5XzQc4vQX7k_R-+O_0ae3q__w-tG5mfViPgBXW67g@mail.gmail.com>
 <20260808191935.GC394392@bill-the-cat>
In-Reply-To: <20260808191935.GC394392@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 8 Aug 2026 23:26:44 +0400
X-Gm-Features: AUfX_mzXMI-XvSNYwk3BIU1qT2YCwQKfcQ4sG6-rtq_FWkuBzgeRnXWXEgvjx0c
Message-ID: <CAKTNdwFBCbW5+-aX7Y5gt3gNx8rBAHsc0AuVMSJMm8ztNN5pXg@mail.gmail.com>
Subject: Re: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1786217216; x=1786822016;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a5hPxJUGzljVrdcBaah0xApiTuRNNO49jZTqJk95lrw=;
 b=3jlqP6ZvOk/5JeKlKjagFE+curUs0IFG3GZFpEmqtVMBDCHpfBZTlzERqU2PI6O4F6
 vWMLN+Mll6N4MWFnmyCq/nwBvNCRhRi4ymNbpXFY8MgMOU17rOWu5psYTCsTtMz2+YLS
 Yw9mwmf2CdaF2WyIcZJWOvnwrHtKnK9oy1H+qim7ADAkNPJZ/x600ZYYg+2XFyO/fG23
 0KwDm7EjeROyPy6mqnNR/mOt3ZPP9HpkqUrpnmmsWb2vMdgpwgL6EN/rmWBbAxh0FcA6
 aUAH4rrqlGQ1IEogxpo9kR3K867fG296miqV7gndDJMTSyMi72xRon9ja18JumKudKGr
 cjpA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=3jlqP6Zv
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, Aug 8, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sat, Aug 08, 2026 at 11:12:47PM +0400, Alexey Charkov wrote:
> > Hi Tom,
> >
> > On Sat, Aug 8, 2026 at 10:11=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Sat, Aug 08, 2026 at 01:02:02PM +0400, Alexey Charkov wrote:
> > > > Hi Simon,
> > > >
> > > > On Wed, Aug 5, 2026 at 11:34=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Alexey,
> > > > >
> > > > > On 2026-08-05T14:47:38, Alexey Charkov <alchark@flipper.net> wrot=
e:
> > > > > > pylibfdt: Grow the FdtSw buffer geometrically
> > > > > >
> > > > > > Every expansion copies the whole tree into a freshly allocated =
buffer, so
> > > > > > growing by a fixed amount makes building a tree cost time quadr=
atic in
> > > > > > its size. This is especially painful when assembling larger FIT=
 images with
> > > > > > binman, as it assembles the image with the data inline.
> > > > > >
> > > > > > Grow by at least as much as the tree already holds, which is wh=
at variable
> > > > > > sized arrays usually do specifically to avoid such excessive co=
pying.
> > > > > >
> > > > > > With this change, building a Rockchip TF-A+Falcon image whose F=
IT carries
> > > > > > a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman it=
self down
> > > > > > from 25.3 s to 14.0 s, as 7139 reallocations become 187. The im=
ages
> > > > > > produced are byte-identical and the binman and dtoc test result=
s are
> > > > > > unaffected.
> > > > > >
> > > > > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > > > >
> > > > > > scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
> > > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > >
> > > > > This is a _shipped file from upstream dtc, so any change here wil=
l be
> > > > > reverted on the next resync. Please can you send this to the dtc
> > > > > project first (see https://github.com/dgibson/dtc) and reference =
the
> > > > > upstream commit / PR in the U-Boot commit message, similar to how
> > > > > a63456b9191 links to dgibson/dtc PR 154. Otherwise the improvemen=
t
> > > > > will be lost.
> > > > >
> > > > > > @@ -808,7 +812,7 @@ class FdtSw(FdtRo):
> > > > > >          if check_err(val, QUIET_NOSPACE) < 0:
> > > > > > -            self.resize(len(self._fdt) + self.INC_SIZE)
> > > > > > +            self.resize(len(self._fdt) + max(len(self._fdt), s=
elf.INC_SIZE))
> > > > >
> > > > > Logic looks correct - doubling gives amortised O(n) total copying=
, and
> > > > > the INC_SIZE floor keeps small trees from taking many tiny growth=
s.
> > > > > Nice measurement in the commit message too.
> > > >
> > > > Merged upstream: https://github.com/dgibson/dtc/pull/189
> > > >
> > > > Shall I spin a new version of this one to mention the upstream comm=
it?
> > >
> > > Yes please, and are there other changes we need to merge in from
> > > upstream as well, in the pylibfdt portion?
> >
> > I've also added public accessors for address-cells, size-cells along
> > with add/delete methods for memory reservations, which David merged
> > earlier today [1]. It would be great to pull those in, too, while we
> > are at it.
> >
> > They are useful for the Falcon mode via TF-A series I'm working on [2]
> > but haven't yet posted the new version due to breakage in am335x_evm
> > which I am yet to fix. I could send them together with this change
> > here as a separate mini-series if that works (i.e. ahead of the Falcon
> > changes which rely on them).
>
> That's good to know, and yes we want them. But I'm asking if there's
> other outstanding upstream changes to bring it?

Not for the parts I touched (they are self-contained), but I could go
through the whole diff to see if there is meaningful divergence vs.
the U-Boot shipped version and report back (hopefully with patches if
applicable).

Best regards,
Alexey
