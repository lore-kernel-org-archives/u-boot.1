Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F6606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YikSu3sW;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=LWOl1xXO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5AB1813BD;
	Thu, 22 Oct 2026 12:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oepXeOCRkZhp; Thu, 22 Oct 2026 12:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D262B81276
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792673188;
	b=VvFGrsi1xDX4mkBLstjX7tjprolVDVXdP9R1yGXIYc89q5d+v6IK9ib5EnrgzG1q5RpO
	 WJtxAIUl5fTny9swBEXRSNVcf21gL/FdKUTGC7ZblGtieE7/80U9ERywAA67GkKoCGrzZ
	 AfloVCjjh8+A1vOz9XhR0goHRjFtsOU90h3yYztR44xWCWW+NoHh5bc89F8AHOuy0J/Fv
	 dWwVl73euUlyWUzsLeQdtXiGW4Jm+Ds1LOwVgpfOmMsc2FTQ0532N6D5wdHU9Di/Yk5u4
	 EJHD/4t8kT5FlKIpHKHinHoznbA6pWeC9miF4+yF7IPNiBUzQT0bNrTEzW/Vne2Jh3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792673188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pvXm5pa9D3m9rt8/Qhnt/b5mSwq+itrriutnsQ3cG70=;
	b=md6XbYEQSazFDS5645Z/Va+jj1WigjECqojTA7qioTJbtSst3pxR5m/QP02/iTCl3/9A
	 KzMTJiKJDoqNR/0ihZZxbCA2vmlVvEbVryyOy8s8MdJFLDgfLCtJQfBOfL4MfgA0o0S/K
	 7KijCR+bk8jZQHNgMb+kXQDs8TFZfNJnDgbp64e7s9jRwwkPk6fng7wkaOGfgwbkSJK28
	 D8pHlpNL4qcmLgYFDNJpIvnvJbn2ux5FxG/rEYak0mvecKz+T3Y03XeKTD+tz0TOu6hZq
	 589xB/6Wy02I0xC+AYqLg9LEeDl8wuKbCrTQXuNevpTbClzjf4b1xrLOLPWIAE5aOiQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792673187;
	bh=pvXm5pa9D3m9rt8/Qhnt/b5mSwq+itrriutnsQ3cG70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YikSu3sWhoDbuNwJcf3R8o2AomUpkeHWl9fPRrFrhjo0tDccB3IkFPQ/aGVdYZsM+
	 DJxhURxh50856l1tbpmVu10yWLbs7QIL250H/We3owZpWSnjdh2ktH5qw5/8IrZAbj
	 OJEMd8S9S46q4aX4ZXSh43af0zbpkzi0jjkPea2QuWX9GoPUqsHK5GoNfPtkFNl6ta
	 klXd4wMuz5rro7U9e6Jr33M7YFH4w+i485gi1JAA9M4xfOaTnevxWOaInaBAw7SK0r
	 ngW9WMqfwlXDrqegclVHPObjZF+YYZAu3yVxLhfsNRb+vTZebKlem+DA8lMvSGtJQb
	 CDPPutMmspEvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D262B81276;
	Thu, 22 Oct 2026 12:46:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FCD33A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D91E4041C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kseOaT43cbgW for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:46:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 78BD440417
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792673185;
 b=fVjaumKTvhlkqN2FoBSTGVFs4pL5Up1oYgvJdfjpC9QS0+r10KTqXxJJ/0RIfSUQrk7T
 8FNWynPTzsG4R5eLX2UPolDOCjlHgevWtYDJ9ULYQZCmurz0RXyaV/Ub/G/tZ+uSACxan
 v1ErdA7DqnezHM5UpbPKDek2+tyQQ0D/GlgzdXWLf3sekMrNCV9bdn5M2xf82gk5nKQ/v
 hN9EbBbKDDjwr/nueCM07bXpKBLWUQlA9ToW0IVe/0unOk3qeEGeP4mzj0gaHI3HctBS/
 StDaLWyt9ZLvxE4zogEdodoq4DSWgpeQPWw3hGvuTdwvHU3QJ8R/Deghc/FM0ED3FJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792673185;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=pvXm5pa9D3m9rt8/Qhnt/b5mSwq+itrriutnsQ3cG70=;
 b=gPVow2aB1i+DEBzz8HygXFIiCwBs7IbtqVp7T9FjphUxavPCm+RCmoJi9bE83A3mYdlh
 YsXACsvayaHDCfQeJ/Knw/MrbpWAwN/ZJrCYzhXWXiCzyTuQG+Qdi4u1epZzUhUYSFeIo
 p+6+0wmvaMrD+bP+CGJvoBn8T+8bGGdiRhpe0jG/heBfON9HFv+t/hpKxVEWzQDnfIwVs
 lVzMvtNE0sKdbotS6ohinTaAVI/B6HHy5aQ9sYmnxofV3ghg6q0MG7E5M29MlVybyMga3
 dG237dZKHbGSe9N1hlSNrvqH8mgd4VwJ2JzJ6RMlz2ViwoGDHlhLmIxb57/CDZVuWRg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=LWOl1xXO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=LWOl1xXO
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78BD440417
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:46:24 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c45551fa84eso268559966b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792673183; cv=none;
 d=google.com; s=arc-20260327;
 b=e+IfTdRutTouSUFuKmTDZKWlKH5HZuKsF3UEK6TX/iv4+A96URJLVsyKMdPZNST86R
 hR4pmLf52J0rls0RWgA/GcKIVWKSpdJQpqCTKlKJ6zPIvxYe0ybYgE3psaMw5v5l4Se0
 hxGtbrjXPOOraV8DG0AH5FkwWOi9FbbbXhs35/ckoN8mLIXWkt+Pe4Fo3LmO6q//cYli
 FHvK6S3qWG1ZwmRyyfZJRMHqou6Cw8gTvKJ5B1LAJNoPtdCqG+ifWQYkdQGlRfNB3F/3
 Te1/DaBOPtNvG2R6JnoGewCeO7L/VpV73jtT9oFCFLwW3nKhffJw2k09QXsNLtBMlYzz
 igmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pvXm5pa9D3m9rt8/Qhnt/b5mSwq+itrriutnsQ3cG70=;
 fh=Y0v1/WwJw6kxannqFo+mURjzi9HsTY9Fquub2Y4LgJw=;
 b=eqGPQrwGGOsQL/6bRoZ7613sHiRsaNsS55t81/O09oNT7fDDD2Pdlq5ymt+XyEWi6/
 bMNB5PDjsqiILChAJ/n0iyTgsnfgcBLvTAa3pzFAb1RFqH5QO9OkicOfbCM6hKnnWhhg
 81oHh5Gd22w3zW8bB7XOWBxgmPqNpNL5fzKyuqtSlrdm3F131tT5AXibHFH+wkARxzBP
 qR4SbqUt421TwwoDYvF3n+wRAPdKm5Mzm5JI67evCHQHgmPSG9xo9LFynzCLRAc+zjFl
 bX73Y28gC4O3I2hncn8UqlT2aAWoUd3MoIKym1pe4fCHot0p6qJkqzDrT9Uu7V1doAIS
 Jk2Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792673183; x=1793277983;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pvXm5pa9D3m9rt8/Qhnt/b5mSwq+itrriutnsQ3cG70=;
 b=LWOl1xXOtVbKfzkQ/6fdxkN212H5W1XgaH6Gmc1/Izd4uaKXGChRe7fGvugvJuzBBv
 H4SB4ck4jZezK0Jsk6OdefZcWERnGuyNVeFH0ffKDIzkGLRJDINZmJKI89jmr9vLfkE1
 WNbqsJ09xp50SR1pfXeITgDbOhQG1+qLqOZcVR8sgyOSvFk6zosW3+AOrRjvc/+rLvov
 z53SQzMA27vpzGgRZ0Vj5tDvDiZLwNpNeBPsmJNyxn6n9GHH3ucUjuEqvHzQ/oNKVvHl
 yWknVKEflQRSBNgZcts805OrfPJJgPuwooNcTEchxlk0KRLn6YS4EFtSYvMOVzwyKsKA
 pXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673183; x=1793277983;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pvXm5pa9D3m9rt8/Qhnt/b5mSwq+itrriutnsQ3cG70=;
 b=Oyor2dOvnySbPQ0DkL6BjKK1NWZJgHUb5IfaoW26+USPCGgtmaRZvK2BscW1xVhoTU
 SpWOdjfTQ5fyjsjTkuqA7ZurSDJMlM8vc5R8gEQm1zHffshU/SK0DidRHMOQe1grOMzx
 QSfgOyLT6GPOcsevJ3ZibMP64Dxoav3ytszuIX+QM727aMDNkGiJHFhFtOldoy1j5toK
 g8+Kr100lFHxnKcOeYDpb8rnhcuFhZ8SvYworDkDj8uNV3QivQkNjoz2CrEYopUVD/86
 MbUrIvt+ii8vtEAIAUiGMz7zwG8IJzYYcdAYuuOiZxTiH85m1IFPOfyfNsbP7es+1ljy
 bLlA==
X-Gm-Message-State: AFq9FYJHzBqhPhK8I4D8Da/ReHZveiYijwkfh2WgOmSt0lqv/ggKAKNV
 +FF+0rCkpsXqb+QG1HhV9R2xOxpaiR3Xhk0hqDT75ZHSU59dsdjdLD3uAmNAmy5pPidSvpytHFe
 1pXheeCREX9PHyYOykeARK5+GVvoJ2M9QKCVKYQxoZg==
X-Gm-Gg: AYBFou3JjTUthAzQJz5IhiarP9iS6ssMV/Jur3UJ+l8LX7E4zC0J2C6QA7AuMfgOt0m
 4BQnt8EFTiYVxCsNA1naUgoX3C0JEGi45yNiGWHKsDhK0aLNGDbJNPGkjRRV/DNYswYzs9gcODY
 ifp+FIoRUwTF6upW/+GLMDxhVNLCvORB1zHZ/hyY7yBMn9HVCUMdt4j1STfwvRmcAU842uwOmIb
 olkW3zu78OVVOBuYycHfMaDibeqvU2DA8BexR2fN2tSMMHZ8xX5Ccm0K0BdF2psuZTQ5CiPYRCC
 Z41GXHV1uEbKjrzcPTdMux23Vbk8ZD8MMgu7XGqJ4mzrG4iIkXIDJNuyh16wzAUXpYSyI4ypCsm
 g+zic9DEMafYwTnYzGkYopldZg6NyjhB6VQ154RBq/lrKO1EI/BA09JIYTZa/n2Qz5HziAA==
X-Received: by 2002:a17:906:f583:b0:c45:bacb:2d08 with SMTP id
 a640c23a62f3a-c4679697589mr547709166b.39.1792673182808; Thu, 22 Oct 2026
 05:46:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
 <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
 <9e0762c4-57b1-4e61-adb5-32031da77c93@0leil.net>
 <CAKTNdwFVRTjq14Sjn8MdAG4DCWTmDPs-81qfsJGcCNo_Ay+-tw@mail.gmail.com>
 <1c6f6e9c-9bf0-4117-9999-79143ac12281@0leil.net>
In-Reply-To: <1c6f6e9c-9bf0-4117-9999-79143ac12281@0leil.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 22 Oct 2026 16:46:14 +0400
X-Gm-Features: AclHuK-cwAiuNMPpdNIcNBMZ71u_VBVyTmwcLgv6Ezk8_aT_5qN72ZkImC9tLQ4
Message-ID: <CAKTNdwFz1okf_8jstBVq7juUWLHwqiUW2L-QHxMzEPJ=CyByHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib: Let the decompressors use unaligned loads if
 platform allows
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>,
 Cole Munz <Munzzyy1@proton.me>, Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On Fri, Oct 16, 2026 at 2:16=E2=80=AFPM Quentin Schulz <u-boot@0leil.net> w=
rote:
>
> Hi Alexey,
>
> On 10/16/26 11:58 AM, Alexey Charkov wrote:
> > Hi Quentin,
> >
> > On Fri, Oct 16, 2026 at 1:06=E2=80=AFPM Quentin Schulz <u-boot@0leil.ne=
t> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 10/2/26 12:04 PM, Alexey Charkov wrote:
> >>> ARM passes -mstrict-align (-mno-unaligned-access on ARMv7) to everyth=
ing,
> >>> because when the MMU is off any unaligned access there faults. The
> >>> compiler then has to assemble every wide unaligned load out of single
> >>> bytes: one ldr becomes eight ldrb and seven orr/lsl.
> >>>
> >>> This is especially painful for decompressors which refill their buffe=
r
> >>> in 64-bit words. On a Rockchip RK3576 SPL, zstd unpacks a 30MiB Falco=
n
> >>> mode Linux kernel in 1947ms built this way and 596ms without the flag=
,
> >>> and the SPL gets 2.3KiB smaller by cutting down on the byte-wise load=
s and
> >>> ORs. gzip, whose inflate walks its input a byte at a time anyway, gai=
ns
> >>> 6%.
> >>>
> >>> Add ASSUME_UNALIGNED_ACCESS_OK for a platform to state that the MMU i=
s on
> >>> by the time it unpacks an image, and let the decompression libraries =
drop
> >>> the flag when it is set. The arch exports the flag it added rather th=
an
> >>> lib/ naming it, so this stays correct for anything else which adds on=
e.
> >>>
> >>> No functional change anywhere until the symbol is selected.
> >>>
> >>
> >>
> >>
> >>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>> ---
> >>>    arch/Kconfig                 | 35 ++++++++++++++++++++++++++++++++=
+++
> >>>    arch/arm/cpu/armv7/config.mk |  3 +++
> >>>    arch/arm/cpu/armv8/config.mk |  3 +++
> >>>    lib/Makefile                 |  3 +++
> >>>    lib/lzma/Makefile            |  8 ++++++++
> >>>    lib/lzo/Makefile             |  8 ++++++++
> >>>    lib/zlib/Makefile            |  8 ++++++++
> >>>    lib/zstd/Makefile            |  8 ++++++++
> >>>    8 files changed, 76 insertions(+)
> >>>
> >>> diff --git a/arch/Kconfig b/arch/Kconfig
> >>> index 8d63afeb138e..606b9d79ecd8 100644
> >>> --- a/arch/Kconfig
> >>> +++ b/arch/Kconfig
> >>> @@ -27,6 +27,41 @@ config SUPPORT_LITTLE_ENDIAN
> >>>        bool
> >>>        default y if !SUPPORT_BIG_ENDIAN
> >>>
> >>> +config ASSUME_UNALIGNED_ACCESS_OK
> >>
> >> I only see changes in ARM and ARM64 config.mk, should this (and SPL)
> >> symbol depends on ARM/ARM64 maybe? I see in the second patch you're
> >> adding another dependency on !SPL_SYS_DCACHE_OFF, any reason for it no=
t
> >> to be a dependency in the main symbol in this file here?
> >
> > Given that it's strictly opt-in by each platform and not
> > user-selectable, I don't think adding explicit dependencies in the
> > main symbol helps much. As for !SPL_SYS_DCACHE_OFF, that's
> > arch-specific. E.g. on ARM/ARM64 unaligned accesses fault by default.
> > The exception is when both the MMU and D-cache are up and running - in
> > which case they work just fine. For some other strict-alignment
> > architecture the set of conditions would probably be different - and I
> > have no idea about those, so I'd rather leave it to the respective
> > architecture/platform code owners to assert, not add any direct hints
> > which may or may not apply to their case.
> >
>
> I guess the point is that this is an invisible symbol and it's up to the
> arch/soc maintainers to enable it via a select (so joining you on not
> adding the dependencies here).
>
> I know I'm usually against going into implementation details in Kconfig
> symbol's helptext, but maybe it'd be nice to give an example for ARM64
> on which functions must be called before the code that can make use of
> that symbol is called? That could help other architecture maintainers to
> decide whether this could be applicable to them as well?
>
> You also missed the -mno-unaligned-access in
> arch/arm/cpu/armv7m/config.mk, was this on purpose?

I missed it because armv7m has no MMU, so I assumed it doesn't apply
there. As it turns out though, it MAY apply: when it runs on memory
marked as "Normal" via its MPU / default memory map, unaligned
accesses should work too. I will therefore expand the help text and
add a similar hook in arch/arm/cpu/armv7m/config.mk for v3.

[...]
> >>> +     bool
> >>> +     help
> >>> +       Assume that an unaligned access cannot fault by the time U-Bo=
ot
> >>> +       proper unpacks an image, and build the decompression librarie=
s
> >>> +       without the architecture's strict-alignment flag on that basi=
s.
> >>> +
> >>> +       Architectures whose unaligned accesses fault while the MMU is=
 off
> >>> +       pass such a flag to everything, which makes the compiler asse=
mble
> >>> +       each wide unaligned load out of single bytes. That is both sl=
ower
> >>> +       and larger, and a decompressor refilling its bit buffer in ma=
chine
> >>> +       words can spend up to four times as long for it.
> >>> +
> >>> +       The assumption holds only once the MMU is on, which on most
> >>> +       platforms has not happened by the time an image is unpacked, =
and
> >>> +       nothing checks it. Select it from code which enables the MMU
> >>
> >> Crazy idea, but should we add a flag that specifies whether the MMU (a=
nd
> >> dcache?) has been set up, and then read that flag in places where we
> >> have this assumption? Then we could at least clearly hard fail on this
> >> flag not being set and tell the user something went wrong before the
> >> system does a HW fault by itself?
> >
> > Do you mean a runtime flag? I'm afraid that will add more global state
> > affecting all platforms, and some platforms with tight SPL size
> > requirements will not love it.
> >
>
> gd->flags with a new flag in enum gd_flags?

I gave it some further thought, and after all I don't think adding a
global flag with a separate panic adds much. If the processor runs
into an unaligned load in a context where it cannot work, it will
loudly fail with a synchronous abort pointing at the unaligned access
exception. It won't silently skip over it, corrupt data, or do
anything of that sort. So it is pretty much the same as a panic, and
it will occur at exactly the offending location, so the program
counter will point directly at the offending instruction for
debugging, all with no extra code.

Best regards,
Alexey
