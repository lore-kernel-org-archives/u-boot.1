Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37C606A335
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KJonFYX2;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pC6BcFkv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 012B3405E3;
	Tue,  3 Nov 2026 21:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3448SNqsXzl0; Tue,  3 Nov 2026 21:57:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42698405D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793743027;
	b=MivtJAVcib4PZKZ9e/xCbMlLsaf/gvxVkklXkIFukAiGUUfdDorGeSxYMi5g5Ie6XK8+
	 U8hrvzvyZN/8xfy2vYQvar3OpUzj5JLJoPmt07pwQrV6eeqpOJ7/jJIerdzBvj34rD4j6
	 bOrT5plIHd7++DCjIO6NdEqY6BCOgPRByi4e2fy3S26vUrSqTiPwrGSMEsFP96/3uU58s
	 y8ntl0EyYx7gekQ8O4GMcB/0I4UvY955J2HriWMtRC4ufHhYOAhU34/FEECQw28xnd6P0
	 vRJK7ruF+HnZz0gHwLuogZOb1A/p0GYd6gQXzPVXRUGeRX+5xgkTTo265DkGYY659QA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793743027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QqPZDOYi9SQbATUry8/yhELMUC1sJ5wr3uG0EMhr7p4=;
	b=ATwOuoiX5m0pEv+ymI8mddUQqti4w25YsW6vT95RHkmVdb7UKX1h3ArTC2AJnexbDYi3
	 l47gnXzVqV9cTQfkhMfVHJOR8ym33J3QQ4M82oKlfYbAM2DDDN8RmD+S9+usoA3Oa3f6X
	 fxn213E7TBTXvGvQiMR9FpJ/g+SUEEGAaeAOrMfFuVz03XwTTXc68M+TH3XVSY9KiYnt+
	 0Vwutv2Nbi2h3bzt8spmJrR1K3rxvJHDxI+7JSSBev+cDo6fCCafsj8PVzbJdC5Bg/vNE
	 b63gPyWzJsySv/IKI7PA4zybrXq+jMcsz1AewabuPxDq73h9av2wXB2feALMqx5EK2A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793743027;
	bh=QqPZDOYi9SQbATUry8/yhELMUC1sJ5wr3uG0EMhr7p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJonFYX2L9pCtcraSiIIKTsE7si7Tx6j00bEWH5qWrNDrEEXx251h5+7KlB06hK3e
	 22rgspHHzvhexDP9VpW3X4Gx7Lrsy4uUZ0qUTB5joIr48O6T2YyD1h410MTHk46XM0
	 9n8IlJLbU19OP3OSoMKEUAl0zOFY47J7B8ZpnI4cj2Va6mpwcZeDCCDhRpkipA+/lq
	 oLLP9BNp8L9DQJoKgdchAeeejltrZSBx7NuoovFL9YyA1016dN8du4ooo9sGO4XmLg
	 JwwcjcHj6v/OhxJuTI+XoNDpQq+e+/v9AZfK1EjeXK4YsjgsTGwSzL3yaNUToAicBy
	 pS5Zqn6DAzy/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42698405D2;
	Tue,  3 Nov 2026 21:57:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 19499784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16AAF606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:57:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5-wITEe0VRa for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:57:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B6FF60698
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793743024;
 b=SqwSfxf4sT2UyVbDy35tV7zbcDPaFaichPqbr+BsiiYAMfht/q00j26/fGOrt08ERudx
 Tso3tAeuoA/by1xuYIOaNI1vGrXG4WTgA5TvqAXELAv2/5RfzmASHpEIgsPt1DaZMx52y
 2Vpn1sM4LcmaV+CSksYkYZe4ptTfl61WFAA8ERRrwNioWK7g3yrdrwPwdu0cPThomXX4B
 QOsRPtNxTyNvP3DSOaftNpJzLiOZPqpV5kOsTZ9CK4Bqy5QB7PlnCu31m+i0kaEjpYibt
 KygkJfl0xdnGxolCIcrp4nYhdrQnfhfxQra3HkpXNC5RlS0T1XiRnHhH0ckBkgrJx/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793743024;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=QqPZDOYi9SQbATUry8/yhELMUC1sJ5wr3uG0EMhr7p4=;
 b=bs+T+T0Hn+Bs9agvcjhdz5gzJMR9aBcqIXnG8BSHRLlXN5u4LM3qzh5FKbsmiW8tnQsU
 644PY7wlYPGfiS+/5kkznMWAWsvf1DETs+RsRdaqkNcmAzAu9w3m3hTqtedgkqFIGtQzU
 vdtYaqkcnhukBdg2TUiFT7CWORGVPI15lPjvAQejNYtlTdXGLlYnnI4210LpZN50482Kg
 yq970oK3wyFd3OM+Q1wAzgY0V3CxE3UJUPn2pfktURUh3FlHuJBmDtIWg4LMqrunj+MEr
 E0H+dnEG6/lEGq/ofBBSpusj6ULwjFjUlp+SXjpb3kRasv+RGcjr0upc2UIio2g9ncg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pC6BcFkv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pC6BcFkv
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B6FF60698
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:57:03 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-845f3fa7f38so19907a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793743023; x=1794347823;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QqPZDOYi9SQbATUry8/yhELMUC1sJ5wr3uG0EMhr7p4=;
 b=pC6BcFkvd01JyotH1HLrzRqk5R32++f42aZIXISkoCdmNwrFePPT2j/YBv5zMjeJrq
 EZ1PNnFnm102aWIFxDe/37Hohw160HdMb6I1lGi8EAUDA1l2ZT4d3q8ZQT51Kjb5cYP6
 gRdKCFpEINiBY1u3cwILsnhZxkOtBepbefG88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793743023; x=1794347823;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QqPZDOYi9SQbATUry8/yhELMUC1sJ5wr3uG0EMhr7p4=;
 b=aD0LM5KwooIrUQoq3GFIZk/Y19bD0QzdudItkF74TBNci/cXUvjteipiOPy396hZw2
 Kh/L8Wj79SV7EHS8m33KEgWq6wHmEXBHyTJzcwyLrsshloM04crX2IhVsav6mwY8Wse2
 KzPCPo/hqVmP2E9D46ykO/5Tfw1R3D0BZ5EOapepGLgs1eIfWUiEBm/YulgRqmro0p1I
 +71+un0xcn643NI9iOR0MvKrV69cdT6pY456yjs/U3IBr1gYjBMoUYBdFReFieEvuOFS
 C3qX6DA4s3SNUOXnaTMycT2WyBdKNJ8bvZWF1t0z8ZrAXqUZm+BNRiO5wyb9VJUxBD7a
 z+Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhXzY5WherAzw9bGj3/O8k66z9SSEUPNrRBC/10uSAeWjP5MKcCN6R+jIjjD+cNJFNl9cjDkE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9FckwuvPg64toUo4blLPbTYwH9VcaFbELEfBO/Xzkj3UUMH6fm
 kLi1VLwuTc1ykdxcZQWLKwQMLY5D/ihsH8wtOWxwpc1mK/ZpUDkLwfJXJ9MsSkQpRyE=
X-Gm-Gg: AYBFou1GPIb26YSOr+GwiDdjOWstuHpaJXFWTj1pgpXtbJIQxCo8BmgzQtalJjhkInu
 LMBjJzuKwNWde+M+8fYK+AybguUs0S+8ubVchZN/xDePk4TFm1pEBz6V331btPPLAd0zuprrbNl
 VbuZNbBu5p1FcyvnbJe42dlBhYjAcuBO+TwM2hhdc99odGpOXZOMBunVnBjm8Ss9jAhTeeZwkdu
 1EeMpTanIiRRMvqMaHLJ06uWUw3ug583sJ4DlpnNIIszHhA5Lt+PvqcE7cDdbFbg1R9J2wBO4vA
 otKTkiD8ij3a/UkkmjhmU6W80Nm8ZySuOmLWPrj7job9DaKC9/Z5u4oWRIRsZkRwZHtHyyPpjlS
 aGu3xc1ToD8ZoveRcKE5+f4phDHAbQxBWh1TiaMWeuRvy8eEovuxCc0cmm8muz921scz67hyS/J
 cwGEgpNFrOdNHNAEKFeMF90s8HfEenYvOW29QPj7LA/Ti+giMAjevUhAAobjKwHdMmgdh2g/PLK
 aiw6s/1NxgRYz9gHAov42loqc9oh8h4aqcl1dZMBx5Q0fbsNvDPF9+HwW4CnHGgZLAHPwhKU21x
 h5BKTKjtA2HbzYxO2jI39/meMzq9d7jc2PLCabtl8efs2RRH4nZ74SDy8FAowdE1SyOiB5kqQZk
 fKFHjmnUXuzeBXprpOC/QJBAiiETB8sBJcLR1S4tN5OdeNW59abcwBqdv/u5jFmVjlWNLPGDyC4
 NoDJMTiB3F4mJZdZIAzr5Mnu1TArZeIw==
X-Received: by 2002:a05:6830:90c:b0:819:28cc:637f with SMTP id
 46e09a7af769-85d3602a35dmr10653104a34.0.1793743022858; 
 Tue, 03 Nov 2026 13:57:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3eb980dsm340229a34.25.2026.11.03.13.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:57:02 -0800 (PST)
Date: Tue, 3 Nov 2026 15:57:00 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 4/4] spl: atf: pass the bloblist to BL33 in registers
Message-ID: <20261103215700.GE785819@bill-the-cat>
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
 <20261103-spl-bloblist-pass-regs-v1-4-bbbbb7e65fdd@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iBsSv6I3BUysbNd5"
Content-Disposition: inline
In-Reply-To: <20261103-spl-bloblist-pass-regs-v1-4-bbbbb7e65fdd@baylibre.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--iBsSv6I3BUysbNd5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 03:26:03PM -0600, David Lechner wrote:

> Make SPL_BLOBLIST_PASS_REGS also pass the bloblist to BL33, which is
> normally U-Boot proper, when SPL starts it through BL31. Fill in the BL33
> entry point arguments that SPL gives to BL31 with the register
> conventions of the Firmware Handoff spec instead of the primary CPU MPID.
> BL31 passes these on to BL33 unchanged.
>=20
> Without this, the only way for BL33 to find the SPL bloblist is a fixed
> address in memory.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  common/Kconfig       |  8 +++++++-
>  common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 5 deletions(-)
>=20
> diff --git a/common/Kconfig b/common/Kconfig
> index 02eecdb5c98..2ac885d31e1 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1243,7 +1243,13 @@ config SPL_BLOBLIST_PASS_REGS
>  	  specification. The next phase then finds the bloblist without relying
>  	  on a fixed address in memory.
> =20
> -	  This only affects the default jump_to_image() implementation.
> +	  When SPL starts BL31 (SPL_ATF), the registers are passed to BL33
> +	  through its entry point arguments instead of the primary CPU MPID,
> +	  and BL31 must pass them on unchanged.
> +
> +	  This only affects the default jump_to_image(),
> +	  bl2_plat_get_bl31_params() and bl2_plat_get_bl31_params_v2()
> +	  implementations.

So that's what I get for replying in order, oops. But is there some way
to handle what the TF-A case needs, while having a more generic "prepare
the bloblist" as I was asking about in the previous email? Thanks.

--=20
Tom

--iBsSv6I3BUysbNd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaupYqwAKCRAr4qD1Cr/k
CgQFAP4jJlj499O23mdYKNsClkuYJQfxTrQmcxDOKWML6n6GYgD/cVFLA846B8g+
1f5O02etEnnnbEjyd6wyhaNBKShyNAU=
=tQuB
-----END PGP SIGNATURE-----

--iBsSv6I3BUysbNd5--
