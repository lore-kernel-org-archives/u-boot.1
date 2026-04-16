Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE493F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E2B84347;
	Fri, 17 Apr 2026 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kumjdz6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7DC8407E; Thu, 16 Apr 2026 22:53:29 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A8E83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b936331786dso1010218366b.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776372807; cv=none;
 d=google.com; s=arc-20240605;
 b=J+IEnr3lp66kPbSxeiV5L8mdZz1LBTUz46h5UueNzBhqfYLtkLl3eH5+Do3MYkNu/+
 6jFf/ydCrWWcI0L+Eo4vmN2muPQOzah+gWX+hVLZMHlcQQZR1JZu3jZGJF8TXeAjZoL+
 9RAjVcrbVCNnHBgnCAcqyzPD3BAwGrWz/+tYAfe70SsxIXS8RmVnptA8Qh3TQ7oUp7bi
 +WgUIhVW/El6YYcFMFzXcdeF96yPZkWqLcTxG+WYH2PrY4YI8a/1SOD0awO95RBEbFif
 tGftGaT/L38DDH6HdlOusBfVrVOGg5FAYvGH9Erp9EyLJR2TELLMgx6pNFXHnXc2Shpx
 Regw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wyRjX8pMh7+RhZHjmCtdJoJ7fJ4lXKm2bNXrge3eIIg=;
 fh=1W6KVLriV9vHZUBTib7uFWDJ5E/IlPKOWOKt6b9rVJ8=;
 b=a+UTB3xGfnvbbNvYvvnRR7dugFK9JW9UoaXojjjGbt+JaAyjIG8LRgelkQSin3ZtFs
 2Kbd6vZY4J0Koq/66DH1EWk9EBYwV1SMrTAjAi1bFPIaKNEedNtAMcooLGK90BaZjQFl
 WtDEiHojGeo5G51U9f6zC9zDtX4L75UDpBytC3N+s5KxI20arW6y7OVDRpvSRTU3757X
 AIOazU/RFcPIgM8xw++uMfVEbKb6JKRkWLSgS4MMWb7XVvrjo2dUeYYHlYv4mx+qPbF7
 dStg0+ME3pT7AW+8Dujk45cGgYB5k/sf2opWlq4BYl0I4EUZ0N9rx9nulM3jCCXfv7Pl
 +2yA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776372807; x=1776977607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wyRjX8pMh7+RhZHjmCtdJoJ7fJ4lXKm2bNXrge3eIIg=;
 b=kumjdz6I4gTNG5BO85cU7T7A4R8hEVc7azbxYqbCDWt1TGMCalEoq6YcVvweIJpKqS
 56MUeiZ8tvEt4X5bApjbz9TlcTkoOW1Fd2t5y+beGnq9DdMWOpTDfRi/HTPfn7xzSKFi
 DMGUozkc0q2u2GKvIU4tyBRyySTzBn5eMSONc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776372807; x=1776977607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyRjX8pMh7+RhZHjmCtdJoJ7fJ4lXKm2bNXrge3eIIg=;
 b=VYztX6NHQB6VeNMTJV9W9LHenJKYxVX8fguzhsYDa5ktHpHyvn4LN8OSY06VKkvS0O
 FAlAHWDMcHP6kU9i50urZ9LznC9baL+P3jBH7CYGZ+2fsMqjw1zkEsCfeclDFX01DjeU
 x3iFCiV8NmUBqZcvPrraXQiuBr4vGc5dJd0qP2cSa4y1fSvw45b+9QcqXVtlcuPtME04
 mWkqSWs823YetUMM4ds23P8t3O8xcUF78Xb2rmEC4tdIxc5Xs8tId14oH4k71ZdyHvQb
 agLvZxAiUVQl/5gM0EKMSgd6kuUMxnYHHMCtQt2x54Vz3ZKaicDiJdTIIN1NrHa7Z048
 81RA==
X-Forwarded-Encrypted: i=1;
 AFNElJ86SsjtmWp76ccmpzqpelOuwMQw6b6SmbDX3ju+38iExfL0sX2Uqg21aUPRvYfFtaPDnSJ/Pfs=@lists.denx.de
X-Gm-Message-State: AOJu0YyNSAmQN0koZ451hoRI3zUtwLTTtWE229gknZlVm47vzP1+6SNt
 sjhX177MmsWOfQWzZiaqDh+r7O9DS3nUpU8aZd2p8oslMmOM2iEADhUjU67lfTEpn6Qruk641xc
 JJNYro3eZltSMnezk/e2e+nYjUqBiASiNtYV6E4G3
X-Gm-Gg: AeBDiev2Qz7cRqDeZnmWQS8rEuD4FEKVLveh+MtnfepyFEZNyyGHJztH0prvgTXdqZQ
 WmtgilxKvSnLfh3tXtOppCwNb587TxhMYB1h2zjtb4VB+JltePjr0sDWTgIMVr7/GIBZjlFZFeC
 G7wHUq/rvYqYwpNU4N6EEvCPTdPqWDt4WtjICb4rRW6v78wzN4pmJ68fH7cdPzH5PQpKJD/+gK6
 ovynxywT7YNneNJJgQbDLZDIzwoJs5Uh5qEzjdIu5OCoDqm1AnD4eALy4s29UYV+tg3RzDq75e1
 lEEA7DFy+n68nSX1ZYi3GoeSefjyVwk=
X-Received: by 2002:a17:907:d206:b0:b9b:fa57:d5b2 with SMTP id
 a640c23a62f3a-ba41b0e2b8amr4533966b.42.1776372806756; Thu, 16 Apr 2026
 13:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-4-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260416053928.2834699-4-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 08:53:12 +1200
X-Gm-Features: AQROBzCXkRPg8GtgkprvEHwa2O2YEoCbzMD0FpTe9cWAzfuM6mf4PCTljPEH4YM
Message-ID: <CAFLszTgMb89EjfDSc17z0TAqZS0MB0Z1m56hqx1=bZxH578nzA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] pinctrl: qcom: Add ipq5210 pinctrl driver
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, tingting.meng@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, dinesh.maniyam@altera.com, 
 luca.weiss@fairphone.com, danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, 
 balaji.selvanathan@oss.qualcomm.com, adrian@mainlining.org, n-francis@ti.com, 
 wens@kernel.org, jamie.gibbons@microchip.com, justin@tidylabs.net, 
 ycliang@andestech.com, david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 richard.genoud@bootlin.com, michael@amarulasolutions.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi Varadarajan,

On 2026-04-16T05:39:18, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> pinctrl: qcom: Add ipq5210 pinctrl driver
>
> Add pinctrl driver for the TLMM block found in the ipq5210 SoC.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> drivers/pinctrl/qcom/Kconfig           |   8 +
>  drivers/pinctrl/qcom/Makefile          |   1 +
>  drivers/pinctrl/qcom/pinctrl-ipq5210.c | 349 +++++++++++++++++++++++++++++++++
>  3 files changed, 358 insertions(+)

> +static const struct msm_pinctrl_data ipq5210_data = {
> +     .pin_data = {
> +             .pin_count = 53,
> +             .special_pins_start = 53, /* There are no special pins */

From my reading, the PINGROUP definitions run from 0 to 53, which is
54 pins, so shouldn't these two be 54 ?

> +     pr_err("Can't find requested function for pin %u pin\n", pin);

The word 'pin' appears twice

Regards,
Simon
