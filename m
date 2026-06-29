Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B435CC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB34784A8D;
	Mon, 29 Jun 2026 14:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OiJm2XIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F131849F0; Mon, 29 Jun 2026 11:17:09 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A90849EF
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84592b55832so1445189b3a.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 02:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782724626; cv=none;
 d=google.com; s=arc-20260327;
 b=gUYIdWS05/P1X5Yc2qpjKeQGk6Loju/onLfpJpDCBt5ZpmZEIl7kjo8dFfN3eUkE+h
 Zd36N1uZt8R/eA7hOO/ZajO3BazxpjmA9ft11n+Q5zfGrhNJCVhzKdqEW9uSLqohZ9HN
 ppX8msX4JkQVaIN62ttCp7MXxbHiUgE2i9HBbfBnNi1YQaBflJ5SjcItMnItqXj7WE0K
 t+miZ6ATH6G+XSxJkOqO2LdHO2RFB020f0zYBEAzS+FcUO65mgzfmp9wx7TmA6nsKK57
 e+m7fuBVKE/O1JkXOGdCKrp5mjKcJBefi97QDI2DLwiBzXElRRzsSg+nALWmerlsE6je
 1CtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NtB1wpRsmhknfIR7L93LUTftOgZ+wIGsGCYmPpNcCyE=;
 fh=Oltvgu5KGJighkHk9VxD24cW36d4fpjMO+hxcoLd97c=;
 b=P2Z7rwzgjyTb6wlrvP5kc//mSCSiaQR93Jlp2aDhdbU9XfureQIgnc+wMfLh8EmWsV
 NOV4QL1xOJKakFuwWQ4g/WA19LPEi4nen1a5OVVy7I7/gfEOT8aZSg3vC5YEXVlZD1as
 XbHqez84BxSq/kpAMdeweTvBtVAyxUG+9g0p1EvHWABCt3vBEWCqjUYk9q3/bJxdF3W5
 IMvhP9nW7DJUF1J1YmN2GjDCdM6VShIjMj1M3Pw3cEPrRuzKkeCIHpO/vnGhoFkFMu37
 7pJCYc33IE09uEJuPNlUAPMZtOda1LhJLs53lIMCrESe7/Vf9FY5sXpUDMmEce0ifBlo
 usSg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782724626; x=1783329426; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NtB1wpRsmhknfIR7L93LUTftOgZ+wIGsGCYmPpNcCyE=;
 b=OiJm2XIVqFDjxGHDdlVp+DaG6dm95IxHtSPBUwXJsTTF8LtIi+xZRSc131cKVtCqQP
 qm9DP/1Gs50Wz6TxarfVuGT7RNyBVQWxKDokCtfJ25khfvXoLWKBMAxTr5pEZvaDYGap
 6rlFGtiwevJ1WWyKs34hJva1iE/CPJfcA+0io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724626; x=1783329426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtB1wpRsmhknfIR7L93LUTftOgZ+wIGsGCYmPpNcCyE=;
 b=JNJH8ZlGi0pe3Wx7GdpyOE9wS9d/Pj3qqjtrnj/WTDW43tw3HdRGG+jwVcUb0xQBVq
 qWByv+0KEHwOv1KL8/CYR0RI8nSNURzqRrUoriw7kU81sIiTqQQ+1czkXDDVV0Fxin2F
 EPokn4I5Wg20w2dM7kvOGilS2eoLTCEUfGBAITqeACAeZeb3zg3tRU5FXLFYrYZJneGH
 uzdOUzyPGtB8pqR14agtpuN4bgQMEM/75rfCrK678wWSF1CUbkG4/RZDqgXS8uAOm9h1
 rRuiyCd2L7AGm3avX1x5WpZEZl/9Ki/s4j4rtUe5204oylPF+wq9G+amrVhDkqFI5E4m
 tTEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbKc8FfZu3nal2ejnw9ryb5WXByPib+WQX+7BK4C4QFcofxy2wb8XoyuwxH2VX6QWIDeb3zvw=@lists.denx.de
X-Gm-Message-State: AOJu0Yys7Eax3DLXJqK52o52Vz4LTk+gGXqnso6UJSTGCUPEpi9Y/bBr
 Kv2i4LrB0oM8TvMzoFKUGEVV84c8YB5pshUwFeZUJkKbxq2mu1tL1LR2YwOQH+gnn76qR3UoJOx
 RFF69/TVWq72wt++njKVcGi+4DZNyhmDNJthqhuUx
X-Gm-Gg: AfdE7ckUXvRfbvl34BSiHWrgK5o4MeNFeEbI+heq/7m4yIWmRgx5NgZ+m7kjK/mSOf0
 3RYef8EaMrzfLUL65MUDyiEf2RROKLrFRdUl2vZkmqltKl5MqQGKWarh/ml+oldU1WSVtET7B6O
 2/xBB1C9gOko9Yof+oxeI0wdM1LEoXQXfF/x91NpzIF4E1hPYojiZDRnTZI/Jgr42NsK54Ri9EG
 rCIabbXMzkRa9CMj/2N7XXVJysfJdgxrNHmUyRcDc0gVx5SM7mm3faRAvwN4ProZmvoobiC8vOn
 hLcIldwm
X-Received: by 2002:a05:6a00:98b:b0:845:d274:bf8d with SMTP id
 d2e1a72fcca58-845d274e540mr7570171b3a.54.1782724625922; Mon, 29 Jun 2026
 02:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-10-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-10-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jun 2026 10:16:08 +0100
X-Gm-Features: AVVi8CdTOHXBJ3Peh4QGUNO6ZpuZXGrMBkQ2ehqwSGuZTrvcCv6uJU-b2pzV1XI
Message-ID: <CAFLszTjCfZiwOGec2xU73F5g3-dvmr9=+12QPqxwHDJbiU9W7A@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] mach-snapdragon: Add commands to create wrapper
 ELF
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, marek.vasut+renesas@mailbox.org, 
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com, 
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com, n-francis@ti.com, 
 mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 29 Jun 2026 14:47:37 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-06-23T06:47:53, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add commands to create wrapper ELF
>
> The IPQ5210 boot ROM expects the SPL binary image to be embedded within
> an ELF along with additional binaries. Hence add the relevant commands
> and linker script needed to convert u-boot-spl.bin to the expected
> format.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/mach-snapdragon/Kconfig                  |  7 +++++++
>  arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds | 18 +++++++++++++++++
>  scripts/Makefile.xpl                              | 24 +++++++++++++++++++++++
>  3 files changed, 49 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
