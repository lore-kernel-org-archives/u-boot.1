Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B7FC5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 14:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D46C9607DC;
	Thu, 20 Aug 2026 14:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PA7YTLI0KVhu; Thu, 20 Aug 2026 14:55:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787237708;
	bh=evPPgM0LYnQgD/hBZogczEOGcfg6Z8sQUWadkGujTOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I0lvlB8WtsRFvLUkSaTwdWn0Ju5yvxa6LsoY9OVp2jr57sMAZ4hqZK+KCw0e7Ld20
	 FrFgWr2Q2opZC7Df3yqtXUPKDLN6ud2NhQnY/31yfCPwh/U7XxJSGTsSVQlUt4bkcL
	 uCAB15ie7L6rGZMfGG3MpZSjvziHIZ9hMXXBmUeMZNqM8OMq8s0OSdCAZPoJtcXJc5
	 foBv1bWwjmfuCKyBreR0dd+TI1jlpeMk2gHFpbwIjF+mxcfbwOKRdto+gZd4He8mMK
	 rG05AJ5A6syeIq/HvZ2lx3GZDltrR9kQe2Fda5361p6By5sDtcac6kZ9qA6DqJddQY
	 ohbByFopL/eZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37DC76076A;
	Thu, 20 Aug 2026 14:55:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A584940B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97ADB40329
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jarGdUVJaDkr for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 14:55:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jphmuXii
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5F854031A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 14:55:06 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66c82b32121so3953364d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787237705; x=1787842505;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=evPPgM0LYnQgD/hBZogczEOGcfg6Z8sQUWadkGujTOo=;
 b=jphmuXiiToHyQ8s1cg88nha5D9sP7ek4j2+x7jOUm8INgNnEUsMV2SMtRZZTcWhmc7
 rBmFlae5qNxMD0/cVyH6NH0vw9mXT7pOVs8D78u8jNCIxNZOiyZ33z59Vg3WLV8+LDkM
 zp0k57Yf1F5Qg4CyLQmVaPcH9/n7vlNfaRhVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787237705; x=1787842505;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=evPPgM0LYnQgD/hBZogczEOGcfg6Z8sQUWadkGujTOo=;
 b=matgnlGkZ9NXNmWFT75a1yp3EmaO6bndFCRfHTm+YGL6Q2fWYurUrtCNvB3ZOc7lX/
 VD66KZPHR4i9GQhC88A0Lz03hC25Td4D/tvNBrWAp/pQSTPfS6WxUiFBluSRHO7Ijcct
 bYFV9t8WV+9ncqPTnS0EkrylBE2vsew03Ut04JzykmusqBIFwzMxK0sWr4kh/CM6m+Zv
 FBNo0P6H0W9Pi5GbfXH7C9X6J+W06I+fqMrazswf0Is5J/+1SpCFxD22jcKa7zoWTwZR
 PPpqwfobO7kbf75+FwKrj2M9FmErgC5GWjdxdhk21wx62SvJ0wYpHi/155d58Yjbby9w
 g0cA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEaTzkD02r3ZgtxtbHUyIDUAS+og5BuVX+3wkVoi31a0s/GDPFssJp15LWNV+j6xDKqMleTxQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m2/agKmsaPVvqxOZZefW/1imuYDPz5Q7haApXvQIyx9djwWPVS
 o/OIzqh8qBwS/0eraw8+8fdH8Fi6kefYruDKnP+Lg5t4oSQpH5ZyTwPPKd/3EV8qGZU=
X-Gm-Gg: AR+sD1137LoHa8+uCYnl/p6hSa/xsyN31QJqmDS232McEEHTgE6ta/rydJNyqb+25w+
 ZrETaHmTKHfTexQhG3iy0qyscgTGEkfv/ArKdQ3KUuP3sARaDYGF+IZj/7gGKQWhYxA06MnRl34
 O28e6aJk88SrQtIMQWiVFIAYnH2LEv8sJEnAzojWR+K/j0ibl3SYPk3jsEidnXTbYDCrB4ewKEd
 +q+H8f+80osY3KoOYQ5g7kouaJu4h/TR4/9Bfzhxv2x/8MCVOdZRMEkNGiqBMQ5OazGrONDRokf
 ttzLIGUhcKJIKkAZggBJXOW1CiDVwKDFS/Oe9oKIWMb9OBPQPVB8LIfXEPohj9H3kUBtSgVpq/y
 ryzXEn6/yaCWM1C1HtYQyxnReWwxpLvmVnrH4c90aheDscaVofuqH7FNVfAsM5VD1LdmYEhUxIA
 WZm/z348TmGT2m+wJa6W0IbapF4opinL/oDyqA/syW1pUChVnuHSBVUzacEVayrwjvp/yjRCc/Z
 xU4v5/ureHS5Uu8oz6vOUdm9LC4PZ0gS4FmB/RJwts6szz+Z9Z70uQXcGwvtxrUm8Bxlc972JvF
 PDIOucbLjA==
X-Received: by 2002:a53:c04e:0:20b0:667:c93a:82e6 with SMTP id
 956f58d0204a3-66ccb745f50mr3818976d50.44.1787237705218; 
 Thu, 20 Aug 2026 07:55:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm2735805d50.1.2026.08.20.07.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:55:04 -0700 (PDT)
Date: Thu, 20 Aug 2026 08:55:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/1] tools: build mkeficapsule for
 CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y
Message-ID: <20260820145502.GH523975@bill-the-cat>
References: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3SKs4YZCy4L4VcXM"
Content-Disposition: inline
In-Reply-To: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
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


--3SKs4YZCy4L4VcXM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 09:26:45AM +0200, Heinrich Schuchardt wrote:

> Currently we build mkeficapsule by default even if we don't have EFI
> capsule support enabled. This adds a host GnuTLS build dependency.
>=20
> Only build mkeficapsule by default if CONFIG_EFI_HAVE_CAPSULE_SUPPORT=3Dy.
>=20
> tools-only_defconfig explicitly selects CONFIG_TOOLS_MKEFICAPSULE=3Dy.
> Hence distro packages like Debian's u-boot-tools will still contain
> mkeficapsule.
>=20
> Reported-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

This should address the similar type problems other people and platforms
have reported too.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3SKs4YZCy4L4VcXM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaocVQgAKCRAr4qD1Cr/k
Cmt8AQDfIpbo03jW7opu5mMmmFjH7rHOw3QQ1g+8IymV3Ox4AQD+MmphwBpJJtgw
py0FTMi0PgXZwYOJXUVWmPZgScBpVQA=
=hD60
-----END PGP SIGNATURE-----

--3SKs4YZCy4L4VcXM--
