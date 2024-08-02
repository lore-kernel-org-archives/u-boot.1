Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BC6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFE188C04;
	Fri,  2 Aug 2024 21:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mkNmDjMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B6C88C11; Fri,  2 Aug 2024 21:26:13 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D429388BBB
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2eea0cbc96bso7040641fa.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722626771; x=1723231571; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2yRhDuxNNpFdMOtgFXyLmIK8LtBBefa3U7TS8ZSuEs=;
 b=mkNmDjMN2qJj//DJKd52LOCGykRAq/Di9ISnvnfZm/RIyoO6epH5BtTw2QJzeQPZoA
 gTapzkKftvZkWy0IomYaa+3vI3jq9OIMEzva5Dz5W4kwFRMCBE0a+acUqu/NJdKqDLp3
 tvlXXI7fIHar+eK00CC+UGUoCr5nVx7msgUpxTOHVBQa6VmvXn1CyMtCPOxnlmIe7Afk
 XVZeZme8R1CN5QH1Q9LJv/0BM6o1f6yZ61Fe14wXVeb/tQ+AGh/iPfSRS8cMPT6b3WS8
 fNwEqfnJG63fAOF/lAc9HviMreFI/AeSpTjJcG/n6F21Puk1qKIgA3AVnIZOKmDWPsW8
 vQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722626771; x=1723231571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2yRhDuxNNpFdMOtgFXyLmIK8LtBBefa3U7TS8ZSuEs=;
 b=m/6f6bA/ikKFqmXzwEgGBhnQ6OFtYFtsKBJx6iR1hpKAIK9phFlOOZInzHjzJEiMzd
 Kxe2cI8zN59OulegyM9ptCCL3FphPPkLmQCk0XWxqSVRLcsXTlIr7iblU7MAHT6SnaeL
 o6AamEHWJuqbJDzL4Nzd2VGFshBAm0QOmqb1a8EtyJrJ44inkQUSvWynAINwS09EALYd
 graTqwipcfCjwhKK1QT4lSmWuZIDfYI5omVp5pcqUv8jahyzB0eQcOYHC+imibZ7qUsf
 qxIyh8YbTMNQKwg9dHmdJeA1yAcznfQFYHc5Laz7iQDvYUY34mfeX8S+qXxVFHH0C3oL
 D7jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ3bOdCdet97rrMeAiqJTv1TM2beBWSOO2DP3+k/yIEtsWsyRRevOqJ7B6zle847Eov8dcDEQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl+yG2Ulw8iHGovjrxSnLJfaC/+SGn5exgsRdjjyd2IMbUeOei
 m/tHfPAwWSumW2BCQyRYCYE7b8tzJhw6TYcFcUCIK2cZEJYJIIGxsrnC5OwQc8IYjRu1/akjrKA
 rR2F5BTUbnwEwnfAiRQX9XaZfuqc=
X-Google-Smtp-Source: AGHT+IFkOglwQZ8bm6xZNJzfqm4iJ02kyhibuvcuQw3J+15Bu8s12hyocMOjugqL1e7qhxzwbPFsPg6t8r1hut9M3dE=
X-Received: by 2002:a05:6512:3e0f:b0:52f:c142:6530 with SMTP id
 2adb3069b0e04-530bb39b3famr1756747e87.6.1722626770955; Fri, 02 Aug 2024
 12:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240801144650.1635599-1-lukma@denx.de>
In-Reply-To: <20240801144650.1635599-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Aug 2024 16:25:59 -0300
Message-ID: <CAOMZO5CgH+NQ0e66nvgtAr_UbdiWm1Tc+8FDuBJGLsx6=xejtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] config: Adjust Phytec imx8mm module config to
 support NVME disk
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Cem Tenruh <c.tenruh@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>
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

On Thu, Aug 1, 2024 at 11:47=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> This change adds support for PCIe connected nvme disk - phyBOARD-Polis
> base board.
>
> One needs to call following commands in u-boot:
> > pci enum
> > nvme scan
> > nvme info
>
> And then ones to access proper file system (like fat[ls|load|write],
> ext4[ls|load|write]).
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Remove not needed adjustment for CONFIG_CYCLIC_MAX_CPU_TIME_US=3D1000

Applied only this one, thanks.
