Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD664606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zUvOZD7J;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=fYIEXpyn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3E7440878;
	Fri, 27 Nov 2026 18:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPCXJpfNTxFZ; Fri, 27 Nov 2026 18:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EEDE940898
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804522;
	b=mEtBKa1UBk5ZplqTAITeSbSCWfmFZ0sYFx2r7OgH8LxHdVk+gwey3h0ByJoaCZHqy9gm
	 qVjbSb2wmloy608woHtSRaRrgrEsqSvmaQGSr9AVkg0aPkNcq/nS5r6IvioyKC8bis+oI
	 qQ9o3gU52rKmT03o4I87Go/EBx5dblJanF5NYb97GGAUUWRDS7JdJQGH8B+i43kpe2OdI
	 3IhOyRb7yFtOMMV/EGdHZY68tlJs8agOXZH05x09iT70GO0avKCIpsPyR3pV6bH2i1nR+
	 Z2BUD9JsDgVPeCK6hl5HAzQ2CKhx4S0epBCc5EVVnG6MByv/5wrta3bziJOvbJhUwrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DvQ6usoeEmEL4Mpj0YYOx6H+82oEo6wv4JoOuF5O5bk=;
	b=FYjEn+zRpQs8qXMtCohRWlFYvq/UVh1Lhpe+6PkizBUyveZxExmOpnYxvuNwhxQ7fj2O
	 7i9ZB8X+vjqE4/VofgDA/YsbJF/O+Iy1GDt9zqFEu3F4jCNN+/TCc690hvc2D7fe8NVAM
	 A1WVpXYRIoJcsUEb/uHn2M7/UGHDfLHPh0mh7LiJ31MuQX+WTPyxUEcMTRD4jZ6GGodBz
	 LfzABEeGs4zlG0O6f/oyEBoU8FfoVlHu1mew9n7kLF3kgbyoaavk5luOY7pom/XfJqZmw
	 xwZkqvFDAIB8LmnHh6zav6TtAY6x72lTNOe3oW3G6LjdUmC8Pm4R9xbdsC5TUZxbVUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804522;
	bh=DvQ6usoeEmEL4Mpj0YYOx6H+82oEo6wv4JoOuF5O5bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zUvOZD7JziThkbPzoe/VI9ClKd1gyCwgcLHlcvlkJKnO/jQ1G5T5mWVjHgVrh0tqu
	 TLQgv5MnDUIu7Sdf3zEuqlJanBgaq64mtVb3V3TKjvasn6gWnUBNwVU5nDP2khBn4b
	 MNc7viu/fvv1cd4UOgEsAbWedel0pJXKBcqcFSq4WfYxIn4/XoaVipmC24xW7MJT+N
	 iezJaPL90eV2PM3PHz6E98U3p+ZovGvV5+v5+khNOQjPS7JToxqSdvVITELfpUMnVc
	 lB3xfcxy47cUUZB/UM6VCCu+dboKRxYMwXacJuT8IFliUPpGFoYfPVdk7YddDwLhRJ
	 F4vw3O9y37VUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEDE940898;
	Fri, 27 Nov 2026 18:35:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B4D8F3D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B0DB812F9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWR5nkKumPpN for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D5A86812A3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fYIEXpyn
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5A86812A3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:35:19 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-844a8bf7e25so4540405a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795804518; x=1796409318;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DvQ6usoeEmEL4Mpj0YYOx6H+82oEo6wv4JoOuF5O5bk=;
 b=fYIEXpynOStTlGVTICmM+XV2PuqVgoPAOqNn4RDiiRaNQEtpU4zOA+mgjil/4sNxoO
 V1iwwnnSuHkjHPPtNf1EvHcjY0YMcnV+6cM9YomPlss57CmPEZ4x4enQemxKMf/yoTfU
 U5Ebsx8lZR8dZ8nJ+QFNaZBj1aRyqKFb8+y4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804518; x=1796409318;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DvQ6usoeEmEL4Mpj0YYOx6H+82oEo6wv4JoOuF5O5bk=;
 b=kEf/isY8DVrKkBUBesrRRa+QGnDc7/ka57afyW/S08ZjkRD0THzlyklwO5BvOct9Yw
 CPCEFbKFkeeFuULCmHkllRh3Ni8gaC7ZjlQXJz7+63BOQWAaJakwsSVbKR/dmUBo4Z2x
 RnD7YXEeb7a9FrzWGcxILwmNmaRh0aFOLijvg7DFRNCkzGEnhe+mM5kJJVyK28fyz7zL
 DuuFCGQE0feSpmfBMyJQL+3frYTth2/uboxqsoNnRpNqNZpo3w4Jvamp/XOjsLN3PDP4
 j77hysd35tDbufZ3nGOmLRzh8I6uOGYawvHrDJhwqHgBnfSsF12htgwyI/VwCaOZOHE1
 tXmw==
X-Forwarded-Encrypted: i=1;
 AL+hErHXiPEEYhMg9WuejA7tf1LdTfSa+z53JTzAQwlPsyu5okKWYnglnVcR+H084+3xHRwieN6rvw0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9IMEsni6/PdilMSvPMJvhzc3NRG+jtsW5GKxBgPZIn3SkSECUF
 dwc1q5HCuOMPngX1fnrKfhMAm63L9AydUc81Zjn6vLlP9/qnikNVHt8RHNC4RcM/2/VOgxAw+3r
 mX8QvLqw62kXc
X-Gm-Gg: AZFdTZcsdY+fgUld9AMG0BFPuKNpsA8ilzrrPhOqyCd/Fb7fB2mUCFJZJ0D4bNgopXI
 b2e+kHwFtYtaNA9qcjG2aITwF2bK/EctSa4x9vFpe8aHXBgMA3AS8ofzXz6vMTHfgGNyvhctBf1
 IZl5Z7cKmV4G5spQqD3/zYRjxmfOmk+cfH2iS342B+2TTYEBHjUHewpIV9xxztvyhftOLWXCcfI
 YoMYifRZzChNtasDPCDmXhSz9ZqE3Sgby2HCZaKAtXAJweWmvIbu89U/ntOa/2pXHoxDAsm5zlK
 AWQVwirdwxM7cq8B+/vxStQIKuhEAzI2iOeZppvju928mk0p00NCI/AvK/GhmcuUr9W0bjsQrXd
 hWzJ0c2RYYztO2bVJnx++uPptWfQ5WD7km0MOYdUlX/bE80g2kaFr535IArSS9TOAbrEyKYaK8b
 GoQcJgqHpxYRSxB7obZDshCsnC+DWgblFkYSkiyGLViBfDd17DzUQdfH+d4y0AKckszCUCyRHC7
 SR6+QRZDMM7ug1OFIZzx5d2aalAflYv4t9NIQpF/g4yT6SxCgpKveOhSx6jxIh7VJx+ejoAADGD
 uczu7dwX1/FdEWRzKx30gyZZ2NlvGnA+KQr8IwGtZPNLvPgfjafg+ofdp6cqge9GoZO2BNRE068
 rR8WsiwmX4eC6Q0cu+lvSPvqvDU5SmQE/HNn/3gzOEn06eibbrk1waRbmWZUtIQWIvkhKfhuitb
 eb/+LnOo0VVMi5+7z1CdeMjqjitsjsv5s=
X-Received: by 2002:a05:6808:151f:b0:576:b73b:f273 with SMTP id
 5614622812f47-57a0a404fcfmr26539324b6e.21.1795804518459; 
 Fri, 27 Nov 2026 10:35:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a35c5ac5dsm19321710b6e.15.2026.11.27.10.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:35:17 -0800 (PST)
Date: Fri, 27 Nov 2026 12:35:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, richard.henderson@linaro.org,
 casey.connolly@linaro.org, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] arm64: relocate: convert relocate_code to C
Message-ID: <20261127183515.GO3176972@bill-the-cat>
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <ddbf51b3-7b66-490f-ba99-88209bced490@cherry.de>
 <CAC_iWjKfbu1JTCeWDwOG36DkvCTdc0hE_YFWKDgkdhSCmsWZHA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WWZlYQtQF4ObmZzT"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKfbu1JTCeWDwOG36DkvCTdc0hE_YFWKDgkdhSCmsWZHA@mail.gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--WWZlYQtQF4ObmZzT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 07:11:13PM +0200, Ilias Apalodimas wrote:
> On Wed, 25 Nov 2026 at 19:07, Quentin Schulz <quentin.schulz@cherry.de> w=
rote:
> >
> > Hi Ilias,
> >
> > On 11/25/26 8:41 AM, Ilias Apalodimas wrote:
> > > relocate_code() on arm64 is called from _main with sp and gd already
> > > pointing at the relocated area and lr pointing to the relocated copy =
of
> > > relocation_return. By that time pie_fixup has already run, if
> > > POSITION_INDEPENDENT is enabled, the image is fixed up and plain C wo=
rks
> > > fine, like the rest of board_init_f(). So let's convert it to C which=
 is
> > > much easier to read and maintain.
> > >
> > > While at it change the behaviour and order of cache maintenance.
> > > Invalidate the I-cache after the D-cache clean instead of before
> > > and add a 'dsb' between 'ic iallu' and the 'isb', which is the
> > > architecturally required sequence.
> > >
> >
> > suggestion: can you please make those separate commits?
> >
> > That should help us if we ever need to bisect this change. If it was
> > only in the conversion from ASM to C, or if it's related to the cache
> > changes?
>=20
> Yea I don't mind. But given that the older version was wrong and this
> is the sequence defined by the architecture, I was aiming to have it
> correct from the original commit.
>=20
> Tom any preference?

I think Quentin's point is valid, and correcting the order in C,
afterwards, is easy.

--=20
Tom

--WWZlYQtQF4ObmZzT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawnNXwAKCRAr4qD1Cr/k
CmjGAQC5jNTrK6/6XnHeJUmSLGMlwarkOnFZ31B4nm/nNs/e3AD+P5vDC6/yPFxg
qT5wWjnZrIX0gIdyzFpHcQtV7lXJZAg=
=P9RR
-----END PGP SIGNATURE-----

--WWZlYQtQF4ObmZzT--
