Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36D8CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85AE380972;
	Mon, 12 Oct 2026 22:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dj-0gtgF5iG; Mon, 12 Oct 2026 22:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DDA2880AE6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844413;
	b=dOFt5PsyZlhdWTdJd25Mq0N1Th6CuhQ8HPZQqIExDPYMkQg1MYjwnmS7l+MOnK6e23OQ
	 GLhUfYWZQEQ2TKaSZvAWioYN6KrOsK64W+SltmzyVZ0IoAKXdLzEdcEsBkuqMWO+FvDqi
	 5FcfO7EPa8Sla2qJCV5euqxn6GoMyYh0D5Gj8OhKbWt0Iw855jTxq06sGbrVz26yX40bv
	 mFhZ7gVQJFSdqtneAXz8pwafZCH7CpDFOeg6hacsr6zMT+5mDzpyl4Ycw1U76vl7pZnIm
	 jNqF7nwYfpZrc8nZxgItTZthp9JFOZVCYwheJw1UBne8HqxgPYwxIXXCqvSk6LGYZBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sd0kXVfEv0AcX8wmbp+GJLEkdmbum8rwELuXWLA2qOM=;
	b=pEn3YJM1w09DJfuCzkH7xeNamWILpJIEoTYQn3R95IIx6eAbLIG3UfmxVjgSBbnyoes7
	 HG8iQYckilR4+l5RZ4CbfajGg9XJT9oJcTsBnqnNjRZz65PB9RCsGpSd28fHU30qkCANi
	 XswiWu/VeshsQdgWTBGDR9hsqbJGTsDfJ9Ooi9OP8qDuBp/G5XPWUsUNKLMPLnUU8qK7Q
	 gzqAB7wGIULSNaVW4irwjNgkFwnnEmsOnvveAf/g3WBE634ykYG1XB0pykuicjMRbZi2W
	 0YYl8wZ19ihtKp7mM6VPlZDcoNFU9oJkOzJQlmXTLvGVQvJ1+OmBj+cpOWIYolChWDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Z0P1fMuO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844413;
	bh=Sd0kXVfEv0AcX8wmbp+GJLEkdmbum8rwELuXWLA2qOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DOTpi0dNX6pkuNqQoitwikJUhUyp0UfaPtXYvawx0vFOaQIVVpx76WHPWk9LztQT6
	 7wU3sTeLoZwo1I6u+AFsI/JYs4DKqWsl4J0m2xkuMGh8DPUKe1SKVpHRbJcuFz1LJV
	 ZWnIf5HVgEH0rrrxNjtw4dnvSmm37qbq3Taa8d9ip6kDKS7qy1dASIdKhmzdrhB/Xl
	 uwKaqPyubFDa4CWXOUwMOOWMRyHgxRat+dW12/cNLJREJE7aFXeqrCgOYVPFFmy8rw
	 WUovfstOuKOUSL6IdXCike8ouQPgBcON8r+NB4UeKcARqsHBeKEWPzo7qANYnPK+oJ
	 bWZ7VjFBMX6NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDA2880AE6;
	Mon, 12 Oct 2026 22:33:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 97CC2731
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D4A380AE6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FgnB2fbaFJTy for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:33:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CAF3E80ADC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844411;
 b=AKHqIQJpvumDKxL/h2hM6qchkYQz5Lloulubc7W1qRni5pgM6fRLdr7A7SCO+A9TxCep
 1XOIgcSG9LMrcy8y42s7iOIBwk1SSWJ3rtZbWO3af9+v1C2UWaktr5qhUdRysUt/83zHN
 dkcA0im6lXgM4xbdYyzeKige/00zJyYepr406FAA8ZAyG9nl/TTAOSv4iqdLRLpr+ZfXz
 fkIguN07o+VIpqx4fJjhaIusIe5ftEz7JauiCkMJ1pGjw/G1vcC0Rs56wM3+D8P6ZwT/z
 syxfZtHG0UxaLJdEgHtyKr88fZVDaeWS70+cKigQvnGphI0dvUs0pekVnn18LqSUyRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844411;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Sd0kXVfEv0AcX8wmbp+GJLEkdmbum8rwELuXWLA2qOM=;
 b=YX3blIIpjI+n79UB4doM2HN4jGUQaQ/kwwf1m/wEKmpkxP0xjT+oyN81VUvnQ3G4mjTg
 1RcvIQio7r6Ru93Gl7SncVVhr3MRsbFadLq4Y0Ojnu5e0sYJgxf2DT49IHUbT92bIcfnO
 mfmPreR5FJ2xhuD3OH8SyvNAGT2WkKlmqGbWq5FAmhMgTyrD+zmFZx95qu+TC4Nob13fN
 sTEYFqsMihL113x8/ZQYY+xRKnq+iIeq0uujQcuBwJ68yRvZzfy4ytE06Aq+C/dXtR5Ty
 HO46Q2D2NOfq8l0niHQu5w08Qpz/47fYy9+R6M4NFL/StVTWhjw4U21R3C9xfRSQOGw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Z0P1fMuO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Z0P1fMuO
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAF3E80ADC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:30 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6deb848ddd7so1537689eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791844409; x=1792449209;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sd0kXVfEv0AcX8wmbp+GJLEkdmbum8rwELuXWLA2qOM=;
 b=Z0P1fMuO6ACsQ2cCptGszafxMqWy89ERcM97Okc6fAwbCOnuBiaxx/Wmg3qTfTPhI1
 oljtgB9paf26c5QikILA+5p7RYDIXDsrcBLDCBIto6MjiCEuHpTKkIpMGf3DwWech+6z
 KK9+vTCnMFMSm0a90JYVNm7eE9HUYNlrNVWpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844409; x=1792449209;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sd0kXVfEv0AcX8wmbp+GJLEkdmbum8rwELuXWLA2qOM=;
 b=wpjHFIoF8Xp7Z2A+SvH/0dM9AoXNPUFefispNE2nDXX7R4BtYCNwP8XTLQ75FqEAJr
 RO5q5415FATL1JsSpqiP92gf02iAlio0T8o0ehmjqopS7JAYvI4gvYMDTB29w6xXWKcv
 m0nKjb6h/BwvdXfQ2BuVLUIpS0OLbW9+eCFxUywc/Bw5gJP2PGf1hYJ+6BvOXQzPN4x2
 56zud7phBdcYvXpLdjMdGWhW0F9D9dPdFGDCpwEo4N5QOjeEyYqQ00i7j/zyK/Np01eT
 qRq24lar3zUCJCdJZzktzupEgz7ppw5cgM4e3W9oA+prexX5HoF/oWYjJ3NcU6S60G9L
 e2sA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOZz8PWCkl6noDJLQqe5D1WTwa5voosTSjSYPjwpJ40Bb35/GPvR74heFMd3EccYMk0cvio9I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLabGlllLGLHnD/qDLFADCA1etWIwo79I2oFjVHPE72oSac85eO
 Z+bvqpSgTq4YTJqur4ZoIOF1yZT5PJv+vYO5qdMJZKjl9hZocsyBwwJiYUNldXG/d1o=
X-Gm-Gg: AYBFou0TrzshJNm6LZJdxVSI8hZG8DLumIn12O+p2zINtg9e+V/n7f8uVBlMmuNHA9B
 VmK30zAMbk187NSBmN0nM5xnFM4lrFehYmNMB/5IjTC6vGdWpKcjzs6OFVsCOi+nfsowXxZvuHB
 KmmIG9+TIBnwGq1u+l75RjpgpZuOd+CB8XqJHjSl9OFm0zyU1cAXG8tyhaXzB0Bp9YYAya6yI/w
 y1LxYVEWLjLG2FK40g397gpq+vjBCyJLpXf0ZF4ItdYvi3Tfk3mI3MzxUs02S80FcJedihRobo/
 OE78Xsu11W9TJWQiq2hY3W62Jhm/KvwIyj1CyviJ+uoobxPuskD6BoYLFrTL8HSPlUPxqrhEH/w
 jX05QJ4SSY5H3RW1kAYZI5FVmEjoER7t6mQ5w5Vikyqmz9PWd0b6ZrvHg+Rg5Z9K1ROrDycTLvq
 0nqgVFzoEo4RWXh0qm1WTaqjPSb1WifkzYQFnkiW+WOuZ9Ioj9osD+qVh8NeFPKMzWX79DnL3bn
 R3vD/LRc9SuBB4SVF5ma4A7crGa9C2yFvjooltsmXy3gDcOWmBd3G5INT3As55TbNEbBJFOLeFa
 2ftLHqBaY7HJ3yyThq4=
X-Received: by 2002:a05:6820:7098:20b0:6f5:f71c:1acf with SMTP id
 006d021491bc7-6f5f71c1d5emr2482124eaf.58.1791844408216; 
 Mon, 12 Oct 2026 15:33:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6f85a9e6783sm1769865eaf.7.2026.10.12.15.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:33:27 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:33:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>,
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com,
 Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 0/9] fs: improve change date handling
Message-ID: <20261012223324.GN3722450@bill-the-cat>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ncO1TmiKEsXwvSWs"
Content-Disposition: inline
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
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


--ncO1TmiKEsXwvSWs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 04:00:39PM +0200, Heinrich Schuchardt wrote:

> * Let the ls command print the change date for FAT and ext4 files.
> * Correctly update the change date when writing ext4 files.
> * Adjust tests.

This is a little thin for a cover letter adding a new feature. What's
the size growth here on a few platforms? Thanks.

--=20
Tom

--ncO1TmiKEsXwvSWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas1gNAAKCRAr4qD1Cr/k
CgrYAP49vVaclgpHzW354uWTQ1JiMhluvh67xiZgez2JXTZX+gD9H06LBxyBV4o6
Hw7KpcYhDOqjo+/4DCUoIx88Gu64wQI=
=XAR+
-----END PGP SIGNATURE-----

--ncO1TmiKEsXwvSWs--
