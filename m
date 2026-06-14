Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3A9CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA3483FEE;
	Sun, 14 Jun 2026 18:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KRpEG5g8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E4484105; Sun, 14 Jun 2026 18:00:16 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4968C83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69165354c87so3127354a12.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781452814; cv=none;
 d=google.com; s=arc-20240605;
 b=er+oe3kBfQSN561CKiOH4fgkSPYRECsyjMjLx33Mt2zVVJzW/3ZYWwx7YmFAfFSNiA
 i1M+iz8SBnnYNDlHxVNwQzfF1vkzH4oLIRYSvkxEccun1mma47X6vc0zIGbB8SV9lyt/
 mFtIKqtD8QjeDfcT2qMom3PlvZsda+Sk42HzoOAxHXtTvHNgPDMRnNrJCdSnzI3RXVGz
 L2YPgm3dMRWArKlCIQH35ZCpF3jMe67X0VZ/j1qbeIKLffOLSL/xYaA/sztF+ortbO7u
 z/P+5Jmie5hz7YEupuGIY1ivpG4c/9gF/HaW8ezwCYVh0jYmuTQsfhya5yinNGakqesq
 Orjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m4tQ/bprvW4himjZADrmpCX+lfWfQnJctotIkQQXIMs=;
 fh=5DvzkQXSYA0JfKNvC4+WY/n2kShyZ68z+gtBt2ADqHY=;
 b=NF5eTi+s0rLKIMTBSW5Iv0VsNpIc3DKKCcmycf+UnMPuqd/UwZnoIBcDkMII2Kdjue
 ZbvCSNq1cc1cnHeCdBSYW0g5eBlmB7LYVkAyFvQVDpGTFtphKtP0a4mLYu3DrrzF5lYD
 yJvISnZgIfycfmteKPtNJk14s6WDG7erXQHejvwt1/J15GJR6kaH/Ng2DVWzsWP1Wk4p
 MycEk1/XC+YEkUlmBNIrb3y66r8lyxzGlGg04ESVL4i7mfeNknQK18zPR1D/DpeOK8BN
 XCKV2drMoN4mAdxNPhyhPQ5vFiXpEGhsG/h1bouhRKYanpJ0xNsHo0VR8tGxT1C7UlHR
 +aug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781452814; x=1782057614; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m4tQ/bprvW4himjZADrmpCX+lfWfQnJctotIkQQXIMs=;
 b=KRpEG5g8mraHuFjnMJwNUEq/ARRDGAnnkx08fWbLdrxhhWlqiQmLUmLeniyRnhD+lj
 MXC7j40jffBF73XugaqJXAZv369ZMa6uvpkq8iwEmtUMJ3up/6Lzk4Gu8gsRzWVc+bF2
 XB7rKzpU8zh7un15hXnB+wCba272FSNXrPl4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781452814; x=1782057614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4tQ/bprvW4himjZADrmpCX+lfWfQnJctotIkQQXIMs=;
 b=gzU/HozeiMjc6SJ6KlMJXUqmnnAhxCRDmUd6nzT/Wg8W7ikG9nt1BGd9Q7+1ozokHi
 80ZVWlxDtWFt23RyktQFuPXCfZJNIAwpcoZUAKbgemWKBOD3y//7i+mPay3FZXFbV9Tf
 o684PBmyISWPXYzn5MQ1fykxrUvfesogNP7IYAiOg3LyYlomQKDaeS/vxJC/yh116Vve
 Pny9Q4FhWmX/hZJLrwq6uY5D2WiYdc6nPfLadHtmPa1PBaw5T6vWFJ4rfXWprOzHkzEq
 gA0UgtkVo5yJDxEIsxc0uBiGKeQ2oyTOufcLiUwn+E5WFaA8kl9Yw3cWzFjiwlmNoXWl
 T7gg==
X-Gm-Message-State: AOJu0YzFUbFIVLpjUMU2h+8wQs1k9Muqwz0LuX37m/LCSIh+NJVFiJTz
 nHduVYvoiv1y1/dih3eTMiPRQutPceG0+jgrp6ePSuQrvu6brm1fHDS2PVsbYhZgOGXkFPN0exH
 /ywWjlBH4ggZybwkP8NXCH9ELMErAPbjglTFPKpBAYdko+JQp1Y8=
X-Gm-Gg: Acq92OHbhSZZRzAxEp/ndG4nCCBvJRDs+lkwe6YzogoJ+sQ6p8YQ1/fUpmpt1jKPHQx
 nBYLd/msdpAPA6pbzRH1T+CiXA6Q/GahP/dhWMC1z9MiujDu7/bRsmaUPTjoRkVhscf3M/sXqi1
 4Pb5L6KavSy2L+vSvYtenV+Q666qoU7xBQET0uWKNg28ieSpQ8i645oM37teB31x+Aw2NLhWc8f
 nM2T78lwZjjxIjSgmc/01UcXknnMX+ImJQwfEwSietOcy6uFzNYyt/CHj6f2YyLmv8cubSEvV99
 4VsC1Q==
X-Received: by 2002:a05:6402:1ed2:b0:691:b0f8:f2c6 with SMTP id
 4fb4d7f45d1cf-69378a2989fmr4476062a12.17.1781452813660; Sun, 14 Jun 2026
 09:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
 <20260525132828.3348679-2-sergio.prado@e-labworks.com>
In-Reply-To: <20260525132828.3348679-2-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:00:01 -0600
X-Gm-Features: AVVi8CfKOA2O-l_jtHobrxnLEg0-T1vtTv8IPe5d0MnvPjFcWieUWGzvcSCmo4U
Message-ID: <CAFLszTin_vsHDKUopaSd-t3VRX5auXGxQ3A3+URJWuwJtCYCCw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] binman: x509_cert: document Entry_x509_cert
 properties
To: sergio.prado@e-labworks.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, xypron.glpk@gmx.de, y.moog@phytec.de, 
 afd@ti.com, quentin.schulz@cherry.de, Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-05-25T13:28:26, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: x509_cert: document Entry_x509_cert properties
>
> The Entry_x509_cert class only listed 'content' in its
> 'Properties / Entry arguments' section, even though 'keyfile',
> 'cert-ca', 'cert-revision-int' and 'sw-rev' are also read from the
> entry node and passed through to openssl.
>
> Expand the docstring so the binman documentation generated from it
> matches the actual behavior of the entry.
>
> No functional change.
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>
> tools/binman/etype/x509_cert.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
