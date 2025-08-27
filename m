Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F702CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 19:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7096D831B4;
	Wed, 27 Aug 2025 21:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEcbuxgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE00B831BB; Wed, 27 Aug 2025 21:13:44 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9AED83106
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 21:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-55f3533fd05so221726e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756322022; x=1756926822; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCOPE8/4+2oRdmAtmUPNcEq1G/ntyiLj4HICRnu0L9Q=;
 b=mEcbuxgym9R8X72CMB1iDp//7R5C4pwPLZh/VDrmosLnlGPnlKObA1W+E5kq1ACT+j
 HGyglYfqM1bcUk5Hi5A2ftHT1Xs+JC81d9sTA5tW6diD2vX3DFz8uvhEpQ/UHrJ5Ivcp
 iV/91K7VrFgO/aLLwDocpD57BjRiTSI+azV5N7nFHfw6Go1S6i6xmcAvgjPTjPcwq6XH
 va3DaBLnefgD7sOE7dneRocjqI3xmy0srmGVF9Rj2P10syCovBS4XuLMX/n6I+UIyB3Y
 kknTIGF0J0jjZqMBK+oMLu3Cfs/RKB3Q43fY/d7QqX3UhGvMSMza9S+gHpZUo5vIDDjZ
 kVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756322022; x=1756926822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCOPE8/4+2oRdmAtmUPNcEq1G/ntyiLj4HICRnu0L9Q=;
 b=FEcGu19Nnd8MdlchzPSVMP75C19mKhlfk9lj0pciURC6thnzIwCAlKW+f/DsomnEER
 jJg8NByWRTrmJTAuXyhB6+zP2PeAPKpoIHrjbUGeHMBtsngB0vVG6cfJPilTho7zCTib
 2JnyKSDP9cfzReM1mgng3ohGklztCxHZ10Bx1AJJF4yUonSwQ91MihdZp6ofP/daCz3r
 vEbHwT4OBPycBbuHsqC6dlQBwg5cyUHIGg7ObDi8IVvaMgm8d8MI6zVp/BU7ecdHGVzU
 UD+62Q7gG/xGUvfP98wkZo0RMf4/mLU5yFFMNBgkaCtpwdEbF41lV+0mBqstgf+J7ifm
 drPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjkrkUxiFyPHIVwoZCNX0Sh4B0lDUhr4O+sF0e8L5fng9W6zdGA205/S3kwRL+JoGZMgmm/dw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0v3YIv8dLUPbeFj79PJXSo8EYe2YFrFS32II81tJ3qP487tIX
 4TXDdYd/+jIjO9bslozgJ3Me3WiSza5iTLa9uRFP7cPNovAkQRSVg3fZnCCtDLRgQ3qGd5SD/cP
 vZ7E+zi0cWXEVg1atbe2798LwlyRflX4=
X-Gm-Gg: ASbGnctOGuw5JAFH7sygehD4e341lUCAIARkxICZsFpbywlTCy6pneNJe0n8RoLGpIB
 MYvS2Lu1iliC+VYVi4gGR0BnqWte8SGS/5MNL5qdbwhftsnCFRW66t3KQIs1ABI2Oaupnr4ZD1i
 8vA8n6WaiZ0CKFqmb98x4waa4nH/RkL7HuNiOsr+Plofkle3ogjN1OgTcm3LtCcJEGH5inBdhPN
 kI6VsIO62LxVDDge2p8KP227UD1yiyKxhyu1LI=
X-Google-Smtp-Source: AGHT+IE04e98icrH2tsjX/FYs5j4vWiOguj33yriR2vp/BA/cEJlUnKVyEtinUxazUTw7UlON8o1sXBMv9UO6eDKojI=
X-Received: by 2002:a05:6512:3d9e:b0:55f:43ab:b20d with SMTP id
 2adb3069b0e04-55f43abb648mr4259024e87.35.1756322021734; Wed, 27 Aug 2025
 12:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250827031156.109432-1-hal.feng@starfivetech.com>
In-Reply-To: <20250827031156.109432-1-hal.feng@starfivetech.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Aug 2025 16:13:30 -0300
X-Gm-Features: Ac12FXxMjgWge6AWe_yKGbahPyBtPMRrUedLReWj2c_kuG3g6FnF0Ruf_8VQsEA
Message-ID: <CAOMZO5C4bMcHWo576rFdJXtwXD_Ars7cQob_KS+3Xxof5-EMLg@mail.gmail.com>
Subject: Re: [PATCH v1] pcie: starfive: Fix the incorrect use of dev_err()
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

On Wed, Aug 27, 2025 at 11:26=E2=80=AFAM Hal Feng <hal.feng@starfivetech.co=
m> wrote:
>
> Use dev_info() instead of dev_err() when finishing the probe function.
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/pci/pcie_starfive_jh7110.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfi=
ve_jh7110.c
> index 51aca7359ff..f2256307ab3 100644
> --- a/drivers/pci/pcie_starfive_jh7110.c
> +++ b/drivers/pci/pcie_starfive_jh7110.c
> @@ -292,7 +292,7 @@ static int starfive_pcie_probe(struct udevice *dev)
>         if (ret)
>                 return ret;
>
> -       dev_err(dev, "Starfive PCIe bus probed.\n");
> +       dev_info(dev, "StarFive PCIe bus probed\n");

Or maybe remove this line.

We don't need drivers stating that they probed successfully.

Probe errors are helpful to print; probe success is not.
