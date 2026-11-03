Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5F606A339
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ryq0iG13;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pSanC6Eo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C6C260611;
	Tue,  3 Nov 2026 15:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5JlXBXKkC4nD; Tue,  3 Nov 2026 15:57:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 501996069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793721422;
	b=FDL1/Iu2WS1wywzXXr3TGB+cywEYEqyGFcJK7Vi5hrbDWKVSZ+kb0jW7OZd+nasqw6qX
	 Nzk0ECoOte8J5x5+holRdeonpbFWSfs+NFYto+BMAgF1JaMltNnmtFoxSG6WMtwklBUwv
	 GBWIkC3wW8HMU4J1Qo+/EKKn9QexPBEBKmodJIr45c02yCeReDkv7c/5ogV8NqHH6Mwpu
	 75IKhomDI4kIJpTjo7bNYnoItrQDx2pA6gJGAz2Ia0YEa+tr9J8KZD0zY6P3ujvBhbEtf
	 f3pX5lyVCJKy4UtDznrRXBkN4l+MnZTSi4I/Ky+jVLYEYCH5WO7UCqmuSVv6QO4HhJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793721422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rza1PKaA3EuOE+VAZQG1ZV2LC56pCgSajgbKRhpMeA8=;
	b=steUTvCvXt2O+RF6mHLs6RwQ73FYsSPFr87QxPKJww2+bMQQDdZu8UCGadUNywClJTCz
	 gXosUKjbB/S+ypeYNt9ypcsRXYoDkvP7a8Ap0Amald324+msd0VxNHnuLecyc2/w2O/F9
	 cSYRX7sNoZYXY74g0N0DdBabejsQGgnQSIO1obvHyIq/FWUoZO8kIkiS8AIBCdQjQ5Sd2
	 QR9fn0/eA95N60Aqdsdo0yRBLEB89p4oZSNkHC+Fy6Ak41PYB5YcRojec7B6wzHABtMlU
	 9tGOCWfoUJxSFl1Tx4/xHEghVp9OmZN4IWLR8MQQ6/+B9T0f1KMzWjlTSku3KFJp7yQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793721422;
	bh=rza1PKaA3EuOE+VAZQG1ZV2LC56pCgSajgbKRhpMeA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ryq0iG13w5bM4YyFMwE5f3n9D9zCQ8n9kKLH1tr2QCmMka5b4FaocF8+lU/tE6txl
	 HGmmEH5QTzOqXGLu2bAc//zTihrZdMZGrPIe+/uDWvldH1R3Fp0pbsJT/RUqCNF71C
	 fz7oJJOPKGOb+WLIGResrQEIWf3oKjN1m2D51NV3D5pSEuU/vq7ZMZHi5yBM6OFw52
	 iA2wkUfF38Pg2hH5EqOoPfd3m8jVDndZ/Ui4mMqvRkGaWmm+a9hAzwfDe/96W79uJW
	 p6pOEz48w785WrPJiIBwgH/5SroIRwE2FqpQWfnm8BTsQRHWIuvGp+fiRK/atEaRSp
	 9hkDkU4y43cfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 501996069A;
	Tue,  3 Nov 2026 15:57:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23DBBD3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15422406DA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRCoVrp4cWKX for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FA28406FA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793721418;
 b=ZCxyX4+j4+9XUcUY2qFy68xAl9HW0Brj/OiQGMGy/YBQVOVXWOXtfkNZHp0T+Knm1+vY
 XED+qRKb9tfKdhkrI14pNx0WhGNuguOVDCLixcoQV2bdpUooN1JkfCEr92ReYv+v5CeyX
 nKrewWEmVIBw7g0dqmvt+azlef92DcA1ZLJUhcoXI+nfSVgkhXnFScO5KdLVI6pvdgXw5
 ibImjsHk7yOqwk5Aem/VLp3QAeiQILAosmLQtMLTPbymUwKecJivAsZb5Q5rAuy//CYD8
 t3wv55ksG5abPjsUuK+IIzz0Ymi0EqTJBrsazHiAxrfUy+lAu0V64se7o6e9wFq04VQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793721418;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=rza1PKaA3EuOE+VAZQG1ZV2LC56pCgSajgbKRhpMeA8=;
 b=icDbeuKUgjbObgRRxtJtiDmiH/xs05Kwkhe66ifc1DqGDweyH79loCJoygvuXzag3D6d
 woG8Q7A/UCmmiOdyfz2jaDWeI40tKpExW+9z/kt0x0YF6H6O5nHDIfeXdwZLQGhWyhNJF
 IZgJaHPrrt3djei/Q8FBxXbaCQpUzzjTHSVrCVZNnS4lWTpVDSttgD8UDgXxFQl2OZUJT
 ltP0JanDn2uDixp5mEhKLBH7lZPWqxH4mG1Ijni2nvx9+UGIJ2iOOZlJjDamm6iBMXWR/
 bLxRHsHd0CrOwGB+qQyGmXCWamogyXlS8Tt3IokREY52JhN2n02FTUkmQH4dcFtwu/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pSanC6Eo; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pSanC6Eo
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FA28406FA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:56:56 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso40990405e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793721415; x=1794326215;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rza1PKaA3EuOE+VAZQG1ZV2LC56pCgSajgbKRhpMeA8=;
 b=pSanC6EoYy38ne5l851rlCw6qr4d6g7O9TyWtErD2305qvM0TdXXkxBZBBKW2/NxJk
 I4ywQEpKLkzDXSRduu4xfM+u77sPtCLrpMQJX+Bg/DIxb/fPmyQP/0wiGvPknxOc3zGn
 0by5u1ctaHFR0WDNIhf2zJhNFg4sJw7jj+irGQXpXAIS4Y5AMA9b7692p2lkvspur50e
 2qpha/qbrxQPSkhxYoe+k62AOVHasQFybJ5lveeRACTdr11wVDKWZZU0ZSsSmccV0fAe
 HwppiRNDV3zsKJyxVsneZ/nd6ElW7+Msjvinkw4oSmEfIJKg2D/gQrRihl434Ih2yRG0
 pk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721415; x=1794326215;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rza1PKaA3EuOE+VAZQG1ZV2LC56pCgSajgbKRhpMeA8=;
 b=dWqNjCc9thIN8UctMM78UNJ38dhBSYC6zs0E2IU0YZmHOCflq2dzuo27xkPrNiz+wr
 3+gu7Qg/EaLJ3Mfck5KNAy8bhTJGZ05BqayeBXOGiceCjfv9NKZcnbEkdaJLYcxMBvAF
 g1TPCHy3e3dAa9RomVG98RTyyPRleIhQIP1ixKxZJmFvNfzagUKpX2ux8UaXvOW3+6B6
 s0E2b5abXTOc8fspInis1pAuMOMrszKaecTHnsLYoEEW03pFOp8qAzTjJhv+2+CuEn7A
 BSnX52RtG0nDqL7O+yzxyxiu+jNlurAOfy6OROAc2RvzHUqPv9aa1T+IH0B7StjtU40i
 2fJA==
X-Gm-Message-State: APuU4Z9drnLKnJAQQP6HSwxsoMtlBiTU9nUEggVWu2RY2dUfysMubG+E
 h8yP47ltQQ7+O2H2/FlS5qjhz4tJLuMEVaLdAhQBIQL/bGB4vd7VcyFxoTDwhnWxDGzGZbGMZRf
 E5ZMX
X-Gm-Gg: AYBFou3coosr/Gbb17T0z/8HttmDn0CjUHUo95y7qgcIB6uLFyNVwllHHpDkSEn/tZg
 MynWNRecvJVfpWwUJOlXXYKfLkGLgTyhEtg2ipVmHFQzTx2zd0Ks+tCQvP5iXM0hYAM2ZockgQN
 lyBMFBJXCyGpB1tkyv71Xl8761UbGYiAyIjdJxTzY0Zrg0TOUsx7hjDGN2a3k2hJB58yg6Zqexb
 ouICThw2R0l5pUQRvPd1mXGuf9llh4HQhLrjVctfuQxIXgG4By7L6g/mLmOJ/zMh1X9Hd1m+MOC
 QH7e7fRUgvMEYWybA/7n72OQdyuRGWRbKTuy8sAGxF63kJj4HSNXBAmm3zjjlR24avX/Kf+3asE
 nsOwFJv5+dsU4Hb+ngAtvYtuvUGyG0u0XDS3T42pSjygIcvDp0fAFsm4kDaEmZz/3l39jyLGGEW
 UhJ7zB0/ODf2N1lj32593wAvVRWdYam8jDQ66PnVf/hugbiKNbNFNZyYIu9AesNEtKnj2uShUe3
 ncXvGvT3ZHTIwfjFvE5JcNF9MnTreLM0fuSFRLE/11ZMRrTJV7k8KmOJSHRhwEVaOqIl6ziItHb
 USP69r0g3pR/U0NvhG1agKZfYAYPNfjRQ9LoB75Uu6LqATBI5d2qcPUw
X-Received: by 2002:a05:600c:1381:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4ac180f27cfmr327459075e9.25.1793721414781; 
 Tue, 03 Nov 2026 07:56:54 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm95362245e9.13.2026.11.03.07.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:56:54 -0800 (PST)
Message-ID: <e881705c-464a-4b6a-8b4a-61631f557cd0@baylibre.com>
Date: Tue, 3 Nov 2026 16:56:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: renesas: gen5-cm33: Start the generic counter
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261103-clegoffic-gen5-generic-counter-v2-1-09493f3c7e8c@baylibre.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Autocrypt: addr=clegoffic@baylibre.com; keydata=
 xjMEafx9bxYJKwYBBAHaRw8BAQdAtc85GIwDXLz0rh9thWXC80Lji0otVDVncXT4qaS4j1fN
 K0Nsw6ltZW50IExlIEdvZmZpYyA8Y2xlZ29mZmljQGJheWxpYnJlLmNvbT7ClgQTFgoAPhYh
 BJjMiHuM4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEH6EW4KtCh6Tt+sA/jVC35rY1npFlOy7YnncTdrID8Qf855JA78IzXgvzpGp
 AP9FkuuT80m66PP3DvgYX9kVnG17mSDKO0+v2W18v6ZgCM44BGn8fW8SCisGAQQBl1UBBQEB
 B0DMwF4u//aQyzsFlO8rPJ/cqsAuPH80IeIA3HOEo5mlVgMBCAfCfgQYFgoAJhYhBJjMiHuM
 4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsMBQkJZgGAAAoJEH6EW4KtCh6TdSgBAMDS0MiWCivt
 LjzZc9bs+P/xdXywUjDKq3lpQGJ6vZ0GAP9vI6DnN7vwVK6jt6/+0aBGkog5Ura9+WwRFEdM
 vLfPDQ==
In-Reply-To: <20261103-clegoffic-gen5-generic-counter-v2-1-09493f3c7e8c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/3/26 4:01 PM, Clément Le Goffic wrote:
> The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
> stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
> starts it before the Cortex-R52 cores are released, so their timers never
> advance and a timed wait such as a Zephyr k_sleep() blocks forever.
> 
> Only CPU in secure mode can start this counter. Zephyr on R52 has no control on
> the CPU mode so can't start it if it is in secure mode. Start it there
> in u-boot IPL.

Zephyr on R52 can't start if it is NOT in secure mode.
If it can be fixed when merging if no other comment on it. Thanks

> Program the counter frequency and enable it before any other
> initialization, through the RSIP-M alias of the counter frame.
> 
> Also fix the advertised frequency as the counter counts by H'10 every
> clock edge of its reference clock SASYNCD1_RT_MAIN (66.666667 MHz)
> 66.666667 * 16 = 1066.666667 -> 1066666667.
> 
> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
> ---
> Changes in v2:
> - Explain in the commit message why the RSIP-M U-Boot starts the counter
>   and the CONFIG_SYS_CLK_FREQ change
> - Drop the Assisted-by trailer
> - Link to v1: https://patch.msgid.link/20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com
> ---
>  board/renesas/common/gen5-cm33.c         | 14 ++++++++++++++
>  configs/r8a78000_ironhide_cm33_defconfig |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
> index f532daa16d5d..1837283c2bef 100644
> --- a/board/renesas/common/gen5-cm33.c
> +++ b/board/renesas/common/gen5-cm33.c
> @@ -58,6 +58,10 @@ DECLARE_GLOBAL_DATA_PTR;
>  #define RSIP_CTL_PROT0PS			(RSIP_CTL_BASE + 0x844)
>  #define RSIP_CTL_PROT0PS_ERR			BIT(0)
>  
> +#define CNTCR_BASE				0xbc000000
> +#define CNTCR_EN				BIT(0)
> +#define CNTFID0					(CNTCR_BASE + 0x20)
> +
>  #define SYSSS_BASE				0xc1320000
>  #define SYSSS_MODE1				(SYSSS_BASE + 0x1010)
>  #define SYSSS_MODE1_MASK			GENMASK(11, 0)
> @@ -1280,11 +1284,21 @@ static void gic720ae_init(void)
>  		writel(1, GIC720AE_GICR_VIEWR(i));	/* View 1 */
>  }
>  
> +/**
> + * generic_counter_start() - Start the generic counter shared by all cores
> + */
> +static void generic_counter_start(void)
> +{
> +	writel(CONFIG_SYS_CLK_FREQ, CNTFID0);
> +	setbits_le32(CNTCR_BASE, CNTCR_EN);
> +}
> +
>  /**
>   * mach_cpu_init() - Initialize hardware and start other cores
>   */
>  int mach_cpu_init(void)
>  {
> +	generic_counter_start();
>  	mfis_unprotect();
>  	pfc_set_avs_pinmux();
>  	mdlc_mpg_start();
> diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
> index 3f09a7c25568..37d700096ff3 100644
> --- a/configs/r8a78000_ironhide_cm33_defconfig
> +++ b/configs/r8a78000_ironhide_cm33_defconfig
> @@ -65,7 +65,7 @@ CONFIG_SIMPLE_BUS_CORRECT_RANGE=y
>  CONFIG_SKIP_RELOCATE=y
>  CONFIG_SYS_BARGSIZE=2048
>  CONFIG_SYS_BOOT_GET_CMDLINE=y
> -CONFIG_SYS_CLK_FREQ=16666666
> +CONFIG_SYS_CLK_FREQ=1066666667
>  CONFIG_SYS_FLASH_CFI=y
>  CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
>  CONFIG_SYS_FLASH_PROTECTION=y
> 
> ---
> base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
> change-id: 20261026-clegoffic-gen5-generic-counter-cd7f953b6d69
> 
> Best regards,
> --  
> Clément Le Goffic <clegoffic@baylibre.com>

