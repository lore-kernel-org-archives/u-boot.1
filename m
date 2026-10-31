Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A46606A31D
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AxdISJ8u;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lMdjd/E2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4C1C60AF3;
	Sat, 31 Oct 2026 09:34:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqgZorIxBSWI; Sat, 31 Oct 2026 09:34:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC50160A88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439298;
	b=XfpxEolMSy1UbiVn7X84wT1nlnyIkcu/SO5CooPPoSDns23dRKCjbFZE/zJL7r971jzk
	 FP0SSKoSDHqYMyR2VaWLjzmpr8vaPpAZmXzA8qgPGnEkfmG0hqV7T72qeJvzOiAUqfvOX
	 CGjl8y+brA58z5ZvRKLFZjfY+Nx6z7t3IhidAaLB0zdhrerwv0+HQU+tAoFFenNdrVqsR
	 Ag6srRGcj2qEw1LNSaYGQJ5pKvexTKwVbLy2iCiZ9Fkt9QpaeREl3IQfwoY2enMzZC6tr
	 EzB8OKRDoK4p9rLPG5vMcwsUFycKWug4a3m2KVJ7ympcaiG0fAL3crmYHUBKVAs+tPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VDMQNv6pk7vlu+KBvZj34e6Hg3KFnRrlBF2OyFyKqKk=;
	b=KDj7MxUei7nvpXk1ln127R9Yh0O/5BG4DeEhIU2RPhIQQbC2rqBqPZR4n8wluyqbOGmp
	 HwQBWc27s8P7t9aaR/I/S3W+Gja4yXkNE9n5qLLJ6Cup8ws6/KnkB1oakuJHOLogF+8tX
	 vZ26pBkUl+68CFlGaA8b908w9rxDD4xUCQxPyyZBo21z/QDUyFuJN0dMT0P5pxPSgU2Q9
	 fBfvWfUvNd6G7OIcemsEBLlNntwm8HJcbuKPCZqdig+q6aX/UzL518mW5d2gwl5bEtdrD
	 NSeQJV5eNaidkb3Hbj08CGnzbeSamDV8ICuqYBc1M4Wg0+f70x6z4ZVsoADtyoOynsw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439298;
	bh=VDMQNv6pk7vlu+KBvZj34e6Hg3KFnRrlBF2OyFyKqKk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AxdISJ8uzIbcy2BJ6rjJ6sF6OqFRNkuIknv2wcL0CKbBKA6BrIC5NRVg5aDz+xFH+
	 KzhilOVPkR76UkblU5lj9Jn2KatEUkM9NVOrwIcXLhbWZGiyPlmkI93OvY0nBgHQCY
	 m5K2KibYJoWymrDXvfVxJQXSsL2EM+ffWDwzAIUb/y3Xt2EcRV/2N8IKSymBeNO4fq
	 vu1qAe5fAra6Crk4VQS29QtHek8LHvsaco8gJ+WqDr/xjPLesooIzx12Jo67fzNLQ9
	 7t3k7J1qCXB9ifnCQ+jwceNNWwFZdyfzl5WlrBY2cfiK+8umyP5TKv5ZSicq6Yh+wa
	 8NqAnkHrSjKkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC50160A88;
	Sat, 31 Oct 2026 09:34:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E502362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23F3F400FC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLqWHgQ21lU2 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 810C040057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439288;
 b=DcsjpbTipNF9+kQa2NbY8KH8srFS3vzj4POQkTYsZ+AJVdje5YnONo2PU4bA2BaYWwdV
 MufPOsm8/hZpK0yzkgoeIAm1RtmD/V8T6FYGH7OI+Pk0/d04Li9WMY72yn0AYZQT8HgqB
 g8FTwBdt33Gkktweg6laBNzA94+xMU8qHNlki61O0Ck7xkoidTn/Ioaz9uSQRO+EDWn3U
 Vpcn5rRQn6hHxoNap6OBkuF05B5cpwBANMFqCIohlVxjXL5i14MieVznw5V8eN1e6dbK0
 az0B8XizIBdiAsmnpU0xNoASU1n22gOX67iZor8TkkXJBiQoDDQb1kB8oLZfwuu7FOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439288;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=VDMQNv6pk7vlu+KBvZj34e6Hg3KFnRrlBF2OyFyKqKk=;
 b=YghWytz7DQmUbBUjY6HRKCk7QxXXRH5TcxmOGfRkp0V1DEq9xuj8DCjJLIsqnu80X4yD
 cAMYU3C4tOnxvTzGoeE4S5sIARCfY0KN/BEFMTPBSWiD9PJzXPtXKpj147T3jwwyP0Guu
 sOmRexaq03rzBgjMR2oZd5WnQmR0aGop41BsjXKDw9rUmt9z2rtHY02fXJxsuoZ5cjoB2
 6RQaKY+59Yza6ADqPaj4bEInM9Dm3Ik8M+HYLIXSAX7nxhaJGoVWQh5WsFCTUI7jfHGHR
 B5wPpmlkMqSDcgsssfaAaSk4MTmA+t4sV+xQ5F0v2sJ7qGnni2ybWMSoB6EcZPOtJWw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="lMdjd/E2"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=lMdjd/E2
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 810C040057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:48 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso710520a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439287; cv=none;
 d=google.com; s=arc-20260327;
 b=mczqqnCz2+7qzonGBcOYMAJL/ekXM2iVR8fISx/7wo9zPR8MbGKPhj3kONAkF9J83N
 PmOrg5QNU7HyV/pyR/RdIuizokPujlxYoIGvo/myD6NkuE83+zpfVYf2OvQM2u4gwInY
 N6EkWJ0XIOSCLvoVp4YExqxoK8mkl0H+vhfdaKFZLypIeBKpMWogOIxw8qwWdD/ignOr
 C+xrvokXr+tcSlpejGr03AQIN4DBJlfpTwdrDQ8RFsE1CHL12WkjcaFDBiJ26KneRe1p
 1Ll8uCZnMmmZuhggAQ3worMkjhpDVntMzMNp2qk62AFfuvYuzYFphUl3T26es7tOZfV8
 taNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=VDMQNv6pk7vlu+KBvZj34e6Hg3KFnRrlBF2OyFyKqKk=;
 fh=Pkbig7vT83LOtHbD3yfF/X5yGRJALDLBdrpld5zuT2A=;
 b=KiGVFuFHpaY5PfPvfmy6AkIHsJGwNf3BUl8iaRlEggSSOVH3bNKLEC6n0R+UH7i2KJ
 FN9mU/ab3Ih+HtuyXeFktboYRCXyGco6EOt0i26HR3fSosWF5q2xZzZFFUj6r8e05QKP
 AuLyvPf5SxBzOc1tL97q8ZrTY5E5bnT8Vu0EtE+/AgzKfFcz7MBpJXyonbfc+dgkLNAY
 ogxgNXrtXHwS9oI04g698gIPSrJ7UR/CRuNydYmBJJLZWQSAsn06neJVGkJBqNeKMAlZ
 2GCprmUVkgT5RJcnFh2IVtXxM0A8vzihSSxmBwUbufmSZmjhT3Uf19AC+EWe1OWBsD05
 wTfA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439287; x=1794044087;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VDMQNv6pk7vlu+KBvZj34e6Hg3KFnRrlBF2OyFyKqKk=;
 b=lMdjd/E2e1u/3jbpigrACJt4bADPQCNvB11BvVeAEvjpSlgAIaUm1aA89jo2quwGX4
 5S9639c2Vg3Q47KKqNLzwMCVt0axgYNyv5ujKDSqFJu3lNUcR3wQrmC3TZCYXJ3TmNJd
 OaM1wICBYkldYOfkKfFGwQKOswB/3Jlmg593Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439287; x=1794044087;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VDMQNv6pk7vlu+KBvZj34e6Hg3KFnRrlBF2OyFyKqKk=;
 b=L4DmAzHO7Zah1GFAoNB7SAPKFeKJ8u/orlvx+rYFfPfD5QyTHPAoLMYA8BjBFO17Bp
 d7UAgpO5fCbwPfqldYWes4GDN31tELECskFhIeiLJrrpO9C6rIIDQdAEEhvr9jkwiJkP
 /aqRZ0Kuo+Q5nKX6oG+TgLot2/TP7rSbtVNl6ovUxm+N2z5SU8OyQ0rV1HCAPzT7lemR
 ygenW6y9B8RLB0Lp4lPwv4+YcDyNN9XKu73ntdtTVvQCCBjezpi40doHeoQ0CQFlnE7/
 vROj9xH5y7naE773qx2OrRU9Jy8kfKhRcctWAFp05Yp5DnXzFRVG9FACKAwRVfijJZVf
 bOrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoBjtZf2ohY8BOFf7LCOg7vfKoxJBazNgMvt1TDwz6c5JZts/7xdvV6Y4xultZGCTTqHqUNTQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKNromMyc3zHhVuKJlAHeVjT3qIrG2DauIHMBFEIP4Q0ydmq45y
 jX9AIBoFmvgYFHM/b3bpTkUUl1lRFYjzPSVAfwVjcubUkQC/bEeY5Paf6hTjGwjxYI4BZf8WRZ0
 njIC3wv1fVxPEafWufGnICbF78lKra4XHyjkyY4rS
X-Gm-Gg: AYBFou1a3DCI8Av7DZIIPJXg8FU+D9zYZWR8Yire4kWN8icNQwn8wApXCjgzqRkRHtg
 0jjBIQCE4wiBj9ewlW3IhIoxUGwvsckwpPwvj4kYX8652wHAD1kQyr77sRbuj+NZzwPosC2Q+1n
 vdQ2PhPDkvNvDSpwkRy0eayCNAT/2kz9Ln7EOcTQfW5bmWZwBoOh1jzbreExabd8jsJofskg3C/
 Z7gtl8dumx9Yr3Eq2TXSOE2g9G7+ZeyiJt5SEX1mrd5AP6FHamCbTwxFkq1UgbczhG1ICVfPyjh
 fLZX0hX+5zCwOL0wrl4Xwm0WEzkMOMwV9XaJ9RRSRGBtndsMW7qOevKhquke3Qaz8wZkymJZ/6o
 zjlm/yaWysgWkDHztXCLQMoTJqOpcQz3GigFwW9H9zpuSaHqyXrRr5jIjoXMGH+DdQ40FHSkv
X-Received: by 2002:a17:90b:4e83:b0:3aa:f4af:1e0f with SMTP id
 98e67ed59e1d1-3ae89536c2emr3853672a91.8.1793439287445; Sat, 31 Oct 2026
 02:34:47 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:44 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:12 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-16-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-16-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:44 -0700
X-Gm-Features: AclHuK9pc8670aTZnsfBFd1UhHz7N2TwJ0Owy23FX7DmrZ08ccnKFU2r2DvPOss
Message-ID: <CAFLszTjKdbL6kCuMavd2RebCCNEbUKEc4b6acVpQ+mM3=F0acg@mail.gmail.com>
Subject: Re: [PATCH v2 15/37] clk: rockchip: rk3588: Remove redundant PLL
 register macros
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Elaine Zhang <zhangqing@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org, 
 Jagan Teki <jagan@edgeble.ai>
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
> clk: rockchip: rk3588: Remove redundant PLL register macros
>
> Remove the duplicate RK3588_PLL_CON definition and the unused
> RK3588_MODE_CON definition. RK3588_MODE_CON0 is used by the driver.
>
> Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
