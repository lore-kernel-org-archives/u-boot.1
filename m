Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC85CE7718B
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 01:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1493080378;
	Thu, 26 Dec 2024 02:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IsScf6HL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9FB8037B; Thu, 26 Dec 2024 02:08:47 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2BD80374
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 02:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso7386143e87.3
 for <u-boot@lists.denx.de>; Wed, 25 Dec 2024 17:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735175324; x=1735780124; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhfLdxvhJn80EliNS2LL8n+hCurZ3t2Yo1Q7nkstYhg=;
 b=IsScf6HLl9oyCMAohnSWd+OZ+v4DC63X3yIJnDFzkgH+jGW7MLuNhzJIjIbHBJafum
 TCtTUx3CVgrUaSwzcPS7teWv35Ss1Hnxv1uzhtCuq3tMND7iVEN5MDMUAdu5CK7s4rSS
 FWX8xj7tqMiSXeQwHQP5zYySJGdUZCZWulXKJjHcx03tjk2J6yF9CC0uOnjFDAEJ2d0K
 Mt+nNzRqhyZVD6y3u5dXfYtmD5zLju5ysk2oRBqxJSDEY8zNPGCNF6ymH5V0MUyHaqrM
 Z7x/n4pJePNJlpsjoPJDUz3OU+neURbxALbaMDRP6z0AmjfGz3dvUXZcDY/iXfQtR7g/
 Hs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735175324; x=1735780124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhfLdxvhJn80EliNS2LL8n+hCurZ3t2Yo1Q7nkstYhg=;
 b=pLYlgHppMcYTe4zIgimp8p8W+0f2Uvo99lSXrBIPt5AsuBfReAaLKJZy2gVYAxczVd
 pzxtic981KHDeJSaLyHPSbVtTMpVoj65jmi4QhhMl9qUudCtL1++uv72pdHEWQcXE4Xp
 WS6+dVyaHa479vipmPl3rKu5NOam1Msz/cMf/roUVft40U3Ek11DSctrQbaOfLErMh43
 uQddZt1KkqVUWans77P7B2uP7xCgdN2UBGmAU8bOtNlmBYe/QSZiSKPOVfElg91tW9qU
 e7i4JqACiKz+6wKKXFGmLrzs9vm6BkqlZdc55nnp3QkXbJrF+L8yBxUi0ga5NKhY03MT
 1aXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7zbNUySVq291jpvXSGrMcB4vICkHeRuA68Z7x4342f53YOntZdg/yT4RXV1WewMa9KAUoXek=@lists.denx.de
X-Gm-Message-State: AOJu0YwpyoLScu+9sokvsLV74g4CPEjqEG4zec6Wcy+5G8zI+9lsny/N
 mL1zk1W8RikxjQmu0zCzE8lWqWqJbwCUGAIWMoMIkUJOxTdRY32wmtRIgc6TMlzlAhMsSAdGUXh
 NSnJxVCizOoAH63tz6nAaSH/FwY8=
X-Gm-Gg: ASbGncvCJblTNCHXlkEyXLGkutI09nFGX72wZMXGfGQchSfe2HKHtlYKq7gOukkgVRC
 NbKK/3Dy0+lbUc6cd5IpTTNS6P88P4V3lHgXr3+6AVc/PKgNmUcziSvgdMs/NzF9I7/7EwA==
X-Google-Smtp-Source: AGHT+IEwQDp0q5IeneaK5zv7Es4QkZCcUiqlQUWhFDzjihxIidyJ+VToL3mPDIIBoM7bqg+CACvg436aHIbkMyu5O3I=
X-Received: by 2002:a05:6512:ba3:b0:540:2542:d89a with SMTP id
 2adb3069b0e04-5422959cf51mr6594845e87.52.1735175324296; Wed, 25 Dec 2024
 17:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
 <CAFLszThYc3=cT73xbX4oRYRJ5SdcMJntNYwCkB4t+yKEsuaJyw@mail.gmail.com>
 <PAXPR04MB96443E60A06424B617D6EA66E2032@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB96443E60A06424B617D6EA66E2032@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Dec 2024 22:08:32 -0300
Message-ID: <CAOMZO5Cxr3=TmdRDb3fD=FMbD4XVxt_A8SMov-GNCC-QHg4asg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "marex@denx.de" <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Alice,

[Please trim your replies when replying].

On Tue, Dec 24, 2024 at 5:23=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:

> Hi Simon, Fabio
>
> I am new to standard boot and trying to understand the flow, could that b=
e a follow up patch to switch imx95 to use standard boot? Then we no need t=
o wait longer for i.MX95 patchset for mainline.

That's OK.

Please send a v3 addressing the other comments.
