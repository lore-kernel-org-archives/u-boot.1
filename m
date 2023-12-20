Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ABBC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08B98753C;
	Wed, 20 Dec 2023 05:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Th+Aloht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C10D86E05; Wed, 20 Dec 2023 05:47:12 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9801087530
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c31f18274so66898285e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047629; x=1703652429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2+pTteMb95Avy/VjKT2HksEXQkwfajK6UJHLNR/kNJQ=;
 b=Th+AlohtbMuPltjeXHlYZ7GnKh0mpYuvw9ooKW4LaahfGyynxD5IWawUP0/Dtneugs
 H/RMsNQ6kIbHWLtWeJo2VK8mkIymh9wnMkxgjLKcbkhx1rmKmN5qeefdi05mcRAWkqrP
 MQFCRWL8Qv0cgQN8dRfy5R8AjsgMd0A/M++tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047629; x=1703652429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2+pTteMb95Avy/VjKT2HksEXQkwfajK6UJHLNR/kNJQ=;
 b=ZWYy/J3oFTlz5GsQOlcLtTxdsJorZIJufXd/A1qt6MLObk6c6Bcvkt0I5QwciEcMDx
 PsvHBVlklFO0Xlaj6qJXOOiUc+MnaonPmlJZcXmkEj68UX0ro7fq9UsSHiJvrEekgZq9
 tSGnqaEt2PalwJKMyO2x9ryrO0SB22T2hurPQuAC9HufSD0C3Uo6wpOJhQlTIQnqx8qk
 SVj/ZSLQdTB9x27njmH6PlnghDW6ol2Z5zRACfGjVyDnnohL3wJy9ayAiUxR3d088Dno
 /xvqYf7NY53EzXV25GkkPuwlKceuVMFqofNKm3qOvXrb85kgaGG/x9LWHnR5+eDrhHcs
 my/g==
X-Gm-Message-State: AOJu0YwznUc8XhMPR5h9BZAmw7PTK2hnIf2IwZZQRNoRVZ0dLBn52/yI
 efsh5jYv0STtf4vEX7YtrtgO/sSVwg4kyKRPKGhEQw==
X-Google-Smtp-Source: AGHT+IGHQ6PHgfNNiewSP/qhrYoVPC61A3BgQCUPYU+yn+WF4nNoDshDwm4674R/m3+4+5vBwE7nfT1YvzRnx6jeiDI=
X-Received: by 2002:a05:600c:34d2:b0:40d:381f:eac7 with SMTP id
 d18-20020a05600c34d200b0040d381feac7mr7792wmq.214.1703047628872; Tue, 19 Dec
 2023 20:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:46:57 -0700
Message-ID: <CAPnjgZ13umAN1E2MqMwTmG98A=o_Q5RQFOY_Q_xpgQq-gmdoNQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/32] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Caleb,

On Tue, 19 Dec 2023 at 09:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
[..]

> == DT loading ==
>
> Previously, boards used the FDT blob embedded into U-Boot (via
> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> bootloader, so we can instead rely on the first-stage bootloader to
> populate some useful FDT properties for us (notably the /memory node and
> KASLR seed) and fetch the DTB that it provides. Combined with the memory
> map changes above, this let's us entirely avoid configuring the memory
> map explicitly.

Running U-Boot as a secondary bootloader is the degenerate case. Are
there any Qualcomm boards where U-Boot runs first? In that case,
perhaps the DT could be used in SPL to determine the memory size as
well?

(this series is fine to me, BTW)

Regards,
Simon
