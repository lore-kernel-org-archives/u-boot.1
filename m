Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0001606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nIpPVNNS;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Uv/cgPXk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CC7C40ADB;
	Sat, 31 Oct 2026 08:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ROtjnlxnVZgf; Sat, 31 Oct 2026 08:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D36AC40B03
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436198;
	b=pZDQmk3HonVXp9mjY/f4e5SJaTfdmvgLRK0hHtWA8GOoratEYZhkMdNX3/U/1MpWk/Dd
	 ZZKghgJJE9/L5CFFEginDXw4kPHX4sQBM9YHansQCPkITt0vMmh77KQm2euER8+o9djVY
	 cYpsER6Zw8k9dmEIxRsa3gviPJ8+sEKCZ8j8DRfwqxCx0Yifaq3ZFILqGys4M3o573QgS
	 R3FW6XTaDfrZ2xlkUVowHsLpZ7V+DEwh0BwpfHYn4444yYf9sm66jUG00DiWU0V6RtiHY
	 Xt4c7HQde01jh8BkbqXdNbLnXYygjU2x+LRYe4ayMh1g6FvqPH03aC7ur1RpklwKPcQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436198;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LalOMqAGnaGDWOPd34RKKIM/fhVo0GCCrRnNRORKwMk=;
	b=bN+NuOCBnk5FPpYhG5XADmtCiKLXsLPUia6eoMGKBWT8NnF9nvbhhv//rVXRYDxPjhCr
	 9ild+orttMTSFoPVkZ/B27yj/Gb4KTMT1Ur4FbLdiOOBMWAe5WtZtWb3t95k2Sejs5sTg
	 6USu5lFCvicYsdhU1VIJuYBVOHI8YN7+HluAIXqGm1+1wIfACvHLoumXKj3aDo/MX//0Z
	 UJxS2bHCWXx39/olsDbMOPvKqqHKOkdoS648YmxwdAS3vwwzJcDz3cevP6wIHY5Ig2PiV
	 juJZYyxnw1u10zmlLCvZJ0pEwlL4yeLkTv4G9I21EY11yHAjI94j7oAvalNaFkZoGwg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436198;
	bh=LalOMqAGnaGDWOPd34RKKIM/fhVo0GCCrRnNRORKwMk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nIpPVNNSWSytYdY6JRjED+DWO86//bGw18tNsQ8CB/655R//mlzxxblOipwqfQY0D
	 ulJ7Fk7c4ku0sc2ClPhtDyATmdQBeLR1ntYtHUUgCrgbPkDu2RwTuQbc8GbDdGjnKg
	 2a9JhiwTwWvC3bNeXZuBwhxg0SNDUQpYTIJte3CE5nqB3YxjgrFHLYsK40MznSAZaQ
	 UDd6iUgLVABtV99XWdfJB7GvtvY+RcXNbMqRzezRFgVJd7yFwDsrQ/Y29xynABdMjZ
	 dOMknq/lzbozPmTkpHO4fxXDF9ASmyENCDWXc8/5e0NEFDwG+Rwxw9C2CZQK5+xt3i
	 MpDf65tSRbrpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D36AC40B03;
	Sat, 31 Oct 2026 08:43:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BDD37156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFD86810EA
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAzLA_q5nTlw for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:43:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EAD3F810E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436194;
 b=b/VaCm4b98qmmOhiI6lXMuo+b595S0+LvSVhjhU2qxbCho+LMg9S1/G32UxyVrYP+8J2
 xpN99CRAkBMWIBt1l05c/k2IY3GYCLRHkLu8CvKYwfbhOhRexH8g7SSGLITQOx0HfmjCU
 o1eIHac6SIh97SsSPxaU8Gr4Xa5rUwj7l+EASR3lo1/9eo7CatrUB0/K4U0v5VQyioBnu
 ziO8saVLggZpnS3/8C8MtGXvLxYmmh3Fa/VDCQNzW3EpK3gRELB5cJF3T2Gjm07d/UlgN
 gIvVv2vSS6G7z1h4vrCi8rVazEfoyLqvqS2i9xOl3cn9oeXlV3L465jcC0YnmETe/wA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436194;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=LalOMqAGnaGDWOPd34RKKIM/fhVo0GCCrRnNRORKwMk=;
 b=FJPu+RMVC+ibmVRBaLRitVRf9NACaRs49Pgipknwu3DvD8aYHQjSeoka8uVd/gGl1hz0
 8Q9KAxkMSXBOExo/za+czLCJdOvyQ6snucmoDWOFfXPG3krOhnuTHqdJYAPPeIg8KjYa7
 YT1GVmJeaMeLd3jotSaSyFnfrN6FdVYYQwxxyDmIWVDqoKg6giHRuCR0tqwblkKRF/wby
 Bf5iVNm4UkYnnEgOf1/85Mi524tvtc9IWU43snHHyS2Her/MA/m+eczmDn+Ms0qYX2I5Q
 cF2fqge+rVQPHdvvKBFC2+ABaHdltbsGUBPkReTE0ydiBX6xn4mCofqMAy1vbXU4peg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="Uv/cgPXk"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Uv/cgPXk
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAD3F810E6
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:13 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so1255308a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436193; cv=none;
 d=google.com; s=arc-20260327;
 b=gpbu8SQnvIRcwi9sW37+gI/nH+KFCAob2TGOSZbQhbq1wBW4EiXGH8gfxqSGyq1z5s
 fGfgBuJtGutW71KLzqbwX/SU2i6kjENgh6UV1/ef9rZN4HCwaur72zcPVBGcjrBJwkm/
 PAzDITQ3Vab9uO06mf00xDvVkSApA+cxnMpCCC9BbgcgTjHdJzHKPoBplQ0CXIy03guN
 w7yyAYR+qvYMhBvK9SCP6oSOkpW46Pn3fKiXbDmhzUN/K2trqUiV4IBAUpP+G/8peVIa
 kdKqTgLyDaAWcJwF83TSE0PCYW2i90jmCLLZpwN5h832UhigItQR4f46GBEjigdc+CoC
 vQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=LalOMqAGnaGDWOPd34RKKIM/fhVo0GCCrRnNRORKwMk=;
 fh=pTetJRX66IoyyqKP8acSKADBrXkJHol7sWom+2jRvdw=;
 b=JCIxrl5Z8p6sMM2yYxBGoYiy9Ev+F0C8bWwB+k2j9aOBxamfywzLBK2T0bjqGx44CG
 7ZFrJP7D4EFpSyfCCmcIGw76UY9kgz/5wm94jQvAiQDvp3tLu7lvp0nz3VXCB/YcuVI4
 nTjoo5CKhtJqFLi2fVkEtDGt+hKk6oBO/qVm9mEdG19boemH5tdPtfAQWUkxVglTH69l
 ns7e/Qko70IS/1s3cnvk8BGmIqC/uF1RPoURaWa6r3Bh+ebp0eaUCQkZPfDDSAuJD45e
 UTCoNcJ+zGLq+ndllEZmuZhk3D0f2NRQEMKKNG0qFzCOL6QXjbtQIn7HyQHqAzuXW7xe
 m0bg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436193; x=1794040993;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LalOMqAGnaGDWOPd34RKKIM/fhVo0GCCrRnNRORKwMk=;
 b=Uv/cgPXk3n1IUM+pfxEDvTodeKw8kjbhHFOQUBQF+0Vuvtx3llmKQqNPVlOkvT6ceZ
 yTYQUek6YK56dXmlz6WNP0jWO8R9RQLC0j7Se/5qjDeMV1KeuuKXLG9qOCy2JF0JCtbF
 +NQwj501CiS7uP6Cp5NalRBXA9dAOeW2s4vK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436193; x=1794040993;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LalOMqAGnaGDWOPd34RKKIM/fhVo0GCCrRnNRORKwMk=;
 b=dz8kW5qs/6v9XkGfZNiR8x6l+3A/X7VpdbacOxqriffyli6FFut3MG1b7gtrFsDtei
 qEbFTfZotLySeQuNlIZ+keTnps17q9+FGBqYn3iME9Rct9rYZDonzoraTDyJyJjpyTuf
 U+bB2ONWgTzPl6CWrvcid2ttU4UFUmKZOjOA5UOyYGAeFRcw89i+O/ihvEJyQGoc3uq/
 UEPo4XbGfxOrtP1QCidpMTvH1Hucd1i3F9CDzq5licAqVWuwR9liDrpjlK/eDX4SguKT
 CvOrDnTKDUfgrMiT/u5OiSRncZzeIQ879strz7AHo9hUPsYipww1tm7kc3XdXVoLKmsa
 BFxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjU6w9D4GGOJeMSzx5sOf+GNqpjGgRbYS8VgXFCbyiz519r+6X6lrg0G6dle2r5T1b1TqZvbg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKVqPR9Hk8K1HoG5+pKwKn7/VXJSo8ZCRrPd5R/EmNHKUN7rb2N
 qwsV4CEy0NeB/6M0mw6XdOT96LBDDoQS8LrRIAvedLr0gjho4tIIxHRL+jh6P1IvYulIy+OG9/q
 Ee5qzQUTohbHhQExWKjWzBSFbfFChy5ZLivX42vm7
X-Gm-Gg: AYBFou3WNzoPtSC/V8Shx3CJWUb+j9jxfII2a3snmKiwaa8oA4ZK1t6G/KIn1c60cO0
 GGCcAzrMmonURoRaZRX0glRyHvsXjspP/tOR8Dx2o8TrJ2VQ6kE4hHBL7stE/BmeTLaPYLvuW/1
 oUGhB8NvY6VNcBqVK+cvIwlHUqbz/B6wMuiZSbMZ+P2ClYxx7YBqVs7vx+jZ8K2wSLjvVpescZ4
 6MzikCtqrLlslEtk2nHmvQhvHiU434qTP7JxRZS/03T9yKLQejqaCZdoK5BAhtrRt70lJ++Ewcn
 fS13C40glKj/UuHniRnlANb0Xc6Sin+2DZb684u/45CLtX7i/hIGS1w7aSEHnu8qHp1dfyHJRUr
 3UZXUwUx1/ZP2UuLEQQxxAGJmKq+/uZFaNMHRVGPXFstYChLZLJJ71lqYGcUaiXS+XwOhUhc=
X-Received: by 2002:a17:90b:1f92:b0:3ad:4a8b:c701 with SMTP id
 98e67ed59e1d1-3ae897b51a8mr3928921a91.45.1793436193138; Sat, 31 Oct 2026
 01:43:13 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:43:10 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:41:51 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029050738.1107663-8-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-8-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:43:10 -0700
X-Gm-Features: AclHuK-Ht87f6w1XSCJbiSrhMZZv7EAV52TBclCLteRCLf7zzrzRxOLRPwbH7-k
Message-ID: <CAFLszThRv0=yGbu+bf_uYPjv0aGME80upMX41kbSaQ41qPfzFg@mail.gmail.com>
Subject: Re: [PATCH v6 07/20] LoongArch: lib: General routines
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
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

Hi Jiaxun,

On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: lib: General routines
>
> Add cache probing through CPUCFG, cache operations, setjmp()/longjump(),
> and etc. for the architecture.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  arch/loongarch/include/asm/cache.h       |  11 +-
>  arch/loongarch/include/asm/global_data.h |   7 +
>  arch/loongarch/lib/Makefile              |   7 +
>  arch/loongarch/lib/asm-offsets.c         |  66 +++++++++
>  arch/loongarch/lib/boot.c                |  14 ++
>  arch/loongarch/lib/cache.c               | 235 +++++++++++++++++++++++++++++++
>  arch/loongarch/lib/reset.c               |  14 ++
>  arch/loongarch/lib/setjmp.S              |  52 +++++++
>  8 files changed, 405 insertions(+), 1 deletion(-)

> diff --git a/arch/loongarch/include/asm/cache.h b/arch/loongarch/include/asm/cache.h
> @@ -15,6 +17,13 @@ void cache_flush(void);
> +#define CACHE_MAX_LEVEL		3
> +#define CACHE_MAX_INDEX		6

Please can you add a short comment to these, saying that the first is
the number of dcache levels tracked and the second is the number of
cache IDs that CACOP can encode?

> diff --git a/arch/loongarch/lib/setjmp.S b/arch/loongarch/lib/setjmp.S
> @@ -0,0 +1,52 @@
> +ENTRY(setjmp)
> +	LONG_S		s0, a0, 0
> +	LONG_S 		s1, a0, (1 * LONGSIZE)

There is still a stray space after LONG_S here, and after LONG_L in
longjmp() too.

In any case:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
