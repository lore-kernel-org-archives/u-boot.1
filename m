Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AC606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QEwi+CL+;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=TZLGHcU8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 858D040693;
	Mon, 16 Nov 2026 14:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8UZz-ws0LFL; Mon, 16 Nov 2026 14:04:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AA65E406D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837853;
	b=SRd4UTa2OYYQydjvbhqEXhIcvmLaOgP/I7tPp8N7s78FQYYIpF2O1+mc8rzUaNc5e4uH
	 1x2sa1bHt8JN/SzSSMslPxSXvZbbIJyiQ6I5YU8GaFDoNAlJ7UdB3S4UDZNkSjhuDvJn0
	 s6uN58W1hff0DlIjf4aJ/Ds3mGYym0t22HhB4//RqvouTfE+/bxTHyLuZZ1sV1K8pmRof
	 ZEOXVaTBCw/JcocjLuEOoPJmKFvGsQBl6uskFc+5xGG+d1KLBFid/FS+2hi8FX0J5Af3+
	 D6QLMyO4nSCCA3MrU5ZapZuwp0ZXjaoTye+OQ45kMMTjqCT51PjfeeMXDs7Ao2RqVkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5yLH04vbrc8lFY75spu05w4U0ZcGi4AFA6ChnZBqumU=;
	b=VEMNPPf3T3UMcgAsfrQ9ldMYNBq+cDfhTgJPvwBxvlbxQBX4TnMdAryPu1pWEE8kpVE9
	 g9swysHbQ7Al7V6uBqA8M44ix46I6bqbjztINN9o+xFu9kASUZNQbt5SJ3wBi+4PnKzBs
	 yqaqXp76hn+XRca+n2hDIfFRGkqyjruazIKikEolD01QaJ8cVVav/Gj4jw/mBzN266r/f
	 w6ek2TdiX69nIN5LrJtmue4nTO+62GCWuseEnDS1zMH2DWmCNFbD8O0mB4fJLpwM/jJLT
	 DUjx9Oi4FiLt1vrWkCofK9CKHIlXABw/WopBWDi7IVUm57D6dAPO2UCxUX+1EmWdJUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=TZLGHcU8;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837853;
	bh=5yLH04vbrc8lFY75spu05w4U0ZcGi4AFA6ChnZBqumU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QEwi+CL+ol4vDqQCgvhqAKfoW5rg5TzhZW1/q9GCPJhgdWkWlsQpFJq4LRHnp+XQ9
	 4Z6z/LsZLD1aYc8kNSH9fwq7uRCqK4IKiga86oBH3hqXeHCIuurkYI/J7Lb5Ghfbkx
	 n1pUlSXH2fiBLtt5S138kslzuidtcVqDL1q61L4OG+bGgOr1vdQ9q/CKdMAycZ5It8
	 WaHW+IH/lo4myhRnX5tP8xdoMrCJPo8hDTR6Hs8nXhZL4dGlsnpAxc9QvrXlYH8Tlc
	 nFdkDs5PiPl/8GUDvGcjI9Q6CmDjfSdnpcSYuLHzxx1e58t0JPzqDmLGTbz91QNoIB
	 do+UK5wi07AXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA65E406D8;
	Mon, 16 Nov 2026 14:04:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 778FB4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6981940693
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ew2fDX1yrAXv for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A214406D1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TZLGHcU8
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A214406D1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:04:10 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4ada9579947so2545873fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794837849; x=1795442649;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5yLH04vbrc8lFY75spu05w4U0ZcGi4AFA6ChnZBqumU=;
 b=TZLGHcU88j0N0j6Gcx7ofRRvgyENljm8l+jz1SoIo74d1JWJmo5BU497V2yb2D1Zbe
 aDTnS2wRrsTFootgGEnAGZMDVODcH594Gv1dF7xTY0ewChB6YWepRKJp+kNDyK8/mT9v
 6JfTc8dDRE869zTBmiqmeuN8+FFLD49OTgH4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837849; x=1795442649;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5yLH04vbrc8lFY75spu05w4U0ZcGi4AFA6ChnZBqumU=;
 b=dbMsVsShaCoedMwkXmYSqSui91MyCqI2zuY8/PI9/WzigR6Q+JfDSdpDKQvqbuqrGW
 XbBt8A0TSvMJjUWQpX9U0qfRCtCImzRpNh/sRFCABdGuAodJ/1VmlsWbbi+osiDi+6Cm
 VNO+2lQoelRpCFDpn0vQjTGL9snORb/SMTO/hXbqONIYWzcJSyRQUVulCd/p7ZVoXWft
 I8dJhubFAkRONErpCk9gJiJtLWg0HR7S3wcn3kQxBgLp4a5bY8MQcJGaS8hEac2rs7tV
 6IbY40MvXPbZQZa7UXf1urHs3MYD+nUV5TwE0DMxpLBwG44RiEskBkibBW5/52u3FPtw
 osIQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHp+qCElFjPrew8GQkqWmu/1mRD7mKghYPJrNwTIe8wv1Nobu6Cp7qu06reI4TNjcU8vdVH+NY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z91rb/vtHYRwCiUch9VVe3Cpp4m/47Vt+nbggk3b7sQCoHLbi13
 ZtmesO+wLctGAEEgCmWzI/1t0qUp8hhX5WQ+tB5K5gmQ/k1ew7TwvqTLhMNNuF6QDpu4xLNaHBw
 ALXyBh4qR9g==
X-Gm-Gg: AYBFou3mSeOK7OBaDyAfTTFszgM+xOFja3OqozmqBXuDGD3EQ3nQWFKAT0kBj4ABRl7
 7Az3CxRbVjqyH+zEgTTRd3JdjjE2fIDAyaa8o8JsLgaYQx0c5hZ7iAnKB/bJUu2pyVyLs/mmIrW
 DitnwNe4yAR+lIvM6nIf2RzMKh6WoG7eFL7ujm4yF3skUgBywjIAsNDHThBnqXYG5HCIv10DgF5
 l5kYl5Ey8htAveaDEePVTKYE83mvjpoNqep0G6S/6DuzwvB6GSoI0+LGn22KwgwC/st4ibUj//n
 7eeFgNh1KbCo0YCkvqwU1KlK9i4kHXl4+xZDbGBRGKqiNcgtU+Yp73A3Gui3ka993MwhGXmIMi+
 JfNp2JR/GNS5W9bpthCNHPOtGfoQPJ9VhSFSXyS8bDZNH1wcr3UfFXeSMFVRN9RP4Zz2YeqrnYb
 80vc+JrrvmlLiqUwgWXuWltbgFNadFd2y69FMajnbd6BnKEKyln6yAO6bcIvOh5j25QKTHd4AVv
 aoUft8Z5jM1aRTV0ZsmtXv6eFfRpEHZqCCLMJpUiQnnb+IrzmYp3ge4f2s4unOoA3nDXbhm3JvN
 JHG+El/faxUwoByo7tzjJBUYugsDVdVwS9PW8t4C/Vv38zOKdgNl2WhBm0MHjNgF4Nj2OQ/xzi2
 LjVHEFXbcOAQu4MN4+v4pVdiWlV8JrF0+fWF+l8eQJpZ5cA8+GDpxVkcb4Byk7sMeDKxrfT1Dpq
 OWWt43OPQnM4D0XRjF8d0sQTAasPWyPRA3
X-Received: by 2002:a05:6808:c1b4:b0:55c:6ea:3e3f with SMTP id
 5614622812f47-56e63a9e9abmr7947055b6e.28.1794837849149; 
 Mon, 16 Nov 2026 06:04:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-574741b9275sm2119233b6e.11.2026.11.16.06.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:04:07 -0800 (PST)
Date: Mon, 16 Nov 2026 08:04:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/1] tools: avoid discarded qualifier in
 fit_pre_load_data()
Message-ID: <20261116140403.GY554944@bill-the-cat>
References: <20261115214244.43117-1-heinrich.schuchardt@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5aAAUz3ohbm8kwMl"
Content-Disposition: inline
In-Reply-To: <20261115214244.43117-1-heinrich.schuchardt@canonical.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--5aAAUz3ohbm8kwMl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:42:44PM +0100, Heinrich Schuchardt wrote:

> Building with gcc 15.2 results in a warning
>=20
>     tools/image-host.c:1797:14: warning:
>     assignment discards 'const' qualifier from
>     pointer target type [-Wdiscarded-qualifiers]
>      1797 |         name =3D strchr((const char *)algo_name, ',');
>           |              ^
>=20
> Add the missing const qualifier to variable 'name'.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Marek posted a patch for this previously:
https://patchwork.ozlabs.org/project/uboot/patch/20261029062735.898715-2-ma=
rek.vasut+renesas@mailbox.org/

--=20
Tom

--5aAAUz3ohbm8kwMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavsNTwAKCRAr4qD1Cr/k
CrmOAP91gBZLsjs5U7BpOPbESmGKrkhNWhxyMDYE/cJ8Om4hNwD+PCRxy0hmUVUJ
cncA3yGo2+I0aoe99e9Qcxecx+K9AgQ=
=i2j8
-----END PGP SIGNATURE-----

--5aAAUz3ohbm8kwMl--
