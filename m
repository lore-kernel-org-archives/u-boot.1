Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C29606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iijaABxk;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZZPnZOxl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB9A360AFE;
	Sat, 31 Oct 2026 09:36:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXhcVYQClm-5; Sat, 31 Oct 2026 09:36:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1CD060AE5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439381;
	b=N42NR4QTgobxach91Iyh58wibhgHyY1MDLxq+zc+vxBxvnQYa3zMzpYJoTlWJrolkiCX
	 Xm6NbVivtC/fcyrqC8LGGJdKat5A4OIJuhv69GObF3aQT5tKO1XlQfQ8YWzKaclxxFDMe
	 IKuuAzpU3QefznTwMwgrx+3l1uoICZ2g2opMuK7U2jsSA/xWDiU7MRjKnnAXLoNRf+Odi
	 wJhVAwKhoagrPKC79wYHsrqV5M5oZ1al9JvcjbdRm+Vw/V5UwCpiHcPWqrT9Hwau5k0ts
	 dgtrfvVDg2Qz6CQ4CLqbXu5CV9qph2rOEuYrIJUX/ytV/KpUfXlcWZA4ChcXHL/i82w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AIwzV4tD6CM04c+L1UBM+m5ia5tmnJXbkJykeAFVMSM=;
	b=YopR/+CCspFVlIchKuhhlCOlZQanrAOJ3pFQwxf4LxreghGZ570a2T6Y+TZwhuidqows
	 hGW3dwIYvKVtlnXGoIVfpcbs/f5oPPQZ+PRfqdaMgHtWFSWGt6u49zZVs0W11YuT8UnTa
	 /H4IfyFiwNl01csUA8uBg60UMvgH1Gv5X53tRNz/cbfQeSxKsDsLlxtDs6ztKUvSJRrKJ
	 tre5b0Zs5rVCdvmKCw923M/8YagjSI5FnKqi528ce60ASRqpO3L/1/xc5VIliaDhlIOJj
	 UmV2j3l1gKQVeR9xaTRx6f/k7LwcYIS1leFu0Qc3qQFtmXYEQmp2a5+IE1Fw8zHDpig==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZZPnZOxl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439381;
	bh=AIwzV4tD6CM04c+L1UBM+m5ia5tmnJXbkJykeAFVMSM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iijaABxkQ1OcTcOnynwP6VMNfrbBc81NqxHRsEFxqu031rPSt1VpKIOzHL3FHeNBx
	 o8pJEhI7AohXx1A3AgwQYsGL658u7f3YKWrb8zXkzQeipxvO52qCGMuOpZM6jWpytH
	 FB5r0qC3AKQXZbYUO700BQpnogH6a8GauIGGymQKCrx2s0VN5LIfOsKMAr9XdiQZVL
	 cfcsQrOaL8cHN1+E3qPBXaMoKLPuiJ7/qXbuuntuhrB4ZkkGo4nkeqH+eth6oiHwJE
	 juD/yDndRBrvJ7qVvSFZklblI1HuwdLPbSgMJfe21LsF7ft0XU//fy9J5ukkw7iegf
	 V16EV13b06XKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1CD060AE5;
	Sat, 31 Oct 2026 09:36:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DEEC2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BAAD60B30
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwIMllUNSSPK for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7AB3660B1B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439366;
 b=IR06UI+zexHKMhIcX/j9VUV1AY1SQvWyUOXDfbDehmui8LHyaGiIkYwDZV3zmnrMQwqw
 pfxFNuLPC9sVD8YQt3A3meoPx+ruPve1s8WIKpvs77vaaOJ5IFIcu4HOKZaTkPTLgLilU
 x1JlQFwWtYRHyKJ1anT7T87CEWfBH6c2auJrppU/9AUkG7n9QEg3FcJ1Tq16QCRbIcJwH
 UEE8WxD5oFEJhLOUrmco4fRhi7o6btaFNOCa4Kc2tXA/reo8OHyv8B7fXPoZePqUGtZUI
 5kmFRKK7AY/3APLb2IQ9Ux9Xk7+T01HiOMMgawZJNtswOa+O7cglpUaPqyrYZ1Opdcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439366;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=AIwzV4tD6CM04c+L1UBM+m5ia5tmnJXbkJykeAFVMSM=;
 b=hDHr4muJpKH3h/btIM+xkwLIQOX4w8MA9DGvpFFAJzEMtUBk9Gagxc8sADtZRkS4l5Es
 1afYEfk7rjEOf8pJrDFyDRe8DF1w9+DsBHV4rVPWHQRsG90hnaNA5hkHdYR1YRYV1NEBq
 O3Obiqp6lYPtf4RppLhySxxpJbUNSEGKqhY4hhxz8RrHkPGzfJHUBdRZhW4FXbVUtHKDu
 sKbJPnlRTy5kCR/d8rWVmziFB/n8C0Szu67Xp4/bYVGO6ripacFxNjbLNihGD9XAOsXuS
 dLHDpdWjPccAJ7V6oBaiYYkkAietrIyRauNPubxftgTf25OPfqY1yuigOFhIPHMSNcQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZZPnZOxl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ZZPnZOxl
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7AB3660B1B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:05 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so1863625a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439364; cv=none;
 d=google.com; s=arc-20260327;
 b=bULPFyAe3CENwfcB5HyQnib0JTV4i8s0N3Q+qatfpx0ftbUkINFGQupcl29LXgnYUS
 nk3JJdxyO6tAY1swqlXwfBRFDetQ8XDgzntqqNQ4X/LNtu7MeNKtIZHWvuAUbMsrQAli
 tH/5XO0zJVVRJpYsVm3sRrs0+uQZrN3dx5CFpVP7ha6BXYwCDKJbnDYOk8MZXpUXAQDm
 6ssFnK6k8JTALpB6J17ik6FTINNFwVC01MMaY7a/zxFP0lYlNt5BJAd3iZJMLAhiVxat
 +mv0jG+k7/t8zHeJhmXicpQJEaXuh+mrMXGbtax2eEwBb/Mw87H9ga5GW7EVYfprmzHn
 H83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=AIwzV4tD6CM04c+L1UBM+m5ia5tmnJXbkJykeAFVMSM=;
 fh=LswCoSp9GscUvRS/Y9lXjOmaUOx1r+YmkrGorxm5eW0=;
 b=XrF49Jqt41rqjqckYUpxF3fymnFmrlI9530mFHYDSD3xZ2DeN/XzwLaRrhvvwAgenK
 zIVc7oKsCuuDhNRT9jMk6V5+67cvYp0AXM6BQ5W1U59SgehnVte8RnhiNsykP2F6r2Ni
 X7OWAinG/Af09H0SVDK09EABhDqVdY3GEkNPn1DQgdyQaYsgZcJF9sM1wpok1bdcPO+W
 OWl6oVILlo1yRPE+2jbA297Dlb/r7uN3kp188iu4sjEw2CNXdivphWsCFVFMES0Jxn18
 1PiZE+bzyXXmYjPlVx+kzVJZn499yK1//76Sc1rSF73svRD9JfH6caQnqQpJrFEQmPbW
 1TTw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439364; x=1794044164;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AIwzV4tD6CM04c+L1UBM+m5ia5tmnJXbkJykeAFVMSM=;
 b=ZZPnZOxlBFI2C/cMtDAqTaEy3Ljyc5tktseaGLCAQsTaqE1IjRzus0J/GKLRVDHJI0
 vMZb+FAMYfsUrXfmtsv4J5UxXlWr5hVUGCUoDEnd6qkdX3YgxDXqcC1zO1JA2Q9EPyaV
 +TLfHGapdIta+J12oE7xbOb8u0Ca3fxxdcfxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439364; x=1794044164;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AIwzV4tD6CM04c+L1UBM+m5ia5tmnJXbkJykeAFVMSM=;
 b=WrySLQcY2EcTp9dxqeS4IqgzPliC4MGSK0JSjfgux1Tyt6/reQ9pTYpmzOXyXxnT79
 M/ho+5UBzz7vp8Ma2oO4rOxPYW8qVDWFNb8nzhseyMEdCVPNv2ec8pz9QW9JlnP6BPFO
 3X/XWCNvwpQrDbv+2Xdi0u8Iedb88xBaZSVBwFUeOGPWY3RYiOoIv3opJr3uTKUt43X4
 r/qIEStJBf663VuGuPAgH3MgIntgCywuTuYZF67NhIN7lLNC4FvWfVDoN7EQyRMj7JwO
 RNRT4LR8zNFNyzad9EGMeOmbt69aUN/7Vp9gHfWCcYox45LmVZ/S76IZqa/iCB05d5qt
 JCLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmqhWVwwMdBmezkI/roYkL5tNBAjna2Xng8HHcTncdK8yaXdZTS+mfrIV/cuOTX14NvzU+5ls=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKBDb+XdNaa93mI9AvvE0JK+NbiV/hKCWVzGswtnvfzhhU32L7w
 842f/+cnlFiMnbXHBA6tfbGYKoI+/9m2wDnVu3WvCmsiwi6Bkzo4Y8zC6lH6VJu5ircVs4SEnwQ
 VtI+7E3DTqKUmecxLM5XXcoxLdrtN89esmvxJ8kk0
X-Gm-Gg: AYBFou0P/GC4cYO7CA3ekdwrW1ySAlILLeuA0tblrC60APhiQ0XOVse7I4OIlhn4hUs
 uoAinRmJzxerk5ldvp3rPAnJ6D7QmUQGmlW7+ZP6G7xOg0+0SpKdCVHXJpipegOMTVIPg+flvGX
 /gIJRPtmNWbMim7zYNaO2IOOJ/2WbKMWYNL19rofgFYw+JFDW3vmRwfKZlohxRHfxEGDXcqlYIc
 ieezti2zU67hMIgHutBUvRTPQ9AwYMcd7eCDYgpD4DRHz7orqx42X2AqZI/xoF5rYGvsFWwXI/Q
 O3I4x4qjxmhoG/+7rDY0LLs7nAg9MCC9nWhAU4YxuLWZS02HEWIJUwt9AQTCDlrU23VCHSswV2F
 vdrOtUQPaGwLn7MVzMfDfSZvKzmzDthWgbKK09gKqYEfxCy8Hq58INUuo0AZuablHnLJEj1A=
X-Received: by 2002:aa7:d518:0:b0:6b4:1db6:9cab with SMTP id
 4fb4d7f45d1cf-6b4d4d73fabmr2798814a12.24.1793439363936; Sat, 31 Oct 2026
 02:36:03 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 05:36:01 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:25 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-29-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-29-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 05:36:00 -0400
X-Gm-Features: AclHuK86Qq0sg0EypIEZMIpqPbbpLA1Qc-a4OG4BCGTBOZwMOxxwa7C_OcdiRHE
Message-ID: <CAFLszTiFeOi3NY5BPyAMWQeHr4+X53ugiWQNxOEiaxxeEPW-+A@mail.gmail.com>
Subject: Re: [PATCH v2 28/37] clk: rockchip: rk3576: Remove unused BPLL
 register macro
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
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

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Remove unused BPLL register macro
>
> The BPLL con registers are located in the main CRU and not in the
> BIGCORE CRU.
>
> Remove the unused and incorrect RK3576_BPLL_CON macro.
>
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
