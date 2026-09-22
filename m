Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C4BC982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 15:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AECF40AD0;
	Tue, 22 Sep 2026 15:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8XbSBmd9q5S; Tue, 22 Sep 2026 15:19:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4749140827
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090368;
	b=hOE5VX7s3JHAqQrPsoTwFbd+Xcq3YMP0C1nhkO6Kea58K/1HwZLqukisTBbqn6XGklcU
	 igM1Lqcj3x/dOceaVJ41iiS+qG6XgORCOH/sY8XV+bEkLqKm2ZREICHhIyyD3mYtAw/uD
	 pfL+0BMTKs/68vd+6c3QQjnYgoJaushX7OldfQgEL0iCPUf8FRbKu6UKB0jpLLrZK/AIe
	 TegDux+VhLVcnaOMlICl+W90xyzZkYN1qa6auR/j0+DnUpd2lXkuq69mKeDSJla/8mFGG
	 olzidXoXAtCdb1FaU6wNMETgjonDdqsQXj8hWD+OiN47DXiWNsfa99YcgEtgs3ky+oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Yhb8PNz1idk3qL7hH0wO9jK1wO+E69HdruMyY92eZlE=;
	b=QxLEbPmXr15y3tA6vuQ/JHiBhfb+1qmwItL9w6bp9vyz3Vb5qlmhPUoqod4DaBLpXtJH
	 AE+/tCnXWOpPRo/dH8J41SjZGv8PFDBq2Hd403Xwjx8L+rvsFpuMSr04P8EGl9HpFmkFv
	 MPun//3e/mRbSQVhoYgwRIkXGQy3ZL5JZb5LN0TyqIjBWiDNBshvAf7XdcSeK1ALUWykz
	 /6GRgB+eYukQ0JBIEOE0bsfqeakLK1jwLhv1XqvynHLmoGvQnptTnpXzcJjbM3b9XnFwD
	 9Q1hxrZXR4RIY4rK3xr6sjBUaKjBprmfR90Ym9akB78Bl7Ea8MhLb3YGJ+FXS81hN1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790090368;
	bh=Yhb8PNz1idk3qL7hH0wO9jK1wO+E69HdruMyY92eZlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ykbskAwCVqqwoYRXIo8A3c9yZyeQtCzBJDsO6rLm6ZH8cIqlM/FwKLw56Hv2NZgwr
	 NlMmXvUxXDFZOkUa0eArTjrx5HPHCaAUdd+XuR7jmz5u/p3D3jyvHk2HeOhcpHOjn/
	 sgQXbbhmCx3wQpBIN+uWHhWC5Fm3dJESqu4sgp1UzzUJ8s6v2/TKab+HBuR3Q3JDdy
	 3VGviHZ7jG7Vn0mQ+vczE6vXuUDKNbKFOfKNE1cnTf5FO/5yNWs5E6EqdJFKZI/+01
	 DEyQzSfJzjzKZzV3ANzIr0KNcqrFqS6yhXKTFhuKPzsAgP4a2SBuwk8rIz5ulprsZC
	 hKK2bAA0gvnJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4749140827;
	Tue, 22 Sep 2026 15:19:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0170C9CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E75696063A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fl7dkVgXIYme for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 15:19:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 39CAC605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790090366;
 b=BP2e1WLdcWXWDduLoPMS11aC9GWdcsu5vv816i38f+G83AnTRt1RpFbKEte6/cmcjmrt
 yxdKMZ81WiBRyBmEmWERlWNhKcWLZUMcSEZ9Sfr8T14vKdBFp/yDXpsZPp8uXjIzoDqRP
 DTFD4gEjCsyp5P7SsQRBDci3EPIMQXeusYPaknYmIPbyW4W2N/0RD5ErGvalPj+Hjh46z
 6Bf5fMVeL2usGj8a90fIUEQmA/FdVwf14LHAUd2XVBMw0lhJ/iNOO2PbU+u6ZCY/QLg2U
 SEX1bBVOTTN1BrGP+84nbDBgg9O6no5kFUcyoIpMf/GaIoDz1JbCCfMusaDJOWIMpaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790090366;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Yhb8PNz1idk3qL7hH0wO9jK1wO+E69HdruMyY92eZlE=;
 b=H762lWu2BrEL5GM9PFmBKEVGPvQ3oQOdqO/K5qG6dSAoNjW5rGlu71L+bvQlkhUispFy
 1xk9uoiqYU1VaT/z4YHiuymqinAWwrzIX4f3Tpaush8VlyQonWdd/PC3LFOKbOOeFnk+r
 AkTGsECfPvuyrk2ASo7QJz+t5jX27O4bAl7vBw0GwMGVsJqqckdtrKWrIiEWGZZznaf4Y
 KJMAYbUtYXITjIzaiRBE1PZIM+912XFzZH3MMjc6V1Tokc9UeRFj/QUG00UhvHVP/IlLi
 sDfU0g6W2+xK4cwULDDjEpHoE7TkgsnKQs4K7Olqua0/QrlCLP9IPc9RY6rZPVHmapg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IxK9b0R9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IxK9b0R9
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39CAC605EA
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:19:23 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae6f5fc5so1951607eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790090363; x=1790695163;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yhb8PNz1idk3qL7hH0wO9jK1wO+E69HdruMyY92eZlE=;
 b=IxK9b0R9ZzjWKixElNBlVhvHiOH+g1xFZfRnVxSQ4TrBxJe9q7Gm8lTZ5XKTEvD03s
 Fohm3/aiRisawk6tdcorVIo3gsluOD0gWI/v4wpPwp5rX4EbdaYBnAhyFGDGlAuOCk74
 kFQWGl+5E6p5TZLGAu1RXK+VoSZSGxwAQt/vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790090363; x=1790695163;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yhb8PNz1idk3qL7hH0wO9jK1wO+E69HdruMyY92eZlE=;
 b=ZzCunaA0nhE87MC+AmGAn/LQjYAXGvkiENVXQXieejYff3CS6i/6Hk+LasCsovXofh
 P2WGiqmdvC/rDGw89R56FjD4m0riwgKDn+fnQxpy9TfXx9PeNYfG53IxUw2DIuDnMD1w
 FW99LQGFSaECmL6ehUlCU6aGkUbbMt1S1wOaHgFq+hZpDJqhr/CmUDy74tmRLJO4S6Ch
 KMmvMWfx+w8lLWNoc8eTbReZ1+WLCqNadi7xMExGypAvni/hCVwu1zbt6UF3FpON8Lzy
 Nb0HKeBJ+ASQ97ykpXGkCS/I4EllaB0zAuglP+kn8X88OtmWKgP4Va+zcXniBZGsd2wY
 m1NA==
X-Gm-Message-State: AFuF++kulttvQ/G/QqDYf7AYWqO0K05+OIT9WEnF/n0r/Yq7IPSHsaBM
 ajKqZC/1QKoe4vXZqVBGiYQzOX7CQwYeuk8K8o/rec5kxcpCBe3pvdNIAGeSS8Bhjp8=
X-Gm-Gg: AYBFou1g+AzfsHBKVxh/73UGVLcTiODHsF/r9gnoy7ivhT9Sx3TnS7QZyIwH3w2IT9Z
 XW0fAgKe70BztXInGtJyYuaAa+r8Yv6G6Yj9fi4gwTrnmsENHadWjsvXton6FNUjmNUSew/p2v/
 VCsVK9OJ322hZ/kpSA9Ld/QcF2lf+j8RY1PQI7BKKGLHS5t3svfmQhj3vGQeKzZCcTA8WvoEyfD
 8b/hffCQ/EAuUN2w0YB9ge2+OZvSERnzEdvccvij3RdNzWUqssOitU/jtbMe7iEgDvM/UT6m6PY
 74FoxdnjW70OVu+8VkMUb5wZcVOKDQSsrKg1jp9vZpWGbEzBwijm7d7XCpMymaEiO9IE4SY0rmW
 aWHEOlpczOVQOrktsmA+1vz0DDe1hxqHr2WXdHhFZX66imnNcvQgHb1s4ClJORTBEzEk+wJCBZ4
 atHdlRZokzhO2EnKFsOHLIiNTOf/Fdw5eMHRHOst0hLxmWISg+fF+nn9wjfBq/l0nCAGlIgeN1W
 OVw+q9vspNzxQmDHRuHd/QDXQY/o4LaUZ8F29mxai4/Zyis2a7SwJtNkrMP/QRi9diBVqwIStbZ
 LxCthQt3As/YHzZcaJCYtF5dmNVcUA==
X-Received: by 2002:a4a:edcd:0:b0:6b1:404f:6eb4 with SMTP id
 006d021491bc7-6ca9a0270f0mr11956396eaf.9.1790090362855; 
 Tue, 22 Sep 2026 08:19:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d1df2b5ac7sm1563939eaf.14.2026.09.22.08.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:19:22 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:19:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: u-boot@lists.u-boot-project.org, Weijie Gao <weijie.gao@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH 1/2] arm: let a defconfig ask for the Linux kernel image
 header
Message-ID: <20260922151920.GH858934@bill-the-cat>
References: <20260920151512.401899-1-f@lex.la>
 <20260921155055.GZ858934@bill-the-cat>
 <20260921191406.3028860-1-f@lex.la>
 <20260921202152.GB858934@bill-the-cat>
 <20260922102812.3981001-1-f@lex.la>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZJ8lgfTv3/IcRWHD"
Content-Disposition: inline
In-Reply-To: <20260922102812.3981001-1-f@lex.la>
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


--ZJ8lgfTv3/IcRWHD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 01:28:12PM +0300, Aleksei Sviridkin wrote:
> On Mon, Sep 21, 2026 at 02:21:52PM -0600, Tom Rini wrote:
> > It's unclear to me, so it might be unclear to others, what the use case
> > you're trying to solve here. These symbols are used for (typically) when
> > we have some prior stage loader that assumes it's booting the linux
> > kernel and we need to fake this enough to get loaded ourselves, instead.
>=20
> That is the case, yes. The board is a consumer router whose stock
> bootloader only ever starts an arm64 kernel image, so U-Boot carries the
> header and gets chainloaded as that image.
>=20
> The offset is not zero here. TEXT_BASE is 0x41e00000 and the offset base
> is 0x41d80000, so text_offset comes out 0x80000, which is where the stock
> loader expects the image.
>=20
> 2/2 only adds the default the other machs already have. In arch/arm/Kconf=
ig
> the symbol is a hex with no default, so a MediaTek board that selects the
> header does not build until it supplies a value. mmp, rockchip and apple
> each carry default TEXT_BASE.

Then yes, a v2 where you just enable this for the platform that needs it
should be fine, and please make sure to CC all of the mediatek
maintainers, thanks.

--=20
Tom

--ZJ8lgfTv3/IcRWHD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarKccwAKCRAr4qD1Cr/k
CoIhAP9Z3CS7SiR6RSsHMmi+ovM/LE6mKmVDb664JtbZQ3C3aAEA0ahi7VKDi3ua
xFy7Ubmi08BagHGwDvSW36Xc9CvqlgE=
=8wih
-----END PGP SIGNATURE-----

--ZJ8lgfTv3/IcRWHD--
