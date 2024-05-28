Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D07C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5422883D3;
	Tue, 28 May 2024 15:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zvp5JKZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E36C88349; Tue, 28 May 2024 15:00:27 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F14F88414
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2bfae86f1ffso148954a91.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716901224; x=1717506024; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHPqYoGGeEVp4322P5zN1jVquKlbdvbDjFlSgOlltrA=;
 b=Zvp5JKZP4SSls9qMfUzVfH6avQYOLJ/cw8aIFgLsRo+mf6DOl+fGAuzKf19u5dJulQ
 aRN/VFaVp1eLfVQ1Nkln9PQmavhiZ/53mQubHK9QixQpv4rJZQYSHdrQfutn+b2AZl9Z
 uomidTZQZQNBFE7nLI0PBWv/lAxjH1d2c20+KuMkJ3QRUp1tOfPSYS/dPftoulqCwSyJ
 Mkw0vveW1Vo4gIeJVn2r7V8q7+fU+e/zPEyfsgBRPIb6ng7N8uEinwPJgRe4u1TFlcrx
 INfkX5mBoMoDeMkw4VTPfV2O0g4/OKBjGcmsylSbGrvwLm6mdKcZUlIGunr8sqnMdMQo
 Cmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716901224; x=1717506024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHPqYoGGeEVp4322P5zN1jVquKlbdvbDjFlSgOlltrA=;
 b=mxgzXjJKzflrc5ZWSyWoSzpJS4MhwgYkLDTVFETQPAc9og10DhVQnrWcLprUDl+CC2
 xvp2DhFqbf2YwreU1PMoDCntiraR/fezkpPIqz88wIfF47clE/a5s+DUNH/18cKhsowK
 iWpcM8p3PrlHNI3FtJvFzj57dyX7KdYewPZN1ppAsD2vPq7fF5uxPW+GEwveom/Q1M6L
 ik2B6lHqONtMOmdSdNk1DZGV3VqSYxKWNE0zsYeeNRdFDfzvIJdBsYRQqbWNqRwMjJrp
 PQNuefWa2FGGhmp/WfWdzPz8HSTOBW25EMf056q6hhwnzuiyYcBKxtd8nnXy/XN1Mfg6
 C8DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK9cLZx4sBZBbWmsvcOJie4JhwgCs7moX3GPAKgtBN0NAFmnSaJXyOLBSBhNMQd0a1SgsRMwabAA0kFDd1+NQRi+lNWQ==
X-Gm-Message-State: AOJu0YwGM1uiFFEu4BA1BEyeRNGOpcvn5bSjUNJAWHW0X/jURs5Ih6cr
 KaeLi3cTf3RaYUiML7KAfC5Jx8ROFMx2fUZu90UeIByQr3x8MGY/ddqLN+kRPYYlj6252hYFB13
 rmtE1l+ebEYc+3J825A2kXVgrrJg8dLy4
X-Google-Smtp-Source: AGHT+IHXqzQOg0JPkXH0paA9cNJ+63LGrFjMY0rlbQ25Pqp8svU1ERoIpKxQk2jdgM1oo3aVnBHqUbQG/OAxaCyYqlY=
X-Received: by 2002:a17:90b:128a:b0:2ac:69b:886b with SMTP id
 98e67ed59e1d1-2bf5e13e04bmr11074570a91.1.1716901223588; Tue, 28 May 2024
 06:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
 <20240528-phytec_imx8_of_upstream-v1-2-c884c1ddca5f@phytec.de>
In-Reply-To: <20240528-phytec_imx8_of_upstream-v1-2-c884c1ddca5f@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 May 2024 10:00:12 -0300
Message-ID: <CAOMZO5BFkAdQhedyroHnVZXYx_4FcsvYDw=foiZiAAC2mt4V-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: imx8mp-phycore: move to OF_UPSTREAM
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Tue, May 28, 2024 at 8:25=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> The PHYCORE_IMX8MP is used by the phyBOARD-Pollux. Migrate board to
> OF_UPSTREAM. Linux kernel device tree for the board can be used as is,
> corresponding U-Boot device tree files are removed. U-Boot tweaks are
> kept unchanged.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
