Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C08606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UuZzfAxD;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OtuLAjHS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9102D81173;
	Sat, 31 Oct 2026 09:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hmnryUrHlqvr; Sat, 31 Oct 2026 09:34:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEC5381174
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439247;
	b=qO6fATWdHEo0w3R6L7I9+uZlk0Zsd3dUU1jUOmFWHQZ7GVtxotokYhGZH02ZTkYo0RG2
	 7Npq/dUbPbbaK6G3JiiYSEqwX43lzmMLwrm+z5bAulGQ5vITSGj1NPaZAmXMEk4zAEg9J
	 ttMSgiclU5ifjfeFMkQnC3+uFO5WJboJWMPYGmCSvQRebh58S6TMHUix5QkbR6AKQckTz
	 PA9Qr8lAplJvD/dd3ABHaIt/ma+pu4fB8XyaMg0HmHdeuZ2qSyMh6RUiRgC7qug3T89VF
	 5BnFUQgiOvg0X3g370CL9TlISjaWgA7co8vPmJGGMDVxJPmtub65dCX7zxF3jT6eioA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=b7yywTxzPu0nNdyQhFAjrE5gLi+fulltRPzpgI5s06k=;
	b=pPJ6K97DkH8K/wQsmrpCj4IWQzHXVyjAjpBUfsyvq5WLtOqhUwiK9VE+SM65BvcLl5l4
	 rV/pSjgGO32UXrPFiL/XwSfD0NEXUHVWv2ZZbj+R/v4PzhmvDyI49N4K3B2ROkKEhXc0Q
	 64EtqNvuyrtj0yqdfbMMXfSuSL+4DjJVtLLkfVt4wa65cpouYfNearEKd4VAGXOz0BdFi
	 PXqHcUAnmpbq4W8dFbI+O9pJguPq0OszeW8fOPyGNlBgHRhAPRNwHdUVSzLjFiKdHqFaT
	 XcvP4PwfrGVxr9Ivc7mS5acY7eKKUjmfSTftGogzfWCsxV5bBREIIXUC/8QMBvPewiQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439247;
	bh=b7yywTxzPu0nNdyQhFAjrE5gLi+fulltRPzpgI5s06k=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UuZzfAxD/FAbVUpXt7OtPZiRvCdN+i51MqbG5oWzXdVlmvlNmFUzjFABc5Y51nZrw
	 eBrI+cp+tiXIa72UyWPQS2r+a7lc97kKAMNAU3v6iziDwaTm0DC8XsFAUPZskBoXxv
	 jz256WCqUptrVP3H0lwZQhY32tmvNfukK4kAyeZ6hxtRHEFM44OD6Mp7w54c/Xl2Fi
	 ekxzb/BitPjQNaw66NJBAi8AK9vrj0YmO5yFlipZ5RsbMrswj7NtggK8X/HlQymWbs
	 4S0EkW1W0ahyC+/JOSBZHLpHR4t0la28PBN4gbKzxLXWG4bjrBFMc3p6F4VPWfzy2+
	 oJgAkXly17W6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEC5381174;
	Sat, 31 Oct 2026 09:34:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27773156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15CAB60A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Weq-usaoZKIM for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8875960ABD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439240;
 b=l5BPIV4QZ7cybYWgDFcSmsjA9HJ6EDGEVuUWtu7pr2zauZvMuRLhNbaE1vkIN2fmDHfI
 aYSf6aOlNSY9nfSA6POJdaRwDoLev3JppjIscNUNkajC2G5SeGOn76i5cpgjPARvPwc69
 OstpzFUO2mXIwepVk7FJ01b03XHWysJHhozuEl306p5wtMkTgoD17DQkpf30COsMgaA0T
 8jao+1z1obx9yKcso65IPC6RO62gIpxCvVEXOezSJkPMojGTq06y4JOiIPoXvRjhdZJP/
 CPoHp5Erkoi/hzQT44GGgiJ55L9OnzmHPuSG26ytCdsdIGtSq026j3PPCWJiilRkGxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439240;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=b7yywTxzPu0nNdyQhFAjrE5gLi+fulltRPzpgI5s06k=;
 b=fU29fVIy09dhFYUFwXRcZNxABUzW9wSjkMtuR1Vc2TsJ8d3XB0BdhP0YKDrG6pp0O+Zz
 1NBTOfyK4QU0JFBzdFxa1i1ZHdDP+eIKC0kP7H9jJjb6ERbvnQlHRyyNKZ1x3i/S4Wf0f
 CNvZ4Ky7RYgWLHRBelsiq7ZDaExKzXjQ5T1GOjFooNbW76wwBQ/Bs1WJGmmUOvfgM026v
 DbD2zSw++mZgUygn5K4W+hvdIcCW9knJ6dPJw78DLfauhhL8eXfXSJGdIuDWO0pbUma58
 uLBTnHryspc2sCEO2lHzhUYWhInjXxDUeLrGPIxsewN1lYbbemDw7NlNk5fVtSHv5Kg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OtuLAjHS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OtuLAjHS
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8875960ABD
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:00 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso765965a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439239; cv=none;
 d=google.com; s=arc-20260327;
 b=ftv9XYeFZtZSrWggA1afgtm6spMcrKV/7gwyza+vJT8BmdKjq2WDP1Dxk46C+bUc6L
 Vgf50f5fEXMH96YDz1bG6QyS/oGac6aWFQhbeWwVQmU3mdCTnN2B6dR6/G2zuViUqeSS
 s8gDNDKmzXV4eVaJikMLT0O6cTG1nKktZ+/9wr3O0CwXyuz34BHdK7W5bHukV0DiQNZ4
 eR8hV8jIQiPLj8Fdab2WpRJiB0KWZzKg2vtgnxPnHS2UUbwHua24mfzASGoS7hSAcTxC
 F9XgV9p9nfdvyyXxm+FPLndvj+deLGphRKwlUV4Mr5tcf1cUsx5QtGI+IangJCimIjWa
 SIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=b7yywTxzPu0nNdyQhFAjrE5gLi+fulltRPzpgI5s06k=;
 fh=UP5pjC1c8SaHOQ9QYJfujNN8mKcjhTCwxy+qBx1sd74=;
 b=cbY0OKwdKHui/XBrAfDN0ieB0M4/fOlOAe6GrI/6lW6KGgzBh5qlW60SFvbXsPuWv/
 hwSV3XqFRbG/uwHniwUptIB1ZSLSdEGGhPL6I+1KMX20bmzCMPf0KHxyZicgSwNa63Lz
 D3KliRadhLZrC0D0sD3klQDRdXu8SZ/yajbLLr5cVyCF4TrQ4yArlESIf2MMKCmZxZVk
 +dL79qu1WRfNN1iserW/ofspyblJrXLK71QlenwpWB1ZT1Sg8Jiwy9vqnJTSF9GqB2GD
 u5n8ZVHyDlWq4Kqe54+l0Wx8uhpe36E50jE8s1auGdk/Q/xZmyPePC35fvvQEtR1LuLg
 FaUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439239; x=1794044039;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b7yywTxzPu0nNdyQhFAjrE5gLi+fulltRPzpgI5s06k=;
 b=OtuLAjHS3BYud0USmh+xaj8SMGugCSuof5CtPdJvAC1wUTfwxkTeOsEneJuJj5X52Z
 wav+zrvdwZkYK5UuK/7F06agfbl8qBmbUtkZw8G150tr4LNE5r79MvjHo2KAa+rHM1oG
 Gc3VF8FVTchwBPHRAtdGqG07RC+raBbChvE+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439239; x=1794044039;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b7yywTxzPu0nNdyQhFAjrE5gLi+fulltRPzpgI5s06k=;
 b=YOpr7AwtiVXwCnbZZ6QRR2sFiCypTZfFSGnQk8nZjqW0f4z1ldbonrkm0sZOj7Wk9A
 rtDZZ7jokq8kWp5fkYOc7zFoiA4k7WofgqbO4XGg3JSMmWIg1N4I6+rObr+aLoOfcJWk
 av6dOcdM/3+B+7X4vBTcgKA3JH1GtsfJFnkbR+MAw6npGaFlt8OL+z31mKFD7MDFNdlZ
 kTZ5rxsqvgRRGZfmigDdidpXMMsooFmYDP/J6YT63oGp2tYFhjU/Yrpnvg969qf0bXp+
 /4EnIWITMQo+o285Qc/qUIEVHpnaq3pm1AM5NmDZU99k9NyhldMnD6coykd9Iu4sGE66
 iPpw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQlVHz3ZOOPMLs/tIyzircR/LiikQhNOhM8Ccmmgh1k7pLJ6p5x1ybqQRyhWy4gfq6VtoKkz4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ0s8Qeg3kWnXmVr4ExZty4S7LDdvRjD5DnZLkSmwWEW5UzTdVc
 7SbSC0gqoz5oLixFBMT+u5eo0YeQGkg4QMYWXNIb6h90cmJjc9XOl2ApTfu6Y1TsjO4ttHwZJ60
 i+WHh1JqpXW2kFTvR7nHmiHgE2fQCmdDYQG7eYAi7
X-Gm-Gg: AYBFou3HguXV7O11P8hwKCM4HlemEWx4q5VhgJnYSHKxtb1glQQFfv5BDVDed1Va7zm
 5YGP8ZMN+DQTERtAaHHgLAosM7P+zhELlP43SzWYhfqFmvXJAicNSgMP8kCE6zc+ZUwArQOi+nf
 Qy4F7i8TdivHIPKOHM23M4jmMIXwu+Orb5DIT3YMbFqYuEANkGPLgTzV+O4Iawo21iON0wfxgNJ
 pGCyD1iPBDJsvhfrdicoOs9v6omV2YmrzAFogZh8EKy32iQtuPM1yjy30/9wvONT+TKSmlkpmfn
 JQrHXdMswT7KiyQ97Ij8T3R7GEgEZfdVcmTn2R68E5qc/dk/Jqiqesi8rNPSHy1UIgD/pL51tXu
 5ctynyj2xFWxcONVgSCVdlwdtU8Wc2UyEPs90kh1AEqZsRGrFJsBEKQtY0unp82WZfi//LKI=
X-Received: by 2002:a17:90b:1dc3:b0:3a0:b312:1fbe with SMTP id
 98e67ed59e1d1-3ae897cfe51mr3744609a91.23.1793439239511; Sat, 31 Oct 2026
 02:33:59 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:55 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:05 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-9-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-9-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:55 -0700
X-Gm-Features: AclHuK-RKQxfn5orqr2OnMVDepX3GgkrLETw6oAuIMwQ-GWaRWfVoJ4KK5nUGhw
Message-ID: <CAFLszTje2v_Le1fviSrNPF_bocOT9g=CiuZSSa3KTpFRguMyOA@mail.gmail.com>
Subject: Re: [PATCH v2 08/37] clk: rockchip: rk3568: Fix PWM0 parent selection
 mask
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
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
> clk: rockchip: rk3568: Fix PWM0 parent selection mask
>
> The CLK_PWM0 divider mask is used twice, leaving the parent selection
> unchanged. Change to use the intended CLK_PWM0 parent selection mask.
>
> Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3568.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
