Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6C3C5AD4E
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 16:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7C224053C;
	Sun,  9 Aug 2026 16:39:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dq2W6NH6GC_t; Sun,  9 Aug 2026 16:39:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC9F940538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786293594;
	bh=aAYKQjwYJdwgUwyd+G5WOoSsamgu+P+sMQIB1gsg8f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kk8BIjMO2orrCf4wcaH8+KiYYIXc8s8gESRIE9030Lk7fjDu5VFcpMjj2r1GMpo/q
	 cNUeA7cKs7+SiufRHuZQHdelFO8inEnjVyS9G22eRF3TwOozrMwvWkumSJ/1JIxWlJ
	 yoDvOrl5ohqN8MdLFbs8za/LRqE/4bHAK9WEWLW5kSuJnPUeOoN0auR9c5tsL1UlMC
	 AY+pgJYCKscM5vecjA7ITuUYKqzKBMYlaDFJakUuhJr7/R7OSOXfPA9xfM6qalTSu3
	 B2ThBTugvNoDluTPNPjgEAg+wtHRrfvp+j1lBVHWNczfuAdvvW1SQkClkZUSPzOWdR
	 YpI8xYCfT8oHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC9F940538;
	Sun,  9 Aug 2026 16:39:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4617198
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 16:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1F384004B
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 16:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gS3tpCCdVL8e for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 16:39:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E314340026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E314340026
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E314340026
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 16:39:51 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6ae542c486eso303831eaf.0
 for <u-boot@lists.u-boot-project.org>; Sun, 09 Aug 2026 09:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786293590; x=1786898390;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aAYKQjwYJdwgUwyd+G5WOoSsamgu+P+sMQIB1gsg8f8=;
 b=I6ANqCMKSFyeukWnIB+ze3iFIIczydmz1DbUU2dkBxDCvgL5Ynk/5yWuuIcEzHoiDj
 bHYocURPSsxxhl/TL+DryxNPTukvh3ZyNrmi4b61/PudPu/l8ZE+mOX3lHXDYxWUOYsh
 rQwE2lB1Ur55q/brRqceWeZVniK3sAnLJ6op7331wEPjDDCwHQYl8Bz7jvFTG2tvEoYM
 9VZjqI6UgIFkRF8CMdEF7fA2UWYw8/sBRsEB0dBLtg8t/wrRD0TO+mYSt1IiTmbvRptN
 qDHNYKAYqBxCBcFrUd3vTi6NlwWKxgCbevp8wAdDU+EijrtMSF84GqDaml0LFwymICLI
 vKSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEuqiBozzDeiE368XcxZfuPj+NhjDe7IBM6TwRlzh/hPCnafQSGIBmMGd6JmLHYPAa/8zmj7A=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyVDTITp2itw7Sxi6xTIUXL3PTTJSJudIieBPGRMdrt0vdgxij3
 cLeOxRaSv46UaYQyiFa3q+N0sevFL5hybYIdehPL3seOO94UvdnvnMTicJVp9M/6QRVGI9C//Uw
 Q1KF1w6k=
X-Gm-Gg: AR+sD10MggXuwF25eokbgh7AfW1sG7eKgPRCwg+Tsty0ADoOzfMWvHMmSMWzpAOd7r5
 I8nb9mErIDn+p5VwtN00RbEgof7WE6m/U4fogNSj+zmVFXelhreHiNSDmu/lU2FynHjV/DB6n+9
 Dgy7HCxVj+MlJy1ngQpoWVDlRHRxfN1Tmhtd1ZoOP54cmsGRVqbSSqkhtBNilLIxVPFFKYEFBiz
 Ih00UtDw3Bqvl1RNu9CuwdOJE/oby1Kydpsbrf2h/p8GzAnS5fTtyMkbS7z7kLCViZSoK56prqV
 v+TrV2z1ouixw4lNKffH/atedosXhV1rEHPdiNkD6JCozmf9yAgOWqtNftwPKNSR6AehwaYXRks
 Esroi1lfQqjIzUIl3xo6xZLYLF2a1alI4+3F7/00wsbI6hoctDSeai2Y7YqBXuSTw5PyjrGyBDD
 o08ZU/keLb3HmVQtCtc+jHNMVj/zcRFFkMbCgvcOVdk/MrFjTbOXbBbZlkGxNqVA9V94vSeCm2Y
 284Bg99CQJsBYkQQgnbrl/D7cTynKHSBfLCez84V319y11s+aMTxlSG5KTkPoZe36kZ4auSfCWj
 VbydTbdYHg==
X-Received: by 2002:a05:6820:201a:b0:6a1:8192:4d89 with SMTP id
 006d021491bc7-6b0421e7d1dmr7432396eaf.29.1786293590476; 
 Sun, 09 Aug 2026 09:39:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0512521a1sm3587625eaf.5.2026.08.09.09.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 09:39:49 -0700 (PDT)
Date: Sun, 9 Aug 2026 10:39:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] board_f: Call initf_malloc() before fdtdec_setup()
Message-ID: <20260809163947.GG394392@bill-the-cat>
References: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
 <CAFLszThbzKZWctdWh8B1j2cqACr+9dNVaX_FMkvbHtXkMDnsTg@mail.gmail.com>
 <2eb8a15b-c9d1-47d2-b8b6-da27d711ddb4@mailbox.org>
 <CAFLszTjUGsM99ffVV+YryDGjB5+YV+T9pnegmbko7vpRySaD2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GM+Ihj4TNx+NOi2c"
Content-Disposition: inline
In-Reply-To: <CAFLszTjUGsM99ffVV+YryDGjB5+YV+T9pnegmbko7vpRySaD2w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786293590; x=1786898390;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aAYKQjwYJdwgUwyd+G5WOoSsamgu+P+sMQIB1gsg8f8=;
 b=KUydCa4mo8WWYWeLuEhKhKELSCdC0BdjKrnvBvlKCk32w3OejPGDBFVepAm1zvZKrX
 4sf1/6C/8GDhxmxYQTUtTeEIXigklPNry8U860tGectvnouAcjVSoiV6UWBqeDXftkF9
 z6fU2PE+yQTB/3q3eGc4oAEBFun572bDgt13c=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KUydCa4m
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


--GM+Ihj4TNx+NOi2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 09, 2026 at 10:33:16AM -0600, Simon Glass wrote:
> Hi Marek,
>=20
> On Sat, 8 Aug 2026 at 19:14, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 8/8/26 8:17 PM, Simon Glass wrote:
> >
> > Hello Simon,
> >
> > > On Tue, 21 Jul 2026 at 13:48, Marek Vasut
> > > <marek.vasut+renesas@mailbox.org> wrote:
> > >>
> > >> In case MULTI_DTB_FIT_GZIP is enabled, fdtdec_setup() does uncompress
> > >> the compressed DTs in uncompress_blob() using gunzip(), which invokes
> > >> malloc() internally. The early simple malloc is initialized in board=
_f
> > >> initf_malloc() call, which sets up the early simple malloc limit and
> > >> offset pointer in global data. Currently, the initf_malloc() is call=
ed
> > >> after fdtdec_setup(), which leads to malloc failure in fdtdec_setup()
> > >> during the gzip decompression, because the early simple malloc is not
> > >> initialized yet.
> > >>
> > >> Call initf_malloc() before fdtdec_setup() to assure fdtdec_setup() c=
an
> > >> use malloc() during gzip decompression of the DTs.
> > >>
> > >> The impact of this change on boot time is negligible, because the
> > >> initf_malloc() only assigns two fields in global data.
> > >>
> > >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > >> ---
> > >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >> Cc: Simon Glass <sjg@chromium.org>
> > >> Cc: Tom Rini <trini@konsulko.com>
> > >> Cc: u-boot@lists.u-boot-project.org
> > >> ---
> > >>   common/board_f.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > I'm not keen on reordering this list...
> > >
> > > The offending call is inside uncompress_blob(), which already has a
> > > non-malloc path - MULTI_DTB_FIT_USER_DEFINED_AREA with
> > > MULTI_DTB_FIT_USER_DEF_ADDR.
> >
> > It isn't the allocation of the decompress target that is the problem, it
> > is the gunzip() call which internally calls malloc(), cf. commit message
> > and lib/gunzip.c gzalloc() usage.
> >
> > > That is the pattern most boards using
> > > compressed multi-DTB FIT already use, and it avoids early malloc
> > > altogether. Could the BTT config not just switch to that and drop the
> > > board-local initf_malloc() workaround at the same time?
> >
> > This is unrelated to BTT config.
> >
> > > Failing that, the per-board workaround in board/liebherr/btt/btt.c is
> > > ugly but localised. If we really want a generic fix, I would rather
> > > see uncompress_blob() call initf_malloc() itself when it needs the
> > > heap, so the ordering constraint stays local to the code that needs
> > > it. We would need to ensure that malloc() isn't then inited a second
> > > time. We could always add a flag to gd->boardf, I suppose.
> > >
> > > The reordering also means that malloc cannot be traced - the idea with
> > > trace is that it is enabled as early as possible. Finally (that I can
> > > think of), it means that early malloc can never be configured by the
> > > devicetree (although that is not something we have needed yet).
> > [...]
>=20
> Ah OK, I see. So in U-Boot proper, before relocation, you have a FIT
> containing multiple gzip-compressed DTBs and you want to select the
> correct one (presumably with a compatible string), then decompress and
> use it.
>=20
> Is it possible to do this in SPL instead?
>=20
> If not, it looks like there are two allocations in gzip. One is just
> its state (fixed size so we could pass it in or pass a pointer to a
> local var). The other is its context buffer, which might be 64K or
> more. Did you see my suggested workaround above (call initf_malloc()
> itself)?

The work-arounds you're suggesting seem much more cumbersome than
Marek's change, and I don't follow what you mean by malloc not being
traceable? Shouldn't it just be that whatever early calls happen before
trace_early_init is called, wouldn't be traceable, and that in turn
sounds like a reasonable tradeoff (and obvious enough if someone is
using the facility to debug an issue, that early).

--=20
Tom

--GM+Ihj4TNx+NOi2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanitRgAKCRAr4qD1Cr/k
CpeFAQDE4xhtwAcLvXVgeqwngp2NB48r+GH44DH1gmnZPiz0ngEA6u1N5JDz0cUL
ilkmcHeTkG1RTRpVZhCJLb36kggDhAI=
=i4h5
-----END PGP SIGNATURE-----

--GM+Ihj4TNx+NOi2c--
