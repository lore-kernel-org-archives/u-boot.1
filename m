Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5820606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zOGYj7O4;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KWuvS4xM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8D1E4069C;
	Mon, 26 Oct 2026 16:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYA1jzwbWN7G; Mon, 26 Oct 2026 16:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14C64406E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030839;
	b=IG8rgn08hBJibbsxLt1qJFrghRGkhwLAA3tcWPCmzWoTSXTOwCL/4FoNPJKge75/qVFL
	 Eypf7ZPWyuOkv8icnmF3om1wrfMSnQFIK0wnNIrHe0kvT3invmMAtdu5kixHkKbxVEvYA
	 JHcK4CMQSdfY+OdRslDMH8EHUW1RieXyYnI+dglCpE4Seqd9HQAC4fGg3UNgst9BleEpf
	 BdeNfaniXDoqC4PdxxpqqTXFpgbHO5gtDcSicKbMkWjo6/avl3QOURCdpjqNkSBLzUOqj
	 jTQzvI0MCgEgM15U1qSWbwMtLcQFamfFseBLGLYoBGYZ5VAqS7aJRnEAcRTvgsO9+Yw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GfwG4n8gz2snVC/o1cZbhD/n54XLzw7zOPfHrHhel9E=;
	b=ek0hRCeblpYveqz34zZPX4SubrfZoZzZtBQA5gt426E5NzH2L2hiBwhbFwq+pOFgmUzl
	 ZG9GtXH8Irw20rvJr5c3MwDOGuyOCL6SwMCeCjlfFn/02d6M2vuk4ew++T6z3rcZ49/df
	 SnlB1R+KcD0fA3bHG5tujxnusSjtoGy69/2CeqrP3nNnP+ojyUwKPVJpAOemWR6MOOsIv
	 3Md/zSKt3dZUoqQ54m68jyCb3eQOnon72ROdP2Osi+S1qrdRTrWsj3OfvD2uZ+QrADbIL
	 61dsCuHZR6jWB/KKy7KUMSxWAAnZN775dUDiONeNOE9ncg0vldVIrstWteH35xM0alA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KWuvS4xM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030839;
	bh=GfwG4n8gz2snVC/o1cZbhD/n54XLzw7zOPfHrHhel9E=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zOGYj7O4yGTTD+zpeU17p7ENFZUsyla3VeR4z6uUOo5V6B5wq8uJ7c30tP/ltJVCZ
	 WYFb9b+4oB1ECuA3BPMG82xK/M1OUTExn6ylep0Q4gdFLp0jg+7YcNHiXY+bYXc4p2
	 K1z2wQNsdj2/05NPnf4t7gFsUxULb26epc01biI2Ue+EG84BSxGJyfMRExdZGAtfRp
	 ElbiGZOD/29aZ79wabVg2YZ2pJ6K30oIuUdpsjzAgr709JfPnefmNCzEiRLR8GTrxn
	 lLCoLlmhGMrzwbTP4UeMoFgtIoX8f16dN9yDSq4gjUjfreMYEVoRnso9+5kyI9VPVT
	 6taOUjAXRO1/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14C64406E8;
	Mon, 26 Oct 2026 16:07:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E8712F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C0F0406F9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z_3WDxRcyUKJ for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF33A406E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030837;
 b=ZW3e6//OXb7N/kpQ0bs7HdZQ7NWXJcEn0j7NIWD14LfD6krq1ctLFT2uzF7tJIatYrjC
 2ePZ7Xfz5f4VJZtPRFJxanoqpq2WXuOulp4xH5fqEVqZDYMNkmTypdTDFt9sbl7TR4oQY
 r4hi2qB7qWCzb+EksotCpx6eIIZIFpeZiSEw51CVervVFgqVjOQYst+4GxH1nsVKjYRUL
 Ys54aFjNMz/BKzBQkvUmo3IvJ7dYI2K0K6eYsGEdM1C5mfrQi7YSdDBiC7uEtmlQCz7JT
 ahZd48FQ2moNk4WfEMiSv6e8+CtIJaA0Mlbom0x+ymeBoD92k28x0nrzkICkYyuMjIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030837;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=GfwG4n8gz2snVC/o1cZbhD/n54XLzw7zOPfHrHhel9E=;
 b=JOv49vu9wNH2CDPSiLPdPH2yintzDKe4nvxVrfdrPLcHoUamMQ/hv5o1pX9M5+j7wBE5
 XYS9DEMiXK2pyTmIL7nwWAE3Y3La3cZvfH4gzvfxwkqMlGjdcFTce4udCAyOGFg5jACNm
 DlglgWdlYPWFNldblHwfV195qMNohGpIJfCAyCqNcqATE1nE0ydVO9fCuJvUKZeYhBGBv
 vu7cdE5NLTuA5DB6nH11YOgNT3r6v1kGVABosR4V9pTuJrkW3f452N6NaadrqmNBIcOwW
 6CcHDgszXJzTiunwLOc/mBFS5d/8vw3lZN4DILPwm1kI/3Gt14eEMgoC7DIYjh3W3EA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KWuvS4xM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KWuvS4xM
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF33A406E8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:16 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3adc4590de4so2184943a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030836; cv=none;
 d=google.com; s=arc-20260327;
 b=a/eyx5twiGnGTi85wi8wZ3TikQ4cQLKIcIzsU6FPh0rnz8oJ8djm2jyWX/TyCqwKD3
 8D6ES6Sf+phMNMq8h+OvzNgJfTanIHqLR63rowPV1Hg6H8IirQAWxTajN27gZVtxz1D0
 5DXmYaP4rNketdIwd2aql2Hj99fQO8SHwdaoLLKEqoh7eTVPyo2WxN5gLBzS0v7QQd/K
 HA/f5MuXL+QbrbDQEqlRg5DiQwfx0Lk2J0by1dQzCu0bgGBxJQuMKh6gmaSViIQq1bO+
 hwJM4raiVGFu64a5fxap4r9dh1W46w1PwUcIXQKUWAjuvbrIN1ya+Zy4cpF9RNR3vwxv
 5oKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=GfwG4n8gz2snVC/o1cZbhD/n54XLzw7zOPfHrHhel9E=;
 fh=Vi46RdmyXd0SupGlsPtmZZi6NaJCBu3Vb80GVjkTlag=;
 b=UOZlHV9WrL/5FML8jC6u6uynXhc3ByPFWyPzeNOLqAUX/IkVWvz/nH2HEkb22CBirH
 x/OYabwyhlGwEdtTKzg/YsGaVKtaXmKPDZ/RhxKq2SSWt70z/wdJQ3lSDZCWFk6fnq3l
 O7osa8qnZ8La8lmlsvu0V/aWH8d4tZBQO7WlhluobmevfPjBNgjuckBeFX91dFGhSisl
 mG8RnSo7BCwAcDUNptybAaqDvxLUJUcGpqm5Hv4g8rZslVSEF4s8v9bHGoXwcOthU9sx
 lLjKZNymFxxp/N2VQisbIH5k7x3uUtnu5K5Yl54NRsR18oCznP+Q5KG9pGZFBN7+me4n
 qU8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793030836; x=1793635636;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GfwG4n8gz2snVC/o1cZbhD/n54XLzw7zOPfHrHhel9E=;
 b=KWuvS4xMCp2q6ycCHWhzbRgrvhONuVfGeerh/O1OoSFcqLy7bOrhPDAKQ343csAQ3w
 d6pPbm4JfY+g2JOUUtn8LRSTehF2bvMkkwgwt2PzJYb/feZioDBACclUx0o9jG9XKQ11
 YI3h35RG3GjSLJ0jYQ9jIpNaNuiTJ9TIi/Vi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030836; x=1793635636;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GfwG4n8gz2snVC/o1cZbhD/n54XLzw7zOPfHrHhel9E=;
 b=kL6JQ0QVPaD9ihhDiS0FmSfk9Gozg+tVSl4LofnUjhvcDoluq2G+9oRuhuYwdpE30o
 8IaKeBsIN8nwnI34+yITmdyCXNBm2pNRCIsD9EYJlsL4aSytp9RG2GcWcOE6xRWQbpua
 PbM4UeZI1gNFJfl4lMXtV6W1RM88fiKyD7yKv7hCxFaJ/kC1OrpBST2AlHLai4Ui7VBA
 mvTFw1zOostlZYPq9GbPsYcKQMsKYuoX32KkFH+vetZFu0ExlNtkWQooswJipyU3raYM
 D/ZwBpbnoKxvdY0Oa7xjRGvwYy/2LP9KTsCueBON+/PjgvV6Z4dNYAUEo4x/nWqLt5mQ
 eSGA==
X-Gm-Message-State: AFq9FYI0KxLV581HsO7Z2Dt42zgBaAruH0X8SlaFf2GAODq4qLmqAr6i
 jRkyOnQorfsS8DeEUvjyrHnSZKEVyc7CP+LzyxADpk7iWd+dJKgUex8Z87/MOpaSCfjklpsKVWj
 T0pUN6NMAurezv0qO4IZhCU4cBh4l9xNXTIYvWoad
X-Gm-Gg: AYBFou2D5EjWpS8A2DxwrQ8cEGzKX/eM4Asvx9qirSJ/Mw3THNdmo4GgfFgbq4QgWSM
 xPFrSyBZSYFyISbCfExuqsN1MqPGLSi7eY0m1xzpIqU1bWUZ2VGCB94GBJC1uIeSNPdvdkzhLuB
 D9p0beTbH8SM5tvHh/5bhAXJu5/YMS8t07423N/9GFcbqTh6kSHMLLcb3r1nudSUgQAWtgKH4I2
 EIaSUeMf4x3cRCvzkB0HIlcTyyO2OTSI8Rv3rCIGio/BYHG2zlM1hO6lzPURcwixW0pUXHKc0NR
 BR3c3ddcCsY154Xk+TGJYTlXk+WlyfgIR3kc/5RknqyPJGDZM+bXii7QvobBoalMf4g4xBB2DGd
 7dnHCqFybKDyk2pG/iRy6jIzPmtPlmiKSflvSItq3uWBQAx9qM1xqHMUbbQ==
X-Received: by 2002:a17:90b:5744:b0:3ab:be66:ddbe with SMTP id
 98e67ed59e1d1-3adead577e9mr6146500a91.28.1793030835959; Mon, 26 Oct 2026
 09:07:15 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:07:11 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:03:09 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-3-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
 <20261021-rinta-watchdog-gettimeout-v1-3-e7f3157b8bab@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:07:11 -0700
X-Gm-Features: AclHuK9OjZUAENnLIZbmtkXtryLe4wJ9DaeFfV0W_MuNifXKxQcnPbFSqi5JMQE
Message-ID: <CAFLszTgd1S5B_va1yhA5c0Nh3Gnv221eVxX2BwfBpeDOw5UxHg@mail.gmail.com>
Subject: Re: [PATCH 3/7] cmd: wdt: add gettimeout command
To: juuso.rinta@nokia.com
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

On 2026-10-21T08:08:13, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
> @@ -34,6 +35,9 @@ The 'wdt stop' command stops the current watchdog timer.
> +The 'wdt gettimeout' command reports current watchdog device's programmed
> +timeout value in milliseconds when supported by the driver.

It would be worth saying that the command fails if the watchdog is not
running or the driver does not support it, since scripts may rely on
the return value.

Regards,
Simon
