Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4240F34C5F
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E356C84198;
	Mon, 13 Apr 2026 16:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X6BsY4XU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A283284242; Mon, 13 Apr 2026 16:58:44 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C202883DC9
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9c603ec2dfso592288366b.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092322; cv=none;
 d=google.com; s=arc-20240605;
 b=UcCOrXo7rjHGRjO743D7mV6vi0JJNYK4nx1IFZCv8rKrRyeSSvIO5rW3AwSyEn0Fin
 /c+yf+mZuh2XSSgnRYQKqUEWDf4KPeFT8Veo0dbiu1QxzP/Xeilw8qxzr4pD5l3s7hRf
 S6uKxwWzeOYQqiJxMWD4Fum3E9aTPAB14zCjGV+C+V3bT6CS1VtS8M3eKCm6o0BSGEWt
 /bS8f1hVqwu7dcsWvXc7iShnxnJ6wDGt79nZhRB0ojKuZN1LthWGQOwBzB9uL1oAHQD4
 zeHMFLaS60yjh9XAJ+HXWZJzixi2os8tsKBPpSEvXoDQYNwnM9CGoUAxEoo5DrAFeLAY
 ESpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wLjIA4fpYAenbwDKeIjEZgnHEad0fFNSN6lNdrWuTe0=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=VBeRX9GKhiA0P6MUj/IyC/6yzesvJGLyeF8QzWpwJhLEYSS42YVcysDYxyOY6nNf6Y
 zfepTe/ch9Ouxuzyb91VwaYoCdeGmjVA2SyO1lUCNZPnQlE4L+DCSrLz9zFTU1Z2zjX5
 4HJehnsnuxie1aRaKUuZqjJNWvQd8uofJPhSTaPaCSUzwLcv62VLp2T3IoYhMiBH+q2m
 QkcbsBmgA/KfHZXsRaX7O4rdhWi5xzP7Vx+opxnVsIlyanhzAmv5bs8obEc+8T+ZpM2u
 sCvbyc359UClUEW/9LIXZO75hsYODVzZBO7M1MWEbyUMtMTjgTrs0/Ct1jYxmh5gdqcp
 AaYA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092322; x=1776697122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wLjIA4fpYAenbwDKeIjEZgnHEad0fFNSN6lNdrWuTe0=;
 b=X6BsY4XUHpjrYJkpLBMHYuRFwIvciQ/SNE7Xy2M6EKKZ2GEp+gog9hECUnanV8BPYl
 juiVgE/09vj20nAy7lXBIHWxWyNDK9V1SC7hLdXzrcrzm0e+K47+9Q05XvdTNc3ct1sP
 NKLqtvaGbiEyyOJRff0tVvjRplQ+7lQIICE8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092322; x=1776697122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLjIA4fpYAenbwDKeIjEZgnHEad0fFNSN6lNdrWuTe0=;
 b=pgm+qyRfOctRz9JoOYQyfRpXUcYWiB7ZL2UpMZDLPOFsllsfORuPiNI7PB7AVeNdTc
 l0QA4AKyTSPplzeqX4WJOlSjJC1pr97xVL2afFutCx+3E1mnG0qyEioaGVX0miTwb7FC
 THgHq2CeEpIrYu00cuF2PehrQa/vOLsEA52iCDRbJs2dIJ38z81unpQHB7LphL1Sqrkr
 9aC+55tRC0X7wKeTBMJKzNPraaX4JVTjJ/NLVay8458YJqsfHR5PN3j8yCFmW50p726N
 Fb1276RrL1tP15YEHbvnVsDBGDn2zbCGy9THqJJEcIQl+FAh4c1iK2gOj6d9EInroKxp
 njag==
X-Gm-Message-State: AOJu0YwLpI1tOpz0dG1Hnq9P5iTjfUXAofhz/Th8rPVcainAH6p9XOvW
 omqkJTAD1Lb/h/7KEgv641m+Kmr0ckKDmkmxdiq1FJCy9lv8EEzwKRkKBWEHTBCnJ/0JQ1UyJ94
 mMKksk1nmMVcKVnJZT5p8rlQS7ojMe3vCaJZ28Bql
X-Gm-Gg: AeBDievZC+OD0315HbGoS4vGAvanzFrqvtAyQzdw0pdAEEq8HFwYxcv5OERsP3V15Lq
 qMUH/s/oyYzJKunfi/Vu7rFAlz1qSn0e81NX6P6GobOWOBKZFTMfeH0Ct3K0yqWnpzQQIL8lmxx
 nnRky5MsDSG5+tW7cHf42Qz8towEW4iGbvbaoIi+t3nz1Ktu48D2qvP5qjMTy+C2AjrkPX/QXPt
 YuDWaFP7Xbj/KVs/JpmANSUwwT916v5HwQh75K05aNdVtz5cP7x37TazQuwC+QJytENfOp5CxKM
 NdqJ9Q==
X-Received: by 2002:a17:907:e981:b0:b97:1d24:bfed with SMTP id
 a640c23a62f3a-b9d72991f8dmr775694566b.41.1776092322249; Mon, 13 Apr 2026
 07:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
 <20260412195947.1982729-7-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-7-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:57:24 -0600
X-Gm-Features: AQROBzAK0RNMoV9t97aU-Wcz25-WMTp9X9HpDGc1Gw2P-hHxK6Z01Jlh-FljIGg
Message-ID: <CAFLszTg4KvfDegPHUzS17Qw3kqdb+ZJp_54-DRHAFw6jxG+L-g@mail.gmail.com>
Subject: Re: [PATCH 6/8] lib/hashtable.c: use memdup_nul() in himport_r
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
> lib/hashtable.c: use memdup_nul() in himport_r
>
> We have memdup_nul() for exactly this pattern of duplicating a block
> of memory and ensuring there's a nul byte after the copy.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> lib/hashtable.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
