Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E62606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EaQeoyXx;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=abGwCDBn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F6C5606EB;
	Fri,  6 Nov 2026 20:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8r6yx0JExMZ; Fri,  6 Nov 2026 20:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF9FA607AD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793998575;
	b=Pg8rPJhl7ookfGlVd5lHivodQZfzITaKDSXBKApIK0VxP63adEWhbxMuHN5ALMG0zCkg
	 NYAsdNjUpFXFSWKDVnGCXxRAC496Fwvq1bRkhiLKnrr16HLuUN/BqsEQvBIdLr/0CFmZK
	 i3u+gM982f4RJiVIOVQH3En2Ri9b+aXHm/SiOePALhYRUvDdbFEDvYn1dy08idp8IBJla
	 2XoXdW3Oi81qcuCdD1mu8jPcP8n+5bOzW5nVPbp1R9HGcnr+xtFI+qWtIDVqJRhuwE5YY
	 YKo9Yvz/VW+MFOvgIkBj3BVkckG1tpS03xDVCQ13o6twoYCQuTpDDKoLyL1liSHXxSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793998575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k+LjWFh4FMMfmA04j/gygcHOBLkVAq4Bds2lFomCVNo=;
	b=K7sGlPUI8Gjvt07XqIzXJ0nLzHatolU66LqJWdbiG82xp4T1h5RdRb9RPbKGBC0UFQl/
	 Y1XIQhrSQ5oChNC48dj84F28B5kATyCQ7rQ4X8Fe+Gqxsu1AFDS1A44Au5hV6j1C0n4L+
	 tgJDOqhCtvEV9FndzQM5HuB46sIO5QxfaKKf2u+racUHuulRO6qdL5+rdxOsq6beqIClD
	 EUiyq6P/A44Re+C+FfEY2EQVafdfikF03qqg+ujyCsGFxhphrOlMqJnKd932DdFUzvsam
	 gKQMOlA001VKGP/2Ll0krLTb0fN8qkoEA1BHi/0V8fCYkBGwyM8ZR1BtZjy9SkNoXTQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793998575;
	bh=k+LjWFh4FMMfmA04j/gygcHOBLkVAq4Bds2lFomCVNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EaQeoyXxVCswu5NR26/DKDNj0Tmh30g8upz0Wg4BVcy1Y+CuE7Xmmko1KWYdjN4hF
	 jWjw1aH9lJo6tB9iqHdECGAIjcybHnXqM9EcbSn3FSsJ8wHIh1IsOGa5swFdyf3cEP
	 Sopp4qa2jT/lY/x4d6vzS0//Q6cI6u6EQ5+cLH2fxK2jAToYzWq8nKpFiF+2sQs662
	 S1p6umX15A4YcreN4T2EcKJGNdbn4KHmRM5KiCgDCZZAaIAtU5AMB6aFif/nzBJE/z
	 b06To+BGC4YJm2wx54emVo6b+0UC3iV6jPLi2W7y3O69yoKSnFCJrxRpNxhwvuIVeD
	 LghJTMkdEkwVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF9FA607AD;
	Fri,  6 Nov 2026 20:56:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B2ED031F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 993C0407D0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhBId1gEqtMp for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 20:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDE6A40786
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=abGwCDBn
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDE6A40786
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:56:13 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-714d57774d8so656001eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 12:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793998572; x=1794603372;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k+LjWFh4FMMfmA04j/gygcHOBLkVAq4Bds2lFomCVNo=;
 b=abGwCDBnJ8BmlXrhRmBJUxFljf9f0rmVk+1yzHtK8TqEAtqom9ISIssln/AJtP4PXQ
 gwVVfPYm/E+AQTWRc6D0ia7ZhIVy/zu3o2BVvnJqCm8XowLr8KDvVfMFkyurEA3KjE1s
 lhDGMISuuy+/a77359nYycPbcGPlkTC6+lO1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793998572; x=1794603372;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k+LjWFh4FMMfmA04j/gygcHOBLkVAq4Bds2lFomCVNo=;
 b=Zmk3xzcxCxHQUFqyHieZNvHkZUolmWXY2zZ0uCYdeCfpRJQ/Nn8BethmJ7/ZpOPWmx
 kQc+ZHg7ZH/Twg+2Ll+y9GZh6heecB8u+YvZBrkXHUmfQ88FV3AewE+RnU/BUxkVvdKx
 z+SucPIdbIbapfqMXibOVsfyDx90MALR6RgZlnNd3CgDd2lsK9fnk63JNXCOiO6b/PtU
 t6CwLoR9Q/nr8FXSO8PVaILP7qPBATgdnreLGFRYrKddQS5rVomm/tuT47cMnLSMY3kx
 rUBAt6Ilgj3NCWKRpsQrP+/EhvsNG9pEJdKIG5W1UY4chzboarOkoHYikuR3HIBLwsWk
 wcUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw011IeJ5jS7m99toRRNzi/H80EJVfwwjIu/9Y14PGUaK8rGg5j9P9qRRoNqRV7i3dd1gNlor4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8xzItmDPM9f2iQeyD8pSW1dr69ki/oEB9ljPFYnu5F8yXTU8PC
 8VfKgi37hOLN1wtXQufRfKOpbtzfRPbld2zYM0QSy0tOeXUyMTklTbRephmrN4qQI5I=
X-Gm-Gg: AYBFou3/e1tTlG8Ao8g6BInzmWk0ofPqIMFlOPXBewOh9qbHzI0RQj4zqSMfqrlmFTn
 z4SFTjcPz+89KYtsen49o4HxVt2l6WnSAikZYWDZdgqkzHrvCJq+ySllNq6bKU5l8Kp9e3Lr1om
 j8dglFzYtoCeIhoS6eRB8RJbqBc3vvZpvk8phk8YYStJOt9ipkuKY3X5grAcNHP0dtZGi8vBPPi
 vrsptxp/BJLqWhXGHVROQTYANEWkbg/QDS86yFhfHOx+moEAz4LRWUiH5DMQrCgC4pzMTmrLgpu
 tBSHVswZYOEKyVOlgrqMtTj2AdRwQkSD3hmijD5r8rhqN4l0hGrFnc6Dbi/ranpKt85GzsrJQ/r
 OWEBxqPDiy5Jlh/IG51v+5mSFNYijjb04gYrNSY3bowPwN3aU87mRuPxqUsDRla3ud4qhapYMd4
 4S+GDTSs24p+5G1XPOyymdbiXsoslpDCxsz+xX9oj+vfxHnZ63PNxpvXDgi3oCwAA+YWz+u3pP9
 hEGhW9DMopFagYWcL3UCaJEL1KapGiBINFUv2Pb1ppfkq1sZetBTMAoHppPtJQ9mS9NAVAQ4N0Z
 Ln9jTRbeEY2dp6ZkkmgRcHHsU+osDSzWqXVHHCRLkchP27kXx+NbPQ1EorZaMtLJ+oW6S6KEsFu
 liUT5jnA6H0raJEurH5pyk7jeaWCA0Lmrjk0hMi7oGvz5IFweUONy0hRDtWXFB0Z0Jd50oynKzw
 Xy+i5XE1lUWu+5a8fCWshTJlxYDQxatw==
X-Received: by 2002:a05:6820:207:b0:6cd:3ffc:e336 with SMTP id
 006d021491bc7-716e79ebb52mr2266673eaf.84.1793998572224; 
 Fri, 06 Nov 2026 12:56:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716e99465dbsm2460586eaf.0.2026.11.06.12.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 12:56:11 -0800 (PST)
Date: Fri, 6 Nov 2026 14:56:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/6] usb: musb-new: Free the controller if the host probe
 fails
Message-ID: <20261106205608.GF3741582@bill-the-cat>
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DvIqNnfF9nOhsabx"
Content-Disposition: inline
In-Reply-To: <20261106194621.510146-1-oss.patchbox@gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--DvIqNnfF9nOhsabx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 02:45:52PM -0500, Yuho Choi wrote:

> The MUSB glue drivers below allocate the struct musb with
> musb_init_controller() in their host probe and return the error when
> musb_lowlevel_init() fails, for example when no device is connected.
> None of them frees the struct musb on that path, and the driver core
> then frees the private data that holds the only pointer to it, so each
> 'usb reset', or 'usb start' after 'usb stop', leaks another one. This
> series frees it in ux500, sc5xx, pic32, omap2430, ti-musb and da8xx.
>=20
> The same fix for sunxi and mt85xx was sent as separate patches:
> "usb: musb-new: sunxi: Free the controller if the host probe fails"
> "usb: musb-new: mt85xx: Free the controller if the host probe fails"
>=20
> The patches are independent of each other. They are build-tested only,
> as noted in each patch, and pic32 is not built at all. None was tested
> on hardware.

How are you finding and investigating these issues, exactly? To cut to
the chase, this series (and the other two patches) sure seem like what
happens when someone sends an LLM to look for resource leaks. Which are
not great. But the bigger concern is if we handle the error case
correctly. Thanks.

--=20
Tom

--DvIqNnfF9nOhsabx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau4+6AAKCRAr4qD1Cr/k
CgYAAP9T0sli/WOYUibquCJZTa8LmRionF9jLmPIoU4JZOZgrAEAicYYBFj8MLzj
wG2dE9hZSTQ8E2hhjZZm44ka3kNYdwg=
=AaoA
-----END PGP SIGNATURE-----

--DvIqNnfF9nOhsabx--
