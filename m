Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B984606A335
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aI9VqJ1A;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=H7qQAHSs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 433B460665;
	Fri, 13 Nov 2026 14:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id No7yR3sTpxpk; Fri, 13 Nov 2026 14:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9DF9D6068A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794581474;
	b=LapQCoTvzCbgGTvAJNg+esFIqKg8z2wl/T/vIMXZwfy8yhiVVEj8XhOwqMxVgcoVrOOd
	 JmCZgLRL7a8KnICIYBzxyTyfQLz/+T0/rbRmiMcpopHKYPZRCx3RWkiIBzkskL7RA255T
	 TR2EURn6RUyn2MSt27aZMx1h5mwhBoSEAvzqMEUxtTKMqeRsJsTgI4t+qvXcQg9MBBlYb
	 P3VNcxIpyJd5s7eZ3b54dnS3qRgN9bZUMYsxhdNyrmrKS7NTsmNgOqH7xdKCSgWpY28yH
	 5C18Rff5SZ31tkieioQmDN6OvfCigiNUOuI8SvbnPwPLr5+8coE37YdPeGqfXEHsunA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794581474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1fBdkSArCL2QA/P2huCs5Zk2WZdmOH4cczqQboEXEw8=;
	b=Ax3KfAwHzjLFhAGngY/vauIMto3/Z+7cjScfDTgCXmC4W5HbaEDLasWVi0LEWGcYxgBA
	 4mQR4EYYHPAGP1FiEHJzw8FClyYgikKfr7CX0g3M4sBkRZUkpXY8uyb7x5WbdLi97TMGK
	 G10LeMrbD2YwTVnixqv6pRsprU++eE7wYE1UR0X6qq1xvimlZG2Jfu1XhH35JLYrt1P05
	 ulJpZ02ySRwhGr8lcxt8uS2klkTyqKBzqwLjvyStr+iZIoObAG7HB5ezvbHl/Klfy1uBe
	 Pr92Upar4LMVMWsAzZrsoz0FEYnTgTN0A8Ccw573ck8vp5x3KDUebO8LK9QLHhjfQOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794581474;
	bh=1fBdkSArCL2QA/P2huCs5Zk2WZdmOH4cczqQboEXEw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aI9VqJ1AQcUJOtjSpmPTmIOh5ciQCu3ijDJN9tS0JkeBYAshWUjy12ymXEn9cIBvd
	 7dZQ+9uFoGW2Q4xz6bPUDUl1f4G71/8AVpq81AEhaUYsGVguGOo6V/j1qR2eTJSxsr
	 Ef80eRFDFqAm0t1DhkppofD7PjOmYlky2u8AOVR4C/R+8d/F6jKSiGLXu3krONLgfW
	 rbZk14gOYZ0vwN9uDoYoTUprhvT5SWoEqGlWykuV9vtBOA48nOM3y0AYoDsWhRRvBp
	 fPfSE3sq7wliNFNxfXIWYZHDU68u7r8W0ykZ375zwfBBLPkG+DUEiqUYJaGtMt4zFG
	 Giimz0yR45wOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DF9D6068A;
	Fri, 13 Nov 2026 14:51:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 25C3928C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 14:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BB8240116
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 14:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J6HhVRnDoF2C for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 14:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 583924009F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=H7qQAHSs
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 583924009F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 14:51:11 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4adae187d94so1280220fac.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794581470; x=1795186270;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1fBdkSArCL2QA/P2huCs5Zk2WZdmOH4cczqQboEXEw8=;
 b=H7qQAHSslo4aEbEPuNsoHnyqpQhZ2PUDg8sV3h3UpK9tfe6kK0Jetzc9tzaVdmR+xO
 TxvDbHJonjoVWfCbNzcLry9TcY8Jyvh2RN+g+IQX4FciXrb2na56XQl4zoo9CJt5Gd47
 gLZg2N/X7ZcI6Hg9PotDXApLswR/yGNfJWySE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794581470; x=1795186270;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1fBdkSArCL2QA/P2huCs5Zk2WZdmOH4cczqQboEXEw8=;
 b=DY/c7k+K3hmbppBd7GHiltA8R8gEBXmcSXhbY4bVRMyeNpRPHn2wwselp8NpNDhtZl
 S/9OyvNKG3ZDTHrT46MWLR0A8AGx74nRi0ucFZ7rNgpAOeEsudSAMJidIFFWYTvDLwWW
 PNuXrFcb8/O91UIfFWe6jfXOOsDNpTpptOVi6QfsOefSV314Rx/3UFYACDtdvqUCodBv
 exSWximdR0S01e9chOm44zVdV7FVeLigc+5JfmFZCo5fBEDn2c8kwzXF9VsGelRkh+6s
 Gwx8lOw1k3E2+78rvz8v+s2OZ4et9Z/KGxo/1xDcH0tX3ou+btH3MtxqDfOlVqd8Rn95
 pXog==
X-Gm-Message-State: APuU4Z9ChRpGoFmV8+yDma9YQ4+Gt4Tt5hLbWmRfWs+Yg/TUJ7vW/nCj
 HtKN0q1E+561/0Lxt7bXy098w1YYRAkLuC5Vr5upq7gkobGotDJkdkj49IX0bFSA0QsNV6Sju94
 LLgPw9VCSdA==
X-Gm-Gg: AYBFou3EAbge1NOyAad3Ru6vQ5k15z7BqU6FovI+RdyxBgNlxF1Fiq2DQfCZeiMmLPr
 Q9ReQ35RIIyM+0ShGHzBprEx1XXl5xN+mC8r+gmMDdEpXSkRe6SdzTou4aojrWuDstfTl+UQxxK
 xk9twyrBBSHeNd0LCeaTgkWpoXI8fZ3N8lHZ3WACWR/aIH7LUp230d1R7P+2TUsHYPii8GVyV7q
 mHd42qvAYxqQkSpQ0rZM3XS8qVEt9JSTLsr6B/HkYqGPazXiZqL1B2qWonLChiEhvtkTjqllG1I
 8QlLBUKWMwZpAQcTnfw3vrBZdViKYCNblfWdRpQ0MDFhwqDDOC9/cdC/Pe2I7DZXE0jeu2KXauN
 QNR1ah9ROO8s1pIWdsO4GJE+pQVcufnTaRhlicKFkTwgqHulKE+aj5EbMIaYQItNdVW8ytuiL3G
 Zy7+PyzHfs2eCjzv2bYXBuRZUps596JeMeFQ/X7+Njnya0oBO0iIzPY6Hnj9hzGLvOGaE4JsxTb
 M/xzxQcbtmOIzCN5HpSJbFdzX2ZCN9QX//Df9BNkSycGaf5qohqB7RsSWamTNh978gjQ/HykPah
 /z4tVRT0F4GSpA/bPYghK6o9yqCyyTTsTP0wZK6Kc4qeRchGycpHTpm0IZdzQXorUNGN19bNj8y
 9oiTCdoauyfW0q+StiR1I8BzTyeTTCjJjV8c6nc81q+LEstoZ2H7WiJg6f32MkzmhOvxAEux7HW
 V0Ka1VRtU0Th1xNVBWdpvsfLp+tCEhY78=
X-Received: by 2002:a05:6870:219d:b0:4ad:a95c:ff14 with SMTP id
 586e51a60fabf-4afdf4c56d0mr2558569fac.11.1794581470473; 
 Fri, 13 Nov 2026 06:51:10 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe2200c91sm1402226fac.4.2026.11.13.06.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 06:51:09 -0800 (PST)
Date: Fri, 13 Nov 2026 08:51:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] disable VBE by default
Message-ID: <20261113145107.GA1199710@bill-the-cat>
References: <20261111093212.3390778-1-pbrobinson@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C7OehzJjfWl0jmh1"
Content-Disposition: inline
In-Reply-To: <20261111093212.3390778-1-pbrobinson@gmail.com>
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


--C7OehzJjfWl0jmh1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 09:32:09AM +0000, Peter Robinson wrote:

> The VBE protocol needs explicit device support and as
> such isn't particularly useful by itself without that,
> it also adds size and the potential of an attack vector
> so devices that wish to use this protocol should
> explicitly opt in to it like all other large features
> in U-Boot.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  boot/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 8fcdc36c931..556e868a5f4 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -720,7 +720,6 @@ config BOOTMETH_QFW
>  config BOOTMETH_VBE
>  	bool "Bootdev support for Verified Boot for Embedded"
>  	depends on FIT
> -	default y

This needs to be default y if SANDBOX so CI still passes, due to all the
tests. I'd say we need to update the tests except for all the numbering
issues that's likely to uncover and that we'll be dropping VBE as the
follow-up step.

--=20
Tom

--C7OehzJjfWl0jmh1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavcj2AAKCRAr4qD1Cr/k
CulfAP0cX7aFEAiXhxAz6JKzrKTzaegoc2HtO5Py4THWL/amnQD/a5LSRkqHBQT+
dSeRJ64g0wxJVUkk371SwNfSG9cdHgI=
=8Ob4
-----END PGP SIGNATURE-----

--C7OehzJjfWl0jmh1--
