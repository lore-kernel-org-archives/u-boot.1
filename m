Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9450EC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 21:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DF787D5D;
	Thu,  8 Feb 2024 22:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4DQqMsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A9787E34; Thu,  8 Feb 2024 22:30:14 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B629887CCF
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 22:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-290c5c705d5so56233a91.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 13:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707427810; x=1708032610; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKrW+ob48HwDxEOhsSYIIKND7RQYoTHFO7LuowC71Zc=;
 b=W4DQqMsMIfZpfuaFqpXVg+86h7/od5hVVeszeYrJf0KFEE3kv4M0rARFd9DG0W/6Se
 DyC+im2wd2OdL6tg2Huvc4U3O7BoD+Z2p9NirsL1KgQVggIzvJEQMFSQsRlKy0Xo7OBU
 woa56hNL3Uf7PuwojA7HuB5tJtfxo4mu7FSNK4X7xccDwe7ac7zAPEqiZDFVq0STzCZv
 7yix72V6IYINzugFwoVQrjcNE6NvlZgenVToKWLOpiDLL22eryc0VxUdLq+LL1XqBaA3
 qx9U9/P71veydNdLOq4a9pe/gVtynAgqqt+b+jXnlnyWzakB45xKW/tCJaWQc2S8XqPA
 mP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427810; x=1708032610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKrW+ob48HwDxEOhsSYIIKND7RQYoTHFO7LuowC71Zc=;
 b=b/STAetrAArRGqtzrCT7uv4PpG1ecAPDLaCPYKA20gaAwuwRBYFpj01z/AZUuSuErV
 g7DXWbER7hzjIP4lk6lnn+Rat0J+tdtLfsFWaH1wMz0pP+a3h6y4CRh+UmIrS8WotdC5
 L6zdDSuX469NB0UcBWldhlfRSpzQ8AnEuinyapIQks+EtT47Qw5XsaM35bSjlZ9BPkwp
 ZQrLWuGCi91RHB3jlNoyCBjtxR7x3VHpf2znpLZahnKE+oc6eGHq2egjs4gh832sgJE2
 uZRsKpdxVgoLIm7u/6N2WLa0cuZ+3cN1SSKB35o7WEXQNwY6oerMXCq6v1ht19Dw84S4
 aVyw==
X-Gm-Message-State: AOJu0YxckFfrDjYiAv2SxrAFT/H7YJSemrDRGK1m6wZ8kL2XJSRlxQvx
 Rxytwmkre940tYPo6wIM1ZX/09oU57ZYmQrKCwT0tzetwLvghnvP+nA6fX8CGB7koU7EUKtBVZ3
 UKOTYlJuUFuDIfLAz1xsRO+QQ8f0=
X-Google-Smtp-Source: AGHT+IEqrK19HOVKoHmt5Tu4Xpj5uuozwI/D0Ev2IFUzNaHp7lC4eRsoHZeXpbYlv/E9mnFVA3aZCEyOV/659lOfnbQ=
X-Received: by 2002:a17:90a:6e06:b0:296:9c2a:e7da with SMTP id
 b6-20020a17090a6e0600b002969c2ae7damr503610pjk.2.1707427810103; Thu, 08 Feb
 2024 13:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20240208173314.397582-1-marex@denx.de>
In-Reply-To: <20240208173314.397582-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 18:29:58 -0300
Message-ID: <CAOMZO5Ch27KJDxX_qU-HnsP47jU3d_d-gefE6Q9oWZpdmvhuZA@mail.gmail.com>
Subject: Re: [PATCH] spi: mxc_spi: Add imx6ul-ecspi compatible string
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@denx.de>
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

Hi Marek,

On Thu, Feb 8, 2024 at 2:33=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Recent i.MX8MP DTs use new fsl,imx6ul-ecspi compatible string instead

Please specify the Linux version in which this happened.

> of the fsl,imx51-ecspi compatible string. Add the new compatible string
> to fix ECSPI operation on i.MX8MP.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

I assume this goes via Jagan's spi tree.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
