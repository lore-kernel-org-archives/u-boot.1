Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7D5E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C12189521;
	Thu,  5 Dec 2024 18:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ilu+S066";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7CFF8950A; Thu,  5 Dec 2024 18:57:08 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 684DD8950B
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa636f6f0efso12261766b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421426; x=1734026226; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2njd+BGevlmW0sc8joePL51eK8snEuUUyu0ygMNW5PQ=;
 b=ilu+S0666gPfN93vVh3JpnsQxtHSoROKVzVaAX6dZdobvcX9N+u3HDbqRUCMJlB7WS
 PpNaUo1dQSkcERUFcy6PfuhDuSs/ZK0K4dQv0f1yZ5EwgCDvz11XHXWFfURthvzqwDiD
 oYhPQYZrJ+CDrU40dL6k8FSDFghyTTYdwLfgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421426; x=1734026226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2njd+BGevlmW0sc8joePL51eK8snEuUUyu0ygMNW5PQ=;
 b=dIKugklPyni2eHArjTBKAzfV12wiMbH9pvXpc1YFmcnD9IVbLP5yFo2VuJsMLaz13K
 BZZP8YnGqnjbAzoMH0tpiJ2++raG0ETxD/xHpMw35GAy1hptfNFlSx0/d0IzR/LM3cjL
 /gSGyTa0D2Zz8MFhsEjq4a2jUwOgy7unpImJ1I5Dp6rL9b+dH+5PfVxhGB1BAblTjlcO
 MQ5oOMvGgUbK/AsrtvYGxuIRq4kOTp5Y1tDPU9KAGyyBVmk050OQZKu6DsP8D0YBNW7g
 aLuJ1b1efZpHvmQQFX+LD8u76ThVtSzjQl0q3QTEnJZ4MRLxPSVX7UVBhgcp1ON6iZ/y
 UlJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXms3CY2bxxjEbU6Lt39r6hc+NUA8RoP/UYpZ+dB7HEBbv1XSLP6ZdC+qOsAQTscO8L8TwylRo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4jTrbyYFqkPYkJSHKZf110+6DOUZ59xFMDOX1y/onfM4c/JZi
 RRNdH/wIbe2zy9bVYktpfnLyEcVFjkHgQLARKLsEMkFNRJUxp9p/cm1WJdJQQY6A95lTZpQqk0f
 p+smY3qknXRfnZg/ZXlHEpuVadH9vjHiV/K7p
X-Gm-Gg: ASbGncvTnlBDNiH+1eySRbTGJP2cBxm1KF4A6ovHzHpAmCURPAikONDWlQvNnZdU3y4
 uwC9R58xYziipwAwA8gQfxx1c1HCv3SCv
X-Google-Smtp-Source: AGHT+IGZ+Cx1gBdXatlJOnCSFvGK4zIziXsFCeGHeZ2+0a7qcMi1m3f7LUdXoezWubKUrrE4AFCQP71rWBS/5BlU8gI=
X-Received: by 2002:a17:906:310a:b0:aa6:30e1:d84d with SMTP id
 a640c23a62f3a-aa630e1e4f1mr110802866b.41.1733421425886; Thu, 05 Dec 2024
 09:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
 <20241205-ge-mainline-display-support-v2-3-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-3-4683bb4388dc@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:56:50 -0700
Message-ID: <CAFLszTiqm=bfpb5N_Q9r7Q49nHTR03vKSzP1vwoGfMgewQpw2g@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] sandbox: Add a fake display controller and link
 it to the panel
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

On Thu, 5 Dec 2024 at 06:54, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Use a graph endpoint representation for that in order to test a new core
> DM helper going through these properties.
>
> Display pipelines typically include graph endpoints, but the helper is
> generic and would work with any device type. We do not bother with
> creating a display controller dummy driver but instead use the default
> testing placeholder compatible.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  arch/sandbox/dts/test.dts | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
