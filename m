Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F307DC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7651A80703;
	Thu, 16 Jan 2025 15:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JCu1lpwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2B780708; Thu, 16 Jan 2025 15:41:29 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A788022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3002c324e7eso9170431fa.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737038487; x=1737643287; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVGVLnyvdVwjD0pdbGviaBmT+TfqIVYqhOo8iIwM8yY=;
 b=JCu1lpwCmPG4+TVPQfIq+JIVsUxtRbU4t1yfrTKYQO+OG1C7gbNyY+qcuLPnQnB1Qq
 MZDxl61qVQBqNBPhn2oJTaA+NFzMCBwnNVGHOoOBvyrg2zkeVLJ1JRDCRS7uonLFLxMA
 Rk/9AluKGQ3zSFyD2kM4B4YPAglzyq136/FGFpkPVZogQ+EApSUD6oXftrCsLCvMOXj6
 vF9BdTI5ttuuvnr6wrRw9YMXiCxSSEmZC8NkfM+MNeqTPprAf9U7LNjzVK+ff4DdhxzT
 Y4ybgXb5IXo7BhkGY3fO9coa9Dc2TexyOVjDmIVs6rCKNOrDvAObOGhTzPHH/UreRewH
 GG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737038487; x=1737643287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVGVLnyvdVwjD0pdbGviaBmT+TfqIVYqhOo8iIwM8yY=;
 b=rAvZxtLOyW/QEfNwGPxF/7X1jPyoiJ6tB4+wq6tJ7KlTKddKjcX0B7QVy5S3F3lpUC
 gTABoxx5xpWVgpbnY156GnqhgC/vbWU7YKc8ndx+agviBAN78UKUQMsSNl8U1DN8s0SF
 M7hh+DSuvaeXgqUvMNk+vnXHO+/UU8x2Qi5w1AzlI5BNLd68icEkx2fSBQrSuc9WCnOw
 JCJTZDgi8uFVdu2iT4EpSSpv6xdpv/CixztbzZF4BhSpneN1mkCSVst1+ap3jaqUgiY0
 BCLIoKxo0RWdjbMoZQn4Kg9tEBlBb7DlGQMWjiE8W6Q+unAHI7M3Z8Fz01pRjo5pnAU2
 F0zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV/b/xj2bD0mFg3uJw+8ggnImEzqh8YvIJELZx/+BHyE61uBcFGSVdAqwwFCPESgGwmZ/GkmM=@lists.denx.de
X-Gm-Message-State: AOJu0YyBj5rK/PlOiaXzspgU+E8NFlZo5YtZ0dEV0SUUXg2ymT8/W2Ux
 NlCAHxhYUzEpHcfNMXGdAWDbaAfOdAf2/A6X7kN+q9w6R7HdZsOGiNwz3bPlN73TPLj4LrMGSam
 5rKkA1C2TZDSPneehuFX5w4m/j5+o1g==
X-Gm-Gg: ASbGncue47dFx00zeLFw8yYPRVGkQUGPTwtSRs86hqk7ZNCh0JO21Fw3Y4eh/4aLsjS
 p3Acxs2/KLc/L2wY4gGjUj5qcuPq9Enilgp+8BbQJjhfdRkBtRxG1IagKS6h5vJme5d93Fg==
X-Google-Smtp-Source: AGHT+IGkqPOY2M820Yw7Ce0dau1czUlfdgw4HdoYPP29KahxHxuL2DwZgJ3JMdLJDJfoXASMafggDf5tItkWtEhPRXY=
X-Received: by 2002:a2e:bea8:0:b0:302:1b18:2c09 with SMTP id
 38308e7fff4ca-305f45ba080mr119028201fa.27.1737038486506; Thu, 16 Jan 2025
 06:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
In-Reply-To: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Jan 2025 11:41:14 -0300
X-Gm-Features: AbW1kvYsW8g9KYYxR2I73mBuMV4Enw2BpcliCntKisHS-k36ikJ5kfDh-qFETWE
Message-ID: <CAOMZO5Bser0d8o+73TR_wpsFgh5PWE7LURW5SGBseFAFWif9eg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] imx8(m): add optee node to binman FIT image
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Fri, Jan 10, 2025 at 9:35=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> There have been attempts to get op-tee node integrated upstream in the
> past [1][2]. The challenge is on how to handle the load and entry
> addresses where the op-tee image should be loaded to.
> Different SoC families and architectures have different RAM base
> addresses. Further the final addresses can vary from board to board
> (e.g. depending on populated RAM size).
> This approach follows the TI k3 kconfig solution.
> To be able to define a sensible default for the new config option, put
> it in the imx8m kconfig. For other imx families, the RAM start addresses
> are different and thus finding a common sensible default is not
> possible.
> I do not have a working Nano and quad board so I was not able to test the=
m.
>
> I included usage for PHYTEC boards for examples (with documentation).
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.39218=
91-1-tharvey@gateworks.com/
> [2] https://patchwork.ozlabs.org/project/uboot/patch/ZeHDVr-Bzm935-5N@mec=
ka.net/
>
> ---
> Changes in v3:
> - use OPTEE_LOAD_ADDR defaults as defined in upstream tf-a
> - add imx8mq (untested)
> - move common PHYTEC imx8mm optee build doc into include file

Applied the series, thanks.
