Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1677C2D0CD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 19:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A8D8081A;
	Sat, 17 May 2025 21:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LEraKhJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012F1808AF; Sat, 17 May 2025 21:56:26 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52E38004F
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-551ed672d6cso177432e87.0
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747511783; x=1748116583; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPH2kjvlS1/LQXaD2hAlAM4PFJ1NJzAuHOz2MS9DxTc=;
 b=LEraKhJ+bXv49aljijHXv0AIhE7zvp3CFT8XLHTOjTfmPMmP0vRPQiI+RzJFh2eAbD
 0N9JuNeJVffCt12W26O3HmO4hJZjuBW8vak2IS47pvQrHO2wMn+Ky31Po4FCAb7dYLnI
 Kc4YHOgP0uPiPXGJ5kuSmqCom0WziVXq/q81rgb0lvObTHOAx7nGGrzoBDy+xY+x0Syo
 ic1Mk63nnbOcFHL9V7twWsYwPCS+3WsoraAseiocrnWtHMyNiz7ok0nKXlxtmiLxpZ3n
 XpefCVk+PemNpQbl/KcWNdSfQjDC4ns88ot8bUqXoGtPpKvqbDuOA90B874dTBrngihw
 J84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747511783; x=1748116583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPH2kjvlS1/LQXaD2hAlAM4PFJ1NJzAuHOz2MS9DxTc=;
 b=GKFtDKqzY9qJ2MJaAN9xt0w2m9ls+ixagOGDjvqO8a5LpFAM2nHDVqV1cKv/MCS/qA
 rYSeGiaumMa2De03zunhlc3ZdtlU3ADaLefchjFz6M9nojz7g3Lr+30GZANJ4Wht8xeY
 GLfaN/IeQaoSlEWg0ZmkjYBnYIVAWjRFUK7mQyv4ATRg9sno9miiFWQdyKynXHTmL6VU
 efY5vsrO9GQr1sjoCW7xCQJZIFRy/fVoiVi+eGLv1KI06qHJVQdbU+SQ3FV+NsfJarT2
 euGEr+Z21DNVs+kUySMLYNFqo4HSOmZrGpoKFhN4G4zvTFX9fgW1Nkw3nbeLpnvLkUxX
 mNJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHZuLsOOuVO8mmPFRZtmx17xYMlYYFUjIUe4wuBsZ6fvGHbG7L9EORKjX3yCDpFo6zrDQBiqY=@lists.denx.de
X-Gm-Message-State: AOJu0YxzdzM1iuJkQfYq151yyeDwkDCKygDvY/4OBEdVFT76yZJPlWk1
 q3Ixq3eXy2Bf9QSgeiMZAoohVulIw7fjwSqihPqPDONR+N0oOasTMhsY8bFc3Cmnd06UucajB9+
 bnMbrWGZZHF/25dCQj6ULDMddbFywa0U=
X-Gm-Gg: ASbGncv/fJ0n2isizjJU2IQenkwsBTkeYqZeMWrbehXmP82APU/yL0I2lfpBM8GzxCV
 D/OudHo/ybP7nsXkxNdfADhLXiFbQw4eun70bBIABa0JBKA3jQOy54HOOnWghjBj4aQUq+Zosny
 +nqa/x8bw1QoXpe1y+gLfqwcPV9wrdeKPTIvDnsLszG711/kl0ha0kDanf+Jo+Ziw=
X-Google-Smtp-Source: AGHT+IGnZRiOpX7maPMyszUPPLlnyr/sOLs0GllF76BJQqvK1ss9WaHZ+Y5NQsnW21ygLUbbxtN5aFgRI5R2e4OsHCs=
X-Received: by 2002:a05:6512:104d:b0:54f:c1cd:c63d with SMTP id
 2adb3069b0e04-550e995cd75mr2036880e87.54.1747511782618; Sat, 17 May 2025
 12:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
 <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
In-Reply-To: <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 May 2025 16:56:11 -0300
X-Gm-Features: AX0GCFv9tnSe3UiRf6ZASpkN-D9sFSwcVWR813_5jXrVR6W-k63cTJk91yOen8c
Message-ID: <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
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

Hi Michael,

On Thu, May 15, 2025 at 5:12=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> The serial is not up at that time so we need to buffer the error and prin=
t later. Right now
> we are working on other fixes

Please share more details about the boot problem on the imx8mn_bsh_smm_s2 b=
oard.

Does a hang occur at SPL? Do you get anything in the console?

The mx8mn_bsh_smm_s2 board uses UART4 as the console.

The other i.MX8MN boards where we tested this patch used UART2.

UART4 does not have U-Boot/Linux permission by default.

TF-A enables the other UART port permission access at:
https://github.com/ARM-software/arm-trusted-firmware/blob/v2.12/plat/imx/im=
x8m/imx8mn/imx8mn_bl31_setup.c#L124-L143

Is the UART clock access falling in your case?

Is clk_enable_bulk() the one that fails?
