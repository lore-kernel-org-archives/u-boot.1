Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276DEC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7777C87A7B;
	Thu, 28 Dec 2023 16:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H/7ILTRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C03F87AA9; Thu, 28 Dec 2023 16:22:25 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D7887A68
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28bbe484bc0so1162265a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703776941; x=1704381741; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJrUtew+c7RicDjX3Oa6avyYMQgn7j6nXbyeXlbAASg=;
 b=H/7ILTRiRZUa19Wvr3HWe279/D1V+2rYTL9mgLxv1h0Vc0WYcw1ZdDWDEODTEp1TxC
 KSWfurdQVjkSMYKaERdYvavGB5FBUTNJ9bo9s13dGkPlFkAac5iFWBcxAm4P4tyU9vjk
 tteKOORVHNdcybCyqInY7+4zbUMe5UKRNHiPLFetEUhG8GfGOeFk3MlIH+KI5+hDoZvp
 Jnv5kvk+yAvLH67lzGhZ3/k5ZzCb4hnnzp3++H75ngrcbdgyhS+XYsmVjrRuOSW6Lbf7
 wamfK/A6fYJqp3eeaE/aWKivwJ7pYUlRWl6wZl9pS5vMQYGfKzSCKHWp3gs4b9hwd7hL
 oYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703776941; x=1704381741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJrUtew+c7RicDjX3Oa6avyYMQgn7j6nXbyeXlbAASg=;
 b=u0xnb6V3deSWgLvo8vFjnwtiDivIN2x/m/c8Z6+KWjDBE1hgrHRcEgPjhjb86PeNs4
 3Vn4d8ZItLxdzdV8Ck9A4tvr88zO2BK3ufb+HA0xZy8W52MSJP8Zz77i08E/uYvj2Z8N
 XB/E59noFMKlvgtPlmiivgmGeGcwM3K4nUm/I+ruN2iHk2xQPhuvCoPteebVumMkGaGX
 v41ExGL2N36PvF1eaa3sGHJT4A42VXjZB+l0zWI9/zKKwbbhV1kizyQAZ/Ms8FMV3YPb
 xaFYCOhe61OV8KR0ipe4DQlOv7nQ8IDszSpLRR7ZkgwPpa5rd6NugNjTS3x/rPr22K36
 3gVA==
X-Gm-Message-State: AOJu0YwTBOzcQUhgYUgULkCncsCp0QZsM36pkCuxH7jUf8UGN8dlfFVw
 wHoHjsNiFEs79AYzHtPCNo0JG6dAFEZIQ1SetaqZ3qfj
X-Google-Smtp-Source: AGHT+IEEhHAhjiw15RKvZq2LjSrm3MrRT72BXrYrzf3XaC59dODZ8cLdwp+XB8EG4sx9UR03eoYFl6iyjDhbEZmbvpI=
X-Received: by 2002:a17:90a:bf8b:b0:28c:2cda:abb with SMTP id
 d11-20020a17090abf8b00b0028c2cda0abbmr12054337pjs.3.1703776941449; Thu, 28
 Dec 2023 07:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20231209114555.16951-1-m.othacehe@gmail.com>
 <CAOMZO5DEwTgffO6RZz8BaFq+bmxM170mz6wWN+MQ76ss7r8O2g@mail.gmail.com>
 <87h6k274ys.fsf@gmail.com>
 <CAOMZO5AZ-610XqiXUc71J+on8ajsN7K=H+aH-pH8_isbz13eGg@mail.gmail.com>
In-Reply-To: <CAOMZO5AZ-610XqiXUc71J+on8ajsN7K=H+aH-pH8_isbz13eGg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Dec 2023 12:22:10 -0300
Message-ID: <CAOMZO5B6rBHZeRje7x-C_TbtSM2-hP4Kptdf-VS1YCsNmhVGRg@mail.gmail.com>
Subject: Re: [PATCH] Add imx93-var-som support
To: Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

[Adding Peng]

On Thu, Dec 28, 2023 at 12:20=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Mathieu,
>
> On Thu, Dec 28, 2023 at 11:54=E2=80=AFAM Mathieu Othacehe <m.othacehe@gma=
il.com> wrote:
>
> > For now, I am testing the bootloaders I produce using those
> > instructions:
> > https://variwiki.com/index.php?title=3DYocto_Build_U-Boot&release=3Dmx9=
3-yocto-mickledore-6.1.36_2.1.0-v1.1
> >
> > I understand that it would be nice to have u-boot do the image
> > construction with the firmware, ATF and so on, like implemented on
> > imx8.
>
> Please give it a try to add binman support to build the U-Boot binary for=
 imx93.
>
> I am adding Peng Fan here in case he could help.
>
> Unfortunately, I don't have any imx93 board to help with this.
