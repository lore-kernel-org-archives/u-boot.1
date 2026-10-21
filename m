Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2F606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G2ziyIDo;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f7tGno6B
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C4A9607F6;
	Wed, 21 Oct 2026 12:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lqtHiVIcthi4; Wed, 21 Oct 2026 12:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F7CB60816
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586605;
	b=TLvQZKs9UZwxxXQDfOBBXiaMQFi5f/HyENFlikc55Lo/K99WEeXJqCbFYXUJqS6Glom2
	 TOOHGxlip6kCtzRU4VWjcbKCUr6sDnoj0xyfIBWdNnzLw4pfMk9VeES6LZ5g1NOE1F2C6
	 PJ4GlpmyndKyuV+5xt9LeNPDUaXqzsU8gwRSn0AvCVzYSi3bXxagqVNEGkrVVT8DLNI/W
	 NUOhWnK4nwXT9Dx6Hy8iMcdQR5ruP6BfV4W0u/E9Qzz0M03zxNT23S5a4s5s0GfZd8+Ef
	 UPiL/DUS0ZNY7sK4QEIof+aVe+sHIzss0deqP9duId56Dp6Xf851aKwbEhtSA8BE5bQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7ZC6P5fC1pVDnQHyGsXYkRvFDm49hn2lTcAUhknA5No=;
	b=McXy6qj4JUbgWNZKkX9aedZMrt9VB2V2S4Dsxv5XYfZ6S/QhCKB10GxjwLLyp9SrrQGd
	 Ibkcq+SAg8O8TUuhbdlw6KGiNvt8ybdJgT5vNw2PO1YWLbfvtYJerPRvi8yKFetifzfoR
	 E2nEKiNaMGOIxZwz21Nk4pfTQeb6jcCuHUcAvuj1Znl2JZUL0FMhEtfS0x49f7EAPDrmO
	 TyiTKkdA9DoUj6mp0BViIT9te46luqQ2fVLGRQzM/ivoHehYqchsdHeIcddhAmRQDJMDH
	 AWY0Eim4qPEX7tTcxCtrpHAnSCBUICUeZDmPMLK8JK0BA6mWJBzk4rWWlYqecSlO3ZQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586605;
	bh=7ZC6P5fC1pVDnQHyGsXYkRvFDm49hn2lTcAUhknA5No=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2ziyIDoKFppGAq1SmuHmNNCJrsWwHPKU83Qrx0KolWOKu+JTrTuvDWStBz40tr1J
	 vENg+NxSAHe5wyB5v1vFz1NLQ/+ViOvz4A7Sq3UrlTK//kOMMjRKHfbGBeDzpz8eco
	 cmdXyH5raX8brNIS8A9PjS9zB6RLbAHWCKQ2IMqrKJzR3ukwnIai6aNuZv/uf/M0wG
	 imvCXKrjrW3Rerj0oBptRPLWYbjr/cF0LftIHVQq9L8vBlm2Is1FlKRAL/ZLNq9O8O
	 4beryzQjLLd7H1Wo4GRuccTutSMrZWubLL/49IOks7tsRJpuTG5WsSC/ZCblMMwGOD
	 QTWjlP3rK0spg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F7CB60816;
	Wed, 21 Oct 2026 12:43:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CE32E23A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3C4240403
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:43:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-fKQMWTm7cQ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:43:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5E61C40424
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586600;
 b=dyBZPx8sk44ORCxMehid119nyZEXuffr31rSU+qRY96pM8CivOl8f5ZHavWpVUjb1roC
 cXncSYzEP85/Q0Q+wgZVCpv3siH2sdrcNe7cyj1HSFsD3lZFr7lI5dMwEQCF4o90quaMN
 YbGLCy+XP6LCnHTtDwALgZOxUop8+gsaAbZ24pf9Fmt9mvG1BtAu81r3n8BwzKQ22428A
 9xhsb0LLtmbL9hI72Ii9TIMV4VNz/+N/WMOb4V66TvNI/SuJzqZKzxJti5G3lDwiUwW/C
 n7QmLFs5JSSKMZBwe3aE+TC4WFOWOh7kPDomsPBy/P8wB+SyTDKUXCHOF92lZojogUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792586600;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=7ZC6P5fC1pVDnQHyGsXYkRvFDm49hn2lTcAUhknA5No=;
 b=UHz1f9sD20DXT2bGZU/vAboWTGQPOkXgXdlHMtSCh17CMsVeNc5ZBE5h4pG2Lyf/PB9O
 Us3ThEVdr3o8i4jt7zmw5JDeIUZxA+aY/R5Pp1pgGKBa5XWK+X6l0s9mv2IQ1B/+hzEbw
 uVIab0Cx7NdBDJhdQtaaaGuj9JgBlGOsPWpn2aVjjyeJ9IngdDi2YMQ8tUVrZDDh94Hs/
 SKX8gpFEx8JQ/VCz7PrPy5/ij6knRphwl7bg8gjhOxSi9u6RopDdnmRE+acQgTx48iNXj
 mDMc6Q1Rf1YsKSButrFQ9MFaSRDlONtNtoKFpDyL33WF3nRH46VPz/QdGQnLyp304cQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f7tGno6B; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f7tGno6B
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E61C40424
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:43:19 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso1475107a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792586598; cv=none;
 d=google.com; s=arc-20260327;
 b=Gk32l9sgYWVLtksS8Lk4HxWlz9qfeq4afI3CMyr2oS0j66XHb4Se6Owp8lVcS3FBDa
 SMd+zpgGOEE40xAQJ8lfgVRsOtbBSz1BBktfegOOpr6ilvD+fPSLUTc8eongHhpLwxFr
 hzCNZaMoKujRa3K3qanNx4iMXSeau+1exQRQ03A8H7MZ8XS1bMyhkd48BxZPLZTQS+Ew
 vCowhpjVq6L9L66+qp+8I/hBExeD+G0QNLA4LxrvIKGtdhdoPZopY0qf1KgJ21zYqioW
 0YX5Y9cAHfh+FID4uGrNOaoY8KB+rY7zpHLn2GQk14CL6N/ALQcbQtSSI6gNFuiqcmxu
 UeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=7ZC6P5fC1pVDnQHyGsXYkRvFDm49hn2lTcAUhknA5No=;
 fh=dZ0tJMEGsIVFUzoIG+XzQP0n93LR20+4J2Xk227cWpM=;
 b=G+QN2Ps8GReziQ40T6F4oFKHalvlRk1B7uszD2s2/J9ZEzjeE4LeVM8xlmsxRZL7nY
 9MyrmlPcCONw0u1mLGLi2bPzFrwOZz1H4decJPQspp7IqeYZzRU3/BM27xWraVpmfVn7
 HmeasKXJFpuBZmt+4NHAjnBYn2l+1+hgblxmg0ioRYLPEBnVllS6/kOksOmnAA3iGESM
 /eX/HwsQJCp4Y4lC/0EaD3oAx0vsAAqEn42BuyFFrOon8UT5PQw2McJVYuhDl1yT9iIe
 /GMbBPXp5aH4JDIZmqmOU57cAMxRiAJmyD/h3QuzJMyXup5vLZ23SxoQksjcrgwND8Wt
 GM1Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792586598; x=1793191398;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7ZC6P5fC1pVDnQHyGsXYkRvFDm49hn2lTcAUhknA5No=;
 b=f7tGno6BmeA1bdqMtUkXD6nidV5/hPqxJFDBpZlg0ml0QkuL3O1/WuC3NF35cLhgaT
 4SXNRVqdNNG2hx4mHif3iLu+OS1kEP8fVSujv203oFV9Iow79zw2T9K5v1Qnvh5lxqDE
 TFFQRYs6m1R85xYZ17YRg7PJmGqf2/sfLC/4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792586598; x=1793191398;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7ZC6P5fC1pVDnQHyGsXYkRvFDm49hn2lTcAUhknA5No=;
 b=slbmIgDmhhtG49QrsIkSu//+LJc9M6wMvAREtEqTKzF81WZCjmOdcky/h9xtCaxf5b
 63G3gMi7wJaN2deFP9xKQB6AygXvj+BPoNHrKrhUCVwyvlY0xgbS4pZ8JYxXWH+vXMb3
 HRS7zDMSKzzgvCe6LZ5e7H+YL96+tYfji824vCh3VMf1E2H7iORYONV8OwmgVihKrcAU
 Ur51AmBfVkxZF46apFbdfevkfTDcHMZruJnMvmzZVOr29ON2aFZvrPkiK33ShwjfGHhW
 wN0NGeRLIL6+o1TuHl1bYUB9XrcFnCqaLjlijZWdJR+7DMx0crwhY9PSE+htAVOvxxon
 4Guw==
X-Gm-Message-State: AFq9FYIAvgA0GTtxoBff6eZkbBD5c1X+xRotpl3/p9rcrM+vTQ4eBtI0
 pNS5T7w5v5WoVtHJwHqNQwk6XnNg/crD2+5P5P/K+RHkh/ZnqqXLqidwNG+Xb3js5gAAfCeDuhx
 wgDTJBJ2sjGCMEoY7Lvgki0NmiG8bxf02fxeC2TXCHRSWwpowt6p1Zg==
X-Gm-Gg: AYBFou1fBhR4JT0WG9TGWCOo+GN2j9IOgW11LVFDBXZZuzWQC/tm07dS4i/hATR8Tap
 wqZrnY2iUYM/T9EUhmUlVSUEIX69dJh1YKHZLC7unCsO2TrjtvOC8X/NTap0NkpoRy5EoJvyUA3
 l8oSjmd2+nwmX+6l/Au8nfuaoin9EBeOAi9M2q88hTO61adHvgZF4GKlcmuCCNd9BA/2Rze0SJy
 5r2UhK83y1qQGC3wFr43Ex+YT+ylGTC/GlpLLzdu96o+MK5ATWCJsvQqkr8ce18POBQhqThQSWL
 4EoX9hgKZo14ts0q6kWqSAcveW4x0L6iVqtBY4+l47Dse6Mcl64BEAqDPaq1E2qlKwaeqHAa/FJ
 w8ikh2nNwugE3QoCR3GsHejpr1pvgE0323jeZ0RS5T/uqREGY64dc8Om8
X-Received: by 2002:a05:6402:513:b0:6b3:b716:e99e with SMTP id
 4fb4d7f45d1cf-6b3e6c04dadmr2512612a12.16.1792586597780; Wed, 21 Oct 2026
 05:43:17 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 12:43:16 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 12:43:09 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 12:43:16 +0000
X-Gm-Features: AclHuK_mpVAnR7UDK_PAQBaKoT6-427IEoOdM5qgxlWenwrHjG9b6OkHljg_OFM
Message-ID: <CAFLszTiJnwq2M+LxQ-Mp3-2hwQQ1xegni7fydb2rdVHVxas11g@mail.gmail.com>
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
To: suraj.hanumantkakade@amd.com
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Suraj,

On 2026-08-24T04:47:18, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:
> scripts: pass dtc cpp flags via a GCC response file
>
> cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> path) in the HOSTCC command. With a long $(srctree) that command is
> too large for /bin/sh -c and Make fails with "Argument list too
> long" while building a .dtb.
>
> Write the flags to a per-target .dtc.flags.tmp file and pass @file to
> HOSTCC/CPP so the shell command stays short.
>
> This change requires GNU Make >= 4.0, since $(file ...) is not
> supported by Make 3.x.
>
> Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with CONFIG_OF_UPSTREAM")
> Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
>  scripts/Makefile.lib | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> @@ -448,7 +448,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> -	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> +	$(file >$(dtc-flags-tmp),$(dtc_cpp_flags) -I$(obj)) \
> +	$(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \

One thing I'd like to check: the .dtb and .dtbo rules use
if_changed_dep, which compares the expanded cmd_dtb / cmd_dtco with
the command saved in the .cmd file. Since $(file ...) expands to
nothing, the saved command now has only '@.../.foo.dtb.dtc.flags.tmp'
and none of the flags. So if dtc_cpp_flags changes (a new -I path, a
-D define, a different DTS_CPPFLAGS), the .dtb is not rebuilt and you
get a stale devicetree. Please can you make sure the flags still count
towards the command check, e.g. by writing the response file only when
its contents change and making it a prerequisite, or by adding the
flags to the saved command some other way?

Also, cmd-check expands cmd_$1 every time make looks at the target, so
the flags file is rewritten on every build, even when there is nothing
to do.

> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> @@ -448,7 +448,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> +	$(file >$(dtc-flags-tmp),$(dtc_cpp_flags) -I$(obj)) \

cmd_dtc_diff (used with DEVICE_TREE_DEBUG) still puts $(dtc_cpp_flags)
-I$(obj) directly on the HOSTCC command line, and it is part of
cmd_dtc, so the 'Argument list too long' failure still happens there.
Please can you convert it too? It can reuse the same response file.

I'd also be interested to know what sort of srctree you are using
which overflows the limit. What is the limit?

Regards,
Simon
