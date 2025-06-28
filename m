Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BFBC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 21:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6231282B34;
	Sat, 28 Jun 2025 23:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vyb4qg/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F6282DA1; Sat, 28 Jun 2025 23:50:07 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068E682977
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 23:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-553b544e7b4so919518e87.3
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 14:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751147402; x=1751752202; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zl90zY3at6P01wnlNmQwdUiP5qPWCbt5F19vpns1KXw=;
 b=Vyb4qg/dfVOhWfRI7xstrVFRfLJWmrVhrxIJaVUsm1YYB/6LOElZd5hIZEhC+Rslxd
 JwPDSwfaVXut+CAX+s/H77W8ZxmKM5wyQ2WnCwKkfJT4Wn15e90PlrlJX1OS+Uq90nKW
 dm4dn+BppEXdKLgm+3lU307wpM5YeacOc7EiZDEXCglIEddGNYdKHDa7sYhadkgn/Qfk
 RYjcNdXyhzBKZAbdxNgI4U7JI82cVBxT0no96wps21yVihjcUUdEOzGUDRRG1EI8brDc
 tKKwyi0ovdSh3P3h+vBR9m5SyMmodQ7yFx9IdvIDOT+xwc3vV9Pf6kVyqbc/s+D1mA5l
 z+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751147402; x=1751752202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zl90zY3at6P01wnlNmQwdUiP5qPWCbt5F19vpns1KXw=;
 b=PjX+mr57ERGy0XZgIS8s9XECuERc4lo8tkN2PZEyehOHuL4oSo1P30EAJXidymdGm/
 Mq6s1Q3YdIWNpOm99WvH7sky5KWLbVqzSd2Yo2GHq9QfLPM99xDf14/Rshl3wqhZpGps
 7n+6EOkCMREYy2YYv025szqjjSMD7RL3g4xRPEytKmDYv9RyHAijpeSQqb/jIm2bJYFo
 hhiO3VODiQZCbxNBHjSneuXzhzLnkGfMzolq3HPAc0wMfZQs+Tl5g114KBnUVAc+Jiw/
 H/lnHEXsffVY6kwqb/6aybDOG/I21DJGfD64wdVyju1LXM3y04DuxhoWpEb0iG7Zi0KW
 HUug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIr8/qloFVUVygVRd2Lu5aF9k1qizkcoQ7ZMk9El3OnLv5qH4Q2arnFvFGaIdt/JXnC+6gH8U=@lists.denx.de
X-Gm-Message-State: AOJu0YxoE5ogdi4KKvZgbo4jnA8avOwogCt3OsCeeVtKFVVqs02dueiO
 4rnJ6/ullll2lFUr2UM4SUHmSxPlH58f1EX/rPpejx2oNmaNYx6G3YAIe4dVuCxoRwHTmMb+VaT
 xZh1CfbihGtfaEU5X9nGkfb3Fh7Isbp0=
X-Gm-Gg: ASbGnctANc1cFUh3VeQ27qLM43nJeRzSlj+nhfoF8WgRK389oOzQELfURmrhu88TiaM
 gXxTwx95duxWk9+crCMI8/6WL7LRlOb9UwBhKJmIvqg0FdGXpHu/joLTKR40ZD0TFjXWREq/KXf
 pjHQ5eM/HNCHJCk0KWJz8MAY3k+Xcat8tky84Vxj5M+xawbSDLni8fMHT2lbO4kmlp/wJMTzQxN
 jI=
X-Google-Smtp-Source: AGHT+IGrfbb0gCS0W07elYgS0SfPbq7bXZyZJcPWge3AeN9HxVnDAjOatQX3fRXWqGmLlrYxZsMR4jtbzK15vyKfIeM=
X-Received: by 2002:a05:6512:1284:b0:553:2868:6358 with SMTP id
 2adb3069b0e04-5550b8bdf30mr2621525e87.35.1751147402004; Sat, 28 Jun 2025
 14:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250628214656.2395915-1-giulio.benetti@benettiengineering.com>
 <7fe3036a-602f-4ab5-8a8a-ffabd0a3ae0e@benettiengineering.com>
In-Reply-To: <7fe3036a-602f-4ab5-8a8a-ffabd0a3ae0e@benettiengineering.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 28 Jun 2025 18:49:50 -0300
X-Gm-Features: Ac12FXwyFMYUbpDic3Isw-L_0dtI9BDblukbMkHcI_DBjdcfCwPhGrOGZ8TrTig
Message-ID: <CAOMZO5BZR9e2EFKJho1QFM4B96L9oCKf=3+ZohfYujh7iFzUsg@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/include/asm/arch-imxrt/gpio.h: imxrt gpio use
 commong gpio.h
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Giulio,

On Sat, Jun 28, 2025 at 6:48=E2=80=AFPM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> s/commong/common
>
> can please the committer fix the subject when/if applying?

Please send a v2 with this fix and include a brief commit log that
explains the reason for this change.
