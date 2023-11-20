Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798BDC197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 21:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D45C786A4B;
	Mon, 20 Nov 2023 22:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zEXjPslk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67BBA871FC; Mon, 20 Nov 2023 22:02:08 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEFC86308
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 22:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507be298d2aso6276164e87.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 13:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700514126; x=1701118926; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hnX+PPhPED81a8n57PhMUXRr/5Z2PW4ZrFWe0A9QuOs=;
 b=zEXjPslkyahPSMcfDUJ8HcnaTWrdREE20fUB2797W5I3ZyfHHAZJBxxQQ+tRN1Gw42
 1G9KImHhqRsA+by/sRSLTZNdzVQCfhviqi2Oq1Faiq3QPSv27QM+0a/Cs/LZUF0Yw9Zq
 QB53cEb6KAYsANl5jKqJL0z6zcNImOpTq5Q1vYbnprwqoQt1XDhY2kevC6faYViQy99e
 z/xJYWsV2zeLNuep3ypRE6Zjk48W7urvg6nR6QeXP0bTdXv/qhyfVnuGlevo0sbeiVcQ
 PelIB1ggY4yWn0nKzG5E27pEOcdUVWdkkNv/vWtnv2C25Fru3YSPnxSLl2VzIHgnVof7
 Pfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700514126; x=1701118926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hnX+PPhPED81a8n57PhMUXRr/5Z2PW4ZrFWe0A9QuOs=;
 b=TItYOm8QAopbpt4ykg7CKTm5jHPhQh4UsiTFeenXVErNZdmQvS4geixTRG4+AP3sbf
 ao4OPl35+YU4aD6KouyVLT4RN+jSRrySjc+ul6t23O6ZnnetHHnKtCAHeTYGKcFotixE
 QmRSX9EgctYLsYLBWO0123WnckiHPtUJo7NG3fGdU5wSZ+jcyd/cNLGYWdazmoSWWDXl
 ZA+31yKnKN7lVvZt7tIiuK85P2KaN3nh+VTnNbaKAZPocGjXujfQuKOpYPHYaRgk6ob7
 MTi2D4fRVgzz/tZq++LeMiC8j43/fj3YxIaVXTvj7ZgQ2gFLkeBUhHJL32iXilRB94SI
 kikw==
X-Gm-Message-State: AOJu0Yzd+6OO6+k5TemnqMAovchIGkwujBQDe9HuOmtThMXF5egQ+rXB
 mlgBx8NJ5C6bLnhcenox4Q0PCqG8YJ/lBdDPrnoSDA==
X-Google-Smtp-Source: AGHT+IHXS7QmUUGvauAkhxbWxoNjbq52zcjFdET9eC8dyJL2DxWucrQQLNWVCQ/cpcrPdVX7fMKMGwSJpdMqDekZlxs=
X-Received: by 2002:ac2:4ed2:0:b0:507:9e51:a6c7 with SMTP id
 p18-20020ac24ed2000000b005079e51a6c7mr5742407lfr.58.1700514125497; Mon, 20
 Nov 2023 13:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20231118210547.577026-1-sjg@chromium.org>
 <20231118210547.577026-8-sjg@chromium.org>
In-Reply-To: <20231118210547.577026-8-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Nov 2023 23:01:29 +0200
Message-ID: <CAC_iWjKgDKb_S6+LySsK2AdzgLcSnSfEeBChTOO+4j8AdPuPLg@mail.gmail.com>
Subject: Re: [PATCH v3 07/32] bootm: Simplify arguments for bootm_pre_load()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

Hi Simon,

On Sat, 18 Nov 2023 at 23:06, Simon Glass <sjg@chromium.org> wrote:
>
> Move the argument decoding to the caller, to avoid needing to pass the
> command-line arguments.
>
> Add a function comment while we are here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v1)

[...]

>
>         if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
> @@ -785,7 +794,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
>                 ret = bootm_start();
>
>         if (!ret && (states & BOOTM_STATE_PRE_LOAD))
> -               ret = bootm_pre_load(cmdtp, flag, argc, argv);
> +               ret = bootm_pre_load(argv[0]);

Is there a check for the validity of argv[0] before this call?

Thanks
/Ilias
>
>         if (!ret && (states & BOOTM_STATE_FINDOS))
>                 ret = bootm_find_os(cmdtp, flag, argc, argv);
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
