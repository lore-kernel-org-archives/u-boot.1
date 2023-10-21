Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB30C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 18:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C0F87653;
	Sat, 21 Oct 2023 20:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uJgcyoLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA82587654; Sat, 21 Oct 2023 20:49:54 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC2487650
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 20:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d9ace5370a0so1820739276.0
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697914187; x=1698518987; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bx1EspoiEawj33KcGfBIRXyUhMEaoaIWYAXaebkoGY0=;
 b=uJgcyoLoeicMvkEdANuntN604cUZ3g/t5KbxjWhPHoZ5KHWPVa7V2yaJMT0ynPtt9H
 +aKp3YxoxoIvrBUbN49TGX4EPNk+Eoxf8qBpISPl2cl+oNHjfmmr7AftzvG9xVKunTcx
 5LZYyOsku/MyrkncJ6n83M3wXmKMvPPehI0tEsJ4XszDDfh1Rc67SZtoQ1/LGVfkeUdA
 Ye5dsW8IZYhKz/IL+166V852tZ934yGu69jU1psGNdH7zur5a3xdR2/V5rBB2tovc5u9
 ymwj+QFDBE1g285LuJWSZ0byknEI3VDqzhGP+zSaAQkg/7yn+KHiXiICR9wZkase1ZUF
 5bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697914187; x=1698518987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bx1EspoiEawj33KcGfBIRXyUhMEaoaIWYAXaebkoGY0=;
 b=sjI/0yLb+jFXv5YP1hEXwvZbITuIK6mx/AcgyQEuqQ0Wd/9keMY/xXBoioXecFzukV
 hMt4rY6oM6ZesS8B7X7+CxM4iuBrQr2K5wkmEc+/4AwmAlcitNhAo58Jg6F3aT9zN8Gv
 gpqz/ACD7L63AXIpH9w8CSKr/MZy5FWWJgJmh0qzmBrO85BR4ZBMhfqfyaYW4es4wcX/
 oJFQzclzHwvCrE56BFuw6oirWYjyF2l2RPww/SK7fuYRgZuV86Avs6FIxVaKDH7VL+ij
 3pgrhw82Qe9BbQRwfDqp6yuEPRSylK8HCA/DlBirs7EfausijLxDqTPgxpdhkGBTlwZ+
 PHRw==
X-Gm-Message-State: AOJu0YzfiUR2AYPhqPwzl8dRHKHT9PgQmSiDuWC0f2OHILjJeLZR/AN4
 9u0VNL3WbQ7yqmxmKxlJBYzHieNxyQzBDIn88f1aIA==
X-Google-Smtp-Source: AGHT+IEH20AFs+GwKu49mbCb11mpfSM/uChmekPxoTMxtNJoLsVqj4l99Du0IP0xQqekZco3xfeEeWgRe3N/bVDm4SQ=
X-Received: by 2002:a25:e08e:0:b0:d9a:be04:7faf with SMTP id
 x136-20020a25e08e000000b00d9abe047fafmr5702669ybg.9.1697914187319; Sat, 21
 Oct 2023 11:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231018062745.3153436-1-qi.feng@arm.com>
 <20231018062745.3153436-2-qi.feng@arm.com>
In-Reply-To: <20231018062745.3153436-2-qi.feng@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 21 Oct 2023 20:49:35 +0200
Message-ID: <CACRpkdbPE46oY4zWk8tunB16pViK5fRCcfgksEqc23xOwhJZLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] misc: vexpress_config: Use member .priv_auto to set
 the private data
To: Qi Feng <qi.feng@arm.com>
Cc: u-boot@lists.denx.de, liviu.dudau@foss.arm.com, fenghua@phytium.com.cn, 
 Peter.Hoyes@arm.com, wei.chen@arm.com, Robbie.Cao@arm.com
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

On Wed, Oct 18, 2023 at 8:28=E2=80=AFAM Qi Feng <qi.feng@arm.com> wrote:

> From: Wei Chen <wei.chen@arm.com>
>
> In current vexpress_config_probe code, it sets the uclass private data
> directly. This will cause one compilation error:
> drivers/misc/vexpress_config.c:114:27: error: lvalue required as left ope=
rand of assignment
>   114 |  dev_get_uclass_priv(dev) =3D priv;
>       |                           ^
>
> In this patch we set the uclass private data through struct member
> .priv_auto, and this compilation error disappears.
>
> Signed-off-by: Wei Chen <wei.chen@arm.com>
> Signed-off-by: Qi Feng <qi.feng@arm.com>

Looks like a reasonable solution to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
