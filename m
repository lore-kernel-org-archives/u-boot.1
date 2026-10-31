Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10727606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nAlVj13U;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LGxzaaLL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD57740B3A;
	Sat, 31 Oct 2026 09:36:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fmmuuM_JmRU7; Sat, 31 Oct 2026 09:36:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 378DA40B5F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439408;
	b=UFwljGozTyPKIP27RDNroRRCl+I/jhtYeqCMRDKThSAfCbbk1d+hhhwvPcCEZ94aCEug
	 OTJaVgOgL4gFT2F7lRnxOqqvbNKKZxUuyCTtzk7o29akUyeooSX1+rGI5VIUyWH1w+gC4
	 FL3zVCplVS41ju3h/iEYvDDk/iQ4jOXEFrr5WeY1NdOnNkyovJXSRln+7FinZ/yxAb/Bw
	 5t3MulEo4r4I+kUEEmmzIno4IsUOF/S6mGObkksTzqCUTlK45HsfdAxKCycXSX/In0eTK
	 Vx7AGtPZAmjOLn8ErDE9pDqZiLf5UWDMesGp2KSNBOHhi8D9aVGHE9RUluC+seDYZzw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=m/DqG1pBT7Elqs6uRbjOqQBP14LxkFTbg1/rxGtTTcE=;
	b=ifB3k1XurJUJYhokgc7HAG31anjY8WcGtQUCFMUwFETqVjtmY6cZmR2bR1bHWqF9M7Za
	 Ya6j66EO6tRCrEos55HmKG9rm2MEwIHLasi4arU7NyypYPGab9Wzd82BFBbBVwzqSBV+F
	 SWDdVXafFupbw/j3bK+2/mSPycIJAfb9qssew9WbChdJz5yoCppfqoqlkAqgqsLYjehj+
	 nbUORpF6TR6Jw5k2tyb0AMDSdFoJ0/uhCF3XHzsliDBTmTKO21ueXzrdBhA7XZ8BDRfFn
	 ANWlfrclMg0PL1Gwh6aYLLCh2luh+za6pC6244606Mt1ge/NvypYnWWa/IcompZYsQA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439408;
	bh=m/DqG1pBT7Elqs6uRbjOqQBP14LxkFTbg1/rxGtTTcE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAlVj13ULDJevGnzvszVBXYWR8T0ymuweeFqN22sbA4wXrd/iBr9gm4izniXHIW+J
	 daAzB/++m89gqXMgtF7NDNXVn9v0jCF2YY75n2ZelBr1p5jQRrdL7BIDV/pfFItzSX
	 wD1LjJl4bBpkTHSkVAwNeyq1cg6cws9LCuVIkrM4PFv+9B1K9oNpw7eYsPMoOJOeiJ
	 9wC7Pgo6SChhkaiwppJjblB2HrEiVOP3Vav2WR6INM0Lkf7N54jO6edbE5r+9EoBN4
	 oZcOMBc9dgsjjGwtGFfAVrVXY9zHIFJnRBEh50yddPuJ6nPowTtvU/rA5W7Gknn/kN
	 BLKdl7lxaM2eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 378DA40B5F;
	Sat, 31 Oct 2026 09:36:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18F084BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F322A811A9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kkjV-u7oZGlT for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CBC7811E5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439379;
 b=UjxxWORv/LZFQidqoyQXtdwtdDKjlVBk2oX61Y6pg+J2fpwrf1MC1bLpNMkGcVXQPoKk
 5nq9EO/gT0tFxGanjFVga2evq8RGXMAfseE+SmT3rQwswX4hOIa5HtcoIb8ZWEOzUCYKB
 q67i1AC3XM2Yqa+YRZOvhG2bFal0Dal+SSvskzN7XyMys18JLjIX/HqEb4r3MaFXVwide
 56szTOK7I3Za4W3QVagqYcRbxlxuJYqfbDQbzzSFpxwhpuiYKCowORs78XCW3UsAlc0wf
 HAo+FJBfAmzGGoq0pJQiYo+B42RehiB648d+5cLilS5P89B4Twu3ILguR9mcshFAFKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439379;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=m/DqG1pBT7Elqs6uRbjOqQBP14LxkFTbg1/rxGtTTcE=;
 b=EqDNLNNzDV9Yh8cpFb5bpZ0HKULGHaQfX6NNJAAizAlmPqNOgIXrOgQTiH0trFEACrJj
 phKp4r9QMOl6enbS8PAvnCSUbues77P+SLsVssTzUFY6fbBvAjUcjle30+wTF3oHiC++h
 s6FeVkJ/StFvTQWl3N07VHWxUPrpO+g8v+l4Fqbb55Uta5aYIj5sk9oRglM/BvG5WyG5A
 YDYO97jMlb/moAiopT3WDe16T9LmT4PFno8G8+mF7CqIw1NN9rS9Z8idPkO1jXIxD8yIq
 vohH1xUuC5GZSlMXckC0RblVfB59xCgnWeOZbeLTVKLsAuLPT4tZlIMFvqUS1rkWoyA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LGxzaaLL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LGxzaaLL
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CBC7811E5
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:18 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c37b612635bso219318466b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439376; cv=none;
 d=google.com; s=arc-20260327;
 b=e15BKO1IvTWCg1d14VRozvSwjZQf4clwO/cMQGqGNQ/v6+AF4P22f98v/ZIcCB2QC9
 XavuvlMD8xwVSN+7WvHUBJuvixo1KoCauWBERpFfvN6aFLRvzCJGFiOX5Roj4PERfjDe
 wg/pojbHJmpQX8IYad0XCn2qpMbgYSyyXn3YlwT/bUo7ikwwqtlJh2EZjqdmAVKjzB6+
 bF6OpH8CO1FqzwTDKuluuTfebQ7Zu5CQF+z9e7PRQ9z/Bd6dTBKsbIpcj/4SHb8+p6mB
 ZTRrbt7yh0a4GLbw5ZiYKd9tcXd2lburjxkwRZofqVG8ffDIHVbsmIVnZDDu6djmLOup
 awzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=m/DqG1pBT7Elqs6uRbjOqQBP14LxkFTbg1/rxGtTTcE=;
 fh=TUJ0uzsRCza2G7RpVj7+L0Zm1zDP4wBCxYynecbJi+A=;
 b=OLIjCa2K/kzfZ1GDuno8mSgQPEz9YafsZIbcwytcZtUPqIoezf2BVJ5hnYKRnJgjJI
 rbR617nzucEr5at01q64CJhaC7l8y/9pG5CBl2fstScEycki09eebZYCvw9c5+wvC33V
 kqx1ZunQXsNglzCKqNbj0XvVwSKOlFyzN4CY8mC/VuOVA/PqME1/Gcl1KZF0kuV6bwQu
 TsE0oVgPbN+zjdI9Cs8noeGg/7bQtEBn31xZqy6tKonnEAiSIQXVBcx0e8MEwl51Cumc
 Q/MCQ86dsDmt3rjTLCuGpfgmM7TRt+zSle9xxfsBOJoQPSr5ImiYo8mUmnO6C8Urd3ZX
 LY7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439376; x=1794044176;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m/DqG1pBT7Elqs6uRbjOqQBP14LxkFTbg1/rxGtTTcE=;
 b=LGxzaaLL2GNx1LbszF9a0m2Tola7lkmvEjk/pIeFhhvejeRhoJ0bSknXEHKIxthAfZ
 IxAm7b06vy77Mc+pXpJC5LPa9UvBjPnpKRljTcN3oFJmehLz5VzacehNdKup9vt4Y9o9
 ZE9xn4aSLD2H889zHwaQLyWPlve2ediTuvIsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439376; x=1794044176;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m/DqG1pBT7Elqs6uRbjOqQBP14LxkFTbg1/rxGtTTcE=;
 b=QPZvH+v4VyZalHI2sPXiHqZ4lJZgcGfyTm3yxIByDfskJ1ltWSU5KtdNQ3E48gRPrx
 Ggsaon9xJtxrrWntWLFQVcSk1EeieeWP5b82LWiBkZgIgR2aCkDWkdWzvSYf+PoFcVzp
 Y9oQORaECcxnjVroz84Qp8/07YDc4XtBgYvFpED1myijlT0p9/M2+HBn21ZqlcWQ9Vcm
 oHrQhNzene8x86Ab9Nq2fAo3NJkzwkJ7LtA+rzZvwq+6Hrx4blxbzvmNT8WpIYdn5wHL
 PCdxhhUq5a0vlvW77HejyhFZFqxBZmQ9NHjjNlbKnRm7GiNRmr8EVYv2wZhk3O0sjJYb
 hFmA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhFyi4sK+2+fXq4KiPiFrHk+mXDWtVFIh35alexMnoXCS3GAE/QGznzT7fNwC19KcuvjLAZmY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI3BGRTFZ5XQvMuHqiXvuHmQ8SqrtcPWa9ZiukVkqm4i6vwdqWE
 OchS4K1qwgYqjq8DstHL+2pSBQcVC45fqj7S+vRqRR9HAo2TRJEyX25PyIoXykP2TlS5ExOrCeM
 99og7LCR7YbYMOP0OIqJSUjONs1NpJadeHE5jJsS7
X-Gm-Gg: AYBFou0w7GrAjCjI8q7GVe9eqpEeFeB3N53A8GfH5wNo5EIS4qdAl0tGPZqULUCYGN9
 pRzEkpsDREvISlW/mhL+HfvWwce2a1IFmaYsxQAu84ZpKB4EdDZlceS2lzaccjgMqcdqQqYOBbH
 Jwv0KKPxu3Mlkx97LTgr1QXf3Qiz2fZ5oDbYRqGolyv/li7MigXzWh7EsK4ra1MEfuaDvh2c6AC
 65G8Jb17mStI5QOx2G4V9fPy87kwjjVFs5KsP9F+DJuTDQITQceX+IneRZUNY7bUbV1s9CQGti4
 fIhCkbpbL4BqGUsHQS+SFWq0I0BBlBHH2sfzBZL4307eXAm1Mxwl7jHVJZl8HTHbI2vmEVprn9D
 DX/wVA7kUBIRLOA50kBEtLut9IeAuwTCMTGQO2efyIsYxpqG+TODJngEb5+MKtdmim4PqDh4=
X-Received: by 2002:a17:907:d9f:b0:c40:b477:dfa0 with SMTP id
 a640c23a62f3a-c4ca7a46ab6mr394540566b.18.1793439376502; Sat, 31 Oct 2026
 02:36:16 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:36:13 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-34-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-34-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:36:13 -0700
X-Gm-Features: AclHuK_LBmhDPkY4peAg-1SJ2TTpf_lMqLCj8isvA1rJgeAGGQOzS4O9KullL7M
Message-ID: <CAFLszTicOH0V+dvn=LLXOMVJsrtE62ZnCQdxfbaJ9ve4YDHfqQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/37] clk: rockchip: rk3528: Align PPLL entry in PLL
 table
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>
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
> clk: rockchip: rk3528: Align PPLL entry in PLL table
>
> Keep the PPLL entry formatted in a similar way matching the other PLL
> entries for consistency.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3528.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
