Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B722CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 275F540CBE;
	Fri,  2 Oct 2026 14:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSk3tIFlOMOs; Fri,  2 Oct 2026 14:58:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7FA7540CC4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790953110;
	b=c9MG01SQL09li8Lal3wfbSZRyg9m4KF1AfVF20HfYQn8otEMhJIXubxwhG22/58xns1y
	 cj49Fqg+KZomsGcmJRe+lIrjeNP5AAQjmQU/P+UwX5tVCu4rPthURtzlNrNOqyesUeolJ
	 qMijUc5BBhRy1I+sYcqYkfNKQ8Ad0zXuGXyFLFbMjBbB69VN2+A94wfKbWA/iJF5ucrQ0
	 /VrzBM3yZ454fY5lu8HpBJIKCzn55anSDqopUTMmNCD94m/671UWITUpIjzOpEL+2kZCR
	 No372jTKesWCuOHJaZsGm9YU7ep8kU6NAFmleweIJkZ8e+qASDqrN1NlPRnpCJfV4Qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790953110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sd7Wsm/NEppCAKbUwlSjgpdD1KSWa0AGvfAXKfQQMRo=;
	b=TxtwGqOCG/zpBNpfSjXw2IxanSNG5HtUCM2ufjHPzo2Tl8RCW4q8XGWZD2eEQKEAX+V1
	 ehmiEjWFF40jTymGg054BaER5R3XY11ww667qzJt0ELVNDuX9SoPlMa1cv1Rj9WsuV31A
	 6dhsCAwTPFvECkJObNyeE/qbBXVTNrrwXCoVOrPj//FuFLOXguyHLj4amz2ih2XDUhPi3
	 stxjukKBImSnnFKfZaHftB1U8ofiqEC4/DAovxK0SjipI5Tw3hfGUFNBnQM7MaVrMQoqw
	 wbfh3mPrO6zYC4qD0udAxbJKSM+vuAvxSdTO+DUvItZMZ2ZSKuIx7SsWLNWOzVFT6Lw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="LapX/rx9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790953110;
	bh=sd7Wsm/NEppCAKbUwlSjgpdD1KSWa0AGvfAXKfQQMRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xHrZEl95z/Z4EBRCU3DymFGDsCiQtKYh9hg6LYEKMzub/WxY8ka4c+Fj+4CH7X+B8
	 GKkyqGXPYQqSgOf2GFbosunHRePOfsGBw5otzz+GrPovpi7/VpDc88g3htklhDMpPQ
	 10n7gMuO4M+eMxRwC0BnNi9F3PsX3dy6NFKGVojSdlORpsuJc1qQLxw5O/bV9n3Hv1
	 Rpe/5yrUfOEW5daHOee5FBDjGKAf5oEO8c+rGLk8S5TKoSficrbuJy02ML8PLWmt4f
	 ohkg2/HtpgCUaY+q1NMeJsFpCUFNnL/JEV2cv+G0vn/eXTVhsvjRS1z+Q04Cnpk3qr
	 dS7uusIe9ydMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FA7540CC4;
	Fri,  2 Oct 2026 14:58:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A2A7435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E415440CC4
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GR9GDb61SXup for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:58:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 20F8C40CBE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::19"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790953107;
 b=AjEKZnZG1qQqFKv/9+PbMFqIyxSg5gMSRqw14d4mJ5iFjJUtsNkm1OhUTB0VGQOx9Dfj
 PgNt+nr/EDS66Cb90qwd10hpgS1EdBm+o4/Hyu6BRcO+xJJ88nShxmmbl5ymjnSwqKZnm
 LvQ4Qxa/654pm1TwUeHm0nMpBUsVacaJHVrcNWUirGq/0sbMTajd7hG9jZF9ILR8DJhwY
 /xy8085pT9NAijmcmkD7QeVPLQUpZK+mY53PFuqLNdkcEY9u9EcxTe2jOujoioxC770X/
 iJHnl8ODAfs9YtXA4X21r+YAMkW0sRaCyCSQB29oQZ/GB+KrKrg4neqPAZ1JnPTuImg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790953107;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=sd7Wsm/NEppCAKbUwlSjgpdD1KSWa0AGvfAXKfQQMRo=;
 b=cplQ8Em4OnPmSgLzoJpMQLZbYjE0wpHlhCW/T5fY2IWekwuR3aOnUy878qmIfSI7OZBN
 aFiVycHsOqtuaUWPkQAHWMtpv0orrXggHuT7Rh0VJ1l/zjCSGDaY/U1is+DK2Z+e6FFMn
 M4cTJsgndvbtVR9t5eeSSujuKoErQSRHUF3ybfdSS2HcU9XnhElJ51N23h3P6Nx1qeo7I
 jFn2JB1X4nKFOahhEEDjqUPVfnB8EL7q3v9R9tvB7QZZdRGF5b4yD0txPvnSEDjiDJ4Lj
 n72Xyv6kU6kI6WYHvIn5N4GLUAJeJnokEQId2SCH/gCAFOeCKa/kplEWKIXrDSubhJg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="LapX/rx9"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::19"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::19; helo=mail-oa2-x19.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LapX/rx9
Received: from mail-oa2-x19.google.com (mail-oa2-x19.google.com
 [IPv6:2607:f8b0:4864:30::19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20F8C40CBE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:58:26 +0000 (UTC)
Received: by mail-oa2-x19.google.com with SMTP id
 586e51a60fabf-48f0056ef38so7265056fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790953106; x=1791557906;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sd7Wsm/NEppCAKbUwlSjgpdD1KSWa0AGvfAXKfQQMRo=;
 b=LapX/rx9Xy6L6SUb4jwHEEkT8QtFdAQhFH7ptP5pouEI2+a6IpggVIHz3ICV2s+fDH
 4NR2VGTIxj1/w+DMixuQMmDpN82qHkPkaqDn7m/3kEKTupqae3lpocxpijlT4Kacrj12
 yV3aZi+3nb9SJctiSBo9R2grfN3NVm9aEgNlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790953106; x=1791557906;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sd7Wsm/NEppCAKbUwlSjgpdD1KSWa0AGvfAXKfQQMRo=;
 b=tUUlLpiM0fDndSvBGJVPMO6/ujMlBUYMVq5o+FG6JLsVHFYzTVMquQTnop9A83PK3A
 QTdu+Y4m0BLbTmJBsjMC+w8a7GR+MfXhu1pW0EX7N1+v5Pe1CEpEMYieNpDIaxoo2cqE
 tK2KdWhMp1Qx1DqOG+7Khsbv0fH5OSnVqu+H9y/mpSwHMzHcLrXPYNf0fAw4+c0x8YVH
 3Ew0cT4oKKjELUMDXbi/3vs7Rv3/p7JqnlNe+uHAYd3b92XH2lKtKnmeYwzKc5F699yP
 nFj3CoSDpobab2apUfKR58LBTI1bcBVVWajVxOzFZDvC3GC8FFdsjMXSeSO66FGHEVNl
 MigQ==
X-Gm-Message-State: AFuF++lKEeN+RucXEPjTLn4wo5cY1UyKmGVR5Xu2y3+mTtkvhdEe3DrZ
 DExUGcRyJA1h6XRu1dNRAf1uFM/+NqpqSz50hq4gjeRHuZ5BZ8D0SoZUHZhj/yR3EXeGoGOtYsB
 aRAlPPL4K62Wh
X-Gm-Gg: AYBFou3m0UIFCoAKaorwbZLyC5pTuNnKrEqNEgZUtUh9V+WaiJ8+EbHpLqFkJGOHsyK
 N8MMBOn+9xj14egExGjrfYV+DhfRsc09TsE/x4JzNT6HGJoWIwjaKW/OQZ+Zg1NI0KwHYC6W64f
 Zq+lIRdi1an94/hzo6ei06gjKk7D1+dR2ZbznWqYw41GtqBisn2PwrnI5Pl31ZDNBjxsEyNG8Qf
 /0I0rJ0z9HowtT+xcqfBi0FT2NMrNzxNb8XWCcl5z4A42+86LzIcPPG+V9BofoFjCboSHbQEP/r
 3NzUBZYKHNVG+xTPh/JkfR09ABALWYGAl37OmIyF2avj/p2rZdJfTHmCox4KqUt0Cj2U9eMUQuu
 kjyJWELQzmGblqeMmAhvkNY5wWkMLEDB6QQyKHd8e/21oDwNNM4xsIs026a+O19nR9cCsy29X3L
 kwjU9I/MhqvN4lnK2SamdOXHdqGyJ9C8u5y4Pj/3gssL8Y3FDKxnyx9JEMEG1eHb6rQOJrVfipO
 s4dZS91Q4crFpdODlTK1ic+hwPQiISdJy0TtLHqGIIQ4FdnIAnvqGiWKGdLylqeeq64zSqM1GdJ
 3m/h/ZMWsfU68om0oBDh
X-Received: by 2002:a05:6808:4f46:b0:4c6:50ee:8024 with SMTP id
 5614622812f47-4f52376b2dfmr2857985b6e.0.1790953105557; 
 Fri, 02 Oct 2026 07:58:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f523d9ea4bsm2164861b6e.6.2026.10.02.07.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:58:25 -0700 (PDT)
Date: Fri, 2 Oct 2026 08:58:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Qing Li <lqing2013@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 6/9] boot: image: skip FDT reservation replay after the
 fdt step
Message-ID: <20261002145823.GQ858934@bill-the-cat>
References: <cover.1790887323.git.lqing2013@gmail.com>
 <91ebffa79f9c5a6d3ab0d05d35fe5f113cfe3555.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iGMV963vu0W5fp+4"
Content-Disposition: inline
In-Reply-To: <91ebffa79f9c5a6d3ab0d05d35fe5f113cfe3555.1790887323.git.lqing2013@gmail.com>
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


--iGMV963vu0W5fp+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 04:44:49AM +0800, Qing Li wrote:

> boot_fdt_add_mem_rsv_regions() removes the ranges described by
> gd->fdt_blob (the U-Boot control device tree) before adding those of
> the new blob. It runs both in the BOOTM_STATE_FDT step and again from
> image_setup_linux() during BOOTM_STATE_OS_PREP.
>=20
> In a stepped boot (bootm fdt followed by bootm prep) the second call
> still sees gd->fdt_blob pointing at the control device tree, so it
> frees the control tree's ranges a second time. LMB tracks plain ranges,
> not their owner, so this also drops parts of the OS device tree's
> reservations before re-adding them; the re-add then fails with -EEXIST
> for the LMB_NOMAP regions. On Xiaomi crux this lost 128 KiB of the
> XBL/AOP reservation at 0x85f20000-0x85f3ffff.
>=20
> Only add the reservations when the separate FDT step has not run.

Isn't this a more general bug? In other words when you just "bootm" we
should be hitting this problem too, why aren't we?

--=20
Tom

--iGMV963vu0W5fp+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar/GjwAKCRAr4qD1Cr/k
CnlBAPwLQw8wcwuZoDZ/2nQOrOGpvxwev+1/Zwco/L82B0UAogEAl+p4Jdv9eHBH
tUBDx6OZTDMUjJTyC9+BC8MO1eK/9AQ=
=Xv7M
-----END PGP SIGNATURE-----

--iGMV963vu0W5fp+4--
