Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A3FD2D10F
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 14:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA5982B20;
	Tue, 13 Jan 2026 15:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCAvsfRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F303283015; Tue, 13 Jan 2026 15:26:25 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9EA82B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 15:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-59b679cff1fso6261390e87.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768314383; x=1768919183; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=INZ2dDQBzpnbIuuosYPGaQdZoKc5vhub1XniiEEonZ8=;
 b=LCAvsfRFy1eG970AbhYKav+vdcj43497LVd2D9DKwSSsg5yjBSBBiA8oR/c9FqpV9o
 U4YE8WoUFrOAxsFJ3BSrHhi4LvBQiF1uds8EdPjVtTYbBpvAGoGpd7EkpmtojvG8jmd1
 r0y0Ex+vRsbwsXQM7FkAdUpO7aHUz+LOBUbyLBpSqCXsWZm+E24FeaXjaTNSPmNjz8Oa
 Ma42EwB3dLwLxHs4t4IpyUj0xgfX7Q8881lv1xiKGHwlHQFlo7iahF4CzBrbEuIDhfKB
 TnxnBUBg8wT5w1pFlk+jOmOPNtnS9tAuh7b0/aZy6gE9dUGrEgiTcYXYFc5Px0FHwmm+
 e3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768314383; x=1768919183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INZ2dDQBzpnbIuuosYPGaQdZoKc5vhub1XniiEEonZ8=;
 b=ZjSo82i5bI/7tLusFja1MRB7wM3NtfJJsVC/v1yEPWPkj/Qr+YSTmA+P7HONjxtrJ9
 NmDwaaoQrfAldW+JxecaTYKs83dC/P/ga/eLncb963zYZTVlMhWxyUQ3I96oe9uhiN0u
 nyISzCx/uG6rCKKdD6hkwNvAjxnz0ATiaRb8d/+D7ts0/mFfQTYv+APp4bJW+t5vNHV9
 IFQBJXsSrdgvkR2e/FHjMoWsHDZq1AyZ3TpRVuvDske96yxmzGU73tnAXVGPswnergW0
 CDXL2ehJJZN8+zz8RjBz1+a8UGRJzVEI24yNAa+I0YiFK3Xm+v7AlBJCA3FJ5ZFQA/Ab
 ZZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUtEw4FB3WXWGFfsXME4aZB/6fpdUXhdOy9E8xJd5TFUxfJ+0RefqWSGwsic12OpImj0+yAyE=@lists.denx.de
X-Gm-Message-State: AOJu0YxLycWXubGiO87R+3T8u/Mck5XUzGaVAqS8rxGEcixmy3lfsLi7
 haoreT1vQmkkYybpBweADhJNDHgyG8BkL73sHQwVmYqn0Nsz8456CGUFgQPzLjkTObMriSPPZ1f
 kLgrZ1tfb/awjD0eOqm1wUw7lyHeErxs=
X-Gm-Gg: AY/fxX5irqwPXl8FJ2UkWYRuishLVoFFyPIEtYdv7KLqETLBJ4bu+meppQSZzDfKI2i
 30JqRKZWG/l++ct/JKn/iIWQmA+beRt5455nWcpTGc1nBm3G4ScwZhWUKvdoMG/PluHeG3Gg5o6
 /QN0d33ZfgBQCSkWdxMgSlzDKniQcdS8YANY7XI6YPLd9ycUj6QqqaXAKPNKfW30L9ZCv70QOMR
 PjxF0bOIQl3fkfuoo5SRH62UCVqk018zbrUjK+Ut16uU5OyoVYJT5dKuEV3phw6/Rt9vFo=
X-Google-Smtp-Source: AGHT+IFPCVtkQiAGRJ5aWpS4yveLtBUtM4Wb1NvjP8xg43NzJj3cGjQLGexatY+5qNAPlvW3ZfybgSqvs6BiKdgGeM4=
X-Received: by 2002:a05:6512:10cf:b0:598:de74:7a66 with SMTP id
 2adb3069b0e04-59b6f023bc8mr6625416e87.26.1768314382980; Tue, 13 Jan 2026
 06:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20260103030728.334736-1-mateuslima.ti@gmail.com>
 <aWYPT7OH8oY0O0Mp@nxa18884-linux.ap.freescale.net>
In-Reply-To: <aWYPT7OH8oY0O0Mp@nxa18884-linux.ap.freescale.net>
From: Mateus Lima <mateuslima.ti@gmail.com>
Date: Tue, 13 Jan 2026 11:26:11 -0300
X-Gm-Features: AZwV_QgXkNIBz__Jk3O7GZVFhXBoBEdbf0rSc0iNb4wHp4iyyKEXpHQjkhGAsuU
Message-ID: <CAP8WwTHEKYejx2KAj0nVkoo9ar12LTq5BvdU8tDhoUovgr9whQ@mail.gmail.com>
Subject: Re: [PATCH] armv7: Add CPLD support via IFC to the ls1021a-iot board.
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: alison.wang@nxp.com, u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 13 Jan 2026 15:35:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, Jan 13, 2026 at 5:10=E2=80=AFAM Peng Fan <peng.fan@oss.nxp.com> wro=
te:

> On Sat, Jan 03, 2026 at 12:07:21AM -0300, Mateus Lima Alves wrote:
> >This patch adds CPLD support via IFC to the ls1021a-iot board.
> >
> >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> >---
> ...
> >diff --git a/configs/ls1021aiot_sdcard_defconfig
> b/configs/ls1021aiot_sdcard_defconfig
> >index 6b32150e408..450b46a6f1d 100644
> >--- a/configs/ls1021aiot_sdcard_defconfig
> >+++ b/configs/ls1021aiot_sdcard_defconfig
> >@@ -63,7 +63,6 @@ CONFIG_CMD_GPT=3Dy
> > CONFIG_CMD_I2C=3Dy
> > CONFIG_CMD_MMC=3Dy
> > CONFIG_CMD_DHCP=3Dy
> >-CONFIG_CMD_MII=3Dy
>
> Why deselect CONFIG_CMD_MII?
>
> Thanks,
> Peng
>

Thank you for your review! I will add this setting back in patch version 2.

BR,
Mateus.
