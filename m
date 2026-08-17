Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D07C5DF74
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 21:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52F9980C32;
	Mon, 17 Aug 2026 21:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUwpdJiLk6xo; Mon, 17 Aug 2026 21:22:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66D5E810EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787001734;
	bh=2r6ifILCBLoxHBxO1RWGG0yHZ08GN287IWY9p0z5ncA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y6YXevwwBdC7a+0kilp7QxTAOTr6cpTMynOlBtrtbg4Os5fSAyQNI/cqttASPy2mU
	 GH7VGGbjUSpymjCP+QHhljgkzxZaIg902vfgyUc6z6WJXipHZtMt8q1y3tUmU3WgO9
	 UiSpGQakMA0KSW+o/ssJRA6scpO0PZlGRL42pxsp4wuMNlF332RbHzU2Egkj+EOKGh
	 u2oy3Lc5h8sIkvlovO3fI0hB/Jt8dEk1Fd30NgEpGiWsvhg+IWgb/ceZg9BH/baMQU
	 W5dqOYXdoVEgL0qSO8n4ugoroZ+JEOukZuV89FWWuVum4b/O/swup4/o6Lks0DN7Ti
	 EIc80NIavYGVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66D5E810EC;
	Mon, 17 Aug 2026 21:22:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BE584194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 21:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8401402D1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 21:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vPci_y248CzF for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 21:22:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C6B18400CC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6B18400CC
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=J3FflmV2
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6B18400CC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 21:22:11 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7ee4399c3abso2585058a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787001731; x=1787606531;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2r6ifILCBLoxHBxO1RWGG0yHZ08GN287IWY9p0z5ncA=;
 b=J3FflmV2yVcXQNcxudzY5jD0LznGzbzu9Rp3mGznUYl3JxmY4/XRjIJyDt21hyfYkH
 xh5BcQJ+4uoxWVZIBRY4zImcIHPGgORyqFGCxeDcCD1ZiT0dPwS/kotbj3gMBewC2FVd
 SMByc7ATmlGexy63wgabaSZE2vHPlY/NmS8L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787001731; x=1787606531;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2r6ifILCBLoxHBxO1RWGG0yHZ08GN287IWY9p0z5ncA=;
 b=VW5Fcr9SLW/xlC9AZof9jkdoT+eGmWobK96ONVzOjSJWeBkeiKGVmMCX8Y7Nrkg5fN
 TtN9PGjMMx6dgvmzC4jLhPYfUj9e5qhS48GylkNK7nsY3vnko9U+fGfO+ZG0hQwpRi8e
 OQYehDTgn5KRkEPBn6uiatYRvrOS9W+h5PKJCTOZGLol9ZW16FKwpqsuCAAod2i7G0VJ
 G6NM9u0tAlRQGzqT3RYA/yq8LMfe4CStJi7gerDzhQ23BE5R0at/YAlKqUvAIsyxrXT5
 xLXJPuiTaJGxnfWyBK8WdHo4bwDn5YYUellrh0tQ2z2WwrfjojfQtLb4YO2RWi/hqFgW
 dIiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcgOetSQBtMt4eDuh0WsA4CWRYSgPz4DDztW/JNNZs6vJ4DU2KeYn4g/HTeli2byC1OZwJxAs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyScSpQk9eFc1CCKOZYEPsZPkAXwSHGywrOsXAFkg2FtqJ/hyyI
 844I1TIUUzQqru2TMS8QNEebzeAAquAPzblQq4fu5Kj4Xq9/tZ+dulfj9JNLENYnvzw3mlKjbLR
 e4O4IHrw=
X-Gm-Gg: AR+sD11C75GT+LKMMPXr6JSYvRi5gdVzOY3uAZNsZfqYieIBSwwzLjUFCPP+cHhI618
 D03UhI8boBNh7gN7ig7647ctMDt4clO2UES2b4mAgaaHeOb+R6dNGZgcriVqkRDWbOJnufKQkmX
 GQ+EJo9JtpfOhsY5IjR6tyA+wvj3nK7rbE3MuNIo3xAIbnx+ZgjWTBusVlpeA+YsEgajULshsYl
 3r3KPX3/2vaQ+pDmNVljjQowMCUo3mHKpssxTahGulYP5LFBtkl3ndasVCWOymR2Sedbk8T40YC
 Fj3/hug7nP2gdZpKMx1RpbvjVGay+bsdaDM0/hXby2q3RwLja3mUkNivqxMZI10EYFRn21gkjy4
 w1iSJG6IdFLT9Wsmoyoys7sbe5A12SMfpxLESHo7FWmzWSQZAUVPjr9v2wiENJuPzGtUnDHs3Wx
 LSGK6k3HFquSM0hAv0oF3YXQ6s3XiywpsFnZndI5+KuQZKFFZA/u2tfjK7RyoDpG8Y9UeUK9Snc
 cD8KwUR8tj/1im3Q/iad7ZTPMdL3IJbhIos+Foz6vQQvnxfG3gbSkDJZygwT7SXhw4rpoyReh6F
 1bF0a3EVAyJYie7LuCDFRWYuXOb4KYKj
X-Received: by 2002:a05:6830:7301:b0:7e9:f8e8:d905 with SMTP id
 46e09a7af769-7f3de66d149mr31011638a34.16.1787001730724; 
 Mon, 17 Aug 2026 14:22:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f41bf2c916sm2689115a34.9.2026.08.17.14.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 14:22:10 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:22:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Gokul Praveen <g-praveen@ti.com>
Cc: n-francis@ti.com, a-nandan@ti.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/3] Semi-Falcon Boot Support
Message-ID: <20260817212208.GW3297518@bill-the-cat>
References: <20260814102153.44487-1-g-praveen@ti.com>
 <20260814145645.GJ3297518@bill-the-cat>
 <26cefba7-df22-4043-9383-b5451ce7cf95@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DU8z1J9Sba8a8MlZ"
Content-Disposition: inline
In-Reply-To: <26cefba7-df22-4043-9383-b5451ce7cf95@ti.com>
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


--DU8z1J9Sba8a8MlZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 01:46:10PM +0530, Gokul Praveen wrote:
> Hi Tom,
>=20
> On 14/08/26 20:26, Tom Rini wrote:
> > On Fri, Aug 14, 2026 at 03:51:50PM +0530, Gokul Praveen wrote:
> >=20
> > > Semi-Falcon Mode is a hybrid boot approach that bypasses
> > > the A72 SPL while retaining U-Boot in the boot flow. This mode provid=
es faster
> > > boot times compared to normal boot while maintaining U-Boot's flexibi=
lity for
> > > kernel loading and system configuration..
> > >=20
> > > Boot logs link :
> > >=20
> > > https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557=
627c
> > >=20
> > > Gokul Praveen (3):
> > >    configs: add semi-falcon mode fragment for k3 devices
> > >    arm: k3-binman: add tisemifalcon.bin for semi-falcon mode
> > >    doc: ti: document semi-falcon mode for J784S4 EVM
> > This is just doing what many other aarch64 platforms do, of skipping the
> > SPL phase in Cortex-A because something else has already done any
> > required initialization, unless I'm reading all of this wrong. So my
> > feedback is:
> > - It's not "semi-falcon", it's just "no SPL". Naming differences, if
> >    any, should be done with that in mind.
>=20
> Actually, there is an SPL in Cortex-R5 which is still present in the
> semi-falcon bootflow.

Yes. But it's not "semi-falcon", at all, as "falcon" refers to booting
directly to Linux.

> Its only the Cortex-A SPL which is avoided, which is why I did not name it
> as "no SPL"
>=20
> *Normal K3 Bootflow*:=A0R5 SPL + TFA + OPTEE + DM + Cortex-A SPL + UBOOT +
> Kernel
>=20
> *Semi-Falcon* *boot flow* is : R5 SPL + TFA + OPTEE + DM + UBOOT + Kernel

Yes, and this is similar to other platforms, where the Cortex-R or
similar isn't exposed in the same fashion as it is for TI.

> > - You should make sure to structure this so any K3 platform *could* take
> >    advantage. I seem to recall part of the rationale for the current
> >    approach is that some variants might only have a little SRAM (512k?
> >    256k?) while others might have 1-2M and so easily fit U-Boot in SRAM
> >    prior to relocation. It sounds like this specific family has a large
> >    enough lower memory bound.
> >=20
> Yes, this is structured in a way that all K3 platforms can take advantage=
 of
> this approach and changes.
>=20
> Additionally, as there is an SPL running in cortex-R5 even with this
> bootflow(semi-falcon).
>=20
> this bootflow can be used on all variants irrespective of whether they ha=
ve
> less or more memory.

OK good. Just come up with a different way of describing this that
doesn't say "falcon", thanks.

--=20
Tom

--DU8z1J9Sba8a8MlZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoN7fwAKCRAr4qD1Cr/k
CgOyAQCBrXlklFYrHX2TsDgzS11Kda1zlEFvCnqSNUGLoBVSWQD+L1Q9KWFVhY38
m24/RYb7KCPqWf/ccKTjWcQd3FdscAg=
=i3XT
-----END PGP SIGNATURE-----

--DU8z1J9Sba8a8MlZ--
