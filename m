Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC83DCA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7743188C9F;
	Mon,  2 Sep 2024 19:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GDr5V5Xt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD03882EF; Mon,  2 Sep 2024 19:45:33 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4860B88CD9
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f3f25a1713so53189391fa.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725299129; x=1725903929; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZAVPEO45P4NU4uewC1YHgqiWBD9nZXAmOu7tGLLExA=;
 b=GDr5V5Xtmu9stMFuYILJp+pxF46ea5t38eswYlIeEyTLNmbmMp0D2OMwnLf1Cww/ex
 J3MkZONt9/xsack+2pOqWNUoTxduXe+KG3Eohgh/2ro0s5FW1naCAn+c9MHwLRQJQ0mw
 nfARRqxtpsTj8JaPy5A/1TC6PB8aDVTt2POhOe8Gsn1OKcVtow4z++y8490s/4sAi9CU
 7ltoooFOjFd26+PDwuq9UTDQkippuv+PWbPj/ktS3/ot82+GojUPzU56dpOU83xdeP6m
 Icui7uRh9qq/IArX8AeelW3fl/1ebBPFD/eS009RERLeo5r1MocjtScdd4u4vN9/3EuS
 YnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725299129; x=1725903929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZAVPEO45P4NU4uewC1YHgqiWBD9nZXAmOu7tGLLExA=;
 b=iG5Y5iG3keA1fTwe6dREqsJJNBDplapO9fmE0IJcFnw+26WpD09mbAS2nXbTjNiBEa
 b1usjs+aatYhzhELGgnOHk7/akXJ75WfolTn4TkUL8+Gq/APZmkeLFfzY5q6FWXsqTEe
 f8MsEGqKDsHFd9zcooBOQbgPDT1GgaAcwIwK9trRrBg4i1umOEJv0YA9OWBFEDHrPcwO
 OAkheDvg7EBW+yMIQLui2P84LjLwXbzfIq9Hc5NYpsRJY3oqjg/V11MwXxzukvwXazs8
 /wxF0ealy+cTkXVSfMi5oXCrA/pfDPQZnrwuBDiwJEP8MtVKDQAv0t5XFnG+K1PZGVds
 Kc5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVEjtP9Av8JzpGbvBVU7VIS5id4HBuIi6BmxYp6BH07Ih1uUwA+ZzGDEVk6VlSX07nqFG+tWA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/q18qptKVwgpaQxvDqvoj2QOj+lOxSwCi12H+dQmCo54dXniR
 lFeF9MCbFCd5c9fmN4IFB3VPovUw6kL4qT6YuAdrUrFrRYJCa18NqBd2+dkcpUgwd5HTIQzVVyE
 Eb9vlEcoL9h0e8zd9KL82iG50PH7/0A==
X-Google-Smtp-Source: AGHT+IEnX9xJLBOodJ/khIS5QW23YA2OFnrasSxpjQUjtIgTmulnMSBrXtp8qC5t8Y1T1W1CG+U5I3/I2tN7SryISHY=
X-Received: by 2002:a05:6512:1094:b0:535:3d15:e709 with SMTP id
 2adb3069b0e04-53546af3fc0mr7510878e87.12.1725299129235; Mon, 02 Sep 2024
 10:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240826100707.5923-1-othacehe@gnu.org>
In-Reply-To: <20240826100707.5923-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 14:45:18 -0300
Message-ID: <CAOMZO5Ab=XwW66kUCDRFjHCKCqd3zQ-20V=qaPHmwG0s07gdXA@mail.gmail.com>
Subject: Re: [PATCH v3] imx: ele_ahab: Add HUK derivation support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

On Mon, Aug 26, 2024 at 7:07=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> Add a new ahab_derive command that derives the hardware unique key (HUK)
> into a 16 or 32 bytes key and stores it at the given address.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Applied, thanks.
