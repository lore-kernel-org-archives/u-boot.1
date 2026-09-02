Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A463C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 16:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46B0A60834;
	Wed,  2 Sep 2026 16:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5WEy2XYX8XcT; Wed,  2 Sep 2026 16:24:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788366268;
	bh=sY95qzqY53TZ2706zHe9C7rzKgvnDaRzJ6Krt/TNrBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bXoJS7HlNo6J89iu4GV8hAV6vcaJmq9nAAOIrHryiL+FXTJ/iU1rR3EEEA9tTOMdo
	 1nWTTzjgx5qtBIJ+1Ju9GnEHSu0gj9ZZ0Q0F65QB3CJgQmzN2uDXWorLX7GOL1IVUN
	 atD+3rKzzg1wqo6AFUTU+0ORuTUQ60jzpeC9MVQaFfouUppZdXevsvV09ekdCoO1uy
	 RvoQYC8MHJ/0PCRgUX3z7QnlYvJ5ffDAx87x1qwp+lOUV2y0j5rMYwQKXnDmqMcBQn
	 dHhM2WRFUtedjrhRGSVTGB/3FPa/whaRQG57XGVTamZg54FAZegNklTOWJY4UgrweK
	 n60Lhshctf1Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22C57606E0;
	Wed,  2 Sep 2026 16:24:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4A6B2B2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AA7F80DB4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:24:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDEH40iaiW3D for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 16:24:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ChKjyi4Z
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3CC080D81
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:24:24 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4a483a552efso564504b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788366263; x=1788971063;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sY95qzqY53TZ2706zHe9C7rzKgvnDaRzJ6Krt/TNrBs=;
 b=ChKjyi4ZT/zgvoJBjerJR/jUhx1OZxJIzHKxmpN5SgnkA4nbYd1q/z32HEgSBnGc78
 UwHuou/O9JsgRR9QBLdxgLK4iaeL+0PrnrQsFmHRSMVdUeIFtgzhNkt6AsQ/RrvZD4qH
 Kxo2vBWpQFrEp/pHN1e/3YS8r+vmAmq3BC4uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788366263; x=1788971063;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sY95qzqY53TZ2706zHe9C7rzKgvnDaRzJ6Krt/TNrBs=;
 b=rvMFnlgvIfwvYgtI2i2y7uHN3bjv7nJipxnYg85b4ascTbMT9sx2Kttk/lQTYKSmR3
 66QI4RiUL93pUMumw7x7k6rnTqgV7GVLovacm/m9hsVW+HIl0Gi7CA/wxl8qCbYznr4w
 gIs8xmAXByw0bgUoA4ozga5+xA8Ccg6qdMkwDAjrCbZq7zOrFN1FbQhVFo59M7qsVWv6
 ujFVbMj+x9zSogBSt9DWQVjorEgK+6rr2aEJhHCwnq7GYwBEjPK/wObzxqoR4OqMoQCy
 w+RK9FFCkbWBiHGqu8V09FC/pgA9H7qqEo96WaMWI8vds7upXX8Qsq/J1gyQ2HHnK9tb
 p9nA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVYsH2itX0UcCCyxGRK9ALNd2zWnT8Kpg5sc6XrCSOMMXVkgaPX8mgSNelqrRdJsIMsnrsdHw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lSl3kIEeh31QFFIDodpal+u1vXh+zwmLqayuNSiPGMYBlUPe5i
 dnhnNLal1xVReMeOBKRRLGRLm1WykQ02lCYBWjEmytVJEok+f5JNE8UUe/g3maUQ3J8=
X-Gm-Gg: AR+sD12JhkmW4Ywh5E7l/XavQvJn+pb4nak6mkWMTWZ+IdnKzoCs3y4ncuYALHrUiwI
 UahMEepjUj6BK3BuXXFaH8BkWW84HaaZRzq33xrgBH4sDOp5jf59RbQy9wC+LC4FROEz2XCOABE
 1JSoR08sG5zL+vU7bk6xC/n9WhMB5GVJBDNMVwuSO5+O0ZT6vQTEsMK+sf0lbrVOfGt7WCFHJDs
 kV1mQ1LDaa+u/gadzRVcbia2nHpOtvnbtSMlXBkJCssA6KWq4A4gFQ3oXfgfmmVI4+6L2giUrwr
 lwB/zn/H3Oku387KygBfVi0vv4tygqbHWdH67wwFr1Qx01WpoM1mZlp+b84l9f+ksz6OOF3Kmqq
 Vg/9OWOZYf2oo+1hoQ+2HMMNKlqVCnpZsWU5O4RPB+myFWk4KaeW0cwZqk1zNqFuoRoChPKhJk4
 omxqE8MwuIpXRi5nm/jfDFEFZ6dfuDk5sol16xiGewR7JVI1+Rr4C0gTn8HBqfNRmnjDpn8Ty45
 SkOwKCJc81hmSSLxWXAkVV0Jesa7j7lv/YpTJzJ9IY9cvcmEHi4l6WWd+ISdwhcJCxus8lt6hG2
 OypIBR2aST2nfr5cCotA
X-Received: by 2002:a05:6808:1a1b:b0:496:2b3:ae71 with SMTP id
 5614622812f47-4b6bf38c806mr4732141b6e.18.1788366263475; 
 Wed, 02 Sep 2026 09:24:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b69b2145easm2264280b6e.10.2026.09.02.09.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 09:24:22 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:24:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 01/16] airoha: add support for Airoha AN7583 SoC
Message-ID: <20260902162419.GB1764417@bill-the-cat>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
 <20260902085311.1550804-2-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CczRI23KoSECe8Ar"
Content-Disposition: inline
In-Reply-To: <20260902085311.1550804-2-mikhail.kshevetskiy@iopsys.eu>
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


--CczRI23KoSECe8Ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 11:52:56AM +0300, Mikhail Kshevetskiy wrote:

> From: Christian Marangi <ansuelsmth@gmail.com>
>=20
> Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
> entry for the SoC, DTSI and initial config for it. Also add the code for
> CPU and RAM initialization. Everything is mostly based on AN7581 that
> share lots of common piece.
>=20
> Acked-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
[snip]
> diff --git a/board/airoha/an7583/MAINTAINERS b/board/airoha/an7583/MAINTA=
INERS
> new file mode 100644
> index 00000000000..71ee542a8bc
> --- /dev/null
> +++ b/board/airoha/an7583/MAINTAINERS
> @@ -0,0 +1,5 @@
> +AN7581
> +M:	Christian Marangi <ansuelsmth@gmail.com>
> +S:	Maintained
> +N:      airoha
> +N:      an7583

Since I'm already requesting changes, this should be <tab> throughout.

--=20
Tom

--CczRI23KoSECe8Ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaphNswAKCRAr4qD1Cr/k
Cj+xAQCXlmDCxHL6ZvVRblVIEewa//Ea1AEu4NnvRq+XNzmfOQEAxIJEmQMB9swt
l9xeanLWpZYgu4UXD80NNy797ZkgLQs=
=DHJx
-----END PGP SIGNATURE-----

--CczRI23KoSECe8Ar--
