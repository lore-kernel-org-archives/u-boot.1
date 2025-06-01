Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B4EC5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 13:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40FB082A0A;
	Sun,  1 Jun 2025 15:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gY4CtpkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396A982A36; Sun,  1 Jun 2025 15:33:08 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02714829E4
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54e7967cf67so4251899e87.0
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748784785; x=1749389585; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0FJMbs4rbZiTotxXr05PZ+P/BGYTz1i4dXu+afmTIY=;
 b=gY4CtpkHPZ4qqC1YcjAOhE4ecW8xwFbOwHxWsvOIG0LJJAndlvNQydknQpHd6jUwBJ
 8+CCMPreksTvWVMxl5QKhRALXmy3qjP2hPhA+DlofvbkqbQI3VN0ENOja/lrapyvoPvi
 oz0/alS0S0z3qT+Yx9UwyIwQ48hJmntwy9QZQyUblF1VazIQYreOqSpdsbiRdGNdYSlJ
 E/AMgXzAEAcu5BUyGHg4W7dnA2oBAysln97+fy0ucQvqTJAUtg8szbzYOQRjl2iMLWGJ
 O5KqbKjpQwWacPrPHIwjcxU4Cm0K2S9CSmqlV0m/79riBsYS+q9A9p89XH8jIx8ibuGY
 PdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748784785; x=1749389585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0FJMbs4rbZiTotxXr05PZ+P/BGYTz1i4dXu+afmTIY=;
 b=knvSvAbqdFYPW6iiwQelZ0IcsHcvE/bkdwYzExrxMZpUDrix7dCelX53zuCX6sVpZf
 EzfIlU7eXFpxDGSiGpiDlqGX703tK/En+Ga78slRifXPDHAEXu4a0BsES+xjEohZXcVr
 /bz2CGnPJx0UVrVn+ZvrlPQnu2m0vZB33umlkI8ox5aGf1JMAczK1MQjTmjOfYxj8l+l
 is6cbQ9iKGn9yLg5x+hJ71lf/DsC1S4HnsSEpMrqaQqdlJC6pRTer8Lv//Pa9/8w4SCA
 ayiZSebTvH0rONHtT3sdsT+f0SeHKmc6Ru0e5xz+rgHmUDVnwY5Z/fmyMLyChGkuRv6w
 SgYQ==
X-Gm-Message-State: AOJu0Yz9Z4jtDIBkghqicTVfFoJJT3DpC+HX0J0v6sAQxz2VmfsHxz5e
 2Mdwo93ofRA65RswwdLcyt1byGMIJsI+GAgX/SJZ1RYTuZz23cpOEqESmpoomWOW6Q50d4A4rWt
 +2FGi9++eFJu2grZkNJMq4apmSuhH0o4=
X-Gm-Gg: ASbGnctuxOkBZlmiAecSehnRr1aD0UsGn43L71sLCAtG7UM+w6aebFht3MG7VBDglCz
 UpvPGLPU33Gz+cGA+/E0WJIolaK2tb2reHBlIJJ8ig77LS/T2v5455XAyOtqdbe0KKhFyp5m7tA
 mi1uHdoGrdCA/3519XI8WWg7TUE//V6xuZyR5RG+dghqYbC2NJ6JQhYVoz3KkBVDtu
X-Google-Smtp-Source: AGHT+IGriMWNKg0GME39S2zxu1fWgg4RbH6WBfdEdOycXYsCQlm3RCKDYeDiycFf8b1PwkgmM/z/k3jwX4GvbDXRslw=
X-Received: by 2002:a05:6512:3e14:b0:553:37a7:b217 with SMTP id
 2adb3069b0e04-55342f93170mr1328753e87.35.1748784785123; Sun, 01 Jun 2025
 06:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250531145441.908910-1-michael@amarulasolutions.com>
In-Reply-To: <20250531145441.908910-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 1 Jun 2025 10:32:53 -0300
X-Gm-Features: AX0GCFtFQiuRFoIJQI11MBCBfXkK_LlpJitxXz_yWoBHOs4mAoXjHs1MRyOEFw8
Message-ID: <CAOMZO5AiNaARQAwvb3o+QcakgDo5zuQMzbF-g+r93CgY1ioJKA@mail.gmail.com>
Subject: Re: [PATCH v3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2B board
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon.Holesch@bshg.com, 
 linux-amarula@amarulasolutions.com, dario.binacchi@amarulasolutions.com, 
 Sven.Dembianny@bshg.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Michael Bode <michael.bode@bshg.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
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

On Sat, May 31, 2025 at 11:54=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Introduce the BSH SystemMaster (SMM) M2B board. Notably, the M2B is
> designed to leverage the existing device tree of its predecessor, the M2.
> The primary distinction arises from memory incompatibilities with the M2.
> To address this, we've implemented a configuration system that allows for
> selective inclusion of the desired memory components.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> ---
>
> Changes in v3:
> - Fix typo in MAINTAINERS
> - Pipeline https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D1=
1274&view=3Dresults

Applied to u-boot-imx/next, thanks.
