Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09CFC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 13:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3400187F6F;
	Mon,  4 Mar 2024 14:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A4w7pKxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4166586F1E; Mon,  4 Mar 2024 14:36:53 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A6687F6F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 14:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dbff00beceso11896995ad.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 05:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709559409; x=1710164209; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPTIGFzMjv6t0WPGaVUZygnqRv1sD/oKkcLYBh+e8oM=;
 b=A4w7pKxZ+gY+V6bus99DqYtxOf/MAlCoqnj3bN13JXNnjepnXdZITry/BwwZqzXY8h
 J+FLswzDoXOq9hdmQMqJqFlxhIIKs0EnS6HRRxIN0oK7EkHbRssDdIdRXoiHtDzMRVXC
 8M9ODxXRHYvp9DckWNSThZGQdeKdHSclE3ppXgplAU2Em/lY7wcOLqkaqxAvgyVVomJH
 uHRhPepdZ3eWqJL3aQkByy511/9lxiuyKMwGUpFkI7NhT55Y3HWoEtE3ouZPGcynlzK2
 DYPpvWGCi5eUr4HoTzgvSA2QGdOvaiV3vumEs0CFzDvQK+bo/OapPn3ZkXK3bu9zauXK
 Fe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709559409; x=1710164209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPTIGFzMjv6t0WPGaVUZygnqRv1sD/oKkcLYBh+e8oM=;
 b=N594BjCoRK28BlN3EJNMRWuJOZ9rPG4RwCkia51w8sHnaaHq5pg6HVPdI5r4Exjd6T
 uZAgCzFjNRWSjBk/OuM5nSBXNO8PDXK21k/8WwuQtxixMrY8829/M8F0kKaNV+srkpS3
 5We7wS5/oTYwTP0iCFuD0Zs95phNXmshREfiC14XUB3XN9J9J36yDEoE0gAZ/wWuHg/1
 FwFtAhC9TBexGddG5sA9fShnZZVaJlNu/ym8CC/cuuKw8yKbi4Lbo6rxhuTc8DiA/Gso
 l+Tj04DXepH6DURMvYRCO7gR+1ymnGviXcXWXTioYC6H9INYEo7Vil4zC+zi2pocqD1+
 Zu7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN+779/onIDp35xGMIU0XR1VIkiFHL1eGYrY9//TKHeN0YqwjmE7MM/caasrjRCI4TT6Hu6efhGIhCOJIjGGkdcuVJpA==
X-Gm-Message-State: AOJu0YwzTtnIDkXXAULKdBTG1UwL5YGTjSMKuQk71jMrAsNgdKv/ItuJ
 V8wClBeEQ9saPg2sqGHil/EgOPPpBHVtoXdxH4E1h1rgLsglLvtoBMIy43yXXwh9dENdZdeDBd1
 mM81AWcMtOB34e8uIqT6VyIoFvRI=
X-Google-Smtp-Source: AGHT+IG2MrxSflrtTeDejqShioOG+Fcx2pEuHCtqK0yH5S7C/CUsY0JMaqny4UWiwwkpW8N0rLXW0SPY4+GWnKzUm+Q=
X-Received: by 2002:a17:90a:d98b:b0:296:db75:c240 with SMTP id
 d11-20020a17090ad98b00b00296db75c240mr7383857pjv.1.1709559409465; Mon, 04 Mar
 2024 05:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <20240227154234.GK3040305@bill-the-cat>
 <CAOMZO5CBY4+CogKi767RVvT0F89Kpp6Hb9p1o7cw8jRE9PwUuA@mail.gmail.com>
 <20240304133458.GE1523872@bill-the-cat>
In-Reply-To: <20240304133458.GE1523872@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 10:36:37 -0300
Message-ID: <CAOMZO5DERLm6DtLGEdpWDnUs=H2Oo+9ug24yjbDOJR6BnGg6=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
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

On Mon, Mar 4, 2024 at 10:35=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:

> For v2024.04 yes, this is fine. For long term, we should parse the new
> timing properties that the simple panel driver takes in our simple panel
> driver instead.

Sounds good.

S=C3=A9bastien, please follow Tom's suggestion when you have a chance.

Thanks.
