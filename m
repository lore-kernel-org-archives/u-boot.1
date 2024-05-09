Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B427C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 16:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C3B8810E;
	Thu,  9 May 2024 18:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Im7Ntp4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C516D8811C; Thu,  9 May 2024 18:17:45 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7E687DEF
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 18:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59c0a6415fso306033866b.1
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715271463; x=1715876263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tpy3QBvbk3YK+IgCmBvmNsQodDUvePGmwD4TYRZpIv0=;
 b=Im7Ntp4YC5x4FGK1K/UosYEAR3f1+4b0t/kSI8wxbhRoh70//WWrrgSyZbWGMF2DUj
 ZdV+GzluCctnYyAclBtnkZihRAhnoAUcsQ0DznoUur5eX4JC8sHUubomTXBtBKXa+vjJ
 TSAg6QvLT1KZRVQOPbwV4fzgcKNBM8Tq9c9Km/7cXUFZU/nv+kHwbn4VoQ6Jarb9OYJ/
 +CL8v+XnHKiPVZsEKAj1zsl9dGjWlRDW5tLC63D5fvCVk72KMPIL1OMDtlQdaRl0wazS
 obRWtfrjGS/kd89xl5FZcmqXCTl/AAhgLxwftuc6uPCgdJvvMdGS1uKy1AulFZWsAitX
 mrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715271463; x=1715876263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tpy3QBvbk3YK+IgCmBvmNsQodDUvePGmwD4TYRZpIv0=;
 b=U3LITbMZT/YToAzeCtLLbW2lZRsg20LqVzhEFaCf7IsdX4wXg1isumzWcqlRJRcUWK
 94sZVtrggJbb3WNN75OQT1cqJIZ/Xaa7pA7L3WY7+lu2EO9UpmjNEjRwwHI8azwXNSv1
 u4zGvMPURhJ26EuyRcZZU3BXt/+6dakgZMW5C6FrQ08DGCorYp3BxXErtJfgiV0kFAKp
 QitGAZjAq4OBDQO4kQ1AXsiOmSaYRl7GrtUW8eGlH/iN6865NK0pDx5kNNF01Jr0Cw+F
 ml9Toa1hCc+0FLFlH7vaxv7HlSPkGbFbxSxdjh6Zb/a/I/1arTcDdhVu8Xs+W1cmvkCw
 FQpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5nzh9g91BCAWldnBVrRRS2bjk6roZCiRi87Rrs6ivNb5WBt+dnn6s9GCTr+ayWLNogrDBc8cmtSl7il1F7Di45sGVvQ==
X-Gm-Message-State: AOJu0YzumeXSuePd+LM7UJWljOb4QmND+QWTE6kytfSi5858ksQuIYpf
 MdR9Vp9SAfM6SwhhfZJLeWBuafuCNkkQmNZ2AUZHvE7cx+yqX1gCBXqO0lxcjh8qgT3P3O8FG8s
 rLtUnaMgxzpZIc2ya5arxewgeX7D8DvEjHZWwxA==
X-Google-Smtp-Source: AGHT+IHVjLLW+QhN2T2AijcGZ9U2BYtLXSsU9Cs/w1Q38SWXsGTYBI16oo+Mkzpgn6ZrSUFTokcFWJtSGH5Nz7lvDE8=
X-Received: by 2002:a17:906:852:b0:a59:aa0d:6d with SMTP id
 a640c23a62f3a-a5a2d6287b5mr4954966b.62.1715271463263; Thu, 09 May 2024
 09:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
 <20240509143743.1496210-2-raymond.mao@linaro.org>
 <20240509145343.GG2568172@bill-the-cat>
In-Reply-To: <20240509145343.GG2568172@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 May 2024 19:17:06 +0300
Message-ID: <CAC_iWjLy4kk-PTc=EKV_e5s86+NbL4Q+sjtpRF4CYxpoJa1teQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] image: remove redundant hash includes
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Eddie James <eajames@linux.ibm.com>
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

On Thu, 9 May 2024 at 17:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 09, 2024 at 07:37:38AM -0700, Raymond Mao wrote:
>
> > Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> > u-boot/sha256.h and u-boot/sha512.h
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
