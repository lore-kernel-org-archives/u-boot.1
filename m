Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692CBC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FD6882A8;
	Sat, 30 Mar 2024 20:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ecyTauTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB9F882AB; Sat, 30 Mar 2024 20:42:55 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127F2882A1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1def81ee762so6014895ad.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711827771; x=1712432571; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FBboCdNOzSmXVPhNgbA91YXZybHLLtoJr4EIdq2eZA=;
 b=ecyTauTNoX67ExIMhB8R+H3CtWdbbGGM5HCfCnUmzIHcW709OhGlLGCAVvAwwtcEYh
 42cGEer2sRo7C8Ov7wuGmlR8lj9g4Dyzn71erLzK8ltc/DRKvixa/BVkpMELVY4RM2+J
 HlRxRff+PXe8dyqVO8xGrnTOujaC67uzK+1heUeM8hhFK/62r86AlOQG5Sy7r3KrREoO
 cEwRDZOa0+GG8OLTm0k+yKi/L9Mv+t6QPQyy3eyT9Rw1DJiH04prNp8D05lHlEsqEO7m
 csBrMvV2P+HyEK4x/KY7EhRDnRStS4h0PHa6+wE23+Vod5jk2xSprOIrID9e4UPTZRDU
 9MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711827771; x=1712432571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FBboCdNOzSmXVPhNgbA91YXZybHLLtoJr4EIdq2eZA=;
 b=bpU5zNA/DQf5qDhWoHqMYKzDREmm7gZ8f2XSjkorhmVayblJV1tanpsjQMw+HGLL/V
 Z4G4UgEqHxUy7EnhgFmuEb3VfbPhIAcQuT38Km9lTXMMI+amNV4kCL27xlWMqBPCLzE4
 36hkI7D4Y0Z1c6yOQoOXbigq1//Kx7z014Veg64GRJG3uW6WH6CY3L5MPvtKX9h544as
 Vm0une3FgxuYAB3jnjwzKyubJ8Q15zGY5a8WywMfEsB3UAzvZ7X5lenIX/K10Rc7pM6q
 HSD2hlgNOi9OXpadloouSzpqq0nAoKSHSgGBH/XkpxomU3nX5CbWNpuhETjPqIAKZS6p
 7GoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1HmtP+NyPIGJXt8riBh8hnCvdluoKMgfbc6FgdxDoQGz4MTeaDQku2rIn1WY6pUSMf2fhPHPzUNnT4RpgCQK2dqvV6Q==
X-Gm-Message-State: AOJu0YwD4UxFdqJh+bRkdQdwxnjHIeaeUETT/P9JHT7UsxiMirdL84FS
 Orv2ErnBN/tWskD/4gVA+svWhlkcgq6PYaMNXAVVqVLbn6VsfHnMz3n9cMIyiJfG5lnrIk7BzpG
 sjze0flkd3eBvh/BPB3hOBiSMCBFiY1Vx
X-Google-Smtp-Source: AGHT+IHsrKf16VgWyjbS+Vm/cpIb3dUDAPdIUTmGJnTOZ4fLzJReFxLn9/xy5nHEPuxt3LxzvgaxLHwglafuHjNX43o=
X-Received: by 2002:a17:90a:5b10:b0:2a2:2b5f:3010 with SMTP id
 o16-20020a17090a5b1000b002a22b5f3010mr1845844pji.0.1711827771549; Sat, 30 Mar
 2024 12:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240329111809.3959962-1-lukma@denx.de>
In-Reply-To: <20240329111809.3959962-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:42:41 -0300
Message-ID: <CAOMZO5Aajgvrq_BTpcoHHGdPeTRMnHANiD-V+=HDP=Oy59EaNQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm: xea: Provide enhancements for XEA board
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de, 
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Fri, Mar 29, 2024 at 8:18=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
>
> This patch series is a preparatory patch for supporting
> different versions of XEA board HW (until problem with
> Linux kernel support for multiple revisions is resorted).
>
> Moreover, limits for u-boot.sb and u-boot.img has been set
> to avoid binary sizes exceeding in the future.
>
> Changes in v2:
> Remove "inline" from get_som_rev() function definition
> Squash with 'config: xea: Enable late board initialization to set revisio=
n variable'
> Update commit message
> Squash with 'arm: xea: Print information about XEA's SoM HW revision'

Next time, please properly mark the patch revision (v2, v3, etc).

Applied, thanks.
