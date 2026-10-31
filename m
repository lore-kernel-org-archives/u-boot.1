Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A6606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PvGYTWEW;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hJ+HnL7D
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 879936060D;
	Sat, 31 Oct 2026 18:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWOok-VRiVlJ; Sat, 31 Oct 2026 18:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0FE860639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793472280;
	b=PdIqyPu+G1h7JrMdjXVTweShGlTlMOIzpUFVlRAfgAakCQUGu3exwaXD1aqY04OsdJ+t
	 /v9RDFguJxOj3ICH4aN5TAHetLw2al4ptQOch+HFoiiIAc2b6YZtTwQR3qhbAwtriZc8V
	 XkIp6XxOXSjjd+dXAr3b/mt93vI9dNCh292EJljHoMkd4anq7UogcaMeKZuGXHY0jzqLE
	 CPmvJ6/G4HdcQJYFzJimy2VHCd+s9Zp0Pnzyc2VKWKFEYKBgfnKtxhCIcPSIZOuSLIfDU
	 9cbzaIZWdBe+hGlTwSIFZlXqwDibXq2XPiIakgDs4zcXDRFPPMZCjXOOOvd365/1FvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793472280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ePAVnB6AGvL1MEsZJKFWYu2Dj1+xgwSZmV3S4F1uBUQ=;
	b=gbdCm8Fi8yJOOgmMjBORbONZMXyOzwavoQ8cNtzkuiLfkeK1iB9BgYsYn6JPjjJYaS3o
	 QQXNCeGrT8nFEne0qbr6yhaNafsv8dJ8ziE9yav9/vgbBIWNiNduYF7GYOVPxgmZITUYF
	 buhTL7dHmaCxenLp5qxnQ41S2EnulEw3hmB8wJGWWTopI23OKoW2gm3c0iAdaxWr1e1/2
	 I0TfdXQ5UxqgzAkSp05wyn2asuFm8R+TQQDJlOWp8MsVK5RM6fgt2tVkLy8CP2PGEFY1f
	 mu2e28+0JP7CdH14uHR1egPF15Y7In/7Bltb4mK1/rvN+5SdOWvTLA/tn2tWxRJFuEw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793472279;
	bh=ePAVnB6AGvL1MEsZJKFWYu2Dj1+xgwSZmV3S4F1uBUQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PvGYTWEWwcxeby6sfHh090G3/mOjclD7t+9FguZplqfg0oOo1c4oTGm6+qNf5bslU
	 seLlKnP4pCO+OuLRChkaV+R6kxnunnORL2j8VR5CJn+OpEq4VW54q+d0urNuFdqsul
	 1s2ydwbSm4MhFWurzQxFG9btniXnr/mjdj9+wtlqkPa5ujbDrSVEDMQg5OIp4b+zzm
	 Rl+/+NOJWu1o5Zuc5hamJbEzpAudfG+m6Layzi2e+FRwa4oLDg6xZt3IT2B+LnvwzD
	 HoREzpVMb8gEse2MvQQ+KrQb9UJofv+/VyYfYIuUV+WvEOginZJAf66ZmSEIyjK1dc
	 cyCImkCOcJtUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0FE860639;
	Sat, 31 Oct 2026 18:44:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39D40156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 18:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 327294063E
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 18:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6xmH1nbaW_hL for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 18:44:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2ABE840638
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793472277;
 b=D20miClHkS6QEqobPrVowLH41x8WSUle0v8jKu3peG5bOk6ejxvLm3qMa9FwO00uZYOk
 sVUP3XVktlpWLpbbfY0G+0UCD35udS/qoGl1H1mvRuTzE2yeOeuZLNsrmGlpDzXh868mF
 yLMtWnKulJujPB8yeO5xpAGSXt2a61iAroVAkRc1+7KX7+pwZc+SGf+nkgqShe1w3AIo9
 X+Ykg72Wd0H8eJ8RPQqJFEozRA/GCD2ZUF9df0GwAuoYgKR9MDY3kKfd3UL/syNW/pJtD
 Mj3uw7mfuUEzF8LiKb9PSUHql03yjJ1JOxas/JX9qbgh5YMLiaAuROYYQArU4ToQb5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793472277;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=ePAVnB6AGvL1MEsZJKFWYu2Dj1+xgwSZmV3S4F1uBUQ=;
 b=ABaGl1f6GUgnK6Ic33A9tphX4DvL4w4dUHvFGC9/Zd1KTuZUz+Va6ZS7BA5KODbPR0wv
 g1jNxbDSBee+YnlfCZNukvjn1HXvKD+Pt5gYxEEHkQfArmRdDeB6AUKo1OdbBvi03jPMu
 4anK1I/zSNCuxFUDQGHiTT7zYx1MCTuGhPrkBtili5/7plVMWQAOeXLnQfVxQDfza/mPO
 I+Hax4oyY1ZEBgO64VLwXXhpUzTzDJnim09SQzW+sj7F6PqvlOR5aCdJllL3mTcaCAweK
 mcJ9pe/iNGIxHk6CM862XM8wiSfWsRV17Y/mgt4U5Nw1i6xR1NZ5HoJDLyu/r3oFO9g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hJ+HnL7D; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hJ+HnL7D
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2ABE840638
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 18:44:36 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c43fbcb4393so267372166b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793472275; cv=none;
 d=google.com; s=arc-20260327;
 b=jsDQwiGJ1HNC0SlTqVs/Hnns8SNF4pcTsnUDPqOiW8uk3twKL7tQ1Semzq22ZSJnPt
 5MZ7uS8c37f0MjC2bPPD9O7IowiEBeY5bqUq9AloucusqoRQmmfYyyzKt7pQte8EPcIq
 TAy8ygHHwrWwS/4BevOzIT4es/qCdLzRqxZAk2KGxJNNfsYu/shvQABcSjkkuiYFhZE+
 HAyh5GUmUN9lt1AFu6SRWlf0Wa80K9Opq0CiBa1kYeCzEgtk/c/A0wIcPYMuCmS7sViP
 9gizRyurwNGTlwIe8dqJ/tlp5Kp1vYHVBMPEv6HCuLefEnIAn/w3bBqTeFokAkzy3iZq
 XMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=ePAVnB6AGvL1MEsZJKFWYu2Dj1+xgwSZmV3S4F1uBUQ=;
 fh=94hpfNxGkmWceG4C+TAmnmtVLp7v6YgYkeuhivfQq7U=;
 b=Twdc0s341PpG+9g3RgZdlT021h09l1cMLTqmeBRgFefTOyyN7EC/F8z73WGJ8pIZC2
 CSH6EJm0g3kNyFOR30N15SoHgJvhwTI/GlwgVmlBtEDcCPs/WlzhYatvoRVW836u89YO
 SZT9yHHe6B09N13ctd2xcZt2kmTwjQ3Fh3KTICA4+I7wNy9tUtUjP7bWbFIwBg1bCK3e
 R2PZjmBMj9/6f3Bj6Q28tta5ruAl//K7HqIEozPkMKk8775xk9NSufyrZfLukXAXq1oj
 c4WbzTPv9R0agVZxWKkwOX2ETHZunBT/jX4WR5endnuQ9Lz7rGdWQ6w8c5s1P3MSLVkr
 rqnQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793472275; x=1794077075;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ePAVnB6AGvL1MEsZJKFWYu2Dj1+xgwSZmV3S4F1uBUQ=;
 b=hJ+HnL7DI4G1W7WR4oASzClnLoXA/XtLuaKaCQ38NIgeyb0PGH9R5Mj5rt1jCwmIiC
 9Zl+y0VoYBhXyZ/EVP+rZAZDWFoA1yRiK0MyWDLmwXhX10a8v1SQmgZIp2JRlOobX6dH
 tZQNTKjR2SSErpmrT5tYZD18kZbtXrwdyOWlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793472275; x=1794077075;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ePAVnB6AGvL1MEsZJKFWYu2Dj1+xgwSZmV3S4F1uBUQ=;
 b=aUqC1576GjmAjrkd3W8BzJ2uoBaqmimbHxTHEIKd/3wTVCo2LJI3XWCMe6bPnF5J90
 kCM7A32Tj05f3DURmyvyAqR3ddJs/SMFX6KcQ1TvMqCxux/bJk3uKrAmk0nXqBTnKZKx
 SVMJp0wOW/UlSulaE9wmKDXW5Qs0tFl9YuUNhjRzhLj7fePs01EGfPXBrxCX4abySCNv
 +olg35IBngqvwgD7H0S/2IxcvR+tqUJDpv2x+sECiVuH5iTSmf106ioSjBYZX3C4GP7H
 95oyH6I/AV9SPLc9MHE9w1P12U2UuExiLrrbxizX3UFWWRjaycbcJZ7IpnBu9sSyXVRj
 kwuA==
X-Gm-Message-State: AFq9FYIUhQsCrrfsks++w1zEiOAVS9O7fofL+kGwp1PCNtv6ofOLafPo
 ZdU8/dRAPf7sm/5IBBbOuPWhmCEiHx9hOgR6cTbEgxfTptlgwmyMS0oh9s+3Y1jorKQ3lKSss7y
 KI0Zcl0J6DrEtpc8ZzcepPKu6SOKOv+QOk9DJDXrX
X-Gm-Gg: AYBFou2hra0fd5PsNyPlimtQmwVQNAglnzg1+vgzKPlLzHVvNNp9C8fSpIMPyJwcpbP
 Mmrhr69r1r4D2HzSAwbu+cl62iPPWSL6to/mbLoeTBnsMTHXc9swGpZLYVTk+LfYT3IrtVwEohl
 OXhr0TSQN4WFtsN0ioLWI2mPwSVhjurj+3x9q4drUG5TivdhyZWfPdOeXihNShM85DyRlUPfUTp
 B7vqVXusiQeArd2Rr6XOgf8TxZanQaJBaHZCDmHq7vO2Mj4A+2b6Ya+KoSQoQjN39rfjnvO6uFC
 cSpop/2nFnewpcR2E5gEZ7QzxhEtoU+KcyVH/W5QRma/p0N4fmaMmtEdl64qL4B2Gh3i6814nCZ
 5vL2Bn+aM6nPn4momSqqU+EEZuBuxGA4v4WizUSYlIyjFBw4uZdHNZL3QzD2K6k2DxYfYBuQ=
X-Received: by 2002:a17:907:7205:b0:c45:c030:732c with SMTP id
 a640c23a62f3a-c4ca7ab0a5fmr495415566b.41.1793472274765; Sat, 31 Oct 2026
 11:44:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 11:44:33 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:16:29 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-2-2a67384ed0ef@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
 <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-2-2a67384ed0ef@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 11:44:33 -0700
X-Gm-Features: AclHuK9ETKlwqIPmQbUdusH5P03-sPFU6WLp_FeW-WXapuAqpYel442KaxoNw2U
Message-ID: <CAFLszTi54DouCiL-JPo_1NztwBbRNve-dyQjo-s1Od-kQCG71Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] dm: core: Add SPL_DM_EVENT
To: msp@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, 
 Udit Kumar <u-kumar1@ti.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Julien Panis <jpanis@baylibre.com>
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

Hi Markus,

On 2026-10-30T12:27:40+11:00, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
> dm: core: Add SPL_DM_EVENT
>
> Add an option to allow DM_EVENT in SPL.

Please can you say why this is needed, i.e. that the K3 SoCs want a
spy on EVT_DM_POST_INIT_F in SPL, so they can unlock CTRL_MMR after
TIFS is ready but before any device is probed. It is also worth a
sentence that CONFIG_IS_ENABLED(DM_EVENT) is currently always false in
SPL, so with this option dm_init_and_scan() and device_notify() start
sending events there too.

> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> @@ -117,6 +117,16 @@ config DM_EVENT
> +config SPL_DM_EVENT
> +	bool
> +	depends on SPL_DM
> +	select SPL_EVENT

SPL_EVENT is inside 'if EVENT' in common/Kconfig, so it depends on
EVENT. That is fine on K3, since ARCH_K3 selects both, but another
board selecting SPL_DM_EVENT without EVENT would get an
unmet-dependency warning. DM_EVENT selects EVENT, so I suggest adding
'select EVENT' here too.

>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>
>  drivers/core/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Regards,
Simon
