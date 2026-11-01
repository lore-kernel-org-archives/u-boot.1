Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BF606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q19nQ51J;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9pa+oj2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09A6280E4A;
	Sun,  1 Nov 2026 08:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id caSsKBXdMWqb; Sun,  1 Nov 2026 08:43:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F13080E7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793522587;
	b=nNtOHEUSbvQjFJpbT6eXkzBKpIS+UJEEaSSWh7GLB5aNjeyG6Zft9GEcjbRSNgIiyMQx
	 FHqTWC3ccmm+U+JpQlyFA5O3Kjkk8yMIg4bfwj+hu3jld7wMxzYZsjxI4yT5IaCu7Tphe
	 6o53bPMdw4BrXavL42P9BDjaJ8lJ8Sskk7bgzg/lcOk1RrLwdqe3WCzWI/zzwkYBPM1hj
	 Wfk7uuhXW7hR4qu4E1AI032KDJcBgOsWBEkGAP9p5AaJwJB0gc+iqqmaZGYiusoM4SIbh
	 kC1keoPlnWBgDWDUxbfSUMmivSQFGPNPLBdLiw+sC19yjRRbwA9T5qJ6OckikEQLM1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793522587;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AvynEl+whgpXpR89RU2NpZWvEkBoRfDs4FEi39aGpXc=;
	b=VMOO6BV7egZU+bz+OwdkyWOA1icr9JLxD5tJ8THfx0N2T/VKPCGf2OaPmRIv9SVMkteJ
	 QpnE6AGw3FyApRelcUXK9oFXvZhnXtzPZuq6lQBUYnQGOPypwpt0cevpEkYc9dUGmVb/c
	 z3oiZN5go+k6NzfQQDUaoMqrc8A3mjg+a8P0DNp46e2gY6Sz1oxW/KYTRBqXmwf67UP3S
	 2cxaw+mIv7L6VGsn8hd3E7qV+eaf7FZovQGV/b5xdxDGe/ADj/pFL7dAzBrNa5z6Urg92
	 4unosn8zBY67DiacVg380uT+nBrsyPYPX0qJN7Zt34XVTWSmpQWVAAkh8raJsLdVnAQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9pa+oj2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793522587;
	bh=AvynEl+whgpXpR89RU2NpZWvEkBoRfDs4FEi39aGpXc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q19nQ51JVqssD3E5Hv1hT0ZuAzBjnzdGwrCMLHv2i2tgzDDj4D82cKUFHV0dc3kND
	 J2VgJ2PcrhLoV9uASvl/OADo7Gn4Z8m45vvJyJosjVOMQ460C74SREXZ+PIOp4xPGX
	 wIlrExAnyk1ZXjk6hMar4bG+MOXT+3pwgF9gRbytE+z/yjhVSwzQyZle2XmTvs1Ggu
	 I3WI+TwZmmBMSkKgtdW+IqS5el+xewaoiN7HYeXBaDpLVXx7TuSvSdTke6U8d7w462
	 uVyoRxsnGkVtdkKdv8JfaUwsntM71G1/iaeb4EvxsAQji6T+6eaA2WBGV5zGiE/sLU
	 Cb8TwSbreEW5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F13080E7D;
	Sun,  1 Nov 2026 08:43:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 557AFD3A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 08:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B37880E4A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 08:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaq4XoPzO7wo for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 08:43:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B61780E48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793522584;
 b=FQRoNXW8E2wLVi7EtkPoEJj43XDi6jm5Q3tpeAAJIm04aJOXFhx1xZkH/o9nqdlEdPiA
 pSHAQWQYbsPJuDUVBelJID1W5y8Y7yv8TfHo5im6mPgLt3z+JiahCxAw5rwl17FUjqxgs
 Ft2c+49+hqLFjogc62fiA+S1GjEZmkMVJQ0ZcpyFb98zzwpqKtSE80aVYYmDt2QC9QgTc
 rz86iM5GKK6K/kKhBSfMZPPub3TmsxCUfEr185asbgqQIAiN/rXtWFJH6ZPuHOPQ+5Qi1
 H/8pllde2JrjNpJLlkOkrOixx8O4nnbe5wUmvOR8Yun/7OMSPGSkOJS95jOPfuZagnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793522584;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=AvynEl+whgpXpR89RU2NpZWvEkBoRfDs4FEi39aGpXc=;
 b=jQDt1GWRkrutsx9FQUw4/O1Nf8ZFyGiySmPxYQRvoEhcGPinMrVR4U2IAGrdtuqUX2Uo
 4z0r31Gh9ET935mvO/tnFbm8m1scI0QI/2gX7Qc6pzV9g+yNkfGvD2ymdWJ8SzGevphZF
 UTL1Vw6ZKFVDh6gBhl7Z6RXUNMBcZA+NwJ2OumbdoDHmDTkTeqcdn98YmNqqdfZw7pd/w
 S+I7uxjua6LMVgru7zC0NzM+Tffpy+tTC0aSpG0n/YnfYQjie5ImdJ3Fu+coPR5TD10NU
 SBxBKvIofYRh0MB65sdFlrLus632Y/QWpIEuFKNBsCJLU+jpl0OnGWf9oKhIrjWcsTg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=X9pa+oj2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=X9pa+oj2
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B61780E48
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 08:43:03 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-7143451981fso1490870eaf.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 01:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793522583; cv=none;
 d=google.com; s=arc-20260327;
 b=CPf1gHYsgXid8OIzbO9e1ri0q+/FYqY+BHcGLY56xiTe4R6v2603Marajp2BLnj0w9
 3dgoMOaPrfJKMoCMVIk6O5gQHwd6JHoRhrHgfV1CafvXqJfVQBA3x2Mv8w7rr8AfufNF
 L4wjpWXt4C5vOV8jzUSSPZQgFuonI8pg779BFeehnspXph8xdtfJm/t5MDCWMktGV12j
 cHt+Hs5vnE069YphjtqTDI5hwctHKNmetAnZ9K4c1+irhtKLn8fOdRQTP+T+G4cQzHue
 ivgZBbEa4pIBkn7kyE/kjyhL8FxPzVqrxWAzxRTPV1YJF5Yr52RDim9PB/PJZ0MVpNyL
 lXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=AvynEl+whgpXpR89RU2NpZWvEkBoRfDs4FEi39aGpXc=;
 fh=8NU91hLE2I34eM2WZn20MSxnLLfIrdlhlVW1YtdVM2o=;
 b=IARLuyNHv/4qKcmbA0GTe+E1XN9zqu/peD8b5GbmIxnE1pL2I/uYGKywJx4n46vBvl
 oOzOTGb9xcY+02gUvTUb+KIbikPYSRYrcjwTH5NAyUd1if2PuZ1rKjfpztywM0ju9XEE
 uZd9aMzOOKx5iNeh49Z2WTsgwoBst1gnGCGV66/Pl5ggasjcEOsdwfYBaTbXpHIUuObn
 MCmCmR7WXAPdUt+vbT29RiykfBLrMO+gDFIhFnWLFsQQYJBOQWfGisC61uIgHL3vyZFs
 NRhWPE+bdIH2TzPfam1l/nsGayJthAw7EUQElv1uiAqY14zUablOuh3uMemS4UemHKEi
 8BLg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793522583; x=1794127383;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AvynEl+whgpXpR89RU2NpZWvEkBoRfDs4FEi39aGpXc=;
 b=X9pa+oj2y37atc0yDegOZ6nBr4ffB43Nd4aBlj7mBNZPRnqnLf/BQF+HYnMReQpi49
 9l0FTjKJuwn4uIDyh48GayIrgvoICfMQkmkzKSPVXatm8Ggdcga6wtW5ZOQ8PEr8aDny
 BcjoSH7+RD0Ljv7yN2selpkA37pDIY0BaFR3eIchquHDeJYaAtBvMwq7Ycg5WSWst3oS
 ZXVYNOu/IrKgp+U85tlOBmVmAu1kWlNtWavOULki7b4XXawc2QYb2oZ3lw/Yzf13vx2v
 0iVeWAHANFzwSE38HtyoDBm51f+QcgCXaH3rNrNrYBJNfiRshSZig9gWetF9YyPfHJ1p
 eoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793522583; x=1794127383;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AvynEl+whgpXpR89RU2NpZWvEkBoRfDs4FEi39aGpXc=;
 b=XH3ZlG2jgx0gasDAGm5KNhqxIDk6uAQ8Zd70tLiBrG3G/6EwOLkdotZrd49jcZQCzw
 90geULfqCnbAL0w43W3DTqxlQvnQ1blAkPGfvZJ1lSJzTdbZlnkXBpug+v/9fiUZlZjd
 54qiBLc//qOjlomBfETH6iMS6Nat191OAF7+keanwHgPcY+/9838h2z99wnVxxwrHxER
 IvCMpYLQQvhXd9FJFKdSq9kpVNPVNWOQhOF46ZWhXRzjh24F4AfxFW6vrw9SKJnMUVsR
 BLjhnWinSFEsf44/NHyP1USZWh82hzhdhzjvN6NLdLnk/Q+TuFkyhor8UCRE+19Q5+Ik
 ghmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBweOipCLVyQbXmDO/KvbpRl4+iBzU35zTpMzyfszf6OGThF/h4YuJmMNimrF1GGUgXoW23C06Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJbDRNJrNrChM+KLwG5m2SHApBO7cz5M9m9UWdDIk8NYjAS0EJe
 7EU0Ja8NHVf5nSCTqvTTCTaokRnZqw+EVb6dX/NItHCQ/6GXZEdmvIz/6lM8plfAsh4GzYtMDnO
 Q3ZxUfc6/9ovTNBcY+JfbTcy7CTIYSvg=
X-Gm-Gg: AYBFou11I8MvuplmVZyD9Cvah+oF0UAzbg9cFsoGQ69CegRxh8kPfiZXex3ouHNVtar
 5D9AZ2Ndb6N3P5i/KtRVqmZxOVV8o/QoR41kKTkGOwiq1P8STx1gREr9LEuxlet2foCYN0pp0xj
 r5Moz3hNR8getrrRaygt8bdRBOAUsv9y7tNn8uqws+DZgoEBlMtapIFEYFylVBimbf0va2ZR2ey
 POh/Lh5pv/jViOlqeZeGor7kCcRypY0WHSiJSIcn9bjojR21Xz+BPXgrltVROks5kImdXMq+qME
 II4wM+fuOba2H8qPk15gkQwG9su2FERSJIoxdYaRWwtzJY1SG5Q9EFTAcydAH0g9G2zkKfaU5ME
 iSHwv7B2dBU/VrCfLVh4Q7gPUCaqpporZNodYAw==
X-Received: by 2002:a05:6808:c2c7:b0:4f5:d873:aaaf with SMTP id
 5614622812f47-5640dcecafemr4820372b6e.14.1793522582719; Sun, 01 Nov 2026
 01:43:02 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 01:43:02 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 01:43:02 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <12ECB91C-515F-4BBA-AE32-A6654D925C24@gmx.de>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
 <6de0ac6c-e5b2-4776-9c6e-3ebd371dbfa3@gmail.com>
 <12ECB91C-515F-4BBA-AE32-A6654D925C24@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sun, 1 Nov 2026 01:43:02 -0700
X-Gm-Features: AclHuK9TcsZZgnGS4URW5clR60QDPbHQFu6rys1m61xR5nDmnEaqce_lwxYEWfc
Message-ID: <CAJnxHsgCejmQHvVTwqq05qWZ8-9zvfQoupfYau=dhpS6djf8EA@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] disk: part_dos: Make room for a three-digit
 partition number in the UUID
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On Sun, 1 Nov 2026 at 09:03, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>> +	ut_asserteq_str("00000000-100", disk_partition_uuid(&info));
>
> Linux include/linux/blkdev.h has:
>
> "MSDOS UUID is 11 characters."
> So this change looks wrong.

You're right. Linux never numbers a partition above 255: the partition
parsers stop at DISK_MAX_PARTS - 1 (parse_extended() stops as soon as
state->next reaches state->limit) and add_partition() refuses a higher
number. So the "%08x-%02x" UUID it makes up for a DOS partition always
has 11 characters, and a "-100" one could never match a Linux PARTUUID
anyway.

The bug is rather that part_dos.c numbers partitions past that:
MAX_EXT_PARTS is 256, and it is only checked once per table, so the
entries of the last table read can take part_num up to 259 and overflow
the 12-byte buffer.

So in v4 I'll leave the buffer and the sprintf() as they are, and
instead lower MAX_EXT_PARTS to 255 and check it before each entry, in
both walks (part_get_info_extended() and print_partition_extended()),
as parse_extended() does. The test then checks that partition 255 gets
"00000000-ff" and that there is no partition 256, both when looking a
partition up and when listing them. The patch becomes "disk: part_dos:
Number at most 255 partitions, as Linux does", and I'll drop Simon's
Reviewed-by from it since it has changed.

I'll wait a few days for comments on the rest of the series before
sending v4.

Thanks,
Ana
