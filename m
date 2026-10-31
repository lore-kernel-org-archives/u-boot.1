Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OE9ltwWL;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PklZXTcy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02DFD81186;
	Sat, 31 Oct 2026 09:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FGihp-j4V0TN; Sat, 31 Oct 2026 09:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15E2D811A3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439330;
	b=tNfIgMA+C8BdG8b4lMi3v342DXSQMEIlfcHU7O4iIR1GZO75TP2FiyzEuMx5UMLTminU
	 ZOvJfrAqUiRYWu/4497YWIKxYYxI/SKhbaqc64TAhwuGORmEuY4Vt90Xq17dL53xoA4KL
	 1XvJCgQn/SXA5Flfii6bFM+/uwN9Qkycnd2A4CNH02Q+pR7dmHb23WtbNq2EmCgOagnml
	 ctLFKCyll+v8xznvbg9deca+etBSQHgMkHsOsTwNYLDEy3ZXSi1N0FFpVAjCgi63fSFAj
	 06k67sxfP+wsX8CY9HTEWeZ4QxluZGrcKviVJzN52x2DcAIX6UHFJCKdN2yzLpizE4g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=y/SyXF73qrx/FGMDQv1KVqEZyAEPeu92q+9RV0pqf7w=;
	b=dZHsr8DeSBvodu8FW2dszWPsdm0jC7FYYCNpeuOo/UAqHWAd5j5hShT9K4PNbPO17gL6
	 vN0i0WPy5429/0PTdEa1RTNu/jTCK704pcpB16HJY4RO4HGQS0jx+K334zLF8TiyGgvZd
	 +qPextju7uO6a1ImGnhHXWNLeIO2C+0MRFY2aHTXlq+GfwmT1CCcdtd7a7u9Twq63AEbL
	 rYVvils0Ve/mI6NgP5hSXd3vuEQPluV62SUNAiRrUenlbp1NpXJhERKmRFZRp5Ea1Z2hy
	 yESdX6mINASq5M9K1yp/qnVnEhRdoo1PO6SUcgOEpQY6Oj2/WlXVdn38iyiltRGRD4g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439330;
	bh=y/SyXF73qrx/FGMDQv1KVqEZyAEPeu92q+9RV0pqf7w=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OE9ltwWLcGKDOAsY85lqUFaizWe213vm6+Qi2R7+xAqLuT2HzXQkjg+oIYcTC3WI/
	 zky/cH4KGULT2faS/hOrZj3WiPN+of8TRekdmdYdyJE+gtNVfC3d+rPT7J2BU9Fm4J
	 fN0gRp6pCkqOdLL6HFvDAbIOceGPEm68QUpXoX7f0sTQaHy+Dz4kQbcbNFJNpt0Q6z
	 c2KDv9iaZwaYSnzejbdRqZt2bI48LXiJVB310ZpOSf603UVRzPmYVxqwWnrwiTkIJ2
	 nslM8die7b2jThMyiPMBSQruCFBpF8RIbDymbEAVykf83m+YaEg1KQUdlFATsIV3Iw
	 yZUiVMz9dtzwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15E2D811A3;
	Sat, 31 Oct 2026 09:35:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80DEC4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 728F860A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K7bQ-2bp1YPy for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B3EBF607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439323;
 b=OcpahncZAzMnVQrdEOXLEuLLvarUTx4rH6CpioQWVYDR2v0I8F/9YbrnoAgyFbgEioX3
 1VPuLFcTPfMKcFiWqvZYNqEiiXfAa2uZus66M3waQYmCWc8pVhsIQTZHWLlIHbDfovoSE
 lMTwqUbyFSslCopnwCQN6mYJpVhPR0JW7mNt0Gbq4Id6VvwEucsVfEzahxaH1yOnCj1QJ
 rYEHp/zsmnOkmetXCp/5zQcTkTJIhu3FMhUcUpJjIM4ca8E+5NNNewE5GhMATMklLhdyz
 23zhJK+Vq5DDBfxVRDcSLWcOXusUmZnLrKrIcgwAHb9zGS1tyiP5TI+BCrQQv3ofUyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=y/SyXF73qrx/FGMDQv1KVqEZyAEPeu92q+9RV0pqf7w=;
 b=Y2pQXcldt5GYfNyrEw7+hXIn7sswRGJdXISM0PavUgxHmG5ewCPOYIw1lh1OGUDi0Dwi
 NHuwZbjTjwOsohalJyBw659RR0sQcK25JNABx56Qp4OiuDWCR36tdzInL50DnGLv5IzAv
 4ycj66d0r7kdhoKUXpcXa88u0obuR7USMaX5anApYv9OnpG9508lR2Iq3WRIex5DW0Scp
 rZxX/zdFbMN4l1DLykHQNa41wZMq59EmvtrBonHb8mXXMYdmkITUMLV6NLEDJPRzj90Qh
 eFT5Dyfhwep/OoGmb76jqdF3lYpqPG5a8Rl/Vc79pn2KjU2hH7iNZS82pOMVQovTe/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PklZXTcy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PklZXTcy
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3EBF607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:22 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cdab6ae1ee9so666776a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439322; cv=none;
 d=google.com; s=arc-20260327;
 b=Y3vkCb9KMi4inv04fkl/oZk2SuJ2/Dp8uVYgBZ+Y6nMYcOOmCe8h5/0DfoiGRO5hf/
 4ApNLO6TI0cJW9qVe01TOugPwM8EwE32H+b1B43VF56u/Q/zhl4StVW1LHaCDn8DgU+x
 cxJj7SH/7h86urAB/VRaqyUtqESOIpjF/qJnGuDB0joOobrXaoZa+Y2uDOWBHOj57kRl
 RC2rEerAj1oOOTLAvPSqoJkVjJKc5hlux++rJi2OPJxgQ0kWjmeFJzQBCzQumMqVw8ZZ
 EJJEvanZhC3yRwpRO8pqU3SNvCpAJZbyPoRWAU6pFBWFxrD0h6phoW9b6Ex2i9mXZsFu
 Pkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=y/SyXF73qrx/FGMDQv1KVqEZyAEPeu92q+9RV0pqf7w=;
 fh=cAKehF/yIzJUjOVDnpA7OXElt19u20gfWwEdP+BL0VM=;
 b=iMvnPsrjqVlBVbaYNv1C8Koc6AAR85ODeSl7GYH+Wh7JVnvxA3ZUA0MceHc5VVEizf
 9GZ4kWXOEfPEkKj9YTpDqSSz41H+Ej29gBTuBP4HJ/chKK+2U3nR7pW5V6wmUaM7qAOC
 HZmBZu4p747OCe6+pxqaKzzyxO844raJta3Si0dF+sHo29PSSfq1cUIMgicZEq42sJLM
 sxS8nO/bJxRftCEIW1jSbfIlDkbNla0FZUt3TW+ylIn3YTQSsVX8nqY5uoCWTSQnXTmP
 1Ru8vZq2MnPNkYYzWe9ofiAKyRTIwFMljbpj9dTyjaYu42hZjyzwoV4xfzgTUQYzuxcW
 XQGQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439322; x=1794044122;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y/SyXF73qrx/FGMDQv1KVqEZyAEPeu92q+9RV0pqf7w=;
 b=PklZXTcyEo+0N6S0GQwy4aSmFKCdr91NnpYv4uHa6Tg/lLPNyL00tXlPcvToQJJFOV
 cowCqbqXRN/kC86DYccnk+0xvu3TDY9HKlVmBGRi5Vb+znXpfD8VVwKSWUukTPzjgnm0
 xYop9BD18U3fZ/yB1hQig3aZj0Gq2trtYb38I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439322; x=1794044122;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y/SyXF73qrx/FGMDQv1KVqEZyAEPeu92q+9RV0pqf7w=;
 b=dM4EpzH00EgjyB3R0HA0bIM/TRrc/q0YbGhrbFjY01zYmxhOj8sjyVyyBzEh3VxYkG
 vOdTzCnJgMID3dyFXAgcV3YaQ0egMjgrT1hLvHaIEc3Yh7tUtOtWO/gbi4MJ24MQbdfd
 itzJ2TvFAH/TCMVRoJ4XBPrIM+hAbFzm3+3qN7xldLcb4N23qy9Aoc0xs0TBJQIo4Sx+
 gQlEtQSg1IUFdQk1hhRtcMDBLuId3UvkCihjJdzzgEPEQqEBjVSsG6b6hO7HUhsPLjC/
 z2MsqFD5HMBdYY7GQ2pqJj7GjUBy60alpqhMz5fcsXfMBGnu8oQR4qd6ii26Of/xVQ9o
 2LJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAXmFuVF2OcQNOSBRxsViQD3nY6VkORMgdsXKxXpLCAKT3oKAbyJ19aeLHNyJ0wTTLDEL6+Zw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKXiLT2H+ED+sbgb5UD3aglA/Kgdzo9JWF1GxCz5WhvUPuNYv1R
 zrFVGEJ5qx5yqt7NsSbJQquo+Y5zF92KwQNmlFoLTybdFUVKH43KiostKapsu9LW+8p7uwNjfBM
 NqwxtOElgz2y6/MsfTPvNjLhXEEs3t4XPAixqVNkXppz25Z4dqXbTGg==
X-Gm-Gg: AYBFou1Yi1vXSIb/IVnbNjzzR66tljI4rkOtspSPx+8eNQd8ThD2iCzrMUIKOFpiR+T
 FzvVxwYU8TG6CDb+BcxcAgbqMvlKoRo+mwUUMIUuDkurWaqlkNoUi2kUhL1sstS4U0beqRKXwbk
 aQlROdzq/vI8mH/Z1Ix4lLIlX3cHnrH4/2YVZHF0oyC2l6hzzpSrF/pgvg/Uta3bE79ERRPiLUv
 Ie7TldNIZIZSpS5IIEZBKhL0FC0FcolCpyp+JdXEfB6rNbQsENxQwPocQWG8spTG6i9DfHydDPb
 2EO73JT2ck0U+ITRbtafXY0fDpdg1f/AUk+h9YK2l3Pb/cX6pnoJ3CrUwsAg1y6lgl3UezpOTOl
 ui7IxHuPjQTmOE91ro2UhHUVUsZEiryC2R1StXXF8hxniFUhoXbjmIlg094WrrKhq1uJeztQ=
X-Received: by 2002:a17:90b:2805:b0:3ac:8dfe:8ec9 with SMTP id
 98e67ed59e1d1-3ae897fcc5amr3619931a91.47.1793439321972; Sat, 31 Oct 2026
 02:35:21 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:35:17 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:17 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-21-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-21-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:35:17 -0700
X-Gm-Features: AclHuK9SX80oKx8P67_xaVfWDYWpE07alZEmh_PxPSxvCi6iNPY8m-Qy4Y6t9-4
Message-ID: <CAFLszThdRL3orRBBERCP3hTo2y9KWtcNi+0saCM+3xmiVrtTcA@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] clk: rockchip: rk3576: Fix ACLK_TOP_MID parent
 selection
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
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

Hi Jonas,

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Fix ACLK_TOP_MID parent selection
>
> Write the intended parent clock for the calculated divisor instead of
> forcing it to GPLL when ACLK_TOP_MID rate is changed.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

> diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
> @@ -320,8 +320,7 @@ static ulong rk3576_top_set_clk(struct rk3576_clk_priv *priv,
> -			     (ACLK_TOP_MID_SEL_GPLL <<
> -			      ACLK_TOP_MID_SEL_SHIFT) |
> +			     (src_clk << ACLK_TOP_MID_SEL_SHIFT) |
>  			     (src_clk_div - 1) << ACLK_TOP_MID_DIV_SHIFT);

BTW the ACLK_TOP case just above has a similar copy-paste mistake. It
shifts the divider by the select shift:

    (src_clk_div - 1) << ACLK_TOP_SEL_SHIFT);

It should use ACLK_TOP_DIV_SHIFT (0). As it stands the divider lands
in bits 5 and 6 and overwrites the parent selection, while the real
divider field is cleared, so ACLK_TOP gets the wrong rate whenever it
is set. It would be worth fixing this in the series, either here or in
a separate patch.

Reviewed-by: Simon Glass <sjg@chromium.org>
