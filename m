Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE52606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bu+7BR1p;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HX013856
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28BF780A58;
	Sat, 31 Oct 2026 09:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HP1baqR-SR97; Sat, 31 Oct 2026 09:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6310980C26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439231;
	b=ikxwujf2W66I/mKD6Y5CnEl5bMxNL2MtlkRafyI8xNQ/rWXb1LrI4gzjuFOv5LaVv8m7
	 vL/Xra6hYghuaKZJCwpP+jYeefTS8+VSxnO4ImXrNZBBntLg26GPxk07c2WSHsU6czHlj
	 MsyFqsOYuUN3F66nmh/jlPqdaLxrN18EWavrKFEa4VDDt/JyZVzke9+J22BAOEuB9aMwW
	 1ZiwRNZY/0hIlx2osqcl363Yimvqybr7cFUc+TFDcJWmqiuOeq5O6HgiC4NvVpQWv0icT
	 Nu/3p9aoLR/BniPh5vvo7mKlNq2/zD+F9ilo/6ZHFll9VsoGHoWGENhLw9bLCeIeEQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fnK1YkUE0CttW9CDYpvRxAegTsbYWkwILH0ExlYwabA=;
	b=svg1Ef9cTYmk8YtckbuSU2nDkcXaW3rtZIu0mdPc+wYHdsG7iK+gnCSzVuI/VvlAdEhJ
	 Ehz0jh6eFgYuh2/DI4UeCs0kwRhmaENc0Jb856xFolBg1R3UXCnLCmSQ1+5LjksLpONzb
	 Odcr/3y0DQLjXcHUGW21k+ionm8nhsV9S+x5QDVgJmN1Q8jCN2cL0XtHDj0TdGQAjKeAC
	 YmNWbO77H+cofGjBzdmBajV+nD+1Swv7EOtxz57bjVeID5eWLOHrTMTOdIz+sbIEZXP3d
	 DgfU5oCrWaGMFi+J6/Ba5tS6uMos6l+/YTGQvD5Mowme8mO3wCIkz4AfnHxEGhFJ00w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439231;
	bh=fnK1YkUE0CttW9CDYpvRxAegTsbYWkwILH0ExlYwabA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bu+7BR1pVtgH0uTrwDhWLLbr+YtfBIm2FUFjJvXcw6kIM0r9XUJKHoAf/TTfIHlkH
	 jQaWnAfBIr72XH/NhiI+lDkTrSr/J2I2g2o+FSpU6Eju77r2SKB80acsp9jtxoz+ey
	 R75BFoyDXT0Tr6BBQkZETQdFU44C+PbrpQq93DJoVbvFjhoajEVMYxsaFWdtrY/QT7
	 UHh527A0rOLyYJVsckZjT5RYFDmB2G7/gwBn26qXcdybfp9yF6EUha55SWWIeMZPl0
	 4mYcE734DVTw7uDzey0o42DkpRyJc6Xkgt5LSiDMBDPg1utCsKEIJQ+pa2pX38R/kE
	 KBvQrU+viP6Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6310980C26;
	Sat, 31 Oct 2026 09:33:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85940156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7714540B60
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3c_ncGzvLe_x for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E72C940B3A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439223;
 b=SrtYrdG97b3nng4PJzwhF6+e2SnIbCJBRxYHqlzIdIN1HRp5XJ22otgNHia9x/y9JTfT
 47gG71z5yYMhKBvsmdjuy+XyKIm8Pw9AiwXAvNAAj+vtW57JoUoWNA89Z8Kgr495C0W3O
 JkaEDdV+5GFUsguPUXtlJdH/UTI0Y7kqBrpsJdB8rT1oexd6IDleo0GqI4AWOSSq97Yrj
 3I8rzojSo1w4rwcgTcALu+gOU+MNuGqo9ur+GhDUcD9QV2AQCHqlHMw1+70Za2emvlN2c
 //O4mahe0812bjhqNgKuE9PUi9XqyNKDONs9CZ5PZUXbzQ7v8qknaPByknadct/k5Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439223;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=fnK1YkUE0CttW9CDYpvRxAegTsbYWkwILH0ExlYwabA=;
 b=c5J7HQHP2upzm5lSBa3afJYEQXRdbSF4jTHpXPBfnE+lSZt9/fcDDQY4HtfSEro0s+1y
 kmltQh6Ml6tx8PikyONttPpAMYLfjQgMfpQUy90k5I1llQl+K9/lMuWmFTLWuqBxxJXsO
 iivq3qezv6zh2vKlinJJi8QO0fheR98O74UdNU4KYXKADk3tcw5ysg5BUMIEYaOK3KC3o
 p0UR9hMNR/mVnLvoZRvVuk0WXHbLlCbaCwmQWBJrZvL7mJLeLOdvxXXgfbXKad6Z4aGmC
 WnT5O7b9IpAGMuS2kLtVDzyAHm5rv7By6N47JRijXTxtsLarNFEye2YJDjHjVVtNfdw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HX013856; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=HX013856
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E72C940B3A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:42 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso8099645ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439222; cv=none;
 d=google.com; s=arc-20260327;
 b=TJMgoqoVJAX90ZyyqocUj/DwjZtNLjzMFLr0X/o1XLybj14hjdgzCiRZ/fmBAED+aT
 AiHakBhIRMzJmMMAJ5IVOpJSydtxmT76zI7dzfO/vFQ0nZSRg4zbklaT+YhRrdS/3wkC
 HT49Qm7yvxcOuNYUE9Hhp/YK1av4iU+xpzJSO5pGbjU2jWL8KxGacWiOJVjNXQArUFTg
 HRFbf2vmYgR64TV66DbI03vd9ZZB5wYUt6cw8Av2s687Rn4MCiAhhd8Jo+nhl2cCpGQT
 KX9JioPeEvM2c/lkIVtdnsjm1UQFWAp2vNyfYnsRv5krAG1eBzhx32XLnCQVyG9J6FqR
 qUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=fnK1YkUE0CttW9CDYpvRxAegTsbYWkwILH0ExlYwabA=;
 fh=JZbcgAF/i9DKz8Dm0GuOgPtAqjInhcyadPyZuz6KlCU=;
 b=XM542Lp/cd9NJ30MCIJAcX7cSPHj8LMRWhocKbE5uPzg+Zkf72D9mv7IBGTerzv3V4
 JLl+8cRRlyhWPu9grFnsVqRd59zVdId+LXkROlQ6KcI9WefmEH3kvxeIBAhR7tQ0aR0A
 2sCUe3gxBTdsr8JkyC4JxIw0bZwoM01sHiyqfG/3MzBVa6BPMFWNnDfCwtaQwq7Qio4H
 sOTN3oFcsldLtzxOFuO99LpWz5oL5yq7pyRLjr8WrQJx5oTBuBW7tlrXOcWN7NlzozaA
 nMABnHfIu7vZa6tsz0OVg7dTC+SlKmpZQA9rD+MhDqkiEcnTzDOYPFmKcGVVdJmOb/xu
 PG7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439222; x=1794044022;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fnK1YkUE0CttW9CDYpvRxAegTsbYWkwILH0ExlYwabA=;
 b=HX013856uD4tNdECgjteBBpCngKWflXgYc3TFLbpLxqAQ05v0KIopYYWQZZ+p0e/2j
 pL/fPf7q/5YSfdxL5aBimnBAAh9wfuOXTlXS6/76b3iKlR/tk090zOoQwEiGYEXCgDMc
 wJsu2NdRA3OMh6fblerpoAerUJLracTgqkkE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439222; x=1794044022;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fnK1YkUE0CttW9CDYpvRxAegTsbYWkwILH0ExlYwabA=;
 b=Y1I0ona4stbUuXr5RR1vffmEXgi6jchVTxRlAatzQgk6sHefgs8Bw2PsYEcG8tEc6l
 ViF3iaJ5EA4ktg3on+TV7/l/Nn8FiMAlM7TuOm+/Bw6zywcL+xbjSBKQT4WbB+HoUcdo
 EnTrtZpWgkuh59KTBWyJsTmefYtTuilbYCjhHtaYH+n74WWoIcHBwxnkMLHLTl4JHviV
 sTp3ZWMvDtk99nPgONFPoM6J5lzlLZvYj85LzFTOENWLc2EpNrb07bDEsYrLN0f0qXu7
 S9r7F2f03Msuj7q2/ojrs3DYE1/4UEBrq0WtQ0gwvE1WUjYRjsdKDp8k2izNHf8+Y38V
 NonQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByu6NEAkZ7RGiWMi+5+GcXdgtfAeBLNjqDMtYwK9FktK14ZnGPpwWiDwf8ZM9p16RUrFsHTQK4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKJsNGoHI6vh6s1XXIr+EpFnWbW2tIZpPaP8Zw7yB9l3dM1pE58
 IBfkBva9/Wm994wAl0muAVX44/fIcSVTuRwKNapqJ6dOu/XQgAAAfzsv9W41/nN75E7ERCRb+Rl
 qK7PmD38qzdqaW3NAKY5K/HvA4VUN/QAOf3SbPbQJ
X-Gm-Gg: AYBFou1qJrdEuLVEv4xZWZo0IhxaA+ZGxDuYCt7ZbpV+oXdvTNJpqeqKxzahAhf1Lvz
 fpxRx8n5gDr4Twx/IXaKPNyX9yr6SLKWpqtzQt7FDgNPT3S9wTQLBQn/KoLSLSeLLUnYdoLH1su
 t1SijNVN+ARfXKZZH0RN2aAz+/HNUcwCNVreQM06X4hCpbqrhg7KjGWl7pbD7B8GHU8P6p0SSkI
 56cwlmC98uxZ/U0uF2cBrQLJv3ku7Pdt+YJPC+ncA8Lx/HOdONNGR/Ta1pENJni8FrkjxSi1OY/
 e1LrIwRFvIJ/iAaYHM8b06/Atz2ptGt7oeBqnOd1S4uehGfbqtOZ9n0uSHhdy9qI7efpRNyYh3S
 WOWJwywgb6+mCgGamdl4Dpn2lncKiXYVKfjtAOpsGwHuM8hAS320r4F6uO7dAMPRcncozBDHZ2p
 pnJ26jNhblU9KsRCvw
X-Received: by 2002:a17:90b:3807:b0:3ac:9e76:aa93 with SMTP id
 98e67ed59e1d1-3ae89573cbcmr3682914a91.7.1793439221911; Sat, 31 Oct 2026
 02:33:41 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:37 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:02 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-6-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-6-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:37 -0700
X-Gm-Features: AclHuK-Eej3it0wWhc8RQlxX_LkUdFzom1TDADmRmq5guGvdcmaVwSFUwAaJBsk
Message-ID: <CAFLszThRTqArY-5yW+Ck8PT5oF91z+LZmEWQ0t-qgypKGDGVoA@mail.gmail.com>
Subject: Re: [PATCH v2 05/37] clk: rockchip: pll: Use PLL_FIXED_MODE flag on
 RK3588/RK3576 PPLL
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: pll: Use PLL_FIXED_MODE flag on RK3588/RK3576 PPLL
>
> The PPLL on RK3588 and RK3576 has no PLL mode register and cannot switch
> between slow, deep slow or normal mode.
>
> Extend ROCKCHIP_PLL_FIXED_MODE support to the pll_rk3588 type and mark
> both PPLLs with this flag. Skip mode register writes when changing rates
> and treat the PLLs as operating in normal mode when reading rates.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  arch/arm/include/asm/arch-rockchip/clock.h |  2 +-
>  drivers/clk/rockchip/clk_pll.c             | 21 +++++++++++++--------
>  drivers/clk/rockchip/clk_rk3576.c          |  3 ++-
>  drivers/clk/rockchip/clk_rk3588.c          |  3 ++-
>  4 files changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
