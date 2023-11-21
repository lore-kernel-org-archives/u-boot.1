Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D26FC61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8FA1875F4;
	Tue, 21 Nov 2023 23:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d8vCgDx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DEC8744F; Tue, 21 Nov 2023 23:12:19 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674DA87628
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cb4ee00da1so2351447b3.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604731; x=1701209531; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+nm0EOTeAwbxPydtOh2fF3d5J9vm27Mg2EooFV+2RDI=;
 b=d8vCgDx847OU6mQtugHZz/yCJBzvaPEzffDibOUzKs9z4rjJdkBfJxhb2WPzrT11MC
 5gV10GEJzxreG+1MzdQc2ljkdkm0we3wIOuea3015sKqyFCu7iyroV+Ees8rdCCEYjtS
 2zCoKO8LC8bhkiK0WL/7069Gb1ri4MpT3PXys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604731; x=1701209531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+nm0EOTeAwbxPydtOh2fF3d5J9vm27Mg2EooFV+2RDI=;
 b=MNeCO8I1irVmncygJnFqYD+PCs1zEAxA1Wc9aIlzLoAhQ/Utn+UKUz8LvRCoewmY1q
 dlH+HWWR0MC5ITOs3Jps6V1Yc/CbIo6Rsfeo0D3lcACBalXa1vhA6Vb7EKPz3PLo1xGU
 zemAXBBunuNb9AVkT4FQoYaELNOzT3R+TTeuZQLTwAp69mk8dbOCNAUlWZCJY96pmtSC
 olmaCaiOmmC9snR5alDkdJJXjnDyKfl7QVdSlea0ZBDjC3EtOkgxfddJ9uRrTqkShduN
 h3lLE8CaHSDRXYKOYFGdt1EdSDGW1FRp/mpWbawTQJY0diYL1LpEywndAINAVlZ6LPaK
 ArBQ==
X-Gm-Message-State: AOJu0YwmlQ7RaLor4WQ4Enrq7Fx2rBpjZhoLPJRqFirbIlolUkHpIwxb
 VZ8KXsbt8c94Peq+BzMEGgj1Wy8K1fYrw/Zs3h2mWQ==
X-Google-Smtp-Source: AGHT+IE5aw6rPQMEitWbt/o6L879e29JCZCSrjFRdmYodsd1gMxN+c/odBrPcV57s8oq3Hw3cYqwsHG8yGZ2jdISuhc=
X-Received: by 2002:a0d:d50a:0:b0:5ca:dbdd:604e with SMTP id
 x10-20020a0dd50a000000b005cadbdd604emr3514346ywd.21.1700604730477; Tue, 21
 Nov 2023 14:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-9-9492198e0c15@linaro.org>
 <20231121190851.GE2513409@bill-the-cat>
 <498279aa-e7e7-4e06-925f-e104abf8d721@linaro.org>
In-Reply-To: <498279aa-e7e7-4e06-925f-e104abf8d721@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:11:51 -0700
Message-ID: <CAPnjgZ2CO8xdfh2Vb_3Fxig90VLrehrm=LOrMpGEJc0aL8XzhA@mail.gmail.com>
Subject: Re: [PATCH 09/21] configs: add dragonboard410c_chainloaded_defconfig
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Tue, 21 Nov 2023 at 13:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 21/11/2023 19:08, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 05:09:32PM +0000, Caleb Connolly wrote:
> >
> >> Revive support for booting db410c using the Linux kernel header, this
> >> allows for testing the board more easily via `fastboot`.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>  board/qualcomm/dragonboard410c/MAINTAINERS    |  1 +
> >>  configs/dragonboard410c_chainloaded_defconfig | 75 +++++++++++++++++++++++++++
> >>  2 files changed, 76 insertions(+)
> >
> > How different is this from the regular defconfig, and assuming this is
> > also a partial answer to my question about "why not select?", why is
> > this not just a config fragment instead of a whole new defconfig to keep
> > in sync?
>
> Oh, I was totally unaware of the concept of board config fragments in
> U-Boot. That's definitely a much cleaner solution.

Can you make a single image that handles both?

There is ll_boot_init()

Regards,
Simon
