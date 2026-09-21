Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3785C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 17:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BFCE6075F;
	Mon, 21 Sep 2026 17:21:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dpMcE3KZc6uh; Mon, 21 Sep 2026 17:21:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2EC2660743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790011271;
	b=gaFOZd3riIdsKVhhLa8+lVU/76C4Tl/azM5GL5lfgMrIZbUojEinqZyXU77xaZ4ZU5kB
	 mr/khZAmSUlQ5YkttcS6zWllC3xAxLav7YFgG42sIGrocBKFhvA2EgloZ6aNxLtDGzwDz
	 +n4hhCfkKXmDasG1JnoTkDbvvE5/QMA5yT/hXnjYn/bAjJ426HBUe62rrOqc+y49IY0WN
	 BFGts67bTsViCRLwVtQylH2KO3Ba0V1ETuICZGn0Ftbs6RjGvSxQiLPUNqBffLH29J3YM
	 G2yRolWcseQZNkpoO3y1b3dDMhXAbzMnHQwP7tPXqao6skL9HU+NllcZ1F88H6UFx7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790011271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pnUV5NheRlLmx3KaBwC1sXT5HcpUKCEi3kgtgt3qz4A=;
	b=edzOsepwyXDWzgFOvksEJet9FItNNIYiYsjBqITpSjOK2dTXG0wunT/+mYGiKPfQ1nDu
	 kNAV8kfZohwOEFVv600BdmsGTnwuvAKxkWGxEWOPXJ4zEKlH4dXPuSumkFMzXJg4Ywels
	 XD4aaaRY8K32TSooEjde2wNDKHDAPO7fGDI5LPv4dYiDbEuP5+c4D9K2nCMZGnJ/+8z/K
	 mOZJrrdHVbPGI3WG2yumLjUVm8N+t/QtAnpjHAwiY3ca0ttFW7FQ7JbaMf60vIZfjHZg/
	 fHhk2vGijSIjlu0qgqG9rTuNiTJd0v9geEhNe3T1vnuHMlhsmz/UklcDhm5373hRpuw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790011271;
	bh=pnUV5NheRlLmx3KaBwC1sXT5HcpUKCEi3kgtgt3qz4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HcYDndDw56k27tLSlCxmvQwpJ+FRrPojooSaTTNxN7+zTRKX5/OCv2DomhTC7t03O
	 dLS0Hntr62zkSGy8pQ7Xmkn3fjvp3yYqT5OjaIQNR6x6L7CwlkhzeH+Uno+0pQoxR3
	 5WoPp8W7SU/d2qyl9lBBl9RJgSa1YPEexPbz6KMr9Do+sDRRnnxEHNe3NMe0HVQKjo
	 /dZeCb/rWa7dq+65DuhT0J8McHN6Dl3Cz7BX8WcYIL3IqNHdPKaD04fWBNYl3KzPFu
	 OvAogWbzP8RnWY36aa1JB4NwtNWUBq0Ks+V+60xO1ofklBjZRWpYITsbh2H+adB3Sl
	 gUPfqTptIrU1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EC2660743;
	Mon, 21 Sep 2026 17:21:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 69E89224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67A8240AB4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:21:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dtrIrQHOo4GJ for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 17:21:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 47978407C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790011268;
 b=R91mjo2ZTrg1PYK3YHckQyfDiXVCD0dDeCOGOp363+fHdDEXwabRDEyeG68WwBoIA7/6
 cyx3A0+pyP7NaXiKxxYXpzwrEOL2nkNV6Pa+nh2entZfKL7HOXKRnEFeV9gzBysKw7g53
 vSU80NGD2Ce+oI4v7nAI5zE3MxcgBXo2RxLfofT0qpAMf9y6xR8qulYBeYXXGxLpQnBS6
 wguMOA3wTTnxlA5BLzcJs3hEI7HovfxKWZRnjFSolZEWimqRhzrfYYBv0xXM/jjnuAkRg
 U2lQz+7ph8hqVWn0fw9LfVe92wHgPCi6i5p11X6GtEoZcUlBZcgZQLAcys2A+FrhAdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790011268;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=pnUV5NheRlLmx3KaBwC1sXT5HcpUKCEi3kgtgt3qz4A=;
 b=Ol/i43aRHaz5dIl2StXAFUyO8jiXCAndGz7FZwARvfyUCvFMu3b3TPGFdZNvnbr9eUFE
 XsF4G9JgMBLL+hEn5UNcQEscuKA2+RZ3VNvRMrtCWWsXV51CsxcuD1SoZpCb2NtiJ/f8k
 BA+3K/Y1lLPI5KRfl8J6yiznOBMNY/1UENwZoyynntWSWIid+/5kne2fiLwSM/ZnNJgQO
 TmAtdPwKw/Qiy619YNa9ZpTFBXqvr1/+BDMnw7M9mpN18X2VPwyfezF8kIRNEdVynyW6X
 nMekSpXG4XrRxSYtlXZc3POdUoH6Y5OP2oggWedi+wpins2EPdA2htBjQpvlh9sPyog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="LUs/aIgM"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LUs/aIgM
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47978407C5
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:21:07 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f56039dso430832766b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 10:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790011266; cv=none;
 d=google.com; s=arc-20260327;
 b=dSGTZArLK03rDjjmap0XUU/+XchcobLfcX4iBYhc82zLsZuvCcopmJtLLFd05e0TIr
 WVJv1OCwIdf6iyMXqKYpI9rq0PXwgm7Uj7BHD4HRZM3CWEhOXzf6NuWvOvLXRM1I5B6z
 kLJjIX2RS0sCzilgRm83FC+3hXH3QuFamqV5THmGkL8sZugmL80b+MV5Eg0LvnwpUlG/
 GhpiDppsUNKKbJ8HxdLzllVx/gfkaxw4MvarNsfzDS5WXOfQ8bG+gMUYDSObTtXiQBOZ
 syt6gf9liAR8823xKkrzKcuh1GDz/SeuoB42xGndzDg2IMoPvtkpQcfONsGRffWpM3vn
 iyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pnUV5NheRlLmx3KaBwC1sXT5HcpUKCEi3kgtgt3qz4A=;
 fh=cvlbXbnSHT0OsHcDzFf7TaHU8jXL77uH8+LIt/bz72o=;
 b=PtNOEJEC1TwuL/SrDTbYGI37MhNlkg06Hp0SpUSz+/uA6SI1URxYYoh7qYN3Fhed9y
 X0MruoMr/yn0cgp2Og0FLg/U+RUcwe50ewVOE/4UJu7hw6snv/0ATjG/zVDwkqD1MmLC
 Z/X7aMnjjKjxlb3CI1yI6hJaO/M4KqXv0kJ0BztRyWBj3Gz5KS3Wgf4D8AfCf7hKDmST
 oLKrIIY28dussIT+DDWFzjbs3Ftif5yjy3NB/e/xJ4ijokyUvFeVaxfHedz3JunzQ4dc
 xvTcDUH8tJjkDZMAPfWtdN3kK8zBHwGC+D7iQ/Pd9KpSa/Jzq2ob/bsFh4E4gp9o5Epc
 gl0Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790011266; x=1790616066;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pnUV5NheRlLmx3KaBwC1sXT5HcpUKCEi3kgtgt3qz4A=;
 b=LUs/aIgMNFYZNbbe5ru6YUGGF81aUXR/hrPS+v9dWUa4v5254vPZBFjhRvi0ssGnHu
 Yu0XEfgHFvj1U77u0EcfY91GbdolSSsxJansmLmGO6k2AwcXFn6M7DgrpfpSJzP/r5jH
 lBb6wCpN7nNagtXPl9EsaqAAsrLc3nUdi53nOgpAqFW2xCpYxMXiOR/U0LrCy1r4CI0R
 w6amj7qB+cg8tPdOXmDdn7BsAudWt7nIM2L2YOa997Kf5bjEQkQNYf9KiWqK2n2mOQHg
 prIDhH7q+Zar5QrFAQWOZgQeQyFhl48CTqi5zHxJ6fU1btTMqtHpENbQ9G3xULMNXrSG
 opmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790011266; x=1790616066;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pnUV5NheRlLmx3KaBwC1sXT5HcpUKCEi3kgtgt3qz4A=;
 b=IBZJ3BE3UFWQQ1YZpOW4HMSr++B6mtSmhGUKOT4gK6yK9rKgycPwzTCfp/YMJ6r25w
 kRpAmDx1RXpLv80qhS81pHXLlwkRCFtEYNTCA4oTOJ6uUgnCKh0mqSiHgEOV4zhMJmXY
 8jvEUU5/aVNAzN4BgZyVtmQHSSWv+zYCAv5VzbOLpU+9opvYGhbTnhbGkzmBMkYw/CCG
 66lm1n47PadAtMXg06J+Nuw5SUBX8dL7lzafwalRPL0O9yL2MOGsVfpb0F4dkdJUgaJV
 UDb3gM/Cnu6/0FoDYrwu8+LF03IINDSjZjEpjXZP0jiBQDJsZyZbuzx+7pAj6BJ6JS14
 7pFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6rum86ebpQ9wXrc4uIKpt4uQ8oumwNA2Ltm7bhHwUSZHBig8Krub681zqGfjvSpG1Vl+P41Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mK9z8Ot9PU+NPQuKs8LOrntwiz4ERNQDpnwpwyLpADdHyWYkLj
 X3abzdaGvuiL+/tOW32b5IvhkO4uh0M/eLNMG9OQKc6l5FAZljXpSC7kjd7AYSbHmHIlTTdlcmG
 3yD+dpy9sa8x0FPoyzI26/Ocn6CWHvn4=
X-Gm-Gg: AYBFou1xK+O8o4jZKZKznf+DtTnZEe7T5a/ZAG1odTg6AalD4jxLeqjzJkcC8Bkam2l
 UhOSDMmoNWrC7Q/l20RLufO2o0QWrc85y8Q6q4Jc4/PbnAug/o7gLVxqPSaSBQzy7CUBYgTGS7e
 65rIfb1jbHbAUNBU4wygskRCtP7DvAXQ3thHHbEXflDNyg+ztZozzTrSJhKB4hLSrK/vk2AVQp0
 pPNOSm3V+d917Z4S/GY1qS+Xu9nZ5upd6PZVbYs+1+DqRHdOsDpCxx9XdohyI1EXiCPyau0CDij
 f/rB/HKIC1bSLhsUbU4oW2l6grLFdWuiA3IjcrMVUZhfPhGn4x6xSTMp
X-Received: by 2002:a17:907:9620:b0:c29:3821:ae6c with SMTP id
 a640c23a62f3a-c2a15b94662mr991250566b.37.1790011265670; Mon, 21 Sep 2026
 10:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
 <20260908-xpl-v1-1-58e9e5248c29@gmail.com>
 <9acad374-5f44-4e58-9689-b9da211a8909@kwiboo.se>
In-Reply-To: <9acad374-5f44-4e58-9689-b9da211a8909@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 21 Sep 2026 19:20:54 +0200
X-Gm-Features: AcwNN1W0iqSXvny_LwKTqCk_mdsFmpeNPvc37NhJlw4LLPtkNy00Jwacc1xOA34
Message-ID: <CAC928HZzPcughhSkT0s1Gv1qCkfirP48D8xTS-sE2WYBOWXa1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch: arm: rockchip: Skip needless CONFIG_TPL_BUILD
 check
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@jo-so.de>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 u-boot@lists.u-boot-project.org
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

Hi Jonas,

Il giorno dom 20 set 2026 alle ore 17:55 Jonas Karlman ha scritto:
>
> Hi Massimo,
>
> On 9/8/2026 7:04 PM, Massimo Pegorer wrote:
> > Just check that CONFIG_XPL_BUILD is not set to select files for U-Boot
> > proper build. Indeed, CONFIG_TPL_BUILD being set implies by design that
> > CONFIG_XPL_BUILD is set too, therefore CONFIG_XPL_BUILD not set implies
> > that CONFIG_TPL_BUILD is not set either, making its check needless.
> >
> > Fixes: bef9fdbed2e5 ("arch: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD")
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >  arch/arm/mach-rockchip/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > index d3bc0689f89..8148816c48c 100644
> > --- a/arch/arm/mach-rockchip/Makefile
> > +++ b/arch/arm/mach-rockchip/Makefile
> > @@ -15,7 +15,7 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o spl_common.o
> >
> >  obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o spl_common.o
> >
> > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > +ifeq ($(CONFIG_XPL_BUILD),)
>
> This and next patch seem to match my patch at [1] :-)

Absolutely. Sorry, please ignore my series.
I look forward to your v2. Thanks.

Regards,
Massimo

>
> [1] https://patch.msgid.link/20260708220540.3368825-2-jonas@kwiboo.se/
>
> Regards,
> Jonas
>
> >
> >  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> >
>
