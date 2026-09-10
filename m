Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87152C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E4178109C;
	Thu, 10 Sep 2026 14:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oYds8XygKXoY; Thu, 10 Sep 2026 14:09:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 77C0281046
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049376;
	b=kYOXHhhnIzsAI7u+Zz+vGZVSwin/ATLhFkZl3Y9qUdgsYMnuPy65P/8SLzEuxhvgSI4Y
	 jybOEpO8NIGT9FO18hgiLvXMsrw4tWlGgGr+Hrt4qoPv32anHQ6ctwI/rrHeTLyzbyyty
	 FV2BU25oK1zscuEFWYCPqOd7sPzXdZmOyaz82I6L6ZYJfGgCjYbqZEJuZRoCOcez4gIT2
	 gzqzWKr0SigeI6fwvS3Jyl4I0OamsiKf78VFMU4+9MjUthWbO7D9qEJIDsJQbUiZAuDgx
	 GlxBFwcFz+XMGa+gZ/ZGNvnOC9Y0OzBsKTl2Xvkv2E3+vXtw5558YPo/eTyhEhIQD9g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RWBlW6wZOp3WFUwVk2glx7u3QSfp1rcWrM8MCDpm3lo=;
	b=lHSBgk5iX5kj30kMNkcHyC9ktUTodecbQEqEszD86KVAFOmTShqrMTlW/lrcgk5CLECH
	 PTVOyGwAEIwmVzxvD2cxjwS9TIup5vTg+YgpISjRa0/7p+RsyOr1PpONnYOlElfalTfmg
	 jhxxBBsVpNmJzK86yliu5LaP3o5PnB8ohRBAVBruUqR4LQbIgh73yZOPpIEPfChKQhZzJ
	 KRwU0lrw15lK4rZaIoqBgD9eM4mYPfEQ4twVcC7ZrS39vhZYzWQXv5g1GaDXXBbpJlfN8
	 kPBmHHl3d8t3hafJmQNOsynQGOQrpTdpG7Rz2GbGO/eCX8fzydUEInzmidJC19JTpYA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049376;
	bh=RWBlW6wZOp3WFUwVk2glx7u3QSfp1rcWrM8MCDpm3lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xqsvDiBcl5ws4BnDGrVDw15zv9WWc/arrckhGfSqUeErZ/u/htP4BEw0JIlL6AM8p
	 qthM7h4ita3orqsJZhD0Iqc4py6d1/fswVvoCdOu6PKbEz+MxxXA0/ml1aMqtONwbx
	 5+Iz79DT+kw1vBXln62H8XDqbV8FTn/GxfNb5twjo01SSJShOeFAVRrgukz/ttCofB
	 y5uz1FG3hctfSJl8w6Ane5MsPCWTU1EqVYwrybEjZ3LNZJO5D4ydh3rdB/7sHQY8v2
	 cQh6wnmXK3b3Yawkw1wwmON96irP1Fs2EvqhpYDs/BdvU3/yXT28UTViPTQDhi5Dwh
	 ENgf1AQEQpytg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77C0281046;
	Thu, 10 Sep 2026 14:09:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED6E8E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3E36400E9
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NcNDtI2-mNse for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:09:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BADC840024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049374;
 b=o3/ZXHGgkjXAINrnjbyAYG/JLN/MzgMz45O4ID/VPj+dhMEn2oug1R2OZG+ZckF5ET9n
 +NJPG2eLI2ODKZXPJyVrXH7EOF2AquVc7tZ9UesPsl9bOZgKEUEyxtZB2tD5mREJcFGo+
 Zp/wOscO0F+g4tk0DxreKVNH9JjO/m/OpDfx+/2RZUgheKDAnNiPh6PByCoft5XEW8ePe
 dH3bMOt1ND+Ea6Qa0Tb3cDkVpSQEr3JTL0Bt01N7Zh84n9G0Ui6RMNCEEZSTY2KQPYwFj
 +w5QxwncYZgaQ+DprWunPPxucOSpdwLU0JMaUuV/QZjKsx2+FsQ5LjsQyyFBU65t5AQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049374;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=RWBlW6wZOp3WFUwVk2glx7u3QSfp1rcWrM8MCDpm3lo=;
 b=Av6OYgbq0eOf/3cWbBamaR1Dq4C4EaIQjybj1uV2KcVUyLsocTeqSpS9UTWS9pUulzWN
 bY7+jbSyR3+xRTyoON1FioSIhuqFkMkt9SEbxYRjRmncZADCfxIXWzD/P4M3S1mnkQGJm
 X1AshMriJLM9Y9wsA0qz4CjV5qjKbdXTWthfHc5SR5uC3zcNDeRI28EG9C1yVofW5NhWU
 LD6eKRMDFpM+zty/yQWMSTMs/XCky/fNrkTUlkQcu4juql7tIRablIpDMInVn5vlPZZLV
 Zn0UsnL2lBanQpOB+f+CClxgsimvnMbMMFWQnZDOGyALzoiCT8bIuf31r+y7GIvx9Xg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GKF9TG53; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GKF9TG53
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BADC840024
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:31 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60591bb18so2455729a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789049369; cv=none;
 d=google.com; s=arc-20260327;
 b=nL7FQPH6o66sJMgnwUg3ooeoIp6JSHprsouUKjaiY0a4zDwoZn1Xm0SmDHoeU90ADj
 rGQzMjqjYISG7+MqtcUofsmi6HQExbqBgtLkK2nHT694sPFJkHt2XidWp1c82gt54nRY
 iWsk9yT0L6CmwGUrIqCm3A5QOsYh28yNXyfRokAX+xTpEVhS6Uotfp043fNYWt/0NMFs
 Lrmpp8zCUT/1NfoYkg7RUh3HsShLCuPuiA8BqbICV3r76w71mlI0iPW2WLMJhnUprd00
 H9fDIE/SCtkYVaLk9XbBchNr/D06QV7LsIF5oK5Rl2OuxR9SThs6+0vjA7SXn9YDvn75
 yXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RWBlW6wZOp3WFUwVk2glx7u3QSfp1rcWrM8MCDpm3lo=;
 fh=Rvz/p+ruNzUb4puegf66eFpa+EapnLAG2ZC8O3cZ3Vk=;
 b=d5FzL3s13DIjZbrrGcO6SG1b8vMzleRaOPUQVDM19qSzJhIhTNZJFrhdkPLgfdsluK
 xQFHajVATh5ZVzXUedPEHbZ94GmPyTpiIugezUEPruExXr1YWZsseW8HXCKf1JSKmMth
 P8Tt0UY48U1qyQfP7/bE1a0xGGbZ0OHc/7UcjslHk+hKhfKacMKuY/xiTO80ww/e+25L
 /9xS+giQWxGzaYT9A1l+nS+/7phJYGZjbk73EhwMF2mglGQzj5xFhFjek1K6VWSOvwav
 AfAlDBvHXm/bQqJNbRzx6KUsLVn3rJJfhx4Yd0piYaxeXhZSNYPpB+WkfP/4acmeTg2c
 meIA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789049369; x=1789654169;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RWBlW6wZOp3WFUwVk2glx7u3QSfp1rcWrM8MCDpm3lo=;
 b=GKF9TG53FMBH/9LajETLfCYQN5aiDoYlDsXemvUMulVmBimOkqIbn7XqqnWzn6rXAC
 oJUh/tkH1icC045uZ8bd1j0q1rtZOvJQIDZq3Y6pJOQvS4e5Ll3RmrwR7MunLH7hPLnN
 oX5XRHJ+kzq5UH/bnuW5moYO943QAwTG0m19Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049369; x=1789654169;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RWBlW6wZOp3WFUwVk2glx7u3QSfp1rcWrM8MCDpm3lo=;
 b=No3y0ZcupgZQuaJMi5mRVBLoK7Dmz2ClXK/mGfCu6uzyV1SWAXrlaNwbzY/QyscmKZ
 uFSwVh73pZ8TIGhSCTlLpISfmEZC2OKt5Y+V4QL7Zo2ON8LZ36Vxmv+96SGolw6gybYd
 obBKulwyDLi925TB2rXcmMYuRJK1M0oySgaM7pIq02ceovLYDm9Wb8oV38mMWWKOaIw/
 i2TRlWyIM3kNzaaGXBkCJwVXpJgj1hJywvNjOvYyXyiuCeTZrZWlIyohryrcplCds+yJ
 bGaAp8UfavbKSKEqk9MnbkQ0BsdEfR3YH1Q0NSATD4/pldxz+d1gI35yMVBoYAmocRef
 N4dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4Z5lL8Dcie0p2dE1fh9coZ0/g+zeYy+60io7x7KTTRjoW8EF+VgimK9db50rkN5bmTnNd/QI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kMvlraxnuybllivkCHRKgQ5UF1yQ69MG9nRovYqd6T70ldQSdk
 Sv9OHp9fbN+St7fPCkJaSSBcPNSFlHyuJoV+6E0AUWROAskeobG/hfRjWeHjfDXspKmcWfWc5/C
 l8rrQjiwIBICtuHDwMOavnncp30aQUCNbM8benHlg
X-Gm-Gg: AYBFou23WUxjj+MCSycZ0KDttHGQIzAxY2l36tNYtyqxDM34F+mYKDaZwdln+8xSRLM
 Bvc+DjN5yc5bKL5ScLmGwH1lLa7rzQKH+5ElFQJEeL9zCvMV/E/KdKswmPbl79OPH3lM1jTP9J+
 2YWqL9sca10N7oWy4Ujp4rPxMeRGWZR7Fb9hGf3QHze/RAgzezw33KQv19c+Ifv66H2CIqD6Ku9
 mlgX1ThEZDAyGzPyoERcnbAC6ztajE/9oLLFqC/TfwCpUl7PypIgTcDp2S/B7khKZD0w56D3YKD
 HMz6iVKNsRxFl0jhq2mKyhyHbLZO4mOiX6J1cxsKzQn+ju6BaJ/S3g==
X-Received: by 2002:a05:6402:5d1:b0:6a9:9c97:baf4 with SMTP id
 4fb4d7f45d1cf-6a9a325b1efmr2364553a12.13.1789049369376; Thu, 10 Sep 2026
 07:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
 <20260828105210.32664-4-mehmet.fide@gmail.com>
In-Reply-To: <20260828105210.32664-4-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Sep 2026 08:09:17 -0600
X-Gm-Features: AcwNN1WeI9LPOEzsdigqGdjky10bZixRKAW7sT7wCE2ENtUOBRR2XAy0ZLdRBI0
Message-ID: <CAFLszTg7aAQQc6EaQSEvkT4YbFpQdKSWzskQpWTAZ-M-H31iCw@mail.gmail.com>
Subject: Re: [PATCH 3/4] doc: driver-model: state that of_to_plat() must not
 probe or claim
To: mehmet.fide@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Ye Li <ye.li@nxp.com>,
 Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
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

Hi Mehmet,

On 2026-08-28T10:52:07, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> doc: driver-model: state that of_to_plat() must not probe or claim
>
> The design document says decoding the devicetree belongs in
> of_to_plat(), but not what the method must not do. Spell out the rule
> that has always been implied by the phase separation: no probing of
> other devices and no claiming of resources, and point at the
> parse-now-request-later GPIO helpers as the pattern to follow.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> doc/develop/driver-model/design.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)

> +devicetree, read its description into the platform data here - for a GPIO,
> +gpio_parse_by_name() - and claim it in probe(), for a GPIO with
> +gpio_request_parsed().

The final sentence reads oddly - 'for a GPIO' appears twice and the
second clause parses as 'claim it in probe(), for a GPIO with
gpio_request_parsed()'. Something like 'read its description into the
platform data here with gpio_parse_by_name() and claim it in probe()
with gpio_request_parsed()' would be clearer, and you could then
generalise: the same 'parse now, request later' shape applies to
clocks, resets and phys too, even if the helpers do not exist yet.

> diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
> @@ -759,6 +759,15 @@ The steps are:
> +The of_to_plat() method must only read the devicetree. It must not probe
> +other devices or claim resources such as GPIOs or clocks: ofdata is read
> +before the device's pinctrl state is applied, so a pin claimed here can have
> +its configuration undone a moment later, and probing another device from this
> +method defeats the lazy-probing model. When a resource is named in the
> +devicetree, read its description into the platform data here - for a GPIO,
> +gpio_parse_by_name() - and claim it in probe(), for a GPIO with
> +gpio_request_parsed().

The new paragraph is good, but a few lines down (around line 789) the
existing text says the opposite:

    It is important that the of_to_plat() method does not actually probe
    the device itself. However there are cases where other devices must be
    probed in the of_to_plat() method. An example is where a device
    requires a GPIO for it to operate. To select a GPIO obviously requires
    that the GPIO device is probed. This is OK when used by common, core
    devices such as GPIO, clock, interrupts, reset and the like.

That is exactly the pattern this series is outlawing. Please delete or
rewrite that paragraph in the same patch so the document does not
contradict itself.

Regards,
Simon
