Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94958EE645D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 08:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E662888EEA;
	Thu, 12 Sep 2024 10:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P17a54+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EADF88EEC; Thu, 12 Sep 2024 10:16:00 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2485F88E8C
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f752d9ab62so7059601fa.3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726128957; x=1726733757; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Shj4Y7aKPGQj1nO5JbdRxo8MPatB6yiq3Mo/YXEDIAg=;
 b=P17a54+z6Bt3YoInPqo4sDaOfI0GTviGwUD0P48H6qPQsoyf+LrkuHSi53nVfS719S
 fIJqFEko6ntxAsBE8zbf7vszT9X84t9TF2q3sx+0oW26KCxnQYAvD5gqazkrusvK9/A3
 4LbcdppB7gzRTz7EzCBYN1IaV8JJ5mr9QtZdjWIdoYKDTKfqcyBTlryM7nZC4bNgfWUb
 nSaWEcOcn7IPDt3qjSjNSTWXSslDwOHZI4dRiFr1ehTYdQ9u2g10B6nvRLF6tGwobWAn
 kRNiXAlkp3OV95ocrcKMgPy7jWBVHsQrE7bGCMtGHBuJqGmVYk8PdC+LbJ9arY7LAmAS
 yn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726128957; x=1726733757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Shj4Y7aKPGQj1nO5JbdRxo8MPatB6yiq3Mo/YXEDIAg=;
 b=SDEeOAVGoefVo8Hoi0naTapbRyyc6x9WjgweY3A0+5ewPXarEJRIXscSZPAaMLimzl
 AmHYc7oA82Ox5e/qDGkWaM4Vms7a0cYqKSYS15++RFsAia1RC/6+vHtgV4I3B8TXoYZs
 Ug4MUpAyC8YYY8AmraVVWQ4ABhil1nYEaZpb66kICDGSCR/K0SI318c9DDMhD8huLlxx
 5J7ty55TmMMzrPmYURV3x/Gp/vHX7U3ndaGqFuB9qIXVpV5uP+ovc3h/V67oU/Fb0t/l
 lJi1ju2KUpNoCQYvlwTiq7wOPA0qpcHv5qaWuaOBRqX1BcNE498n14rxFDnq8lQZRXsH
 ucgw==
X-Gm-Message-State: AOJu0YzV2xuT4wMY08eTYe43c1utOK0LGW3Pm9OZorvGw4OP2OUTFSdw
 3IU8VvJ5q1Drjt0OFGnt8GE+ng2l/C9Nb/L2wH1b7W1L/BvvsjrrIaSAmkgFNo0ML2DyUCt9rKG
 khxgJwBWyYlRlnmql3LI3y6j/9Puzftbf8pFwCg==
X-Google-Smtp-Source: AGHT+IF+UGUn3PBVBpe3cphgFqgg2UI1kiY+i/fOlMrp8/vZrhzx5JSNOFlHiS/YvwdytPH3HpkFCbXFX8ovyxe36eM=
X-Received: by 2002:a2e:be0b:0:b0:2f5:abe:b6c3 with SMTP id
 38308e7fff4ca-2f787f30303mr10117881fa.33.1726128956426; Thu, 12 Sep 2024
 01:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
 <d27e92a5ccecc302a1b2ca7ff55b8c3b@mail.gmail.com>
In-Reply-To: <d27e92a5ccecc302a1b2ca7ff55b8c3b@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Sep 2024 10:15:45 +0200
Message-ID: <CACRpkdYxecZsgoUipPR8DgcNPKp-3o-h=Qseq71W8vceV4eXsQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
To: William Zhang <william.zhang@broadcom.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>
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

On Thu, Sep 12, 2024 at 3:32=E2=80=AFAM William Zhang
<william.zhang@broadcom.com> wrote:

> Thanks for merging the patches to u-boot.   We actually had something
> similar
> here locally but just didn't get the chance to upstream yet.
>
> We will review and compare your patches to ours and get back to you.

Ah, excellent, I guess you guys know the stuff better than me
so I prefer if your patches are used.

Do you even have U-Boot working on BCMBCA? I didn't get the
NAND to detect properly yet despite all the backported patches. :/

Yours,
Linus Walleij
