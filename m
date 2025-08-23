Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C420DCA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 19:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D393800D7;
	Sat, 23 Aug 2025 21:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSSbgoii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6EF182BF6; Sat, 23 Aug 2025 21:36:21 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7344C80077
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 21:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55ce5097493so2873092e87.0
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755977778; x=1756582578; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glJnXiaeQDtfLAm0ANCcMk4P7xEsXK5AV5HdByjYNgk=;
 b=cSSbgoiik5oFFeYq//zrZHkY1LXWtt6QFcTFrvWTCoaKeLUL3mp4PL7tlGH9o7hlKP
 0D79e2gR1UcULeeXETjoYgEPJOoFL82DpqqYlAAtT/pTFAySZCTBs/1wW7UnhDNgMrjz
 JfBGLVrAaSRdtrg0Ttazov8fDTNmXjI2WY6bggGRqpHLowRB8Tuwv2PGJK0ZmgTwrhHq
 x1734b0WWF46hc4RcmcnYkg76ArYAFLmeatfemaAJknC6kbp36UwvFPi4PbPJtv5u6iq
 7t7XV/erqRaYPbjtpNC3UWUZZrZ75hEWoJf6moY4sYqTmQnKZr1V5G4u6DpuNU2TV8lC
 y95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755977778; x=1756582578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glJnXiaeQDtfLAm0ANCcMk4P7xEsXK5AV5HdByjYNgk=;
 b=lHLhQouIQBgZ+XttXzdzI5PAYCGKWMGeT1H4IfY3F/EQzfGYq2aSdtsJ2MWSDqz5MS
 4oOXXw2ki/iYcw+bhmjwcV+pQiLCbpULZmWcVlL/sdRn23d/d0QkEZNQ9t7+2IyB8Ia2
 n53NJ4P1envbTG3rnNXFEC+ve5JbIGOERRtz8PeQYX1ACeokLORSpX10FRy76EJv+Mcc
 nQ4OMvqOm2Mx0HMR8BPoOEjC/fp6EPfmcHVXYTHhTn51boNxZg4cWgQqiLK8IlohoJO3
 kn54D/AUx2iHOFdzyMwCfNWsMPugvLLtInmZBJ/GPabqoY7WlarTOKiev79RDNIYbBs2
 XTxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhsUdbGm7B8b6jQNMAmFyixS8mXYeMT70EaoVq3PFFux2oSgJW4+ou2hVcpz74ILuSw3JPnn4=@lists.denx.de
X-Gm-Message-State: AOJu0YzZZLcMUL9uxtqQaITtdigjHa2gsrlohzhiOojDw1dCtp5EWH1S
 jiiJO93Beo7AhjhvaJNDNAFSdR4SliBosJDGNWKz/x6+RHtQoW0bkx1QE81rEmC7Hm+Pftu2W4f
 wBoYnoIvQzxUmyYMW+DpnIK2ZFKB5Q3Q=
X-Gm-Gg: ASbGncs/qDy29L62f3SnBfZ+j86R6bMpGStsnCP3RK9jflralz3kLXr34jq828oNIWH
 2Ka8TCUo2PSvujT6d+KGOyjp84rI3lZ65J5/DfNl0QoZr7TP/zUS7OZMg4XqSmRtnjsrKVXkEeB
 1+HQ3vpccbI5doUZD4bakTgQsQjYcrWQdAhIyWp142tbloWL87kCeMW6S2zhjovXWoSoCBqNPzl
 M4zu7rwEj5z6r9/IJqeF9j/X8OaM9rWdwKh8b8=
X-Google-Smtp-Source: AGHT+IG83e5oO84ocUx9Tu0HX82QX6WnN/sqIyQpqkdt3UtEMv0XmMFnawaJWkJvbgRCTbIz6sSZ4fdmnnhJnDFaIIQ=
X-Received: by 2002:a05:6512:3ca8:b0:55f:3faa:7bf4 with SMTP id
 2adb3069b0e04-55f3faa85a6mr212851e87.17.1755977778108; Sat, 23 Aug 2025
 12:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250811-v2-fix-imx9-usb-boot-v2-1-3d89974e2881@toradex.com>
In-Reply-To: <20250811-v2-fix-imx9-usb-boot-v2-1-3d89974e2881@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 23 Aug 2025 16:36:06 -0300
X-Gm-Features: Ac12FXx_Sz3FJbM0x5WrQuIzncz_lLi98tMguOYbJV2c5I0qZuPzG3Eo5jRe7x0
Message-ID: <CAOMZO5CD61vfQOUAo_uFSkuMuaD=tjw9H66io5z+z8cKT=L3TQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: imx: imx9: soc: Fix env location when booting
 from USB
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
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

On Mon, Aug 11, 2025 at 9:58=E2=80=AFAM Jo=C3=A3o Paulo Gon=C3=A7alves
<jpaulo.silvagoncalves@gmail.com> wrote:
>
> From: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
>
> On i.MX9 platforms, when booting from USB, the U-Boot environment is
> always assumed to be in RAM. However, this causes the boot to hang when
> `CONFIG_ENV_IS_NOWHERE` is not enabled. The boot also hangs even if the
> environment is present in another storage media (for example, eMMC). Fix
> the issue by correctly handling the U-Boot environment's location when
> booting from USB. Also for i.MX95, set the environment location based on
> the ENV config and not solely based on the boot device type.
>
> Suggested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com=
>
> ---
> v2:
> - Changed the env location order on USB boot to maintain current
> behavior on i.MX9
> - Applied the fix to other i.MX9 platforms, not only i.MX95
> - Added Suggested-by: Frieder Schrempf
> v1: https://lore.kernel.org/u-boot/20250722-v1-fix-imx95-usb-boot-v1-1-de=
c7f2384405@toradex.com/

Applied, thanks.
