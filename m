Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BF6C02188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 16:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD1D880312;
	Thu, 16 Jan 2025 17:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQ1bIhMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A898033D; Thu, 16 Jan 2025 17:14:07 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764E080214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 17:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-303548a933aso9817441fa.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 08:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737044045; x=1737648845; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6P9uqJMQEsgBo026eGRSQk4ciWfUhfsXJ+vi6ywMwuk=;
 b=RQ1bIhMHAsGTH7HznvuyvUJzdSBV6TFliU8vXw0WvCOBvwrsmSJ1/pC2ZF47J4F7ml
 CO0vmH52Sy3GrqlNT+LO65Bv9xr0wTqm1AABrzzFhX8x60h2k2e2X/bGdvl/COG0nU3+
 ixcrpTmsKnRmKA8MMgeCJw9iD7PxJMqZptnr+f1PvtX0JgRQRfsP09yTH8T3X8M3Jsr7
 iA5mZ//a0Okgs2plffh+hq1Q8aS0Uss4vbrs8ZWYapPOYiO31wE/bHEntroaEJYgO1L1
 0YZRUfXlUVAGF0yZAnn6K6Nj1mAPPwVLFKXooep0dBV8cHjvbH56RvcdvHsUVTfrB5eU
 rXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737044045; x=1737648845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6P9uqJMQEsgBo026eGRSQk4ciWfUhfsXJ+vi6ywMwuk=;
 b=A0Cd1dujNJjt0HrtXSGwabIlmY4i5HFEx4jywUblk0hSNTeI7C6G1Lq52JKdZ+0S0I
 4pVIs5efXR9u96gbZDlO/gnQSyT/2MZ2P2h+f6YBuShtiyEEZzMr6pf2x0d/LPATjK1W
 XWup0ePksZwm/Ej1GgcFY5dt+Q/tVcYzi/XgxcJ1pMjsE1mwZlXec+LZnSuwcoHJklGk
 P/CeHQ24kmKoP3Dl4C1+iV8/pEQZ23pMgrGq7OOMJrvy0rVuNLSgnpaoOnCe9eAcfYbp
 aaU9RS32k/GnlLUXGfj84D9KcuuBYJo2k96jF4hwywHA+g692pSIHORQowT//HvCpfjj
 OUFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxhqWH9HL9GUkooXrX0U/toOO++ghOkeXem/QzFG0tQEiYqU5URynVCh72xKa+7Z2wKP8rQoI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl+Gug+8M7Kz76XslcyEHTkOBmJMsvO/BFg1sMEsnB+O8QZWQB
 YwqUSDPBsQg7GaOYWn2dSFpZsIM1vVMy3alh5dNl7PWSrTp80vk7xsoCj7Iaq3nYVcxEOq6fSY1
 eUT044YK1gwtU/invoZXAlrQEunQ=
X-Gm-Gg: ASbGncuz3iP1O1QhGWPVOy+V6U8lBIc7gQ5WXvnfRAYQdYi4fCF4GobdwrO+9J8i6xN
 gS58GDMKdacQRJgZSXphaxaqnNoI8zFEq4F8VLZEHfbtfiSbZY+pm7wEmRNxt4thv1Gn7UQ==
X-Google-Smtp-Source: AGHT+IHe/KQH/FWmnyaslQKIL+zC1ESC7thnO7tjdsIoUEFX0cXxDbTZ1/bmoM8l7dv+VZVHsKVdHK94IPOtIU0cfgk=
X-Received: by 2002:a05:651c:1402:b0:300:2a29:d47c with SMTP id
 38308e7fff4ca-305f45a974bmr89327431fa.24.1737044044451; Thu, 16 Jan 2025
 08:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-13-d2c0acea6feb@bootlin.com>
 <CAOMZO5B2K64cc1v3yn26fXqHtEcsMf+eSj_Smm_vAr5shzfboQ@mail.gmail.com>
 <87zfjxsmpk.fsf@bootlin.com>
In-Reply-To: <87zfjxsmpk.fsf@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Jan 2025 13:13:53 -0300
X-Gm-Features: AbW1kvaIUsMdHTjs4CW4uNjHefm5V_-gwqumFxuCffpWmPWVCbzqfweK-kYeEEo
Message-ID: <CAOMZO5DRfTh_iOFiJi9J1FrDq6-VV0dWkCJD1Oq1cwBeVQ4pjA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] imx8mp_evk: Enable display support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Sat, Jan 11, 2025 at 6:51=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:

> I only worked on a custom design based on a i.MX8MP. We do have an EVK,
> but it has no display. I was asked to add a user, but in practice I
> cannot test that. I can enable the ldb in the EVK DTS or drop that
> patch.

I wanted to have an in-tree user for the i.MX8MP LDB, but if you
cannot test, I suggest dropping the imx8mp-evk patch from v4.

Hopefully, someone can enable LDB support for some other imx8mp-based board=
.

Besides that, there are some comments from Simon on the patch 05/13
that need to be addressed in v4.

I hope v4 can be merged.
