Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C9AC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8114878AD;
	Tue, 26 Dec 2023 10:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MzARJJUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 037AD8788D; Tue, 26 Dec 2023 10:37:02 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5274878AD
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-77f8308616eso387134185a.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703583416; x=1704188216; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ocy0jk44TeJKODgJIZSPWBXIqR4Y28AwTSEyhInmIg=;
 b=MzARJJUF0WXhAPDKtyxUsIx7yHt9u4gS1020scZaTzKoieYeuqR+WQZHqW2VNSOUCf
 3GpzgKgR7Dtk5VrcL3+JKl58ul3d2dEY2MpuJNEihfKGYnwi6kOYe591E+doUE1c1PTz
 1dlAxI8ADGsgRWlvmZ7H7Irjk8DDlBUjS6cr1Z8pPbqM1wdnDO9LgeeLRzT9Wzj3vDv0
 hOCstcDLQ+Nqcp7l4bEJLCundwO9igDoPt5mSWIe283H7LYQvxITYHNDYdhU3feopLyu
 aAYDuK+Ifx0akQ+XPnvw1PfzPkSHVQeML6ALjbS8RFiSDGsn0kwy0mb/cny9BRw5pitA
 j/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703583416; x=1704188216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Ocy0jk44TeJKODgJIZSPWBXIqR4Y28AwTSEyhInmIg=;
 b=OYp9PhhB2WyQ9DyP24xlHkG9IYjcL0lSXB2/ye12WtDgsJlZ/U2k4W6M/PaNjj/eLH
 0yX8c4kKbNCBoBteF1LUfPqLbxUMjHkdJlxJs4nOPa57ileCZMxHEDT3XSp60nSiqWrQ
 kP47a9pm5BLuXA5h9+Ifg7KJPLKa2m9E9Mnltk1XWeVxopgWv8heORm5BXqao7hqFkeK
 DAngwBTwKJR9SZH0PU/GIp7qnAV3Zt7EPjeofjrvpJqjdezCoO5XosdZD241NE5BiGcg
 BLuAf+EZoz1NnImcSIR0/s6EYKj26rsSNEEZ3MFKpQ784cuozf2lrl+54er4wkU/JKBZ
 hftA==
X-Gm-Message-State: AOJu0Yw95hbSfz9YA7T6XVSv0Lc48nEUxxfuqcdTrMNlEkSQZVTFpIYw
 O4qm3CuiiUb2iMiRN5mKpAHKl5Lh2CeaAEdZed8x/JrChU6nKw==
X-Google-Smtp-Source: AGHT+IHSECvLu4RlyEjGkHO499Q28pOP6MvBb0iN/g8sTJNphMLJ1qXsCvSyb05H9viZBW6D32Xm86ZaHVnwwElNkcU=
X-Received: by 2002:a05:620a:15aa:b0:781:11e1:5705 with SMTP id
 f10-20020a05620a15aa00b0078111e15705mr8832112qkk.136.1703583416502; Tue, 26
 Dec 2023 01:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
 <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
 <20231222-whole-canola-81240881c2e7@spud>
 <4a809aa2-0cc5-4ffa-a19f-06d69ae9e460@linaro.org>
 <CAFA6WYPY7DmY3+Wf-=xbCpm11ub5BWTVc_C=SeSPVK0dVLTQ9w@mail.gmail.com>
 <23752cd4-d443-4a35-ab9d-bc637e1dbb56@linaro.org>
In-Reply-To: <23752cd4-d443-4a35-ab9d-bc637e1dbb56@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:06:44 +0530
Message-ID: <CAFA6WYMstaPyar-ZzSZUMorhHALyhNhEunYOOoY8AG9feSVCLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within
 U-Boot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, trini@konsulko.com, 
 sjg@chromium.org, krzysztof.kozlowski+dt@linaro.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

On Tue, 26 Dec 2023 at 14:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/12/2023 08:53, Sumit Garg wrote:
> >>
> >> The problem I want to solve is the kernel maintainers to be aware.
> >>
> >
> > Although Tom has already expressed in the other thread that U-Boot has
> > been a long time user of upstream DT but if we want to make it more
> > formal from an enforcement point of view then I liked Conor's idea. If
>
> What did I write in my first email?
>
> "Maybe create a subsystem profile and include it to
> maintainer entries of such affected platforms?"

Apologies, it was a miss on my part. I really thought it was about
U-Boot maintainer awareness. I will propose this once this series
lands in U-Boot.

-Sumit
