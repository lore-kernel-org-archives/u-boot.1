Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747A6CF34A8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 12:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083EB88815;
	Thu,  3 Oct 2024 14:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OuFztGof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5748188CF1; Thu,  3 Oct 2024 14:50:35 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6673B88418
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 14:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5398e53ca28so1039650e87.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727959833; x=1728564633; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko98BDsUi+3Tio6lh9ZMiQkF0Bu558wlg3v1xSXUoVo=;
 b=OuFztGofWhHyZxFlmrkmp73AhSMgq8Tcgus48eY73c0vX6cJ2W/KtsRBfY07fFNC03
 rcOtry2//i0fCfG4xFJCcX4HJ/j9LdUJ+mrWoQ3J4/qVvpVRQqDOcyP/jIR+wouFD8qC
 C653cFlIJDBnDjEu3xAJYP7DZVLcJ03hUKp2SzVCfMwZKX0Zs7LuIOiqwEixdN55oAg9
 1gTCasa8Uf2QCUU/5UrOoLISh+gMpbt89f/93pHaXzc1yTq8T8dTH7Yo54bET0JpuH+E
 mDnIymVcE0xm778Nb9SlUXAcCrAJCbaVpJbXQYQDQ/kyNnUBqxBAJ5mMHdhSqQjbViZX
 JUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727959833; x=1728564633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ko98BDsUi+3Tio6lh9ZMiQkF0Bu558wlg3v1xSXUoVo=;
 b=xDSBOkFryCm9hyun3vC2DCPXQdMhdwXyQP2/V7c1Qm3c2BgIRJJT4ybuRUXE94uHt7
 YPC0WOvGf9D6cGoAnzJRtgu64VTQGoyfiOKG3Pto+f7pA8zth9MK5vosk/ekuXDn3KT0
 8Fc+2x/Jqyg/ob6GX1VW4P6CaXUh9c5F1ltSkKCiMO31quDxjLzWDwMKBPY/tlPra0Fx
 6ArDgLG6+2O4FXG1QoHkqOplZjRkq8i80K9rLN5i3fgWBFGwsLuZHYm9tpTtOMXrJHs6
 5OemMUGXTyqGeAnpFuhbsYtYN1SjdM8CH/ovn11Ns9rIs288Wgfw5qFSTsLxupBGs9iG
 Z3mQ==
X-Gm-Message-State: AOJu0YxC9QSk9ByGkqaNvdKM+NEczSzlj/1mezcMMj8l3HVLbu6TiK9a
 NFDZfks16l3bzCuyirvzRUXZx/Uebv/hi+ZkSzsncWohHFB+ISpFY/nfACoKdFLO12JiJ8+xUoN
 fZI75RvSn5kLCsUUxQdMakptmwVBzFw==
X-Google-Smtp-Source: AGHT+IHiJIzGM93MXhnyNGz0WUakLsxA+YSmhlyvRj8bQ/2sJwN5zFvHINdQWoi0ufwgy1F7qJj7MVWz6IjwuNL99aA=
X-Received: by 2002:a05:6512:3b90:b0:539:8af8:159b with SMTP id
 2adb3069b0e04-539a0684fd0mr3999384e87.34.1727959832307; Thu, 03 Oct 2024
 05:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240929131341.2761444-1-alice.guo@oss.nxp.com>
In-Reply-To: <20240929131341.2761444-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 3 Oct 2024 09:50:20 -0300
Message-ID: <CAOMZO5BEowo+jWtwJeaFoAakfOeK6KYEkKNWbAiB+wvqnjwozg@mail.gmail.com>
Subject: Re: [PATCH v1] mailbox: add i.MX MU driver
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, ye.li@nxp.com, peng.fan@nxp.com, 
 alice.guo@nxp.com, viorel.suman@nxp.com, michal.simek@amd.com
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

On Sun, Sep 29, 2024 at 10:22=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add i.MX MU based mailbox driver.

Please improve the commit message. The help text in Kconfig is clearer.

Who is going to be a user of this driver?

From reading the compatible string, I assume this is preparatory work
for the i.MX95 support.

If this is the case, please also state in the commit log.
