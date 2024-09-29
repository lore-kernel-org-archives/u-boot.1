Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0327ACF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 20:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EB88863E;
	Sun, 29 Sep 2024 22:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BjFF2hgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D7688D6B; Sun, 29 Sep 2024 22:57:05 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BAE0881A2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 22:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5398ec2f3c3so982689e87.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727643423; x=1728248223; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBvJxjYPuosoISgxKdiNxgiaD7j5dGu+oQpffII/dQU=;
 b=BjFF2hgpa663l+DjcvPZzDdArTD8dLUdRUOliNpc1yv8l1tUS29SbORIU1dTAbsJTC
 CYgCIUYBKchf/fDztDeLGOVmBkP4gl09B6h6cn3DNTFblUiKc4g9OG5GaSuVFUOKqeth
 QmsMpzcoFlQNyRPnvhubIynWZE13gPQak9TtK8Uc7HDnG0u8eLdBmV9LOBzXi4AhKozz
 sFgTszchTYDdsVxpYt2QPhFzPyptFMowF8kIwPztgdEFr3iJcOO3F+Tw/xvvLQ/Uamk8
 UPudX1Wzi9bkJjAIl1lYslGP63SX208q12JelllA53iqE4C1lmk9t0iMraIG8grkZEso
 n/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727643423; x=1728248223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBvJxjYPuosoISgxKdiNxgiaD7j5dGu+oQpffII/dQU=;
 b=JrNctD6Hlq/stNC+fjrG8zOI+GobM+/WmGjyPdRAJqU13hvEQP9RzVDWlmQnG+6NM0
 sC48OmmJxC5P4iOjd4LUAdGY/Qpv20UuQhtZJgxgIeZ7ro/RjB6XbpclIU/MZpXpUSGX
 yHywroMP8JY9aWlH300O+30XN0P1fjQpvJ3tfAb7ND0EaTCII8sirVg8++e7LCVUh0eJ
 KzDggkWcRTkMC4ZtygdbgetHkrsf3A/rFsng0YpuxoMFWLvh2lt6vCEKSuz1SLOgWaNR
 H8B6eVbEsXZQ01K3XUmVI0YjI0zuBk4KWF8JzBFwn301IZur81Eou9L9TlpQQShhbKEN
 hfXA==
X-Gm-Message-State: AOJu0YyUZYSSrKXH2KLv2xd+viI8U3t4b0R/wafwLPfLyJpWUtNIizjI
 lIdvkQ49HghZkOvykT4GVHAVXvDKPHl8LLaePMw+/C6w0rlWaH1PmHCmIKct3mFNz7mEqenoTIk
 mDi12nSM6rdrck3sAljSfo148+08=
X-Google-Smtp-Source: AGHT+IGNKGsHUncwFs7JfLOdd0+TMsXmn2NVeGpAVbjZVW9VCi3xGtivFoawuz3vxCHUjNJIHWbvQW5de2bBbD93VoI=
X-Received: by 2002:a2e:a58b:0:b0:2f3:eeab:7f17 with SMTP id
 38308e7fff4ca-2f9d419953bmr46064721fa.41.1727643422679; Sun, 29 Sep 2024
 13:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240925160738.85211-1-marex@denx.de>
In-Reply-To: <20240925160738.85211-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 29 Sep 2024 17:56:51 -0300
Message-ID: <CAOMZO5Atu3hcOZZ_=5UC7kzANN4oLLBwF74WHeV8bTJOuVnG+g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp: Add DH i.MX8MP DHCOM SoM on DRC02
 carrier board
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Wed, Sep 25, 2024 at 1:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add support for DH electronics i.MX8MP DHCOM SoM on DRC02 carrier board.
> This system is populated with two ethernet ports, two CANs, RS485 and RS2=
32,
> USB, capacitive buttons and an OLED display.
>
> Matching Linux kernel patch has been posted:
> https://lore.kernel.org/imx/20240925160343.84388-2-marex@denx.de/
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
