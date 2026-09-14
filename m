Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE000C88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 16:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9172080D98;
	Mon, 14 Sep 2026 16:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ld0zXGX7HNV5; Mon, 14 Sep 2026 16:40:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E624D80E05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789404022;
	b=gjX72LdqiQjU7D8U2mBt5AiFmQi6kl8TOfaOCno7CDHpCj4RELt4TlIvF1k9VZhsiMWH
	 Q6THsKY5s0/uwyIzxgWV7ngppIdX6w674IownUWk5RU1SruL9XKRAjXgGsAxE4fuOvwyR
	 RTIkh58Op5nDPSdaGDTWW+F/W0bg8TJ2sCcsWcB5l4rMyFNeEBuL8He4lkRKqcXJ4QbDe
	 0jq6OdiVJYnQuH3Ka955hYrTj2IMa0D96i7zGDXqyPjFd2MQo1RI4a+I13phROplqKuIf
	 DGhqSZhwX9BaRdUVurhKmey7dzQJMGwC7W3/VKoaTlGVUOug3TJ+Q2wiHq+w44JEPHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789404022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6+xvSijkHpe1jM5MlK5LIkj/TFchvsY4XY6AWxd9aE0=;
	b=jtUZA7yg3AfcZvtcAVS0rsfDV0i+3Goc8GIgEAcPUDQt+wjeDTIbh2tfw7dg3n531noR
	 +Y3vu/CyCS6T9Ld1SQ/6LBvQWjr51YoznmFPvxQxMx3jFwQ1YRBya649AgDyMdTqxK9KV
	 l0SkvBoxIOLgspJpRmesjeWb9uo6fvM5VSe8iD+P9BXKHRAYSNruaZmxQCT+e4w4K0S/Z
	 +fJk2k+xLF+qVQ6Hwso3WBOt+e5N90AnEngyYm0F9OVIjEJnOAQ7UIKIAwWr2IUVNArZO
	 ou9s7VZXHbSmjkeNn3MH5IP5YFPxmF85AYuOfzcI9+aqw4KP/tiorgEEb6qVxvHUMcQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="i/DqXa2j";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789404022;
	bh=6+xvSijkHpe1jM5MlK5LIkj/TFchvsY4XY6AWxd9aE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WYWEa3sFnTng1ZytiG8SYAxu0iwqwZHTS9lesyLNzXgIaYJdjxViokHzjhYxZ1xyU
	 EauvwCBmOhnLvrgMOrF2a6e6S9woE01mj/JZT9CF1hQRc8QMO5xHfBDdqMwJfR296P
	 a0A4RdtiJ3hrbT3otwdhP+gJk7d+z/MBfBrp1GnY6CGNGi9HJM/ndMgud9ekDB0xbu
	 xuMGHU2UT/Gvzqv9tCAd6y/GWu5Z9+AXbowmp90Yxy+YLSkpOeEnJSf5JASHjEMPTt
	 bnxRlSdUx+0q7ibo9cY/lNIDkesf0qXd5LH+8rj5dBq8+84bXWGtBoscpv+P+AV46Y
	 hjfHR6yGcyakg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E624D80E05;
	Mon, 14 Sep 2026 16:40:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 847B0224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8185180E05
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLoxgZFMcYw4 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 16:40:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B316480D98
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789404020;
 b=QpXZrtS19U1SAkKbcC707sZQXfL70xXt9l8KAD7vXWh+GvOExDcgfbf9dvpTtk1pDRFj
 1ZhJy7MYqyobU1b1Ru1JTiCfbBHpxRr2GIvaEa60tZ7tQqYzKksw3p8oK8UcFEjZM/MuL
 it5P7ANNAJ4Yy4mz2NleJ5xoXeh/DTcCQ1zDzlN1FL7rFNYuj4wD5sxDeUJiWEnwes0wZ
 S13LF5eEYU1My+n3jaka6KNMO1PTi1FbQSt9t+sgotmMGSeabiU64YWUJPWgytoX4bAOQ
 P+YPXixbS415buyn+rId91GuK+eP3SfDJd0S5MQqNIvuTqgG8faor/3SqQhtCEcGrhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789404020;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=6+xvSijkHpe1jM5MlK5LIkj/TFchvsY4XY6AWxd9aE0=;
 b=O6xNK7azx2YUoyIgakQPy2trt6/Uen8WcC7Z/62Adg93uYItliDD0xQ3WoSU8tDRnqC3
 2czffdJTkkRt1JlMzBJXOvoRuEoQhM7bYWPe7dZpvmIofnebhhMTD8aOJ2uEFwmm9hYhb
 1sPdHZBKWCDATpLvN24G63kTGCw2pQRLVryhxMo/hA6dw19vj+olSDhjHjOUrpdVHMC9W
 x9TTOq4/NCjlBpxRN1mNUzPppyu0YFO63KWH1meVGzxLpwNaEHcJQGZn7zx37N01kN5Tz
 bGm5Z9aMPKB5GAcOXu04eB3obbI8AWucCNbUkcF/1PJnh/22dOopd3ctpMywOXFXZrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="i/DqXa2j"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=i/DqXa2j
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B316480D98
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:40:19 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b4bff33d18so889655eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789404018; x=1790008818;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6+xvSijkHpe1jM5MlK5LIkj/TFchvsY4XY6AWxd9aE0=;
 b=i/DqXa2j8gG5YfoXf7eH3F5hpJDMgZNQ/nKe7PuTIb0w/f+eIvCNWC/aHSCuC57YIo
 iYQEQDDtMTr25J3n2HRgi0bMTIUpAk1YwpIkR6Itt4Y7lyck3eN+7UkouH+GhoD+hSX1
 HCW6VjDZAKggLwfLqYaViTCbKzzlHeW6tqQdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789404018; x=1790008818;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6+xvSijkHpe1jM5MlK5LIkj/TFchvsY4XY6AWxd9aE0=;
 b=Yta8pX9N0yhZ8Y/VlBacxr/pHR9aUs0qfjjz2x070jINfQUp8r4Pg77Yzs4NJe29Z5
 Xm0qHH01HTGX+owxZzlfsjo1abmcOmTWFZ9B5IIduxpZg7Yap/+Rgmzi8SmbKsoEDK8L
 COXQk7pMteP5mzQ1tip1uVJWwWDa9VNtg+hPu+ikwqRWiPbPVhUn3LZKROYXvbVIeNiw
 1r/MQZXkK3E21OALpMN+T8axW6iUpvOzyDu2NbY2UOvQo2XEKTJFuJ1lEC8SxsMudCRN
 jvqOZURRXbEHEagMFDPS3MSwoLPTGcjbdBpPHUNpE+b1nBOCagpEsk+EU2OVHZWdLOqZ
 GMcQ==
X-Gm-Message-State: AFuF++km5tU9vjDdsV1xgThShkqJ1KyMDKg0vvVLiE9Dpo42I4I+qZoP
 mSLi398JApbs/mG/4IOnbwmSATqQkWNsLF15zaZtTFKqlp950tARkOJ9E3ZWAd1jGIg=
X-Gm-Gg: AYBFou0M/CGonBpso1XgzkCdmtUb92qznCFn1rOBXS5/4rWgYnKdHslY4Jxha1cnk3y
 fv/e6II9a3IvpH4y6MU+FaNWYSeWKaevN+f7QADdaWzFkXzfj4ppXvLQaFE66x2vsQNJdsBkStM
 wA/YvSD3cCjjF7KjhReP00YA4moEh8IC7tq1G5fuyf5AWfIiKqIy8xRqJ0LWLdEx0+YrenTO18Y
 4666S52ptfS76ja0ZFla+HIp+WjgxKL+FoQ704hAjYExCv+7n7M+pu0zNV/xjd/dHtySEBn58J0
 TCs0tQydrqf3AB1hWGRo4MIS/gVY3X+vSxVV3xysVlyIStY+CpPAhOyqahQN/LqL/+BLXbOk9AE
 r5VqbibWg4nQ36+UjPGIzyZ0DkV3H56kTozocyvXQvlLhEbikRizt1PKZf17JQGESGPBZi/AEpZ
 J352rA63sTNwGBS9SLKhvMBbIwLdjZgy0wccFuADaPKSbCwdzHEK2aNJsAQX6AO2fWK0C9T7/9G
 fshlTHmeqhShaSwCv+9V5hAvAuT0lM7Dr5MqQ0MOYtHc6KsJ8E831vme46MSiARtMPsajF6JSba
 KT01g82PVW+DLqaV7tub
X-Received: by 2002:a05:6820:1792:b0:6c1:8b6b:ffa8 with SMTP id
 006d021491bc7-6c53fc70c65mr1867305eaf.27.1789404018305; 
 Mon, 14 Sep 2026 09:40:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c2072f33fbsm8943404eaf.12.2026.09.14.09.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:40:17 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:40:15 -0600
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
Subject: Re: [PATCH v3 2/2] spl: mmc: make raw partition selection a choice
Message-ID: <20260914164015.GB1764417@bill-the-cat>
References: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
 <20260914-ccaione-upstream-part-dynamic-v3-2-a38c19e74563@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CSEVGwbY+QvUzufn"
Content-Disposition: inline
In-Reply-To: <20260914-ccaione-upstream-part-dynamic-v3-2-a38c19e74563@baylibre.com>
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


--CSEVGwbY+QvUzufn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:31:38AM +0200, Carlo Caione wrote:

> Boards using boot metadata should not have to configure an unused fixed
> partition number. Make board-selected partitions an alternative to fixed
> numbers and partition types in the existing raw-location choice.
>=20
> Keep the selection policies together so the MMC loader only has to select
> a partition and load it. Selection failures in dynamic mode must stop the
> MMC attempt instead of falling back to an unrelated filesystem partition.
> Existing fixed-number and partition-type fallback behavior is preserved.
>=20
> Distinguish shared partition-loading support from settings specific to
> partition-number modes. This keeps existing platform defaults and guards
> while allowing dynamic selection to use the same partition loader. The
> STM32 fixed override remains conditional on its static partition setting.
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Overall I think this looks better, thank you.

--=20
Tom

--CSEVGwbY+QvUzufn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqgjbwAKCRAr4qD1Cr/k
CsYvAP9MjUBoXf8uj92aZqYARe+YB5Li20mNtoikBc2tNiqRZQEAgFfwTQsi+Btx
hbZhB9UpC2kJPp7GbgLhsrtWKoT87QY=
=NyTu
-----END PGP SIGNATURE-----

--CSEVGwbY+QvUzufn--
