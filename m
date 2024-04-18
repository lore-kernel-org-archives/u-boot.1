Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661A5C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE324885E5;
	Thu, 18 Apr 2024 21:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W79nEbcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B388837D; Thu, 18 Apr 2024 21:06:16 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D2C886BA
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2aa0f3625aeso268765a91.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713467172; x=1714071972; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOUntGDUeWbxWjszAx9yfWVzgT65zLvkMZaSv/M1gc8=;
 b=W79nEbcge+dHO+oZS5VMqW757aQc07cCQkfhWddmg1jbnBtKIjbQ1DxF6nM+f+It9u
 ycbq0Qf9d6+Z1knUZiRbiyG/omUzjv5xj0RemOiBeGBGD4FoiaUc6dUwsWgNAEIGWivS
 T+pcg2gnpKfVpxqNRiK0GCgDcucxmtSp1cQMssYosQhZ8MkbsNUGgJ5MXK7zzeXMNAir
 H0qy7uHSEbStCuFR42niuERTX1LwJEUvg5+eRghPGF/92OHjZidi6qPrIeWxXxyBg9jj
 dbjJJJtlDJYQqHfCLsXHaIw5F8b3TUbkPee1Y6sxm6fNtUjYCCOhKfxQsPGFDWtXvCct
 yB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713467172; x=1714071972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOUntGDUeWbxWjszAx9yfWVzgT65zLvkMZaSv/M1gc8=;
 b=TyCycRZNjWxi5o/oKtGQJPK9OBiNsPSkYD63vPXZD94FLTbBIBSu/mTpmWfaBT6fJJ
 2Cu+GVyXcJTN5ZZ69Kr7Pk5ujeQ/NG4A6chaouyozXRJS3RRr6EFrTki88IpVuQTUo0I
 yTZpa9suVFd/yAY040pqJynlOWWt67h2c/+u3F5FCxNFgfwippFYGIzzZd+6fd7KjFf9
 3QnjvIyNiuxyVS6NRDDB/SNJrlslQoND/Yuajmn40YgGYfIdmUhiKnfrGpj6DBbew6eP
 fHUI1avXNKarjPTrpybst0zEL0hDFBFVKzs3HhLj4IhhjGxKFhjvGeCRoc3fdtJ9ziI3
 Qyvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ELfwZIvZclp9ag6Zqo1Ndwy/B0Ubi21Bn4GJW07WZgIeDhFdm3cAHZF6u2PWxS1vEh6QbKmo3ub5BLr9I6dnw+mSmw==
X-Gm-Message-State: AOJu0YwXfzSI0YLVvmi8Usw3BJUFXXGl3w43zTkB2Wfr79H8/rfAL6cd
 dlTwS5BFXbrDqa/Ehu0AtNCWm1PFhETutomirjN2NfeCtYxgdJuDtqOEtiH1fIWyFHwT2YPowZx
 fzkFPxDkH3xn9QRmCnAY3ltNzmt0=
X-Google-Smtp-Source: AGHT+IEsL9P9sVfN/JB9XKXib7DnT92QjXqfsaJbY97WFVrDuJAe9dUJ95GfuTFektJxEnp56AeQzpqps2/ApghcNuo=
X-Received: by 2002:a17:90a:b96:b0:2a6:8e66:d585 with SMTP id
 22-20020a17090a0b9600b002a68e66d585mr43781pjr.4.1713467172558; Thu, 18 Apr
 2024 12:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
 <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
 <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
In-Reply-To: <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Apr 2024 16:05:59 -0300
Message-ID: <CAOMZO5B36vz1w9ZZzJ+oZtypanTb7k6PvXNwG6KP8QBqcniGOg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com,
 Claudius Heine <ch@denx.de>
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

On Thu, Apr 18, 2024 at 3:42=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> Interesting. Which TFA blob version do you use ? I used the mainline
> 2.10 for my tests.

I tested with mainline TFA 2.10 and also with NXP 2.8. The error
happens in both cases.

> btw. 'no pmic' ? Is that expected ?

Yes, this is a separate issue. It happens because there are two PMIC
variants on the imx8mm evk.
