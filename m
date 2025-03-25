Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F6DC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 11:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB3C180EEF;
	Tue, 25 Mar 2025 12:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="itQtFQCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255DC810E8; Tue, 25 Mar 2025 12:36:33 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE73808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 12:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30c461a45f8so54723421fa.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742902590; x=1743507390; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aknk1IW/4l5gM9vwdmNxW+3sP6/X/LZAau4cQVnxCt4=;
 b=itQtFQCdTGd2DtvwOaRM57cnSwoJZJwCjKA9tCVsJokyQqDnkyzvbC8EN3eW0Tz3tZ
 rzs3BStvhlDFZTIOKJyZWfguxjIY8Xa/TXZ5lXKFY3V3+1e06YmHwIFEWbA11Z/u6d6J
 tvQyxC9oYpM7UONlski8hEuh9JtzEvsjzLLaV7LBchKwk0soEopOxIs1wpA13DvdGCEe
 VVf80Gfcj55d4Ew+4bOHL6cHiopobOdwmpbrJD7h3BtEoGZmJVhVGlP9X3jXWT5IKvDw
 pwX3tWZJrymOO2a0ShZLC2LVeA/uUHIKG75zx3+V5NMOIqqv97JhSnZ0A3PNK/yyAKxA
 hdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742902590; x=1743507390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aknk1IW/4l5gM9vwdmNxW+3sP6/X/LZAau4cQVnxCt4=;
 b=kw70g/Z2XOMKo9xbJ5zY2njeTIjNoBNQudPAxlrFrTilGUOyVfP/jM/G+iMY6JdJu9
 AwpIR0zlooJYkArIQefXGLPnqiV2q2h4pNU7R/ONgl8Vrm9lEOTVC8QE74jJGAxDVBUZ
 L+WgarsgCtWyAEfECY1onhnBQrTnsHMMMwmrJYADWIxFaCrrppt0NCXIzlFoWAza+YKq
 K0u/P0f8pD/Far3A91CxOibCYbDYjWmUEmlJ56WE4x2H/frYbj/QaazYnEuoGORNmkZB
 DQfSMhGNah5sZSUda9ySCGdEpYdCaDxqEzrbY/FfGz5U0UZwerhFzfVXEOwrCmMqbOfI
 q//w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEgDyTIY9Dz3gxmIQKylXCrT1nCPU84fytqmcOPimoycFs8EllFo42QYKhiB73T46qb5YEQ8U=@lists.denx.de
X-Gm-Message-State: AOJu0YzHEi5n6aFzjCze8HwPPW6CCBjh1g95YVKuxAcSuQgf/ZP8fEBt
 LRzOYVh566OmytktY8aZWzuHZbhe5evWtgZvDDaiQcGIRglvvfZeaW/eV7p+19gRN1p6jHWFIYt
 Qsng/EJsGlaUFh5E29eGibns1xOQ=
X-Gm-Gg: ASbGnctBeZXnPooS41z8S0j7FZFDPIN6elIZIcgLlEP/3uRJxoVcb86n85AADXgBdZr
 zQO6H7+kPSeQHisuvVD9GYBc8ygTYJpbvKO5pTFZnVcjtX2lhk8EI/8N9NCL5iK+8gVDxD70MrY
 Wt9G0svndjjgzn/3o8NG2v+kj4kz4viYqYVDMSb3SnjOVm10ABTY95TVRSJEVAm3aoPFw=
X-Google-Smtp-Source: AGHT+IFe+WjqtKtiWYOVqxJ3UBVS6s0n5CuJhmUowTW53kx/rOsl+dexH9V5RmwSoJHIgVmHshpdNb6Zdfo3yZI7sFE=
X-Received: by 2002:a2e:be1d:0:b0:30d:62c1:3c0a with SMTP id
 38308e7fff4ca-30d7e2aa82cmr69093801fa.25.1742902590034; Tue, 25 Mar 2025
 04:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250325025452.950303-1-aford173@gmail.com>
 <20250325025452.950303-5-aford173@gmail.com>
 <6f58a557-d5b4-4bc7-87b0-6ed626ec534a@mailbox.org>
In-Reply-To: <6f58a557-d5b4-4bc7-87b0-6ed626ec534a@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Mar 2025 08:36:18 -0300
X-Gm-Features: AQ5f1Jo1KX6j7WIm57L6F1mKmhUG6s0RLuJKfvzbgDXO1krgLQsydWQUab8b2ew
Message-ID: <CAOMZO5CT0uevQaPWPAHM0qVULy+f6rsbwE72Kkph48ghpOSKkQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] cpu: imx8_cpu: Print Speed grade if IMX_TMU.
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de,
 aford@beaconembedded.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, 
 Enrico Leto <enrico.leto@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Gilles Talis <gilles.talis@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Tue, Mar 25, 2025 at 12:37=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.o=
rg> wrote:

> Please drop the fullstop at the end of Subject and then add
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> To the whole series.

Adam, no need to resend. I will take care of it, thanks.
