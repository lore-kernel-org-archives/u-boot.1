Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A61C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 22:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C83440681;
	Tue,  8 Sep 2026 22:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e5_e42v-5E9T; Tue,  8 Sep 2026 22:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7DDC540675
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788907880;
	b=JZk86eCUwWpHT3k6wDTANyLx7fNtittgsixvLKdEgzW3rq03zhQRneAeQFw9XZFHCuJp
	 ifjdi2SbrlXHS4YUde6tqOuYSV9gNkqCPkuqLpmGwJexc5bCRcTfW/biENWzlD+e1enyI
	 YUvVaNMN+nCxhwLhIQc9Qoa6F8Wj/uvrUscLVoq8LAyK0n5y2acGSvQnRhuGohmrVG6zV
	 j7dr13wJ4o7JVUAgguJ/xsDSjK9W2FOaFAXCq1EXm272j5t1Jh6hBEHwkEqSD8GKgmzKZ
	 9qT778U22nWQCr9eX1RgC3oIRtvDhFrQb1i4P5u3Xaet/bxC8CGu8mwZ3d38w14HWKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788907880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EWCkI77Rsk957z/6zoba7ebSp9wq01rbvZ0ad9e0Yxw=;
	b=g5PCrV+EEljNCeA51HUFWGgg7R5gvC/0oC4EMS9bIhDNZAq1Ug3EYzTv9POnF9uOQUaA
	 KFTTIV6sRzXqkADSCSEoH1ojJWXy1T8DXdOi8tn1vTAnaSKZ++a434hE5avBvkD3a8pwA
	 H98ZePTSEBPFbSerqiqW9VJAW0EaQgJ6ebVA4MrL0cP4BJ0tayRcEXSHuDb+yVZN104JR
	 ZwkcsxTT4uEe2d54X3ZurhCoCEXANUCvVW8w8q9GbIfTIg/kNnQAtwGRHcYrFU4IuhNGo
	 +ykrMozVo/bvVkySPL6KpQweIoBb/4QYFz/G6MEwhE9CMGS9e9W8ofmg+D+WEyuqgSA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788907880;
	bh=EWCkI77Rsk957z/6zoba7ebSp9wq01rbvZ0ad9e0Yxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/arTTG3cbKhmnt88X7vJGZdwAM9zru5TrcMV3ZGE9NPmCHAPCTjnHu6ZQZLEG0Ix
	 7VzMJT53PsVNxrxEHrMKNicxFQlP1yJx8AIFGis+m1BzFoNawKs9qElLd8t2rMl0YF
	 Gp/IomcEJJyK+lY3IyyRfdorTSEl+TTq2k5YxJxrqAoTIX6sRJ4o+kXBYlTQbHZVMg
	 AELQomXssR0QynYkQ14VHfsi3DfiVv/Nu1H7yXr2bd80D/IZVQmwfBxCC00NfHM/CO
	 MZiWv/kPUn+xFi7eHZ8jlJE9xbX/KY8U5CchIa6wAD+Z0Ris2jYeTQGw7+Oz+VPXY0
	 60dCtsvIxzEmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DDC540675;
	Tue,  8 Sep 2026 22:51:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 600812E3
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 22:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 463FB80CD3
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 22:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l8_i3CFTWJ2U for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 22:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8E00E80C9D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788907877;
 b=s7sn4Siovsy1RwtbJiBVCOfhxWbJ+/NLdY5lKV3jiAJYtrDtB3VNxQA/Hy2YGEk2CvOX
 aVfpx2bFHSZ0+K+xR3er+P1tSY35hRWeYcxtOM6Qz3/nXwcygIoCq+jDvpj7qOMa586HV
 bvTkr0wRjkDNG9+lpysHd5TUoF3BDjguQpF9xDjOBEwX2HwIFoOibeVwXotRrR2+d4pQI
 qZPDCAP8gKLquj3TEBIS+0EVq8EPsqeE/0UQriQN2WyjjYM8GO0nkOwdcP/otYCKd8/VJ
 h2rjlcbqnprH2XI+NzwD0Yzp1CyKFGNEiZrlE9LczhqFzzJsBzEpWWWCgrU+HT0X+EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788907877;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=EWCkI77Rsk957z/6zoba7ebSp9wq01rbvZ0ad9e0Yxw=;
 b=GJKyd1LD68DsDWfZNZGFKGAxMUeOxZxz5rHEFNjlV8iMzruy2kivwgQ8RZw8DRx7gGF+
 SXkUcE3d35U3731GQksMHpHDRMzOgPZoG+BS1qkslelTJ6Dx1Q9Kqa0NIn1ojA7mqr/1+
 5gx0ogDCbHx8YNgZjbqp3/QeS/7RKgQB865CWkEhOUZYTwx5Tl+uVBNf3uJdXVb5qixDX
 UxDlYNmGU7bsgw92c0lCRIlWCzSQmnp41Zho+0gE5VBDos9uQso42icDT/a33shQ034pD
 qkK0WpbyZCBZQUStsCfL61+iGfwigbZJgvMW9DgGMW8J+JGQ5xFT4XbI/0rD+XEfAvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WPw40LpJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WPw40LpJ
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E00E80C9D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 22:51:17 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f4f3683fbcso5147232a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788907876; x=1789512676;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EWCkI77Rsk957z/6zoba7ebSp9wq01rbvZ0ad9e0Yxw=;
 b=WPw40LpJBXCs91c1oBgSya7cAE9WqlEnIt1MQ3kOWiPriLc9xv933brcNWCUJTuZhQ
 ffswO9pJG7I/T20q/WMO3PCwOAfN9He7IeALsoO1njOGUBqCdbNgzTPgeSLswmMe7hmI
 JVVo/KUtN7p58JYUPLpZ+mvcVNb/p48GpaYbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788907876; x=1789512676;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EWCkI77Rsk957z/6zoba7ebSp9wq01rbvZ0ad9e0Yxw=;
 b=BahlKbYWZG5dyCG92Ia9sqBOwl8znzJoLzHHLdBSfubCsfQeQJW6iYyE0ZmLrXj2Ht
 FY4uRKYZ2DT9fOQBwLRLymlMdCDZXiolR1eyw7cz8lCPiWp7ixgH5aMKPEegthfGv9Pl
 RtMk/oukL8fZw/B5GjDMCmVixcWO08a/z+Y2NaYe7vlCxRDUqHzwsRYzP3FaY15arw6/
 alUcIpJuNcTqKn3IXezRNTrEvMptK/pB0rMbyLktdWgL6gNvhXEUN8wPMdbgyTkCSHd0
 yuM6ylEnJg30K41DG6bF4rosY/JrDYbP+PqEkBnDwHyLET5EZm8KUhsjaJWOfsT/BV/d
 BOKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9ykM+i8T7jCEhA500mQlXyIi/pbGkpt4/Tr4C2XJvZw07kaxkxwZJ3/QJUY3sck/ww7/qwLQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nQYs6dlnT+NSthLfCSB13Q4hDwodVinmsHjJgohWAD4trtdnjj
 MOlosnjGknBphA1aP2a4R/MOHd5GoaywlqU3mXWWQ9lpviOitVJeU2mbf4MMFA16XPk=
X-Gm-Gg: AYBFou0mqB762wgcZECpeC0v6NeWI7yqvWQSUzsUDYAv4a/PAjXmhgN9vaxz086uiZz
 U/+k68BtW4kzX4wTUoz7jkAdDqs6Sik6fxsQWqvYTCAAwf5l2SYHof/6tBm14p8pm+Z7doTJIat
 khm9RRt2i/bzUc3q+sK0tAg8H9iuEUYiCzRtRlUZmIP4wh2azRgkmQuTRzzFIPCpzXJWd3NvvDB
 vF3F46r9LYeu0RXcbZA89kB9++uwVVYTXOLaMWQoP56CSdCqrJcCVM49GVOA27MGNKcfIJXZ3ej
 Sn12k3sLi9ea78XYdPuYl5MXn3ATVLIvgKNIwU8m8a6EF0OYbYiJkLh2mIKSBEZG7JMLSs+pFsE
 D1IoCoEn3DPZj5j5v0nbKm9+xV/N01nGRr2ykU2zxFO/eoT7jZHcZiL9mCY2uAFP0w0hgTVKuGU
 0+jF9ra7gmaEYw/TuOnrp6uKm9Ek+Evp7Q5dd1th5lFjeW2gqEVD1/w7nvF0xcJZfzWkyHWj1H9
 fuOobixUSJVZIzJMO71xt2+IHhWaF+H4pcZ7XNwf+pdYUkFDLeQnxSKlQFRLciO8Lvu1iUKRT8m
 gdsEz6vd4w==
X-Received: by 2002:a05:6830:4392:b0:7f1:e04d:fc4e with SMTP id
 46e09a7af769-7f899a8aa7amr16686746a34.2.1788907876140; 
 Tue, 08 Sep 2026 15:51:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7fca1a91920sm10036221a34.11.2026.09.08.15.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 15:51:15 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:51:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] MAINTAINERS: Make RISC-V entry cover all paths
 containing the keyword
Message-ID: <20260908225112.GE1764417@bill-the-cat>
References: <20260908221740.27927-2-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="86zJD9ZCaifi6fPu"
Content-Disposition: inline
In-Reply-To: <20260908221740.27927-2-me@ziyao.cc>
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


--86zJD9ZCaifi6fPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 10:17:41PM +0000, Yao Zi wrote:

> So files like riscv_timer.c won't be accidentally missed. Also remove
> hardcoded paths that will be covered by the pattern.
>=20
> Signed-off-by: Yao Zi <me@ziyao.cc>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--86zJD9ZCaifi6fPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqCRWQAKCRAr4qD1Cr/k
Cr7xAQD9hUpRa/aePteaAbfojfjcvZy0vnlQ/smOY82XzBCWaQD/au1chei30CPR
OtNEDqiJIcHKhbOAiWH8r54FSYWk4AI=
=K/ST
-----END PGP SIGNATURE-----

--86zJD9ZCaifi6fPu--
