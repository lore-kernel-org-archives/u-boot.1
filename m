Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DA8CF258E
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 20:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D049989067;
	Sun, 13 Oct 2024 22:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A7YxdwrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338138906C; Sun, 13 Oct 2024 22:23:42 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E91E88EAE
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 22:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5399041167cso4900928e87.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728851020; x=1729455820; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqRp4g1UFkDTdyDJRuuNnlUfggGE0uPTKex2I5+iQBU=;
 b=A7YxdwrB3STHxYUTA1GA6ysWwyeuLEc7kEPlaXOWdlpl5jgdY87o1Os4p9mx4vO1z8
 QX2QyH3j7Og0r2u+tVBb8WOMwzrpmzsO3+f7LdauLyVWNV7hYdLDILPDeueEw5LCuALZ
 aYjM46Rb++IoNxrUXKCRm7ts6W8TAYyV35dVvsoqatBwFd4rbP1f5+5g+EXPJoOoTpl6
 Mb6tPcyJgvO24hAE/vQuKvvc/5W5xt+0HuuC0NCUPy9vzoBv7nxhJfoW9L4I7+CCW1zR
 AERYAEcJ64HGboWlbN5yBGMgZeH64PVcxBo1KIm+zuHIs+afT/B6BSMGyo9xA+J1XroL
 bPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728851020; x=1729455820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqRp4g1UFkDTdyDJRuuNnlUfggGE0uPTKex2I5+iQBU=;
 b=faY9Lu8e2GZxB3Xw9O7ByJd8hUlB1oidBtX9FYUM7rLfgyiHMUACo826Pz5kwCRUs2
 rX8C21njzzLp6o1ecCBn+Gn/xisELo7dAo65c6fLUdpSIFBgIQAZBrzw5x7pV4DVdCHy
 kTcAW1wywqSGxp+ZHPvJwZTbj6FmeY55chXS0LHgzHHh0/DeGHYxvx0vOfa6zvy7oAOV
 dynJWLkWK+EsIuzvbFKppWDbRttGxJHQNtFipZYz1WvImkt9DrQaEGNbtrdQ/ALBFGlB
 YNPUB1GOeS8PbjY9jn+DEwS4hO5OwvowzdlUopGxWz4RZZmZqyMJEgXnX5kGkAToTJSv
 4NJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjaM6tzfvDt6hOpxHohThKoe1279sxZRry9lOa1biHUnjtPa9KX9Yf9OTibAax9eUOSaEZuOE=@lists.denx.de
X-Gm-Message-State: AOJu0YyByM5XrAhBKRdSPB8o/nNrplpWX22CPGqMFyI784VWMcHCScnq
 AU6HwjLJLMvGAp+SqnXr5+FjEtblwKLjHQsc9wziWHWvtK3A9rvrgkokJtWEqoEMQkqIviDeygl
 F1DrYMU3jZKqGRlF0g6N1EgQEctU=
X-Google-Smtp-Source: AGHT+IFSOjEiy1EJvVy/WkNgxLMo5M2Fe1f7JH4N+jEu5du2gwz9EK8FA0b1qzREj02zYKn6PaBiXt9PiNX9MdzZ7vo=
X-Received: by 2002:a05:6512:3e01:b0:539:df2f:e114 with SMTP id
 2adb3069b0e04-539e571c9femr2176224e87.45.1728851019378; Sun, 13 Oct 2024
 13:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241010004242.149787-1-gilles.talis@gmail.com>
In-Reply-To: <20241010004242.149787-1-gilles.talis@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 13 Oct 2024 17:23:28 -0300
Message-ID: <CAOMZO5CaUEiSp-YMtsr3n0SO_P3KwdMuiLv5eoOUodP-whUWSw@mail.gmail.com>
Subject: Re: [PATCH] arm64: imx: imx8mp-debix-model-a: Migrate to OF_UPSTREAM
To: Gilles Talis <gilles.talis@gmail.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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

On Wed, Oct 9, 2024 at 9:43=E2=80=AFPM Gilles Talis <gilles.talis@gmail.com=
> wrote:
>
> Device tree for this board can be deleted. Device tree location
> now points to the freescale/ directory.
>
> Use absolute path to PMIC node entry and its regulators as
> device tree in kernel does not provide corresponding labels
>
> Signed-off-by: Gilles Talis <gilles.talis@gmail.com>

Applied, thanks.
