Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D5ECA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88782813DC;
	Sat,  3 Oct 2026 13:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EyR151sDMZXh; Sat,  3 Oct 2026 13:41:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B8D7681414
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034863;
	b=VLVv/qrrMlYdH866/TURI/hKwXByuOlnPY1mvG8NBaiJNOjkt0WY2YAByp9zGRnFX45V
	 4hx3UYPkSt8FwuLnt8GZi2eW9LSw/hQmgmo5kkGmMmjvzWIvRbNMchJmRACMPa8TRKthk
	 b9AoDsvKtiwzevfKcKLbDYYyBn5x6TTaCfBA0Js9y5pxOn8kwFsRSrR65M9SvL8sFmPiR
	 HC68RAkutssTftM/kpnqiuW0TqN9h82C3jQlOzZBJs3+QjkWl3oq+yPn/mUqVPdZsczb0
	 4YyKSWxx8DgUzF1oy+QeMLgD+Wg7Nbyzc5pgvpAYzMh2RhruZEI/4kf235LA7qV273Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2HFUmxV56QImSdtnKVLOgudgz1gx+BEUN5nrMg2IQKU=;
	b=HhzwsKOXVHhQAWLXdxcnpaWs2d0SQv3LVIBv/jy1tWmOnNyUqeIVilfcdj9i9t+CmZjp
	 bbpl0WnM0VXYXc9Oe8Oap0gUJWuu1P/HcQvOzx6ysSIFpwaVFTp6J9Y6UUVFLit9gFj3h
	 XsKEYH7oQjUqUorJ3+J2xlqE2cT09T9dxADmgrLhuGLG8X5uau2zfyeILuAMtOZuuaXA1
	 spqz38tUxFy4zpBIj2RslEC2veFGf7syknUT+j1X5pceanYEQ0rkdpwQ563dOlhy1MVb2
	 XF+iMdLcAUs/mkFhQEB9jhWL/pyRtOBF0MaRqpMTF+Ef7tz9unQj9GIVEXoY163WYbQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=faDDTuzu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034863;
	bh=2HFUmxV56QImSdtnKVLOgudgz1gx+BEUN5nrMg2IQKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tTNc1YbRAXFtN5a4RUkl2VKUs8w6uWliMOUf9ltUaswFrN1gbzgxahaePpqUK/SwD
	 iztiKsGtBS9ey8SBZaNUw0N8w4zA3h0XO+I1sFb+VaMGhlLrl1eeb9tDDwYUGmYhnr
	 AZ00NdZXX61jpN1NRA0weX5D+2Qs5qZ+dTN9SzmVggiiY0LSXkmvZlLT+Iw7QEKXi+
	 uzbF6UJm6CTJAj0ntpx7/qETrgmZpR63tz+MMe1FD5y4qEvTnz5qC2NpGv2jdL1USU
	 EZRjC6wgF6eMFzM7QlydUb10YpdKhs3QuglYWY4/OqW8dbLuX1n8b5x/0qkDZFvJsX
	 O50w798p+H/BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8D7681414;
	Sat,  3 Oct 2026 13:41:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43568282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28DE681414
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5n3IJZiSwwJ for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:41:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2A608813DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034861;
 b=XI+dHV0JFI1jjyuLCQSaVF/5YUM66hOscyHLn06e2QCCkk3qZIwpNEeffjIksqC/J/oJ
 iB/Y1BDLNzhUJ1dbI8ppkwmcUf5ICqCPFEWj2OcaCV9dF1YkB0j/0SenFV0Me8vQ6NeTL
 +VLKjxme9fAMGfeVMzuzTU8BBYqemUiW9nfbmaJWLTfZ8cl37f0u51rkS0D7F60DSZ4f4
 TEqx1W1YSdDwgNqLEo38U1DeQEdG1AKNZ3l8YR41xRmMKQhglVhRUZPTPKW4QlHWJGqvu
 vMbVbHvvCG+MSvCxIGTafw16peStQu8pqFCujxGV7+4kS80w7bP0CF+whoDslx5kthw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034861;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2HFUmxV56QImSdtnKVLOgudgz1gx+BEUN5nrMg2IQKU=;
 b=aZfyhnWf7r+qt58/EtGkcPF+ZN/3uknBtYDNhbp136tNXNBxtojxNHLqLiJfBnTiuBdO
 445+63OJKQHsT8DJ/Pj65XyitYFzlZik9EX1z6XpAYREfLb7AH7e5KrHHEX9M4eBe7ckA
 +o6kpg+5a8n2ysb2dwozIL+Cg8Loh5zgDebqI2jOBgWm035ITd/J3DAy5FuzSWUdfCHVa
 jyDZAEFBOzFXSRpReJxWxk2n85aG8LQdDuSKySr5+NpHy6GVQCp5kTTzGBRpSVnBaJVkX
 wCoHR7OuudrtLRyPSTG5qadYMG8dPF4g5tAaJXW0oQdBJsbV9XZw+JxNfRTslD8djIA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=faDDTuzu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=faDDTuzu
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A608813DC
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:59 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac6fa788e6so403217a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034858; cv=none;
 d=google.com; s=arc-20260327;
 b=rbnPhHQ8L0KC+1LjI/LrxTK3pcJw/JD/lSd4QoeoNYcMClT3FfIU9qOnb+0ZniDeco
 gl7Lg9v87J08hWBOxB0o+ViSwvl7Tq1gkSu1Xg3nQSmswrJGvUDlO9YaCe+4lR+w2WBc
 iqYEj5g/1g+C5jj0lkivPYWVJGwGcNPVkEOHyh22c0D0PGRG4xSD86PAckug00sbbetC
 Zx6X6pTnAesgvYs486AsB5NtxU/osN41rwDSWW2+1S6T7qVOyFfCutSVjk2tbFW9mXBd
 OaXN72NmibZINAoRLwN+Tb+1d27Coll1iVC6YFmRaM5vxxIqISHRwIpsvUxaVr93kLx7
 xFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2HFUmxV56QImSdtnKVLOgudgz1gx+BEUN5nrMg2IQKU=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=oJNLMr2dZByRLB2twEkqcSLNQBIWjQgLqRuDCaG6wiYGzmwVMrvUCDT2bpxFWUBnSN
 EEImNSzDuWVhY3zNGg3NLUnqRckS1KhimQrh3I8a+0LpftLB9RzoiF0jN5ntrLytMya7
 a1X6j5g38dKbu/IS8hY67kwc6TE3oxlVWyRyhTbRgfXVO1MfAeCAACx1Cwa0vgiu+rhI
 wLu2UJr0Ps1LLtipc96xr2pkFefnRg+H5XN9ORkTVDTMVEam1OlWRzgav0x8b/TV3hZt
 4FUWkEkNNW3E8b5CPRHDtKy9Tn+uWOBQrndeg/K/wXV4ibyek9vycX0oHj8Qv7LARaHC
 DLIA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034858; x=1791639658;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2HFUmxV56QImSdtnKVLOgudgz1gx+BEUN5nrMg2IQKU=;
 b=faDDTuzuqzYUF3CfhcuT2p7JyPkA5kzT64jk2jbH53GtMOHgxkDYAUWdu9oz2/Vy8W
 wgJabm39i2oq8xr3q5GSltygFmtQkglxkzrDAXzMmWDgtkgvpVxsDLTiq6Dru93jwURz
 r1sjQ0ykx5bNsFkPxFlDCoBueoPFQPjx9V6io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034858; x=1791639658;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2HFUmxV56QImSdtnKVLOgudgz1gx+BEUN5nrMg2IQKU=;
 b=L59IQY6rhrAFmn6smTSNHFec+c2cIHTEFztJ5KDrvHZlg+rpTlBEvc3c/Vku8XXvqq
 1eO9A4OfNHCgBn9voJdJe1hPeMQKZbJKrdX6xzQscCkwAf8zBPQ/sxO6f8CnhANzd0Og
 8wImMEXPmr40Jw0hPW4h5JzvcxczhWbDumx55igWHDHQ2bTimx1qnEFWwZB8+f/3dLNg
 NHI1lqjnkFy4qLQG88zale6poS83ldHTJLJeMP3RWFLcygd09+p/yr+cbox1sxOer63R
 vPiSqqiTGYZ4hgBjZohpjeNdjbzHtxJeJw5cjFJwvhElmjSxm5T4UkrITTTpaXwRtWZ+
 X9cA==
X-Gm-Message-State: AFq9FYKl0CLlfQWVihZp1j3IylElqlb0dLIObJmjWo6HvI5x8iorgs6P
 eiAVIlU932IqlzeaZ99h3jvDKXcehQgR9CvWHCQyR9E7DMpMVho1j92ATOXsPw0h/Bxgwje5T0p
 U/s6Ncr6DQrz7vC84Nsu/S0iP0uHTCU3R5VEjN1pG
X-Gm-Gg: AYBFou1d7i3MvlWM8MJjcVR20XYPwMZrKswXxKn80+pHEb7KOW28IK36AL3WQ22IXFQ
 O/rsZtEAHW/FNFEg5mlmPheika8SqufN8gF+s5wUP/rCGVRf5tT/XOCnoNHlhcbLPTQ8eLRdrOR
 bJuDeGBldAuEDuJWWtU7xho2t7eKnNkMnnSm56eIxTFqIi71eSejuxjBz9u+IMKgiaRZSeHBcl6
 t3PKXoCMx29bOgj39rYM8loKkqrBnpM8hw/sxj0VcS50mBFwx/uhcnSUfMDrMz+wdK6i94COBUY
 3hDDoA6gNImOROxMh0QKRwEyk7VwYLqH1LRyQmr+NmSiMVUPX/zCEA8=
X-Received: by 2002:a05:6402:5409:b0:6ac:c759:556a with SMTP id
 4fb4d7f45d1cf-6af9e2fd5a2mr4974702a12.27.1791034857733; Sat, 03 Oct 2026
 06:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-4-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-4-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:40:44 +0100
X-Gm-Features: AclHuK8qQwgt9fD2L6W-fL6tGXHr5VFpdc6S71blM6UN9SiQoTk6HnTdlw0SxMQ
Message-ID: <CAFLszThSk33kZwbWHMjMSdc9w75WZA0yyQv8RH4iiQ7-Jr+X9w@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] lib: Track whether a phase has a decompressor
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> lib: Track whether a phase has a decompressor
>
> spl_decompression_enabled() names the two algorithms SPL happened to
> support, so every algorithm added to image_decomp() requires editing the
> header. It also asks about CONFIG_SPL_* from a header included in every
> phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about the
> wrong phase.
>
> Add a hidden per-phase symbol selected by any of the compression
> algorithms and ask about that instead, which also matches how
> image_decomp() gates its own cases.
>
> SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> common/spl/spl_fit.c |  6 +++---
>  include/spl.h        | 10 ----------
>  lib/Kconfig          | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 13 deletions(-)

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -284,15 +284,15 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> -     if (IS_ENABLED(CONFIG_SPL_FPGA) ||
> -         (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_decompression_enabled())) {
> +     if (CONFIG_IS_ENABLED(FPGA) ||
> +         (CONFIG_IS_ENABLED(OS_BOOT) && CONFIG_IS_ENABLED(DECOMPRESSION))) {

The FPGA and OS_BOOT conversions are a separate change, not mentioned
in the commit message. The rest of this file still uses
IS_ENABLED(CONFIG_SPL_FPGA) and IS_ENABLED(CONFIG_SPL_OS_BOOT), e.g.
in spl_fit_image_is_fpga(), os_takes_devicetree() and
spl_load_simple_fit(), so this leaves the file inconsistent. There is
no TPL_FPGA, VPL_FPGA, TPL_OS_BOOT or VPL_OS_BOOT either, so in those
phases the answer now differs from the other checks.

Please can you either leave those two as they are, or convert the
whole file in a separate patch?

> diff --git a/lib/Kconfig b/lib/Kconfig
> @@ -974,30 +978,35 @@ config SPL_LZMA_SIZE_OPTIMIZATION
>  config VPL_LZMA
>       bool "Enable LZMA decompression support for VPL build"
>       default y if LZMA
> +     select VPL_DECOMPRESSION

VPL_LZMA has no 'depends on VPL', so with this select every board with
LZMA enabled gets CONFIG_VPL_DECOMPRESSION=y, even with no VPL. I
tried sandbox, qemu_arm64 and evb-rk3399 and all three end up with it
in their .config file.

Please can you add a preparatory patch to give VPL_LZMA a 'depends on
VPL'? BTW SPL_GZIP and TPL_GZIP have the same problem, although they
don't default to y so it matters less.

> diff --git a/lib/Kconfig b/lib/Kconfig
> @@ -1011,10 +1020,31 @@ config TPL_ZLIB
> +config SPL_DECOMPRESSION
> +     bool
> +     help
> +       Selected by every decompression algorithm available to SPL. Code
> +       which hands a buffer to image_decomp() without caring which
> +       algorithm produced it should depend on this, rather than list each
> +       algorithm in turn.

Not quite, since SPL_BZIP2 does not select it. The commit message
explains why, but please can you mention the exception here too, since
this is where people will look?

Also, there is no symbol for U-Boot proper, so
CONFIG_IS_ENABLED(DECOMPRESSION) is silently false there. That is fine
for spl_fit.c but anyone following this advice in code shared between
phases (e.g. in boot/) will get the wrong answer. I suspect it is
worth either adding a DECOMPRESSION symbol for U-Boot proper, or
saying in the help that this is only for xPL code. What do you think?

I wish it were DECOMP instead of the rather verbose DECOMPRESSION

Regards,
Simon
