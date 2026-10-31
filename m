Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DD606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IlY2tCEr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuWNmc1p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B983F80E42;
	Sat, 31 Oct 2026 16:45:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4Iy2VfWNyDR; Sat, 31 Oct 2026 16:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A39C380DE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793465130;
	b=SpvYGk5oy3XgEH6lo2O4HR+peGaOO0YI0KaYLyprqpLBbsw0U5WDLPluGL+M97VeKkRL
	 NQtTXrsKEG8fHmvuMXzM3VG/qjzC7ojhXcWqKaQX8XF2DdIBHPGMi3wZtLGPeSHCuXDtQ
	 bc7TGTB8k0BsuV855Gb4ESMoteXwxtuKucg0pbdvgPPFzsLZzIwbPR2Mi5QrTyQc6o1KS
	 rSX34S3mWPORlP2vPyvVcqOxHplWNeOCtHzB/+eLP89i71AWtKGy1k7tyeqnhvpEqjhDm
	 jdu9cTgkoDUIdMEuSeHY267/Cvh/vFX2S2Q2xhXYX2PYkaM2rpqkLNVNLlWBHpVjA1Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793465130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7XjhtRytnZTJRH6XCvKR1fagoTuLbe/QAz4NAE5CGgA=;
	b=Jz+iEg0yXstflsXDgsb8x5rVGizDm4SnVjIB29YguuorRBCJs5nFqdSBq0lEOYe8fNyO
	 575/DaOVOoZ+2iCSEW3EjaPBWvxLylh7kCan0DuNEMhHq4M+Fzch8oeJK7iB48TApx9hf
	 ffCFYh91/mR0/jw/+oip5Cn5TnMnKnH02UySAZ5AgAp/o3wyBCJJjsLxYPpjlBwjgQGHw
	 qVmXB14DkNEX4Trd25zi0jkXnvTc1B82FIUyANlkOZFd03UE48Ytpyy6zdCPcKsW9oNPU
	 s12aoOHhWjIbqzN8TDMALCzBkPAL5ybZDbb1AbOUSwaAQ7NsoroQeJSIMtZcPMVG2tg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuWNmc1p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793465130;
	bh=7XjhtRytnZTJRH6XCvKR1fagoTuLbe/QAz4NAE5CGgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IlY2tCEr4amFQtDms2Wciigk0/avu4Rgt5SJa+g0oNe8qdvhzS96VtIQyC7WGW8Ns
	 yqfYsG108d//rGs9P9Ke0A3eX6MKCnBQUtjPrGRJevnQO6wtKDIFSKGqjSw3fqiKwM
	 uczBqRf5hSbRN16POTjjSC8T5gugsPZN4T+QKillfgNrhVvXIFUDrHGs1WwG950dYR
	 VQO005mCbKuiWNpZf1Zfc+Wp3mFhwmkynu7okXaegqL4zOPocNj3oyT3Pm3iD+aqgB
	 nrsBC45hqD1fRVU1T2ViBqiAkpZcDxsfiLj1bLG1vPHLyqNXcjuejtycfvtTFR/8Ra
	 XYi3Rxbt5liWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A39C380DE8;
	Sat, 31 Oct 2026 16:45:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C954E156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 16:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE2BA80DE8
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 16:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cEjR_5uw6ziG for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 16:45:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 73E9480D80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793465128;
 b=GrB0gyLPXCwCU3aFkQ0JlMvu8DE3z05g5eS767dPGg6SzS+nX5O9OR48iQ4ELGlnQSFh
 evhq1RQpJRWMOjuYI73YV06jtZqLAKadhWAxdinpRT7Tp1cMTkvCflw/HpydcFsg4Zdh6
 0a/zlmr5I3OdQibgRMtTrx+Rm6DeLUHTQVwDXlx8NS5IggqV7/VLFBB7jdkZJfjdeWeth
 Kf2bJdMgjCeFGH+ib4TVU47zgL0zca/TKRk0tZEvKXX3qOW/3zKaOzjmCoIusbUKvLMYg
 t9oESyWYQZPlLY6AZ034uzXLIZS1l9v9fbilGhb3n/8soGl4Dd4f6ncatH3RuEwiTTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793465128;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=7XjhtRytnZTJRH6XCvKR1fagoTuLbe/QAz4NAE5CGgA=;
 b=fMShhRdzOWzVz9v8tTsj0Zf0Cdr1LtxTZCONNLoxalCErlkFWTHTlDLbS4dfGG6Bj1Xw
 p9qEOFiMBM9eBPflVmBiEIAzC95kDvfbuDI3FJbxhio7SMloEtNXeu3HjLFF+s41trl7b
 aglGHuORJjmr+dm+Hd0D2lNgm1MBLEtKekZnNiFZsGRmlJzeQyEUgHhYRunag6Xx7zJom
 4pVyKxZsEuD/Bie5WtE8gpTgl9f2EfmF3fBzh+3n8p+JVjVF979CzfGTvXHs0ZQzo2boo
 LcOiq6yVi0kcxu9fnTMGl25KcXop0SAQhrJiUHuoH4mafQWAOvsNG5xG9eBPs4dfLAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WuWNmc1p; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WuWNmc1p
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73E9480D80
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 16:45:27 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so2776323a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793465126; cv=none;
 d=google.com; s=arc-20260327;
 b=jj2lB/q2xMt2wS167f1k2AYmTUdtjf8vWI48q6GS4JNDmaWG2GvAjHqyIuREhiJguc
 2SKHHvTf2tkmxcWwaKaUNqOmqRDxh12/LdtTOuFR/wQuXeI+YMz8CMhoawIKxrPKmYoO
 Dbglx/c2KENrU15c3X1sZpB4ydluN6qlIQ4gD49uM7T2e9cb42Yupi6tlLdhtPHYlXz8
 +FVNovV9yxhCsdbioiiQKF8TrSL6MeF1xSUx4K35QM6N+fM8XMGyaXLcmKdKlE5ut9AS
 4bUDCbXGbAlOoEhisgrnHDiwVkreurPIzyyQ5KDbfmujmRSsEDB/4IsFv+W5iRgPnjjd
 2A1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7XjhtRytnZTJRH6XCvKR1fagoTuLbe/QAz4NAE5CGgA=;
 fh=7h0RBIo82oTb3gs8UWhsSst1+gy3mDl44Ba62kH2lX4=;
 b=G8BD26Wyd6X+iDivAYpkzS+DoNXBDw4YAPp8BCe0z+sxpZV4OSo43kC8cjo9kU72Jr
 tft94ZxsLIylvgUe9pyOADPZBB7Geh+4vQcYQbdfuQcOmZp+YBKMX+MGwTz53z25HEXW
 k21xmiY7CPoTdNfGVpLJ9ksu4LP0r5W8NZiZeoAFCmK3QC0PtIa781Ht7HMTOEd24HAr
 G8zEXmbwCm6hzdbwbsaEmM79DvSamlWnTUudKSKr/ZKobVZLzVW5Z9sQI1se5DIsFyQ+
 Bxwlgr2TwJwLu+FlkMzlXtPHpNEQsfUHOSt5wEgcE2CUYeOZotey4kVIaJJ+XQimUd8b
 /QjQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793465126; x=1794069926;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7XjhtRytnZTJRH6XCvKR1fagoTuLbe/QAz4NAE5CGgA=;
 b=WuWNmc1pWGa+A/fMFR1FRWGSAGR2U9NDvi3TftEwNZx5dohwnF8G8VMkVmITsMw/Fd
 VjXnDZU0TFcMdiqTfg9I2aVb4ULAL8WGhp/qprOY0N+oCGkXgiQlKMESW8gLxaxXvJxa
 OZY/YH0HMhgyLEg+3TcW/H+DXzclSsCgHec/zI41sVPbkZwDFtFOpjE7LAbBl00wVy94
 76Tuuqyp2MuUOLOvAq8XspvZaUHILt7AdQM4irdG2Bv5MzgIHyJmLvURrUNtETOLPwWO
 NcQsjnY30oE+3R/R5ABpRrys4ehfarfRyb+I0OOrt39/tnxbd/R9mq+aBR51HpTN5a7G
 MkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793465126; x=1794069926;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7XjhtRytnZTJRH6XCvKR1fagoTuLbe/QAz4NAE5CGgA=;
 b=xhjvHje0tQ9vyvTh5Q7Uu+3/iWNXnvYH/eSFih5BpIEQEOyqpGSOyqvdVC+d+H8Ao1
 yanAYvWWDjlpX48We716M3vyya9P9aaBXV80fRkfGGCqdXgxiICJDI0jbME3GbNgmRdX
 dzqJukp4TP7KQW8rpLkrfaD0h8ZieeZeFKcyQmF0nurRt7utcys1HQQJNBtQNAaKk24A
 Dsb88yideVBlqcYR4v39/DR2yJ9mZFEgbrrRmecC6fY5BafrLWi2mfp1Nf7prJrbIOoO
 nZUhhzQuG3LZBXiKdgUh6V0UtT4SKZjqzIijxM5J7foEYOY0gyOdTYBRPl+BdNGh2cwF
 7COA==
X-Gm-Message-State: AFq9FYK2AzIEt30w0nlNFl8/TZaVKpdsyyn4iq8eC48XQK2Sm1ICfs8m
 lFx9iUsjrtNNP4duAIgtUxApwDN1g1YdSVqth5sxLdBmaR4MJOp1mVHgDP0a1xCoCirl+x5N0kK
 7bC2uMZV9EcHFoBdBVdCGDT8E2/cv9SOz7QwB
X-Gm-Gg: AYBFou1g4XLv9/E2dcVEZaS8N/klmCZVadMQVD84qQMaNnLBN7AKCpZT+QUfZSdaKa3
 YI253tU8GMfJ06xoQgBxdXrTNP/SUT4pMox9vQjF1OSTutDxqwJJl2eOVZodA7sNCoWWEL9PWK3
 y888VJr/U9VqjY/O2bPh5kdvIJZnXisXZLHOOwYa5dXUqrnVM6LENNLBUVvOcdjLrljLSr6eAMr
 Cnenu+g0jmw5ntYqtSXNlOEVOBy8UXaSUVbMix2fc0Aqg/gyX5MqUas/88/H4yS2HeXbuica2Gg
 RRGxuFDdjpyYiwpeVRFB9x1GFonLDRI+E7m3eB/P8B1m8IN1TZcLO7c+nbCaeFpI51DGYQEUNMY
 z9aTPxKPdJ23uJ06dHeX8Y39/nYjSEcMtFEs=
X-Received: by 2002:a05:6402:5489:b0:6b4:21f6:ff48 with SMTP id
 4fb4d7f45d1cf-6b4d33aafc4mr4048358a12.3.1793465125714; Sat, 31 Oct 2026
 09:45:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029134705.3767-1-linux.amoon@gmail.com>
 <20261029134705.3767-2-linux.amoon@gmail.com>
 <20261031115645.3197359-1-alan.tseng.cs@gmail.com>
In-Reply-To: <20261031115645.3197359-1-alan.tseng.cs@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 31 Oct 2026 22:15:08 +0530
X-Gm-Features: AclHuK8Y1zsahvYJnnY_bnrT0ZliMwhX3eY3mjnI2-QuAiFGk093stU4mIC4RDM
Message-ID: <CANAwSgTnTtozrtCj498eDdZMN76Lkkyixsc=9wr6zEXpiebi4g@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] riscv: dts: spacemit: Clean Up K1 U-Boot Device
 Tree for SPL Initialization
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io, 
 DaveWK225@protonmail.com, eric.chung@riscstar.com, e@freeshell.de, 
 dlan@kernel.org, pericycle.cc@gmail.com, tim609@andestech.com, 
 leo.liang@sifive.com, me@ziyao.cc, trini@konsulko.com, docular.xu@gmail.com, 
 raymond.mao@riscstar.com
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

Thanks for testing this series

On Sat, 31 Oct 2026 at 17:26, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
>
> Hi Anand,
>
> Thanks for sending this. I tested the series on a Milk-V Jupiter,
> booting from SD. It reaches the U-Boot prompt, but the SPL no longer
> finds the PMIC:
>
>   Get board name:k1-x_milkv-jupiter
>   No PMIC (-19), leaving rails as found
>   DDR firmware: [0xc0820740]:0xf0227179, size:0x8d98
>
> With a Jupiter -u-boot.dtsi that has the same i2c8/pmic block this
> patch removes, the SPL sets the rails before DDR init:
>
>   vdd_core, value:900000
>   vdd_1v8, value:1800000
>   vdd_1v8_mmc, value:3300000
>
> The commit message says the regulator configuration moves to
> dts/upstream, but k1-milkv-jupiter.dts there has no bootph tags and no
> vdd_core/vdd_1v8/vdd_1v8_mmc names, so the PMIC is not in the SPL
> device tree and pmic_init() skips it. It works on this board only
> because the rails come up at usable voltages. How do you plan to let
> the SPL find the rails?
>
> The new file is also not picked up until 6/6. U-Boot includes
> <dtb>-u-boot.dtsi, $(SYS_SOC)-u-boot.dtsi, $(SYS_CPU)-u-boot.dtsi,
> $(SYS_VENDOR)-u-boot.dtsi and u-boot.dtsi (scripts/Makefile.lib),
> which on K1 means k1-u-boot.dtsi or spacemit-u-boot.dtsi. Nothing
> includes spacemit-k1-u-boot.dtsi until 6/6 sets
> CONFIG_DEVICE_TREE_INCLUDES, so 1/6 to 5/6 build without any K1
> overlay, which breaks bisection. I have not built each step. Naming the
> file k1-u-boot.dtsi would get it included from this patch on, and 6/6
> would not need DEVICE_TREE_INCLUDES.
>
I think configs/spacemit_k3_defconfig uses the same approach.

CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"

It is consistent to use the same naming format for files.
> The MusePi Pro overlay also set sdhci0's cd-gpios to GPIO 80 active
> low, while k1-musepi-pro.dts in dts/upstream has it active high, so
> removing the override flips card detect on that board. Was the
> override fixing the upstream polarity?
I haven't verified this yet, but we can retain the override if you prefer
>
> Two other things I saw, neither caused by this series: the SPI NOR on
> the Jupiter is a GigaDevice part (JEDEC c8 40 17), which needs
> "configs: k1: enable GigaDevice SPI NOR flash support" [1], and
> U-Boot reports 8 GiB on this 4 GiB board, a known issue in
> ddr_get_density().
>
Yep, you can enable CONFIG_SPI_FLASH_GIGADEVICE in the
configs/spacemit_k1_defconfig

> [1] https://lore.kernel.org/u-boot/20261027154347.1392094-2-alan.tseng.cs@gmail.com/
>
You likely need to update the regulator name in your upstream patches
to match the specific naming convention of your board.

for example
               regulators {
                        buck1_0v9: buck1 {
                                regulator-name = "vdd_core";
                                bootph-pre-ram;
                                regulator-min-microvolt = <500000>;
                                regulator-max-microvolt = <1050000>;
                                regulator-ramp-delay = <5000>;
                                regulator-always-on;
                        };

                          buck4: buck4 {
                                bootph-pre-ram;
                                regulator-name = "vdd_1v8";
                                regulator-min-microvolt = <500000>;
                                regulator-max-microvolt = <3300000>;
                                regulator-ramp-delay = <5000>;
                                regulator-always-on;
                        };

                        aldo1: aldo1 {
                                regulator-name = "vdd_1v8_mmc";
                                bootph-pre-ram;
                                regulator-min-microvolt = <500000>;
                                regulator-max-microvolt = <3400000>;
                                regulator-boot-on;
                        };

You can verify this using the command below

 # dtc -I dtb -O dts spl/u-boot-spl.dtb |
    grep -n -E \
    'regulator|pmic|reset-controller|reset-gpios|vmmc-supply|vqmmc-supply'
136:                    pmic@41 {
149:                            regulators {
152:                                            regulator-name = "vdd_core";
153:
regulator-min-microvolt = <0x7a120>;
154:
regulator-max-microvolt = <0x100590>;
155:                                            regulator-ramp-delay = <0x1388>;
156:                                            regulator-always-on;
161:                                            regulator-name = "vdd_1v8";
162:
regulator-min-microvolt = <0x7a120>;
163:
regulator-max-microvolt = <0x1b7740>;
164:                                            regulator-ramp-delay = <0x1388>;
165:                                            regulator-always-on;
170:                                            regulator-name = "vdd_1v8_mmc";
171:
regulator-min-microvolt = <0x7a120>;
172:
regulator-max-microvolt = <0x33e140>;
173:                                            regulator-boot-on;
298:                            vmmc-supply = <0x3d>;
299:                            vqmmc-supply = <0x3e>;

If you get this working on your boards, please consider updating it in
your patch series.

> Thanks,
> Hung-Chun

Thanks
-Anand
