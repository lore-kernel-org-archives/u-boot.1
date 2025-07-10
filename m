Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE3EC83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 14:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518B78363C;
	Thu, 10 Jul 2025 16:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak9V/TuT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0B68367F; Thu, 10 Jul 2025 16:34:39 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FA2835C9
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 16:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54b10594812so1033682e87.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752158077; x=1752762877; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5rs7lHMhxOASbiE0qenBSx5/4r48hTt89mrqp1gYxE=;
 b=Ak9V/TuTpRNpgwFst6iKq0DbHcBwLUmziSikOzRAHzcTNUBW6cM4jRKd1CFPa6rLc/
 dYO/lHsC56uE8d1uvVANbDi6ePdgqqCVx3PIm00g6m5FuS/VWS2VuG3lsJRHr7xhktNz
 2eXnll9oJMfJiY7G4H+ouiJifLpL3fJZoa9s1z2H3mTx3544QWTe2KM+jacSOeY2zHxG
 2X2gjiabwqZBaYHBX/JgeMEhZtixxaxLy92erAGlcisxeygjc6lLlVuY4tydCN3N1jJ1
 zOxGf1acz7pUSfEK7BmV09loZIaPR0+p7RLWQcZq/BfOCuuzOg9rIP+0C7ptsZTcViHO
 qyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158077; x=1752762877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5rs7lHMhxOASbiE0qenBSx5/4r48hTt89mrqp1gYxE=;
 b=klIqpm5VjEscUQdq+mGfLcUvU9C6+M0Pit0zvovDHdGguI8TMfGZnMllkvaBKy+7Cx
 lE35xlAIUFiRkKgPohIftLAdpLVQS/lSYaVc4z5vlTwXGUOdCQ1G3sKwTDzXaJiEQI/w
 LCb0Wz3o0B6dcZFqFUE/MRoDzN794dxW06SNpa7AGUv5+BnasRVzDgJFDkXMxUd1uQmV
 RVk6axwlfWiN+6RvziOJvg6ReaG+I3yeH7YvYgEk5xBMCLGGmnrbI8sxGrzyO6+0Y309
 6nebKzCgFwPiW1x7WMnrizpi6DX+1RITRaU8lV+nQROW9oNfjJS/F8KrFqHhgOAF3zOS
 stIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgPmd6I6X5AJLz8/vYdGjA+VYCbyx/K8jJ0xlKrsveOo7B0luUZurM07Pb50PM6bMqVYZtOjA=@lists.denx.de
X-Gm-Message-State: AOJu0YxB2+SB7hOWKiEKgFm7VVyu9e85PK8o7YilRWpYE15h/hZwyz6l
 9YMRsjIPR1wnYulV59iimQpQhJqsqGgaxzcOi5rcIvRGQx2fhqb1FDbIF7K1iTpJdbS7naGZ3xm
 y/qTycf3In/J/oUbmEjSM6rmlWlZnOEs=
X-Gm-Gg: ASbGncvoQdRdA0S+5mJLKSvqDGl0IpJKm2v7uVSGAK0Q47WLVT8olI1lr15dx7THeKj
 ZT0awcRbFJ4uqyUHcPZEsxGVq4GMkhFnww0YqWeloAu2GVPQ4wXf8SfUvv6q8fenhBk5ncV6O1m
 S1c8Vlsf1rRIuM9/bpC0xF/jqSBmFu1sJxSTfZASWq4DGBSZWZVq27u2SwLUu43y+1ICGgac5iH
 uA=
X-Google-Smtp-Source: AGHT+IE/UEslYVTRMVFUbKXHncw7eEFXiclrXkDaBVjC3hWs7EihoXCImWg4laSM8FK0MGWoM1xR8tW2nyu/ubrQLVo=
X-Received: by 2002:a05:6512:158d:b0:549:5866:6489 with SMTP id
 2adb3069b0e04-55935b34bf0mr1054350e87.47.1752158076348; Thu, 10 Jul 2025
 07:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
In-Reply-To: <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Jul 2025 11:34:25 -0300
X-Gm-Features: Ac12FXyzzCxEIfNHqRpA-5lEwfJr1RwF_yONfPMzUkyeiF_MwU-TxFSjaKhbY2c
Message-ID: <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sughosh.ganu@linaro.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Prasad Kummari <prasad.kummari@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Thu, Jul 10, 2025 at 11:28=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:

> Thanks I'll try to reproduce it later today and let you know. Do you
> know if we build this defonconfig in the CI?

Yes, mx6sabresd_defconfig is built in CI, but no CI error was seen.

Thanks
