Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79534CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 11:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F328E82E34;
	Mon, 27 Oct 2025 12:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMizeB3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24566832AD; Mon, 27 Oct 2025 12:55:11 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D88E682A9E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-378d50162e0so52847841fa.2
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 04:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761566108; x=1762170908; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1tqMVMQPk0Q60mOkpOJYdJi5ZZ+sEEKr23py4qW5YE=;
 b=TMizeB3i34vdn3H/y9fjP1sPPPSZKSe35jDejcUHw2GGnLdIySGFi+2KFQBoCgklb2
 54JNXqhFqRU71rXrndFCcxY5zrpDncof9oQr2R5J2zAEARahLnN1fHnWn5hstOLqitF3
 EYEdRzkTIQwmaIjowld7q3gPBfs1xqdgjbTF0qMiaG9XxpRqJOVpW2mAFCmgNHtn2HfO
 7/n9Wy4wFWZqUSKJk4WyRpNjQ4F+r/Udhxd6qr+X7YwUyLXKKAgrFg5JyRkJbmE4SG68
 DmmHcd9TBB5QeDouEAWVgDjkZXp0XvumXsoi4Prc5TIBY+YkrpMKuHSx0ukLpKKm+79X
 ij/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761566108; x=1762170908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1tqMVMQPk0Q60mOkpOJYdJi5ZZ+sEEKr23py4qW5YE=;
 b=G/YmwGM+XHriJriHzxzQAz42KS9LTGtmYKv1q1cIVZZp6ibCe6UftOQjk/oyujY5sp
 052PXbFO7IS7UBTKLURFwzl3od6oDhW6XIsGG/jVcGazSDMWBxJPfgL9V3Ijv5GQRZN5
 WUpfMezDMebiUHtnSiZVieHUDACA2+iC5ruPlvEX4eIL57TRvMAqcAcxh2F3AKe3Z2MT
 APywUF2/MG5kRr58m3yRgCoTl66LaQwjLUvs7PBrmmo8uIO1Me+KYlhGD6gyeSVl/WQ+
 HPO9HF5VMfx5Ad3CFrvWUtHMjPPaTEPppiTFAHT4QxwupxA5HEla/ymQnLeoF34W4+tk
 Y/5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3hE/VKZWlDo7m7Wv5ZhRqP+1CFTo6WhExjLvG0W26lCh+6iK3JmeeCX4+hiOsEofowt3oERE=@lists.denx.de
X-Gm-Message-State: AOJu0YyNTCRTfJl7WjBs9NZ27o4IyXcydGc736wwHp3FlLYCu0rHFlCl
 zZiAQQR/ZYMyupCnsmrWbd3DTn8xVYQ0NBiJx465KoPiD9inpJpHYZBrWStpQrSyTGa4h0Z5opp
 ++mdE8LUdj5nvMRUqpuBkJu2nLNlNK+k=
X-Gm-Gg: ASbGncvtH5X/pi6NBd8lGUApkScwkh09QkYaxZOroStUC6pTsIHVGqTHLlaGMwVe7vc
 STouKRm+4Lu+mlGNEZCP1mx7B7wmwubq7/4kzjvnRW59DFc5P2mDhcJm5uWM40bxqqSuVPNe9ZX
 35bj4OT6cAr+F5c+ZBoAGF2iaMe6I5BqrdnnWDXBBGlZKg51EXow7eaexmtvxwuims3gA816+6v
 uqlFA2Yu1U1U8lZ4qCwLKeRawxytyUYps82JjgKYuPcDLqJ0vxJxvE0122iYlzOAnOV2qO5yyU6
 2smsGktQcnDSYM+G
X-Google-Smtp-Source: AGHT+IGLzOnwZBuY4QJjHc1gxOHhRWY8CCYB49wN63JBNwz3CCk7EdnK8A/uWnzl2zBtfAMChq7hOkj8iFEyhmQTQqs=
X-Received: by 2002:a05:651c:1511:b0:378:d773:aa49 with SMTP id
 38308e7fff4ca-378d773abb1mr43065651fa.21.1761566107891; Mon, 27 Oct 2025
 04:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <bfe7ac62-0d01-45b5-9226-e1d425565d50@schwermer.no>
 <CAOMZO5C_8xacCJn9+KWC44nSuMWNCUu0c=YHsQvTH-+1yKawSQ@mail.gmail.com>
 <5ebba7e2-ae01-4ff4-a17f-66ddead1acd5@oss.nxp.com>
In-Reply-To: <5ebba7e2-ae01-4ff4-a17f-66ddead1acd5@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Oct 2025 08:54:56 -0300
X-Gm-Features: AWmQ_bnPllgYt18biWw3pk7MrQSpSKtiD9VWpdHwna_UK_CioOKV4nVxWvlUn7k
Message-ID: <CAOMZO5DjEsPEZmJCO0Xrv6oZm5AFu+VM_DC862sqPQqT9RUc5g@mail.gmail.com>
Subject: Re: mx6ull: init_bandgap regression
To: Ye Li <ye.li@oss.nxp.com>
Cc: Sven <u-boot@schwermer.no>, U-Boot-Denx <u-boot@lists.denx.de>, 
 dario.binacchi@amarulasolutions.com, peng.fan@nxp.com, ping.bai@nxp.com, 
 sbabic@nabladev.com, uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>, 
 martyn.welch@collabora.com, parthitce@gmail.com
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

Hi Ye Li,

On Sun, Oct 26, 2025 at 11:27=E2=80=AFPM Ye Li <ye.li@oss.nxp.com> wrote:

> I once sent a fix to revert that patch, but it was rejected.
> https://patchwork.ozlabs.org/project/uboot/patch/1646721735-125430-1-git-=
send-email-ye.li@nxp.com/

Thanks for letting me know.

I have resent your original patch and added Sven's regression report.

Thanks,

Fabio Estevam
