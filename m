Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kY3w8Rxn;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fS72LTSm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A85FA80E42;
	Mon, 16 Nov 2026 13:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fSGTuIz3dAhH; Mon, 16 Nov 2026 13:06:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E618F80E48
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794834416;
	b=qJIWIQclgnxb8541COGltn0Wngg9I5Eh4pJuBcIcd4KQTu4cgdj39GV5UR2EGamWFVnb
	 vaOTVL08mzMl3/vriHhZ4QZGkLJPu4ZbNWjy00E6R+sqbYYeAYm787CEjSH/pYy4pBWQK
	 mkVfs2h2tKZzcq4rqSqg5ikJko08QAAvXQ9J7DiTzrLTUlg81OC+kSQfxxWg9iHBmwENK
	 bCCkJPux1SZ2qw993R8Xls+0sjm9hUKgS24/psnUI/vQ2t/oTDqMzjVm1sYNJnwxw1RUD
	 Lsci3j38OvFEeR1Ze4rJbY1U8wuebYyqh7P67T/zUAeGG7CcpKao/DTlB/ZcudbDlYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794834416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uqK4GCVmU4WmRTfvMt9YNc41MJyM6h1AqPHvHhbM6vE=;
	b=dx0uHqsZg4/P8nRjISyBUG53Zav8ocLUKcdtepqt9jPk7LCx3169vVnHbhGQfIT1kfYS
	 EqnDh/ZBWP37T9KNwn/0NTuHDbUYht750lqROeF2mpEX+/Jk2ALRdlo/TFn4I+JA3OkXC
	 C2M9qxwsahvshJa4po0+A7ET6E1F4UpSYPi3fYgFjcKkbWIGZvFP7vRLegqZKXUXPx566
	 pCIpWI1eFo8stNJeeerRtbbPNNtpQhDPqqeq7MwKIQWiLg2yJIVcirQczZXMyQtQ09bLn
	 lKED4wiDphwahLvMfWGydtBq2HmzamIOURNdiJfccJVSia4JTFrIHwH+9o4QrNVK1xw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794834416;
	bh=uqK4GCVmU4WmRTfvMt9YNc41MJyM6h1AqPHvHhbM6vE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kY3w8RxnmwrR5AR8hdZ2JIjfXar+KZETm5CCzm35UiTsF0tACMwSCr6L3yZuWXWkQ
	 678hERBadNtJm9BJ02bxJu0lu/WNwSd6wnJDam/0q7Aj4fp2ocl/v5hh0Zp9pjzmPV
	 VJDgS2G3T6fL/vyfDdqNd/pQkeMyp81Cl3C4cSvblTJBZrDjgFRUvcry/raPBRWkcj
	 V0cgDgU3mG53qJB3RkJyuz2yjU8qwlNJWsCyYIWc/MNhkJmTUfiqLqSCJ4eW6anx5T
	 1N4B6zvduTzRUJ4lNjTXKsvItBLVwZOq4yZajENaFIOaD3IiB2ozSOV5hKLf8+U6LQ
	 mOQAy0f35AR9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E618F80E48;
	Mon, 16 Nov 2026 13:06:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 087D04DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0535E4069A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LkUrGGWnYsxk for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:06:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE08740693
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fS72LTSm
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE08740693
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:06:52 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3adf9b1f5aeso43943691fa.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794834410; x=1795439210;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uqK4GCVmU4WmRTfvMt9YNc41MJyM6h1AqPHvHhbM6vE=;
 b=fS72LTSmpFQ98JDw9/OUmg4s/muCZjYZ4RqM1bsGNXxQaRKn9IaoWWRfYyADeMEdp2
 n9kbn74ol6NPuz+DOGRPFYZlwhXn19qeTJBKAYfoBH3RSj02TqY351MIeEi5TifOLImR
 +gqyok1gKqatrDV9xBOKGKNZBMk/uUBCP51oTNDkgjt1nid4yXfQEZOx7iMC8mPu+udr
 VrhelMCGKDMPkgRtmDxV1fdu0A8/QZGmrxyjBVbOvUhQtQm+suqp1E+5lc/nQIogQkEj
 tlvR0gFEKhQq/3YZfnlRNiZ9OhXmAmIFmzF7mrevvFGEaLzPG+qPx2tnumUYB56QjGzB
 JQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834410; x=1795439210;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uqK4GCVmU4WmRTfvMt9YNc41MJyM6h1AqPHvHhbM6vE=;
 b=uIY1+Jn5rfUoqqBbmI+fq87BcnrpIZiSTu7Xsd9hubGAD2j7otEAspCdAKI2zPeXPP
 EgSbs/jyfjY6YpIxA4B768+dybuewa28qsEHGPQ6xvKy3ub+3SQpjLbcIRcHJzYcA99a
 tN9BBcXXj/dbqAC990Wb24O20u3FlxbrMPpREVXUXY+yn+pW6xdX3F3vXN8wHdp7OoOj
 0X9KWx3/s9qojrh3vtIwcIMFuSeLdf8uXiYVUkWu73l83UBammktJbJWWmgt7G/u7yxk
 ftou2/9g5mY+udKvcMO2mI/d1oSk7OOzngH7oT6vfMWjnZGrANCD78494jyx49Pd1TMU
 JogA==
X-Forwarded-Encrypted: i=1;
 AL+hErFWJxFzk6cpCm49eTu+D6z91wUiJDkvzqHjBtOsPj93p6mqTtnJ58NgpdOK2BGBh5uR0kuInq0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/keCBK6NvOfVes0ztfupZo+UWjVOqR0wcyOAPf4FvRKscODwqo
 2OT2eyVd42Qrt9T15/9dfTXbQWJoACDtSofg7XXLbP1AifEKXLphJDBXnCLICrVOlzoLJwp/Hva
 j5VZjaKB+N8y6KMxUPFbHDcSAms3tcwlERkVOJ6APicMASu/S/qZDXlnDoA==
X-Gm-Gg: AYBFou2yT7gMvUmXccsOqen4V9cI3N9ERRqrEcj4kY0Nq+nOMjpwMjs+Eop9srOvozR
 PAFb/gNRtQcOkDVUVtipYFvyHkbwmnBT0z58j2hhRyF7Vr/sRH4qH7f/DJ7aTQ2Zsh8/X7hWjxP
 5fBbyafJedwJK9Ta/BtaeNIWVpvJ7erJ4TeKnMLUKESq4Euima3PAQCIpV+TQ1/JwzBpACLo1Sh
 q/+Km+6mULOx05EXbPZbsrym9CzpCUOhFDSYW2HeYQZx/exukOekkHWjrZZITHFhmekZ/XhRrcO
 oEt2ITQu2RuStZ1tLu2K/CQ1GYXZmyHxFe5fdhRq5FtE9QaBhdNYteWX7rRKPFTA0dRvBSHV3A+
 ko40Qv3rKxoN7imsHy/v+0InSMLaX69KrHFHXaL6QrQgTdHyQu5PmTMDquykTbXLbQ+O0CZkrau
 AMOAD6r2kufoICoYurFB+FiXO3BXzUOemnrJ6f1wdiNLqOZpbGT0GzuRoAc+PUTtS1TC3LcMuPA
 M0IBxQsGiS9wOU2z9BvEyDbwAZXHuM2PhmUU5fduHuay9grE6R3/D7SWLtT6tHUUhlRLIFMZiQz
 od0KMHRxx7WdUaVbin3vhv0VMS9cS9nAkXuv3AfxNmKePwlVkXe61SqLTp5DuTQpoPu0lNp3HkC
 qVO2o4nVQbg0mtvUwgOg84vezslzPyK3PO2KzEg2/OKTvIMF9YmlbT/AR3q8qg1bV7wBHuwaYU5
 7+uA/bz7y78EVcwbmEqZBJkJPCpqqDcjk2LrAdD16BlTJqjuGNHXlln7j28gT2v6/fqk0c
X-Received: by 2002:a2e:a98b:0:b0:3ac:4f4c:8da2 with SMTP id
 38308e7fff4ca-3ae1c0007c7mr35356371fa.17.1794834410066; Mon, 16 Nov 2026
 05:06:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <b33d1c37d001192a911db58dbadc5f7223051a7d.1794614217.git.daniel@makrotopia.org>
In-Reply-To: <b33d1c37d001192a911db58dbadc5f7223051a7d.1794614217.git.daniel@makrotopia.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Nov 2026 15:06:11 +0200
X-Gm-Features: AclHuK_AFLs280yvWC7BaImjV5PFCFvBvIBI1F4iAltWNQDd3tTl6zEY9wu1jlU
Message-ID: <CAC_iWjK_2_vxx2pBBTSWNjBdBqzhQqxhVqWna_XU=sk4rw9Gcg@mail.gmail.com>
Subject: Re: [PATCH] lmb: Check available space below the allocation limit
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kumar Gala <galak@kernel.crashing.org>, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 14 Nov 2026 at 01:57, Daniel Golle <daniel@makrotopia.org> wrote:
>
> A limited allocation checks the full bank size before applying its
> upper address limit. If the remaining range is smaller than the request,
> subtracting the size can underflow and reserve memory outside RAM.
> Check the available range before calculating the candidate address.
>
> Fixes: 4ed6552f7159 ("[new uImage] Introduce lmb from linux kernel for memory mgmt of boot images")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  lib/lmb.c      |  2 ++
>  test/lib/lmb.c | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index ca00047f624..8067f184f44 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -698,6 +698,8 @@ static int _lmb_alloc_base(phys_size_t size, ulong align,
>                         if (base < lmbbase)
>                                 base = -1;
>                         base = min(base, max_addr);
> +                       if (base - lmbbase < size)
> +                               continue;
>                         base = ALIGN_DOWN(base - size, align);
>                 } else {
>                         continue;
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 168c66ae649..a69a915c06f 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -12,6 +12,7 @@
>  #include <test/lib.h>
>  #include <test/test.h>
>  #include <test/ut.h>
> +#include <linux/sizes.h>
>
>  static inline bool lmb_is_nomap(struct lmb_region *m)
>  {
> @@ -491,6 +492,30 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
>  }
>  LIB_TEST(lib_test_lmb_at_0, 0);
>
> +static int lib_test_lmb_alloc_max_underflow(struct unit_test_state *uts)
> +{
> +       struct alist *mem_lst, *used_lst;
> +       phys_addr_t addr = SZ_4K;
> +       struct lmb store;
> +       int ret, count;
> +
> +       ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
> +       ut_assertok(lmb_add(0, SZ_1M));
> +
> +       ret = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, SZ_4K, &addr, SZ_8K,
> +                           LMB_NONE);
> +       count = used_lst->count;
> +       lmb_pop(&store);
> +
> +       ut_assert(ret < 0);
> +       ut_asserteq(SZ_4K, addr);
> +       ut_asserteq(0, count);
> +
> +       return 0;
> +}
> +
> +LIB_TEST(lib_test_lmb_alloc_max_underflow, 0);
> +
>  /* Check that calling lmb_reserve with overlapping regions fails. */
>  static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
>  {
> --
> 2.56.0
