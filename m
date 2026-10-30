Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA26606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wX9beOaq;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=EYh7eT3z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1F1840D9E;
	Fri, 30 Oct 2026 14:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OMPEL5JKYbwd; Fri, 30 Oct 2026 14:32:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C74140DB0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793370732;
	b=genOsmx/5oSePV2cj7gbH+IqbkN8ex7x0uCkSF/KYShQN2xAfvgO7T0RheCMPgF46809
	 l1EIiZAQ/GXMD30Nh0y6NOUkfh3aPiB22BplOKbMACy7eVe/Zgc3RFhHwwThCan/EvFtQ
	 USgSxLRpMcdf0PDhfp+aAJ6t0jH2XF9/CdJwmwvgmwmtUXNZryGPb67sodm7xMkBPN4bH
	 50N/xMJoZZaxXXIq0MdMh688xa2JmbxOrGhLc8Beg39XBFc+BuQ5bv3KEE8Te6DDfmrY9
	 d0OebJL4EhfqV7X9o0NclnLmdM4A2bkmwkcuH0oXqLwOBybWRvw5/QAn1M83DCVLIew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793370732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=37AxmkceXtcSt8UL9ePv7pq+6agGcXQvLVfXuH2V4g8=;
	b=fPBaEprU+p5hyPyzEMnvuu5XRwA7XaYPQ7V9rxm1Wc2QaXVe35nJJGcAaSK0MaD97pmO
	 Q+cn81EIT7b9C4c1D4FKLvddspYNST1Jfu44nDuTtl2S/DdI4/6mW6EUEGswFu+XBj4yI
	 Pptn3KEz6QDo2+8A3c2GkP1hqb/Zv0ApZuNHMa9ACgDCHdKCX903gwy6NTy2h1efyB2Mq
	 VBXC79QZ4LS1sWK+zLVnHyC1orCDdpH4Zs8OhuVo01jaEaefXYT5aT/m3vvVtg+wrpu89
	 ooros9JYHP48VzxwxPcPw/JGzhjfJtFk7Ei0bxsG6xjFChhSMIkiPQ7rOmZLR0JIxtw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=EYh7eT3z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793370732;
	bh=37AxmkceXtcSt8UL9ePv7pq+6agGcXQvLVfXuH2V4g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wX9beOaqSs0TzHaQuyRwyMs5smQufICosfX/QeKHYBmrgA8VlBQJaQ+nrh8UWxWse
	 5qAY7kqlx7Klo22aPwpfPRrWuK2TbPj8hWCkESNR2oh7i0yREh2FbbfWgaJ8ypm79h
	 fWrzx2iHQFM3zGnD8/vj1nsWHQSdnCEg4eF/z1fehhHI3TBP+ckiekx+rWeR2KFil/
	 1iRELkQMENpqlQauZtI7oHjEuR4kUbfyL9c+ku96mDTKOXVkTR0tZRHgaU+XSbrSyz
	 mLq3DCRM1b1lU2sshd6XSCL+6+Lwntg2KT9u2fJq7v7PD7DiP13UI9Taoa8lMXTV8E
	 jvXDdvoH5RXYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C74140DB0;
	Fri, 30 Oct 2026 14:32:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D83A4D38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA0BD40DB0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:32:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EszaMIJWoKsb for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BA4540D9E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793370730;
 b=smUSik2/WgxeXh0fw7f+/Wxg4E4o9Ep0bEVjO0YLSQtRlaW4geofqLFaRSXQTo8Oow0l
 88ovdsndFcjI1bfu6Wh6oniIuDgHRVSf2wHUFYFbCxyTQAyfA1JeFSItmk1R3n0xsRg2X
 yoJJnA7BiplX6bLhfFOtZSjLf+ToE5knaoINkGt7MbYr9EpEnbo72tVzBW2Zvo9XVhI5e
 m3p0x41kSVYoDHTW9A5LTfpGWP/bR9dBfgfxGfi+xqLgPg3Z9xvQtu0XIB4qACrJASg6K
 QGz1dvmnlfu6DFvERrbpMVoZId9IKfMr60OCn3iiMQsqUuJ0JKi9Vqe+EHb7wYIldHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793370730;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=37AxmkceXtcSt8UL9ePv7pq+6agGcXQvLVfXuH2V4g8=;
 b=G32KSMXJJCEGitOFi7X/Y5wrBhaOhKat4y8ZjNXlGbLCJ/lYEi88mbYQYwFQfqxKV06C
 dUs7g/sVGqdm44bc+RR/XdEOqh7xkOlxdnvHhiD9tAKcjVsgEe0sT6Tb0UmpfudD/iXWr
 kCVjULyTVtfCt8LLYYReZe77PGrPLlL6hVDF8uw0JaB60QnY70On8Dj3V9RZbH4U7K9n0
 NjPFFrc2QZdXFs4jLvISpObeY/ovRwooQT9ghMUR/R1f1MTbmXAHrMpblOSgYD3G2zbgT
 4SVb3ovybpI858WKrhU7pGYbKv57JeIWmEZoVv7QBTsJAg8oDJWGywHQyzZtuy4eF8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EYh7eT3z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=EYh7eT3z
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BA4540D9E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:32:09 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4b190cdc9feso505668b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793370728; x=1793975528;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=37AxmkceXtcSt8UL9ePv7pq+6agGcXQvLVfXuH2V4g8=;
 b=EYh7eT3zolWNMhqK1LE1j6N6Qks9nXe1Qr7ajAjdap6P0567ad9SR8mLB7UD3xFoSg
 25FzqWwEZ2u4C519eoBCGZxbQHu+KsJRMs1WMecDF/NPh4ZctUbQ/syUk51wGhZuOC3s
 gre5GDw9CxUAdVDbYB/AmM4ZsvXZi4Mw5v5gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370728; x=1793975528;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=37AxmkceXtcSt8UL9ePv7pq+6agGcXQvLVfXuH2V4g8=;
 b=KVjgs3MTA6fzLyCBOd7G7666/psclUyCo/uQtBbQY2OoAEro55RQa3y02x57Dkgs9U
 /oGWluLHQZmZfT/c1FtxZ5cLKx/BitGUOvaEheMTfuQVJlkmr1hr4Lsrp+IsXRxuVKUS
 zSftow4vq2FwHB3nB6Rn7Z7FVVZ+wEc1yzdtsvwKHoisiSC5gWe2C8LeUvQzXCIBvpAW
 wyjQARy/Ek+7X6pCtVVEuGDRlr6Xvnfr0V8q/9Qzvz2C4GQliGqtC0wx8fvhBtKV//PI
 hztEh4Fdz6kBK69A2OHGwksyaL2dIj1h7WxvXu/ZRQTV89r8CoO7iV+CkgotLyQQBJzt
 YgBQ==
X-Gm-Message-State: AFq9FYI3seME3ZG1j9orzA4s4xQ/hpkOezaVHEOWc6vJRXd4MKr5WLdx
 d/MpL2j+FmzvOm3h+zDtwP7dedaGPZQEGwpxb5VXJdzC8Nv8JA69x4olMJBLeSw1/4c=
X-Gm-Gg: AYBFou0ooDYYRIxDnBTEo6s+muQkjVy+KuQNCEFZKvz/+KFESvtDeMBFwncvr3w3zdr
 J67Fx7b1MUAAjukFcnV3zbUjyKNlANIA2JH605rw4Na4+WvMp3PI9IrFo1McfXQFXjKFeZHNbD8
 Iy7NAq8kWmyR0b8SzjJ3Ui/HsBbbSbfMppGRIq/F0vDJHc5lGrtdBNWcfQDjeCn3M+SWnR8AOCa
 tVfHrMZhWBFkhQ/wJSXzJC0vDQ3RqhNbsDYs9GhPMtLILVNjj2V8mOZ1okh/iInAnw1K7MFGmOy
 DyehDqXKzYix02m3/g8R7JnfdSL1qM3yGj79yicWVTXQHHmakOQpC/l5l7tsCcAxHxsc3P9gU6p
 t1eiaa4bLn+rUoy4Y/ghFuxqenICDHd0tCMw3O9OJy93zb3TVWhMJzpdB+xT6UQo10aBBTOKR+m
 BVHdfplRh9X43NrWa1fnPC1q0wzMD0Xeml4bVlZ+dvXhg1URldVxgI9iNSn0y7lLdl1T84KXj3L
 Poc+QiJp5IKss7UY0HE5wBf7f0OG84/A/2HBZRcJsi/kcmh8KZPY6ck0hN2PVotu+wNqcpqWL5V
 3xegaZfF/CBbv6ELvGGs0MjxKyI68Wm1kcmTgJb6dISD2sUmpgwTIeg9iGa285jNwRnZGXO5m6H
 MXYw5IMFU1Lm3C3s8H4rRhQsqNIC3MXN/Kc4Su/0e3uQkjqIk/AI6BrnG8GJi7lR0V+pi2GxJb8
 UTdiSDztG04YBJvcjUBtfcA+cr3AMyK3Q=
X-Received: by 2002:a05:6808:1522:b0:561:fa43:1b1f with SMTP id
 5614622812f47-5640ddfb108mr1647607b6e.41.1793370728360; 
 Fri, 30 Oct 2026 07:32:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fe0d46dsm1666726b6e.11.2026.10.30.07.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:32:07 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:32:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@oss.nxp.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] pci: layerscape: bind LX2160A rev2 aligned with Linux
 kernel
Message-ID: <20261030143204.GL3011578@bill-the-cat>
References: <20261028145705.2407296-1-vjardin@free.fr>
 <auQ5P0e4Fn-64cyl@L30177.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/gZeuOyJ9l6SEmPj"
Content-Disposition: inline
In-Reply-To: <auQ5P0e4Fn-64cyl@L30177.local>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--/gZeuOyJ9l6SEmPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 07:29:19AM +0100, Vincent Jardin wrote:
> Hi Peng, Tom,
>=20
> I am not used with uboot release cycle/policy, for such small
> case:
>=20
> > +++ b/drivers/pci/pcie_layerscape_rc.c
> > +	{ .compatible =3D "fsl,lx2160ar2-pcie", .data =3D (ulong)&ls1028a_drv=
data },
>=20
> since I posted this after the -rc1, should it wait for next (v2027.04), or
> could it be considered for v2027.01 ?
>=20
> It only lets uboot bind the LX2160A rev2 PCIe nodes of the upstream
> DTS, and no in-tree board is affected, so I hope it could be acceptable.

I'm fine with this coming in for v2027.01.

--=20
Tom

--/gZeuOyJ9l6SEmPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauSqZAAKCRAr4qD1Cr/k
CjwNAP0T2nxAkWJ6iw8UUn3ptLd8hnjn1XTDsKsVuOZDrcdMMgEAuUtX9DrqXYXf
Ws9VN3I1hfc9Xjv+YSHqTJeuOEbOeAU=
=HlT1
-----END PGP SIGNATURE-----

--/gZeuOyJ9l6SEmPj--
