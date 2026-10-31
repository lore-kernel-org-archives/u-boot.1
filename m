Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75118606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mt146trk;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fqUgjzF4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52E7140B47;
	Sat, 31 Oct 2026 09:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFdEsvbB6w_B; Sat, 31 Oct 2026 09:33:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9753F40B33
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439219;
	b=cCfRm9ar4hp86mIuTfTeThxKV1F1SEn8BeRG9o2+0cWoYaynXYZGKl3dXSGco8PqryDQ
	 XR4nR5vSWMQ3H9dczPmmrh8zkmBm1nIInpnDu8UIVzj+GKXk685irAAp9QtbKZlP+u5tB
	 Ww0Ht4hiYERw9hLhTwsZFuGlmKBnSrrPEJuqESmk18eGzfg2V+/dkc5FMVblD4kMU0JYs
	 NZsezBVxmRn4zWPNBvgkl74oCm5RqESkT4mYUkjD1pmD60m6nfbC4z3kaCOkukHByS3uT
	 UwbQwCEgDyrPcwsz4jCzg43Ad6RUTUrNph81cELfIbTHLPtBT572gY/5vAH4s9s0r4w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=C1Ez7imtwohdIQ8VZvB7suQCVR26Q8GQ48l7phI4r1g=;
	b=pWBZrRs3KHDqAouhslJI1TEDfxrTzLc5fWuFEy87YCStkJC3eBGXXm4/z7FpwJM738u8
	 fssME4KJIupPBX57OC2/O/oSlEmBBSNHe0moO0IZDmiFrJMwsVk10C2+hm9EfIrx2SfT7
	 1H4PIUPGHjLZ3aZ/lP0tKwzWND3g2KvxalUgx3bq738SxxpiH1ibbNEnljZ+WFDLnnH09
	 ASV3ed/VtB9/M0qmGHthHjOqalP6LRzFRgVtUOSABcdQUehrex8RM8rlCTpRUBcd0boSc
	 SvNVAgGaqJBNZxJzOoOORWgRO8bAIKYAB3kTOTZnwmyFnvakw4LQUhQ/EfagSXetazw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439219;
	bh=C1Ez7imtwohdIQ8VZvB7suQCVR26Q8GQ48l7phI4r1g=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mt146trkoVk1RnK49V2Eb5W3UNIqFam+CZhEb0ULsSJ/rwbGToJrWv4trgFPZRFGy
	 EK5JH8htJGjTGVUlQ1lsoL8BYcyvMYEYRmqLUNG4OfUycOrHStcxn6X5YDCmjKelM8
	 KnP/Yq6CamrZScK13Ty/riGJooRQOrvbJhqN/y1p945Re1DPkqUfuZI0NMr85GUfLE
	 wtILr+e0eXc5GSF54LmJ83oFt17TVUw9eK2NTRoXCjTS2I+Cf22E9T6f1qZ7x37R+Y
	 i24N6mrQP08HxDzodPx2rU2TszQaML8BLDcnEamnqHOzwf2EZfrW/C8xbB1MkpUp3R
	 LVxoHRQ2nluVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9753F40B33;
	Sat, 31 Oct 2026 09:33:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 193522C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B0F9607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ie7hYIISvgHs for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 722F560667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439215;
 b=SOFlUS3at25KoNYxyQsQZzyo7EItXTSSFjkx207il0tXrT+dglutm75cFlNnNStqrndD
 Wt9B/nvNIDT3+JG/FedP1IX/YBfedF3Oh1S1zjbLuX0+3d9Q211fjYpn6VoyyqJUqDlW8
 Anm9WNt40ZqXUZztjIPZbX0yQl6uU4uJT6CSWFz0gxSzqDXw3lbN7I/k4PG3bpVDZDQ0K
 gKJ2n9j58LQyjgU2IFHhJVN7XH4l6OkkbnkY1xinh341pSmI3Lhl6HySDUhzLHyUG0Ip0
 nikF/J/6sWf4NWqklHXOVxGUMcuxJKrSZ6FmdIbMMkAHniFvbLi6+rhfO9Mw7WQQh1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439215;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=C1Ez7imtwohdIQ8VZvB7suQCVR26Q8GQ48l7phI4r1g=;
 b=drE9vmq9o6B+u+s0k9OSXt+zprchqmHFrptoROLpaJmOJ2AKwRT5A9tGFoBL7imQXPq9
 G9zAmadcdPnWDlPEdXRDfaWYLtT3cOcKJfxXuRqkMZ+DlIXcAWqhxE7judK7sTRJ3ai6k
 YpciCxkLYfBuSx4/epsD4sJ522LMFsfGfyql4MJYldzDLMOFImOCl66OXfm1CjoEGs90D
 ze9Pok/BB71X7b09LjaPEtdTHiWrDKXyxZ/j7DRMhdCpfrUEnLp8rSOuaVIUkiY/0OyPJ
 6wIZOk9OteuIisp7PRCxGCVoRbou2YQI+3ub8bBfTogqGWt0Vk6z3//Tb4hPCKYypnA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fqUgjzF4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fqUgjzF4
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 722F560667
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:35 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cd3310348d2so1137164a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439214; cv=none;
 d=google.com; s=arc-20260327;
 b=Xu2QDerfyqTLzwo2Uk+Km6jd/UfUuqVS982NamMqVTmTUkdV0jEARwnU+KJOTZWjtH
 enkJIZ67yF4WkQfK7+DsdCtVQ0KwP5ATwzQgAwT4016XAx0/bqwnLkqGnIBQ/UDVLC74
 8EZArBO7KGTFWMMcthpbTlZu+3KdfuV9XDfsobzxTkN4mV0Oxul7j70V2HZgcRQU2eW6
 7Jb+RcXZGjowfEevZM2v1TjrACxd6KtKdZM5oSwqI6iz4ss9Y2cNnk4OU1SV/90dwLOf
 jzyNT/N+Jm7Cr8otsfB4SATE3TnglcWa7uX+l4A/rlelnIEt3AWdHieLclNjJ36QPFIA
 2cQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=C1Ez7imtwohdIQ8VZvB7suQCVR26Q8GQ48l7phI4r1g=;
 fh=9P2qelB52H7K3YgqGk7g28WbQ2epH61Ck6k3Vh20C/M=;
 b=OtqGOv/ncMhWdYe1ZDcp/AavloHzbmlpDBZddnol2T7L2HnmeO8vPlq59G8xGip5YC
 +gIgLxVXlp9uwspBEaBPHVOv/au267A8ruvNhzHGPuPdo8ruf2M+wwB2UfgiMKrAuRit
 KC1UkRE5hSfb7TrdeLLMAf4c1jiv1qBgYZyhAoZ3KEvG8wac8jdqPYsp7eEGf+iHRm+3
 qpmxqb8xjsoKiJ/genNgANi1tdFZQksMQ86XFqdvSfDMIxzspuC37ujOcyCl2gGyGyDo
 zv7e9/3ckWeB+GaFDXHKwX3HrYb+CcZWqA7BSVz/lidLsU9HT3zDyXeTLcqD223ZfBQL
 R1lg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439214; x=1794044014;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C1Ez7imtwohdIQ8VZvB7suQCVR26Q8GQ48l7phI4r1g=;
 b=fqUgjzF4QKKm9DsYSDlG08UTqEQmpv6U4EmAjXsCcQnCHlM5TtkHGDpQJ2ZLV/Zlo5
 7GeZmtQkv3e1hL3Owz9PEseGN5UcgLUJQ742QU3GhsXcP2kRNth6qBoP6O0gevEf6Bxk
 t8TY+gafur/YcVQYjFhMoh2AiG+ELXT+g+yPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439214; x=1794044014;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C1Ez7imtwohdIQ8VZvB7suQCVR26Q8GQ48l7phI4r1g=;
 b=0Og1YFgJVjFt4qMRZmRSiwXBjYKzJz4tMllxOX2Xy6dt6CxRSkob/zn0Cth4kd2IsY
 e5whZTiPcR8bnWxgeEvFk4BRvfC7roR4heVLH6qa/ebCYzZOmcM95nm8fErLRw8ATe0E
 qYGjIX2j7xs/9hutOKppWj8W/FtnNCzroU+cyDmMiH3P157WQx13rjYuUbQqYfNwaEVt
 6yvw9Ewce3AijsBpHULmRzyjQlL6WEss3caWyujwm5z5udKdQFd0sSjTg53RawMaMAHx
 XQFSWmRvYwdhwIWUt99UZ6iGzlh10n/dj9FaPK/ky3z8euhGYadfgcidAnwWc8RGTKnm
 /oBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEzOcJR5HHhtrsFsmFbUcVR0KE36ncKX7SnwnKqSKiHccfTKtj73Jw/LC1t8+VBY9HUHE5kI8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI+XJuQJx7OpA1WbutK9Hk/fu++LrohO1rt0++PlqDIWR2pf1Gq
 BlScm5pjbYStixNXTkneKJumpuvr2CZaUrD8/YhznC1f4yoCq9r/UdeuFU+YSqsRQfrUp1eWoHk
 ZsapzJmq+9o+94HpWBHYJCTug/zUpugoPLwMIKfOW
X-Gm-Gg: AYBFou0xzjcJNuXCLFEJK6wNR0OJHidlZNDfbfUfSsDZcuF/fs2vEBbVjmEtMZvq99j
 UI5QzaIxefwDogQ+rT4qrlY48kNSOzZPnef91arO/GPpOi75OPybbCXPho2vvBlJHa28d/3PDrH
 socW7af06Wj1Q18ORF0K9J8MsftO8q3Gu5i7YocpyIAGRBmhRhvXMsCQnq5ONiaQj3/EYDOMhe7
 2WcQ6LiF96E4zrHv/HldVcMydHV/QhlLwoMFbGxrfBmiHasVhhdhXFW/nRA9ZseQhYAX8hMVyEh
 DBV8wl7zj2q7Fl0JRd0L7LpK7XSwLk3L4Kd6FgtbjJy18WSKhbCOqPJBtA7LfsEonHKTBQ2YnH9
 8elJB0d9O1W3avauHDmlu30WQjPfxmD1Uh3FgwkthnwsXSBSA7KYpmjY7e1VmJ3YxxLaY2Hw=
X-Received: by 2002:a17:90b:5624:b0:3ab:d26b:c2df with SMTP id
 98e67ed59e1d1-3ae89758b67mr2608739a91.27.1793439214619; Sat, 31 Oct 2026
 02:33:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:01 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-5-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-5-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:31 -0700
X-Gm-Features: AclHuK_gH0pohvsw_voCfFl4Z710iaAkvBiQ9oaP617dPLvTdKnuCpuPV6XPgF4
Message-ID: <CAFLszTi2HSw0dRUEP-cfGG3h1yeZcLBZ_hTHGLQabHzLhozROw@mail.gmail.com>
Subject: Re: [PATCH v2 04/37] clk: rockchip: pll: Always write the k parameter
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: pll: Always write the k parameter
>
> The k parameter supplies the fractional part of an rk3588-style PLL
> rate. When changing from a fractional rate to an integer rate, the
> k value is left unchanged, leaving the old fractional part active.
>
> Always write k to the register, including zero, so integer rates clear
> any prior fractional part. This also matches how Linux configures these
> PLLs.
>
> Fixes: b851c006a150 ("clk: rockchip: pll: Add pll_rk3588 type for rk3588")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_pll.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
