Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC6CC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 15:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91EE180872;
	Thu, 15 Oct 2026 15:20:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bg81SwfpbVol; Thu, 15 Oct 2026 15:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5A2B80A49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792077651;
	b=bB32In2G4/DRPGZ1yl31ubP+WNZG3nOwOv4vCpzggK82V6BO2wjfn6kvqa8o4ONWKAqQ
	 FqE5pg8cHiiFOyGG3G1fP5fBAhgy6HCaY6tymUUBBs9A/8m1MdT64Dbcy3IFve3WaMf+6
	 kdyV8KW02FXLg4uxo5slx8q6/i4t3hvn5wrhpo1Es2yYvbmhjApbcP0ozujlrPGs1Vypx
	 kwJlhzrz5/zytYdtMqdhx4Nm3oxIxxr64WlWpb1CkGnnIALWJ0AZhUKabzEFqQquyoVVF
	 jp2LRvBA9eVInoNxJG5BTv5vz8lrM35p+1vevmdO+Itxm2fwNKCFd7dnPfA4RwlLAQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792077651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jr9B19F+l20WAo8Hz8aSUkGoXAtk268WlHsOUVABwTs=;
	b=GUDU80T4qSJRfOoGQ8n0R3Ph6kfJzwvs3Nq5n2+PUESKY3G7MvLubYFJBLtN2qgJ7C1e
	 wilkhKPCiiOGlpTzAJvuKTkHFWs60/hMMmdI5E9qJ/smVvQJIcHkktsJvvt/NNlN8BqD1
	 B+VzNo1jrqh6vedDD5IX+r8aPPicKg+HGkaGgYGm2gSN7bs16mEjx28kXQaG3NJrdzH7e
	 LAqN/TcoVVDcXfy/ZpIGoPNCXXJ7Eds5CKGnK2Lxb91ttqB/o5kTKnwa6W90UZfJV2sd2
	 a9EBxod8fI607CAuL16zF45YPBHCmdVB5CFPiRPJmjT4FzNDeRj9wrRme/t4mwruPyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792077651;
	bh=Jr9B19F+l20WAo8Hz8aSUkGoXAtk268WlHsOUVABwTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQX2gI4Pv9dHpwEmZohZhJaXOv5Q29KJI7idTEBRAI4VcnZBjxd5dWF/l5h+azan6
	 ++asJChEU02khRLkEBmnKMBWb6+1WmLGBluBiSFoBHcPRQmMQK1nXcnOcUdbJ3Ly+p
	 UuEIULQQvWRi9WE0b9fzfoJiMS2Qf31siaOoAvHEIBEUPZKN+Dnm/yhs8wOqDGTzJR
	 bUuXhwWQvyKIQF9yjrT8VV/RjbBq9gyEKue51djVcn9LEwbJHM9PX8dsjhn2gvfxiH
	 dIS9pvI2NYX5h31BpwY4kGKUuQJ13cQToGMWhb17v1I7BTDquB1BvOykFpmw9KqO/K
	 i+80zQBwKPliQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5A2B80A49;
	Thu, 15 Oct 2026 15:20:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F9262AC
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 15:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55BFE4018B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 15:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZHTKiJXyjZD for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 15:20:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7B298400CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792077649;
 b=dKkFDA5F1S4GsHpfjrTRHW4Kq24HyxnDBrgIrGghzxbjo1q/3SUrRvnAWbB9MmolTiAI
 i1Hgda3ToNM8i7vdFOK+jxQRB4erAlN9Z0frPR9M3awhyxkWDqiB0jGR0Uc6VC3P6u2yO
 Axd0rXU3swIiN00WBdROwfzCqDP677wUsxa4N6SGvkq/DM1oKY3aG0OlyDgnywJLyaX4j
 EFc3LUNwUSFDKJ3b/TdAYMMQ/q6aJ3/K6+ID1HpAO9hBXH1tATN5sAaHSxeGdqMS9eYFv
 XB9/fny1e880SGeHjmyhu2OCTTOhjIGHasLhDu9uHBNpNMA+xIIAvfuTfthuS3guLZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792077649;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Jr9B19F+l20WAo8Hz8aSUkGoXAtk268WlHsOUVABwTs=;
 b=g3kgMj98t16YKsldprXmbzJSe0Yx4Ft/50dW7MNbULuyNXjgkv/Tmev+X5fyD5TLeDKh
 Jzem01nZN/ExHbiAobEhAyTqVZ//QdJ3p101zzrGomggbHT2P8klABXyh8ErApm5690yQ
 4M0LMgNujpgwlBXOWJx7BKtdUNRRTmGRdOe8Zp3g0xr08/vGzxm/p1eviIq5yuBxU0RSQ
 se+o49gZlj/O3WKCPPIwMzRx+2KHXN7VlCOZ/exdtYeuzL9ligEjtndai1ZaorPAgwvUJ
 +yeURx19TPKybdW1paM9R0EVGJbzVx1ZgdIiw2lYNRrOeUghb+JmjupgucHnICumFQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="mKq/Kvl6"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mKq/Kvl6
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B298400CD
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 15:20:49 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-824e6e6ed71so1793878a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792077648; x=1792682448;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jr9B19F+l20WAo8Hz8aSUkGoXAtk268WlHsOUVABwTs=;
 b=mKq/Kvl6qVlhg7JXabTBTr6KhiGX5ntbSZhZawvWx3z7aoworlDepRcRP896gue+hz
 QHiAbcCDd563j/WD8SJprdmQIkArtj9+gBnQPFIoY1JZtqx1rAqoSyd1vBbjt0Z668CU
 bulT/B8CSggqddKZWV/zS1nAsAojPUdSz9p/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077648; x=1792682448;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jr9B19F+l20WAo8Hz8aSUkGoXAtk268WlHsOUVABwTs=;
 b=iklCRz+C2SuCuodCGa9I8vBn70pWnvm6+w4LwGtGEIKgiDjzqOfWNVC3hdJkoWR0Wl
 V/Rh57ivTQhT7pfncL2k03zOvATFgYyd5/i70G0rWh6MmA+rkwxgA+dXSwqRaA9162cM
 HuM7rzzrV0Er8MZGSPthFKSi0jwVUOznL/3oUd/EPts3HB2JGkHIg6Ckc9byV5Lzo3rR
 rRP9ss4RtKXc0rqpkwK+Z/6Yp2pvRZ8SQtN1SYtCNwiLMUebwY0V8nbE5IhAyKTKbZu4
 z2vd3dPOZzCyZOPS9WNiIvaOjp46Kdai2DC44doVnOzm8KH75TgCSP+LBiwg7v0UUClV
 4JuA==
X-Forwarded-Encrypted: i=1;
 AKwUvByOBJJiyM3erx34LY1f//h1cLFkwgvhoxzBVZVIUIZ5aT3xyCGvUirrrRdNhFh4yOQs9m+QZEU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIZ6oRTs7iwyP3TJ73aClKzw8vTYjPISaZycOqmzpqOANu34tt9
 hj9PZNhU+bzprqr3jogcRaEROcHNoSWkcREKzHmNp/M6+9cx8GfW6nAUZm+FrZiTg70=
X-Gm-Gg: AYBFou2dYbxNJKfTigFCvQX80/1YsM2K2m0rgmxGudJeR2tahA+MMpLoBeLuBPegVHe
 be3VKv7wotn9/HCYdQcvVIV8KY8vmJtfaei9x9PoqKAVw/N/XcNQMVy2T+0y6tGZbrddJdAagaH
 Xk1lM0DLpk4FNYUABD7hHH/+UbDjgd442WyUCtNbrWTrlT1eQcC1YXibvOeSzZaW0Li4sikfNOj
 dXMI1Y7tTes+QjcViIHNKfj067efOMxOdV6iR1vgp81N7NMwwMExIT3gbD7cAJh1UUWeHCreTZV
 46D/XwTZwKTV1uf/V/FSkcuWno2+0LxKNyhQWgmQM2mms9ees8WcY5in+PB3H2oLWZPKWriVGCU
 +ou5drvUjKZBUdd9werZ1IiX0WNAkO2mB94jiPQnDmEZ7ghcUDvFquQO1sQHBYR8MmQ7uijt1gk
 zC0ePr/CF8qgUMfgcLeg6K0xC6F5Z16IfSvsIG5CwzFlR7n1qbbcsj/syCxnK0jsF/7dcJ6kX9q
 ngFuBmlpROhn960TW3xAvLwXlzjy/FQItqcRV4mCXmG6Cwcsf+6Etb33x3HKA9SorxXBQxEFfzc
 HP4oVitiEv8TZdQBVnE=
X-Received: by 2002:a05:6830:6816:b0:7fa:ac4f:79d with SMTP id
 46e09a7af769-83097c62d97mr20399385a34.25.1792077646946; 
 Thu, 15 Oct 2026 08:20:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039076dc3sm19325155a34.14.2026.10.15.08.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:20:44 -0700 (PDT)
Date: Thu, 15 Oct 2026 09:20:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
Message-ID: <20261015152041.GC259661@bill-the-cat>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
 <6f29a66d-1425-4229-a762-2dbc02fd0dd1@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DG5oAEcHrENgeO2Q"
Content-Disposition: inline
In-Reply-To: <6f29a66d-1425-4229-a762-2dbc02fd0dd1@siemens.com>
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


--DG5oAEcHrENgeO2Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 03:55:03PM +0200, Ludwig Nussel wrote:
> On 10/13/26 17:01, Tom Rini wrote:
> > On Tue, Oct 13, 2026 at 08:47:48AM +0200, Ludwig Nussel wrote:
> > > On 10/12/26 16:44, Tom Rini wrote:
> > > > On Mon, Oct 12, 2026 at 02:26:55PM +0200, Ludwig Nussel wrote:
> > > > > [...]
> > > > >=20
> > > > > When I developed the patch OF_OMIT_DTB was "default". 68e65953400=
 changed it
> > > > > to "def_bool". Would something like this make sense as a fix?
> > > > >=20
> > > > > --- a/dts/Kconfig
> > > > > +++ b/dts/Kconfig
> > > > > @@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
> > > > >             disabled in the board's defconfig file.
> > > > >=20
> > > > >    config OF_OMIT_DTB
> > > > > -       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
> > > > > +       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_QEMU
> > > > > +       def_bool n if ARCH_QEMU
> > > > >           help
> > > > >             As a special case, avoid writing a device tree file u=
-boot.dtb
> > > > > when
> > > > >             building. Also don't include that file in u-boot.bin
> > > >=20
> > > > No, because commit 68e65953400 was fixing how the symbol had been
> > > > misused over time. I need to understand a bit better about what you=
're
> > > > doing here next, so we can see the path forward. In commit 99df7f47=
1551
> > > > ("arm: Drop unused dts files") we dropped the empty dts file that w=
as
> > > > being used to generate the dtb OF_OMIT_DTB required.
> > >=20
> > > Qemu provides it's own dt at a known address. Normally u-boot would j=
ust use
> > > that. The purpose of the series is to make u-boot check fit config
> > > signatures though. In order to check signatures, u-boot needs the tru=
sted
> > > public keys in the dt. So in this scenario we need to merge u-boot's =
dt with
> > > qemu's.
> > >=20
> > > Maybe a better fix would be to remove OF_HAS_PRIOR_STAGE from ARCH_QE=
MU?
> > > Looks like this atm:
> > >=20
> > > config ARCH_QEMU:
> > >         ...
> > >         imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
> >=20
> > But then we would need to provide the whole device tree, yes? I think
> > this ends up being a tricky case because we're on QEMU for this. We're
>=20
> I am not deep enough into the topic oversee all consequences. Something l=
ike
> this maybe?
>=20
>      -  imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
>=20
>      +  imply OF_BOARD if !TARGET_QEMU_ARM_SBSA
>=20
> How does one get u-boot signkeys to work on real hardware that provides a
> device tree? Or is this just not a thing?

It would either be in the device tree we're passed (OF_HAS_PRIOR_STAGE)
or bundled. QEMU is in the funny spot where it comes from the prior
stage.

So that I'm clearer on the use case, is this about testing, or about
using QEMU with U-Boot in some other case?

--=20
Tom

--DG5oAEcHrENgeO2Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatDvRgAKCRAr4qD1Cr/k
CndCAP4zrH7V4wqVePkWSqgdVX4tVEQGlBjgmHF9ZnT5LqrK7QD/bD+c48fbu2UX
PPrwRvHqhOACNDh3abEohlL8qWDakgk=
=09sZ
-----END PGP SIGNATURE-----

--DG5oAEcHrENgeO2Q--
