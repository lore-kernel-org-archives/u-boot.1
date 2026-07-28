Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7963EC531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44BC36082B;
	Tue, 28 Jul 2026 11:38:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5RawzgwIelc; Tue, 28 Jul 2026 11:38:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73BEF60817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238717;
	bh=WMIkfPaFLM2eUBMx7CZMiowx/5TDfVpyRa7TX/8MEhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ME4e4FZh8/s+SN61Nw6XI+UVDeOPkekDbQNt8hEHRpcEKc3wvnQB7l8BxCnm/goY4
	 6gVYBPdNX/4dKwUuu2lHFbGjYYXu6oTNS5sVhwo8gKrdOByTb3cKRBkSrGH6LVFLQr
	 ROYtFKtLEPLfT6t6uAhgtW0rNdg56TidMA9xGyrl9Fpya+we4fUUM8VmpWv7/pyauV
	 CRSVfFd3BChAwAP17WxxDlk/ahJc3VRNcP9QDfdrYZ/a5K86D3sTjUYhBL1GEwnbFp
	 Y1zGwtk0vPSklgTsfvJ9bA9BjgruGP+UsYExJijxhuGb6OTyDUFUUB39IZflxLrFCF
	 5KhWMSuEleYAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73BEF60817;
	Tue, 28 Jul 2026 11:38:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A377357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C62840A1F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05tnjUOzVyiI for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:38:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 231AC4099C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 231AC4099C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 231AC4099C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDBE8494B; Tue, 28 Jul 2026 13:38:33 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D54B82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:38:31 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso532157666b.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238711; cv=none;
 d=google.com; s=arc-20260327;
 b=F2ar4ZqZI2mVVGV68qV90U/WpzKepUizgZ7LWdrhMaSicVyzPVRnIizEXhp1d4oH0h
 98GJ5tQJ1rtBxr50B0ral1ZX2d14jkUFztM09jMLicPN4g0U3ZyBt8VJbVNPNsKbNanW
 PKNzia2PalXP/cWQoI9q87Thta120Ia/y2vSqFjeeTQ2Vppnkz65vyFQ0hYT3hF0vW5L
 ALx2LfBFmag1yx4VLIBD0pLfcVsef/uqlslNgzCtn4mlFWDgz3EslRcdwiayxdl2x20P
 LBNujVr7pxbxJAIATJENLGXJLUtjyn8EgYHNQxDdGo8hai2PsecMQ1Qm2A0UuckEw2XZ
 HiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WMIkfPaFLM2eUBMx7CZMiowx/5TDfVpyRa7TX/8MEhY=;
 fh=xS+HAV6RLXATwINidFWCD1DgEFGVJYhETWrPCO0LWbc=;
 b=GvsLLZta2TcKgYlAYFJ3RulqhVl0Hk1MS90ZqeIJfWlQ+8JC04IsdPqMGSnUiunPWN
 o1JXofUe7npIYrQ8qw11/TpveHRw2kG0USedGevdMAX5aBdyW+00lGegAUoBdjiy/bvj
 j8ZzBPql6r5hgejhFM30bZUuW7XsV2SVH0YSnBno/xuEW1uShEqeRezVe1wR3zzAL6yl
 BQrw7H96wup/FYVv/RcReg0Zox2cp3bOrAsh7YHkchfMTjubgZlAZ5Wk5Bp6Fj+EJ+vT
 kCvfaghWU4AdxWgMm5REi59KegiL2Is/I74nCYLpAjdnAHj3AQcajDKqMk+2BOJjSBCr
 TJQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238711; x=1785843511;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WMIkfPaFLM2eUBMx7CZMiowx/5TDfVpyRa7TX/8MEhY=;
 b=oyinGlPuf3/Rh7GK99TG4o+4jQyknES0cB2CdBN3sHd80t1TpAv1H4Zats5MhWlIsG
 ZMQtDl09+xqf2tWw5M/T6Sl08YO4VjKuKv6Tddmki2+Htm0OPLVtikU8ifaBQmMTpOTV
 ve7HlWJwHIQ2mw8XpciHe09b/MXS5+fHbZJ8uZuQ+jxRTYeYGkkNdM93q0wNXUWgj+Xg
 PX8iWPq/hfidMd/piTEJeAyRKArzaP9vnQYTn/eQi7zG6PGs2Pba7Pnd5BqlC8GVftOC
 /EyDlQ0TDyk2b3xYy0FpUafcEXo7r7fN1zccx95izQO81Swis0OpCgdAAgzordMKhumC
 uKSQ==
X-Gm-Message-State: AOJu0Ywsk0VZcylgdEbWta1hr9Ph6yFVMHXWOnL7mwofYM8uD5zpIcRt
 xj5yCYG2wQQYZWXacLmGI2YzGyzvFi7S1peqLvDkzL16saX0+cU5GmEG+bAFvKKDBmoCxKkLHC1
 Ax5Mv2X+8Nk3NN0Y+MY2nrktQvxKLaH+3UsBheFlL
X-Gm-Gg: AR+sD10DiXrwwCMrlxa6hPETaWB9xc2hKkHBlu8LdszlgOlPswiU2tJgPnXJ8jagcqS
 NC8+yyZsQDjgilXzBghNtOi9CsgpkDN0A1fBg9Obs/LK08gBKdlOkrWCHrx+iYsLjTkTsTBgvjT
 GrhLjN7h4FXUPO4Kc3HiBwTRkK0nMw1g/1wQUHpaNvVS4vpgBs9RrVfXuyKHTffrxkY1tdIDd0t
 yk4SMIy0CP1aju5cyC2iryRBEhDbOKIK2Ka668M+0YhnkEYYKjSnQ8fEEitN79gIdTL0+4=
X-Received: by 2002:a17:907:8b98:b0:c16:945:980c with SMTP id
 a640c23a62f3a-c1f7251b895mr99360266b.37.1785238710990; Tue, 28 Jul 2026
 04:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260709022904.3226038-1-james.hilliard1@gmail.com>
In-Reply-To: <20260709022904.3226038-1-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:38:19 -0600
X-Gm-Features: AUfX_mxNCfRkNGU4Q7j1H5t-nHnbQ12Fqo0BLITgd36YIXERmjYFi5lEonHtguI
Message-ID: <CAFLszTgoOWc-5_pNdPRwjzqdqF3Ga5NyEtKY9cibgMoA9NSEbQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: binman: pass KEYDIR to FIT entries
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238711; x=1785843511; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WMIkfPaFLM2eUBMx7CZMiowx/5TDfVpyRa7TX/8MEhY=;
 b=XVnWIgd9yqUZEO65hiyhQGtOOI9JdGaf/CvHhJ9mofUuB+BmGBRMCS8dbajA7W8ezV
 lYlPmq/rpalva+aqwn/NG0xNlTba3llT/SA4zqQOtIFJtyYDOXCYMl9A/GXrUhwbrapS
 HG4bRHROChMrrSsEuQquzuyyzmw73bu1qIi68=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XVnWIgd9
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="XVnWIgd9";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-09T02:29:00, James Hilliard <james.hilliard1@gmail.com> wrote:
> tools: binman: pass KEYDIR to FIT entries
>
> U-Boot's Makefile passes KEYDIR to direct mkimage invocations, but
> internal binman FIT builds only receive the generic BINMAN_INDIRS search
> path. Adding KEYDIR to BINMAN_INDIRS treats it as one more input-file
> search path: FIT entries still auto-detect a key directory from all
> include directories, so an explicit KEYDIR may not be the directory that
> gets passed to mkimage. It also makes a key-only directory part of the
> generic blob lookup path.
>
> Forward KEYDIR as a binman entry argument named keydir, matching the
> existing entry-argument mechanism used for BL31, TEE, of-list and other
> U-Boot build inputs. FIT entries use that directory directly for
> mkimage -k when fit,sign or fit,encrypt is enabled, falling back to the
> include-directory autodetection when keydir is not provided.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> Makefile                  |  1 +
>  tools/binman/binman.rst   |  5 +++++
>  tools/binman/etype/fit.py | 28 ++++++++++++++++------------
>  tools/binman/ftest.py     | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
