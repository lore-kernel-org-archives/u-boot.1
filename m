Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA80606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hnOsTtiC;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=kCBy7Bjk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B009B40726;
	Wed,  4 Nov 2026 16:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I2m0aRHJ3Rlh; Wed,  4 Nov 2026 16:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EBE79405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793809886;
	b=oZRMAGsIUawgy2+YRznKPyxv5Lr7E72E5F3InBbi7QZgDSfr66x69U39QMTm7M0GnOQJ
	 2K0W9bOcQ8siEmIao/AM93ONsiaVsB9UvIx+RgTtiN+A3LusoU+dwbdK17hyacZjjAqPX
	 a6kwuaPsyxU9xLTVhBNmIFA1X+1owjdh/nCnv/213WXTwJh7siJDUhIhKXDhYMN1yD0dD
	 FCqmi/YDLeUffs3fcKWc2Cr4vuWNlmFa3v2KDo3tKHVHeKp3D3JaP+qt5xzppuRN+cDLW
	 b5VJbNTh0WxV2bR+NK0uHFXe2rmna1FGVp7cENyL8466EEhU/vIqCF0OAgorDmFvbxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793809886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5iRP1ZbgImPjIPVlzTSZUZfbMzZ7aIAJr5PLGUJ/dmA=;
	b=Kxx1LX/0hbITdq9YA52nQ/WGvbt98w1Kt+L4E9eBqqdiQu6QORcEDSSitC56H1iy7mzv
	 MhEE0J1c6ukH34Lp71TIXoW1gHBmVzoh4cmGHt42OL+hXGPKNUjpiYjEbaDFZYUGEpJnJ
	 l6hD4iD3v/HAstM8dJk0kvFAxKtGs/OBKzSpf99MqBxqNiqhwGQ1sZ+WpFO8RmqYQfTwg
	 +YjMliJe1tU2w22D4uObQ6RJBo7hqBnLteTopTaQZq+d12Rmo1obUTQ4nlQlWV9CtCbio
	 6J51WsUrngt6o+7etJdQhEjGiYmlNGygf9KMsO3TuKR00wGG3rcGd8JYpIBytkxP3RQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=kCBy7Bjk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793809886;
	bh=5iRP1ZbgImPjIPVlzTSZUZfbMzZ7aIAJr5PLGUJ/dmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hnOsTtiC7ElApGDmR2SaIM82is8a1bQ0qeko1NWkq0J51a2KtQbUmvoN88D8d1N++
	 oCtpfj06iYJ7fhvHNedNhH9NHfZ2veqYv6ch6aHe/KJiXtF/an2rGXTWqea156HEt6
	 h4qATmAGIN7ZR3ASvNTLcKxy79upHDJrgqItoj513xXJRCEPIzZnGnaI9s16jYwoNw
	 ecTH90f8UBbKPDNTpp/ZDF2I0j2YL4Y0kaWTy4V7UAdX7WF4AyuoIcdxVQygsh7A1T
	 rgDx1h9uK0wJqa+hr/a3yn7WqpRNH0MUd0tYLtTJmYaU5pg0ngwehRjA2GHwKMgaCe
	 kqMc5El09OMoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBE79405CF;
	Wed,  4 Nov 2026 16:31:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3105C165
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16D68405CF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQzajt4Mv6cf for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:31:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C92640512
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kCBy7Bjk
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C92640512
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:31:23 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-539d2baa897so391351b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793809882; x=1794414682;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5iRP1ZbgImPjIPVlzTSZUZfbMzZ7aIAJr5PLGUJ/dmA=;
 b=kCBy7BjkjdLk+hyPX+FzW4ZYE3oeu8PdaZTeQX7GJg4AQ9sM0iyJDjheNdOBwAyn8l
 inPdGpdODKOZtVi/im2P+zM3IBCUmT3nHLwy9HLhBJRPv8wm+WM0MFmE4PCS93xOYYF0
 o9QdxHqSSTPgRFqoZ9gxjvmsZyeRRyznA4ypY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809882; x=1794414682;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5iRP1ZbgImPjIPVlzTSZUZfbMzZ7aIAJr5PLGUJ/dmA=;
 b=mCDs4en1yROB2cDRvUSwe9ZlhHMIUQjCUzF5gJuQQaZK4/hq0h075sESpGALbVn/6K
 aATZZKdK5tkukO9Yc3e3k1zmEsdHIknwvnObVrUalyocWRbBzUtAMqL06YOoUSPGG+pZ
 8TwOGwkLMRSLpCtO3W1fonhKSpNnV85tINY9I9uCxjm/B5gSYGiy8vbx3MfNT9BswOzl
 Ewug6WUNLY40z3EBMvcwqEzqF8mqRAP9sEKCy6us/wjXC0czgHvDZ2aKDf/VflPbv2OM
 c6a1sqK1QpYjyi1Lc+or7sNg3uwC/EqGeISKMzZ4+MrzhpclR5IY7UEjJndMX8r1WT3X
 wzgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy52HfIeCdq3X7s0RMIvy7c6j5gyGCo3ZqdIMDRB8nEGY4nDxiNNG5CqAiCPq/9UO3ZYRIXdns=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z++cyl2FPyppvW5nLrRL59O4oOISN7/N4fJIKq4Ls87vWRRnan7
 EnhkjT13iBzngjcYxG4dh3xrTYSyCMspt48xbyAcT1oOn5VcV4o587Xb63ZlrPO1sfc=
X-Gm-Gg: AYBFou2CqDdDw+GVYKE57GO3TlXoFBL0KtPh9Nv3FaXbfS+bnU5STQaHuRSmHAg/Abz
 +MAdv0F3JKNdWuMU9voWxCfkTY+eOe09xEfrqYZkyZvThgbRjIDEIMiQbzlxdeSe/Y6tE1mphJQ
 OChxN1o6GQhU722mptKV44O+Js9Ol9iYq5bN9HcSqfIUbEGWi7Z7pfq4RJSx8MYsDfqaTWUHCUn
 FzTUw7W/JfS8tniX41h9FqkFkh9NzpbLpgET+fBkHRErwhXDySoHBkMFi2JzcpjKEx1ypOYN4KW
 ucHVUp8UbtsWR0lEcBt3UMjkCFTPlWF9WB1Ezd3pfkIeyQLEo3MUOCPQoyh9o0NWXKmsUEjrVUA
 DWZQEdbNr3Cqs/usRIZ1+ZIZNUa3dA36S4I0tORlUTRBlBELZA1GT+xQ5tLOIRCjwx1tf+2Yklk
 bpkJ8Wg9TqaPd3s54m9nwjp6oTloO6XwlP8c1hprPxMs3DKTzhHs5v/x1prJU+HPvio7OiLLPcu
 L+ibtrEEx1WGBXYV+IBp5qAZrxIeTF++EfhS3o9OJScvE7Dn3YEvj7GFtfKnBP0sq3wGzkH8yt/
 ESeOzAqm9vDeLuHU7XYX4ipikJnAwsLW49ydU9x7FrWxNekwvpLsleoQY0j0krKXVaiiddt+lcB
 m68qULdZmy6KSQL30OWGSg/h+4onUuD/wIidWY5i3re7bk2yg7tivfrg65koLHACsWhkwc/NMdC
 2MI2EMyubbWCQUJNaoeM47/kqMwLutdA==
X-Received: by 2002:a05:6808:6509:b0:543:50ad:baae with SMTP id
 5614622812f47-5640de7b4efmr10631555b6e.63.1793809882480; 
 Wed, 04 Nov 2026 08:31:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9fdebe2sm2018713b6e.16.2026.11.04.08.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:31:21 -0800 (PST)
Date: Wed, 4 Nov 2026 10:31:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3 2/4] configs: add qcom_sm8550_defconfig and
 debug fragment
Message-ID: <20261104163119.GH785819@bill-the-cat>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
 <20261102-ipq5210-v3-2-aacf3930848b@oss.qualcomm.com>
 <20261102172155.GE3309461@bill-the-cat>
 <aumczyxGU6jw/IiJ@hu-varada-blr.qualcomm.com>
 <20261103154724.GR3309461@bill-the-cat>
 <aurpg1fSzNByWwe8@hu-varada-blr.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CxHH56nG9RwSg9O7"
Content-Disposition: inline
In-Reply-To: <aurpg1fSzNByWwe8@hu-varada-blr.qualcomm.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--CxHH56nG9RwSg9O7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 01:44:59PM +0530, Varadarajan Narayanan wrote:
> On Tue, Nov 03, 2026 at 09:47:24AM -0600, Tom Rini wrote:
> > On Tue, Nov 03, 2026 at 02:05:27PM +0530, Varadarajan Narayanan wrote:
> > > On Mon, Nov 02, 2026 at 11:21:55AM -0600, Tom Rini wrote:
> > > > On Mon, Nov 02, 2026 at 11:22:27AM +0530, Varadarajan Narayanan wro=
te:
> > > >
> > > > > Add a defconfig for running on sm8550 as the first stage bootload=
er and
> > > > > associated debug config fragment.
> > > > >
> > > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.q=
ualcomm.com>
> > > > > ---
> > > > >  configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_=
defconfig
> > > > > new file mode 100644
> > > > > index 00000000000..40f7c857007
> > > > > --- /dev/null
> > > > > +++ b/configs/qcom_sm8550_defconfig
> > > > > @@ -0,0 +1,16 @@
> > > > > +# Configuration for building U-Boot to be flashed
> > > > > +# to the uefi partition of QCM6490 dev boards with
> > > > > +# the "Linux Embedded" partition layout (which have
> > > > > +# a dedicated "uefi" partition for edk2/U-Boot)
> > > > > +
> > > > > +#include "qcom_defconfig"
> > > > > +
> > > > > +# Otherwise buildman thinks this isn't an ARM platform
> > > > > +CONFIG_ARM=3Dy
> > > > > +
> > > > > +# Address where U-Boot will be loaded
> > > > > +CONFIG_TEXT_BASE=3D0xa7000000
> > > > > +CONFIG_REMAKE_ELF=3Dy
> > > > > +
> > > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/sm8550-hdk"
> > > > > +CONFIG_QCOM_GENERATE_MBN=3Dy
> > > >
> > > > Commit message doesn't match the contents,
> > >
> > > Will fix the commit message.
> > >
> > > > and maybe this should be done similar to some of the tegra platforms
> > > > where it's just and only a fooboard.config and documentation update
> > > > rather than a full defconfig.
> > >
> > > Added a full defconfig since the script needs CONFIG_TEXT_BASE of eve=
ry SoC
> > > in the MbnData table.
> >
> > Sorry, which script?
>=20
> tools/qcom/mkmbn/mkmbn.py.

Sounds like something easily adjusted then.

--=20
Tom

--CxHH56nG9RwSg9O7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCautd0QAKCRAr4qD1Cr/k
CsWYAQCYT59ZJXIha3ZkJmtHHQklF68Z+MJEMD1PPgR68caDKQD/VTxQ8BsbXVGO
lcUu8vORAuJ/s7WODMtO9uDaHnnJNwI=
=eFIe
-----END PGP SIGNATURE-----

--CxHH56nG9RwSg9O7--
