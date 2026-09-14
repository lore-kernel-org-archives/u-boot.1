Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAC6C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCC65806FF;
	Mon, 14 Sep 2026 21:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c69IoUPCYtsU; Mon, 14 Sep 2026 21:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0F0D58084D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789421594;
	b=T2QxHk1+sl4LtQBqh73wXUplOdnUnJV+VuFfsE8gKQdt7FG4EDeHeJqr8/da1l6+HkTE
	 2zu9rtwc+KwoIF3afjLCiJepEqStuKnWTtvU1nU83v5Sjq+PKowGQcqP9iV0z9wXhcGsE
	 0RN501GLq04u/n9jZllUmZnzYnICRq1ejJlfkW/f4FMUSwIElVn2X49zpBFBPWXpR9buV
	 QBOQWfsWCkkXrm4hx86x6WW0eVT5tqIR0bhm9ylvL9my3jsjg+uYoZ6zK0SUDbdCDqufq
	 hjrlzJUaYUMBx/Bq17GgVpzdRb8MBD9DkQ569x64t7vRQiAgFCLlJRwHd+euTOpidIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789421594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c2F3fjwNZEwv7CY48ksf28jj6M8CSaoymSQI0u0ZF2g=;
	b=JsFM4BwZmpJI/cNs+Y99RZ4j5Q6x5psLt6aZS4zAZbrVi0VQ9hng/dJEVLRsmRAul4k/
	 189JVYPvg0HeCMKQ8bzuHef3CAgr1TEro3KK8teKsyfF2Bc/NqthbO5G1TVKBhFTIH2Xg
	 KoPngIcTIMJnz83ck6sQivME5a1dVPTYca/Ad4hSgAr7Pf/rMLdtSyjqI8towI8+RBVcA
	 Wro27443HPxpjmalzuxdbDFvbI+54tiUvXRzHB7dwVOo7A63zMoUJY79RjQ0QCjNx1quE
	 8+F2LNhnkY6VjVLmCpb2fD+gW/SvNmqtW+QRKXnWOvYl/x6naMu7BxHfQnun/gvtQdA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789421594;
	bh=c2F3fjwNZEwv7CY48ksf28jj6M8CSaoymSQI0u0ZF2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMMZNEW2JoQsWa/WfAlPTDH44bDMwe7iHYozZ/4spsffItT7F9jd6nafERpLqBk1v
	 UI81x97SoNnVZxsTHRIj+34ZoWSRCtpfRaw/9dDZqbAP2wkj4b2GrPr9eziQoXHSRe
	 7cSphoouqv0J8TlFax007O1wdAQj95BXckgc2+wj36xekTcjZRNHicPcyGwsvb/u2/
	 M2CmMxA99Pmg6dR225Wk+Ty+qZO/6QoGJ/DITpIWw7znquCekTHCBYxhM2kpxRVLPK
	 1DHYNxGqYq58OL2uP5zO/Nyo3NBrJn8OiQU64FySBXApvB42eM5BxVmvXxAf3xBkEe
	 OV6pq8G2tdgJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F0D58084D;
	Mon, 14 Sep 2026 21:33:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B87A0465
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA753605F3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7WxsbDUm92CB for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 21:33:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 08DC5605E5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789421592;
 b=HC+oQcC86ZTONqV1plffPyOdMNDDijo2tihGBAiXOA6GPeL8mChVHtMG7+NshmE8apYG
 YavbrFF4qiJA5g+ApYvZ5pxsYizWWhdDkE+nFiD3nk20kTWUjHvQqpnjnIpPTsBXeF1oR
 w6zl6+RUDCoKp5iSNi0NjHipqd8Yy10Zrkpy7DDoWNRORI/hVjkTDKYZvds7PaODbFVw6
 vhAGYMULdyvGi3xtWZiK9LtbkXvTG5Q/bADGyF/A3fGTm9I/Xs5olUycXJAMP1/Jbnvap
 izIINyJ0Gqf+UG71KURAlyGV2QeNxnD++dmIMfM3MgymNwe+tLOI1YuIHyDzjXQMIqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789421592;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=c2F3fjwNZEwv7CY48ksf28jj6M8CSaoymSQI0u0ZF2g=;
 b=fcYjRPbBU/U/dByqJClJZcf08o0u61+e9+k71yMK+v+60QA9CF1D5HLsxQf7Z5SxF0Av
 YGcHGftp4zjvfU9uJ47zmA9EAYDrgDrLNBC+MDi7oK74eCYoX+9pFWRZfOCh584kslfew
 Bv78qvxXjJVRs3yKMFktAQnHP/S5TtPKc1r5VZPj7K38EAWcMMimsI5qVhMzMEJYD2xlu
 6WcWRis/o9hfXdksghqg1sTVXu8US+a4V4Nfg7SJ2ZeGNDejMZm4TDU4svw/KyXuDFua2
 vEhqSPP6aPGExRAYrTgWhS6i6sbOnt/A/ww60dEl+EajMB/qZrGTZTyAJDaeC40N/XA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AtEfdY4f; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AtEfdY4f
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08DC5605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:33:11 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4af173320f9so2945507b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789421590; x=1790026390;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c2F3fjwNZEwv7CY48ksf28jj6M8CSaoymSQI0u0ZF2g=;
 b=AtEfdY4fyBQol9o6jCQtMzzp6199fxZxt2mtmKpX8hC/Yb4MQz1GIwefKuJY6f/aNM
 D4veMHl0oBsk50uOp0o9g5MSVMHaRN25HYZRd0VJHmWYKDijG4pdEFIGctNm8WdzyYHt
 7OxstKcTqagEbpKu1B0rG1YIbXoGsYXsKT6cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789421590; x=1790026390;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c2F3fjwNZEwv7CY48ksf28jj6M8CSaoymSQI0u0ZF2g=;
 b=RQ7nABUnWJBFxvMH+uFpf0x7V/Dt0NceG82rAztgShpVuY/1EgxBJSIuKaFW1PM0RE
 H5e7n3W8DCPXbLZwzpLx/f3qAdATm22t7KpFmYjzlGIwNYbFvjJOqom2U2n2ev4jrq/T
 uqBGM9YOPn5gF6cFvglAVryCoUlGNJ0UXg/sT+ei2vNduvW0mbEsk4dkYnBLVSnpBz5v
 ofyQmC5fBociT46v1t31fBE6OwRrAu4peDfBkng3k2DnR6T6dphgf/GcZXUYwxgUPj2/
 yyTHEyF8qho1IDSDtiBFu6oTtQyX3c8pWqwq+5idoY7UXpoJi8qScVHT7rP056wzJ+rj
 BxDA==
X-Gm-Message-State: AFuF++kF67LoEr0GVAs1Xa4L1Hv5TNZEBtctwZWnnk+C5EuVcdVn6zDB
 diq+lILhPEEwfBgE4cbsDqslm2k77ed6IY+d6kzNSCdi1DOlim4TcI2vlJMNh2lzYlc=
X-Gm-Gg: AYBFou3Q8IGORYv0Z1IB3GRJRmZ3ntwwTKqa5lrSyyZpLC7lKkE8kZCsyyMMm1QnWlb
 ZxFWdxeLOdbSftRMR/Z4lisscsJ7b/mxnOlhWyKh3E7BcvrpmUrMMo4EoQpDcKT/qrdDnQdS5xZ
 c0JdUkfkWRXjITis2ckzTmZ6bEwsurYykHlcWeczSqJ21G8hk9pIREdEQEgdzipV8YiOrFBvg3l
 EOzOurxetdPpm8q+STR+weeXtsFYlEvv6HRFGKrry/sOtITzXNflB/ZpdSdGI6jqu77jC4J54/J
 daktjdeBl7VHQVZ9wh8j5FLqQoH/lPYfgyhi7oQlExEtVj2hLWjDoKyfMywaHfEOVHj/Isxhsy5
 fkbCFEsi61+Vchtc16LYaslwQR9JIlsXvEjr9+U5/8YMdqSQn+7N3nxl+vp8zfxrOzbhRpvA7aG
 XR/EmrYTBoRMU5PuJp750MpDLD8xxtvPKgUx4JHNF7Afl/AmvH/4jXpLe63wzdX2t9EIjlY6VXi
 nvi+DQIYOKQgd2NW6av0DWIZtbkxVI8LI1mLaGIx12ZP++yfVEXCq3RXMKmJ1lNkd5QCR+ONnBP
 Tmr6FO827QE2sTBrUBlu
X-Received: by 2002:a05:6808:164d:b0:4b9:e5fa:8904 with SMTP id
 5614622812f47-4c7b63691d5mr2877773b6e.23.1789421590523; 
 Mon, 14 Sep 2026 14:33:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8892123b6e.17.2026.09.14.14.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:33:09 -0700 (PDT)
Date: Mon, 14 Sep 2026 15:33:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 1/2] spl: mmc: select the boot partition after device
 initialization
Message-ID: <20260914213307.GJ1764417@bill-the-cat>
References: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
 <20260914-ccaione-upstream-part-dynamic-v3-1-a38c19e74563@baylibre.com>
 <20260914163557.GA1764417@bill-the-cat> <aqhe4KnMjO2HQiDA@macbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z+JbjmB1c0TrDoKz"
Content-Disposition: inline
In-Reply-To: <aqhe4KnMjO2HQiDA@macbook>
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


--z+JbjmB1c0TrDoKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:56:49PM +0200, Carlo Caione wrote:
> On Mon, Sep 14, 2026 at 10:35:57 +0100, Tom Rini wrote:
> > On Mon, Sep 14, 2026 at 10:31:37AM +0200, Carlo Caione wrote:
>=20
> [...] =20
> > > -struct mmc;
> >=20
> > Have you thrown this through CI? We have that forward declaration
> > because it's not otherwise defined, and we wanted to avoid pulling in a
> > big header chain here to declare it. So I worry something is going to
> > fail to build now.
>=20
> Hi Tom,
> yes, the CI is all green. include/spl.h already includes <mmc.h>
> unconditionally so struct mmc is defined before these prototypes.

Ah thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--z+JbjmB1c0TrDoKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqhoDwAKCRAr4qD1Cr/k
Cm0KAQDavmC3Zh6jrfYHultoKYgugcJ2v9ld1tZEKLkFsmGIMwD/RjPMz4py71+b
pIrbAByZ1LNj8uUs6vOvx/Pp7Qc/PgU=
=gt9k
-----END PGP SIGNATURE-----

--z+JbjmB1c0TrDoKz--
