Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10409C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 01:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065D682CBC;
	Fri, 20 Jun 2025 03:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PkOg6Iql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E83482CDF; Fri, 20 Jun 2025 03:02:07 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA90D82C55
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 03:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54e98f73850so1159909e87.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750381324; x=1750986124; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjKOb+blTNS8URU2UdyKp+brES/Cc8iOc96+GeAuGpA=;
 b=PkOg6IqlAMHfIPAQLzhbpO9+t0scY+EVvP3CFqpW+kpLm32Yf97OBFLRfZOLJDiKkR
 2ecXqHKfMNsHD0h7aovZXzS79MKrWLPSiHxLQRONvztcUFFIl9NLv2Nmf6OgXUoQ7oRn
 6dlG7XWRlHlcRXMvN223DfWZ4MyReA6teMKHQteNG8A7yitwfRmLTQfG+hcap5A8DEUm
 wq4huM/Y7MhQjLovbNQ37IrSRdo/doWaE/1woPi1nIj0eveZoBAW3Nx+lOAOAPaJbK0N
 EC2Ic4NSjE7nymkPrZgU52CPnDX2rOmXIF/53uHJ9tVxXOJ56A80ObYGBKwe8n8SxlhQ
 9keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750381324; x=1750986124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjKOb+blTNS8URU2UdyKp+brES/Cc8iOc96+GeAuGpA=;
 b=KGvB6gg6qErhgTClKU48zBYhrK8VnxkBy0erxbQxE0dbZlO6iLdziDtNXsuvDWngmn
 17SuC/K8UTaazaI2/JBpAIeAI+nqwHsoao+e5lFd/ijP6zCQChYbC4NwG3O2togN+DqE
 wq9yj8DSBozGTWEY2JHLHncaH/lVQHJvwy5oKuv6KmksGK/oa2Lo3LwZQlb9Qqi/lber
 skZHCq4LeForS6tGXOCQGbcdCNA0WgBl2GXIlNfwxCm30umKS2iPU00MRHTrzHY52ZA3
 b1pqH+iMju7XIUGJ+Zm4wOTKaEEoTBTCnW3SA6w6XKcdQ+KB2H1DTwQY2ZQ/sbAmLNHu
 Yn7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxaA1dqJKN5sUZLdqFlhYuH+4NqqMP6DBIBf578Nw1mdWdFVphLOPu2vZUie/GM2dpUZS1sBU=@lists.denx.de
X-Gm-Message-State: AOJu0YxWe7LeQch9DWYI5QwAFT+T6dBlICIwMHvAswtvPjZTjXi/RefI
 uTN5gucg8bz8Kup61D47tDsMsvjGAaRCdDqVfmq+lB8hz/b5gndWj44ofhCnNd8eLoa8hNa1OG3
 s+79RxD6BDvOamFuVMhHzcgkNIQ/MXt0=
X-Gm-Gg: ASbGncvZijvFbHmcZzgY4qScjL2PrAoB5pGPqDoEmlJX2gqrtvhZNe5E1iU1U6xvOSF
 zugnSygZ6Ku23+parARn1ch0pTBB6e89SyG35/+8f1By8ffyG6c5hbj/dKD9BuqOi8ilMYSF44E
 RRdxuwshgbk8m68uAeqY2sFrSjEut3dCKFT1/7+1C+Rxm0eCESkVewF/D+eDyF6x7F/25saIWJj
 bQ=
X-Google-Smtp-Source: AGHT+IGJD12IXVaWZR62iczYsEGGdiUL9Qnnn0KXIM2qOMxyZUHE1CiKT3wBcSFFn+mkggC6RX1RUAcoNLMAtWaJcaQ=
X-Received: by 2002:a05:6512:318e:b0:553:3770:c907 with SMTP id
 2adb3069b0e04-553e3b9adf2mr274112e87.10.1750381323565; Thu, 19 Jun 2025
 18:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 Jun 2025 22:01:52 -0300
X-Gm-Features: AX0GCFs1SGXM6JuM6uHzS6c1H9eMMARI8Ky6E12-vvzZZynh1m_at6B0d1o9MqU
Message-ID: <CAOMZO5CpcBTKQW4O6qFH4TgvsBBzmud1MQOEtz1i0V3UApz-sQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] (no cover subject)
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>,
 Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
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

On Wed, Jun 18, 2025 at 4:30=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> imx: update the building bootloader image related part for
> i.MX8QXP, i.MX8QM and i.MX95 B0.

This way it is written above it looks like a cleanup, but if I
understand correctly, there was a bug report from Enric, so should
this entire series target master as a bug fix?

Francesco brought a good point: are other imx8qxp/qm boards affected?
Could you make the fix to all boards?
