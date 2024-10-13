Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2CDCF258D
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 20:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB5688EAE;
	Sun, 13 Oct 2024 22:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQ/G36qY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF7B8899C; Sun, 13 Oct 2024 22:23:12 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E4589098
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 22:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539e59dadebso1756648e87.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728850989; x=1729455789; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBp4m2fB3HkEUCHVkP/dyvmBp4iKBxkyB7v4HlUGkWs=;
 b=RQ/G36qY3wnnt8hZVOZYDUR3zqN+XfEnOAoqbVTgcZMoajramhOuZUcx0WD2MiGnJN
 wj8r91gY2pEXyTGwDQvfqbw2ejsylwia1Fdzc/8eXQrdibnGgZcSHVLXVYoOCMTyzkJ2
 Db3NsmcT18XVgZf0XKZw6pPNBcNu1bgUKL1kOb+0AtQk5st1KI8bKgtFPvtyqKlACVnT
 FZaiRX6oSN4ZGKN+gthpvo8+pTLx/8nRMtVzrDvW0DafS8jIZFW9ZnSWIUOH7bBvSb7c
 k4odzYwtWKpzqPY9Ip5yTQXwqXbMckOTlwiOfT5tAEmgJ4cg85Zb1k9Ae6JzQGKsSJNd
 i7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728850989; x=1729455789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBp4m2fB3HkEUCHVkP/dyvmBp4iKBxkyB7v4HlUGkWs=;
 b=mnN2R1WKd+fYbrosdLCiDlYJnZIK9waVrkCyNMzgLfz6lwBp6HPrLuQQI3h+YET1ZF
 4fhionG57qTTe+Pof04yWyXlP0njwW6iug62wx8ZwnTtR6lE0Hsi3U4exFLaCDFG+xiE
 MWJFBlqRhhy9HNnQA+2fhQC/vpfrU2aRL5YlRdXj/dtO8RWc2j86aTO6ASKPCzu9R6C2
 Of0iKfZPFVqdrAGXVp+l5aIpThrjokI/3HuGqBq+xrMhyZnSuzG4eKxZaN7/Jyu0J3CI
 siTw8xVQkIBrGe/qHreo4XfLB0BuQNF6eGSMcLpJZ7KXtpFkMUxTwGvbVx7O4U8oT9XS
 LiSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDhSbBZS8Ch5ehybEe/nAJXUuvg4pCGlsloj+Oyi0NvjyoI9Ze5+wU+GzCQib+OL3eaRV6SZM=@lists.denx.de
X-Gm-Message-State: AOJu0YycVAnmrVS8B+XCF6HPdqVYx1KS9A/t8v720/gk/sCbNSZXtkyM
 tA4icFWOPa+eeFDMufM2Q9sWMYWFqqpxxbxnnzFeISuoS0sa2btcYUSG/kFppi0ifXWfLeoWT54
 aOIWdN8bAA3f/SOdKhNlLKeOQZwk=
X-Google-Smtp-Source: AGHT+IFHhR+99IUMahQ6hzFaQQt6/o7PIYoHWFqeLVJxqGzJaKsu5qJCcQobNvPOPRsMsPuplqd1sVl3k5lRP4pdMBc=
X-Received: by 2002:a05:6512:2806:b0:539:e97c:cb10 with SMTP id
 2adb3069b0e04-539e97ccd5cmr1560566e87.40.1728850989124; Sun, 13 Oct 2024
 13:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241009082936.22269-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241009082936.22269-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 13 Oct 2024 17:22:57 -0300
Message-ID: <CAOMZO5D0he3ZK2CA4jtaB3p=60RUoJJOCrUjQ8r_4x9Fbc3g8A@mail.gmail.com>
Subject: Re: [PATCH V2] imx8: Correct the SCU API return value check
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
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

On Wed, Oct 9, 2024 at 4:25=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The SCU API alreay has been converted to return Linux error code,
> using SCU error code is not correct here, although SC_ERR_NONE is value
> as 0.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
