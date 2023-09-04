Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EE6C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB368690B;
	Mon,  4 Sep 2023 11:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PPg33Z9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 217288693D; Mon,  4 Sep 2023 11:22:14 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9870686500
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so4460312a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693819331; x=1694424131; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laYO2uuZ1PU64OqPhv+gR9YcPM0oKIsnTNum0KIU7x4=;
 b=PPg33Z9Lw+gZELnp6bgq/UK8TFZLziZExq0KNMbgTK2szU7iaAd3mx7/K1Fcz/7IEp
 EVadHNanUlIQ3RRJSzadHzjvXlpMXX2rmWGiWgHBVfrsWulhkjMqtNV9wXho/LrYCt0G
 egJodnBymbReoF/uIioik9kTupz1fxXmcFFSSdhULMBlsOo+Mrcgc9/Sb5LJiwhyM0z7
 KEx91P46fHBWV6Xa6A7y4EYzL8swMWBqEaiiYAGHB/Mo24U0g2S8SCb40m8YPyk7wyj1
 9CHH+WcKxwobTiKsRzoRCL8Zo6e/h/sf4TjAHYr1O12M5zIwqoslGDlylwhdJVh+XDHf
 1p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819331; x=1694424131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=laYO2uuZ1PU64OqPhv+gR9YcPM0oKIsnTNum0KIU7x4=;
 b=Sqo6nw3Af6ILMWGCcl7661jHJN5StRb7TEm651VeBUaZPMesoOTOnRB1MA1qoi2iNO
 Y/p3Nozd+yp3dNU9kWE+NoFzzyMzmlSMcYHQYZt27MD2Mr55u1VHT8d9sHj23B7rqr0K
 M5w2zqn5bMa8iBsjuo7kyF4I2ZiFD83VYqWQ7C6NA8tAJZ3gE5svbF/T25AwUcI5lvfz
 J+WqHQDb8zUx8qyzF9B4jn+f6SLGzQ4nqio10mg8PhkCmg58u5HrAMuZLKxlxGmvk/lX
 6ID6pMTvi1fLhwuLa3M/ZZqQUc9VB/kyBQO+xiAejUx7fepnzRidhDeuY3nV6gItd/SK
 2t5g==
X-Gm-Message-State: AOJu0YxqeIoiARvdJhfiXsNSrd/FMX+BMWqutYgpLNtyrHpHSv6aYPD7
 h3WxQJvGSw4WluYrRpHIoktrg4J8aYTkjH1gnFTLd/J0IMspNA==
X-Google-Smtp-Source: AGHT+IHkHRnIb1pOi1vwCNDvSjGT6FbKmgeVdcBSKUfb6y0cyOT0d+NPur2YbYzW6SmY4GzrFh5KRy0kVZkW6OZ7XDY=
X-Received: by 2002:aa7:d316:0:b0:523:3e27:caa7 with SMTP id
 p22-20020aa7d316000000b005233e27caa7mr8411443edq.20.1693819331002; Mon, 04
 Sep 2023 02:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-5-sjg@chromium.org>
In-Reply-To: <20230823184746.842091-5-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 17:21:56 +0800
Message-ID: <CAEUhbmVbP9Tsjr6G40TOgBeyLyyRo4Qz2LPr5SMAQv3Rt8oUtA@mail.gmail.com>
Subject: Re: [PATCH 4/8] x86: spl: Change the condition for copying U-Boot to
 RAM
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Shiji Yang <yangshiji66@outlook.com>
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

On Thu, Aug 24, 2023 at 2:48=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Make this depend on whether the address matches the offset, rather than
> a particular board build. For samus_tpl we don't need to copy, for
> example.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/x86/lib/spl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
