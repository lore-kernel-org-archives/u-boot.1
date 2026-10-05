Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2185DCA5FFE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 458326073C;
	Mon,  5 Oct 2026 17:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rS6MmtX-_Hhn; Mon,  5 Oct 2026 17:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A486B60725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791219966;
	b=LZ6Gx8g5SVCORH7FYY5bytGCCg55GHrJ92TSBC2t8i+DOLajoorH345HVmpPPfNfCD5Q
	 UdYcfhDNfwSAJ5JsxcM9B6WNT4OuJiusfU5fYVb9hnBSg2EyoBx4xN6Ys5HRqJ8tOWsFP
	 k+e/B9OJaeLa/6LMUyGHfqh7n1z/8J/2OFo2l74qun/s2g9fHFjWRQjjLanEfL4Z0pZsr
	 DSSlP+S6NGC8BwwNGeHD9BKZLF+EjgGh0exA4GCAxJ3TYfG2QjBjUSIdMPMpXcKxejJvG
	 LCFWMwwQA0VoDKk9BDc4Qp3hBAwseLbinvzfzYNRiyG6GdTN8oJW3J8WxdPx22hRYuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791219966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=W/CsPpdHUplfxjfGgyJjFFIAgAKs2l5bApPJQKr8YtI=;
	b=Jfybgr7ZlZRh8ZRHnJPTtqqeSKpjvg6DE+9j0GCl4s9WewtLh5uzRAwNm7SBrYp9VTg6
	 XfNFgJHOCvEA8G/RybiODU9emnPFnKyx6zXRXzQjYUnLY2CIXaakSZlZliUk5YHEECdNI
	 mAnKBZGL53Wm+hEVOabG+hcOgz7Tz2FRTFOgStLQHog3dayU4bVNuo1N5tFZ72A3/gF25
	 fKrcFaMjeYjDMQFmCPBSudqYn9aDS/kOSU/aAdmTGfI3gl77DJ1YfWusJNTejSCpPQkMt
	 n79C2tIdN4v2KE5VGzz0BC/fy5dM95tn0JCakc/PPji5PhnlIrewO1ErzQMiehky6gg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791219966;
	bh=W/CsPpdHUplfxjfGgyJjFFIAgAKs2l5bApPJQKr8YtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=phCMq36TacUkjocNIU33kp8GKT+EM76nLPHA7abwC8qgNwXRdlfwwoJvfB7eMm7dY
	 mycexfKSfD/m5fwnpTezssrP92VZccxQegvL+3OJe+mRHZh7+QlvXyEs3rYJVSQ+VC
	 PFjaDon0HFfSOGlwcXUKGDvWuvWnaWs3cNpV5yKd2Pw+8ET+HF4XbL+MvAEbapwX16
	 Bx80HHbC2f3oLJm/k/8vrn8x2kGU5ZyRccRwEKxj6ZhHFJj2kjnRwzmikmlyIy6bSU
	 DvU17d3r3BbRit8WPTvwZzioDa6/dJ+wjdeMp6tuPEYB9dmJz47RBvXAedpcgsPKsY
	 YiUSOsY80ul9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A486B60725;
	Mon,  5 Oct 2026 17:06:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 06D882E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0E7480C68
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PCjBpBCpj5Oz for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:01:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 377B380C11
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791219706;
 b=E6aX4lYJCbffi6vHTJ5UAcWUJhp8+tjyvSYVMbRZYomE+f1lUjBbg+uABHOribcED4dd
 jK0sTsiZuLD1Lju/lSTqbrn39dDk0pGqqsVtrQydWPzJKfOEfvDG0RyyTnz4jTCVYWVnl
 zzSXMNIq0Tyfbc9RUivWklfi/ZsNaw3c/N5AxkNefP0Ygx7xDzISPOMFqeAEs+yt5Cx3g
 teQA8pBpLalc3hkmpGtz47JZYQ7ZGzT4Hl3V0fpDa64ovUammU7dVQscw/BOGk3elkK9u
 xF7CfT0OipjPqYvLXLMwbB3ZSmiIu6Fgl3cU8iwSGKy8yLU3S0zK1ha9mlduB0IOI7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791219706;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=W/CsPpdHUplfxjfGgyJjFFIAgAKs2l5bApPJQKr8YtI=;
 b=i1d+oLBraX/mb+fN7DzyGrIVnw2NX/SMYGfRvBSyyPsJd/Fe8yjqpbau2xlOcpGUG1j9
 4AFAc0cPbuttv9S7Nu46bxTKjyMEuo9r9CtbjD5c980ndxkIJ5L85vLevLawOoN2rKLAu
 hSz20EtbPg/LVrYwlYLFVP0UkteYllRxp7YTSPI9pIv1zPFj8RYWZOvnt4whPcR/4J/Wf
 tQnnKhkpDBmMBWqL5dURbJeDMOqN7rndZho/2lCSu//cXD+iLP+0tNc9d2VmLmQLMqL/I
 kfK0NlBLTaTBlWdDJE1+5Nb8SOAPI7lEU9IMKpZB2CcXOmqdL73sxMXDkPiEe13NJQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aQv7yxWU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aQv7yxWU
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 377B380C11
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:45 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-8274df739edso382470a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791219704; x=1791824504;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W/CsPpdHUplfxjfGgyJjFFIAgAKs2l5bApPJQKr8YtI=;
 b=aQv7yxWUd2NQPEExh94i4+TfqoJOEm9wiSFJXe2Wz8zYmuVrNuLXnPYbksseuYPd0f
 mwSMDKUcEf22IYejtEPG3QXJkxiqCS4D7uUgHVFOzLOGsxg595oVXTlVKjqZ0+zgIpQA
 IoYFisv8/eXXZLjNNMwzWIETkQ0LbUOtTnZrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219704; x=1791824504;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W/CsPpdHUplfxjfGgyJjFFIAgAKs2l5bApPJQKr8YtI=;
 b=rnmO6+05wG3nHD+TJKhRIFUtSilJx7G15v/2pXTHlIie4qJKd3MhdIbH6CZ2K14Xrs
 wHF1q6Dj9By6Yp8ECrYSO5Ag4srLM4M9iIdMom7ZyqARpdH2bUrDR6XFirLZ3UZP939p
 bkq6pGOnDgtYdCrs559rH2n9B2J5iwS47hnnCsb2kIRsN2f5u0yQo8Bay9tSJ7Z3RINN
 xGXg8NIUBP0jb8LbM0m2HeKy6vQTAdtG0ePbNTdyWuxyw0ulBHFzwD6PDviAr9B14DWK
 IlUVtzvCUG08eCjroMWhqHR0x85d/geGcTCyr8+sZ22wGZHhks3k7cyqdYA6UJlv251g
 23nQ==
X-Gm-Message-State: AFuF++ndFKIh48++Mk9MKBb31aIJQyNk+T6fELiwCjTYx07z6xzzsy9w
 poGlpLj7NeVxbJ+ewSI5fbVbazzKbDSf8EFbTdGiAZy6iL7bLwcXPjRzBAgbvjbPk98B33V8meL
 PXYtd/O5Ttvxw
X-Gm-Gg: AYBFou3XBBtuj5RL2gsHqhTVPXmRK4Rdg+fhMb657KJJkJOekTt28TaSk7qwW4YpCfI
 JMgwzjvrWF51eWGSsnzjrbswk2mMcIEDTRNaFipd/aPeb8/RuKvoyy7LRqIwyXdHZjsDHWicX/i
 jPR1OXXS4RE4t9mlvtvasqlN21PLIjA2tIegUFi/o5FeiirwKrZMZXvI48AdNw6agHd3VMb4zhD
 mDojASGQZuo70ZnqUR8D+GTYWwubUo4FnufNjXFmBeSurZUF4BG21AX6eMZKKXzCnhw9UQMEo5E
 ZIpNG6OLPnYlT29zGuU0bEhZhzeHi7FPnheGPBnv0J3gPCmzL0f94xNFEGiqZKWNo6/UlZmLd/b
 ThPPeeW7VmSTStV3EyZ6KWs5HS9QqymA+TTm8Mbeopb5qP+bZ+oBkv31mgS/6qjxYSp7DwsU7Fv
 hjpV5fMu20t2h2j7RMckYc2Ijr4ekXmQVOq9hMSk893S8K0iZ5InmBePidgA2Qam+MCWeNe5ZVO
 6+ppGfWHeiJk5pFi9um9XzFZUgUbcZE3U9wEfQk+Ka5Ji24Iwv4UUlUYSsaU63oAIhLqw5JlgXq
 njIMPOQCqewtpzVpANPZ9qWpCbUvoA==
X-Received: by 2002:a05:6820:4c0f:b0:6ca:453c:b001 with SMTP id
 006d021491bc7-6df3428cf72mr9034678eaf.46.1791219704266; 
 Mon, 05 Oct 2026 10:01:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6df3bb8ed63sm10044721eaf.15.2026.10.05.10.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:01:43 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:01:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 2/5] lib: sha1: use memzero_explicit() for the HMAC
 key schedule
Message-ID: <20261005170142.GB3724959@bill-the-cat>
References: <20261004152715.1574-1-18102059357@163.com>
 <20261004152715.1574-3-18102059357@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OhycNwYkGvq/VvRZ"
Content-Disposition: inline
In-Reply-To: <20261004152715.1574-3-18102059357@163.com>
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


--OhycNwYkGvq/VvRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 11:27:11PM +0800, Xiaoyi Suo wrote:

> The key schedule arrays in sha1_hmac() are locals, and they are cleared
> right before the function returns. Nothing reads them again, so GCC
> removes the stores from -O1 up and the caller's key is left in the frame
> as 0x36 ^ key and 0x5c ^ key.
>=20
> The only caller in U-Boot is the TPM 1.2 code, where the key is a TPM
> key's usage auth.
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Xiaoyi Suo <18102059357@163.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--OhycNwYkGvq/VvRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasPX9QAKCRAr4qD1Cr/k
CgbDAQCdf5lFQb41HPJkdZhOC9XVDZrVn4CA9l1IfvePfoKu+gD/Sqo72PGSljoR
OR+zWH21ShcUbd145Hp+l6w0xBF0vAE=
=1ukF
-----END PGP SIGNATURE-----

--OhycNwYkGvq/VvRZ--
