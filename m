Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1818606A323
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g+SrR2hy;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fIoxG741
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A9566075A;
	Tue, 27 Oct 2026 11:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5iiwwJJnb-Cu; Tue, 27 Oct 2026 11:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69AA360748
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101675;
	b=PkpheXUfl3mtFtWjoP4SK7VULogFcalBx1bLylmFVw9fnu/n9N/IYincVzz6DgxtNVJm
	 4C9iTWpI/u+TusqZCP2WldbbANAcObCCM1lzjaV6400Xb5ymWSIM5jJLoOH7yOTZrCk4c
	 YAY21aW49A/S9IJ+wxYKMCCVytPekB9Jq87ooI5f2rV4gpsqwCtfzX3RUPJK54wlPX9w1
	 0uYmYPfSbWGesDkut9YT6+5UcuAJD6i0D68ObZHeBgemibiV9O77LVgOyZxyeN+i2tdE+
	 gIpchlHVRVL6k+ZKgBxDbEqmaxi28qelKMhP1yFp0ggfY/xNsw/qewv4O1wZp34/alw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793101675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uYNyBQPZZNhX9bMWWeYhAXn2hUMBFRBFv36OG1vhn6Q=;
	b=SQAEsbVJ/Z7YiqhuVTON3Z1U+ITK0Ylrg/Yq/HQMnxInBrEZKnkb6GQ+5RBcKaPkK2g4
	 6FUH7vfS5XG0veDAlBuuJd1soToNzYEpeW6AnRPazUwxeLN8KMNCfp0K/LYpZhyCJsZkt
	 4s/k6tY5Y7a9OpXAocLd3P8IYXu6MVh/meEOoqM8eAMV0ZxKaeAbUblKhM/1JeNYkAzW3
	 i93JP31gD8d/QEmHdaOmlx6ilnwEHFXMs5qPqDyRlvgsdZTLDrToReUzvEN+eHX8rmMzQ
	 D8EVOgYXkMPwtfCC4EUYMFDujVd2xOkhkRThwMDf82DQKEv7Wfzc0P0cqxL0DOlh3lQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fIoxG741;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793101675;
	bh=uYNyBQPZZNhX9bMWWeYhAXn2hUMBFRBFv36OG1vhn6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+SrR2hyAisC7oaJMTLjdbxw6VL94enLeS5MWRr+Vfng/VK1qpek8Al+1UeHdYmZB
	 SEyK1qbxsehso6TLzj0ALJwQmSodKivUBMVsi1AelARIzQ+fcRL5RXtPGzO61uQ19i
	 G0P9ojF3vfVEB9hI3dH2mWVBRA0zoN49DRYcaSiQi0+bRUx1PKtLzqxPR7GDGOdm2W
	 s9mFAm75xB/vXHh6PTDeo8ojcRszlUaQsdaO1Cd3718UhEU+hRTkNcZT5TJn7yn+81
	 oi2E9rtMZgunnwaQAsuVAY+PFTjZGxYN0SPyKd38mhJSOgcOyuMUkK27fXNMkqk3IC
	 4O640Q8a/nBpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69AA360748;
	Tue, 27 Oct 2026 11:47:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B458A1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5F6F60748
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YvuSX7Tvk6zD for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 11:47:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A836560711
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101673;
 b=BgWIHNjOzRElbKQitn3Z21QddsWCLfyNK3iJMLYSBm464xZ0Kj+7ZeqJjaWPb0W84hT8
 Nux0bxnfd2UMLQMYLCOq2P2GeQj19z40v/nR400djcrpPhd7JjhzIQm1R5mS7Mvr7694Z
 Iq+2OEtRxcKJb6DcEg7u+nbhYSxJ6qBnRSObAIQywsXzC+YxQcxnSBRY7nEAbaAbdsL9a
 W+wV+SS7YzDBHngpqnmZOiJ/UMsf3FTcWSIdMSZ/0vsuVfR875dc/TJfc2Zf3NspH2jSj
 Ywx8EYbTOiePmrj2PGTNRDRt3IEpQuQtxgBZ6RS/wh7aVhyGzeOmsRFWp1cZ83QoDMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793101673;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=uYNyBQPZZNhX9bMWWeYhAXn2hUMBFRBFv36OG1vhn6Q=;
 b=ZDk3Ye3JqElYadyUB0rS5ixKyKCM2SI4LHpt3BuNoI0ix4GD7DA+7uLxLXvLDo+1meHW
 alzqULXefITHSyEZedAa1HEOGVIib8I+1cUYcccZ1dmXzEoDziTLBs2/1AZ41xEGM6K4Z
 8ii09bpCPVcVDDiV0ZRhMVC1lOlPG8WKgMVvkNnXF/s6iTUE/i6ivDBlD5s5XpfvD34KH
 0Oo1ZuZI5Hql12NTWsQ36M3oZo5AiH0SDCBx9z1X0YgiQMr627uFDY0zZ1TON3NvFBMc4
 lJxl8m3NPC4uTYcoFK5Oah8Cix5McWjtrWGi5IIMgz0gJpZmJiqXgNdpKKsk0k408bQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fIoxG741; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fIoxG741
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A836560711
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:47:52 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b06c0794cfso34273247b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 04:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793101671; cv=none;
 d=google.com; s=arc-20260327;
 b=pyoYqKBLt6EU23544Q9JzI5YuRS8kYGZWz5NMUco7rXZzxeCUgIvqwmLbJFf/5dYhi
 WMnDDJ7cjfm4QahukAAyFmnjXJDwsSVYNwZNxMJNY1x27mm25OzO90U9HwEtpW7nirRq
 JRnms3ejOfjnQ100OdiAHSBke1viKnuZLzSVVVizUwX+hQkLKYNuZ1oF9xFgocgZngUj
 CubYir65CbNVGFCR0+Du97fDYBxWlmKtS8Odj9XiAR/lYDElKVPdcou1zT5gBYWpy4gt
 fY9jutP+9rB7klKLD0+qLGP+VwEOoUzX/rRA98yioMeq9cXQ/cuS+7awl4g5O97btplo
 YTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uYNyBQPZZNhX9bMWWeYhAXn2hUMBFRBFv36OG1vhn6Q=;
 fh=dBPtYC1TZ/qisQKccqrPk+ZU1k6U81Ut+AAudAfs85g=;
 b=Yo6DYDOetkhLUE4/HR9TC14F+x6rfzs+AZNYhakKpNRwXKC9/u3Yb6R61W/c1VPYko
 SDa6Z83T3SQmARHBuyVyB+apD2jgIctHY80Fy8WD2Us5RIJ5m+wFUjzYInuZh/5zPepw
 s1HRPnuBUhiAakLb9DgYrJe5lriLuRsApLIBo2LHSc+RYgxIYtRQT8DrpU3UZQvM0+hb
 EtnVpjSpX1aDT3MgUVTL5uNWb6bnVmZousmePw6kRZv1Vk1t12MO9lfZgBbJ9F0ILaf9
 TjZznJQYSHmyZvAb5FdSn/Wou4/AykVDGqI04fylxQtlt+CbaggRBTYH43Smj2bx4blg
 HZZA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793101671; x=1793706471;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uYNyBQPZZNhX9bMWWeYhAXn2hUMBFRBFv36OG1vhn6Q=;
 b=fIoxG741dWH37M/J1JPdK+9antYJCAUNj4GT2e9ReRjBOCpupQ8I/b8IF/xNy3DKUX
 3DeEB4fURvD0/NRkMNIobSCKD+cMCWwBsQuVEE+S1QbUpt242Ryeuz9jvgDvgadIKiwx
 pm56SExL0n4f0bTqEpPkj4uKWeZ0OIKWS0JhEfnaaTizesWNljcgs5t++oWMHSoavdVj
 eRr1hP6xdj1gCpNQQ5ncmoLhJVlju4lq5UVcaoPk0VVYZ4zXu6a+Atsi2GW2PM77/JWE
 6k8fYwwUKUijkwQ+D6yaTwgkikglJG/yjLfgO+u3ZcjYjuY6Isdj3Gzl7LA/jLsSpwWd
 +BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101671; x=1793706471;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uYNyBQPZZNhX9bMWWeYhAXn2hUMBFRBFv36OG1vhn6Q=;
 b=UQi22xKslY5oStwkLFBSWNh5vM+Yd4hAxlq/hyLA7cN7HGFy9LjpaveofqirzDVarl
 H1L9SAiEENd+zHxgE6bCsRewZ0lHEZfm0XEJNHGW+xWnWnDfYTCjkkCf/O8xuXGNf98X
 dISNqqHUSCeEo10so664a28pGJ5Me6Pgj6YR/C76rFBifGlu/TUsPGx4bJY7DFzeLmqe
 aecXuhSNuzLXb7RQUZmd/n6CHg3jIPqPo2WGz+7gjkjQqmWtBu/OYv4sXq2ySV0wmq+N
 RZk5MTEBpEFbldCT2v2kb+E4GqWB5LAvtgQheq5n2HE/wRFdv4uj1H0PcbL3sY6KKmmp
 IT8g==
X-Gm-Message-State: AFq9FYICVz/g0YRY/6Dx5iB3IzcjnbvbzqkydvOVO6DVuBiXDexplY0C
 dqsRTOl9WquIkT9Tp/lXmyqyE2xvPnX5cij20UY/c2/MaETguheeZHahnV/nq2ICAmgfVrAXXi7
 KWsWfjd/wX5h7/3n9ywgsTYuKDLw+zwZcStsCjtUZNw==
X-Gm-Gg: AYBFou3aN25biyLle2w31sxvce1YfUPftUqHOKjt4B3yAUVb1Y//5gGjxxvZ05n+cRN
 LwJLSlNsgZZUUW+7Mx6mnRJ47Obt4UQ4p7bG24L3TmGAFTkUmrrHtQeOTqKmg05QLheHAJynanh
 uDEZj7KiDOI66MpOHJNDguvZb/DAhKS+QK7wcJPZI5EK0QeGcvzuvkbdFvDjcZsigwnnd0lwMp4
 i/0Xt8JmYyt1gKAs2/oaeGZ53Mo1RpaI4j/R1vekD7eX8d88fQOoRS278DD2X2VKvnUYH2bfe3f
 QeNoGs2h8wDQAs54wt8JPJwlXah+rtLSaRWPp/IJAmohn4XIXpXDt/Qgt+5rP0U3eQkGtQ0JWWf
 uXd5LaRVW3UQm32EmF298I4EzktkoMqGI86f1ZX0/K2j439D3xpKqNqkpKSo8tgvQIh86XyyTiY
 C/1k7GUVOf6yGZ4KgHvMFN/+iwz8sobdwTY9zOUGrA2nvT2eofOBV20c/fh8TeHqvSSmZDLjult
 XvKg5Ix9hCV4Tz+/drb7pc7QpQWjeCh00jenZYqQT64UEKtqPVtpkCcb/zm6kHnIDnQTxNBgqYf
 fX5l7NgPamd+NEwZxh3DzPAVNcgs9UafvUG/tgGPpJpPGhWBBQf55VJfWoZh7nGbSenFGjwpmCx
 RWB9DMW64+W0QgDK6bo22NiRECU+CUybSFsBmH5mE6Y3lCOvmbhVJsyWHmus/SccV72q6cgpXG0
 fY4pruIn8/lUKynMwbSQUA0UXHaHTuPiTckTzBEKsFTIzwqjit5gaEOovNmg==
X-Received: by 2002:a05:690c:c4e9:b0:8b0:a30a:7f25 with SMTP id
 00721157ae682-8b166b8ea33mr71993857b3.12.1793101670699; Tue, 27 Oct 2026
 04:47:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
 <ee4b6c97e1063c2836397c6025003920bcf25e7f.1792001844.git.harsimransingh.tungal@arm.com>
In-Reply-To: <ee4b6c97e1063c2836397c6025003920bcf25e7f.1792001844.git.harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Oct 2026 13:47:14 +0200
X-Gm-Features: AclHuK_V1jMX9eUpyM5b1iSvo_om0yvTcKt93jS3hH5XLy80Rr5S9rBaiM7VZYg
Message-ID: <CAC_iWj+Os=yp9Y=oNf4n0RKCkLd23ahR-tOB4pc4hkr4j_WVYQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/22] charset: mark u16_strsize() as __efi_runtime
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 at 21:23, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Mark u16_strsize() as __efi_runtime so it can be called from the EFI
> runtime variable paths added for FF-A/MM communication after
> ExitBootServices().

This commit needs to move earlier in the chain, before you swap any of
the runtime function assignments otherwise linux will crash during
boot.

Cheers
/Ilias
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> ---
> Changelog:
> ===============
>
> v2:
>
> Simon:
>
> - Split the `u16_strsize()` runtime annotation to a separate patch
> ---
>  lib/charset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/charset.c b/lib/charset.c
> index 182c92a50c4..738ad1352de 100644
> --- a/lib/charset.c
> +++ b/lib/charset.c
> @@ -407,7 +407,7 @@ size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
>         return i;
>  }
>
> -size_t u16_strsize(const void *in)
> +size_t __efi_runtime u16_strsize(const void *in)
>  {
>         return (u16_strlen(in) + 1) * sizeof(u16);
>  }
> --
> 2.43.0
>
