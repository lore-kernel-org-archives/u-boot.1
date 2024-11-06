Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6211D40D13
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 01:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D8F588D09;
	Wed,  6 Nov 2024 02:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z4W005qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7519B88E0F; Wed,  6 Nov 2024 02:09:18 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35ABD88B64
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 02:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e2e2baf1087so5719522276.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 17:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730855354; x=1731460154; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gd+TjaX/hE5itWZD9v/rEy/7BNji3T5L81P81pMfSFw=;
 b=z4W005qi70FlOTbqpoCkz7qLQlYBUvVJScudMDzuy1XS7GO9h+RWZLj+ER5oFbpM79
 GOprAHMWG8LUry7XQtJLe8oPdx4FaaqqnC7G9AppmBIGZSSDG9hZStIXtKzpvqLmNgfh
 ikJKnoSfroHurBcfV6e7nEJF8ynh0HZ56UrR4lp4IpkxDTV3QWeQpxnpKLeoYc0cSFTC
 Sqq6HH+wGRpiY/HHtdtprtLSTTruX/8u/JXEFhG4DlKI2bLBnaV5vSUXfIIZukaMnB+N
 4CmPX8nGtQXwgrRFE8nQxttNSf1TwSO0nkHy+UlwLCKr9MR9Ts3dBjAW3Oj3DemyqSuc
 BrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730855354; x=1731460154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gd+TjaX/hE5itWZD9v/rEy/7BNji3T5L81P81pMfSFw=;
 b=JPKnHsHgUlQ3qwLO8mvOZ5GjiSS1TdvVEs3PTBS5Pvu16dQPNcPH96lxdH6XDGH/iq
 6GDj/vS3QDzrMaIUHAzSh5ZpLev3528i77Cb0tlrhcq9L3INbpIXeHjz6oRky05sgSRr
 bWqPqge2fUMNXWcg9FZjSpsXnFTw5TWtxhP42ldps3+LPn4uVJaVC59kIPl0dZcwp/zs
 bRgWqm3a1BDhOoZvbeNRSlrcY9FWkAuiBO34MX63IivDY1htZVLART+ixjnneVnBV9A1
 ZR45PxRPqos90zkId1jP21zbpHyWkeG0q/VkKcSQJ8n+Op0ZBEt62iztEtlVXlvL/fTC
 Ii7w==
X-Gm-Message-State: AOJu0YzgQbfPkmeNicW8uM66tpaXF1EggfPi5HI9Cy2gfvrA2RddOqLT
 6FAWmNJRBJvb2LqaXEedIU9d+LqiHHYAiCouuxiiLY7PDeBGQ8pyF6sb2BOdvS75Rn5dpkGNoCL
 +ClK/7ni3orRmvvSaSLv54gzTcpBmAoO3vEx5TA==
X-Google-Smtp-Source: AGHT+IEVVkqxj3H9Pdb+FJasmNoj8WuOhL/pOO3lLqiVQSynl9wTMjWz0H4hTosJdB6OjWW3gsofhGTT+YXiqcyhuoo=
X-Received: by 2002:a05:690c:690c:b0:6e2:a129:1623 with SMTP id
 00721157ae682-6ea64be680dmr190995637b3.38.1730855354018; Tue, 05 Nov 2024
 17:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20241031220605.31684-1-semen.protsenko@linaro.org>
 <91b284bc-b3ca-4475-8e27-01ece4ef10e4@gmx.de>
In-Reply-To: <91b284bc-b3ca-4475-8e27-01ece4ef10e4@gmx.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 5 Nov 2024 19:09:03 -0600
Message-ID: <CAPLW+4mzyhQyNkJe7fu7PS+A+KLEvEEM1Be-DXnY1SsZ=cLm6g@mail.gmail.com>
Subject: Re: [PATCH] armv8: cpu: Implement allow_unaligned()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Fri, Nov 1, 2024 at 6:46=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>

[snip]

> > +void allow_unaligned(void)
> > +{
> > +     set_sctlr(get_sctlr() & ~CR_A);
>
> Looking at the ARM documentation SCTLR_EL2 is a 64bit register.
>
> https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers=
/SCTLR-EL2--System-Control-Register--EL2-?lang=3Den
>
> But get_sctlr() is defined as
>
> arch/arm/include/asm/system.h:174:
> static inline unsigned int get_sctlr(void)
>
> Your code might not work as expected. Should we adjust the definition of
> get_sctlr() to return a long value?
>

Hi Heinrich,

Good catch! I totally overlooked it. And it's already used in a
similar way in a couple of different places. I'll handle that in my v2
soon.

Thanks!

> Best regards
>
> Heinrich
>
> > +}
>
