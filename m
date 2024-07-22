Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69D0C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC4387D43;
	Mon, 22 Jul 2024 23:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EJ0lHhGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4755A87D43; Mon, 22 Jul 2024 23:03:58 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE6F884AC
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ef18ca13f2so4935851fa.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682231; x=1722287031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFCRCYSL9qNsv+rB1MP7Iig8d5et5TzULmWVnmNbD/Y=;
 b=EJ0lHhGuxm3RqOi0Psh5oIStRFo4J1EeTQTBdp7w4Vm2lG2Kx4Pmz6vMO5G7Pqdkpc
 g0xxRD2Q6Zkp2z7l/xSxa1JZh6XFDLCXU42ZF2DAfo7fytOtD4HK3JajDiOkoKS6zKVi
 Gnu6kvoR3j0PcR/nNnpL5e/l/rDd68+pgOxX9cDkIZPmtyEvKJEDmOXSIIa+1hOnd1NL
 XjkR6toIkzn7jOAiINPMS8JCD3wxEvNnZaP5zuxjBMUxV9DX6uSNBJPXs4Gf+qHnd2Hd
 5UR9yvgx7IjSJyCPxryOE6b5uK22aoYMSIb/rppTjVuz3vMuAeZna+FRdz001jYIFAzn
 JWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682231; x=1722287031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFCRCYSL9qNsv+rB1MP7Iig8d5et5TzULmWVnmNbD/Y=;
 b=wsMlPJsjEP4bD2zCIoAKtKUC/cSfOoc7S/z4iyrxCeVmtqG8KLXWhY3K+2DuGT64IX
 1tj7Fq3t5qwJTdBMNXP1aTlwFM+D3srDL4LrPdRnSKInBVHJVYP41yAGOcMGeBhFXcvZ
 ouyXTqXGbSGxenwNKljuq7Ahuy+u87T91HFURxiVNbxuLS7qiWYod62HSjk9rUI6zLHQ
 eXyyb/Z+JFAsfEBK+hod2zI9po6w6Z60miAaAvMDaS3Ih8R/fsJUlPShJx4nRT2K9dsd
 AAUh6bA9QTBViZcPwTvIVYo025gWemoOovFkgpYwY0EaumQP6jr9PD9H5zLgp2qfqkgr
 qtDQ==
X-Gm-Message-State: AOJu0YynNTMaIp3JymAMrVKbfGrhHrflmENPLMIls64RHjv4u3Y/gUgz
 8A+gKAOyxw8NHCjyVJutBVKF7BnqLN6ETYBlowlj3xX06PWSMXqDzrmm8ApJyaoPyuFIpV1UdDq
 3oRwcAcUkeSqHnWefI3Vlf5XXmbY=
X-Google-Smtp-Source: AGHT+IHktAPv/tMgEYQyU00tpMqjTX0NQ6uKAvGLyl3qCMTtnqRtmjZmNSmRcm4GF524Jd5uGVgd1fRQxVo/hz+clmE=
X-Received: by 2002:a05:6512:308a:b0:52f:c0dd:d168 with SMTP id
 2adb3069b0e04-52fc0ddd3a0mr1193905e87.7.1721682230301; Mon, 22 Jul 2024
 14:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240720124803.3505570-1-agust@denx.de>
In-Reply-To: <20240720124803.3505570-1-agust@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jul 2024 18:03:38 -0300
Message-ID: <CAOMZO5BUth8Lj5Uaa_03RV6Mw99vCJUMzGqsz-HcuykCZPzM=g@mail.gmail.com>
Subject: Re: [PATCH] nitrogen6x: convert to DM_I2C and DM_SERIAL
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Troy Kisky <troy.kisky@boundarydevices.com>
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

On Sat, Jul 20, 2024 at 9:50=E2=80=AFAM Anatolij Gustschin <agust@denx.de> =
wrote:
>
> Rework to remove use of legacy I2C API. Also switch
> to DM_SERIAL to avoid board removal warning.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>

Applied, thanks.
