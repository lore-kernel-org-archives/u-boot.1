Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BF2CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5920060A41;
	Fri,  2 Oct 2026 16:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iyvKV8nwdLTV; Fri,  2 Oct 2026 16:47:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 75EFB606AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959626;
	b=it95zXoBE+hwxm/Z+MbR2w+d6EG6m5HijnMLSif1y2okVYB5iPQHsT5NdX2ulbIz7nLV
	 OLAAPjat/B7ElfG6qN7LHpD4rmOlIxbBmDywfRp72IYTN+WCmyIlgIBblgyemrWYWlTiN
	 g4vHZjSYnaZ5TKoA2e3+a/QLLybfsdU/gyX8PxdFHcu0FFMy2H9sX3BpaJ7p0NzjnzMpL
	 A5sS0WYhsuY6ExufUuZiPWHntysz+PpMZH5DzPKGO9SrmJXOeZWNt2d9KVdXOmQtxhLSZ
	 fac8hlEmkE3Emj9uiCkBulzYbmZPaJZXfBFSz32nGx1p6BiiNFT3vn1q8coWeQ5dK1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YJ9BBfY8mTYHw/EGHOO2TsbDPZbMkBQ6j7xcXnn246M=;
	b=h8Xe79QmAmefTJjIYqT0y0Y6eZujTGWvreWim7tQEoVF0wmh6VuxwpmaRRzIlmL8npdj
	 gvWqdWlliMN1Ip8jDepWA5o+osYAEvs2Jdof7+UJ8SXvdwNCvz/Z3WuP9OvS8aYhpZNW8
	 spGGp3TEE9fjo8NavnVOiW8xdw3zrX3xnXbkwCC68deyxwcQx2ER9NvssxNA4mIAywaj8
	 c38JcTpEw8nwnYrra0wUn5iTUnb+jbkVew3xDfUJJR71BHwciQwOMVexOsrtD7ZPEaVxV
	 lPXCSkFmKw5NqB/wkhGMc666J+10TOUK22BcbgjmdQSo8E5wXcuF87xlpDOTkcaivLA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959626;
	bh=YJ9BBfY8mTYHw/EGHOO2TsbDPZbMkBQ6j7xcXnn246M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NRhbqD411mkFLAabmUQAjH7K9QmO4K+pI1w660GPB+ioKMP9CwSsZRWVgxE0XGnDl
	 HNOic/cfPVMVIQjeWQTHrceoufpfC92MtryGc7Kz8b4oCn0/CCNxMZoxedqscT+YJc
	 G9qFOrRJdykcb7nuG/MdRfG997QTPc74CZvLTwtP8mInkDXF8jZ1ZBFvKcgf/RRDZP
	 r70nbjuWuRs5kmDcPZHr+u0w3bDpKTMmB3ZEBNrUvFcduMxYaK/6eKhnjzxW2P+GQP
	 G0tIXShpVsHzIRamPYSM9wGT5AR9zMiMKh0UqiDV7/uz4Ce4BjACaTxqi7dKKo7TYT
	 N+itxZfU8P4YQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75EFB606AF;
	Fri,  2 Oct 2026 16:47:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 963F42E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87DBC4005C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ize_l376kMnL for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:47:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DFE374004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790959624;
 b=eFCLj7pMx0iPB47gJMWBV7jixZ8s9z8/wLfy6d/Jkpj5yViU1Yamti6MP1ixzd74Dx1f
 H2BkKGzyHYeZqLhQaGyDT9gX20YzyC+spHxb6M14wy1Lmdg0xPMpyxJuyfl8iuYSBrA/x
 yBDyuQ3VtKCAZdy7MTADo5mkgSpv00bASj/CyOOn7X77nq5paY9kM0NHjRx281p+97JWc
 qj+umzw/gB6Mjn20XysGhFbZjG34UzC4galscILPuAUjZ4kMRnCuSyiF0qPLcKDi5XC3a
 Kcf69UY5zkeafYhgjGvkGplpP0jFm32pv7utXBH1fy/hOAd/V+WJF9dMMbTsU9fqV/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790959624;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=YJ9BBfY8mTYHw/EGHOO2TsbDPZbMkBQ6j7xcXnn246M=;
 b=HZoyPZqBwWKNZcxm2XVdUmOoD+p2TpRo7LbQmiLgjyj7+8xRpbOkRz+2JAImT5Qougnc
 cpQGhgBT628NkXYB8QmTHGsue7CcjnmTNuYFzDiiChlbeOI9UZxcAT5g6irmdOWkvVdiT
 D2Pzdwgwi2JO8WZjBA5di6M4H0BH+Wa8I3If12qMosyp3c2dvo+vI4+Q3DzNHFjKrykGa
 xY49sSfWyo995tpnCQ3ATMMu+HK/lPyCiuwU2//WIiC6JLrf9MKEcL57e1QcMVYoHap7t
 U/OZK7BzdBe5B1mJ3LPIFuT+rtPaL6RxHIHA+5O+DuUVT0iWWDrzqpwvqouPp3ZUZdg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=azeT34WG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=azeT34WG
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFE374004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:47:03 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fdafso1800b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790959622; x=1791564422;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YJ9BBfY8mTYHw/EGHOO2TsbDPZbMkBQ6j7xcXnn246M=;
 b=azeT34WGnFZXajITuJ/AB3OMIfDzPgtswV+fzoOixiDgkQhok9YNz6f4lz1AqUh+cL
 +gu+Pg7k9KOnG0sy26WZrHPoqQCrJS3EIbzvGWiOxxLVVcx4ORUb3xBnmVt5gPq6pGzD
 uOOxA5yhKKDhbGoGxrhNI7vzJaRsEhbYyL1T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790959622; x=1791564422;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YJ9BBfY8mTYHw/EGHOO2TsbDPZbMkBQ6j7xcXnn246M=;
 b=hMneqR78igilJrzpmku/11ulc2dL4astDqnZMtI6WZ+GtKpOl9reuriWYp9VahL5+v
 cd4vzIiX2o3fcp/K6R6D4xryeURpMRN9CODTlcF3DpttEnpeOHloMzcF7lgQlSkmvrW0
 1GKM6bLObc+ax+6nxrSsxs9uC4Sv+lsE6izLdICEHhmWfAzqXhEBYrmZHB/GUCr4Ijyj
 a+SFXwCgsKcp630D4n96WzM4ht5vrG9HMusU+b1bSaRfRwrnMD80fSUvqFlvGJkIdwQQ
 KP9lggrUaSk960m+7UTs6DZNifcP2zebq09/Tx3n8ODDapWkziy+h/iKgOZI22h9qF5w
 EyQA==
X-Gm-Message-State: AFuF++k/jimWUjqODnxO+fxS8HnnndzOxhDhBVaIAd+Kt7H+Q0cQ5D20
 2Unj+A4dH7NpRHKd5G5A0B9NsuL8wwpRlJlgPJFxyzQATi25reFeV+TWlSMNeljmo8U=
X-Gm-Gg: AYBFou1C/MNrA+byLcuA/+78Bn8D3G7pfON+aN0QrCqKLHBcz8WZRL6b+7Gqgw6DFAp
 ScqZ1N0jtWq6wOzo8PQMhQ661rMeg6gp8G4zIiye2qTaCQH6dei2VEYCO+sowiB50Vr+GYsODjc
 61hXnSAhEg+j/74Nxu/qFXN45N3STo5ZNRQfC+FrOhcyKhXZ+d8BPQxh3Pp1Pw1l91vZrOqt7ZH
 kCpylfcnUY9oCTmDD2Ycd9vn681P8QDuNxsPNx6RMX9YqrMo+A+moEY1A9WwtpaKk3i9RzDWwkN
 Y+C0wSMJTdrQ7JoFmAR5IDMpbn0VOWAR+QwDeJTneZp0LCG3+2JQ++y5O0FFakzVKEsHMelDZ2B
 DgqzI1Fm7VvPZ9jiyK5zdXnos3svk0wu5pJBAmYItcfMRJK971+9iYsFyZ1iu3I1W9d411yCgVT
 0AEPnaVoGrfhopvVbi5yL18F1L9u+SUZZ9zyXBzT7msscr4CI1ctrx+kBPByVvqjAnf2599T3R/
 RIODrxBaBPGkuzCr//zSZAPZL7t+3yAlS2ASaHzO5N4IuKUwR0yl22puyDfANPcI6moK80BVFXb
 xe6pqH/tR+pCpUDkHc8HpAM9Xx3tlw==
X-Received: by 2002:a05:6808:178f:b0:496:976:acad with SMTP id
 5614622812f47-4f52684f2b9mr1715783b6e.1.1790959622222; 
 Fri, 02 Oct 2026 09:47:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f52195afa8sm2383582b6e.2.2026.10.02.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:47:01 -0700 (PDT)
Date: Fri, 2 Oct 2026 10:46:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/2] lib: add memzero_explicit() and use it for the
 HMAC key schedules
Message-ID: <20261002164659.GW858934@bill-the-cat>
References: <20261002161607.688-1-18102059357@163.com>
 <20261002161607.688-2-18102059357@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rl0BslpGDnPpkcFu"
Content-Disposition: inline
In-Reply-To: <20261002161607.688-2-18102059357@163.com>
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


--rl0BslpGDnPpkcFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2026 at 12:16:06AM +0800, Xiaoyi Suo wrote:

> sha1_hmac(), sha256_hmac() and the mbedTLS sha1 shim build the HMAC key
> schedule in local arrays and clear them with memset() just before they
> return. The buffers die with the frame, so the stores are dead and GCC
> removes them from -O1 up, leaving the caller's key on the stack as
> 0x36 ^ key and 0x5c ^ key.
>=20
> Those functions are generic; in U-Boot the caller is the TPM 1.2 code,
> where the key is the usage auth of a TPM key.
>=20
> Take memzero_explicit() from the Linux kernel, where it is a static inline
> in include/linux/string.h, and use it for the three key schedules. Plain
> memset() stays where a buffer is only being initialised.
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Xiaoyi Suo <18102059357@163.com>

Thanks. Now, as we talk about
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#attr=
ibuting-code-copyrights-signing
the part from the linux kernel should be its own patch, and note which
commit it is based on, in case there's fixes in the future we need to
sync over. The rest of the series should be making use of this function
in small logical steps.

--=20
Tom

--rl0BslpGDnPpkcFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar/f/wAKCRAr4qD1Cr/k
Cg0tAP0QATXCS+RgbdtJkMAQyNgtLfDcg1zuK2ktg2OSDVwVSAD9GVJeWtesWbDg
EqcQbwcC2BMJIbAX6sP+52j7HWBRswc=
=+uYs
-----END PGP SIGNATURE-----

--rl0BslpGDnPpkcFu--
