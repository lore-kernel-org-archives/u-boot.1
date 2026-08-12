Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03580C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 18:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A04A760757;
	Wed, 12 Aug 2026 18:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJutZq9yAFLF; Wed, 12 Aug 2026 18:57:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E37760627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786561023;
	bh=pXZASyd24b+H6+opMce7rQutculUzMcpOuMrnr4bVVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hNsO3/VS1nL2SNt0OPBFUYEOTfF84e8+KVXv8yMyRpER0X97Dp4EYRNDmvXfrEg86
	 Z56uJYlVnizTSWeX/HKy3QrYS4vNbGY3CQoQN2bNAQfjrLjcmQiB/VUxgt5uQfFhkp
	 25ag/jacWss0NHigU1+QZmuNW3mkROo82p4VLkd34FYhtRHXx1iAs94kNgtNKMZdFu
	 yuQaKO+aWYKNGTSM0kS9a21w0Bw1m7oGImegsExWgbmGON6GEv++GUnb864ENujdVQ
	 9+e+i2YNcjbX7H62VlSuMcUN0tnKE2hPTAWLkCDlpOwOE85P1SusJXfldkqOha616D
	 19Xi7RKad4Rrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E37760627;
	Wed, 12 Aug 2026 18:57:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 42FDC3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 18:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34C314056A
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 18:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhGuaTs5SFmC for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 18:57:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 61AF9403F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61AF9403F6
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61AF9403F6
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 18:57:00 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so1990190a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 11:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786561018; cv=none;
 d=google.com; s=arc-20260327;
 b=qnh+oiZcH/tD+IhoydbfCnklFM/EaSXeEFOOS2lZTuITwkcIDUmQYbSShSUlzFUYHB
 57yR60lIGBwEmH/gFZFLCr7HWVCN3VNaJoLX1Lqg76/6uUiZm2IqpL1+poXL35Yo95qY
 t4PYwrQNoWYroXiR2ga8OsFL5uW1Yyda+ry0FmfAm/c5YnyUGjP2678RRseGIL2MFsNa
 ll6ljdhBN6Orfc3nf7Mf26e31/5INVKyEg7zhk2pCtoBfpgkZYUpu05ttvU58ktTCl4Q
 vm+sHO2pFcb2eX2c1kBdZJJKn8uq1XfLK54TeTa8W/Qu8Y7xpXSH7+66WEDY28vVIItq
 +nSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pXZASyd24b+H6+opMce7rQutculUzMcpOuMrnr4bVVM=;
 fh=yvHJ89E8bUI/gr/GYgtaKLx20ktEkLgtXMsmUcQ2C5o=;
 b=WbBC52NOkL6x+OhU4frbOrY7Qe39JsB0tcYJ5+W2WRxzcoKtLzdgdQz05jINYu1FLB
 A/eAsMMkZYL31vWgWWSIjKzYM8ikJrXIUbaKUyb38vSzG200qU/nlhTEZTwi1RybtI8k
 lDwXaDx6WWhb4ae1jLK4UxfnikvgFIWQJnQz0PNuTfdJPXLvYRTN0nqMAB+fPJfkwOxy
 tQH5HXdpKsgJHMMhNAy1pP0N+M+7u6ZTbDt+MUgnoUI2ZXchJ8uNgbdNJiYXJRjMuiqY
 WowrAaU7OndirVm2LyW/op4ccDT9acmS59/vOVgZvvJWsY/rmXvmaNSMKmlr6mYk1qke
 ch8w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786561018; x=1787165818;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pXZASyd24b+H6+opMce7rQutculUzMcpOuMrnr4bVVM=;
 b=l0onEbV6JzSIn5QRjf2RmCuRbvtSxtgigTpRzrq6k9kevRWpTdLyYo1QjuJU4JvnRT
 lwTFYgjUj/lPjyw5EEqzSmLIkQzFEwdUVAYl9rtmvlLhTVVpFUZ0RTxF1+z3eD9ZRzNj
 MIwV4xcieRFCvhu8z0SPFzqHZ3+OBt9grBTpTNr8sMa7bKTfxxKDwbu677YJCwniswbF
 IUFI7gg76Xw+oaETWmmlfNdb7BrHp1ULMtmSFUnjHd6c5sXwPFt3RMQ0QBlOvb3yTcnE
 uUExFuoQ2wN2LSW10S75F1pPiJdzfSEcYJR0hgKLNqO9SLtwED+d1y3R2uyF1/tzbOcw
 tMbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKpCiTsL/PNhxqT27S+6Kx4UoDn7KJnQiTQJ0FxG+YqAwXrC6yGp6pOuu5G8BgHsKtOPGC92U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx5E141xdBOUviuSRjAFEk65wJ6pv7fBwNsGgipK+ft6JYmjnsC
 8Ar3qn+QIVh+wLZ0KwHiUtoySfwM97Zb9Ivtd9nURYgM6rmkx+pCH9lju+MHryJKiJOcjCPKOUK
 vTTKwnJ+rsWodUB+oJwmWF73ueNabjjnX/oku/7wXiLrOVI1NDpk=
X-Gm-Gg: AR+sD11nzNvImzv/IJtf+h7fzc71o388mkPyIkNfmsymQpeMyKkZbAjLX6WGDS7KpG4
 Yimr/5v1NWKMWJODn+qTr8azzbKudPfRKE7OGwrg2cJhTst0KZJA95ndxI3dB5s1e+36tBlMLn9
 cY+bDruYmBCabzgKKM5jjXblrfztL8/pUSVL1aRmry09lVY5Ii/yIM/5UZDB3qArjmdDrIKFn6I
 4BRU0XUYYzmUcqBwkmOoUH5zaxi69IQHgc41+SlgY1fVdoILre3FfMS6xQu3fS2p0NRzq+6AUI4
 DnrrNELdOS3NCBHq182QDLQ1NECG5GQKaUA0QJvrpXpydTpHxe1TRLYZ4fPX2xCfK2gQF3eJHbn
 HzA==
X-Received: by 2002:a05:6402:52da:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a3805f95c2mr41698a12.10.1786561018420; Wed, 12 Aug 2026
 11:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260810204828.2836359-1-jonas@kwiboo.se>
In-Reply-To: <20260810204828.2836359-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Aug 2026 14:56:45 -0400
X-Gm-Features: AUfX_myVs5HI2M1FsS1KMVfDUfFVol6GeYNVraFqA-Ws_Shc1txI-ma3i9333ms
Message-ID: <CAFLszTgSs8s_hFtyEFq6D0zhPKmaEQ2+gE=mqAGiR3OVTLqxyw@mail.gmail.com>
Subject: Re: [PATCH] global_data: Only include driver model fields when DM is
 enabled
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786561018; x=1787165818;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pXZASyd24b+H6+opMce7rQutculUzMcpOuMrnr4bVVM=;
 b=m6I3OA9zu6+p9SjYrS64gu51YK+ktGxjzVtVRMeVhE+/XLssF5iYLPG9dXK/4uAJgD
 1r6ruyFrN0/Rm/oThPmE3DdVTyrYdaUNtUT+AjZyOYgaHj8KIDrBD72eXsE9+1VDMJF/
 a+w06LnfVMZSuBUJccu/ZVyDqywrO9QW0O86c=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m6I3OA9z
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

On 2026-08-10T20:48:28, Jonas Karlman <jonas@kwiboo.se> wrote:
> global_data: Only include driver model fields when DM is enabled
>
> The struct list_head dmtag_list, struct udevice *dm_root, struct
> list_head uclass_root_s and struct list_head *uclass_root fields in
> struct global_data takes up 24/48 bytes of memory on ARMv7/AArch64.
> However, these fields are only used when $(PHASE_)DM is enabled.
>
> Guard driver model related fields using CONFIG_IS_ENABLED(DM) to save
> memory space when U-Boot proper is built with DM=y and xPL is built
> without xPL_DM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> include/asm-generic/global_data.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
