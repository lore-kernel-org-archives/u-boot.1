Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F1606A33F
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pzLQoV96;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PidrEGCY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 353EA40670;
	Mon, 16 Nov 2026 23:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f6NhF8bz8b3s; Mon, 16 Nov 2026 23:22:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78E1B405F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794871367;
	b=tLTb13MJbaSOkZhNFTB6xavgT8vGH9Qj4G9lz6qJb8I9bHk2wqGjd8lyVWssh5P8wzPt
	 SWAIKfOFJQsDSAu1ONpQaQc/xCYcB/XUxiOKP5o9ahjs/421zBtmzfABT+hKrm5ik6tdI
	 BJbClsao6kurl9jYYk3sOtKOXH16cQaMW+N1OeQtSgZz0JgoWiJ3DkcE45d1YFkxzNdJe
	 5aC9Dh3azKDXJTyPuMm7MEtUzC6HH/Ov+dUsHmCxAV4+KLlEFYDr5Db7QGNxf05QAZH2E
	 Icds2ZttWiUIWSO5hrudrbJlmVNKUb0lUQ4FvUkaMeVHroRNqMVYrFOtYnjRgOt6Nxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794871367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RWYwJHrrOMICX2OnZ/c0LymcqpbnwujRErbVKqBgThY=;
	b=D158LZFZrqe500smFD76jtAD4W2S6r729KwRoUYEoZRTkvZwwDKzjBFScdFWOmkOwW7J
	 rpXDbYDZDEdsKuYik23QBU1X003KrbeN+YvJE7VI14jJEIWrXMTmFMJBpT3lZKxx8/xeH
	 QMCDpuvkhoA20uattHe7FyoEYfPxofKz7UIsES7REEKiZIS6EP8R/Dm+A5kk5fBxOhs+n
	 NygEbeuXfiDi0rdzxjOugKgtRL6y0YoJxQQZbiISox+WIYq34pkOmW5+y/DiNf2lN0f6v
	 T0+WUlGgdibAGrdF9cTWHAu8U4FfayCdmJ53Qhkr7zN8m0Zwx42XMS8PO7+gHVVFV+g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PidrEGCY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794871367;
	bh=RWYwJHrrOMICX2OnZ/c0LymcqpbnwujRErbVKqBgThY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pzLQoV96JY87MQ4aD7LjMwW1zt3btM5HWDCefkQx6JzNHZpszsDr0Lrzf1IYLcXAt
	 gSjMEOGXJJvUAHjY8Z7yl80Gd8ERGJiLfvWipK4zToF49xipiRmbjznLlzgF7zsRoB
	 Lx6WRKMEkpHc6PSh/vMw/edZDxKNiZ2DJq3ZwhtIqi4prW30q1z+zmIn6aV3lbd2Ln
	 A6qLGJbpmrjIGLYQM5Bl9oTP4tILPbMmXM5Yi5NM5lAddRZOwyY1H8qpotrzBR6n76
	 ugG+Crw6GlBtJC8JrYFw8QFueLpc3lyfcr/MIysB5M+1+BsqehQXczKEJJFwz2xjH5
	 IC+4qs2AjMTbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78E1B405F9;
	Mon, 16 Nov 2026 23:22:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08F3828C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC7B6405F9
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSYh1ylJa2uH for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 23:22:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3136B405F6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PidrEGCY
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3136B405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:22:44 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-716c0217635so416838eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794871364; x=1795476164;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RWYwJHrrOMICX2OnZ/c0LymcqpbnwujRErbVKqBgThY=;
 b=PidrEGCYp+hktqBBp1Cf0cqjiVmTq0VwcCkXxRuPGL+U+dw3dfG+8HNHMEZcLZoaUP
 U5VzfIQaEu7+CgN5MLeL1SCaZ4NIPYxk/qV9ek9YDXiwku5hkYbKnsBhvjgHvSE3mRJL
 c2VYR8SkXv0JtRoD23fQ1/87aXU29YdllnGjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871364; x=1795476164;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RWYwJHrrOMICX2OnZ/c0LymcqpbnwujRErbVKqBgThY=;
 b=B+mXn1YngU33MeFMexK9jPjLYBYEWc2Z3vgSYq2Xw9YtQXMkIkNhYdM/LfNyYIoJ7q
 C5r8JS9FvAsZLJ3WPJrBk1MqTGOW7KcvsIO1WQVrqxIjNRAIXZW6DM67ikUH+NUmtFDw
 eXsHqhiTgsGuYrYjEIPl/Ot8CM8RWH3qfYJufN4KT+xmHK0YHuGG5r/M3KAP/vNtb7TO
 Sk3E/RTaLAkotJ5f8JapNelMOINCWvHd7l9+cBkJhqEyUeemuDPwGGhUp2IByCmRYmia
 W9beJD9mghEwAsOsMPuDpKrM/I4Zv25pIkq20aartq+OTPU/Vs/RjKKUERvDfu4xdVuE
 O+fA==
X-Forwarded-Encrypted: i=1;
 AL+hErHQlhp+/UMs/OQiuR+Dxcvh+yOeVUj4kQEpocWzpReybnDkhyq+c9XdnV1NA8jBP3BK8wJ/j+s=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/doRTVjrwPvKtON9ZMW6zzRlKdFH88myPJCL7fhkylZQIU1RJW
 sm+BiHhgXI8c0NZluWYyECn1obLMFnK+w4yrYmnO8kAfzWhOgbPUEO+/Y9yg2Anbl/Y=
X-Gm-Gg: AYBFou2SDuXnQMYdlfkOUEtgFNzhRku5uAGB3t+4rn+gFgJ+Un6I/Pa6aPdSTI6+i/6
 tQdTr0XvaopmFXlQhhzhiaGnzLDf7SFGAT/bI4N7UeSnSu7OcizyWKXANEtDxKNBrxsvAuDddUA
 uTBpP9tv6KZWIMxguFwmtxTAxZTObbjodOTbF8IJI5MAOJ+aywaG3plDxiLkRuBGjkkl4OEfjA+
 /xLOJt2OAa+ClxylFp+CN9Q1vjhiD41TzZkgF7sa6yFsjbhgumZ2T65uTigzbI58Ly+Kmf99VT3
 /qKLqLWNT4Owt4aDsu327LJU0VEmEHrFD+Oqie+6xhHjvBOBa2FZXKiUPRKqP73BgTkPB5DaJxD
 or/RhxG5tSVqYgm+5gWYqX4CI8yx2wOWdOOZwZgZWP8RrViKkCUAm/z2uCJSnQCmB71MlW+X96h
 /5Kac9f2Wb9th8B9MZQ3UsHOqJW9Rlz6IaX63CY+VLL7Mw4an80PKc2Gny6613mY7Z0FZGohIcG
 z09zg0DEpxWbTLUmjdfmEaguwvSspN86dmAjU92iSkyBwfphw14aZeSICT63mAP8cbJwQeP/edb
 T1UKJ7BtQrDDjgQJDB/iXajzJ1QfHp8OKdnb9MM66jEksqi65WmYHA1/efFl+5shfDnzfbN7zGL
 8bj+ErhTTROiA4MQS05RnfNVzigH51cF7vrUvZzfE8KpZl/GVKNvnRBXgTE9scKUGvxxgO2Kovs
 zcUO9xsfRS4tJsU/ZuGTnvv9hcR1U17rk=
X-Received: by 2002:a05:6820:8107:b0:716:c529:7e35 with SMTP id
 006d021491bc7-71b028d2e35mr749937eaf.36.1794871363716; 
 Mon, 16 Nov 2026 15:22:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8629d280975sm9397108a34.21.2026.11.16.15.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:22:43 -0800 (PST)
Date: Mon, 16 Nov 2026 17:22:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Dilip <dilipchowdary21@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] fs/btrfs: fix path buffer overflow in subvolume listing
Message-ID: <20261116232241.GO554944@bill-the-cat>
References: <20261116205502.14884-1-dilipchowdary21@gmail.com>
 <767dd299-5aa0-4e4f-a84f-a55395214a30@suse.com>
 <20261116211731.GL554944@bill-the-cat>
 <CAPmzV5nK54_k3imwV3UGV9dQjGpa-FjFK-5PEsFz1yrDrOcWKg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JFZ1M3xWVoisK55h"
Content-Disposition: inline
In-Reply-To: <CAPmzV5nK54_k3imwV3UGV9dQjGpa-FjFK-5PEsFz1yrDrOcWKg@mail.gmail.com>
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


--JFZ1M3xWVoisK55h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 03:26:01PM -0600, Dilip wrote:

> Thanks Qu, I'll drop the comment in v2.
>=20
> Tom, noted on the AI policy. To be upfront: I did use an LLM to help with
> the analysis and drafting here. The bugs and the fixes I've gone through
> and verified myself, but I should have said so when Quentin asked, and I'=
ll
> keep future submissions in my own words. Happy to continue only as far as
> is useful to you, the findings stand on their own either way.

I want to address the general notion you're making here, that
LLM-discovered findings stand on their own.

They do not. Setting aside (because *largely* they're better today than
6 months ago) if they're technically true the question is, do they
architecturally matter? We're a bootloader, not a general purpose
operating system. We have real resource constraints. We (generally)
aren't sitting on the network. Someone has to have physical access to
the device. Often devices aren't going to be looking at removable
storage.

This is also not to say that correctness doesn't matter, it does. And
reasonable defense-in-depth programming techniques are useful too.

But they are things that require looking at the system as a whole, and
seeing what needs to be done. And what is even the threat model and so
is or is not relevant.

--=20
Tom

--JFZ1M3xWVoisK55h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavuQPQAKCRAr4qD1Cr/k
ClYAAP9GxMwoFu19itAZh7UJ9qOVmMSwupWyH+utwzxZ3vacKgEAiL0F6Jt3y3eI
UkJLKDhf0M2+EYlir5heofH5Pb0mrwY=
=/1nv
-----END PGP SIGNATURE-----

--JFZ1M3xWVoisK55h--
