Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE65CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 079866069B;
	Mon, 19 Oct 2026 09:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 54xzIQ7GLUd8; Mon, 19 Oct 2026 09:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54A7B60740
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401308;
	b=BwaAtCHAwaysba2TkspQbNFUxdR1ZoS1ZpZyiXtMHNRttJoUKO0woit4qFQUVvOoRWl1
	 3q9OcFQfAm+GMHpwz+Ovwy2dC74iY4AdmlLa57xAtjWR62JqszbN/IUAt1nsxF9DHq4Vg
	 sTH19EztRtyzaOGkL3b+pDP9ZrvIJL5eMG8rqwxR4aMr4nC6ca3FuQxzXLUQq/AnS6JrQ
	 +Joefahovgo1QD4ctEleFkg9uBjMHja+o0jv+ViymZu+ZfXc7LQ8B4yBRON+xZHDv2sp1
	 aJws0JrUP2OI36Y8PeQEkERtAwhW3orb61yZqvL4zR8UuB5DgOa8J4RpMYmekdxrncQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p76VdKFwrPtSkysmWShrNj/eNqe4woxXPu+bid2lkCA=;
	b=aZyZmL1bkH9Oq9PFrqhw4XXSYtAAWJfzXCmiI744jQ9KngWwshhzKcQ8Suj5F4q9cAy0
	 bez3SmSyUllKXMeH7zl5qLkLx6WMyyAUa6o7gxSXmZc8Yq01UJdIpTkLJ/Ig8TcV2MsJ3
	 8ELCCcFxI/w5apuvL/tL/OEGjjNXiNITZLByAdekjb5OTxNnZpPALXFDNMryFJ/MawRyw
	 Qzh2neC8VeDcR8XGaR25DX5ZIhNoL1704iB0SFuMHz1F/95KKl6qbZcLxfi2orjKQHBbV
	 xs3ucQOPTRcT+xTa2ncHeU9pi8MaojPmEyVmpQgzDYJSrI5xYN68/9lhxxwPAl2qgiA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401308;
	bh=p76VdKFwrPtSkysmWShrNj/eNqe4woxXPu+bid2lkCA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qmwz/wUAZuTDH41V8u4pMICVdmfaD2s0cjkzp7htDEJDgTvHIbmJyqKpzICu9QpiP
	 Mmr1DxXry/fULolLCoCIye52PeA0GhTOguMx4E9xhJb03yeUIeaUqDQjhrdJXRR62s
	 cgiszxyj9j3STxt1BRcGAahyTyaHhQeGzN7ESHCbttF6YG36pPe+YPQ9bwFsKaHBQF
	 zURRPtljNdBQWdHXveREBjsjWsZCv1aRtAGD8mOi7gPKeFiI7zRn1/8YS+67bBbO+p
	 E2ZRjuPA2f+wZCFt/cn7QY/yNvV67QKqGkEBEMYBlxV/Stc2W+UQG7JFAhj7Nafw57
	 +AFHbM79KpGyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54A7B60740;
	Mon, 19 Oct 2026 09:15:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E5232A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4537480AC4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3pl7dOnlNba8 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44E3E80A8C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401305;
 b=loeeo36CcDBuc1NdDkyS/9cqhZR5ldmaBVOTMROg2CbH1mWyumUEUZwebmAv6AKhujC6
 12GmJTPLtj68XJ1BcEPfedVkLtkjLfHEI7Zyg7Z5Gb3ixrZa5apYCltg9W/LsK/RXsrF3
 dP4Qjs+Tgb32yW3tX4PDlDNXF+Ji+E7CnCY3Owu4oaNrm+Oqeve7FtSAFzR1Ufbf9scPb
 Ujc07KBPLJXUy1we8araSePc5jJhWShsIDqT1/JFOZxA8bT0zngK23V0t58X8r38JDVwF
 NMEoO6kCwc/sSR+AekhFqmQoBzjwR3OG/AErBbYPL2YudG8ZvCh8K8CjEWWVtw1El6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401305;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=p76VdKFwrPtSkysmWShrNj/eNqe4woxXPu+bid2lkCA=;
 b=Vf1eI/SUgIh/8sQ2pruvIGILKIMW9Z4tqBzHkGPxHrdbdJOfTlImybg2JNu5c7vrsPy0
 edI0m87HXGI8GvYPIh5qCnsxbtIwCXmdCXv2LyD0sq9Ze4P/Ywu2Em65kPL30QbSULnFC
 CxNjkKLsZqcVe14Lz4MJZ3g5l/X9wULIowliluKMs8WLLG3jiS2teqKLyfVdykYEwNPof
 SRPBkpJ6CcurGkmGbf4IPf48Yi52N6Zy9QNZZra7GDRvO4ka3p4zSqvrAQckF7eX3MT/T
 uCDiocy/c/A5lSslYvCg6eA9KrhqNo/O6PoCfcm37WH2uV4MpwIdhCAtXnbxtg4vV8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TkVnkjtF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TkVnkjtF
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44E3E80A8C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:04 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6aa9164072cso2407943a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401303; cv=none;
 d=google.com; s=arc-20260327;
 b=cD5qe0EhphDDZ2Kkn93Jn6Ivyl6IQ5IOQMIQOCeRPDTpsqsVbm5giTNfSYPysMVhXE
 HHMev/odzGCv48spohkuuJN+YebcSschdPyMasWYdyl8I6bIC0hAI/EgfHFkNoNLW2fq
 +zmctlvFChPvIR0abnx2GKh9xTtBJyMCVdfwo/0v9wPu97ghXbBfp24EYcGXlmw063ab
 coZK5Y1uoNnaTlB0Hl9hl6ghHbedaOVhwnZChE+aooBYwmT7fLITufTJRSTrY0qfoPvf
 n747V0MvybnM/9c4/MSMmzvJ+MsEBykStVKOs0m8Jq0ozFZWTBvQ+I9G0kS0LqMaIyK0
 RJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=p76VdKFwrPtSkysmWShrNj/eNqe4woxXPu+bid2lkCA=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=srCwhCtrmdtvFwZ6BKKdb/capk2F7OMhOaSw3vDDgiUzvWf91k3XmBPZLb8kQuFgwa
 srlG/7VcpfP0vKqErRYqe6DtUIc527iHgWPrryUVHVPuTbOHTsiGcFQ6L0piCT8z9BOX
 nPldaQ/l4CV7MQUEEGti+QTJrGAa5bRi8jReVmVVjiY7OMBV9ax4iw0rgTka27Rn3+yl
 L9DBgZVvqd8cZGZM6Toahb8vydrS9LX43qfaAfbxCgVOzPSbSb/FYggZydABqT59i4JS
 b+a/Gmf5ayd4BD8DJBLJojZS7STwBYnyf0f9PiWi+xp/Y/fFuuiMmXSqm/kLzb6yZ9on
 RkPw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401303; x=1793006103;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p76VdKFwrPtSkysmWShrNj/eNqe4woxXPu+bid2lkCA=;
 b=TkVnkjtF5xapyQzUhYBHQb0dVFgaBgb/q8CsIea62CE/l49b0SKEs93pWX66f1LBP0
 SQgH8dNR5xnwfNDlVQdMgJ6znYC2sH/zAlkJiwimnIYtepTmCo30IOC2cpKD5GtocL90
 Yh+6QWbuJZ547HpYKuypbisTCvqxBIxSaA4s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401303; x=1793006103;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p76VdKFwrPtSkysmWShrNj/eNqe4woxXPu+bid2lkCA=;
 b=GxXiYj3L9VryeEM5idZVz1i5dySAR4nPeBmIAlpMibGn6d09FaJVoB5P8bGXFxlB9k
 SYAdvHje3IzH68ui1XpINvMie7sCCLQ9VZL5X/dLfpZ77A1uFN4QakTkag9Gipwc8mVi
 Ec9l+YboUwsSvcDiPh6SyqdtCjAJY4SNxRMi0cO4Q5GTTo26qHZdl2Q2gCM7bdi9MCuL
 DJMh/KJv54cGr42sFH7MlkQ68LUuCSdxahub0dNzqMAmgycUGLuTTsG2Kmhe/iHUrQ+S
 CliG3+fHmOVzz4GB1BXebTYnrxTD7gAC8mQ1haefA4tQsPLh291jbitqdhjbkcf7WwE4
 Kn/w==
X-Gm-Message-State: AFq9FYIyU0EE9cBn/Xxd9PjFfWS8Qdwwqq9mTSbgAGTqlFHRpBLVcoi/
 PK7KfVw71wiPu3ZIOuJWih/Cgyd77BwGrcw6snCmmk1Od48AoGMv8A2UpclziRDj0ya9fimSROd
 P1v0cjHw8/7/5a57wbNuhX4iA88shudgIootkZUr4
X-Gm-Gg: AYBFou3hxmckTk046btHoO3ppV2ZXVTy9L0Jz2W5OeiTeT03GCHx4TQAdjO3if7IWYk
 j5YpERo/Wkp3JX+3cDiAVKVTBCeCPyVesyeAm1SkogjVxaAu8CbcRHTXiyRK9cns+Fj0qMJ6s+9
 T2D0vAkNC82Q9Wo5OtKQ1fa2RP+jmB6ysSBh0QucxKzGwBFqOo/a9yBjQvgO1DbzRGEa5zZGDFB
 kR3tD9lD7W5VH8vmsdlwNolDWbJNog4pz8mQpJfYPXN8o4niDP9hrJbQoz75q48tHddKfUCGBnY
 7PHEPmsQ9YCHC34TvtlAUMeuFGBrdnM3ZdOMRUwQiOXnNSYJVJzieQ==
X-Received: by 2002:a05:6402:510f:b0:6ac:c1fc:8a98 with SMTP id
 4fb4d7f45d1cf-6b3a81b86a2mr4221617a12.42.1792401302731; Mon, 19 Oct 2026
 02:15:02 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 09:15:00 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 09:07:08 -0500
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-12-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-12-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 09:15:00 +0000
X-Gm-Features: AclHuK-T1lPCT59FkSO0TigAqGcT3-mxSi-e3pCXbSDl-SP5gndSYDIN9Vz5pTo
Message-ID: <CAFLszTgeaMLMr844uXs+1=z6NJ=KqMaJXAau4iJPySBPinR7NQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] test: expo: Test setting the highlight colours
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
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

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> test: expo: Test setting the highlight colours
>
> Add expo_highlight_rgb() to check that expo_set_highlight_rgb() records
> both colours.
>
> Check that rendering a menu with a highlight leaves the video device's own
> foreground and background colours as they were.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> test/boot/expo.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
