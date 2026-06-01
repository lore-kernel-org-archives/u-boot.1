Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7140CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506BB848AA;
	Mon,  1 Jun 2026 16:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ASj5Igco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 555B7848B0; Mon,  1 Jun 2026 16:54:34 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93A3848A9
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-becfa735b9aso175970966b.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325671; cv=none;
 d=google.com; s=arc-20240605;
 b=Xl8NXHnCkhsr2RYmN/aEKhNtO7sz9n4sbCkDDDnKDAnFpGWmPoHHiHZFYMG4Ovfwf0
 M7Xog4BGoRImfjugzYo4NlKJ6S+0nm0ULLe3wzIixuQK7ac3j/Ugz1ppiyXtMWIkEizF
 Xvk1DnuGX42UHcGEE1q6kIcz6u0GPC6c0W0VQJ3tVYL7F+JuU8Npc6PYOvLEEjsqG/2L
 qoegtTmY2t/4VjTKKkjS7SOcrrzwatR8yKCcbzYV11Bv6puXnnQC2wVUXMXF8vUhXrcm
 +UwqulsRqz4aALip07HJIevqj1S1MYW8/ADUP6MtL+DiX8y5JgrdG4tpXSlD5Tbxx6oF
 6KhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HkE1p9mwhiVDGIbTVNG09Zh41PqjHNYkay4JmAZxiL0=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=J+VbeY2/kqTqVr85pzxP5ft80Eoz5/v4lcsYcOJlQXBQKNJlxYw0DiTqZhTnEt/wL9
 oulaYkDW90Tko+hnVg1MJqLie7Pqlws/r0431Ui4aor0VZEYzQHxmcmUtWMcxSSpqjy1
 LLu8BpZMw6OYEINYsL4tRIK5759PUqrHXPASRkaGlzLdK5GoJMLw7NrPQR2Zh+XVKtFF
 bLdQM3andzIimge9jMjmjaT/vZTmATqiZ/HkgOibYtWNV+L6QCdryNrZspLotcg+Ttd/
 LAe3kA9BctTuRceX6d3i3eBb7beVDvKqgVB1q5tiWmP3/6OZsW2xXIpD8L7GcH9a0BlS
 0BsA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325671; x=1780930471; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HkE1p9mwhiVDGIbTVNG09Zh41PqjHNYkay4JmAZxiL0=;
 b=ASj5IgcoI1AUb9xxdKQ8RyzR8LU1Po8qvjADw18TnzdtGelXvlxocg4D61h7ZOAwSn
 pLUjOs649XCZ48sFmMVRGvCBv+t5bhPHzJWaIRf4gOksCsVq80/sDXANQimy7uZLg5bX
 IkR3KAJ31tkZp6cMWd1m06l71ZUhnoEFobv8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325671; x=1780930471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkE1p9mwhiVDGIbTVNG09Zh41PqjHNYkay4JmAZxiL0=;
 b=P1N8D2i8oEj9iGttBSKhtzYV9PN1dmBx0lUu6TpUUmFk3/zO+1016+UrOkq6VLNtaW
 cDkOSPNZgeK9+sz9qzIcdKzT75D5lNGvLBQ6c5hqjXx3u14M+rcTSJ+zhZDuwd0trY7N
 OZz9TM89jZOk7HqcsR+ebpoRJbiYxWLfrBciMVMrxlNh9mjz31mOAoUC+iXr5bwmITdU
 cGgQFlT2+MqscO9DEOPVX3na1eX7PJo6VYHetsgEkXzcsXEcfkZ/FMCXVRlvbmq8UjJz
 YFinb3jfax8aqJP0TKGL2b70gUNe0VzCiZPAgeXTAaD48LByk3h7fgbEn9ufiyNIBuRS
 17EQ==
X-Gm-Message-State: AOJu0YzcpOH/3cgcFpLki6NBMsSASnp8vptcOr/gu0/7NH7nAxUgrl6q
 zzAQyc9nbsj2wCYSDAt+5s0lUiWzJcZXZC7ho+z+1Rv2w0XpixZAuIrVvb/LcjVF8U2v3eg2oJ8
 vnn6nEMbzx/anOoyH1AlmEG0JYCKUt7srUPOAuvBy
X-Gm-Gg: Acq92OE+lKau2svjJkHE513cAPBRvoAXg4HrpR3djgVL6EDsns5C7U5yCutuX/9zcqN
 lBcEHmvfA/pw1uMOkC8Ie55cJsiX21FoVCQgeLmCMoyc7Y1ccLkq61xp43koe8tvOPomXfjqbYf
 1dGjAnMWc3+0/aXGbpOorDgSwxyh0kWTrIIDCpHS4vDM6z+ce28W75P1Nzj0jtGX7uFrtsfLeUU
 yQBL82vQQtKVlLWVf6SdDuo5iYh8LIUpEh3kn6BOtLehFaFI7ddiWVSuoJiMYeB0QEy3R4DyyBw
 toJv0ggURYo6+hIm
X-Received: by 2002:a17:907:97c3:b0:bd3:32ce:8902 with SMTP id
 a640c23a62f3a-beab5ff02a4mr736361966b.39.1780325671304; Mon, 01 Jun 2026
 07:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-2-dmukhin@ford.com>
In-Reply-To: <20260529034839.2075806-2-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:54:18 -0600
X-Gm-Features: AVHnY4KsITx3jnsoMyww8E70SKc64DI4X9KRWJtmApTq1F6Q21GypVmv4Vkjpm0
Message-ID: <CAFLszTjYa_=jNmRXO5rbMh4K=uEimwBdq1HS1iNmtAGhznVfqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] reset: Allow per-board reset type
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Denis,

On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> reset: Allow per-board reset type
>
> Some prototype boards may not have (temporarily) all required reset
> types supported (e.g. only warm reset supported).
>
> Add a Kconfig choice to select the board-specific default reset type
> used by the reset command, allowing it to work on such boards.
>
> Keep cold reset as the default.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/Kconfig           | 31 +++++++++++++++++++++++++++++++
>  drivers/sysreset/sysreset-uclass.c | 19 ++++++++++++++++++-
>  2 files changed, 49 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> @@ -57,6 +57,37 @@ config SYSRESET_CMD_RESET_ARGS
> +config SYSRESET_CMD_RESET_DEFAULT_WARM
> +     bool "Warm reset"
> +     help
> +       Reset CPU while keeping GPIOs active.
> +
> +config SYSRESET_CMD_RESET_DEFAULT_COLD
> +     bool "Cold reset"
> +     help
> +       Reset CPU and GPIOs.

This is very thin - as is the comment in include/sysreset.h - how about:

"Full cold reset of the machine, including CPU, GPIOs, PMIC and other
logic in the machine"

> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> @@ -57,6 +57,37 @@ config SYSRESET_CMD_RESET_ARGS
> +config SYSRESET_CMD_RESET_DEFAULT_POWER
> +     bool "Power reset"
> +     help
> +       Reset PMIC by removing and restoring power.
> +
> +config SYSRESET_CMD_RESET_DEFAULT_POWER_OFF
> +     bool "Power off"
> +     help
> +       Turn off power.

Could we use the 'poweroff' command instead?

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -150,9 +150,26 @@ void reset_cpu(void)
> +static enum sysreset_t sysreset_get_default_type(void)
> +{
> +     if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_WARM))
> +             return SYSRESET_WARM;
> +
> +     if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_COLD))
> +             return SYSRESET_COLD;
> +
> +     if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER))
> +             return SYSRESET_POWER;
> +
> +     if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER_OFF))
> +             return SYSRESET_POWER_OFF;
> +
> +     return SYSRESET_COLD;
> +}

The trailing return SYSRESET_COLD is unreachable, BTW.

Regards,
Simon
