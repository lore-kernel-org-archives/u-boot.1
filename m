Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EC5CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2543C80F80;
	Mon, 19 Oct 2026 13:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fgt7cNkuX7u1; Mon, 19 Oct 2026 13:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7262F80DA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416799;
	b=tcP5fW/9Js/o6DxV2qCrRZobxaCNFTpLiJNS63mTEryocBCUodtUt1H2/R1hELCS92eO
	 ZPYpiGR2+EgRRKNYVv+GaP33XESY3JTp1qlPCHr2cdzVeR4PqrIDHPcU51KcRQG2n0T5E
	 s3CHa5+jjC92UTtE6PINqmG3lHBLOL9kakX50FiWzSvplZywazyzCsNXHhDj+ejlDquaZ
	 Iz3QQXI1JAzLtGN3bD3WwhFTZttK4gd1fJ20CVV3vhHKLHxZlonl77jsZbSaSC0Fv/btG
	 H2idXTjkwMCj+eRshZycFu7Wy/OcoGr0d1qTT/iMUmJdER51e9jCe0LA5aq81v3f4lg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HX2kSuuZ/1toOSHZYGu4K1tf1QClp5RZcEQPG6vblQI=;
	b=HMdyX3dCzq4OyI3GRotU1Uw4eLs+eOdEmHp4pJDVW7PUWTu4vvC62Sscj86j/SD1HvdQ
	 tBHuVpiNG+xaVEpfn5+WoffApf6aR6Wk9izQhEc574RRFUZZLyyWbDCvJZkk/ZWMAPARF
	 dUUZaOvtgwtULCxNBw9ZoIFcc2hyEdPNhBAHWIiKtYaUAAzaJMDoyTeH1M7Gt8fqtNPlU
	 JJjhHtMkuRWt1l3x2y7VXXY08IfUmBaciU8hk3IYnucz06yTCCfToHdFrNrFftFKdwgpH
	 Pwm8iHwPb4+2sfzRRfBqhMDX8Ds04Avgts+lsHzAA5/oSXthX+6FiH8CAWXslgSZW+Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416799;
	bh=HX2kSuuZ/1toOSHZYGu4K1tf1QClp5RZcEQPG6vblQI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hjcNH3rznHTPpCjtym9QkEOzNCup8ZA/VupINJxRhx44SfrQYm/lI8N29je5SzFY3
	 JB2kze49GVCdxmOJ2kfQeLnXLEiTe8qc+HoiMzuDuyxuGxEcsuBZpvijKHy9afY7ly
	 KHHH810nk2xkCwGwuVV+VTxoxjS8aJGdeamcZvR0b3L0b6VARkL+rZT92DUCwL4V6u
	 YH4Q+qdX4x6N3sGOAWVxRe3AOSdCvK+/C+nCTmVVQ0j0exys4haaLq41JbkL72OrsL
	 XGP9u5jB6MeF0i1wlrybGSZ+qO/dlmYaZX9lK1bzS2Fncl6gxLoP3O6bcg3ZhJswL1
	 7xIWcjVShLysA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7262F80DA2;
	Mon, 19 Oct 2026 13:33:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 732581AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58D5340670
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B43wEPfs6KI6 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B61D5405B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416797;
 b=nz6yy4XSgMD8kgVYioKw3q3dygWjYY6Iz6OMyEfUpq1OzGLbxPxrK/d232p1VMrya1ql
 ouw2LFwyzBIe4Mj5Mu7tTFc4aIM/aSuaa28cZOFYS+gaozG/a33PGuKBfKLk+siTey6Nt
 iaFNouUoVQwlLWU8qlTiD6p18l/aQnT8tX4Yz4g0L95+CqJjcwDk+NehCstqK2pZ5kofa
 pxhmQxtwjAhomh42tlHIuW/pFryDfU7avjsECrs2BuA8/Hg0fif6umAjCIDhi79KeCW9P
 JMPByyBPPOkHraTqui81xl5CcjgIRbXUPbaOVjoPgzUZVP9TMqQqMgWeXQ3kxYEjTFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416797;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=HX2kSuuZ/1toOSHZYGu4K1tf1QClp5RZcEQPG6vblQI=;
 b=jVR4gs6xWmjaDkGHPYgBu8Yq4pTmbiwBSZBQbOvtVMRWqrUI69hDFOOfiXYSCdjki+Ot
 8nbeTlfMdQKShhBDxmrot+WnHDLRwiDVezEE2jVHhc+nbWKqD9ARLL6C+zyftvPAO42i1
 YeUf1ot+9efd6eYobbaYpsdioYp1TZwAGp5heuYikOUjWFGW5reOA606zNOovoJgbYK6b
 GUaxe2RWKqk+9qEYsuU6XkumHY8lxWyk+HJ68tb71vdGpt79nAFSLMopbGYjySkIZOebr
 03BrQBT+efmctkmX2Dcp8FPYkuQLDuKe7YUglOlcf559aXrCN5+v1RllnOJFDf8cVGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aO82wRPU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aO82wRPU
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B61D5405B9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:17 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so1683929a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416797; cv=none;
 d=google.com; s=arc-20260327;
 b=KJiba56dP4Rz4FVE8wCycI64K34tzDG4kxkTjcL998l6pI+gUFl0X78X8+sIcTRVV/
 NzYpnCdK+TqJ8v9ss8871ABogRbfaDY/cztwwWng3B9/fJ0WdxXvOeXRuZ7qPi7reRgo
 7CihD7lxqzXHxOY7cSthOAX3Ytf65mj9rxqimvRL/YAC4T/b5UUM3UknpA2P/7vqOfLi
 VJ5qY9d1K+duro3tkTB83y/7Eoz6F4x+56i47lOgF8Gt+Vm+wAgM83Y2aO2lH5meOCb3
 X1yQdRmiIBz7HnSZEemNGEuspMmsZ3WhDgwmUfG5sTiRWP6iX/2gWlClOvO+22aPkLTG
 5mPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=HX2kSuuZ/1toOSHZYGu4K1tf1QClp5RZcEQPG6vblQI=;
 fh=i2tQHTfbjxCsmvhnoxB9qnRhfzM8iCx7s7bfzE6Yn9Q=;
 b=pBXaA27her+FRqBj9NP7XoWjA5NPFdOIgA2hR4jIDAL3gk7kVFO5LkrNGzrJqPyfBx
 pAXYseGuKGb/D0BcWytQiy+mDewtm2TaZQYwJBM4jKmbFf4wVPoKnvEy36w8Y9N9Rjbn
 gMS7z8WY7YNmdo2ZVwYul72rej0JNNDFtAS62aib6q6senygZqPmMLHqPf8cjboYaPSb
 PTD/rxHsyJgx34PZ4yy475kYiq9fOZGFouB+bbqQrI3NkNr7Ctst+p6J3QQHi80kLKTt
 TG3/niVBhLlwIZG1q86nBZ8Budys+dMYFfatg3WV661lou99spRsstkk6aHLOtSZrONd
 GWnQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416797; x=1793021597;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HX2kSuuZ/1toOSHZYGu4K1tf1QClp5RZcEQPG6vblQI=;
 b=aO82wRPUbEr/UsR9euGBF1j+BmDMAHVP1cFxbXvMJL9KEnaeC66VDk0961kxsaTEqP
 mveD2ALUszfCjOFmZduNW+WB+9wOijrieIA86BatZuAZN7CAqNFfFcVC10XU61rva7yv
 oJbh4I1jRiOLFVPXrb68exkyYR75rGPVElMuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416797; x=1793021597;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HX2kSuuZ/1toOSHZYGu4K1tf1QClp5RZcEQPG6vblQI=;
 b=f2WyhwNzqB4xQnGmCy1MYm9KmfHdX3U3nBzgR1LIRA4nfSI3veVrwHc2aKjKpWobxL
 xrvLY6G/VQC+haHQcGBTNdVQ8jkEcwpxeDVSV8cZAtRW0/iSNNQMePixCG4VdmKLxELb
 kubJS3DX07sQJss9MhqlZhIkLotUI9RtTpGnUkOSfpMIYtLSJSUeRngk3P9bS6twKwBN
 +lDEpsix9UhlUonoGJNdh2DZ7wjh3PaqQoq1o0p0lAOrjIV+7Wx+GzRAHjqIaz67LHj5
 EppQtItBNd0TVq9jJo0y8BJsTomdPFmz2O57T3us1OzJC2mtImSfYfRwWQTmBoVP9xiA
 F4Vg==
X-Gm-Message-State: AFq9FYIrSIdq5GoQb3sZkq9+8qzxO7ub2UA13rGlbzm3iBxnM+wE8AS/
 heHtOnNV2OaBAgT6yRY4C4E7G+o38DKZ3YY6yyZAVYr+EkoNa9R8XYXmGmHR6GCwET4P/vIU4gi
 Z5E3KBZMGDyX+RP1G43eHIK5kLDUUYUbuxSxZRcEy
X-Gm-Gg: AYBFou3fuGBv+N0njYMA8BI2Z15FqsW9TJgGtHnNlkRn8pJeorbOZ26+pRwrnn4wUxi
 fwNKZXk9y2HFGZRz6ptzwdUbvX5I9p7kn8g6wVDL4ye6klOfa6TfqzPhWfqEk2bcERrWxic+pJr
 ZdOLs4ZBwzvNUEZsaMKvreNGCtGm3nTlIUAdEB8Xp8ED1KiN0yYpJFqDAQK0Dkgny77BYchmGlL
 1ySfhhuEgTgnWy5IUoTeh+TTFvlrIE80YzwweyaR85CXZF2tgVSYTVhcU/eOnBDlugcTRZCuecP
 AqdpgZK0qpOse9rQsCCfQDMnviSwsJHBx6iCDbAqO6+muyMhkcDYgg==
X-Received: by 2002:a17:90b:1cc5:b0:3a4:acde:1e3b with SMTP id
 98e67ed59e1d1-3aceefc6164mr6133371a91.13.1792416796816; Mon, 19 Oct 2026
 06:33:16 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 15:33:10 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:37:58 -0700
MIME-Version: 1.0
In-Reply-To: <20261016-ccaione-upstream-fdt-fit-v1-1-f6286ef82364@baylibre.com>
References: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
 <20261016-ccaione-upstream-fdt-fit-v1-1-f6286ef82364@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 15:33:10 +0200
X-Gm-Features: AclHuK9AxcKHnXZ9hOej_pAsDHt5bt5AV1a8vs_Dvf0I36WNivSyvff4Gp4B_GA
Message-ID: <CAFLszTi30p-3bwLaSybBRhpBUiCVQrizjnMCKPgBHH0cRFV2vg@mail.gmail.com>
Subject: Re: [PATCH 1/5] boot: fit: tell callers when a devicetree buffer must
 be freed
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 David Lechner <dlechner@baylibre.com>, Ahmad Fatoum <a.fatoum@barebox.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
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

On 2026-10-16T08:36:59, Carlo Caione <ccaione@baylibre.com> wrote:
> boot: fit: tell callers when a devicetree buffer must be freed
>
> The FIT devicetree loader can return either data inside the FIT or a
> newly allocated buffer. Callers which only need a temporary result
> cannot tell whether it is safe to free.
>
> Report when the returned buffer must be freed. This lets the new
> fdt fit command copy the result to its chosen address without leaking
> memory or freeing part of the original FIT. Also release temporary
> allocations when they are no longer needed, including on error.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
>  boot/image-fdt.c |  3 ++-
>  boot/image-fit.c | 68 +++++++++++++++++++++++++++++++++++++++++++++-----------
>  include/image.h  |  5 ++++-
>  3 files changed, 61 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
