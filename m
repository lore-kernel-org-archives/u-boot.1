Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB716606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d9xq86gt;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TWi5xS+t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89C3D60AFD;
	Sat, 31 Oct 2026 09:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qohq3-m1UOde; Sat, 31 Oct 2026 09:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D851560AE5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439412;
	b=PAYYijAfHwHneMPiihzD1pv+JfIufV2yZEV3kBb6isfCYdg3eUlf5KjGDVB6kvv7+eMW
	 gY0Z10QE7F2DQP8C2SlL2SCuPdtWmdCGl0oe4UdjJ0QUXSKxUL25H3SO+H7LWbDI/8gtN
	 Nk0B/zdPjcr8EqPNwwHuvh6KFuD7zc3jJKOX2hXkZ2wOw/01bXMMcBmniNzB6dajdRNGt
	 SKfCaBoeLLObBsrdIf6hGHtC46slmc+VmNtP9lvo5N4c28P3NQJei1PLrKyoF+zDboF5g
	 dZXJzvoITMfi+rwnERFcL75ieGdVbUQG/IWpL2DfWtuJJ/cgdVpgp+vAfclXb6POG9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2oWDaXTuv89DmvbbUR0+u33P11VvIkTR4p9Ca0CbLSI=;
	b=opI5MchdUBL+dGc7n9vkYc2O3TetIPhc+SYry2VJ7aJrqj8JKg+lws+BS5/+Xlo9t+O/
	 VWt2EsMGqZmMF0Cr5dEOqY7CUb+//JS8lbqwfy2vNXsJFbEtz+CcxaH8ed7IktWWccv9d
	 s0h0Yh/tEyTxbX8wo4wKfYb2iO0bPOJOYYkCJIvrV21iedDQLXLOozGwl0JK1nxbGZmPW
	 rvfnpoj6nN2wtGrZ2JCsY5dH9v+Jy1pL6w8hBIlKRCqIA7JgSBPKOLswxdUaeXPpfGB9R
	 R4xIx2PAZCI4eNUzexMd1Qhi2XxV5MyNEG4pfEVkHjTzM1vZLFGsCYNTfoN1AyFQVcw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TWi5xS+t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439412;
	bh=2oWDaXTuv89DmvbbUR0+u33P11VvIkTR4p9Ca0CbLSI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d9xq86gtbCuVnoS4bvqAXgBJ+gY0i7YppEElKKpgafZn8xALmRWNjYHerGPNab10w
	 Lhx8Z+MFoAICIctVWUsPEbrQ29KI1lOieU1kgOwhXxceoj+8ltOr2+O4EAGERUDSLY
	 tmBPL9V/QlcHmPSq3c42wA0ogNG9ZdzI5qtv5i+1QiHFJPOXb+SENoKL3lrQK/N3kw
	 6w9qFg0k3T2A61hG4XUz7lCcHJs5kX+YyVBzZgT9sWXbhI4BJEo9tViNnebY8goY5H
	 rfFSbFv/aZYx+N7S+sKeY4PTBqwutW7tNCRYpaCnPvVgubbT1U1UhZf/f6PRxIyW7t
	 +AutP0S5VSOyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D851560AE5;
	Sat, 31 Oct 2026 09:36:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 630FC2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 490F360AED
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36MzkTCLHAWt for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A7F560B0A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439382;
 b=dvoFQI7uWFVyYsSa3gMG/dATDyU0Py+fRrlxK4wvM1sTLGz/Z4xxU87bWVIVaNy0kD0T
 ZnBRGUfpBIJJnFfha7LkqnBy+jXI/GeC18BExada3YYjJvTtftkxSwfH5phqYHLvyTjZO
 SWfdlPwrtDnu+h4vWs3C46bLogsDhVouFFmfOjCnylfd+0T3BRkz1QPNX5eLLQLcW5EMG
 heW/3UjXJ4JgkeN242XmiCy2oAfmK2BRFHF8DF7y2stiTzxLq2RZJrHU7hXpv8JikfqB+
 2OnH1TfUhaVAxZuZQAvePiVQgWqvtyUuGG/lIVOp8pxk9BXeBnInA0BZlsm1+dQLrDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439382;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=2oWDaXTuv89DmvbbUR0+u33P11VvIkTR4p9Ca0CbLSI=;
 b=O7EeJRQfMn3P5TmxLRNcQNsV0yU1Yb59lYeGQv8jJRfg7DYn+tAxC3f7mZLXr1sd3T9a
 Tzf7nUo0NSA4w6A28hZP3d5Q6nvwyP8glaTdyXXQrSzbm6tUcTtjyK5Ywx/crYrcCrIOC
 VT/eBeEIqObDewBMsFQPh6vFyHN1VnCzUQ/s4PT+CibEuctYk01i0Q0RjZcWDGOcJgYFB
 hQyShPDyfWuPqasiLb44OmYH8x7YmkquWcG+Huyxe25OXxT2ScIMxo50rGGVGxDMjYUga
 6xrOxIURlyBQCPZayJexeifPuLYD9UGES7YBCJkfvZ6wNhagLNDIVfd6NdxCTpei04Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TWi5xS+t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TWi5xS+t
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A7F560B0A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:21 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b4a13789b0so2060665a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439380; cv=none;
 d=google.com; s=arc-20260327;
 b=j2VuQRU/glOJqNkcYWPEfiB78DjEVphweGta9ij60uN7y3xW3aFhLz1648T7A+hitR
 nKSPMYhyjaCMh8KLT+dh7Ur9j2iDeYbaale1+qUvqOgZNapyJLAQJG2RifA3odNtZG7E
 9LRPM0G4D6koOR3qKKZyV/lxxTml7ru4fg8GAJANAF05kFPgBesDVwiIWJgyFBh2X2cM
 A45rZ4nc5jO1tanrl58AUPCGqeHX871LQkHFK3R9PLwJT+TZ34Bpt7ZviGiWL9m4Bv3U
 4/bgU4YJtsSreSoozPOWBq3VarTXek1Cp3FUaTlIafIlfKstkJc5eP8vq9h8bW+H5dGG
 vOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=2oWDaXTuv89DmvbbUR0+u33P11VvIkTR4p9Ca0CbLSI=;
 fh=P8sFMhgUXmXaoG2Yip86dVI9Hbp5oXpFi+PU/ghhi1M=;
 b=YbfIK1HuA66UsQvSNHvVTWgsC5Oe7xgEfmtd9fg4oQLi19oi3ul0dwK4n9eaCmjita
 5qmTUuLuMj1nUef6XisBvlXibxIm1RsCNsjFVf6FVBOsfinIhrWlWxR16nqgZ9tW60T8
 2xtowNVF+ZTcTZn2bJWD9m0/JnbRXD36YrV3ufR7cKCfcTIpOORoxTaMlQkZq2r2Yrfn
 sGsrUgHj+r6gA0hce0Rebb5SvCS1w71d29ubmJkEbfsgFJ2u8qyJ2zGWMqvfNL64k/5B
 JvvqToD2j1NQvj9JAhjbCsqQsavrfg/XEBllDdYSDrKPUOS4QEwKe2Ij/h9q6EWxXmWr
 rRDg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439380; x=1794044180;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2oWDaXTuv89DmvbbUR0+u33P11VvIkTR4p9Ca0CbLSI=;
 b=TWi5xS+tj+alGSH4gUnyg2tZGKjRt0uADvBGq6WdLE8cG8j8BqekttbWGVfKKl4K5D
 oQ2TQBsy8Beq8fCvP4n5yl+aYwz/16IcdelPCQfhxRbLAuE0tKP/ZZ/75/5T58fAgZYL
 bqR8/5LXlpWzm9oYnIiFb9ozIy/VNk8Km8jjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439380; x=1794044180;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2oWDaXTuv89DmvbbUR0+u33P11VvIkTR4p9Ca0CbLSI=;
 b=tPhPBJjXJTgjdSthfEbjK5bnTN8oTTckazRiyL4GsO20byR7pmwbhhD8rU/liB6msQ
 gIzTxTVe4mPP/XGEylLXxgcvL+FS4Or2n5cv8y5ItqgH5zKFOYQpzBrGq331ffkf4c4/
 ij6gSt18XWBK+WJN6Qfs1sOjV2YC92xnE8GFgdS60lzuathmoFpx9OHhroxTT8argVdA
 +eNI6bIbwoBqcJSzPyEwNwaCYtxP9G/lzUfmMc00BtowfvEIrIrEvmK/UbD8EVoUmX2i
 PigVs1tqRVfSe897+Cp9YvqpHYyCfPNQhOVghV+2BJ5UeQXgRQ4Dnn/uBw7TMfseMNiE
 Kamw==
X-Forwarded-Encrypted: i=1;
 AKwUvByYoQZ7SK9kvakXCPL4mDR/x4RKQfZz5iLnLdTE08SnZs9366gonDHBKaomZfvet8KgBy8QsJA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI1fgUC/niD6VJpT0nslJSy1WxFWdL8s7FyMdtGPMrPX0EQq+20
 CD0FZyxfS2hKF0A85VoY3B0W9CWW8/RaExnU3gDHsgSBziIpTVGIK20bnuVCfbAIc8YvDnpTcOe
 IwPzJ+jOuSFnFxWh2ptgIUsCNs43EY03NbAGhJK+F
X-Gm-Gg: AYBFou3nQ0Z7q0n3I/20pDh42tTNdApLDWdf4pnNgzU0aB83alpODLNc8nArjZ93pXj
 X9F9h3KZKWLvYLO4D9ZtU89MLSwa2bnRiirMh5vcllnRl1CPgBjuc94N9UKmWWrZug5exT55hXL
 jeI6KM92RWyLpQePQYG4jtdqj2EV9h89jps6q+58kig8bXLwG7c+iLJp5F0UGoIf/1GpSInhLwz
 onyiWFCJVK2G+GY68DeSB7KRafGh5uKU8Cb6czaEzcTNY6t0996aQwhHSYMoraMn38yrddhUpHg
 dk3WasW78z2mhq9SaBe0e0KMNODz3yZmiDLtugj97aUlaB+hJbSh/Q6FahnYGwZR+MeiyCzBfEZ
 82I4+iJ5joFYTe+2NeNZfUvrUJ4TdbkSQVytY4qFWZdmDueGcPPfshZFmoQh+8jrw4Vpj5n+3
X-Received: by 2002:a05:6402:2048:b0:6b3:886f:1f0c with SMTP id
 4fb4d7f45d1cf-6b4b0c2de6dmr4108293a12.20.1793439379898; Sat, 31 Oct 2026
 02:36:19 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 05:36:18 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:32 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-35-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-35-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 05:36:18 -0400
X-Gm-Features: AclHuK9wwmRrUMsjkQkhbUN7I82YHDq3ZXDqQAM9rYFF0e4H61VGpmY6qGrEaCc
Message-ID: <CAFLszTj2WUDTpBKGy2Wk2Jvb9vUATonSoLBreh6FG0YH7cQVig@mail.gmail.com>
Subject: Re: [PATCH v2 34/37] clk: rockchip: rk3506: Return correct rate for
 CLK_I2C0 and CLK_I2C1
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3506: Return correct rate for CLK_I2C0 and CLK_I2C1
>
> The getter for CLK_I2C0 and CLK_I2C1 both fall through and instead
> return the rate for CLK_I2C2.
>
> Add the missing breaks so correct rate is returned for affected clocks.
>
> Fixes: fbf72dce915a ("clk: rockchip: Add support for RK3506")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3506.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
