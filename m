Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606DBC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D92875EE;
	Wed, 29 Nov 2023 19:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jhD6TWrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA128778C; Wed, 29 Nov 2023 19:07:29 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4757A87784
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cf876eab03so124645ad.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281238; x=1701886038; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=628LPWXm2pb717zEfxIWGmD/ZptqxvvZG1n7dA6/OPg=;
 b=jhD6TWrlPx6X2DCj/GlRBjSAFkAYtbU92gFrk2gkjvTwC5naiHzKM9JjdLcUVuVn3T
 WMkChpzmqIC3oPl4XOw54PSamwSyaCPWRLaWPIZXmurgeM5jK7CTyZz16aG9lX52DxW/
 VGecXys2ch6pz1yiOrT445CNNj8js2P/niKDRZnJ1gPZBn8rcJPYDeygw9I+ZajZJFv3
 EglAaConFEexSMkv8zV7HoIerCv0kUv4Yj7YOfoG7qZLdfzlGZ3sy0c49cNQiJz3bmWg
 geND6k+GW8zvMbt5G+VffZiseID7YGT2uDZB8gAellXbJVd5cIh2OR7nkhfhqRWJHAyC
 uGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281238; x=1701886038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=628LPWXm2pb717zEfxIWGmD/ZptqxvvZG1n7dA6/OPg=;
 b=C1477Ho3oYjAhg/dzIKyTpNjOb+RJmd4t0+ViB/bhLt68DODSpnCXv5R2cAgL5nuVD
 3uHMEHTdph3NhZbbxaPsyb1GU6fZVnya6yBXgj7IlcIw8FHsS2Jw6iRJv/vAp/SQHhDI
 gnjhGvPxd/w7bCrYU5IATq81xc+u8qMzZaU3lN3+WzRBokQ0p3xEfesjZrGEbD+avfT8
 txj9jG4w/o1x4pPRvVX9yFuOQaV38SNu3FhlBCY5Hfa7FLfTo5PHBbnmlfVyG2jqV/Lw
 Dm88PnKolmjYGc6YVKWJL2Uq0xqD+SAZbnT7LYF0WADsGgs7e0xdQI3NJPMgFWIaq8GK
 RePw==
X-Gm-Message-State: AOJu0YxVh65/N6kXBQoPg951HLeGH5FsrKSEcstdKhQfD4K/IVuZDxcQ
 hcj1prR61bgSsqLc7DcUvLJO4z39Ve89bi47oc8=
X-Google-Smtp-Source: AGHT+IE2rfQBjJUwEif4XxJE8wBam6Ey1tLtGpYG8ZZ+xOlEu4Ip6tlLe6csI6+f7zULT9uYVgTkymkRxzxMsp6XB54=
X-Received: by 2002:a17:90b:3643:b0:283:a179:963f with SMTP id
 nh3-20020a17090b364300b00283a179963fmr19600267pjb.2.1701281238001; Wed, 29
 Nov 2023 10:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20231018183306.2168046-1-tharvey@gateworks.com>
In-Reply-To: <20231018183306.2168046-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:07:07 -0300
Message-ID: <CAOMZO5AjH09+4SsT8hQhbQzF+BH5S8GWLvhah8TdRG83OCeNMA@mail.gmail.com>
Subject: Re: [PATCH] board: gateworks: venice: add fixup for GW73xx-F+
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

On Wed, Oct 18, 2023 at 3:33=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> GW73xx-F board revision switched back to the original PCIe switch due to
> part availability.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
