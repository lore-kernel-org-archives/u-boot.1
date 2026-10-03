Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD7CCA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 14:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 107D481376;
	Sat,  3 Oct 2026 14:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5a8Uht9sQa2z; Sat,  3 Oct 2026 14:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 35D9D81377
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791036773;
	b=SQz1zs2yextux24CtaVUTa5gtvZgdtaEO41Gbe0OrFWMCuemQVXWFii+rJs+xKlIjjJY
	 f2G5rPT93hnXKYKVkG7htxoEpuwpT4cpJ2kHbWCHl8K6SR8breXrXP0S2V4X07xCL38Lt
	 Y44hKeAcNfOGw0wzgj2nhLY3zy0o/wMLVS1LByZGJ+WxOOFN7K8oxWbBtq4FScBG0g360
	 YUzX7myrol+MZ8CqJnGpr9InAJVTiMDSDUQ5pRkrqsXL+a9yXzyUiNUacmq7md9yF9bMG
	 9xN2S2qkZIazjbQl8BkrS6iVYckepv3rP5GhRctvRclGIEwUQBTAd/gDwAa7Jg4HLSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791036773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rPp+/0tR/M3k1D98b8nB6DZYb/q3FicfEZfeUM93DhA=;
	b=jYabTdc2KmJXqHB2CS3D5BVNSS63Gr0s9MS8uG1zSmeK0YWn31lm0hOPupQZDEkuL6Uh
	 fYGDpZwh4lxuaj7VyLoaZm7RFI4YbOnGMq/JDznpvZPSh/6NrK7EnCRd8otUO0tHi3zk5
	 qbJZ5bkbxrLbu9Fb5XztdddPuGqKG9DjURISC/Wi203ulzhV/yAXicAqqTBR/TLru7HZg
	 34eLtLnry35qsfgG1rdCi18KqUhzZjJNAdGB2NGCfGdALa7OuO83lScduif0Y2e+Ijwpa
	 6EMjzeLTBHvtXdjX0rWET8Z+snFs/DNf2B8gs7SEb/w66GTCT9BAu50Z21+BIvK6SFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eahFpgwN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791036773;
	bh=rPp+/0tR/M3k1D98b8nB6DZYb/q3FicfEZfeUM93DhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LyYfEaKbcgd0XhdXlH1sBeTul3rUxLSiuQKob0Byc/sYjnJuvENkAEc1xUtqAjUft
	 fJelgU/yWNJ3rqJhJ4Vn6OgqLymplNqjVQzbw0+9nDpBE3azKgJNUMSZice9kDTbSh
	 YlvMxz+o6aX5qpzkuGjj5OjXDnN/Sx9F/pRcXVhJwWaU4NaGHMeBAenh66GxOJFpIa
	 uk5FN9mTR4CgHnFriHa62qw6OibyCVUFlBgTsdO/uzeZO4l1fd2MNZwhSsRPkMLrPi
	 /MZGL9de6KDGVJs4MKahy/ZhI/5M2RIXHGW5WBHi6wUn8iTheoi5+fVfbzrNyNyMTf
	 1BW4H4vfuQudw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35D9D81377;
	Sat,  3 Oct 2026 14:12:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB2E9282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCAE581377
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESQI0aAxkw7Q for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E699981376
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791036771;
 b=iC8SWSAZqJnIA4RFwk6O3ViIC0ASdZB5tG9d7LYefZeoTXp+XsqqpYth1uzFnF0vTgDX
 qM0ZtXW/XGT6JC4xGKyL29S2C3mbeE///I6aotjohSMvq2ayFbYWUi2h0VYYraawwfTfg
 1+AbiyPjuWPZ9zpa5VoxgdLFIzca1LcR62KoLBe4fMqOQMZcK1did50Ux+99Ag3xTWzSQ
 ZNJ8216cdYR5R0jeUBq5zEhJQZPtYbQwI7YHdRxBrMHL60tRrSo81pR+s++OiZPtbhzzH
 xfiCKof21iMHoU9FdCjhwSQDnnIXysMo4ZV8l1nUQM1pkVBvNp+/FGaxOsYw8doiCfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791036771;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=rPp+/0tR/M3k1D98b8nB6DZYb/q3FicfEZfeUM93DhA=;
 b=hWTHAN/8UQsBJMLbEF3dfmbAvfK2UV6rX0afVr2PVO5gesbcN+BKgvfLClezWw4yE7lK
 Rtv8YXtvHjGqIwzWlg/zVGZ8hnwNu2dcPGyNpBDhBLjSREEliLrPyrwfD3vtGNuUby/U+
 MosZ3IXN7EZFlSZWLmiV6CxA3t52dEgj6U1s02WYHPwkGSF3nWWRJdUU3hpPoB4eowRA6
 a2pL1vRdrpwNdSzOi0LflL3rI2tt4gAuSqpn/ngqQnhSF5aKCgFpl5mbWVAQ9vVP+McmA
 wZby2s5xL/1zagOYqQOBdK221WLZKJEJS/ceRo5f+KAqP5pdTUy8J5b2ra4HBY9qx7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eahFpgwN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::26; helo=mail-oo2-x26.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eahFpgwN
Received: from mail-oo2-x26.google.com (mail-oo2-x26.google.com
 [IPv6:2607:f8b0:4864:31::26])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E699981376
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:12:50 +0000 (UTC)
Received: by mail-oo2-x26.google.com with SMTP id
 46e09a7af769-821c01c2fc5so852847a34.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791036769; x=1791641569;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rPp+/0tR/M3k1D98b8nB6DZYb/q3FicfEZfeUM93DhA=;
 b=eahFpgwN/UGpJZLFUBhrVySc5tFXDhishBhtQ8dJqX1VWsRwiDJmykbmDNxCZMahMV
 Cn5BH2viY95c6ZH7H5qnu7A16TaX15jprjPi9SZmzNfKRc9gN2m1iQzH2OWbbyorCrXR
 6nnuT8p/QQ0U82CVOXCARytFsc3BkncVZAOmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791036769; x=1791641569;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rPp+/0tR/M3k1D98b8nB6DZYb/q3FicfEZfeUM93DhA=;
 b=tqgfw8GBrBPR5JUoO54T5rw4MEmd5PZmADchks/el8xFP8WX9a8ecv+7X/6m2QF0Sn
 R4p0jecX3VPM6/GX4c8BTmnTw5Q3hU1y4+bz3KD1s5K2tk2PcLENvLzEXegPr4E7s7fT
 dsjCkYJu0PKN/4OG7h5NRUAX02EDiinLDlkdsNBypv3Zszv55YzALFrJkVgudd1s2LBi
 TErm/0leV1RF98Ds/mv2jiDJyuuUsEdNRPhMhp9igRTqutgsxokzP2us1RhJDcROWDq6
 G0hiDJoixmErsPReC1XdnjkDiN90NVW4BKDKaX67VVkK0jfq1r/LikcNBOVdVfxsr7iS
 r+zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvgsxxXFhwMjnKB9CJISuqgWM+k40+LrdXXY9lUNxFRBVmpWHlJjPMP9GXrXG5pJPrplQ7s/s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nBrAVmvwe3iZldH08UjNPfMjHYmPN+nRXqaEqjNG0Tc69cvXeM
 2Jtek7eowm8IfFf3DEIj2+ikX9k8ZMM8jkvs169vs0y2JIqoXh9AKDMNMT0NEYdNtlTVaXElMcr
 r++XjlzJiMG5r
X-Gm-Gg: AYBFou1CLeI5hFXfZalbgTfjIlk0ZrOM5Vn78HwxQR4+YljRdOI7FinN5et6kpG8sfD
 oJpmf9IosbqNyok9eAcac6IU5EVhsDa19z69k7+xcAN8NxKWUBZlbrtTfxRucHLT2o/3gfenclB
 vg2NcbK+yykbOJzoDW8ul8ozRJuLa/J82IpCass6+vKIS+SJwr8jIr/0K0kBTC/Q2K1Pugqw6mn
 nhyqS8TxI+wCXqc63bixM8u24mhKLZ6WtV6o7QVG6UWqUKLvg5f5cYLc2O/UUqcqS4YUJWjbJ9k
 VOc0seE80zIbSUFUyUIOZkl3aKlj7nR4qbmwHfuvvCvNKB9jCy1AOVBEl6MCbQjsTd2lc0rNqF6
 UDqs7lcq8G53AhIpYBmPEDQrwKkAMFVETbRKt520I0LLc2+d+++33bgic7hFdG06UcF+sZ7xGKY
 84nDRILTe1xb3ZFbN7dYYlF6f9VnHyS6/tRalwVtCgLAf7x2NSRdCZAkAawXt1N41D23wh0XZTD
 vdl/uxTO0+y8Pcc8ZlZi6qqxa6HeS30d00KTsvYfkjjbz4N0sMJj3tHBvU6btnbhYucbAhwSoVo
 ssDqQ2ilRQki5QDX2P8Kw03FEmHuvQ==
X-Received: by 2002:a05:6820:80c8:b0:6da:3a3b:527e with SMTP id
 006d021491bc7-6df3612ca97mr4783640eaf.81.1791036769457; 
 Sat, 03 Oct 2026 07:12:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16f4b59fsm4500819fac.16.2026.10.03.07.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 07:12:48 -0700 (PDT)
Date: Sat, 3 Oct 2026 08:12:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: alchark@flipper.net, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Francesco Valla <francesco@valla.it>,
 Anton Ivanov <anton@binarly.io>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 04/11] lib: Track whether a phase has a decompressor
Message-ID: <20261003141245.GD2658242@bill-the-cat>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-4-28e946f57357@flipper.net>
 <CAFLszThSk33kZwbWHMjMSdc9w75WZA0yyQv8RH4iiQ7-Jr+X9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iB/Jdiyo6zQZCAUz"
Content-Disposition: inline
In-Reply-To: <CAFLszThSk33kZwbWHMjMSdc9w75WZA0yyQv8RH4iiQ7-Jr+X9w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--iB/Jdiyo6zQZCAUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2026 at 02:40:44PM +0100, Simon Glass wrote:
> Hi Alexey,
>=20
> On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> > lib: Track whether a phase has a decompressor
> >
> > spl_decompression_enabled() names the two algorithms SPL happened to
> > support, so every algorithm added to image_decomp() requires editing the
> > header. It also asks about CONFIG_SPL_* from a header included in every
> > phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about the
> > wrong phase.
> >
> > Add a hidden per-phase symbol selected by any of the compression
> > algorithms and ask about that instead, which also matches how
> > image_decomp() gates its own cases.
> >
> > SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > common/spl/spl_fit.c |  6 +++---
> >  include/spl.h        | 10 ----------
> >  lib/Kconfig          | 30 ++++++++++++++++++++++++++++++
> >  3 files changed, 33 insertions(+), 13 deletions(-)
>=20
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > @@ -284,15 +284,15 @@ static int load_simple_fit(struct spl_load_info *=
info, ulong fit_offset,
> > -     if (IS_ENABLED(CONFIG_SPL_FPGA) ||
> > -         (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_decompression_enabled(=
))) {
> > +     if (CONFIG_IS_ENABLED(FPGA) ||
> > +         (CONFIG_IS_ENABLED(OS_BOOT) && CONFIG_IS_ENABLED(DECOMPRESSIO=
N))) {
>=20
> The FPGA and OS_BOOT conversions are a separate change, not mentioned
> in the commit message. The rest of this file still uses
> IS_ENABLED(CONFIG_SPL_FPGA) and IS_ENABLED(CONFIG_SPL_OS_BOOT), e.g.
> in spl_fit_image_is_fpga(), os_takes_devicetree() and
> spl_load_simple_fit(), so this leaves the file inconsistent. There is
> no TPL_FPGA, VPL_FPGA, TPL_OS_BOOT or VPL_OS_BOOT either, so in those
> phases the answer now differs from the other checks.
>=20
> Please can you either leave those two as they are, or convert the
> whole file in a separate patch?

No, it's fine to not worry about those others until a need comes up.

> > diff --git a/lib/Kconfig b/lib/Kconfig
> > @@ -974,30 +978,35 @@ config SPL_LZMA_SIZE_OPTIMIZATION
> >  config VPL_LZMA
> >       bool "Enable LZMA decompression support for VPL build"
> >       default y if LZMA
> > +     select VPL_DECOMPRESSION
>=20
> VPL_LZMA has no 'depends on VPL', so with this select every board with
> LZMA enabled gets CONFIG_VPL_DECOMPRESSION=3Dy, even with no VPL. I
> tried sandbox, qemu_arm64 and evb-rk3399 and all three end up with it
> in their .config file.
>=20
> Please can you add a preparatory patch to give VPL_LZMA a 'depends on
> VPL'? BTW SPL_GZIP and TPL_GZIP have the same problem, although they
> don't default to y so it matters less.

This is also further nice-to-have cleanup work that's not relevant here.

> > diff --git a/lib/Kconfig b/lib/Kconfig
> > @@ -1011,10 +1020,31 @@ config TPL_ZLIB
> > +config SPL_DECOMPRESSION
> > +     bool
> > +     help
> > +       Selected by every decompression algorithm available to SPL. Code
> > +       which hands a buffer to image_decomp() without caring which
> > +       algorithm produced it should depend on this, rather than list e=
ach
> > +       algorithm in turn.
>=20
> Not quite, since SPL_BZIP2 does not select it. The commit message
> explains why, but please can you mention the exception here too, since
> this is where people will look?
>=20
> Also, there is no symbol for U-Boot proper, so
> CONFIG_IS_ENABLED(DECOMPRESSION) is silently false there. That is fine
> for spl_fit.c but anyone following this advice in code shared between
> phases (e.g. in boot/) will get the wrong answer. I suspect it is
> worth either adding a DECOMPRESSION symbol for U-Boot proper, or
> saying in the help that this is only for xPL code. What do you think?

The whole set of things we're doing here is xPL, so we don't need a
symbol for full U-Boot at this time.

> I wish it were DECOMP instead of the rather verbose DECOMPRESSION

It's also not worth redoing the series over, either. DECOMPRESSION is
fine.

--=20
Tom

--iB/Jdiyo6zQZCAUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasENWQAKCRAr4qD1Cr/k
Coc/AQDlZZE0Ksd3hkPDp9d2qYxcRZEVXukzpyEkQXIcB5wBUAEAwUBpCkdcoaXK
V+jR1pefmcLd6ChFrr4NWUeXmQoeaQI=
=M7Kd
-----END PGP SIGNATURE-----

--iB/Jdiyo6zQZCAUz--
