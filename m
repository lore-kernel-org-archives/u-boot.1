Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE3606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rKVkBVyp;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=arngluH7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2F2A60767;
	Mon,  2 Nov 2026 08:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMGT6uEzjLxF; Mon,  2 Nov 2026 08:59:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2135860757
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793609953;
	b=kJixue5wkB221qCxhQKMExdSMaO6q+ENi7NhBMyOIc1Hdv1DEF507P7us4kIBpXHo7eb
	 ggZ9I0x4CcuA1FVtuhkflt0xox1je4NGb7N7vCCwaPyF7lTJczyakPMDGIw7X5bylcM+9
	 b9IpY0ReqmeiUQ4gyYUjAnOLeQ13vGmRhEwZRVdSFzIaxLewwIo3Unpv9MzZtMD/Y8C59
	 xmrrFOLIHb//0xDpDpvF3J9hUd0SSgEAhBHzIdhhsIGVNc++zd9WU7TYj6ODYvfDwBP86
	 AJ/hDIQuXkNllIy6RrIdUY9D0MVFRjCrip9aE597Qiu4TYDIuFyz2RaFNvKatxKFSWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793609953;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uVhohqeIoymmyG97ysmee4rZ/28gX26Cd7oPoviWuZc=;
	b=Ixq/L/NoQhjVkqCnED2+4xSaMkAirk5gt5kWHcbHp1OGl7JAOdCqrnIMuY159RijILhL
	 ccbTjZvXW7Y+/51n0JZLFIn3cB60GBiqhTJ+SI5lbKnDSwtfl7JtPnnxjvE3VDnQHv3pV
	 cT/y8Y2UNeIYfDPYuMFeFGom0WwCHPSzGfevYI+M4FC3qhXJZ4m1ZPBOSeALvaZ7Xfufg
	 n4YaydK73a17nEb9pznLUK44bmjt1Jc5wxE+c7PF8G+7/2atrhby7HRDyCQJn6O2iSdtR
	 A5KIP296LmpeZYpZngAmAp6N3bv1jgPAG7ThbfQ8zuNUVRu4wcth7hHYZmRZeWYr+dg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793609953;
	bh=uVhohqeIoymmyG97ysmee4rZ/28gX26Cd7oPoviWuZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKVkBVyp7WFPjSDOLsLkMBVQdnmFQ1q1kBXSNv7i9h7lWW1b8T708vKIRNKjtm3Lz
	 4FTqPPBKTHpXem40yxtW5R56LMqovj3F/cJDcE7EvMdrtQnKSZ41zjIG19znVFLPPb
	 zPGsZcXwahWW/p+Yb5/+2Ie3OaaRaqDhSqlVs71u499iSCJKc1uSq1kiL7RUmvQ/mh
	 6suFXn80DyDZcdC/TQPdErnhSXrmeQWOjkfzI5DAf2SSlCpWqxf18ABuISSqqTAUyc
	 xWiGSptpjM+G1z46uXMlOtv7sxeuiIImeWtDTpUdU6SWDvAaA+QS1orRN9LzHobbzr
	 lZr7uld4Oxc5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2135860757;
	Mon,  2 Nov 2026 08:59:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28A04356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E65980C2A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ngFgsZBR46B for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 08:59:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CED680BE9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793609951;
 b=jNCkLQ12CK0BvTpW6yVPld2T+F7hhtDPZ4EMI5XTLHj9s0eJ1rdxBO9W9yNv9ktB9Xkj
 3oRvFrxoJcTLKS6JbV59HPesqmcjaRn7NXmvy4+6gMdlfonNXhL/GHPlUOaih7lRXH7Pz
 fgnS0Txf+qen2frcV+wRvTwEzAjinf+iCew5McwAifVT/v19C0ig+IPQ1AIY181lG7J0p
 raTwc2M4hpzceXEJERnQy+Joee8juPq9W510KuCfr02l+q+t2ArfL7sEtEr273xz5X02s
 Z3fGZJHRneMLuoRCoE0aQB3uecOH2fHalHMRXSvDOjpst4ajhPDnUwJVa2fvQ3pIvEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793609951;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=uVhohqeIoymmyG97ysmee4rZ/28gX26Cd7oPoviWuZc=;
 b=klm5hkwPJ8L8RYjX5Lf4zAyV5Th5Ko+Dcs+rA+ueeCckaUKD3depTktXaUbLfmpxC3jC
 cjQ8gngsKepVga8BLdcoY8glag9Hvga/gJAB2fqac6LRzhpLW9IWyAtmmtfDoP3YmTwOs
 MlnKUkWiM73wFYR5N4FSjehzd1rAjEzeoO9tIUmS8JuPi1m1wq/hEsiA4coUzfHqXBCil
 o6ZYWQPVvPCKSn1FKkE6NL9TCzU+hzZr91R7lpz8igHBTAvJyXKJOG+z1rmplsZn1gX7M
 nWbUXvSWCGhxS8hd8fAi2SNJWDGuqPmYaW+4EkzuCIn9hThnoCX91IzXFK/NnCl5+Xw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=arngluH7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=arngluH7
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CED680BE9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:59:10 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so1273676b3a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 00:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793609950; x=1794214750;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uVhohqeIoymmyG97ysmee4rZ/28gX26Cd7oPoviWuZc=;
 b=arngluH7C/4NXKU3nPnynxn7HOgW2kBMrgt55fk94qLREEtz/ObsKpZ+nBZBezN7GR
 YTuL4hbIn1pKd5Sx4FUUdk5sq7ahUE6fJ7jNUlMwoz71VwugafsTGAPa37N8lS1Fht3Y
 8msd2rYCA8kx6kJu9iyesBJKqnlmGo0ljoz38UOfGuD7+ggVYF+Hpsi6wjuWxc8HBIWM
 +gc43e2dLsRJOv/jJgaNcjqWCAEU8swbbvuiykVGPKlnqFZ0SpfIo4QA9UZgr+NWRglU
 mbCxLG5Y4Nnnbfe4d+RZtD1LFgThtgwgAd8mYmdqdrzB3UNz5zCUPtOXkrnEIBp//DFf
 MN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793609950; x=1794214750;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uVhohqeIoymmyG97ysmee4rZ/28gX26Cd7oPoviWuZc=;
 b=frnCyDofj/dya3lDJ/xAIQ5SUePS1IdYNML2oiIY1DoB7qzr9ScvpqWRfgMF0oBlRT
 xEykwavKXtgD/gWoToJq14iJ+yZwh42TTqE7sMeYjlgpGLFzmF3Q95+mUgYzfaLvGIVC
 jJDXOWwfLw5GekzOmm61YjjTJURBhiP5+HjOzgVG7XpJDODAQysge8DLJaqDIyhD2vsl
 Gf3mrIRGxmgvVOzQ5g178Dt+qgwO7XB+P57IIpqcf3NAPmPIXzh2S5flKDhTymgOFqKu
 Z92aoD0HkNOPKepyLEKSTwN7OXCcAuDT98rpMj+BVfrzlNUyaakqxSXlqQKyKHDVk32s
 JM2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXaEsxWIRaCLjfnTxn6q1lLU/TmJyLF8A47bTajVIZnUJv9BTtZrVAABReeLmFI3ROFjRGL5I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9qbD1fgbBStveT9tgYxHDLdfMO6i/zQyReMgeuTC+DjHfWCh3v
 JX8E1kh5mI66/d9A7xwuxhb0pap/GAyxuLe8It0cmmgZJgHsIcHBQXRYDnaRGWutGxU7J0GvFUB
 wSkUP/LKnfg==
X-Gm-Gg: AYBFou19KcZCUFvYZPSji84YNq4Zeu3jRzRMAlSGGRCaHM6E5Fzm6mXkCgxlUhpZ+7Y
 ElXQ/Y0mOsjr3K+UHQyyfUcs+jxSQMefQ6Cl66MnCepoHswzC7WduHnkk1ed0QRVjAtAEZgrYJP
 FsdyLFP59qzjWd8k379zCs7FY4iux5JW/wmv+XL9MfMZruG52pQtvK6+/wjVRW0VWuDsWvkz6b8
 ZtlBwBhSUp/8iMqsfuZsS25z8Yc79djuTTiwx7vGa+9SAwM8VI3ZNY9zmmNBDN1Bv7jFFU06wTb
 GKm67wHed+NWA48T2/2uv+UjojtRLl1cHEmC3idkMZa3kkWUozV2HlLt6kWyZ3geKR6GS/2fCqn
 C3p5YI22O8+4te81OYkux1c+q9is7orhvRjOow0EOUIu9ONlcfCWaIiuscYaaUK4SRhF+uBXsTZ
 qaqMhb7wSuVhuL0zuC1ykHDf/a8CIZgbEqrfLepBCcR3ssn7s64L8GbK1CpnA8xVFsj5usjFkMA
 BHARcCE+cCw+VijQdIIinen+kZHapvh28+hV6xqDo0SBKnX8+VpttlpqZweCsHp0GDpDlSmVaxv
 KmDG4CwUmgvEMk1873at5nC7ZyTRzgx26XyNJNOyi1VQ
X-Received: by 2002:a05:6a00:22cc:b0:8a0:550f:bb43 with SMTP id
 d2e1a72fcca58-8a83289e6c3mr7521348b3a.34.1793609950047; 
 Mon, 02 Nov 2026 00:59:10 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aada9ae39esm1731714b3a.52.2026.11.02.00.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:59:09 -0800 (PST)
Date: Mon, 2 Nov 2026 16:59:07 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Gustavo Henrique Nihei <gustavo.nihei@espressif.com>
Cc: Yao Zi <me@ziyao.cc>, Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org,
 Tim Ouyang <tim609@andestech.com>, Tom Rini <trini@konsulko.com>,
 Anton Maklakov <anton@espressif.com>
Subject: Re: [PATCH] riscv: restore ILP32 size types on RV32
Message-ID: <auhQ2_oTRdpf39KN@lliang-1876.localdomain>
References: <20260928-for-upstream-riscv-rv32-posix-types-v1-1-6f8a37501ccc@espressif.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-for-upstream-riscv-rv32-posix-types-v1-1-6f8a37501ccc@espressif.com>
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

On Mon, Sep 28, 2026 at 12:14:26PM -0300, Gustavo Henrique Nihei wrote:
> From: Anton Maklakov <anton@espressif.com>
> 
> commit b2c860c6dc50 ("riscv: fix use of incorrectly sized variables")
> widened __kernel_size_t, __kernel_ssize_t and __kernel_ptrdiff_t to
> long for every RISC-V build. On RV64 that matches the LP64 ABI. On
> RV32 it does not: the ILP32 psABI and GCC's __SIZE_TYPE__ and
> __PTRDIFF_TYPE__ use unsigned int and int, as does the kernel uapi
> header.
> 
> The types are the same width, so the mismatch stays hidden until a
> header typedefs ptrdiff_t as int without defining _PTRDIFF_T. U-Boot
> then redefines it as long and the build fails.
> 
> On RV32, this fails before the change and passes after it:
> 
> 	_Static_assert(__builtin_types_compatible_p(ptrdiff_t,
> 			__PTRDIFF_TYPE__), "ptrdiff_t");
> 
> Key the typedefs on CONFIG_ARCH_RV64I, as asm/types.h already does for
> BITS_PER_LONG. GCC and Clang define __GNUC__ and take the
> __SIZE_TYPE__ branch, so the size_t fallback changes nothing for them.
> 
> Fixes: b2c860c6dc50 ("riscv: fix use of incorrectly sized variables")
> Signed-off-by: Anton Maklakov <anton@espressif.com>
> Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Gustavo Henrique Nihei <gustavo.nihei@espressif.com>
> ---
>  arch/riscv/include/asm/posix_types.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
