Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181C606A322
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AejWA+Qb;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=njBSWmvL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6D6540664;
	Wed, 28 Oct 2026 08:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tRLy4ibJkqVz; Wed, 28 Oct 2026 08:57:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0EF544070F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177821;
	b=IlUTlVlBd6qFSgzhALN1f5R/flqiG3AG26kAGycSJftmnVxWO3o0L4mUBfz8LohkGokh
	 +W3cR1t/NAnVyFPrutTVWXzxaZh8gr8CHL67HAlP9swwsumeOpgOz3UYrJqayrKr7HG1v
	 a2hFyg37i1za/ctjZ6NOAH9YhSrq7WXV3LkaTrkjNqp+Mh6JKJJaNUgJA/Jo6w1G0qrLA
	 YeUElxLsY7GBFPg8h27edco2SdavlpAtLHwnv7TzU6fEMbnkw737QfOBEHUCfc3sEMiUA
	 b87KEtCfjaBMFcxAx32VTUMIXL1FwGKxGcMiJBFBrjUzbdrvTKY4+h2cbiu52uGbGGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OvM0qgHK5v0B7GW2gJQiIWPw9rx1fgBEXoHS+thUsHc=;
	b=amvhz9yYxMrdHAAeRPJGetAqdnWsbuNtnrGgv4PzzgQvBi9s4w30ZLeuWpQM8BN3Nrmr
	 fZKTRthFpSV3et1Rmu06bLBgXOmTmD2uT+7jO4jgMibBfEP24bKd94GMS0CSbjsd7JFM8
	 Ib/QomKG+bZ6J67veDxBq1K9iKsJeIxzCgUmOD/ggA9J1uEJcn/1RjEGhaiwH3nJA021i
	 Rg3Xm50vsbOeDDUeUewNORRapMYquIu+Lp5Xt/ukj3pJKHDFK81gQCbqB0x7f1mWTbrAC
	 vtmazLgL4JChVLdSepGvrWebK2ZcgftDT2KXQlcBaNQilMd9cIvgZSmWUvzdMq2jbXQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177821;
	bh=OvM0qgHK5v0B7GW2gJQiIWPw9rx1fgBEXoHS+thUsHc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AejWA+QbBTqSP7m2pgmh/Aatm2D0V9tF/70VvrjKcm2eKGTydilYoYr8aexeSGDKo
	 UMUsQD2r90kuKeFXwbn5Mu5CCXXD9A43VnllBn72t51pfbQM6RzQWenXnpOSayJcCv
	 /gxr7ndB6DMH1aKSA8SR19HsyQ6EkWLL/RPNwWHh871+cBSmqcOO0XveRbhB7AnWkt
	 DiqzteS0Yumu9SPWqgBJYc7DY1bnlAfEFNoV7DZ4yfomzhFyaZrR7Aq7kC4HRIBm81
	 HGWloE0hT1b4ljoC816j2Ftw5BjBf39te6Ji855LW14ZzHe/cR+q6aMymxlb0MDdj/
	 0CNsPVqkwS21Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EF544070F;
	Wed, 28 Oct 2026 08:57:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BE504D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8173C60658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndYViyxvChFz for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9D6C605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177818;
 b=lS0Vs4Es/v+kK43kDUp0XdIdGY3A0Ibx2TytHxyBnIZ+jNjMuaZJOKFFoqdGiy/dOviJ
 kVcmBg+aSW1ao1P/Xsta3Qs1apceecEMw5ANGxbhtdFE92gFY95jXdYyXsgobD16eZh/5
 8AeE6HDK+KV19jKYHu1wtrJSKl9Uwno110L5j8QtDJ7rE1Uy/r0uyUGCj7uzlrMmhHmnC
 Mj5TWzsCB/4J1zHl5flLycv6D2cVOngtXcBQncoEnCgUUE6rf7tvIk5lnrwdQBrsIruWA
 6ueoJlV3e/Ug3g0kbxf+PFuZIKfID98P6CCSe2RWivHq3RopiSfoRcUVjHoVFiomGFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177818;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=OvM0qgHK5v0B7GW2gJQiIWPw9rx1fgBEXoHS+thUsHc=;
 b=ZmeAoWKAZGRohwNqW+Zk04L9KLqwHkVv01vB6xhSZGFODDUTjYZalNmxNuMN/Gb53fDP
 ntzyPdNL/9moD50CjPZbhb292X4zMRaJNtIz6W2mWPRE7KFe02fKQ5yF63wEAZNL+EQKW
 Y7GxX9UaWH1RTxyGX3OGQ3LHUNyFXIgjPNe16yzAs4d6KNx2l1TedDm8SySqyy4/Uyk5O
 qFmYufMrxXYLnV/moX6mYSZpU6cjMd9+34dbw61P4wTIQlmgETNxEf2cU/TwQADGH3fJs
 N9GfkpZV3HBWIdrE/isdJNf0R4KODg0MbkKAP9g0NzLXHBRP7Jz9e1ojf16gABdvC0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=njBSWmvL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=njBSWmvL
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9D6C605EC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:58 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ace9e6e1a5so1117276a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177818; cv=none;
 d=google.com; s=arc-20260327;
 b=rDgI7IbSUfii/fQXu/d1fKpFZyg624LOH7W88Rm38tWSlhfA5MpvHYcT63NtCG6S3A
 woh1FIrE86T9fjaPJSK8Boxkufkl8g5M0zwNHG8lWG5UHXv74r/0cVmOBkAo6sphhOcz
 wKRiXGN+DH+np+wIKclRveENb7rShYaW2Er5mR/GJymPdAL7Dr/45Kj3CVJXM3uxIjf5
 H9ONdmWkE6CIiYc6CaKnGZcfl7Zq2tGIpqfN9HnNtKCsQne1MyU04yhWKmTpKYTcc7lq
 rxbobpBWEvSzhLE6nnJvlfvtYHwq4v7G83uZpY+SzAFQgJAm4/ViVQyCCt9WkLD5pGFw
 /2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=OvM0qgHK5v0B7GW2gJQiIWPw9rx1fgBEXoHS+thUsHc=;
 fh=MlgadY60jqNTYKnaHqsq8n5z8RA6GoL4fe55ZuhhNX4=;
 b=f4+Qo1uQ1GP4+tf/PxTlXxOVSC0JXonOapC28w5zYWvZnAKn2BDwkLQ0yLcugng8Mv
 t8LIgfxCnEg6IUZYGMpWgfIbXlvU1pg/j0uEdK23osSq9qgE/Bmnx63dXGwk6lTlidh8
 Cgg5M7HxBqS3X5/Nkj9/uWyH/pVKwKtrr94MOns57/ub2KVAe1WJp33fLyKbEtEawVEL
 ulMLGuwXlCDMbUbu9RmJt4OPoDSkv9zaF78dEH4tXCuGnkslQTuqgxfG3ZVes8TXehl0
 tAh8NgotgRveqnZ3Qe+YS87xZv2ODq41z0tcXxmkSizHV4cMF+sYW8xzTLzYk9xU24B9
 5Tqg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177818; x=1793782618;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OvM0qgHK5v0B7GW2gJQiIWPw9rx1fgBEXoHS+thUsHc=;
 b=njBSWmvLObW/U1tOLSSyxeit8VZ1RIzxsxjJf3RxLxy7Oux7e3HpLaTZZpUzC4/T1I
 WIM2W4ncnkCiJqJo18KggMb5HoPRQ/5Dwd0TcbXXU6/L3g6COadXYjlPyYagl1PgU2iZ
 1htGAZXflPzv7rHAx8ez1uBTpvMLtAgCQ1Cdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177818; x=1793782618;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OvM0qgHK5v0B7GW2gJQiIWPw9rx1fgBEXoHS+thUsHc=;
 b=hwkuibTxsAqu98/A334R10UJ+MdQMjNUOX2eVEwlH9nqjR1k88Kz+nDCMWx5pbyNQc
 Xaf3Qr83/WlPBL9+1Cm2hQNTErrqneAqFVpjzbLuTsLc0BHlQOwQI1Pa9C0uDjmV69yv
 pZPrhf6Boi//Q2E4Ag/kDEXTPemVuCJRQ6lHieBoxVEzMRVxf0kTHYf30YTqN4EWjOit
 4Lq/cJQiGgx8MImvdtxuqNlJ+6uWgRfux1Je9mlSYKCyK5qZ+Zd5oJBJOC7vVdask9z4
 Xc/MMolpRpUVhFWZjVzOKNBLyKWkx7eiQe9Hrdx6Mx0s2VnU6obie+YSMgkOUuthSXyl
 l10Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKE/D+yfXfTNIjFM0CZx8OMVH3GRUvlZKNkuBA8VSKqUsLRidPGNNbzCg5jjR0UD0pqCMfThI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ55+plPGHBsSTnGEThz4f4lL1uWrXMgjgOYSP3LF6WCqf2vWHI
 YBeRUOa+KNS2r21PUCH/Hm8oWhehsS+GgTozF1b91IYywFB0FAht9r7lRwBum8hwpLPcplafqhN
 Hv4YCaAEvIIy9o29J/Jt414VSUpezzRYiSCHomtzg
X-Gm-Gg: AYBFou2klMX00tISCvlYzzwDnB6r/3P0RDvNpwYKC603JBjr20ZrxZZ+w466kZK2XB+
 njZvCjfhRytt78c4wteV0rU75Cga7ekwTUtaXof3ZMkrDqOjnZsAUcfgx4y/2M/yRUrpJidA3JR
 vnOHRYcjhwY7JWnVQo7TLF73bA9PCT+KE2j/xuPHsNNyhdOzbrTVoJg4TQXf3yBu+FRUtUAxjsL
 ybILCCjX4cmPrAqGLNTsDvovf/3NHU5u+c9USD4FrDBcrJFHr60xecfuxLgseqTsLXHmE/mSG0T
 YeyrjoHyETjq/tkAR0m4ZaqstGeOSm8Ak/tDnndbrXrFHCZ5nFLWOFKByyEg2L14XNvTMrLenEi
 T4TzxYEhqn/lA2t6NdV4A4zjIscwG707m+6c=
X-Received: by 2002:a17:90b:3e8b:b0:3ab:b39f:41ca with SMTP id
 98e67ed59e1d1-3ae5c8a5379mr468978a91.31.1793177817888; Wed, 28 Oct 2026
 01:56:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 08:56:53 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:45 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7a66f202-37b4-425c-9c12-9ccb10d68c2f@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <7a66f202-37b4-425c-9c12-9ccb10d68c2f@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 08:56:53 +0000
X-Gm-Features: AclHuK_rqWOQNRWYFfPRuRM5CFq7hcM7fxQ1JRRFsR9W_BS6ctrYNlLRRA8cf_c
Message-ID: <CAFLszThLoWn1OvNs5oUupDKg4pY0viZnHz9LpZsUTk8rNZSWhg@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] disk: part_efi: Check the header and entry sizes
 of a GPT
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:48, Ana Bobillo <anabobillo3@gmail.com> wrote:
> disk: part_efi: Check the header and entry sizes of a GPT
>
> validate_gpt_header() computes the CRC of a GPT header over header_size
> bytes, as the header gives it, and nothing checks the size of the
> partition entries before they are used:
>
> - the header is read into a buffer of one block, on the stack behind
>   part_get_info(), part_print_efi(), gpt_repair_headers() and the gpt
>   command, so a header_size larger than the block size makes the CRC
>   read past the end of that buffer
> - alloc_read_gpt_entries() allocates and reads
>   num_partition_entries * sizeof_partition_entry bytes, computed in 32
>   bits, but the entries are then used as an array of
>   num_partition_entries gpt_entry structures: with a smaller entry size,
>   or a product that wraps, part_get_gpt_pte() and part_print_efi() read
>   past the end of the allocation. On a 32-bit board, rounding a product
>   close to 4GiB up to whole blocks also wraps, to a tiny allocation that
>   the entries are then read into.
>
> As Linux does in is_gpt_valid(), refuse a header whose header_size is
> smaller than the header or larger than the block it is read from, one
> whose sizeof_partition_entry is not sizeof(gpt_entry), and one whose
> entry array is larger than 4MiB (KMALLOC_MAX_SIZE in Linux with 4KiB
> pages, 32768 entries). Larger entries are allowed by the UEFI
> specification, but U-Boot has never read them correctly, and Linux does
> not accept them either.
>
> The header size is checked before the CRC is computed over it. All the
> checks are in validate_gpt_header(), so they also apply to the header
> that is_valid_gpt_buf() checks when fastboot is sent a GPT. That path
> still takes partition_entry_lba from the header without checking it
> against the size of the download, which is left for a follow-up.
>
> Add a test that gives the primary header of a GPT on a blkmap device
> each of these sizes, with CRCs to match, and checks that it is refused
> and that the backup header is used instead.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  disk/part_efi.c     |  47 +++++++++++++--
>  test/lib/part_efi.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
