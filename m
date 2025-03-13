Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBC5C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C35B80FF7;
	Thu, 13 Mar 2025 20:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cp9399JV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3998168B; Thu, 13 Mar 2025 20:58:23 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D371380756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5493b5bc6e8so1473863e87.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741895899; x=1742500699; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGvxfT1ZMMKZh905PKarHsU6hG+Ozf/lNIMFy4uLX8E=;
 b=cp9399JVCSu+d5f3RcH1ys+wS+KmQH/mfLiWIvM/Ep1X6ZufnXcztvZKjnWFeRquYR
 hpsaKOnfWgOniuTP9Jaxd5E1cPb8A/fqG+GErKGx+rwxJxFuQUrADaxtbs1YFbq6gsvi
 ASj3QCDAEQmmA8jE2AIVuiHZnCnmLEGcQyLvXrdDdMW/ww9gokK7k1N+RB5Ysr/Bab0t
 wTGmYd9qUkHx1DgD8Rzy7FEne/Y72IcZ1Q3LlKXnfu5yoJGTRfQ2droFdkkAFBbLGyv1
 8tF6YnUwtfp6IxEiqi8kjc/xQGjzV3hjF2cZoxmJr7POVvzGqlBEhPs1k88g4rIDlL8v
 HWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741895899; x=1742500699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGvxfT1ZMMKZh905PKarHsU6hG+Ozf/lNIMFy4uLX8E=;
 b=C/oOR4QatdzdcGa2NWrbx/HHgBSbLsfD4Dbku2JUMYrwGEOT67XUDaaVvqk551P3Gs
 n0+nBWZm46b1y/8qpqADu+V2VrrC2ZWLyZOmlozTkrAdg1qqB3bFoMda4YvD5/tUWkyz
 mCuMazK4qvoFxxGfY1dTF8QFHh9p4O6Nnf1DQ61CyRPcobK5iesxRWPPhyaROQuCLK1L
 0TzbSrLcW3cMunrxtInwYiJvISGxItmqkEMayhFfMScUDgReFHcCr3zB4BOfgKk+PWYY
 VSMnVnGofJcPyGsB0pK/3WZOR+93oIZtryVHNMN6gfRM6o5j4/KjAjDt217yEJ5EbH4z
 uplg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlMbnaLzrErIIvV3u5n0tXyZRLHpOCDLOF8PlmGki8bIeJkeJn76Xl9JAh8jAIa4MFyBkidA4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4pmvtrpUvCrxtMcEN8qMMGGjt3eslllZPSV9UtkJsQO4cnppV
 gDmB0X/FdhYUD0YRxKtBBkubzbynn7Ym0BgwiIE7gWi9IfvIEvLHKq8LB6N02PA81cIT3vmvtnC
 LDS7G9z0Oe0b9R2Mj4DBpn0qq3vMiuw==
X-Gm-Gg: ASbGncvqCh0u6gsUYWZt9JonwTBgzFP3cFBtvCrNqxLykbyFShk2Fekaa21ZYdM3uyw
 CoUwXCk+arSJbTAeGnnWkF6vpBZZNB1dPa3yCPAA5bguECcRrfhlwgWqf5tgK5zTorXkg8rWpoz
 yvEU4U1dx/N6r6OTUB/GaCz41H9KGyvKjGg0pPkeB+jIfQgDYgx3RkW/ogX32kfyWWw5pZ
X-Google-Smtp-Source: AGHT+IEJOt6EkuG65f1mlyCDuRwFXbK5i+D8W2bJX0xu6fkpQ4ATRm+VnWCFx2ODOPmZrZ9Cxwq4XvCvhLvZAEaSLcU=
X-Received: by 2002:a05:6512:114b:b0:545:ab8:2bed with SMTP id
 2adb3069b0e04-549c09f7fe9mr367027e87.28.1741895899097; Thu, 13 Mar 2025
 12:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250227165001.252176-1-festevam@gmail.com>
In-Reply-To: <20250227165001.252176-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Mar 2025 16:58:06 -0300
X-Gm-Features: AQ5f1Jp1APVlmk3O0ubmGi81pJnKf4-jpwqCMk2D1X3rHG14X0g8j_U5xfCX-ck
Message-ID: <CAOMZO5B8Yfj+-tutUA2bmo6VL_D7768OXg5aq37102seLbJX5g@mail.gmail.com>
Subject: Re: [PATCH] imx9: container.cfg: Guard tee.bin inclusion
To: peng.fan@nxp.com
Cc: ye.li@nxp.com, trini@konsulko.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Feb 27, 2025 at 1:50=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Guard the inclusion of tee.bin with the CONFIG_OPTEE symbol to fix the
> following build warning:
>
>   CHECK    u-boot-container.cfgout
> WARNING './tee.bin' not found, resulting binary may be not-functional
>   BINMAN  .binman_stamp
>   OFCHK   .config
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx/next, thanks.
