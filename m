Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F00C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C6A87608;
	Wed,  6 Dec 2023 04:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WKbV8wRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7B28753C; Wed,  6 Dec 2023 04:54:26 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B748753E
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9fa45e75ed9so39592966b.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834864; x=1702439664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m4Pmgr7/qnjNSUutwjQgZ5OJUOSUHk7G3zEbRnJRTe4=;
 b=WKbV8wRgJ40L36H4dPLoEtMzbykgXDmgBwv5OHPnbpCbVfgs5+xh8y86tdzWKnBF4x
 3wwHIAHyhkL/k40PuVkDR5V6oyxSkIrOXAzOz8xAvWKIdTyt6FvLlLby1u6yBw3V3dVM
 +8w1JG0Xeuv08AZ4lEv7DAq3/o6ZYufy7jXlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834864; x=1702439664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m4Pmgr7/qnjNSUutwjQgZ5OJUOSUHk7G3zEbRnJRTe4=;
 b=D5s2KyXLX2u+XiFNfLm4m9rIlp0aZD4DdM2+yNzLhFQ2zpoPIMhS/kMNdI69GC2zzs
 akv9yWv9kUIOc15787kf4l0mECe74eaKrrk3v4sjyIHrZ9M3lSEwDGsPgqOp+nk9u5CQ
 jkNuUCZJm/PVpixCW/C/GCDiqK6BT/gh+RF/Tmg6O98XSezwqIEI8AAyUNWiw5m3ckC0
 LaMSBRr0NWZtdPJma0R5Z0wGvLe2JcY82PDxUjiLYBi3RnWdY1Jew5bipBsQJorrd6Oz
 G3W+G82UHuMB5m5LMqCrC415ubu948ddULsXvrHkZyX3camqJcwgyj41McWG7O+ePod6
 9eWQ==
X-Gm-Message-State: AOJu0YxM913qjFPoYQPZiXpJNZbsgtBP7NHA7EC9uRG1U6EQ2o9OJeiL
 lDEz4W5H/zL3Q9yUhmLp5wc86S01vwL4A4FA9d2i6g==
X-Google-Smtp-Source: AGHT+IEX03Q22mQ6hE0V2j6LvntImz4DkVziYATq9KvX1de3ajJUoKW4rrlv8/ozPJWzwvygyC36H3X2rAGS6EcjN5I=
X-Received: by 2002:a17:906:4a8d:b0:a04:837e:87af with SMTP id
 x13-20020a1709064a8d00b00a04837e87afmr133961eju.33.1701834863704; Tue, 05 Dec
 2023 19:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
 <20231205-b4-qcom-dt-compat-v6-6-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-6-61d104a8f920@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:06 -0700
Message-ID: <CAPnjgZ0gC2nhpX=fA=s3b+LiABN4E-cHqY-qH5+4LuVfBwp1Gg@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] dts: qcom: adjust pmic gpio to use upstream
 bindings
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, u-boot@lists.denx.de
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

On Tue, 5 Dec 2023 at 06:48, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Use the upstream gpio-ranges property instead of gpio-count, and drop
> the bank-name property for Qualcomm boards.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/dragonboard410c.dts | 3 +--
>  arch/arm/dts/dragonboard820c.dts | 3 +--
>  arch/arm/dts/qcs404-evb.dts      | 3 +--
>  arch/arm/dts/sdm845.dtsi         | 3 +--
>  4 files changed, 4 insertions(+), 8 deletions(-)
>

What is the replacement for the GPIO bank name?

Regards,
Simon
