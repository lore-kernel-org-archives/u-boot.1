Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63190606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BMddTNtX;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=CyhW0CdV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CDBD406E5;
	Mon, 23 Nov 2026 14:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8JxzjoH-3UN1; Mon, 23 Nov 2026 14:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B17BC406AB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795444749;
	b=n2hGFvR8ZIw5KZxV55ieouLZni/OgJpicKl3ImtBb9eVvnV1iEhncJlPI04S2dqSCUrH
	 R/bD9FlalHmXvwaAcB+dmGZnnHsIDLnuFzTMCvL0Joundi64qBeX9hts5ruVdfrlO7Hjn
	 z3wIvI5OUmySbK3TiMMirIhu7/ijLba6hxBlT5nsfM+P8Umnq/IHvkKLBcdcYqxX2xnB9
	 ENSdycXy6gwIlHx47rPpZBBMqI8fyYYpoP1Ph5CrSb6XfbVb2lBQH10Su0EAgZNPux8k2
	 JRIa2VsDLqpi+l7WUvNAF2PbZyhO7pVydoYBpt/o864Bq8wtZjUe/lUDIJIYbGffgZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795444749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yiKuUuGwf9k/UE00eSL9my45C1tVA+9o4OUGUFPwhxI=;
	b=n8BgSaU+SU9BRh5sMCw4b+vF8Iw9uhdygAu+XkwoXpApm4g8neXrZd8O2VKd5aVMa9fr
	 Je9txWkK2tNFzc0tQpZzzsYS7R32QJevqHwURu62+LpfOUEZX+5Qj/gNVy6rMBSmR39v6
	 9FCQ4YYJqZzLY/5F4Xe2YRHI3D+AI9dYzJ2dUCs2PAMfVqNXqeluMjSo7nhD68Rzai3Xl
	 Kjbai30ztD2mZ3SpH41AeeCOD2xi/LB4fC4P6hlYjuyKSfUMr7UytbIwbLZ1pSAsqqUiT
	 zJQS/7XibwDqFl65KHSEy7r6iarP7n91GEJ/IiuZS5um6BnOVW1ewzyc89SqRnfQcug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795444749;
	bh=yiKuUuGwf9k/UE00eSL9my45C1tVA+9o4OUGUFPwhxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BMddTNtX4D5bunL0IdWplfPvgmXEdD7IJQ2c0kdvUCRWlmvmhy4oY2jcT4VxFYUbq
	 MnINgLWi4nH27rvvDOWPT2AmwRb2CD04LKVseIwoKNCUU3+TzAVTWsRuLgdSEzBm3w
	 tHJWI3QcC/6V5E+hC/BTAfeymnnARqDULZpMt7QeMMbw/vzI89DIX2V7KRw0wMH5I4
	 J/+rSpFdG4AhxIQydVWZTk+W6EK41dIAV0B72p7yC5KVKO/Zrymfx0orOCmWlyBp5Z
	 gHIUERSVim1OZczXC+4LVu4gdgkMhUPD+Xo91XLGC/XGhXAbRUqTF5Z0M2lrkVJhLj
	 QF3xdXfIT/6IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B17BC406AB;
	Mon, 23 Nov 2026 14:39:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2791371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 936C8605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x71Z0UwJII1c for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:39:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7B81605E3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CyhW0CdV
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7B81605E3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:39:06 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-571c36e48d4so690496b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795444745; x=1796049545;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yiKuUuGwf9k/UE00eSL9my45C1tVA+9o4OUGUFPwhxI=;
 b=CyhW0CdVTqI5ockIfHobWi6SPeGUKBLRHIAuyEx0nISOeplGHmiPn/Zyu1mO5XvzpM
 xGB8ye7+s5pfkmpGavizKPD2a3D4qr1mvmTM7OldXilMKfMwOcs1/C3fQdFvp4MiYaK+
 cKMjf5oP8OQgMShITSgav5sF+BqI5m1ckczXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795444745; x=1796049545;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yiKuUuGwf9k/UE00eSL9my45C1tVA+9o4OUGUFPwhxI=;
 b=VaFO0iWmRoyoYNEXXoDI2rIWX7Ukhov2JH3vdxc5s9Wr699aLCq2LFj4QQ+ri1PjnU
 svlZLTMMxigogWlP0IjO1mBDygu2eniY5wgLkf1W5/aqFOS1lAm3Q+6J8rGHvwezNXwR
 +RFLngf850KV70Jt5/TV3AC6st+Un5PrOZN930hJFOw8hvOkFt7vEsn6jWxjVQ8VGqPA
 58FeZfic4Y2wejWrduPixlJTtuseZ9Mq2dL6bbbduv25tC0aQnY+0qp/eo5WK98yVk5N
 hJSBquFlF/LmnbUCaJtlbrOHuTX9rWawYulbPHTr2aVI2/7e+LLcqpJhLZcjO2mumTid
 JcqA==
X-Forwarded-Encrypted: i=1;
 AL+hErE+25466fPpTj4al7iIi3SBuzYm5kNmS4VDmzDO19IXM/W/0+LZIq6lfz0257/OzvLiVBAms84=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/nt9Sidq+pDv9AmHzicS1uJYRMbxTQpQO7LXzzsWIKkBGJunUX
 +KLBr7GTPYTnQo5bahxrUqk6ujOo/BKHJCwWVv7LVOERktS1J+voLs/Dmuc92ijHlzo=
X-Gm-Gg: AZFdTZfz3cz9BzazRDPRJP763qDSk41jRIxgFJpblVsYZnzsqYJiTcxb9wlYpOxTGjQ
 qW6bv98gwsNsHc9lkoFeuyQ+w5fGn3iKWNHqFC3ASWNOZbtehmcOu5/9JMbYDqFsSAS1fb1yJgO
 1j56YQyVc2E3Q/P6JgRUI5Zass/ST8K0P2ERYmesTFy/eZKjmRkrNj4A2k+zba/OCM6XC5ATjrt
 Y1qgtUX4uGfujbLrpDz+4KKhgu24HQN9YgsxKZpxxm3l4sQQnpqxWOQztbSTSI/yXEQV9RBU1zf
 vq/T8IRpiXljKo9TAn9XvhWF8b4j5fZEjbADrwAgNcatXVXN0/k/MK2JjREwSjiBAf6UST9b6jf
 4W2wwmV0NucRUpLTy8ZYQwh5OMGhmRWsNZyi34r4eqv+NekthgompZCZbmx76IL7dH2UnBHNraM
 twFFpmWqkNnNL1WXq0CC3bDgkYsBeA17dxg0OkHeRkOTERq7K377izKKU77EvZ0RQkRilPK0Cf6
 j3oIe4WJjZDvJFYhRM/JazzcT9mzCW+WkUHmD/Og+HxxFUzJ0y/kcpYbwjRrCc9e+6QfH2nlmrk
 3QpPnf/bmw+2o5ghiu7yrwwEPNlGkMlvABC7x3vupd1tSrEJdI9ntt4QK/ETnTxVKRZpkaJqsoM
 HyEv11av5TZUrrDwuKCcVhbC3yw6pWO4GraGCkgRZJFiQ28AV/O8CgZNER56hgtZZtL+Bn1ieux
 XDZGylRin6/FXspCndDDph6lqXuGyMRcY=
X-Received: by 2002:a05:6808:bc3:b0:55c:928:6a0f with SMTP id
 5614622812f47-57a0bb8d4fbmr13685999b6e.52.1795444745427; 
 Mon, 23 Nov 2026 06:39:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34252987sm8879406b6e.4.2026.11.23.06.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:39:04 -0800 (PST)
Date: Mon, 23 Nov 2026 08:39:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: George Kola <georgekola@google.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] net: lwip: shell: reject out-of-range connection IDs
Message-ID: <20261123143902.GN3176972@bill-the-cat>
References: <CAOTQ16+bNoyuFm9kF97-Z3-vpbj77qUGfSZvDxkAXbnhKP2FDg@mail.gmail.com>
 <0c9029f5-0d2f-45a3-9634-f882bc74582c@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m1SASEQsCEGO62XP"
Content-Disposition: inline
In-Reply-To: <0c9029f5-0d2f-45a3-9634-f882bc74582c@arm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--m1SASEQsCEGO62XP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:24:02AM +0100, Jerome Forissier wrote:
> Hi George,
>=20
> On 15/11/2026 18:12, George Kola wrote:
> > The lwIP contrib shell commands clos, acpt, send, recv, and usnd parse
> > the connection index with strtol() and only check i > NCONNS, allowing
> > negative indices and i =3D=3D NCONNS to index conns[] out of bounds.
> >
> > Add parse_conn_id() to reject empty, non-numeric, negative, and
> >> =3D NCONNS connection identifiers across all five handlers.
> >
> > Fixes: f3f86fd1fe0f ("Squashed 'lib/lwip/lwip/' content from commit
> > 0a0452b2c39b")
> > Signed-off-by: George Kola <georgekola@google.com>
> > ---
> > Note: lib/lwip/lwip is synced from upstream lwIP via
> > tools/update-subtree.sh; 2-space indentation is preserved to match
> > the surrounding upstream lwIP file style.
> >
> >  lib/lwip/lwip/contrib/apps/shell/shell.c | 54 +++++++++++++++---------
> >  1 file changed, 33 insertions(+), 21 deletions(-)
>=20
> Is this cherry-picked from upstream? Is this code is used in U-Boot? If
> both answers are 'no', and although the fix does look good, then maybe we
> should keep the code as-is to minimize divergence with upstream.
>=20
> Tom wdyt?

I suspect we don't use this code and should instead direct this patch
upstream.

--=20
Tom

--m1SASEQsCEGO62XP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawRP/wAKCRAr4qD1Cr/k
CkY+AQDb1Z5L9CVAyva4nY/sczTywrJ2UdqhCv93XEcYwD5WcQD+KJkBmhVwhLhZ
Y3Kd6GsqdP6CiX79tqPG1XbNCL/sGQg=
=t/iP
-----END PGP SIGNATURE-----

--m1SASEQsCEGO62XP--
