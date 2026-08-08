Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD47C5AD2C
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 18:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A53460641;
	Sat,  8 Aug 2026 18:11:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lH2urAJUnRH; Sat,  8 Aug 2026 18:11:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3536E605F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786212666;
	bh=lWv0AbhamXZG5F1dlm0q2mj/PazmLHuSyKJt4aGPg9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PNbEOyLSokqL+Tuezr6xp2HWA+H0ZMOm4qjs/KxQ+iKjJkyEeaWYoNK/dkCrK12Fq
	 39QC/XIHEYdLPDaUNnN68bQhzHBdKSkN4cVFiybmOTik/1AFgV7zqdHSGXSr+tCFX+
	 5WeG81zOCJpbJ/WQRQFc93KKEVEdxq1iXsxPYVVo+D5sujINVUfA5xtLad7pb5iGWd
	 +JYaTFQeyv9yfBdAP6LUKbpcR7omLcIWN6+rNdBPSPdiUiK390U+S0SnUH+XYvm+Uv
	 X2KriKTf0YQDmj0xexxs/yPCFevUpkzb0CKHEH/kAyzcT76J2nC1ZCJ9pApi+mPjlc
	 SuELXwy1dxn1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3536E605F5;
	Sat,  8 Aug 2026 18:11:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BB521AF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DBF24007A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gl8c3b7agp3k for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 18:11:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 22AE74006B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22AE74006B
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22AE74006B
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:11:03 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e9d7464b71so184024a34.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 11:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786212662; x=1786817462;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lWv0AbhamXZG5F1dlm0q2mj/PazmLHuSyKJt4aGPg9Q=;
 b=rLCBIKWM1cUQCTG72Yvhk4d61dKAss03nMp8/fELcy8LOIccX2gmcvsZ5ksBuAOMH5
 Raa/1TSkSk0xUF1G0OfSDpr3EUArdnr8TLr6vxvhVODsgMhixDimkb28iQzrWX9nNTuz
 Rjqg+X3FXpfbzET3VP+4NYSFnTDadaTlJ/05yXTfuf1zfR7bFieNLXptfQHl1YBAilJl
 A0uh6khThcheo3uIbZJqaskf7YazyeW95oeuhtyTAmtY45VPCQvIwZWOadUKIPv1O6tX
 OBwiu/i3vtjGjE2rFC0y3qLR5v79kBOfbVU72i2UFdbvcXBr6R1t/E5ppVugpzzGwsWX
 qAGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RowWVKRshS58MXEhmUD0JW0vihAsuy18YY6/5okUwWqaH2YsBG4BKth1i5zztVPKExhvHJx7UA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxRrdnt3EkzVOiT/A/VTDEEICdae6WLVC6Ecta2aGe8tWyJYoKQ
 r4uoP/UogMkQet1Fmy18GpDqMqKk+xRI825j61z/mjs5naB+au6IBN8fWEN52VqCA1o=
X-Gm-Gg: AR+sD11J/WtNhagyUMyKODrlOZ5pALqqkzLbtcFCeU1MIw+3Wo+o4/+XnWrXxLHpDSw
 1emRbt+zEjGmkTm40LKpezYXUxrqG/1TH2YkF+1V73OJIQ/zQ+bpN7T0FOnC2ANhSqa3NKLd9aL
 /8raIBMbvXfw7KLzG+HVlf5BoZ9qNuobOxszNRSum4+KlTyAEW7cULfGTjYISHtJ1HOssh1Qf04
 u6TNRZgEuj1Hj0nL5giMSX0qa+ZwMUzN2uksVNlJZum7ErFCO22X0BALNwJnQkgjcpoQy0sGZDX
 hSlYdh/9VhLyk+UjtBBZMVwJ4l/wHDGf6OztjHVuhnl9zCCgmdgmQzMyGn+kjmM6uHYUIw8qvVO
 kZXzA6vhY3t+sAlAntUsnzDW62nYPEBZ7FYiKmypudnQV5lhiUmiRZi6r2uPYnS4g4rf4Ay+AyO
 qkXCS9kQd+k84WRIcVmIKrX+e2WJhBZkV3kYc0I2vWjvUSUr6cNS93lmcIfD1346u+wSe43K0CE
 PWIMXk4Ngs34llB/mlw6685gTXQBlk621k7KvaREtOT1AN2Gs5d9oHraPcQwIFD2Qb6ZHLfyVWH
 9MA8peoSxQ==
X-Received: by 2002:a05:6808:c1ba:b0:48a:ddd4:d36f with SMTP id
 5614622812f47-4afadf16e3fmr16651838b6e.8.1786212662047; 
 Sat, 08 Aug 2026 11:11:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b1aeda740csm2623034b6e.0.2026.08.08.11.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 11:11:01 -0700 (PDT)
Date: Sat, 8 Aug 2026 12:10:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] pylibfdt: Grow the FdtSw buffer geometrically
Message-ID: <20260808181058.GB394392@bill-the-cat>
References: <20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net>
 <CAFLszTiJK9JFDe30ZfaXkZvmNUfWUVmC8ZVLU0b-7vfTsHaQ5w@mail.gmail.com>
 <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dEi4D9IV7SRAmbX8"
Content-Disposition: inline
In-Reply-To: <CAKTNdwHyab4T-02-YjSHqmEVHYVXmZSZ9FqYWzpvUpt63UUHEg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786212662; x=1786817462;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lWv0AbhamXZG5F1dlm0q2mj/PazmLHuSyKJt4aGPg9Q=;
 b=GvULoftiIv2KDGnB/PQW413gohOC/i/TXkBlKXDDql5F+FVww9HwJEUn/5ATKKFFXZ
 iw+wRMuUIzuhBk0xpG7vG+kw6HGO/nLc9ZF0D/74tJlQ2V/PXTJlc89Ppwk9KHBchwFu
 eUSXq0eiULZacwcLqZ3IAoXkjlv5Q2vrf3chs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GvULofti
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


--dEi4D9IV7SRAmbX8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2026 at 01:02:02PM +0400, Alexey Charkov wrote:
> Hi Simon,
>=20
> On Wed, Aug 5, 2026 at 11:34=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Alexey,
> >
> > On 2026-08-05T14:47:38, Alexey Charkov <alchark@flipper.net> wrote:
> > > pylibfdt: Grow the FdtSw buffer geometrically
> > >
> > > Every expansion copies the whole tree into a freshly allocated buffer=
, so
> > > growing by a fixed amount makes building a tree cost time quadratic in
> > > its size. This is especially painful when assembling larger FIT image=
s with
> > > binman, as it assembles the image with the data inline.
> > >
> > > Grow by at least as much as the tree already holds, which is what var=
iable
> > > sized arrays usually do specifically to avoid such excessive copying.
> > >
> > > With this change, building a Rockchip TF-A+Falcon image whose FIT car=
ries
> > > a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman itself d=
own
> > > from 25.3 s to 14.0 s, as 7139 reallocations become 187. The images
> > > produced are byte-identical and the binman and dtoc test results are
> > > unaffected.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > >
> > > scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > This is a _shipped file from upstream dtc, so any change here will be
> > reverted on the next resync. Please can you send this to the dtc
> > project first (see https://github.com/dgibson/dtc) and reference the
> > upstream commit / PR in the U-Boot commit message, similar to how
> > a63456b9191 links to dgibson/dtc PR 154. Otherwise the improvement
> > will be lost.
> >
> > > @@ -808,7 +812,7 @@ class FdtSw(FdtRo):
> > >          if check_err(val, QUIET_NOSPACE) < 0:
> > > -            self.resize(len(self._fdt) + self.INC_SIZE)
> > > +            self.resize(len(self._fdt) + max(len(self._fdt), self.IN=
C_SIZE))
> >
> > Logic looks correct - doubling gives amortised O(n) total copying, and
> > the INC_SIZE floor keeps small trees from taking many tiny growths.
> > Nice measurement in the commit message too.
>=20
> Merged upstream: https://github.com/dgibson/dtc/pull/189
>=20
> Shall I spin a new version of this one to mention the upstream commit?

Yes please, and are there other changes we need to merge in from
upstream as well, in the pylibfdt portion?

--=20
Tom

--dEi4D9IV7SRAmbX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCandxLgAKCRAr4qD1Cr/k
CmQFAQDY9DgH05pVhL8RTGL7MfEMaOTeib6q7fzebNKK7xKDhgD8CifFkR/v6vkH
G5dyNJeI/O2+DPQGXhSmE560IcMt7A4=
=DraN
-----END PGP SIGNATURE-----

--dEi4D9IV7SRAmbX8--
