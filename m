Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4C7C2D0CD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 20:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52BA3828BC;
	Sat, 17 May 2025 22:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GOeEBOvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C453A8091A; Sat, 17 May 2025 22:57:29 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C608B8004F
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 22:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30db1bd3bebso29605511fa.2
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747515447; x=1748120247; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQ2rQvqmANGs076+CPEtlyulDccAE/34/zIAcI/mNzg=;
 b=GOeEBOvHqjxDQqnWhx6rd3cDkNHxe+rYr1pnBZ7CJzf7UDQnOrjIaRubtwsoFatDmN
 eRcSX+WQAtWl3KzrFPOTYex/ax/lsZlqPE0poTrqd6MQ4wqcOw3TBHgJTFfi8QbXvT5V
 +GxdKRXDzlKoNJ4OU/5JO9LZYrhgL997S133WQE1np2GspwP4AWfvYLcAzrmGT88Es1T
 UmlzMeGrey44iKedoRigPjcog54zhrmjnGxwMy39IfV17O+6mIb+bJDqQjOJ7Ov6hIlT
 UuC0xWyjLRh2DPyfOnqYDGp+YPbDg4Aw1Wlus4LyDiA4Xn9ArGXZZIPMrkrLMurLZbLM
 CMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747515447; x=1748120247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQ2rQvqmANGs076+CPEtlyulDccAE/34/zIAcI/mNzg=;
 b=bjFAmOccIGoMKsq2LcFC1+tvxah4YCPfPFCKE7xCtEH+j9dSeOLtH8i0XMa9eCQyIZ
 X2gK/OtXECY4cia2vxi/C0a4+fIJwdipa0Xa2kZsVsMG0JzZZXHZjSSbrEaZaNvmG93G
 avgb6x6Sw5qWr+woLgSlDAxWdd1QqijFbv4J5/Zm58vLF2kUiQGyNtiabu9ou8O+gPYl
 ZyH8TaRk/4bWfBOu7rLIIQd640H34pCliXcvNdsbh5MLy+Cy4S9DXTTzs22UpO7HZBGC
 jeUICmw5cFIt/Pa54f8ILpM5JVkQi1cFydkJJqmUlVEJEvS9iEiTp34tCI+ocA9L7oZE
 kp8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuH96OzXGisWbVUy37Xk8BvL9F0NVrfnVgnIVKUUr5duc5EBz6XKaNkw1As/zULE7+j33FUDE=@lists.denx.de
X-Gm-Message-State: AOJu0Yww2AXQQCP+ELr5YVbpxm77C6jkBOtaMe4fm3mSpF7aNul0yJF7
 h9uDZzgjUJSDskooOoA4xmZxR3rJFLg9Xi5qmswq+OeROKjIyqkOg4jlhIhvoX+rXU/UPQZbUWM
 L70ripjt+lT/EvD/0ULKvtWOFXVA1VkA=
X-Gm-Gg: ASbGncunCoooJNMT4b6niebJ74QhQjj9ECEzfIEq5IRTdLE+oqUfYJXnXxsbfHPy8Cx
 eJfxoxxrpeFTb4FXAuFOzjdkwd9dlJQPR5//grfYKjApoDiKPdhZFskMbcOPSm3B//62umsDNHc
 dqaArYyRNO1nanlUhPAl/QiRSKsuIK4Xg8VVIs5H3fp622rWjAxxoU5dwOMkm0gVO+lGtycStcD
 Q==
X-Google-Smtp-Source: AGHT+IF9n7CtcIa/wTI42tZJFXOWUU6J2ZM/HziR+Zc5StC9ZIgO0B6QWX2aC9j4TGkTjHtcs9XX/uGP2EM4m9e3Bpg=
X-Received: by 2002:a05:651c:3041:b0:30b:f924:357c with SMTP id
 38308e7fff4ca-328096ba765mr15338171fa.15.1747515446507; Sat, 17 May 2025
 13:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
 <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
 <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
 <CAOf5uwnfC0nLBy1QhcDe_VpqE9LGh5fKV_Br4_=rZxMBNHw1ww@mail.gmail.com>
 <CAOMZO5AcUbYa0+40jZ=2a1dxO7D+tif82Arkguf_vVsP=CkzAA@mail.gmail.com>
 <CAOf5uw=cb2jQK1f-avqRvYxukYb-Sy-jWDvqEyM+nRLTnXcAwQ@mail.gmail.com>
 <CAOf5uw=099igk1=dEXH6dbUDMSH+bVo67mek_P=+G3Sw-f4B3A@mail.gmail.com>
 <CAOMZO5BM8y1ojYONMRBm+gBAgQ7ThWarzWZqfrEHwm3fM8_2Yw@mail.gmail.com>
 <CAOf5uwmU2--9+UpZL7uE6HvNUgo7w5H+boA0icw9WcRv=2GAOQ@mail.gmail.com>
In-Reply-To: <CAOf5uwmU2--9+UpZL7uE6HvNUgo7w5H+boA0icw9WcRv=2GAOQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 May 2025 17:57:15 -0300
X-Gm-Features: AX0GCFtZqbov6q4uoAyVXmJ-BNN1GZTMzbZZiIjb4xrfDB0VE2OuRZw822kYXrA
Message-ID: <CAOMZO5Dj4FU7_1Q06DFq0WFsDZom4GUONHOS=uBSCzr2ZOjPMg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Adam Ford <aford173@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
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

On Sat, May 17, 2025 at 5:52=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> Are you sending a patch? or I will send it

Feel free to send it when you have a chance. Thanks!
