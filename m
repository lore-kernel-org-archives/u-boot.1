Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29AFC55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBB176069B;
	Sat,  8 Aug 2026 17:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qg9W733utaGr; Sat,  8 Aug 2026 17:25:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED8BA605F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786209905;
	bh=3HuL8E3coaLR1fyYA5j2RKXqh+E36gNzxDyDRNHQ/RE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HBN2ANCxeROBlhC9a79RsDO+dks690OlRJZ6nzvTDZ+gvfolBykf8jyXlASszx5YH
	 TLl7kSj+AYRuzMLuM+n57qo3uiMFyWlmgPVSYjaZKmm2HP99rWibnBGLUmPIjqSpsu
	 aOCfZfGUv/hQTZJaqaF/04PTGwKKbybjFfW8YsGYYLHsrSsSVgFxkkn4Kq7ccLqHQl
	 TetGbsgml4uOhtoaIH9CsKu9p8ZgOsa8ucWX1L9NYnaQu/QxHq/+H3MlLLQNAvjl4q
	 RUjOUnBe2YoH1JljAtTGHV6+qL0X3vDhEg1raPEt2ktE856caSznebswgkOHrunsvD
	 RwgPXHXzXtQ9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED8BA605F9;
	Sat,  8 Aug 2026 17:25:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E557144
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7000D80E28
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WqDfp71HQGlp for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:25:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7D7F4807F7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D7F4807F7
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D7F4807F7
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:25:02 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1fbe461f59so59282966b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786209900; cv=none;
 d=google.com; s=arc-20260327;
 b=YYz5CBKBDiXGwXOXPrlWXH2oka8fSCAUooJsC5TEJ43pauIQxtlRl6fY5oo3I2t0xc
 E9piFfi5nuCetsuC7gJ2KbYBpj2jQXHWEcCg/FNnFd8tSm2EuFmNllzEEo59WJRML31t
 RtEY5o+wYi6AxDmGo9iRyx2qW3Su6tcLre9G96yjv3KkzyAFcTawCZReuLnzwLokNXYI
 UkThImG9zHdMGIYwm87PJdf7pc5g4hN6yNRsdVpA2DJBpOPl4ZsfI0ffTwkrkmjNQMLM
 shEAdJHrbH1y7PALVmRVTtDV0vmRYRZaSouL1nIeTiaHNdFbcLkamkpGhoAoGqsdBg2F
 IJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3HuL8E3coaLR1fyYA5j2RKXqh+E36gNzxDyDRNHQ/RE=;
 fh=VUkCjhKa49A67drcxhbxxj9MpVXVprkO6rbMFFd9+rw=;
 b=bfOTp9Ua4goE/bJoudP4hIcjMO5jlvY63KEyclKtt/mwg/Yrf6d1KttR4b5wZqDBCD
 si8bVWzqydM6vp6yNDKiEj6jnWFjHY0qMJLQDBPlTLqNrRGgd7g+lrnuEx3x+B5UDjdM
 xhl5tuHDc4/XlJ787qCnsiAprKB1urp20Ytre+DIsPQuwfJ5G3UZxJdRtbU7Ff9n3KFn
 Ci7SpeC4HlvkHd/0ncFTfsCL/bDBb51zWqXp14aeL0jhH6NkJeYUvPmAAYQNWs1y0IJo
 XBrpMISb60nMsvyJyU7BVD66YPtld4lRp471YE35crGMY9lF/4Fp18IoyS4tYzoT6e8y
 1VNQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209900; x=1786814700;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3HuL8E3coaLR1fyYA5j2RKXqh+E36gNzxDyDRNHQ/RE=;
 b=cl3U/9DYQy4cchLnAKxPpTPXLDCJ01WuhBMc0dLU3EZ0gCGQJT+HRS2HdJDflnAMJK
 OzDfcmDpmkn+C635Yibv+U4ML7qi9I7NKErTqMyZRXgmEiTS1ktmu9gy8PWFBqxdn4MO
 veBsd77nZB+YbFCqZI59ua1b2ekpvNCUCCTLOboMvfEGr8QdokdTib/no2/wFBEHY//U
 iiocf8r21gzM7QzrB940A0kn5oU937BfCSt6CRkjlLc8Haf9AVlL/H1fN1Z3s4y8Jg/F
 7Voub7lOdEM6hRrIyvjD46/QnRTy92B+NCzl18Pmzor8sQRFzYBE+fiWTrxgkt6OMAZz
 JctQ==
X-Gm-Message-State: AOJu0Yy+6FTNPgUViw7rJt17bBxA4QQOe+OzxJZh1w/LROSUzABmDDeL
 zjCfA+CF8xZslKdLVpExw1VOcmtpcncEg/JTtcc95rCR1ZG7uRI49Y4KaS9hDsR/nfG+KFuYzNB
 l5sj1glaL5VHMA0CjuWRoV+Q1c8cSHh+F5aZRkAl0
X-Gm-Gg: AR+sD10gS7q6SQ53wMK6gRLugx74qcXOIuD0xJ0rcStPTVKxyPnreMB8DEJvy7qKa+M
 QWR8kQX1q78UjrSG89gvrcwYXECQPmE0FyAEjgDY0F54AWXqN0nxY+XxPpvwymMPoKNhjrJtfjk
 J3Fr6Z4fW/DlwjmUMg4yG3s/L9qifJCqinMyWBr3GKFnkYzZe81k8Y92rETB+Fynnfa9zme9I4e
 q12HUZv9tdWM1/a5WEN65SSi8nt4FKXrkLuabpo+RNRJs0/f81fCpLCxLn1uoC5SIsp3pmvoFYl
 DUj6D60zIbTxHAJiIF+OJTPHpys6TgiwrtauVT8ENH4=
X-Received: by 2002:a17:907:3cd2:b0:c20:295d:6574 with SMTP id
 a640c23a62f3a-c207320a7e7mr825413966b.12.1786209900264; Sat, 08 Aug 2026
 10:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-resetinfo-optional-v1-1-0b500903e4b3@flipper.net>
In-Reply-To: <20260730-resetinfo-optional-v1-1-0b500903e4b3@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:24:46 -0600
X-Gm-Features: AUfX_myr97g9pf9LHKiH1_IUaRQq9atyizxw8NIvr4wn-mA3lAEP_vtPtznrlog
Message-ID: <CAFLszTis8DL=VVUOKhCijxkKif62=ypMW0e_OdO2_WF3Q21t7w@mail.gmail.com>
Subject: Re: [PATCH] board_f: Make printing reset information optional
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786209900; x=1786814700;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3HuL8E3coaLR1fyYA5j2RKXqh+E36gNzxDyDRNHQ/RE=;
 b=lFbbtHhJenUcW8jCMv5QHh9uQt5i2IyLdqy9N+c4jmwjwh2nRnzciT2KXLu8MpxGbS
 nuVQdhua46j2AwmNAZjg2AQzPosaluDPFtOJyALz+1zCBbVNt1/7Wb9NlKEgOxHS7Afm
 RIkCRQ145kmYQ1msUc9HT7H3aC4ixp34ZiLUg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=lFbbtHhJ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-30T08:39:27, Alexey Charkov <alchark@flipper.net> wrote:
> board_f: Make printing reset information optional
>
> Current code tries to print information about the reset method whenever
> sysreset support is enabled. This causes the core to try to bind the
> sysreset device in board_init_f, even if the driver doesn't support
> reset status reporting, causing pure waste on some platforms (e.g. on
> Rockchip RK3576 it increases the boot time by ~0.4s even though the driver
> doesn't support reset status reporting).
>
> Make the printing of reset information optional, so that it can be
> enabled only on platforms where it is supported and useful.
>
> Only four sysreset drivers actually implement the get_status() op, so
> default the new symbol to y wherever one of them can be in use to avoid
> regressing those platforms:

>
>  - sysreset_sandbox
>  - sysreset_mpc83xx
>  - sysreset_psci, whose weak stub get_status() is only overridden by i.MX9;
>  - the pca9450 PMIC sysreset child driver.

This would age better if each driver implementing get_status() opted
in from its own Kconfig with 'imply SYSRESET_PRINT_RESETINFO', so the
next addition or removal doesn't have to touch this Kconfig too. What
do you think?

>
>  - sysreset_sandbox
>  - sysreset_mpc83xx
>  - sysreset_psci, whose weak stub get_status() is only overridden by i.MX9;
>  - the pca9450 PMIC sysreset child driver.
> [...]
>
> common/board_f.c         |  4 ++--
>  drivers/sysreset/Kconfig | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)

> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> @@ -43,6 +43,20 @@ config VPL_SYSRESET
> +config SYSRESET_PRINT_RESETINFO
> +     bool "Print reset information during boot"
> +     default y if SANDBOX
> +     default y if SYSRESET_MPC83XX
> +     default y if SYSRESET_PSCI && ARCH_IMX9
> +     default y if DM_PMIC_PCA9450

If you don't want the imply approach, please note in the help text
that any board adding a new get_status() implementation must flip this
on, otherwise the print will silently disappear on their next
defconfig regeneration.

Regards,
Simon
