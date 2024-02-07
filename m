Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991C1C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 18:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E489587C8F;
	Wed,  7 Feb 2024 19:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FDpNx2b4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B434187B3D; Wed,  7 Feb 2024 19:00:53 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6169B87C8F
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 19:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5d862e8b163so206332a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707328849; x=1707933649; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKbqjwT7Dsa0JX5kn7V8pcQTwO+KqsF1p3dqJNYuWQw=;
 b=FDpNx2b4dRl/4k8BYzpl41Fs8LmCWkzPQ2apLwU5EkrW1UEgTWDAGpzOCZGrVQv35G
 0lfOcGlKOlC8AdCFQQglSblX9H4ojc0iagrLDW6DDCHZgLgZFI4n5aycS2x5VNOeb0/c
 PcD5Xu4UZ2dFvAOgos0eHOngB2Ob4J5pH49Y0DrSgWNmbetHGTlCEovW9jO3MKX//dUu
 +oOFV2iNZA+5O3ddJq2LOT3kcXiFNwFV9fdI63srAjlb2UytuY6WSbxDr0uh6rkirtRj
 4W+IOXUp7SfDmURYD4iVtqzwG+5WD6bP+eck6pDLYaOZMh7DsHk1dV0oDZ6ZVVrJX/lh
 EcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707328850; x=1707933650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKbqjwT7Dsa0JX5kn7V8pcQTwO+KqsF1p3dqJNYuWQw=;
 b=kTJY+dx1CwL790MeW971T0VqR9jnTmMcYBZshmE/LpQfsjL8zXlHt+B5a2xkEu+WX+
 iegGq7vlvh2tjo6rziBd+56VPOzpwPPnfOuatnQ7eTujdh6aKNV7e3duC5gxCSbojT76
 7QcNE29Vsjpz7c5jTl/hyHrjlxjjnS2jUJURFpSdXm0FLdhbzrxWq/ciBQwv7+yqOyAm
 EnksNrqKnTAOLGvpd+U1tNVTR1TtUETClnurbBGWz30opusom70eo5xGJVASLbLN/3ir
 6zubTbkeslEZCGI7y+QQTm9ltnevUBoARlUhfAV4nF+9lc56dcTebTKR1QFbzIKkiYzK
 drvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6I1xqKyylAhpzQBh0b9Yja7j59XJhEKDY4ZrWVhvBQck1xyGLp38LnJ0b6Iwi6y/+/xkN75QsxOzuVdnNCvYghCx1Qw==
X-Gm-Message-State: AOJu0YyaquxrOS+ZimzWbK37wllh9K70w2vyMa9mxs7LoeTmPMC5YcPv
 tEg2zvAENStVV65zf80pLPM+mxxt7mbZzbTlyE1Pf7D8nj6QgHPo26pvjmVBO35dQ2Hw55hTBi/
 b1Iocn2NpmGUIa32rAhrh2Zks2BU=
X-Google-Smtp-Source: AGHT+IHQXe8pzYDoeZMchGEKfJVdlZcV38YN+y9Ja0Jg3yCe5mQtpdIbMjSgc+GnFiQMiOpGiJD5fmZRL2eK9Z8QZYg=
X-Received: by 2002:a05:6a20:1591:b0:19e:886c:9035 with SMTP id
 h17-20020a056a20159100b0019e886c9035mr7004547pzj.5.1707328849543; Wed, 07 Feb
 2024 10:00:49 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
 <CAOMZO5C02Fwe0ci1RW64E2Gxi4BbdDfhDAJx4ycczE_6oW-oxg@mail.gmail.com>
 <CAOMZO5DbSnU0LdUJwZGF4C2wFuO4WDaoODJPy8WqLa=aoN+0zg@mail.gmail.com>
In-Reply-To: <CAOMZO5DbSnU0LdUJwZGF4C2wFuO4WDaoODJPy8WqLa=aoN+0zg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Feb 2024 15:00:36 -0300
Message-ID: <CAOMZO5DjB+AmBteNJeda51zrFO_atDZN_5gg14KmVgZpiTioqA@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Paul Liu <paul.liu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Paul,

On Wed, Jan 10, 2024 at 9:20=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:

> One colleague from you at Linaro was able to reproduce the bug:
>
> https://lore.kernel.org/u-boot/CADQ0-X_cj1ECn67U3sefcZ-Jm4OBSYmZkA+JaZRCa=
3ekq84RaA@mail.gmail.com/
>
> It is not specific to i.MX.

Have you had a chance to look into this wget problem?
