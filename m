Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B73EE57CF
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 20:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B952088B2D;
	Wed, 11 Sep 2024 22:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bB1JY8EC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 161FF88ABE; Wed, 11 Sep 2024 22:01:21 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3682388BF7
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 22:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so4057141fa.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726084878; x=1726689678; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kh4+CzF0RD9ZCAYZ2pwy/51cdQXqNk3+f9whCabj4gE=;
 b=bB1JY8ECPzLeqxFUs07k6avRu3cjyOTCV2zQ4msiemSPbgWO7wLPFmMEMP4oXn+IJO
 5EINo5dACYjRasFezASDzUoLI6FK4pw9BDh5cHR1ZoD8ay+k3PdNpjpkhSH0+p9kIBxp
 +EDKKUcQvZx+CGMdn11aX/y3G7tqPYrnKM7ig1AkZ29Di8RgAJ2jg/4B9m/n2kZM5Jvl
 YQE0jaNFnGb6EObh3noPWgaoJaqzDIxPA+zKYGOb3Holb4H+1gkZWHdGrELVwrcavsFG
 UB+rEZpc9u61xqP1HWrRjt7+4chAr6d7oE/eWCRJCWsm/2vj2BS7i2M8i3Vumke/ppwD
 ACiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726084878; x=1726689678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kh4+CzF0RD9ZCAYZ2pwy/51cdQXqNk3+f9whCabj4gE=;
 b=X7pAHOazP67HdZYUkH2IHDjRZekOETsw3bkB6+sfWIcFkcQOgJ2KkHJ2JcFArmrhg8
 jx28qDtxXZwfOvZkPcKDjMf+2ubNp1+GvE/vcpDTfaisQMimPHzr2yQc7EJhAJVdcfMU
 ejchSR7rNGKnfCL1TpqLg18e1HERUYF8K/MVKezJLEKoAAEZHBwAgBL+4pzFIUjXDWHq
 OMOqtNj3jNWf/RxAN+Kcf2Q0DAHZFleMrjLARQXLwgTXRWtNk77ncMeeD22UXz7Bx6+v
 gOv11HcKCF+2ya4XIMe4AtWR1LhzNYjcq4n+nn82xsie/XYvyJxnD/suITRNcLFSZK95
 ec6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/CwwtubU+5Jg4w1BHsU8Rhz/LtOuoJCekiaPI8UH/MQaT++/qntfR/33THRW9Ju+Xa27eiB0=@lists.denx.de
X-Gm-Message-State: AOJu0YxRYXUSMuwI0e1duAaarDdTHRzbmLyHLW47PpNtZML0gGftrPhw
 AgcwMBeRh8sGsYpMF5L16WXhkPzSEqy/vaq89gWIhasZyTMLG816vThdqFl8YjckIpfTBuv4UL1
 7BdjEaozLLYOAf0g66ylNBPAzphQ=
X-Google-Smtp-Source: AGHT+IGYJrj2F7SkWJjyS9/vrcp5USoeKKixWonXikI/jiLxMdwCUWWPSk+7HrHQQ48L8DrhdB/T+exIIxCynUnE7eA=
X-Received: by 2002:a2e:b8c6:0:b0:2f7:4e61:38b4 with SMTP id
 38308e7fff4ca-2f787daf861mr3141121fa.5.1726084878149; Wed, 11 Sep 2024
 13:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240910091359.102121-1-miquel.raynal@bootlin.com>
In-Reply-To: <20240910091359.102121-1-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Sep 2024 17:01:06 -0300
Message-ID: <CAOMZO5BZ8X8cXUfZNj9GpcYaEZXrhUntdp-wmOAWnLgELcY2aQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: imx: Don't drop the enable bit once set
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>
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

On Tue, Sep 10, 2024 at 6:51=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Changing the duty-cycle should not blindly override (and clear) the
> enable (EN) bit if it has already been set. For instance, a PWM
> backlight can be enabled and set to a specific intensity using two
> operations. The order of these operations should not matter.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
