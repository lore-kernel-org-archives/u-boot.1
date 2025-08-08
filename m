Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB52C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 13:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ECF68472B;
	Fri,  8 Aug 2025 15:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rzp6hLgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704CF8472B; Fri,  8 Aug 2025 15:00:35 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6224784728
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 15:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3322e4ac195so16861791fa.0
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754658032; x=1755262832; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzvBZRt59fqyf66+xkEv6ezA5ADXU2S3GFslAe5loJM=;
 b=Rzp6hLgjSyPsMTyN2tWRNG5qgfo7GuJwloKuQ0whMWFNPE/ThZykDHzvPQEKCN9wk/
 smgEQ1KECh8d/kesSJC89VCpSKf/3BdIsIHvr2MCeT6glPUsJPw+6s3dZCzUD1lmxbYB
 l5SR2XlarlBMmCATCSi+LMlroun9ZV47rHa4R369wlj09BdqdWl+1rXpjkmTKVB7o0p6
 9XJBeblr8RJNzlzO2HyBBt5EUnpGXMtoEIzN4M5lKVToVDqyOCT/ONEy07wdiyHyp2kG
 10EraC9Jty9eCrr6SBMh1V+GMSbAZgjRR6LrR+FmScinm8R5rIIl8EvqNQ6Rf54AZMrs
 rPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754658032; x=1755262832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzvBZRt59fqyf66+xkEv6ezA5ADXU2S3GFslAe5loJM=;
 b=qgB6n7VdmNOE1O1Qc4drqQGIruPu2cCLBcBtigQJNo6A/ctzCKXgjDTqwWjS9jE9GX
 ol7XO6SJ0E6jjZ4CF0Htn1CPkSbe1yQMy1cwHcL5ekosWX7asxh74b8nztmp72vZUsLr
 4tKJBy6RTv+8Wn8d8TK/n6E8rwAparFcsaQNjbw4Q3sEXMsafBxS+Tff+F3JMMY4U/pL
 0nmcMn6NyJ9PsUj7LdqyzDSfFWRcTo4fGIeL82UQKQ6BjdxOML7DljvmE5NTv6AjyOct
 mwZy6jjSgHYI3HlREKew4DEZiZnOshLHF5cTQY/qGMqJ1yX+1NZiIqp5MP9xASnH6z86
 yu2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7tKYmLSaEPfuaW+ka7KFAulwY7w9+H4hNyY6GspnZnxi5/eDhr7ZLHEbcsRDPgqvWHkqhowY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx76wDdADRNOu4FW9nGP7rJDstrj636cBSIw+gZjtvXf4mElvuN
 qCewJaeiHZv5Vk8DTN5OsgL+anLfAWQKFnLrmPAV1TavY4Hxk8l8p2ZYMsndct7ZQ1jSTahfhch
 oJwMZGUQBLSG+NYJld0NqjZK84fKZD7k=
X-Gm-Gg: ASbGncvIXOQMM4HlKttuAc9zP6oL779e0s7F7n89NFcryIlJfN96Wdtbc15Psi9LSW4
 vwxPH0HM8PXEREqg9XUT3PDDG+7IgekeDKtfQCPP/F27FTZzHABh/yVyll99bAvrcy7rGtQcVIm
 fLaBfKq35B+OKPhIU7ksLB2zsCUs/UsN6dUv2SuAMpVx4r9noc32mAeuNr1twMEw3ARxyZq+JoO
 8lwYdGUjjQlObaL+EBi4EhbAvdYFAmOMgXlUqScwN80tWsv
X-Google-Smtp-Source: AGHT+IGW5l7eonLwbZERZBvDkrc75EPGd71jRU3PHb7WxH0uaLm+Isr4VIQwNcOj+fUdPEf7zc74DdajKOzNNZ93Quk=
X-Received: by 2002:a05:6512:b02:b0:55b:760d:c2e2 with SMTP id
 2adb3069b0e04-55cc00e30b6mr684865e87.19.1754658031665; Fri, 08 Aug 2025
 06:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250807131354.1531908-1-primoz.fiser@norik.com>
In-Reply-To: <20250807131354.1531908-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 10:00:20 -0300
X-Gm-Features: Ac12FXzu6-hfFJVTalhz3qeR_CyZdJ3fM8x3nKZtFe-uTenYNPKSU5myAqDNAJo
Message-ID: <CAOMZO5AstYMTkAtU7__hUgs0y7Mi-Tj-3rTAzuqs3PfB5sRdRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx9: soc: Reuse and export low_drive_freq_update()
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, u-boot@lists.denx.de, 
 upstream@lists.phytec.de
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

On Thu, Aug 7, 2025 at 10:13=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Reuse and export low_drive_freq_update() function. This way global imx9
> board_fix_fdt() doesn't duplicate code. While low_drive_freq_update()
> can be reused on boards such as phyCORE-i.MX93 (TARGET_PHYCORE_IMX93)
> which is not using the global imx9 board_fix_fdt() implementation.
>
> While at it, make printout logic less verbose by only outputting on the
> error condition and not on each successful clock fixup. Also drop now
> invalid comment (low_drive_freq_update() now does fixup for internal and
> kernel device-tree).
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied the series, thanks.
