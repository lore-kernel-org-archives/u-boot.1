Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B116606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mU6HE5E4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LePGkGvg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E52874040F;
	Tue, 24 Nov 2026 14:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SNlQ_VJ64E9q; Tue, 24 Nov 2026 14:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3EC8940462
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795532063;
	b=iOyEgd7hSwKthvhNeGNIkzSEjQr/NzIMes/RopgFVZ0fR/TDilisLwlVyRImJm9m/tLF
	 O/hJblyIN/FfyDF/V5CeFx1egsg7kohJWr8mqQ+nXBA2bR1SuB1gMcCKXrTbwDLwtBqfG
	 5pU/3OMRUHe5CRrmVw3QX/0lBGxa7MS826Ig5CUpcOpIoHQmPt24EvapL5pMG4yLV1Dmf
	 55sd1nMjumW9qG8XZHzb8aw69wjug4Og1mj9pI1LwftgYpABDdda9HeXaR+nuMV1rtNlQ
	 zZDREKY8kNmYqZWEaPXDSUnYgnf2rivBWcDxxjMBQe0tGXg+Sua6vN2J6G8K1Q51V8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795532063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=omibpti1qw1x6EjlkCe2d5W0pMX6VMcm1NXkj61iWH8=;
	b=CZg++doaJ6kethyWalJFhZ84luNMImSFvnhDC0Mh1JzFpGfuFQIzr4mfgz3iVN0exV1F
	 F9wypTNLnUcAkzkoWDuWbBBqsRw+W+v+A/CagTJqVSmQ1RluuxyBZqSyI04jbnTViWXuL
	 WnZqTHulpZQZjUD1CoNJiAVq0mdrEEGRylaOyxQ031Gczn7ffqWMZJtfjLBR8t0kUO/EE
	 KqnQqH4cJolw59B/A781LPfjW2WYqTGPv2g2Df4PDU0SIgXmrYnQrGdLNor3+05CHbneH
	 kC9mbt9MVF+YIErOkwajvtilh/hQ4t7q1+qPb8LgAGSdLEZl6cm7l+iCwtuGjc04TvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LePGkGvg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795532063;
	bh=omibpti1qw1x6EjlkCe2d5W0pMX6VMcm1NXkj61iWH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mU6HE5E4LyEawhqGCU9Iolb4unTAL2halqkSuGKSdGPeXYTiZDdcBE/rbsgWz76u1
	 K0K2C0Ap7xvNCOec5lir/v6WN/ERZ9Phj0cE+LAciWLNmIrIVYoIn6/2yKfOrT7SQj
	 oI5kMn7+AnRrRBAJxVQM96j+akgA3JFwZkSoLdNWj7GpmUSIU0JOsYdvavLhPhY2d1
	 lFn5W5JZrrl8aMLLTbmab/FfBeNM0/wrw8mK+aA+hWFawEo0/nWfLdmwAFpuG3wYd1
	 k41GeYYAgZiYfc+JP35AXYfnyWciplE3JGO36LyBK53KY9XGAoTfVnfX0ftDP+0VnC
	 MZn1/rH2yOjAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EC8940462;
	Tue, 24 Nov 2026 14:54:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE05979D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93A034040B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSgQ8_XHPW2j for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 14:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D9FD2403C7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LePGkGvg
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9FD2403C7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:54:20 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-71b45386310so2022751eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795532059; x=1796136859;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=omibpti1qw1x6EjlkCe2d5W0pMX6VMcm1NXkj61iWH8=;
 b=LePGkGvgSEPxq+T/6q+5wnFqVvcMlqKDdPrjAR0M72ZGGJS1oqgUYSCTIXm4L+4a5x
 YIC7jKcm5+bisYlWHlSzlJ4hPqx5UrW0hDMRYh6kl4O69TkM99jlU1g/21pjTdwSEe+A
 DPvNz05tdYiLeMQ2bx1v/968K4FEPKz6AmTI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795532059; x=1796136859;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=omibpti1qw1x6EjlkCe2d5W0pMX6VMcm1NXkj61iWH8=;
 b=f2WzPY4VP6EzqBP+STIsTbtyfTz9sjGueBaeBKdX5zolD64n+o9Gki5cTzXD8Tv0Ev
 hdeEwp4d+5fqQQgliAQCC9ZK5thMkfe98HdB49G1bJ9FR2Tg/4Q5FRPBrx5appRIlP6B
 KjIGSIP6ADLherN8R+0SOomlmaKnuGKeuYMnpk7LGLr05r7cFHC6pk+aEC259KE+eLMF
 Zg1gjnBIxkie6NkNjAXgaMtSv4l+stLUHfI9q4ues4/tvAcxvzH+EnmvVnVrhoR+ARqg
 xQryDw8R0JcLXc+9TF/IQ2wwKnO4vtsIKyoTv2BnGb8rYMhWq2F23lunCB3rBa68kzUW
 vtHg==
X-Gm-Message-State: APuU4Z+u45VyCs4+Gb7uzorNd04IiZ/SmP/PBhn6Jh24AZpmXs7lVNP/
 8HC1K+mJRLJc4sq2VczZq3H738BfqHOcsY3Xie5uEgli0Cfq1nWDHRvYSC8G0JRZgmc=
X-Gm-Gg: AZFdTZf+P466pceV0plg8PYhWACKwGfGdlSWwF9B0spq6WnYoBrvxzIS9Dy3vetM6Vi
 1QAxmZT+FWuQg517DgfsLOZJa1vybNNL2lpP63cjgWUbWhoEKOfoFzwTFNbppqA2zOUYlzJjRP3
 KG2AkuJHiJuIS4hP/OoyvKsC31+cThqnBfkW8VZIezW1v8cgz++qpg0zrkok4c86T4Egf5Agr0R
 DY7w387bmUVJiNaRopno4xk1KUweeCAH+fSrclsMb35XOrfFC48VK9rE1bJXZCVO99j5xpDLPcW
 HHtftpLhaN7abELe2O/SLZHHxM8qmsOUfZn0QNWo0pE95B9OTyvjnLtvWeTQ49tDZindnMfHQ4H
 wKldTgDcw1/qeSQ77cNYjTjEo/Ri1w/Bt0K1oqItliQLQlQII62n6tD49pI+Pr9+hbwu/59+wA0
 89S3pLVUClbgAIrJ4kHbCB9GidoLYje080fs8tZa6iwsMFRQm2RbDoBpghKlAsp1ZqkwCKH+apl
 /U2dZATdOFReIgw81xLK3O3kU5H144Pcevj6GCgjF8+pNtumWzdIG+EVwn4CoRvLK0axVm4xrDu
 bjqrcttawNpjEkP49jnRsAEaoMseuCqAnYehgefhOaPtpfr+CgqbYxJM/Akjmc03Eh9maQDLjh/
 snSy5eLKVyyag4qKTZIG06b1JvSGuLZOQojXE9to+dslLb+71F2xsH91vwckHQsCW7L2QqrUzeK
 XqD0D2mtaJZ9XrApLggX28J57fdrr46Pg=
X-Received: by 2002:a05:6820:4185:b0:71a:fb4b:a990 with SMTP id
 006d021491bc7-71b395919c2mr10284339eaf.79.1795532059312; 
 Tue, 24 Nov 2026 06:54:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b37ea8472sm9518897eaf.2.2026.11.24.06.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:54:18 -0800 (PST)
Date: Tue, 24 Nov 2026 08:54:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Ssunk <ssunkkan@gmail.com>
Cc: u-boot@lists.u-boot-project.org, vigneshr@ti.com,
 takahiro.kuwano@infineon.com, vjardin@free.fr, Jacky_guo@xmcwh.com,
 hs@nabladev.com
Subject: Re: [PATCH] mtd: spi-nor: Update XM25QU512C to XM25QU512D
Message-ID: <20261124145416.GS3176972@bill-the-cat>
References: <20261124123624.471-1-ssunkkan@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N2HuBKtUbMWXkvLE"
Content-Disposition: inline
In-Reply-To: <20261124123624.471-1-ssunkkan@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--N2HuBKtUbMWXkvLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 08:36:24PM +0800, Ssunk wrote:

> The XM25QU512C has been discontinued by XMC and replaced by
> XM25QU512D. Both parts share the same JEDEC ID (0x204120)
> and are compatible with the existing SPI NOR configuration.
>=20
> Update the flash name to reflect the part currently in
> production.
>=20
> Signed-off-by: Ssunk <ssunkkan@gmail.com>

Please rebase this on the next branch, thanks.

--=20
Tom

--N2HuBKtUbMWXkvLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawWlEAAKCRAr4qD1Cr/k
Cv2wAPwNk7W+V7uv4gJLL51wSQ6yVujicfa1XSbUNZzDdCBX3QD9EkQaqQzcTcAW
vwSE49X8YqC7wkuZ0Q2nGuPNixhZVA4=
=9sWP
-----END PGP SIGNATURE-----

--N2HuBKtUbMWXkvLE--
