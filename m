Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140F606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aROVdYPN;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SpS2Ksg4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F7896069D;
	Fri, 23 Oct 2026 13:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6ueju6mALvh; Fri, 23 Oct 2026 13:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9EDFB606BF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792760833;
	b=EDl4IAeQFaQQR3j/W0EGgtVJsqycgMCZIIMnKhSnyaj2c/Y5w7uM/BjjghvNlmwefiCX
	 bEPjWcFc8c6b8vnu49hKPINcV9UfikC196JkLmj8pEjPYgUPx56kzRTaBZw37qmHnu64U
	 Gu3mbWE2WEhtWVb9x6QpjkDe6EmcacVFugoV/EeFG+6FMqDNNSKxw/wNeCg/n83Aj3Yh8
	 us7fVx8s17rnEtVpfg52REwtHlsofFZJkxujAgacbNf+YOgsn/Xl4HBuNXL8+1XHVLgkl
	 M3B3CQH/79bMoVk0GxUuGtgGLEGldDqhllAC/mGzGa1+sO/By/Rtmb0D9mzbGhJU9Sw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792760833;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jqW7obgoHHn0mhGjksS5+l8KbCexer+/I7wR95MU054=;
	b=ZtxAfJLq5vKZl5Ysx94j3W+ogXWZgr4etqWZBhIDwSsbNT3aAM3Lj4Pdjr0c/K0BVa6r
	 Ra9YMaJjCSx2IVoFR3rodtXnjFPjBeBS+1SGlp/jcan6uc+dn24Ze9GZ0tKpc1HdYFUaS
	 3YXyctfuG9KQa7Vt/C9aV2s8jpGRZIKCh7YUWwMzBqhwPN9ujMVPG7blsGR18SkGENJUo
	 o+p75IHfttl0DvNVuDJHfokdGrcs3FlZKhgPNiq+KXYa2WW6BrAYjZiNnyehQkmsKi3c2
	 V8kwme8MyaXhmPrQgKiwFnvkS3sWjg+Of2729VNHsbXCCTW4oiBa0LP+Qh1hCWDkNpg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792760833;
	bh=jqW7obgoHHn0mhGjksS5+l8KbCexer+/I7wR95MU054=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aROVdYPNDjPXsfPcyh0GqNaDyFFxZEDvDJ03LS/U/P3jOqQy7jrSGAiMpbpaoulhh
	 EwFxmijE8GqRVrfX39M4SzyLHT2b6N1+9AMhEs0Wu/eT9HZtcPwjZrydSszp6udkZy
	 7c6m22w1J3Oc6ZOEAW+zOApauMM5OjhlrjsJ8iQ3RGpwseqftlImQ4mkcNfalv9Xa5
	 zaNJnON6phRb2eVh8TkLtb9M911nscdePj0lQAuIGBlNHueWka1vDkpykTfVubvT0Y
	 UbKw7OBNKG9USi2n7xNq7liAO4odibQ9VpHjO7NXtrcb1oBQf9c0+vlkMIkLY5dM2O
	 Yyatcl0qZ0HWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EDFB606BF;
	Fri, 23 Oct 2026 13:07:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 450A212C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B0C581471
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rTmuKMaozDT for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 39D838146C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792760829;
 b=U/So6lX8xgiBdzMznJ4SoO3ttmeKCCLMxriQQtxukoON5flG6PlR4E7joCY+zAA4i7kZ
 3QhPniK4CpuUsKOhthdFtx2blk59ZprxC3/S7FWhQ1vhAlWNnxl5fm9+nE6FjPZhC4VwT
 Rhffen0l/C7yDe6M/2H8NAtNKcSlygEIJJM/iNwf5kpM49KF1DSQbgkPBzgczhm1WT9iI
 F7yAdhlYD1vku4dGNVKWxi53iOPX4Y9IKlvakn4Yu3jVoZev9cLBk/CsNXtqd0idOQ8rx
 5TKmTNCAj7uY4d5QwFomGASvNNfFhRxZIYwrTaUBvUmNDDJhNfM+9C1Z9i6wegM/4xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792760829;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=jqW7obgoHHn0mhGjksS5+l8KbCexer+/I7wR95MU054=;
 b=mQ0mhsBqFBLsPBTGkMoD59zdZnFKfFCafwPQoNceDagoW0mpGZl+F5qrC98Ndl7ezSAz
 56MZroOYfUonMcU2iULsSK0nJpxWvPgq2Yc4JFQ2Y7/fAN8tgDzmsEDvG/K5ZznSEHsed
 NEASO52ly0L5ropQAiXno8cnOB6rsVVczwOt2VPOWgvQOisEBBqpDyb2fVzAo9E3BTGCW
 whAWRULLHAB6N3XeEs7SJRXXyvxbVliGKtmAK0QJKu05/PFgNFPQQYaCouG6VatI4an9D
 CZAZ1emGYJ/ZyWpeAbgZownh2M/7jZJBUo/sWhBpbhTvlQZw8kz90qPjU4w9b/no9wQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=SpS2Ksg4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=SpS2Ksg4
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 39D838146C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:07:08 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso1198525a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792760827; cv=none;
 d=google.com; s=arc-20260327;
 b=p3MRgDZoida2Isp63vildz9QpvSPGBbJaKenLhSuMKW2jqAaLvKXxRa0T5e6qb6Pmv
 UNZ9qI2FTohBT46JalhXWV4ibEeafEyaXOZLIoI5NQrWxySORTtMeg4sMJr426fdX2K/
 HX8Rv5o0JEJubRzgX5sZU4iHh4aNj8yuebqVd3K62Jfo/bHAymqp+XU4lgaEg14A30sX
 d82AdrmQsT0Y02crfaLnyXaglnJ9C3voYj7xshM8JxhmgYxXbzSBn+0MQ+Jw5Dv1EGES
 C4Wx8sDakLYNnkfNaLVBKqVmXxautl9rrH1jKuXFNe8Dh7daL+2tZuffyKjApMwMBnAn
 IYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=jqW7obgoHHn0mhGjksS5+l8KbCexer+/I7wR95MU054=;
 fh=i2tQHTfbjxCsmvhnoxB9qnRhfzM8iCx7s7bfzE6Yn9Q=;
 b=CBr6/CdpSIDaP9l6JTvNGYr6XlkrVoU+xht36cQg4nNO6y+NOQiveFKx6RWYobpALc
 Sz7LUHYv0rZUVkGm+s6X8TuU4zvPTFSpwIfiPUA3xTOLfU5MxE/Nz63cIEWKfwdE9va0
 HBfKG7P5Qi3a5qAOfUphYz6dxt7u5n4E/7ZVme/xRJH/5Qa9H9CSjjJLjaJVVBhpJ8W3
 ZIEVVZBL3p5c3F2Y2PefEN7K1mNvYTMt6S44vNVO26Of6GH257mxU2gkIS6vWZdUN3De
 l/62+wijUw9CMuq7LpTIZDW1KjiyEE4dic9WIF7VGjimQx0dP3K+zlTVE8LsSOXWMaGk
 zD0g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792760827; x=1793365627;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jqW7obgoHHn0mhGjksS5+l8KbCexer+/I7wR95MU054=;
 b=SpS2Ksg4YAzUac51MkFU1IsOTbK+xn/JU5dQGYOjrAmoNq5TUs7P0ecGjhRQRDvoIq
 ISaY2Z4PwuK/4t5jkZ051FF+v/nHdhuKh7KyuHv9PV8BG93dVJxr66/1zXAQrWTbmFCS
 uF0wR/u1oDAZfNNzPPWFW3uJwkXsS6W4qlflI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792760827; x=1793365627;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jqW7obgoHHn0mhGjksS5+l8KbCexer+/I7wR95MU054=;
 b=vHNXMWM46txswR7xVJXBKPCbk61DIVdSo23gmOfRiuc+H80M93OT6iAqhPyWBdzxo8
 a5G3Ffz5ntQgoxAhNukz5gHke0B8rJWNM11I9aoc66oGH2SCTJnqv9K4mr5c76HrSFv2
 0pBjLim78wRp+d9kilssitPqOS+ryasw/X5Jf2ht5wOQJlMBFynKvPpYH3Y9u7YlYQMb
 X1fdlic7lv8Yn/flwXBobWczgXtR/eOL6DBDv5GVm0clcwl1dBZuO1iIK3LMTt+9XJeU
 iSs2BtWr2h2OhfFFR5UkHzHwW3+C+JLDUwfutZOp3v6AH94GCUvTlinHj6g1lZ0CI2Eo
 6A5A==
X-Gm-Message-State: AFq9FYK+gcjptl3oGMPjI/0o13+hdc0odQsPcDJj9sV51mRPsKX2dxV7
 0n/l8B46PqoguY/VejqdsC8/fqNJbvNnl9E8hGvNg96TWTLW0Qj7L3LMJp8R3Rz7L2WbgiKvtAm
 ATpaTk/McnovlmDLSMOQdllTpJexx5+EGbHk0DvdL
X-Gm-Gg: AYBFou3XANwCDb6OnuTYOJKN8aa9DfulmDru0Lg/A2XH0j15FRtB72LisfumCWQM4Vf
 o2KsVpLHEnkD2cDcxXsFD40SoxtxmrwRa5lxZNVelIWEqJFR0jOjXXKiBrOCLKg0M1sd5MMOVmH
 x2dFRw9mZ4Xkh5rkhXJrt/tXUChYrkK6xnkJVoeiIfH+l9lYr7337HSgNijB88apYyP1NozrlEH
 TchA+Ymd57m1Er3CQ0BnWhh5wajlEJQE9vHFlauXXnmyqTXg/hS6gWcFz+tzgDq+utQcgYe8ZjF
 gIFmCfYk4tDHfEktGVRxW7bf/RD3q4kq5nwmxYN4jHi2gYqBpQjpf1KOT+0cu6dvSEeE3kqd0Qz
 GeANWfAukZP1+AB5CKcm54nHq6WkstW7JJZM=
X-Received: by 2002:a05:6402:e8d:b0:6b1:cea1:a011 with SMTP id
 4fb4d7f45d1cf-6b432a94c76mr3557577a12.0.1792760826598; Fri, 23 Oct 2026
 06:07:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 13:07:04 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:50:35 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022-ccaione-upstream-fdt-fit-v2-3-4140e0c4d5a9@baylibre.com>
References: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
 <20261022-ccaione-upstream-fdt-fit-v2-3-4140e0c4d5a9@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 13:07:04 +0000
X-Gm-Features: AclHuK9DtY5eE1ln17yTXm9YbSmFSrWlodxbjBBoUGEmlw_1dA2Pf0gf3oPha-w
Message-ID: <CAFLszTi_3eDYDHeWN+ySge2uGiS5+PX6oHj0byk+uVBZ-EujPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] boot: fit: let callers choose where to place the
 devicetree
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 David Lechner <dlechner@baylibre.com>, Ahmad Fatoum <a.fatoum@barebox.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22T16:20:10, Carlo Caione <ccaione@baylibre.com> wrote:
> boot: fit: let callers choose where to place the devicetree
>
> If a FIT specifies a load address, the loader writes the base
> devicetree there before processing overlays. A caller which wants
> to prepare the tree at an address of its own cannot prevent this
> early write, even if an overlay later fails.
>
> Allow callers to prepare the devicetree without writing to addresses
> specified by the FIT. Alignment and decompression still take place,
> so the result is ready to use. Keep the existing bootm behavior.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
>  boot/image-fdt.c | 3 ++-
>  boot/image-fit.c | 8 +++++---
>  include/image.h  | 8 +++++++-
>  3 files changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
