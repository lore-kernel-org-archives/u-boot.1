Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE12606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZO4uEgbL;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Kh410sOR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6502A61108;
	Wed, 21 Oct 2026 22:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oqX8gM4wx3_w; Wed, 21 Oct 2026 22:19:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E1BD61243
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792621178;
	b=WbgY5bZ5zZF6ejMkM3tXuDWwjdfxQHH9phLtspK2zPmsfu3F+X6pRmn1rWN0TvF91QYR
	 TYXSY8+A+xIdsBYTplrsdVNZvJe+pdwi5Vmvgrgzmr6CSS1yoWxlxSr9P4JUB/EuthnCj
	 H3icMyxC3YSlfJjgiT3gpdcbtRI+4HhyAxQN1OrhaDHgz3MozC7BFA045XfLZqgwPcgau
	 pnt3x9sUvIXYt+MP2UtFH4Ts9jERyoHHQaZwB1hqkU9SlY7emSFSEDTkcUlWdRauliWst
	 ReA5rlVIKlIOopRLWmSebnqpm5lZC+RLGafkAR/qzIfGpJdvo5VslbMLO6xBo9ZbusQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792621178;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yFltw0XtUH92W89O99c1GsfFQJXmSJVVFkNihBks+fM=;
	b=qfr29tDnbqyXG9Y4ilZ9TP5algWSSRA88BdpAcgmAoiwfwXInY7ykoEVcQTZ/P6jWHvN
	 Z8Z0KozXS6SBsFQNx/bli7zkUTBrVDy3B3zrwgEgMRSLUOxDjugGVWxRoM7DjuN9nlXG7
	 7zsiW2WTo/ID1Ro4nPtL+JKVpvP3y7fmKerVV7dr/5OwVCwozfTmyb+kvYgmC9Fb5dfVL
	 dzFktDiEX+5gLbDO0CBUWJyow70XSUrPOKaSIc902oYXvRiz0M33D5zHYtGp3k9+4jGnR
	 43/dp77fFkhepetgLnUb2JUN8jw3KnQ+kmzYcJQWCOFfrlUEC7XrOmIPeTMPO2iwMSQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Kh410sOR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792621178;
	bh=yFltw0XtUH92W89O99c1GsfFQJXmSJVVFkNihBks+fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZO4uEgbLbsgNIVsCrwsgBkqfGTV4EMKYx8x/PxKlv6qOxjyyjE7bFBHvfe6EODojR
	 blkbcg7SZDu74DhgNmfOr4GV0ALjsoyndyLix2e102HYfYfl7mX57dgeMGR+TQ4NHj
	 Y3bCtgFYq0F0IVMWnLKPFyuKrmGoz5oJFAMSjv3YrDLkzzvFDTtbavTxmPGp5qRjPi
	 8zYGgwt/vNByHIuUfAL4QNpEXn4gzX/u1bZbPQlX2wo5NNml7ZCNYi0/Cum2TPjdq9
	 2YRWIs0yBX6IP2as8+sOI9d2vB2cNUr8ZRGRdgAFgJQSTQPlOkz6VVZau+AjwWDzuk
	 VkO/UwuG7i17w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E1BD61243;
	Wed, 21 Oct 2026 22:19:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 531403C1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44A5A60B2D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIxo0364r7ym for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 22:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9193E60AED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792620857;
 b=kAqXsfUyTGF9ZAmLCem01j7t5phao1Yd0d9LuuI6IkBhpiHRsTMd49W0RQ9beo1+sn1U
 qeZ9c+Z6eEEcpIjroC20ZHB40i6e3ehXuNhEn7f2w5EyzP7OhFftIeIQ9mlYnESRlcDSt
 JbwBYa7skdQHOdJ+/NHVPtkTTGwlx5CzvUuXWIYeMOgntHezbq0sznKrkJsIRdLgvCYbX
 BDmW+Qecnmt3PO4RfpymDG1r71eui82A6X0TqjaDwoa14OIVeU3vxmJ1CG5iOA6bL9swA
 JXyxGfBoxJd1mpdytw4dFu39S01vKBdwxmmhRgCY4WvlXcQT7fxxoJ+f0zV4TCiIIUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792620857;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=yFltw0XtUH92W89O99c1GsfFQJXmSJVVFkNihBks+fM=;
 b=ltq3RPzIdiU5JrufLwLlyWHD1b7hLEUR5fXBLLQ1treMODUm3lDlGHdzU7JvS9H84bvi
 R/QMMGINxT+cs/7u7cUC+0My3oDKabHGVRLu+LoYpctIheCewr9eWSOKrMaOFgWXRfT90
 bhqwvlityYaNNGIOxw4x2iPM4opfJfAQwuEx7MyoFL1/RlcQ1vFvY1XctniRjAq+ftNFf
 59+JZ60qrJm2v8p8CsLBw3uPfmC305UZ0VrmgYCGzIw9jhwbjO3Jt0ZPQ22+tJc7DgdZ6
 yrgqQ77xnfFz6fyR15jz3coYp/aQ+XnMZHB2XInBRwws/6lpWuCKZvIs7nWZon98MnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Kh410sOR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Kh410sOR
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9193E60AED
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:14:17 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-7037daaa820so482516eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792620856; x=1793225656;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yFltw0XtUH92W89O99c1GsfFQJXmSJVVFkNihBks+fM=;
 b=Kh410sORSERqAJI+aAiPljswzwbCx9HtAvnoUr1H6aecMrkLtitr2XY3qpgSiknlZj
 POQs8MMXZrdh25ATts/nMSS03SAAzZ0O1KDIB0sBVE3oLvkkKrhsL01mma1fRL4r6ZzK
 du1i5PR5uyx1+jhTuu7sXwGHpnXlK2Rnwp/jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792620856; x=1793225656;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yFltw0XtUH92W89O99c1GsfFQJXmSJVVFkNihBks+fM=;
 b=2V/hikrRYJcohgMOKbQ9yb18eHAfYkqDzrcGYeZcMl/t0X6DvwUr+U2dqcp2/ZfKBL
 1u+49Uqqv9Zx0cDPMq00elL46jgs+jkhZG1CsC/Gxn+8hp/GlDDg/A+b6MCXrvE+Ld/z
 OBVtt7B1yl8A9rssF3R/iDiRIBJrnBD9MJOaFkE0vwbthZdxy93ZsinJ10/3Rr9xiz4s
 acV7ZSWfzcPP7gW8y+ULJK/pCv4bZm7VW2R7k5SX4aeCzT+9ABU9OUoUm5rX/u6RaK2v
 J++QHxzQHvz48lh5kDuLpTaS3MFsgL0pRS7vvmFHjMdW8Z4F7tl2L/2sjLKXxVsCgGXj
 JbSw==
X-Gm-Message-State: AFq9FYKkO3+4K67OCE7ShNffHkWPf8xvWNerlNFbInGRdB4lqVIZwU+q
 5I2a6CkTGvMnGWvyJh3oYz5fpI/tyMYuYcIQL23Anmbvz7tVWOptvy/z7xtkuka5QAU=
X-Gm-Gg: AYBFou19LYsJKyPF9cWm1fLXHLHmB3sOSIYx6o5MY22FWaoenJZh7Le7HVFqMvMsY1Z
 ZTqd04PiyedQevp4yQlrc9eGb58eZX3ihA3e6pJrIj/r8+y3jHKRYJsBuvCb/klGRjQfLAYNwrV
 UOn8re1+OwIKiPClvwImAvMTJSr2r+QTHuPSRjK0TLc5+AjS1sHb2UvCxSEMSXtvarFuo55d3aj
 b2NwFysfNQo0GNegmVb/dmldNIJV/56OR9J8G49FhRl3hGmXhT8RtAGqPETkvVonjUZEpFxX/yI
 A6r0m696s6hiPLG3DfUMf5mrFKH5Tg1z1NTSam08HZNajCJRfMVR1/tKldjeM5lgbihahttiEPQ
 sN3iiu8r/te4obFGV6mePN1cECHt4Cf3akjKa62TPLCO0npoWnI74U1/efZGV0kaMQsQKD2tNGf
 0NxbDDCoTXm8sXdoIcWVn2/lLSTtpk9QZ3I3EeiX9NFH1+kDFmmIfF94lWrJb9HIatxSBybTwsI
 kDn333mRvGSGxQkRKIvj/foRKkh3hv7Wi990QIZBA2mn/ZXEru+7JbSJvb3yWgpumRFDQwK8kqq
 5phT/Y/Dx20GoeYVmo7qGjskP+BvjCnJr03FcvAXz2SXDpcGZv+Gcr/LtYHmrRvoImk+4kSyK00
 u
X-Received: by 2002:a05:6820:4df1:b0:704:2628:b1bc with SMTP id
 006d021491bc7-7094182b668mr2190878eaf.50.1792620856215; 
 Wed, 21 Oct 2026 15:14:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d611b380sm3007444fac.5.2026.10.21.15.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:14:15 -0700 (PDT)
Date: Wed, 21 Oct 2026 16:14:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>,
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH v3 05/23] spl: fit: Look up the compression without the
 table in a tiny FIT
Message-ID: <20261021221412.GL3275858@bill-the-cat>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-5-6647aa23ade5@flipper.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uSomAhbLOU5bY7Af"
Content-Disposition: inline
In-Reply-To: <20261020-spl-fit-compression-v3-5-6647aa23ade5@flipper.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 21 Oct 2026 22:19:28 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--uSomAhbLOU5bY7Af
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 08:40:52PM +0400, Alexey Charkov wrote:

> SPL_FIT_IMAGE_TINY keeps image.c's tables out of SPL: the OS of an image
> is looked up by comparing its name against "u-boot" rather than through
> uimage_os[]. Reading an image's compression, which SPL is about to do for
> any decompressor it has, still goes through uimage_comp[] though, and
> brings back the strings of every table in image.c: around 2.5KB on
> tqma6ulx_mba6ul_mmc, which has SPL_LZO for its multi-DTB FIT.
>=20
> Do the same for the compression, and only tell apart the algorithms the
> phase can decompress, by name.
>=20
> Return the compression rather than fill it in, and count an image without
> the property as uncompressed, as SPL always has, so that the caller needs
> no default to fall back on.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uSomAhbLOU5bY7Af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatk5NAAKCRAr4qD1Cr/k
CgO/AP4u14hezbLw9+/TLOUATq9g/w2fxXBoHDM4hiq84kS1eAD9E5p88QPA0Ncr
N7FOardlewnrGUUWk6RoZ3zVqPmePgg=
=xrln
-----END PGP SIGNATURE-----

--uSomAhbLOU5bY7Af--
