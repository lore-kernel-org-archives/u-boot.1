Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A3606A327
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eiXm7wCk;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tSWXrkKV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A88660660;
	Fri, 13 Nov 2026 15:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUvuT8AXgelh; Fri, 13 Nov 2026 15:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB0DF6062B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794582045;
	b=o+A0tJ23MOo1xYWPbFlVPZNeECM23/k5Pu3JwouaFINbzbSv7U+3/6ZkrxQ/n2NpRxDm
	 wvrNWP/yrqE94VJrCQmyhnzKlgBotSrl1jbcyL8ZYjhiGT3la2QfOjgIrVaKbkXyKu3lv
	 DH/dtvnujRRYVP48GAHLSXF9UfjLMrrNAA4uj4eABWx27tc1W9/CiG2laHqX7R0ki41Db
	 qCsvnJTq4QbXFLaEpIhNuRUxIN8mU9Jsg0slD7SRRcZWQnviZQGxC1dtWzvBS3YHbJzxK
	 yd6LJ2sV1lqp1bz6k0GEl1OdVkZcHALHX0THt9W6/v6WhmKdkdOL29o2d0IHw6MeiUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794582045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mGfZdof23MU1wmNdhmEMcyZsPQcY2g8obG0AIVyqg/Q=;
	b=RVzRx/dj2vUYR2fJnCszImeINceWHRfH5CSKlxJ3lmiDkFhr6iq7u4lAfajZTZ99th2h
	 urHLGZbFc3/3ey96tWtPl1ESVT78Kjlr0GzgfCYywBO3pgzfPh5WaSwgw/DHofv/1Tny/
	 W0ZkMDqAWpA0OIlbnahyCY1jD+ca9Ubr5cMFyxVT55yBGLdAU6lEvmuoujOD40RbNZluN
	 8vjaRakjXs4CwOPRiLdQnlv0RvL9bI1yafbR9enSuDOAdkVguU3XTSXTOHasnoKKdPRpB
	 IZ3/fN/UVS/p0VMhrSIcOXGlvUKVStQL+YgczgOzGvSTRpHfRIU1brvdqxtFmzpBCJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794582045;
	bh=mGfZdof23MU1wmNdhmEMcyZsPQcY2g8obG0AIVyqg/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eiXm7wCk7ZihpW7WUXf42tsG2pPmTPUPu0DJ0Hipr6xdIhfM0/7TelhS0xs9g2BZ1
	 zZn+6+OP7bteXpQ2OhX5RK0y0LDvYwaT+GIycY9YostNb0CYpnHUt4YaHREqt4BgmW
	 4aaDNTFFsVgO8L2Mutvb70UJ/bKzEwU2PpS5sSaxUCx/R4eckB4tEd1GPuAtSYzCY6
	 PP5h2k4igvxuCP3yhqoqYLIveW4jxT0qU7hzG58+4eSornnFERK1LsFvEIfBMhbTmS
	 lDYyGLUkG5AZ/MMhQm3vNNznalrMOZPMSXj/3SveOLuPVDvHmnEfX+EkOjNUPny9Da
	 2BKKXTLgvFrOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB0DF6062B;
	Fri, 13 Nov 2026 15:00:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EBC8B1790
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D167081565
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UTgKb_Cm6Tf for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:00:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B2C0814C7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tSWXrkKV
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B2C0814C7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:00:41 +0000 (UTC)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-675617e81f9so1090608d50.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794582040; x=1795186840;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mGfZdof23MU1wmNdhmEMcyZsPQcY2g8obG0AIVyqg/Q=;
 b=tSWXrkKVw5+xBf0JfW0sRm9sxJjUB4kUBWvVvjQ2KaJH7htR7f3PTMzF3vpN5l2iCF
 G2P63xsSYmLk/KKpSJMgIH4sHsq3vNwNBkypWliza+QaDL3QVawdRqxCiqtEH1oSP2y1
 sZYp5M3LfuVCmulI35kwxFbRYQateU5I+yc++yo4MvkrzsOQGFiJ7P1JqbU/fATgQq3g
 SvrlGayGDVjy6K0RJN3fhQ7J3tnttn5OCfAWIj41/FGj7MFuLEiZwp6iFfqqtQf/r52Z
 iNqtz1bbpT1kj0SmXJ3cehL9ct27si25cp9WRMYofOJM0TeMIu8cZ7qFbz9hlJVNe3Us
 Y1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794582040; x=1795186840;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mGfZdof23MU1wmNdhmEMcyZsPQcY2g8obG0AIVyqg/Q=;
 b=rZyFoDMNdThYPcjH26EKh4yySZ+ohzdtdEP0iIXZaS+FVtOFIOpA2XmIKahoqiqeq0
 nlRv3RDAKdKQRvz4KYuof+tLbPwi2/cjt7YH5401DI3G/SWNk5JJoPkkbJn+Ug69uG6I
 npt9C81M07bzSC00tAuOBEOnduQC1z7Oauj4Xy0crRUxlxWZrEW9HDHNn5yFYmVKtV8B
 NX+zhoP9Dw3EqFSida5HzO6h2jpi9P/S24tiIgA1HrvqiOp/oe7zNUq3VGxc44mhX7qq
 58eMxBc2YCMDwyuC1jxJqFiaq7I8wg7GXiypTi1KplzxjVyrFkxRzc2ikhMyFBKGJUD2
 xQxw==
X-Forwarded-Encrypted: i=1;
 AL+hErFoV5Ux/7bNuUzI5fqCxDX5UYdQ23vqRTz/sqGVyOvdA7aSPFNtOu7XXyKvGXtSlNq2Y4AXi5g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9HyXFpJqMY+NI6PMUom1AiUt7mPu0UPHm5MjJZe0PyOfWh3760
 9sO5dixL7rmkjpR4HwTwg+cXceMT2PZxJXdva7GjnNFPbc4cnUR/f4bu7F6L45nhaaKZhZEZE+z
 4uMTEM6jw4iB5zdxYokoeUkf+piCOLuDmK/mVhOHccw==
X-Gm-Gg: AYBFou0gtGhzR6PR+kd97n7oxUE/VLWyNou4umwhhmovyW+jCoixwpK3XaMs4NSmvXS
 s/Ehd4+DcY2wa+x50YDdpvddUtJw5k7bqX0txGYlOotuRTvBErva3Wy2m8l/byFkI9jqItQGTDm
 PhUra1jqtIWDCepIgsjQbo1FamtTYSYQ+/7jXDqPJNz0Qgs8tZQ/YQR6xeWyt0IGGznRQU/OyNM
 7jO8MrPuZ3xlkaq/2cHvPk8exAJ/busD6E8Ws4lgSFL4Kv/06qy7A/Nltj0/iB12mqEMnwV8ddV
 WyFW4CTH7uvIPnz/j8ZIdm5fu4HWWFq8EmkG3Nl0OQhd+T2A1KZWouQFBQD58N7VeZI5BDIBmpg
 5Ot0Vrwq1VOS9jXnJIy+b5+Khwq9B4gVUA0yqHqhfjWiz5rbKMz/sRMdHpXDSqCQKnWy0CK8RHI
 JB9C2TUkKTVhc1XTOdLEvdRYAgiptPajsqAItqus4CxySUuZhYM9Tiy5izI97xlQAWJydqyS7aq
 lpmSU/jbcHYJ7sIxx7ZxdDq3OSJaIQd2eOMpI4VthNIsQwPJYPWwvWEYerMSrAC7WMWVM2Z1T1V
 k3uvHJdJf39kbf3WtomDWwt/jmY7yDViUStG/oFPoJO+f4xrMXG/695jo5Rt/IdXV6pU40xY5lx
 Bm4TNaqiSzsl/H5q5joazJx4nwhcAdnlBJ5+2bYFQFNROovDiImNagPp7kDV2npwZnEk/34+4Tm
 i0YD8JK+e2DJ9Vq5TZx7HtxweOjRRuzo8NaaRVOd+Siv91bMEBGPVY/A==
X-Received: by 2002:a05:690e:1501:b0:67c:936:dcb8 with SMTP id
 956f58d0204a3-67d8975ada1mr1373331d50.90.1794582040192; Fri, 13 Nov 2026
 07:00:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112115438.1837663-1-me@ziyao.cc>
 <20261112115438.1837663-13-me@ziyao.cc>
In-Reply-To: <20261112115438.1837663-13-me@ziyao.cc>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Nov 2026 17:00:04 +0200
X-Gm-Features: AclHuK_-OKaAN22dQL7nfF689R00RAGuuIMP04lrntJJPtZNKZjY6coc14wWPiU
Message-ID: <CAC_iWj+OU4m1PipSN9xkWdMCpp5ALhfydG0fA_Cfm-BJ1-pcsQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/20] board_f: Add LoongArch path of mon_len
 calculation
To: Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org, 
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 13:59, Yao Zi <me@ziyao.cc> wrote:
>
> gd->mon_len is calculated in the same way as SH and RISC-V.
>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>
> New patch since v4, to ensure U-Boot correctly reserves its own space
> for relocation, even without SYS_MONITOR_BASE enabled through
> MTD_NOR_FLASH.
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 2f26b4644cae..22650d9d003c 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -292,7 +292,7 @@ static int setup_mon_len(void)
>         gd->mon_len = (ulong)_end - (ulong)_init;
>  #elif defined(CONFIG_NIOS2) || defined(CONFIG_XTENSA)
>         gd->mon_len = CONFIG_SYS_MONITOR_LEN;
> -#elif defined(CONFIG_SH) || defined(CONFIG_RISCV)
> +#elif defined(CONFIG_SH) || defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
>         gd->mon_len = (ulong)(__bss_end) - (ulong)(_start);
>  #elif defined(CONFIG_SYS_MONITOR_BASE)
>         /* TODO: use (ulong)__bss_end - (ulong)__text_start; ? */
> --
> 2.56.0
>
