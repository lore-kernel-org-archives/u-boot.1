Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E89C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 14:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8306A88A28;
	Tue, 30 Apr 2024 16:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tDJnNhmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECE588A28; Tue, 30 Apr 2024 16:19:04 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207AA88843
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 16:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-de5d439b729so2558345276.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714486741; x=1715091541; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovL5WBDs8iCfEVAAboHsfBafydkOZUcVxjHPY0UXLQE=;
 b=tDJnNhmHisleA7puDHtUCx/wpIsaF0FEbR5hO82ugFsHOf0PupepUxNREIYTy0Q1R+
 VZxZn2rm5hv+rZqCypBmFtGpa3dwfWvXvi9YeahDyRq3cQrgyuBiMx71LgrlgudODWQD
 lMdyK7xPqzupJrHsFjy/upuheFpefxQTddrcHPPdw4ItGdaj5yJy2nTAS4aQYmgdZqtx
 vFsb/sPp+ZR85ilTVE+gHDcl2epDSJlvG12RgFyCRcN2JPS3D5cNe2tpvPDLiHxw5sh3
 NczcsX4/AzmpBrAMMR0GqTQtCoZaJzx0gHcqjqix1mQdsFBR6HP5gyix3IrT8PHSqNfb
 jvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714486741; x=1715091541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovL5WBDs8iCfEVAAboHsfBafydkOZUcVxjHPY0UXLQE=;
 b=pxgRnJm1tG+PoLWkMLUIzX/m2/5/i/PqI1wjU+otGZquUpeXPPglGTv9S0ySyb1Uho
 XdoyqBkg8fZw0kTjUW2b2pTBU7MQNfXQVygiEBSbaBHuSTQFqqtzCpIPigUyuNsPzeoG
 as7djOKAG33DQ2t0PQGMyAaK71BeYrZqzMYYp1uN6uxWR/uHGQeVJHWe7NhIJXnhkPqa
 yG5tnWrBHBB9b9RnKUv+UeFv1DuapeKMtpfZqkJkQW2k3l8WDI2ZQ8OsWUL0fzdIlYs0
 wPAZfHuvHuw1WbBLd2ZPIrhI9tka4nSdB74OeU/FBq6yk6ijrP4Swot/7rvDjYqKUDYI
 xYhg==
X-Gm-Message-State: AOJu0YwLIYBeF746Z+agEb4hTjeLsmgpP+zaXe9/1N97tlH5MFDB7XgS
 XyjO9WkF3U1sgNqymWfYBqhVZNMUXYD4Agzi4VwcuMtpWbQYugRO+bjhVIgYtCZDNMYCN1qodK3
 U3e2aB8e75/dwd17gSH3yWTuRAdKiWRwPpOqhXQ==
X-Google-Smtp-Source: AGHT+IFpTsQeVLMVPKuam34qqiFoM3AKcXGTQbs7z7ufOyapVdEKE4Pc+lM4tL5hL9rhyAlHLmj8HR9/DC0bHaccsLA=
X-Received: by 2002:a25:bc8b:0:b0:de6:c07:decf with SMTP id
 e11-20020a25bc8b000000b00de60c07decfmr1810554ybk.24.1714486740913; Tue, 30
 Apr 2024 07:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240430133559.1836389-1-trini@konsulko.com>
 <20240430133559.1836389-4-trini@konsulko.com>
In-Reply-To: <20240430133559.1836389-4-trini@konsulko.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Apr 2024 16:18:49 +0200
Message-ID: <CACRpkdYh6ML9u4JZ4KpwG_jf_nzVxJF0dtUNi2hPUFgWK_7qJw@mail.gmail.com>
Subject: Re: [PATCH 04/33] arm: u8500: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 30, 2024 at 3:36=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> Remove <common.h> from all mach-u8500 files and when needed add missing
> include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
