Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F588606A321
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XgA3p/Dn;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EKBQFvH8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4423D80A58;
	Sat, 31 Oct 2026 09:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XiQd45x6m1Rn; Sat, 31 Oct 2026 09:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 94E0280C1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439310;
	b=ky1PQ9keQVNMmeuEODXDvpdDqe3Dwp4F1G+eU37CuNDSXKZfoQ7tB48o0gXBXbzftU8M
	 VJZBV88TZ3UHWMWZMLC3ytSj0mEo/xhPWj++4JlE9kt/7MB5erkFtivCj7Z24vGtMBfN4
	 VdYDVNdPntEhYtYSEuR+zSuF4NpUVw04EcS2L5TwBwYkBbUHELN2JEFh4Z6Recc5YQp8g
	 +ZvhelqBrqYpCZqQisHiBovJh8orr/hhxGcgiCGz7pp+KKCFiO81KamiE6c/Sf0sOvKoT
	 lrb9aGifNZlG5Lq6fVN5D02HYafbecjhc725odZWR/kTyFqpffOFYnbHZ4sJkE8185w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/U95XqLwrBjvhhbnHgHwYIquf5RLnU0JznWvMaos5NA=;
	b=kkxCB3cPW5565K/46XH16Q47xmjsq8yYB+BbbDFosJfxzBzBeREOouxeHf61/zlMUXz8
	 5CfPE77Dn+n9eCwLlJIhMrTIxSCb+Kcjh9SaYez8mGYZ7BT8Weh/wMJN88hSuboswx+yO
	 oJqvdRU8O4jR8ONPAho6VB1EONVw/gIbgGHaJ3lhobk53jbpUtKG9KByWl6s7FgfA2JxO
	 Je6BRmwgfFM5D1u91ZA3nHu5CxG8hMfM0Qdpt4iX/hVIIkVsfk4bICgTUhqqCusPpj77x
	 Tc0qc4Q80Ze9zwMAABCIzqKyyn5q4F47XOe4CbAiwU2Pbcb1FUp/HQJtPivVFAkwWZg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439310;
	bh=/U95XqLwrBjvhhbnHgHwYIquf5RLnU0JznWvMaos5NA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XgA3p/DnUnV1JqshqmpTlQCx/GCiyD0RHC5Y9iIYd+m8+uRfEAO9wlb0trW51IutJ
	 X8S24LHnTKSWLhy6vy5JCez5QRqL22hHoPat9fFEjQVPlEYm6E70qw7+PGsrkqiUkA
	 hnuBkchWLfQ1XLBR16Tg554ZiLQDLjkMM2y76iL8R9EAsZC242etb2TtS4HhM7hm6o
	 9NSV5dTndoNhPDHSaiFcQ93rOl3rC+kE9vqp4zzluMehcCqweQPpqBgmYfGClwKhn3
	 z+PaubLNLVB9sRXlyFn2K0cq/H6OPaXHyEsK+aMEFpdtdw0/Sw56vojVlT8pxYxjXr
	 XKcfwOe0cjHvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94E0280C1A;
	Sat, 31 Oct 2026 09:35:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB444362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0F0440B3C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6q0t-XTdLuMU for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB32E40B2D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439304;
 b=SveChga+uSAsThfUb37ewXzc0LQKFUHU6Yu0RYL0YB9HsJ7ddqiD8qw9an48bZupe0mN
 z28nr6HnVWbqElPLgbA+rA3NFFcQ3hMo1nFfEKUPGoMA7uPLsb2VTgfEon9YyeFWK0vNx
 I6SJ5NxoSdyzuB+17/fIXsSEnve+pwfuNReT+ITI6ZmCQVEgzSrWMZFtVsj4cZWQsJ6Lo
 6miVUJKjdfinpShDDumLD+zGgVvkDcmDfV812T4hfNf+sbhmHX7I8DxAVwxsDNGruCXH1
 BjmzScQiw7mqeffDz5bhMHNCu62ZZ8+oJewKp7BUtoQvrCec/v+q3EhnsElZpSZXnXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439304;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=/U95XqLwrBjvhhbnHgHwYIquf5RLnU0JznWvMaos5NA=;
 b=g9cHn5LCbQdqJcVylqwAoipmLZzYnzIZiKvU59Oh5w2Y24MuO422arzFwfBM7bbmTbuv
 5joerAk38sPDMyj7urkkbK89rshkcwBhoYthbbrvM1Kx0kkKTiHi4pcgpWnJ2uRSZEWSq
 LssfMBHlFJsn1TigLP4bt21z0Mie3kR1iTzDZG5iyqsHJbu7JwpQVdbG+uszMAWUGLQig
 iOa5j+xd1IGqLiSF2LDNcVY5evoBuWRjeYJMpFdiScarRqlNhuPD3bgYSl+ddAqzwDX9w
 TT/SiB6J9iZGB+wSEeoMFmOInT8eGeSuBldKAU3s4WH4kGxPz2IqD9dxmTECbWI9F3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=EKBQFvH8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=EKBQFvH8
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB32E40B2D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:02 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso790924a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439302; cv=none;
 d=google.com; s=arc-20260327;
 b=g0FwVcsIPaCX8HpPzjc1klgbdyJkjo0f8Cq+yEcXUoOBaA9f2T2hUKQhUXIU0zpDQQ
 db+M3lwMHioxkSeEScBnBCwqlSAnJbkaI7UcEPRvSNoGRat8oxMNPuYWKrqu9PTat9Z+
 4zWodV7DXga4bfOmx8UcYfR0bP6wUa97J46dA1Poqqre5koKnvca4gQUBG4MXKz/l4SS
 TeU8GQASgOx4bgSh30i+Q238PQbx1KLYcMWQGNEUzVQs7sfOe+3YeyW+AOP0DoPzEG5X
 CTnnkQs2cpjEbApJWfyfv6xBA3qu/lQ7juPbOf8UuzxRftUoOXtxJL2OvZPcFo5kltr1
 AcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=/U95XqLwrBjvhhbnHgHwYIquf5RLnU0JznWvMaos5NA=;
 fh=KP2KHZcYbAuGbNw7tECJpAgAA31cxG+qGC/RI4tiE1Q=;
 b=T/n5XAkRricNb2tvY3Lk3PD1wK0pYq4ORirmFVy+JexX84e5Zcx/oFOf+cAzyxUQdv
 uOff7c5kZeit5qLJjSxb08G2IzllCGIOihePGuJLneLKUgl72dhoezpLNIu0/GyguV/u
 6sVNY0Hi+DXKoT/rEfUkWUxeMkwmFEMG6/QQoATCYrJ431L2d96aEf8Q/7Zd5f3kmyos
 dp6jyJ5m+5vtL11gGsdEZvy8TLUBLDk71X/9RD+2qW/ywwSzBLH0QC9C72AE8DpukWhL
 sIy1nObSy9E6FAt+MuU7I4gxiErGOWFZkDjvWaH4NlZK4cQEaVmUSFWLsk74nz4gKnTX
 VXBw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439302; x=1794044102;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/U95XqLwrBjvhhbnHgHwYIquf5RLnU0JznWvMaos5NA=;
 b=EKBQFvH84vYRjCq4+JjwXzqOqK+FGzT7M0ZSRRAe1ZGqPmIlOSYveo4aj/wBJ7//Gy
 bmyJPLHW5la/obw+3CHYIRyN7fnKcORjFaFL7DufnLB2e8mguJxPJjI2Dkf1iCD1+7gE
 ihEaewoah5lwko+B3dm4TKou3D1A8u6o9jsU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439302; x=1794044102;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/U95XqLwrBjvhhbnHgHwYIquf5RLnU0JznWvMaos5NA=;
 b=KemQKcnLIdPs+PRI1zIOzU7fMe41kYd93awS7Ds7DS8FHc6RGIPMtSzYb7uztD9blA
 GPUfvtOofon+wC7y7kQnnVcpHP7PY4IFjmU5cdaABCfqoog3CsxAXpJXyH3llceiaQNr
 pgr1re0gFw0aG/aJ61Qux2cQEJ8IfzkNDPO1uYfqgCJzYyWcQGYR8zsJNpZARrviSs1e
 yQQdF3bzZX27hL2vZyNRWi/vkVoGGXP65//hIBiIySn5uvAjcMUYRhLJCe6eIUqvtqJ1
 +1Bxe6qun400XxgHYR4aW5BhnE3JecUnPfoOGL2Ii4Rq9VF9AscWHZg0brXEwDxvyw4E
 08NQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXF0ozXnDYpO0QW2hdB3XXKJ+kf/wVC75ukYZ/i7ZR6YbVn42CwYkrN1sj00Wus2QRyBY66tY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIG1heSG8+z1z5XLyW2Pm1Kly/RDxuY6A0qBXu9AintY8FXFerA
 uEgpZlh9XAnEQ/uX0t5ciCSBG67c9SZNGid1zFQYCH6VsG4HLTdlasDZsEzgL0DicYSjhWqTz4W
 idghbbATxH9pzR2q3YI16AM9/YGvV6/jeO3Q9wYMv
X-Gm-Gg: AYBFou22JHvGYB3KZ+kZGnacY1u0P9xTRgeW6aOaGoWWw4alNcs7qFwy5LRx1G541As
 gAeNxTAG0PrGUPmUC6OtCMTsT8/hoConlllvRl2Cjkt6B6Ssy1G1vsIwwSEMvG3cG/l81tgIBXX
 7vRTLDI8xl3RfYLKXNj5bnhGpUEiPzVMQNg0xtsAVU7IV5UBOhP//7b1KKdijbUlMNkoeoDeV4y
 ArBtkcHK6kScC1yAkfLCCRdN/mn3S5VrwWyV/jjiqqCHM9EJJ1G1hL4EEqgMLvrq5eoKV6NRcBG
 mBUP1CqSk1K7zojQJ+69L/2te5R4VVDtMv5JAWWSMiGeKeF1naV3mPt3wnoU8b4z5Y5iKLIenay
 mrjH+DgarTM4v7JvpHK8vcWMtxipYpRcVptZh0ZgPu3tr7VmFVKU3jpz8/J0BQ6v4m/UvrUk=
X-Received: by 2002:a17:90b:280c:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3ae8972a6d2mr2643722a91.18.1793439302052; Sat, 31 Oct 2026
 02:35:02 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:57 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:14 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-18-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-18-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:57 -0700
X-Gm-Features: AclHuK-Hs0LbdNJtbzV63BxU_wwL8-w7PP1ZpAamUBU4GZpNYwKceCwfCE35xY4
Message-ID: <CAFLszTiN63=nATe-SdvnHf+CAwcdEP+56fPO0dQ32JU=sEFP8g@mail.gmail.com>
Subject: Re: [PATCH v2 17/37] clk: rockchip: rk3588: Align BxPLL entries in
 PLL table
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3588: Align BxPLL entries in PLL table
>
> Keep the B0PLL and B1PLL entries formatted in a similar way matching the
> other PLL entries for consistency.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3588.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
