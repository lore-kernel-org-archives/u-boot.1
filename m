Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD78606BA24
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RdNu+oo8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=sdBlynWk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30922607F7;
	Wed,  4 Nov 2026 20:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p3UmdS-6k9ix; Wed,  4 Nov 2026 20:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 763206074A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793825008;
	b=FMFCQyclBq3ihGEt0uYVuLbOIrpsgKVnsWxcgKlcDkhay9i7ORO4d8F+2f1CBDCox+4A
	 RCZiS1qFBQ6jNMcodmr9AFYV6umm6v5LcrAw5fcXtDTlyBfKq0K6VIl8M6YCN+yFVe64I
	 fBdCxZJqsGLZeBS+3UIRy+yhfegextT7ZlX65M5As8BEt2ju/kRX+YvHJ3b7LDvvAP+Hy
	 nkrvdhva0MWa9Tu2+3z+IKpe16kBCuJA721efpwezwuhvH1Ko8Ky4XkfT/b1RV8YIgRYh
	 DSdHMPPQSeULBtD4eZQqtFHkU/rnnkQGrgkdabicBckqZaOMGQTv/XoJ7jU6svPFYkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793825008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qfVtbJM4LNE40Ru+j72mPHNziiU+zHiouX4g3ERKr7I=;
	b=XMF7DjBf4mUGm5vuMMya6fXdpAr7kTgp4oadW6kvMwsBq85SBzi+BjJuF87SFKKmrSy3
	 9md1KdNZF93IXFPqXkT/ANrWAFXk0nkU3IFHxHA2ukLuGUJDlJ78c1GqhyfaWCY8GDBXl
	 wZ89vmi/xbGP1qETz4QIFePge1o1Mq/YXmjjy1eyZeDT3jIUZvKPfR1+zZxMfFzq4ND4U
	 VKHqQpK8Q5XWGDvsf7W2HhJQQ8WSSemCINvf8i2+VlYciKXhhMadPUwcxVzg4jN3B2rcA
	 6ccIgyox169CUwcDfHj4vXZwYnvmUlK0jHfzQY5Ff4ccoIkcLHgnAmY8u4ChPjmEv0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793825008;
	bh=qfVtbJM4LNE40Ru+j72mPHNziiU+zHiouX4g3ERKr7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RdNu+oo8uuPE5YCegQ6aM89UQRrR3xAHiwLFZB1Ox5ynVGM/d3vKstGZJvbFge9yA
	 9u6Ip8zqsT1BdSsHEUJYYaz44dqLILrK2yFOAQpltvMEdNETOUVMA79WGX74AA1CFA
	 XDDgrzbyqUDGcSs5bC75iURHzFqb1aVQnWJXCjTV4zqzp2TIFHocLZiVkrGrG/s6YN
	 aVe21vS1WU0BNHBt01gIyCoT4pNGMzKVl6eD35//8ZlaCv57HFJlcDW+v9K0hsI8Ej
	 XmFv8F9O89FQFtp8Z267C8Vl/2eJ9f6VfmF+1H7DZjZWqpoa9HfBoHI4AA+XAntljk
	 mQ/hPGE3cLGQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 763206074A;
	Wed,  4 Nov 2026 20:43:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A3ED1D3A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 955CA812C8
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I9YUC-BpqYQG for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 20:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D7A7D812C2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sdBlynWk
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7A7D812C2
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:43:26 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6de1fd5f572so530861eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793825005; x=1794429805;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qfVtbJM4LNE40Ru+j72mPHNziiU+zHiouX4g3ERKr7I=;
 b=sdBlynWkJfUODre4H1NHLFoNSiv9mLh0nrDYFPwQq0xvnVkXMM+cX4t6v7uxJF2Hn4
 AJ7z+RuUbayTyhCrG5ujRzHdLBviQDsINjEgZhmEZRPYCQGZfLcsPb/mjNNMeCyxoFyL
 I/5jzIxtsqIlWhsjceIRw9lyqfKQE02BmT1qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793825005; x=1794429805;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qfVtbJM4LNE40Ru+j72mPHNziiU+zHiouX4g3ERKr7I=;
 b=Y0eyQAfgCLc19Mysk57PGgPmrj76BQa9Hixk9KOYBDkU9aHH98m8bccwdIpDbNVf+w
 WBNyz6fQf+lIjMPJk8RnVH/PDviLGVtOr4T9wLq1eghKpiy97m6Ebo+p6qtfsbx3fZV3
 UL6oJgBI/gN4qmL2EQv8otzKyaLLzJObHiPAg6CsT19XbI5r9EnE/Y9gyHkZ6odvteed
 wlLMaiYzHgrfoyzXYP3nZxl42N3o2DzJB/S3dl5fCpUTlQVQAWXV1dXKX4/Bl44rtm0Y
 gIX1YUpQ3HAEIiP3T+iNUS2a4lbAqxkiMbVFIlyJI8lutbmZGfMb+iYF34gEYN2e8j7+
 6Prg==
X-Gm-Message-State: APuU4Z9ThtiQyrMqvs+fergpVJOY+1TaOLuaQG2PSL1Q6PBAHh5tsHA1
 OzWoAJlwPpYdrgfAdUP1g31at5Q7rl3ojO9L47RgUJSTdvjhV/JY1BhVXsq6hXymXB0=
X-Gm-Gg: AYBFou3BHAVtOiH3JMfFGFkS6A3MqiFXCfImvrDjTFsw4i8g7dKJLQlqfCRumFDV8VH
 4WJUFUqp1iXUtp7umdYfKFexu7t7cppIx2gZGfUMJKScnoTrK0JYmSvwUIEoMsD1y1lCiWBkinh
 ltvlDoAAlKmJ1rK4cfRUoHo1BWVAmKgwTqL2UUXScOCO9w87c+3tyxtA22AwRSbDFFzY9w/dGSp
 jpBANVZ1DJOll/PagV/+D9PfKUWpsY+MO++s8CmrzhWEYhtYSTLJPGwGY8OexSY8ofLMNOKVkxS
 hY1nGVYKridyiKrThM3HJ6k+RMuKIARA3cAzakyyZ3jrumBODA5qYmq49loNeJJGOVKaHnlkA1e
 5o/Qj2nXucCQEdGN4QarqWWWwp5egObC2NldkRM4LYqHlKA+by6/nfQiLr6kAcTynQh5byiXZNJ
 YD79mCbCi3phssRorD7SEzi7kX07RW2bLMPd6SZmtl6g6mZqC4KXVZCk1gLM8luHC1b5wibHzaO
 /juqLuhUxobaw/TWFw1nolndo59GnTmea3LBeMUcSm/Rd2U7Jq59l5Zzt6W9mYQcrpxPxhApJTk
 Z/A6icRf0zHU7VMFgER0oAQT8rl0wOZ75RyvOlGpk7uHd/aPqh1xpqQLeGeujQ1xuPLnfcrz7Ds
 QKdd4nErUccPUnOcdw4933/lqS5TQhdDmZ1yJr10e/fnOs4s5We34MCnBWhPAxUfPbUB7InwoBu
 KVJZ1238I6ppi0efgqwb02zEp0M002uA4=
X-Received: by 2002:a05:6820:607:b0:6f5:217:b0a2 with SMTP id
 006d021491bc7-714f24b8026mr9796929eaf.12.1793825005322; 
 Wed, 04 Nov 2026 12:43:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4acea61f0c0sm2810281fac.14.2026.11.04.12.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:43:16 -0800 (PST)
Date: Wed, 4 Nov 2026 14:43:12 -0600
From: Tom Rini <trini@konsulko.com>
To: eli <xjmps7114@qq.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/2] SPL FIT software rollback protection
Message-ID: <20261104204312.GA1192734@bill-the-cat>
References: <tencent_4D4A63A00ACB3E875F30AD14C1B8961F5D06@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HJmwJR1e4G60rFfq"
Content-Disposition: inline
In-Reply-To: <tencent_4D4A63A00ACB3E875F30AD14C1B8961F5D06@qq.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--HJmwJR1e4G60rFfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 10:11:15PM +0800, eli wrote:

> A verified FIT is authentic but not necessarily current: replacing the
> next-stage image with an older, still correctly signed image reintroduces
> vulnerabilities fixed in newer firmware. This series adds opt-in software
> rollback protection to the SPL verified FIT flow.
>=20
> Patch 1 adds CONFIG_SPL_MINIMUM_FIT_VERSION: after signature verification
> succeeds, SPL compares the configuration's "version" property (covered by
> the signature; missing counts as 0) against the minimum and refuses to
> boot a lower version. The default of 0 disables the check, so existing
> boards are unaffected unless they opt in.
>=20
> Patch 2 documents the mechanism, including its trust-root boundary: the
> minimum version lives in the SPL binary itself, so this is a software
> trust root only.
>=20
> Related work: "Add anti-rollback validation feature" by Sean Edmond
> (2023, Patchwork series 372657, currently changes-requested) addresses
> anti-rollback at the OS/boot-flow level; this series instead targets the
> SPL FIT configuration-verification step and is complementary to
> monotonic-counter approaches (RPMB/TEE-based).
>=20
> Validation: the same mechanism was validated on real StarFive
> VisionFive2 (JH7110) hardware against a vendor 2026.07-based tree:
> signed version=3D2 FITs pass (cold boot x3), a correctly signed version=
=3D1
> image is rejected with a dedicated message independently of hash
> verification, and recovery was re-verified. This series was replayed on
> v2026.07 and builds for starfive_visionfive2_defconfig with
> CONFIG_SPL_FIT_SIGNATURE=3Dy / CONFIG_SPL_MINIMUM_FIT_VERSION=3D2; the SPL
> binary contains both the hash-verification and rollback-check strings.
>=20
> eli (2):
>   spl: fit: add software rollback protection for verified FIT
>     configurations
>   doc: spl: describe SPL FIT anti-rollback usage
>=20
>  boot/Kconfig         | 11 +++++++++++
>  common/spl/spl_fit.c | 24 ++++++++++++++++++++++++
>  doc/develop/spl.rst  | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)

Please re-send this to the correct list, and also since you're sending
this to the old address, verify it at least on v2027.01-rc1 if not
current 'main' branch, and check out the existing and outstanding FIT
related patches, thanks.

--=20
Tom

--HJmwJR1e4G60rFfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauuY4AAKCRAr4qD1Cr/k
Cu4lAP0UcsZX+Cp7deDgNUbfDSNJ2pQBEJoONw5faPocqs8uUwEAwnl1XT3r01mf
T2KRvImJ3qxIMG2x80KRuY8FxLixwgE=
=G24E
-----END PGP SIGNATURE-----

--HJmwJR1e4G60rFfq--
