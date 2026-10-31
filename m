Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF1606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hYvyJeYZ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OI0T/T9j
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8156B811A7;
	Sat, 31 Oct 2026 09:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mT99C3iD7d0b; Sat, 31 Oct 2026 09:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA3598117F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439360;
	b=KyoPM0fuNcYoErwnPfXHL+Vy7jeSr4ECNbmmVSIDehVz17ziLtHLMn8lTcIC8E1nyDl7
	 dyODvoRXiQP28/dBWcrgkqXlA7KFUaKXe/ffTkpeH9mSAR+cUJHMY6uEZZZfVrL1kxU4X
	 COU8pyNID7aFQ3C+E03PJOkc0k5WW+PaSa+1x8bIgObQRf0KrIGFfBSX8b62fgk/ApHZx
	 +lygXmpWUW1JWRUdzqpucj40VRMPtTMjJv2yQxwrQRBI/2jbw/gR84388b8Y/9AvJ6Q5y
	 HmcCGlFGc9+Tjwfeif9gSFTDUjrRQ9p22raju3Z1sJ1FekGchZZJdGnkIkeuQIEiVYg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439360;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OxsOdgogGYOJy+CmCpXbcuc8oIdoi7o0Qu0b+M6MGEs=;
	b=BJLz/oCsT3tgNyk/JgzS5gnMpFoemdGuklKILIK0G+QTSP1E6YzyCOjsC0J0BE5RMm58
	 F7wsZ7KSpSoviuT0dSsZ4vMzd3BfQ9PkViW3Ha62+rJDmlMyByP6MJ71gYpM4+3ZKMM6C
	 Yi+GeIq+lovOcfMWNZAVy+rdREpOLScbpz3WXpZFA4p/aQtxOofocrPNmhX/zOfc5dMmY
	 f2avLzPmk6u/2r6PSWmHa07iAZUuwR8NmYFJeBS13UOB3gNEembK1IZ+F70DQ13wsmsZS
	 oMgtiNokBZdKAehRUPaVSXLg2vUuEcqxD/ioDb59enntnNDlYU23zrumO20gsluwzdw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="OI0T/T9j";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439360;
	bh=OxsOdgogGYOJy+CmCpXbcuc8oIdoi7o0Qu0b+M6MGEs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hYvyJeYZErCdXtA4WSw+Qiz2LwDYAwAQl2+E6YPgV7OLyI+/UinTnJv9atuBorByx
	 9x7bISSDCmPLOESWMCese7fx6kpnlBAbj2SCPZewL00dZmBg82KbwCaHWATDDMAJbQ
	 ou7lraush93N1C9YU16TAPs74kFKJKACpgw6RzPzJw8dcZ7HL6exzZt9zIMbQpOtMs
	 ls7jM6q7MvBQFPL6cOuimvMBKc1p8Aa7CpXswPF0UecgIoT4oupBZCJGjucjjxA7K6
	 e2YX/5i9DHpwAOUw3Zy5LXB8YCwNhgJ78gFpdIje5hmEjgBQEzN/BY7MQKrOWJNkkw
	 2e8GdL8tkdcVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA3598117F;
	Sat, 31 Oct 2026 09:36:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4658D2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4379E8117F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ozfwBByrgbvC for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C8F381166
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439355;
 b=fG3j+4ixCXWSuuA4ZQpR0hTHjF068DyZ/uxfEg0iP/jljk9SBA/2EVi25nEMD2+CRleb
 wFUIAPSLWwhgK1+NcZy22lETN6UbGrMlJsPtqOGqpuzG39yNRQ+yCtH2GIvZkS/oLPEDe
 ho2kAxlhz1VKt2VXZ0Wx9/wbOgQLOcQDypSpn+mSu087UHd35b/aLQqjfRMEogQkyRvBd
 o24y2nHTfdmtJc+7gBGn7lk9gizBHzSIB6jkEHEpnWI0PEKYRrhuyTc8pN9qVNAru1j8l
 bTCGbbUypcNjSVcwaOlxl+Axs005oUalMnAuR8xEWzEJnF9cS35Kg91J9wcduK0xu+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439355;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=OxsOdgogGYOJy+CmCpXbcuc8oIdoi7o0Qu0b+M6MGEs=;
 b=GctYedO2Z28UnTgqAzNmaUqPDeMQnPrc4kEDfi7LLV2rAV7vlyxxwLQvWAGvdvjoySS7
 A1dbeyG2oI/9K9/MDens1gQ74hNEjXbutkBpbOMUCFL+1niXqNO2uspt3EXHpbR77v0aE
 02z4lXvnAbTgvW8f8gsxlcfHAMlRUVkuGQT2SFo5Ju3jGc4TZgje0JvFcD2tw38Ih5NQ6
 39JpLZEnRxcsPWu0HZGdfmY5tAIQSq4orjRtdDUgZ3DBwVYPO55laUCqb/gLjiyDAKINk
 qveRdy/4babE/8a5NLQ2ybtei34xPT+IVOQPQ0m5pcu9ngtSjM6e/+Q+rZIH54niXKg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="OI0T/T9j"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OI0T/T9j
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C8F381166
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:53 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so1863485a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439352; cv=none;
 d=google.com; s=arc-20260327;
 b=RvdvVrvaA2UqLQnT4mrw5UIdpoAJKbaNqgPwhb3M8d7ohY2x+JOrp43O1GzOSdsvZw
 ZxxK/JwwR+tHjDy03DHDexkEDIGfJTMUPVE21giUnNUSRFabIvnubYaNjt0QOW8lNcoF
 9NG3QnSR/A136qMxBIoaj66z5p1jPZUaW8g6GxbJWnLnCFJk9cR7TxkP7CNVLDK2GIyy
 qNa29uh9ILSv2EJbWUpFmaRRPusOdk9PpqwPDGjfwDz2LESOlmf2tuP9WhveKH3dLrSJ
 //b//ZfzeCYjJZbNVnCDU8UwhDPoTO8EGWbeTCHepGhLTiSx4Zh28d5OffW7lPShqERK
 G4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=OxsOdgogGYOJy+CmCpXbcuc8oIdoi7o0Qu0b+M6MGEs=;
 fh=rbPpRJkof6+T1quFMhFpW6OGoKUAc6AZNne5XZsX36A=;
 b=OCDw1Nn2gQT3CN51V1vCvbkHKAGCglHjkDcEmg69ECMx+1HRUUcZFDZ/1SlCmmdipe
 h2pRWh7U26+3VtkTDf5zeWv9RWmVjB3yX/ZwbRvmO7BpYrqgUv3oLIC7seBz6AAmt+Ps
 p1gJabBuHU0S6tOHbdZDU++zLzHdHuobwTnc/EEU0XDejzpTvQxpA++gg0r1vFjWYrwI
 NyTTlljt5R6vsr/M+KXuQMcR7MRbCppAvcICSO8PDDlXyqWZaDg5Bx5fHQ2srJXfcK1I
 YChn9EUqf7TIjZtGJS4pePkQ7CMJ4Em7DRJVN+V0V9ptF39Zo7isXhN/hax4ko27PC+u
 n1qw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439352; x=1794044152;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OxsOdgogGYOJy+CmCpXbcuc8oIdoi7o0Qu0b+M6MGEs=;
 b=OI0T/T9jmqvykJShCrBJjRwEOLH/qqlTBCbZpcgPl+cFjFRT2YfqBXLWHFyeb3+HFI
 nVXztZ/6b5S88Kb6zNaTP06px3AyogmBFEr7p0tYsqB+kM4B9ZD1vyn5z0GZeKkTV2iC
 QFFnZ+EF5zr32gM/U09+GAGEdRhACjwWPykbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439352; x=1794044152;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OxsOdgogGYOJy+CmCpXbcuc8oIdoi7o0Qu0b+M6MGEs=;
 b=ZwXgZwK/RfSCqmqS8lYcaOHJAQb74Nv6xffPfI28blq6tl/K1pw3tBR9+uiA8nKlsQ
 wD8MGYeLzi5Gn3Eu+JvD7IrWwr/kM01unOEnxaWvy7CQUKaESiBLXOtG5ntIB2cfgO1w
 cKpO7xLHiXO2JqZkgSUjcw9DjnqZdeV5PcfDnXInjF3fxskPOh8mArFDziyA9LPgS2k9
 zHxTpTr1Xc91anVcn/1L2RKCNDhk4wEls5/TZtqecPLflUiCUDR6CAsqPBJLOITmIV5d
 vFuBT99wATDXMSetsWJBy2d/hkhNWZOgr/YS2dQkmN4ACm66LZUZhUUGKpJYHW8bFHgZ
 L9NQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwz9f59Q3Ca+xXHBpG1AK2CyE0hH5sCLCOI5SO9t4MYSY8UXRN09r/m9SSLNEQDeGVf/c0orpw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIhcrgnwObyX5qBQEf0IVHSzKPXUGbNHITv3uAQsNGfCDDEFi27
 DIc3PWAwRLfDy1AA9WfoLwxzAOUIhBfP/Vj3Dl67sNXVo34G8nduKfyeT9M5GbAzbWrW3c2Ofwe
 m0hQKJVREDbLSRw3sKIVpps9pXnjSQVfmwVdUt6OVMiwxRh87iUcxOA==
X-Gm-Gg: AYBFou3AfEXLFqmS7jQXRlkeERgZQLTyTw2AJmxEL1Juc1/VP0rA2rh6f+1jn3534Ox
 l5LFt81E499UvWsEtskjmi7hic1suX7rmtchy2gjl30qx4+DScAbyPcf2OI8O9zNDLd9FvOVERn
 utGeOm7wR7ToNsapcz3IhFGGzvqLdVqB1PBgc93MB4LIzMOBAUvAMxfomHmFPmqoCdAgfAEbMQj
 YuEK+LV/1xz3Q8UW2wpPyZ/JPWcpB2t0iSctxDYE5Z5z00NhpYpa7R1JuRPB7ckIgCGeFTSsiEU
 JLptJrqit+hopDEWKDCxfbaLWGO2PPlK0PFY2ROU8rkoRbU/tGMzz1eP6fKPmZ9+IpTOYuZNNFc
 nQUofpR3W5KnawWvlSxUJAAGlVA/jqqgeNeTJ63DlEtZZ6V88uWPGf4F2bmXr7Q75sOAqqyg=
X-Received: by 2002:a05:6402:44c8:b0:6b1:c34b:f1d5 with SMTP id
 4fb4d7f45d1cf-6b4d468c278mr2408485a12.18.1793439351913; Sat, 31 Oct 2026
 02:35:51 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:35:47 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:21 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-25-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-25-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:35:47 -0700
X-Gm-Features: AclHuK-I56TPLzzr-pVXYB8DwYcoerqIyTir7InSIBGk5jU3Xdn5eiKupT4HVzE
Message-ID: <CAFLszTjyzupBHuU2w+jnJmJyQieU1nqEVB41uJVvz63uN5X_Pw@mail.gmail.com>
Subject: Re: [PATCH v2 24/37] clk: rockchip: rk3576: Use correct TSADC clock
 register
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org,
 Elaine Zhang <zhangqing@rock-chips.com>
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
> clk: rockchip: rk3576: Use correct TSADC clock register
>
> Parent and divider fields for CLK_TSADC are located in CLKSEL_CON59 not
> in CLKSEL_CON58. Change to use correct CLKSEL_CON for the CLK_TSADC
> clock.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
