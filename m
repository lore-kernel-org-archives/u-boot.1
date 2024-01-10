Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61CAC4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E5B687867;
	Wed, 10 Jan 2024 13:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GscBHBMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F6786D2E; Wed, 10 Jan 2024 13:20:46 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E75287867
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so544638a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704889242; x=1705494042; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xV1Uq53ef5j58058P8CTZehJDC39pX1s54j6C9G50JU=;
 b=GscBHBMS6WNWs/snEZiih6o2cXbXo40OtwcEhju3ViPP0KO02Llj7Fq4dSOzS5vdt3
 nypuHjH74hNiqRs+LJVQ4KPR8p7gPr1TT+ZhhCIieke/lav3X5dxUO15EWt4NEqrXqox
 pHCX8JsR0SE6OehKbWC+tQwytAkgPyd4MWR033a3JSB0aQ8YctCqYsHpR4vUKImefCmC
 WZsAAFRfTzlgxsVgteaA805KuJXF/Qrx4LfyHddn4tExR0+pt6IUxaLzclU5ylgFW3YU
 FVpDAQY5IqHIRocvy2v/4b1+jxN352cswUfK/zvbnvwcIHjYEu5U3RZHPoHE3TyQnTAm
 VIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704889242; x=1705494042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xV1Uq53ef5j58058P8CTZehJDC39pX1s54j6C9G50JU=;
 b=pbNoF0ujjQkP3sQx9cYKYrmYzVor5HlpoCbCk5obhsBNaGSfoxQW6LiUZS6JNIn7oi
 4RYojlpB9329mM6nNW66qkxBra6I+SDXnTvci4npJrvvMjVh5l00CId/XuC+c/BwLepj
 +x4M635LLmFmZNypuolMrBrLOZfCuv3s+h8BEfq8nQ16wNkNw1QhcK/Ox8lTU6vqBRw1
 8yiOM8KJum4ReDSugtcf5HFPWV+Vs9E7GWfYdT/Lm7sxA1n0xAp90D/KW57ofQi0g7kQ
 WFcYkVgNtiZSoAaEZ3TqEb/49bd1baNmI//GFp9hp8rSSsMZrNZT7KZgGpHz1Ud2uvaz
 DC4A==
X-Gm-Message-State: AOJu0YxHA5XAIqk3YIhFj1SnOAs50dX0W02Chl0wdeHdtJkGR9Ei3b4L
 Bh727ndEqcZ8aRROwcjdSSX6qlWKziv+zdjSif4=
X-Google-Smtp-Source: AGHT+IHA4/v9WtPXc1IZgwdHlvrz528giy6SS2Co+crf94ZeIyOUrrUYJj5hVOcHrUN/NoKdMd6iG0wF/tXvcFSyIcg=
X-Received: by 2002:a05:6a20:7483:b0:19a:3403:608a with SMTP id
 p3-20020a056a20748300b0019a3403608amr562245pzd.4.1704889242414; Wed, 10 Jan
 2024 04:20:42 -0800 (PST)
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
In-Reply-To: <CAOMZO5C02Fwe0ci1RW64E2Gxi4BbdDfhDAJx4ycczE_6oW-oxg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Jan 2024 09:20:31 -0300
Message-ID: <CAOMZO5DbSnU0LdUJwZGF4C2wFuO4WDaoODJPy8WqLa=aoN+0zg@mail.gmail.com>
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

On Fri, Jan 5, 2024 at 4:19=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:

> > I tried to investigate this by U-boot sandbox. But it seems to me that =
I cannot reproduce this issue.
> > I put a file on localhost apache server and tried to download it from l=
ocalhost.
> > I might need a more persistent way to reproduce this bug.
>
> Do you still have access to the imx8mm-cl-iot-gate board?
>
> I am sure you would be able to reproduce it with it.

One colleague from you at Linaro was able to reproduce the bug:

https://lore.kernel.org/u-boot/CADQ0-X_cj1ECn67U3sefcZ-Jm4OBSYmZkA+JaZRCa3e=
kq84RaA@mail.gmail.com/

It is not specific to i.MX.

Thanks
