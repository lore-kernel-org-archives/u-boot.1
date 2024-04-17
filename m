Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E5CC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 17:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E7F88343;
	Wed, 17 Apr 2024 19:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yaso7guU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007928817B; Wed, 17 Apr 2024 19:09:57 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A17E88343
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 19:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a532498cc5so3582a91.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713373792; x=1713978592; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BthdC0L0d3e+alyoTYHfttwl83zBq4KCdqoBbvhcBAI=;
 b=Yaso7guU1O2sp8h2Cgn47k62vHlznH+vJxLJCvUzK3i2opCXpRAihR6z561RZEjQLG
 0R/Jynq0zTLvVXJNhtLI4b4HtkmrMT8rtneWvCe3J2d2W+JmnEwGHGuAv1TK1fg6S0oU
 sTPl+i9TlKO45K6f7Ze9QzbG1y+NE/bMFfabzzNMaC9OidZMj7dKonRGz31epVfNfTU7
 E7Vu46fB9vV25k3ExWwwrbKXZ6im5XAKWia0Qqcnru3Oe399dVXMKbw4zWXzY18Hd1ZN
 bcQj4cpPAOlp+xKneB8GwRhaCJoNZvHuh0o9cNbZWsriv5NOWdEemd1dYmfkSsEh9sIV
 CJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713373792; x=1713978592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BthdC0L0d3e+alyoTYHfttwl83zBq4KCdqoBbvhcBAI=;
 b=pFId4b93Znilc1iTP+f/p0k6S7xlEFvLQ4Os22MHixygT9hlzc7miju8Vx5h7aESM9
 L8aZKY8cm9wbvl9Oo5zEznfzKIiUMxCWYxpf7srtu2Www6u2KKB2KJAKsTV+iTv3K5dC
 N502Oy44+1SkS69EmMsuNWioWwhl2lVR9+uwShKyo+u++AV0fyrmVl4YeosQSt1fjl6b
 fXeWJhJk8SsMHG1gnNCqZeRSWQ+Q/q0e/E6T8uc8Ymrlsa3GWFG5FuSA+DhsxAzePnJ+
 eaNqMsJu84LpgfxBsxq34ISjboq6y+KI8fTzwoUI0YKaM09IHQ1UxqtQxRaffqza5kbd
 oREQ==
X-Gm-Message-State: AOJu0YwAH9DyWx7Ekqr5mwEYTQVQ1xSGwAm4Zfy0fI9HSLrDwY43eNoj
 tNEhhwm8LE2/tlAAsp2CL1veMdltT3HQPZ3e8AhiJ9Xqufb8oyMP8D1OvuB8Zr57JJpgH/ARgeR
 s24RZjM7Pq9GRaagYFpdHOz//Fwk=
X-Google-Smtp-Source: AGHT+IFOiAAcgKgU4EAmduFWglpAZUXu9rEKJM1qixOMui9SrhGSWct/1LnC3gzjwnPqUGm35L+y7HIlxloX5yUDxXY=
X-Received: by 2002:a17:90b:d91:b0:2a5:3f1f:a1d1 with SMTP id
 bg17-20020a17090b0d9100b002a53f1fa1d1mr31942pjb.0.1713373791902; Wed, 17 Apr
 2024 10:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240325162739.1350665-1-tharvey@gateworks.com>
 <CAJ+vNU3QHCV=69yau+v0yYK5i_dvTydGvzMyne=nbBveq8VveQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3QHCV=69yau+v0yYK5i_dvTydGvzMyne=nbBveq8VveQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Apr 2024 14:09:39 -0300
Message-ID: <CAOMZO5D6BQRBreJPqJymjjKJxJs5FKgBWAGpnmTayHyvQyz_MA@mail.gmail.com>
Subject: Re: [PATCH] imx8m*-venice: enable TPM support
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

Hi Tim,

On Wed, Apr 17, 2024 at 2:00=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Fabio,
>
> This one got tagged as 'changes requested' in patchwork but I'm not
> clear why. Are there any issues with this?

Sorry, this was a mistake. I will apply it in the next batch of patches.
