Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E408606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vtYtbHko;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=i1+fbuRi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0747A80C1A;
	Sat, 31 Oct 2026 09:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZsoT-Yg9-02; Sat, 31 Oct 2026 09:34:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E2FF80CDA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439262;
	b=nAru59fffS2Lt707pl5RYPdnN2wlGSXXX4LNdlFgx/7oFCVatwnnp1yAcR27XMBJQtuv
	 NzxTs1YTRHgSAnBecvcyaRhswHugV6L+R3PNfNbohn6CrFcDoXvJI2kBJie7vnqYaHkDp
	 AUPLh+DKc4YokuewlNtFqQQpksywneSldCv9vC1kXNnZAMdykGD+ppOwAI1XImIrvWXG9
	 X+nC6lKP2rbq5kJY69c0ybDlVRMuBKMOnSCtn6sRcmdgmFNHImPYADJalUZCaSRV5Nksz
	 TNL+1IHRBQZLMWWEtDA6jzjisT6fbwwaNm1EzjjvELhfRFrfBwl56G0DzXvFqTmJ2kQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=N09MMFhYJOtCvajs33QoziiDoPnnl52zmju9Ov7vl0M=;
	b=et3ZdpAAuGOY9/VMhbD6+XJbuscuLnjsT+C0wqJXhxvESMnWFr0g/JI7ii2Qy3dQMWzg
	 6gVv/LW/2AJ74CLrPeSpFcQj+Snhxt/j1tsQlwEJFEfqav+q1jpQ0QJJgkbEJO41dJvEb
	 SrIYqnlaonxEHOTAu41THkKcl0f5wQ6IjADjse6Dqt9SToj0kvwH2vV5bsoUwCwjko0K7
	 xFymuYDhz4lepD+9JQODr/xupCi00bFF0eSsidPqmRm3drYbqCdieYgop9c0+yrJOFqsJ
	 zXzgLfT5TbuMBccZ50tAqiuWOOP6UNSQ4S5PE2wfvko+LZDiJHfZqCTJwARZTYQPbuw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439262;
	bh=N09MMFhYJOtCvajs33QoziiDoPnnl52zmju9Ov7vl0M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vtYtbHkoqdsA5HxidrPNCVx2kUxOi6Cg+r8jhW73snyD/G0d9xWkRaTMmI6HZTd4Y
	 YmXawnLAhw4sjyxYc+kj8RzpdtP21Lr9a5UH2JiFunoGgcgKtAJxlfcfb6/Zyf3jjZ
	 85b6SuiSkhr4D3U6LniRE9NEtjVqE3y/DZRggNgM9gV5AaWWlDx7JJ5YLTrqqCOEL5
	 aTNk+v/55e2s8FRfKjq71tCki7ixped7bzZYjx2iKrBJ0VVSPxbm4vl9EWEz1YaqOS
	 ibn6pd485twuQYHWHblPuGFd1UHGVqe+Sq6x8scoSy0AvNH4o4hjmK2RbZClh/4DrJ
	 rfxIT3dO2CrOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E2FF80CDA;
	Sat, 31 Oct 2026 09:34:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB2B9156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9120B400FC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQlvKg5KthiG for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F1EF640057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439255;
 b=FL7DauMN10IQnDyADnKjEidBTsX19QT2GpRWS8vpB2HeeMSYAfltWVEWqv/LGu7zDmeL
 qyuRfCLXOZ2yoKFZb3J90OXpsYgE6KF0K1TnW3c+HRnqJ3xUHpoI4oVwWileW+w1lBxrY
 5ZfhBnDbZB83dtpQ6ndgR5VeiHhoqxG9W6SEfc/ukSM1aQZCFIQ4FAHhQQTuWPgUVU1vS
 CC4VALq+XJAdsXFgzn1lhHdr8Awhj2aV68tUKIh9gWe+RqGLwJ5nyB2BG2Nzf4RHqHHqN
 ZYQfKQFAQ1KkD9owkNg+riFHv3qdqpLrW//KrBpH71uyZGJZAMVgi5vDHx5LqNGH3RQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439255;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=N09MMFhYJOtCvajs33QoziiDoPnnl52zmju9Ov7vl0M=;
 b=RxzV8ondWrc8JmcfOnu/Fnn13ceLCFjOKzO0QJtiSdkQU1OOLdEv5BlU1MRdCxh2hGPN
 AxGaf76mS8eAjz1xQnMwjhagSAJxzRBeGKAJdwIYiKECPDFUFi778bfZF9KT7pYrnqsCN
 u2OGmv1X2nas+TKinN+XCeZ+Nr0GAB6xUYqn1lbu0G5MOLw8vjwRc+PRzZJzAafWkpBs1
 ZvVOkasFbcpN4lxOxcDfD6hx9g9HStuBrkqLX7aWQ/Y5LNU3Ai1uuyuIDB5mItAxHwluQ
 cSB4x6RQ9MUUkmGh8IScQGMzQ5RmTg1DTKIvxnx9g+Tt1FE3EOSOPpcJObElhHgsW6g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=i1+fbuRi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=i1+fbuRi
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1EF640057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:14 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so846702a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439254; cv=none;
 d=google.com; s=arc-20260327;
 b=KtsYIpoJkbEPOWP462Omkep4LL71qzAKmAt9i3eDgypCtRXOvyqdXVfPCMZNPhMPtb
 CeLUu+IJaxvxmcr6VTqFURee3Klt165MEORVJ+o+4q71Pk65DYOxplk/n5RHemxZyETc
 dlqky8GzP0qLjNFHWht5+uovT4R/KKkaceF79t8jMn9QSSdqoCupQcB4Y4U+ne8kFoxG
 neErDnOiNVpUXvR87VGBiIAvW4STp2xrfLhmxb095EmxeSMC2Tgif+QdDmWU9wrRqoJv
 rYnAyy0wzJgq8ga0ZEWMWR01ela7EHzqq+kGb2p20Ter8SRdcRo3vQZlPaGPn1sKdGcL
 ypmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=N09MMFhYJOtCvajs33QoziiDoPnnl52zmju9Ov7vl0M=;
 fh=yDSWzE0QtkGj5zRxzyY2wLrv439i9lQCFP/VvZ5UHmo=;
 b=VUvNDEGUB7WyTp6+ESt4hSCoAm5oxGQsbvhiWfyZ8O82rOXJlHyD55wqhg5/2CvtA9
 p2+J8tvDK/UBztpktcW3Xsan2r7l1+M46/BP8llJte15Yre3A8WPvUs/MEX/7B0s9a7S
 1CHaWbhpJLdOBMr249uIcKYW8/WRQ82PBTnlshwGzEcm7C+wEtPHQl8yqcf/K7yn0Gyb
 5hoMvcyIVdiQNXUzo9l6v91s3+5gvEvgz0wD3EU/2dwwvec/QS/HauR5TFfLPJOWSBAt
 y1+flBdZOOM2bDHp2ybIb/5gDZbYL/otSYMHE+IrHmm3yVNqO4chl71c9Zgmjciqbxcv
 dnYQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439254; x=1794044054;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N09MMFhYJOtCvajs33QoziiDoPnnl52zmju9Ov7vl0M=;
 b=i1+fbuRi5UzgOA/IhG0Al5+p2EojScbX2n7RqFS9L58D1h/2QjSnXZd7aSF+Z+iUxR
 uxTDuN+BYhQhx194u8j7ZV58AkGPQxBSSihS28ZGUyJRtMLe0f5G6+gJ/03JLvoHPRH6
 z9KFuirOI673Ib7aPcQ6MhOmfpwfpTo0Q10rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439254; x=1794044054;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N09MMFhYJOtCvajs33QoziiDoPnnl52zmju9Ov7vl0M=;
 b=i25jvwP5L6UyMtqbRMN6vbYcuTUm19gdwyd6SosvGS8McpFbu0IhU0+xpUxyqesN67
 Gc7GZmWotNlyjPiXfQm3FGD2rhJPYnzg2LNSZTXG6MIIk863v7gMsVPDg6sLj1qn3hyc
 uWCfacVrD13YQe5DSmOkQi15BgK3jTEXBFT+54u8bPpPajkI470Btzg/n6VwR304n9Zs
 oIOiJhqGk8dXAkPH/4MRd4dGGHP8OaBeh9Ro1pgwqMdg9M7tsx42eord2hv3f0TWa6uv
 oTaAhnfDD2tAL+r2gBwm9ocUFjqm23e0q0V9MwGDRVuP3M6VYvl0PqFvJqVjirrZApV2
 IT6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrt6Mlj1JUMDQhUY7gZo7JvB83pPz+D8+Er9BgzNGDLe/DJE6RTknBgIeoAxOzygwnDN9hRMw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJIhu7Zqs/dOgSZ/Zuok+AkdDCUDc0PFsNuP1z11vRrDuDxd1pO
 KLAkgZY2cRzthUsNLLWw9xjy2hta+2sSCPgZut0JeEQSDl0iyyx0NnpRV127zeBjIMIhCPc9+68
 fdtiL+MRf1bfruFERcOhX8GpkCmWsibpHSLXEHUQq
X-Gm-Gg: AYBFou2qGb9qBOQ/I68NITBdn9RI+6OBk64rPx88yX/3qvTa8F24/X5RlqmpBiMN3yj
 6Rymh5dJxhzuNIJrKmxM6xFQUb+TzciPlBVFi91CFqzXxOYNbbyhGMFEo858GCsL4qcWgpm8NRg
 BV2Vkg2H+HauPZ8CbCR3qwlk+XlpUmwUP5wN7BcFVa+LQs7J6hLNsG6z/kiBW/8EIBLpUjW8/8C
 qTBy8tIyAUSF9otoqjIkqgZ4RkRhlJPYLmzX8r88gfGhHYTzWUuoLGUXP0Oltns1+WVFzzxBuqL
 beNhtrkpVXiRmJJcW0dqrpuHYiv2RtXwy95S1swM+QZmArSjFMUlCy6h56ySoGwKs0229dRi9mF
 BNJI6dCqwNtpF3tnHBnglDFvMlT46JKppxcmdYXRRluINDZK0uTE3YTXnjgs8YWIohD//lnU=
X-Received: by 2002:a17:90b:528d:b0:3a0:eec6:b065 with SMTP id
 98e67ed59e1d1-3ae896d8027mr2561581a91.13.1793439253974; Sat, 31 Oct 2026
 02:34:13 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:09 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-12-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-12-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:09 -0700
X-Gm-Features: AclHuK_AZBFeIaKe3ChUOPPmFmykHy1q1nQku_VCko9VtOwctwnIfw5OBV0gC4M
Message-ID: <CAFLszTi+XH5o8y8pcXJNQ9aGLV0s5ZK4xFa9vtR3q1ABkZeA3A@mail.gmail.com>
Subject: Re: [PATCH v2 11/37] clk: rockchip: rk3588: Use GPLL rate for
 CLK_TSADC
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Jagan Teki <jagan@edgeble.ai>
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
> clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
>
> Use the GPLL rate instead of using a hardcoded 100 MHz parent rate when
> GPLL is parent of the CLK_TSADC clock.
>
> Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3588.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
