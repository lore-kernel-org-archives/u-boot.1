Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB6C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 15:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E421880AD;
	Thu, 21 Mar 2024 16:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GuuT/S3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B4687C61; Thu, 21 Mar 2024 16:38:39 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9853488095
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 16:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6c18e9635so264887b3a.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711035516; x=1711640316; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNolyub43/3iavJwpOs8Hv0DeKmOADQT4N1dLr3CWp8=;
 b=GuuT/S3VIHvVZtsX+jX6kOb8ijZpZMsgbpUt0lZkB1em+yrqowkHmhSDw73ke2SIy+
 +aZlNpQOBfgMSOtP0fIR8iP+LzL060SbB6U8P7K2VX79F9nu9/uniHC+RoCK0Xz4gtP9
 5+3RE9E7TZ9h74tL9S9PbeHUYaYiMKnMHm/mUBerd8QodoaYFR9v5GR3J/7EUvFRfIJj
 iIahc0TNwPFVJiVAvvdtW7oxwnyGOfkGH2etjJ9odk6hBd2ExDo4XM2MCygmK8WdXIdU
 QwdbI80+KcoHbXAhzmCiIEZc/vTzYzJftzHBiJggMn4wypt5QCwPEF+ryOZJn9aTPa2n
 sueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711035516; x=1711640316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNolyub43/3iavJwpOs8Hv0DeKmOADQT4N1dLr3CWp8=;
 b=jOdqlZ0aMTyQ8HAjrO7JZmkjOBJgVAXR6UZgPr2tAOTD5+kQU5XE2Asgbn+BlTEiD1
 kTb9bXrXi0A5TRd8HpqEuhqR3CzWf2CfpIyC6A0QcVjulbiKt9DJ036w21vpC/0fUsSp
 vWxJ+ei3UbCHrfHMX8yILqt8hOi6EXK4HpaHDtmCfFag8h3xvw2xongmPTtUTwbStLIL
 rUcWBIKbdxy8KtLSDnD8FeV6KFPpVK/NVVwcY1O4n8MX6eRV9xdZ4fRXVreVkiZSgJw6
 M8GmCtGL7L7QfAv7gxtB9KJ1TrITg6k26M4bgz+O083bj65BFMhCfJlkCOunPHBdcat3
 rRtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDxP/+XMvLCBe/wFHbqlcKQFik2GNGHFbo0wnFt9ZK+F64c70yAzvEn/k1bNTao3Bt1MX0pCAbtRyerQbWWnq7bL6HDA==
X-Gm-Message-State: AOJu0Yyv9Iptn72oMTcwnvu5xrSVj/PYcS0UHv7eHuBOc4HgDt6xZQvT
 wdl0kODDINZCPvETDDmT/KgeEW658EWf+kaVAJF+cwsO63uvYQwa4SqBqPas5AavMLf4V/FKpnI
 B0ZQpMjN+M4CD2jrlO7fG2Cws1gSDS3vS
X-Google-Smtp-Source: AGHT+IFXRRqhPzz/G6iK+1bEnWdAQEyM1QtvXCuvzUwK4en9vh/6VdzetdZaRSvNYZMV7+J+ltvkJhCPNkB0qz+vK+0=
X-Received: by 2002:a05:6a21:338d:b0:1a3:9f10:20a5 with SMTP id
 yy13-20020a056a21338d00b001a39f1020a5mr24450pzb.6.1711032474462; Thu, 21 Mar
 2024 07:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240321144541.15314-1-othacehe@gnu.org>
 <20240321144541.15314-2-othacehe@gnu.org>
In-Reply-To: <20240321144541.15314-2-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Mar 2024 11:47:41 -0300
Message-ID: <CAOMZO5DkJwqtp5v1w9GTC-oNdc67KE+5SvstP1QqeNAz9+FbXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: dts: imx93-phyboard-segin: Add USB support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Yannic Moog <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, u-boot@lists.denx.de
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

Hi Mathieu,

On Thu, Mar 21, 2024 at 11:46=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org=
> wrote:
>
> Enable both usbotg1 and usbotg2 ports. Disable over-current as OC pins ar=
e
> not connected to the SoC.
>
> This is temporary, until USB support is added to imx93-phyboard-segin.dts
> in Linux.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Thanks, this looks better:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
