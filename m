Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023AECCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B88D780F35;
	Mon, 19 Oct 2026 13:20:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cCHF7eAiLMep; Mon, 19 Oct 2026 13:20:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1491880F72
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416027;
	b=TlI4VInolCiTDA2Rz28n3aJ3/1MGCIssuHXsB6vMLA0Qupu23cgzI579qrnu170/Z2FZ
	 +xAOFmzZJZKRKqGT+5FefurIJogQFji14cbSfb6AyInQa8qhXlhtlkMdAx7Zo1JWOhMrj
	 Mo93HwxSHlEOS3MKN1YtVEjnXTbbYt05PA7oaK4tVkb2GowG0pkw7k3TIS+4ZfKPVXU3Z
	 0GiL9opRQYYdMHDGneWs62k1mfxtHzKxhUNTKWT9mFAbr78EKbaxsdwBdIalsbmc20HA0
	 1Aic7NCruNbVxMI1BMjZVSFyW9auyYUI9+M5lFz7gaCATuAOLT5gAZUGrXE53ElkFFg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vBkFK0iZryLQCxUhBK31LCMaR0fd07cCB48Ksv1Z62Q=;
	b=RRiOe616E9YNZZo5vssE4KASitoTRrdSnufE7w9ftqBE/NnwJEERSYqsbiOCiY28N4SV
	 ZZsfE4ekFQSxeCwQLf3x6AtklyfHHGADc4PR4KUcCXjqW8SNNS60tXR4r2mqsvpRWcASi
	 c29SWHGuubzN1lI57pu6uDPlPFPeBvHfdidnvdTciJ2rKMOA8U5zv5XRGE2OwTSfdQoC5
	 7/eJwtCSmEXcDfxcuasSzOllu9O+6vpERThmL3Rtp3CtDFZ1gRVNQBqkg/iE1COQ7ncvB
	 kJK1aYSjgfkTp8o/LDm/QzOJe+/zIxMpYeILqkPXior0ioiJZIyMm9/QxnK29YAA/Hw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LZKy5iKL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416027;
	bh=vBkFK0iZryLQCxUhBK31LCMaR0fd07cCB48Ksv1Z62Q=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0xvwE09vDC19i7vnY071fZ8PgC5ZSHh3kuh7U8g1N3PAh4H+jB5y4KGjEtVwT68pm
	 wPCM86oh9JQyywff6JbkrMvPxXAASNFsKdBs9STj4Qbc+YoJ4+TXt5uqDGBbvVvfOn
	 QzyhcoNM9dWFsNF+QngwFiUWfbfYoy++cCqdMnW7x1/iLN52q7N7KpY9OjBPXNtj36
	 lG5W4a2Ac7ySVVPSBjmxIwQUeMGq0TOgMjsd9r3g05eEPSq4hFCOb/TZTvDwIWfpsU
	 Mz0qgA9PLJJq9Sgqi/MUl0nSosEWUlgf5K/8mcFW/BdNmLAI0HG9MLUx+5Nn5BE8Z8
	 5tqcwPcGgGaKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1491880F72;
	Mon, 19 Oct 2026 13:20:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEAE123A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0C7D80F72
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6CNHFWjLSH0o for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:20:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECEB180F35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416025;
 b=XjEI7mW9MUmdYRCdSsehj63aa2zJCjt05qad/uRbTCKfQ6NDccWpCK/A8+g6xu0oO8EA
 gKRx3mGMmuh/xYXLkPqvNFLHN0rsUPs7yKmr5vmaqGFxBtMR/Rk/JL7HppDUL+VSfBApu
 FsQPShehuB3V5n4+8ZtDrPLlJuHUC3h3+aMXYLyHCXFrjIK+7mwzOWBMT2t9B5cFit3lo
 MhcndY4DJP8jOpy54bCcePLofgC/VodYTup/p59l1wKHdj5seEeJMVjypkY6GrpreD+tZ
 5dCh1W7EbySqUeLxmEO6FDFK7X/aQAAqridJoS3qWEhh44qBsYshefIyBufG6PNQm8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416025;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=vBkFK0iZryLQCxUhBK31LCMaR0fd07cCB48Ksv1Z62Q=;
 b=TWNnDFpSOYAHrpkRrdiQHzFdjUKs3LoEhHUJ+WSo/TrPLxkVpY/Zhqjd0H2GA6DbZ4Wd
 KbakjiSYHC3iBo/bYyPdNAGQzyFdR5FFdkODiEY6rKTOVGVI4zKZ2vrCtj+WctLIUUPtC
 ioXh/86SHJPr5v/6W9eIVX5blzrxfJwy4SKwdTs2tX76vs3UzWc7YSD4PijFkM/Ck85qo
 lrcl+MJjxw6v6A/MYeYncvcrOkt9Ukpkoc59rLRIAFBFzqXK/LdjDux1n3NqIiMUf+9O/
 bmz8+Sf0Ofj0tSO+NHYMzY4+ExtCGHYypV4sepLBIzkKILLga3/OOSWLyLMpaRxma3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LZKy5iKL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LZKy5iKL
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECEB180F35
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:20:24 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso2849218a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416023; cv=none;
 d=google.com; s=arc-20260327;
 b=DDYD5CoH2WuuXgUqIxi7wDmQXv08/dPgWdxjGpz68TaBPpWra7+nfta4lMG+cLW0MC
 VQpsTQL0KwPoAQ0Y6et4myeLMjUs+ovD+X2+dx199f234YchisWIJv0tvuJXjD06fB6C
 xFpk0RY33RbzNo0eYPx6f91kWh4CI/8BBhLEtk7YIWMeQ7k/1T6cVOmTRIPxMGkXmGFJ
 Xz654FBFLRuv50Cn7T/y0/mRMPEBPO5chNYp2CfL0vC1xi/HBsyvPOqfaT4tZcXvu5Ew
 F2iAo67HlexEL/RbCyIkYd/JQ6I0g6yqzaSrwU2zWVk0vDc7ANRRP7PK7vpxAzsD/OlG
 gejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=vBkFK0iZryLQCxUhBK31LCMaR0fd07cCB48Ksv1Z62Q=;
 fh=5RTRZV3taGliDHEcLEfQeqZTDm6mdBANkQjoqjI7DX8=;
 b=C9PTsnv3IB3ua7eoJPKh3bq3FiBz6wbGbMx4tKpQU48SGifOFVhli5FcNp0fpX3dUa
 IQ4UezvP+oSTIJa/oY5XbfEPj1IpyZLrm/ySTYp2G89qmEDhFf5F0eXxVojkgeNOr/uu
 UkrCXMFS7zvEjOYhZ7OisWoZ8FVXw9iGxOXpAW2c3UW0/UazQDhQkBNaDthh9sDLcC3b
 5EVhgB6Y3fT/lNXo+kGSp36PEX06DHARX067kJ3IsrMeCGu1k79Ox3Mt1dfllrdAnyXN
 Gj68PdY5LAZUIcYFKhM6cIaOHmNpD77SqcUguNDYhXy+UFs5uD6tec56YIxGFissaJdV
 4G4g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416023; x=1793020823;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vBkFK0iZryLQCxUhBK31LCMaR0fd07cCB48Ksv1Z62Q=;
 b=LZKy5iKLsN9n21AZSDkABH5ipdmzbQNoNvUh41BQ+NhpQhgpWkPrn2EMwuWofwSluq
 rE8lRe3oDzJ4AgF4rQE7F2qU+HQY2fvxXU7EgdxbudGg5pMropl8RkUPPnXrsBTUgS/U
 E1tGerjeRn6I6XKuBvtRCqrQnWyHvDRflD1S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416023; x=1793020823;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vBkFK0iZryLQCxUhBK31LCMaR0fd07cCB48Ksv1Z62Q=;
 b=aU6zVRRP0kFZWLpblL8lfDMPSKpuQe8NlepXk5O9yPLmRbyW279D50aesAa1PY93ya
 Q462P/XDNonvBwESSzQbX5dJpVFLgY0y9WC9KCKR3tkh/8q0dPtBVqCjGTeDDHbya2O3
 gSZzG+W/6jqQCnJF2VbX35CHfU/Yp73UeVas2EezUcBEOPjluQfaEQ8SllVxqXmv1YFk
 xS9cll+hL8KPfqBgjFC1L1pRzNweHLLIddWjzf3yUJuuf1uyzsTlEvjbrj8RNMuESLG6
 mvvzhpvOtk1kBFWY6H+0dJdj0Z2RGWQ0MUrU3H6o2eBtz9jRwfxYbzsY83NHorZibtjO
 BDlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj/xX0VfCQsOipzmQbbQkClXTslcWgmllDc/0gDQ5fGpnD58tGa+9G8pfjWBxXesNPkEutyno=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKnSBmir0MYhn4IgmQGkSN7px3lgP2AK8XRK7ahbAKkZsRW6/kI
 n6utTADhxL7OJNRLIbk4VtJEBB9HGumgaNduwlnRJ7lFzSuJYtDcdyFwWqiQv2EJU15haSZhTJs
 /k25zl0tqCaSlyVlcWd3bvHEzeusklwkkzgRtxQs6
X-Gm-Gg: AYBFou07KhQQqyu6HWXkyrim/c3U7cnaqn//L90ebCOciDohPhHBWeUmOe3KFnz4yoV
 VDj8Omxgo6sciJ8Fya8mCuLP4nhcxzT+yRpOg3KPfiVO2muSBhVl3bh85h8nISlVAxQvMUb53rj
 qkTNfWOTgHPBYSeTqNGUZaVB8uuqgLYGkxzPsXDQsTdyjEfv40sA1W6V6pfo2bySSbRT7q0nVXC
 IDo+PsXbiT13M6HQr9ok6YixVZSwRjjAQ2FeJ+H1ca0/1eUUUFxberSP0N2EJGwhXD0f3LObKq4
 kCNCqczWfqq0sF6aE4yFqBWh7dMCsAR3woZ8nkREzoYVimnXiCVjPA==
X-Received: by 2002:a05:6402:5187:b0:6b3:c74e:b260 with SMTP id
 4fb4d7f45d1cf-6b3c74eb4cemr2585603a12.33.1792416022681; Mon, 19 Oct 2026
 06:20:22 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:20:20 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:19:50 -0700
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-2-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-2-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:20:20 -0700
X-Gm-Features: AclHuK-PDUMpwAm1j0fM-7YK1_pfznfGl52kmPAkhOGQj2fiLi2d2WYUzeXWmVU
Message-ID: <CAFLszTj85xiaiGoZfEprnOjv3j7yP4ZJcYhwA+ZH5_TU5Sbj+Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/20] lib: fdtdec: Handle multiple memory nodes
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
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jiaxun,

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> lib: fdtdec: Handle multiple memory nodes
>
> Current code only tries to fetch the first memory node found in
> fdt tree and determine memory banks from multiple reg properties.
>
> Specification allows multiple memory nodes in devicetree, rework
> fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
> to iterate over all memory nodes.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  include/asm-generic/global_data.h |   2 +-
>  lib/fdtdec.c                      | 127 ++++++++++++++++++++++----------------
>  2 files changed, 74 insertions(+), 55 deletions(-)

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> @@ -1115,90 +1116,108 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
> +			log_debug("%s: DRAM Bank #%d %s.%d: start = 0x%pap, size = 0x%pap\n",
> +				  __func__, bank, ofnode_get_name(mem), reg,
> +				  &gd->dram[bank].start, &gd->dram[bank].size);

%pap already emits the '0x' prefix, so this prints '0x0x...'. Please
drop the literal '0x' here and in the final log_debug() below.

Regards,
Simon
