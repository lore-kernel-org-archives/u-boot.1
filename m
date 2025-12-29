Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4036E92FCB
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 18:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3535D83ECF;
	Mon, 29 Dec 2025 19:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4g1vQpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E44F83ED7; Mon, 29 Dec 2025 19:24:30 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7258B83EC8
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 19:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-37b97e59520so79667721fa.2
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767032667; x=1767637467; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9FWMuloH5tUAJkLpe43JvG/qJUmNgNfmTn4PuVGr94=;
 b=D4g1vQpS6CWPqccYZuFJ2fTjwLqYuKcLwMsrNDtMIeo/jooF6mrpogJpHVZPpWtyih
 Z5ATHqgk4fCrMFSgguFP8/+ZhCwrfl8yIyo8Bxaxt7jbVw67PRnKk4suX2MTXSMvNC+z
 Vm/h8WysqhgssRqG4dsoXVsYH+7qqVAJXVKxxHcLNa5hPQl2dpUVelFZ5gRy+vt7eo8r
 9IUvZ/0bFQySSTaaYYFlEXipIkdaXpGJDwbVgPIrcJnSy2JQvQODmEkKMByEmBYXCPQR
 +QvOAi/wc3pEQRaJTd421TKscOvLc8cZJrL5Psze7tXNu0RRDC+1QcJJN3Uc1QlpwRRI
 OwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767032667; x=1767637467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X9FWMuloH5tUAJkLpe43JvG/qJUmNgNfmTn4PuVGr94=;
 b=SUJuqTGCRvnHEFQQxSGTdLh+Vrvg49FQXuED+sxuTDNbqX/mU/BPkkFEqA7KK/ftSO
 k4al5mr7O+9Ae7XSFUiE395PhOX7kxiUD9QGytw5RbnVnqFX873sBXiwXDRIQP+6BxH8
 1bH+6jvbSNWrbB8E4UDS/YcO7gEs9rNrmd4bq9jrr7+INU2gIO149Foy95ukP0NJmsje
 I8/j/SnuLVK184QI22GwZlLhcKZMX9EoxtzCuz4WTt+v+MXyK0pKiLXZxNRCF2IxDD7N
 XO2yVrLLLNWBRg4HZ2M4xBIMDQ4iqv5QITh0rfN+xvJYXbfibMUaqTuWpUOT2LToylUm
 n9IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmkibUcddCWgylbcXtXuXZfRB3bRDWKbhmYI98O46X+2MgPrgruZkpNOQZZb3TdWYE4PsB3DI=@lists.denx.de
X-Gm-Message-State: AOJu0YxFlpHK0mGfyFR/4igbSIJQYoHwSu0KS1ChWC32ddjRJPh+97kP
 uiASQaRA4Lc/MKCli4lSrxWyJdVN6LBe2f+nmJE0CoAFzQn+aUOpMl/oBJAPoU842y6v1ZdyJsl
 vCvqfpyQF2+5Ou7zTK7GJBzjOfPgOvuw=
X-Gm-Gg: AY/fxX7aJKnzwfiqQaYPSPeo1fwyWGNVusL1a8svTNkz5pIrMpzV0uaM+tAZbFL+bkh
 tqJnim1EVoahD9DEbGBrSb7u1NeP/VMlusVWOUN/GeUrf0314RT2z6iBlrXhYJVSFeVLUKhCvUy
 UobhEVc3hxkhv5km2d58puwZ2wmJyJw75N1LdJKCQdY/rbEctXcHO9RWnDN7k6XjxiVwmFtjNyL
 vBr6IlNm+HluBG6RaGaIvYYiIPi6xE4W/fGUzSwh2XYsLlanlftfMa3uaSFgAPGi1inybz37tdZ
 r+m/m9D1JkGsUf0sIQ2xCcS3t05vD5OvIsA=
X-Google-Smtp-Source: AGHT+IGEgjhS8mvU/0UqzkvGuwuwccFR5QOyidfQ8wy44bLe9tf1/QwfuNTUSM/pJ0DEBx9/Dd9W8oF4oYz/DyvOj7s=
X-Received: by 2002:a2e:bc18:0:b0:37b:a32b:ed41 with SMTP id
 38308e7fff4ca-381215c5edemr90237211fa.18.1767032666431; Mon, 29 Dec 2025
 10:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20251212-imx91_frdm-v4-0-66bf00d8e721@nxp.com>
In-Reply-To: <20251212-imx91_frdm-v4-0-66bf00d8e721@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Dec 2025 15:24:15 -0300
X-Gm-Features: AQt7F2p7zSFan2xv4hz5MhbgJio3i2KtSI_mxd1rrvco8lACHtV-zMTjq-w-2kk
Message-ID: <CAOMZO5DsCi6GHrkvLEZTjsLy1D02A2e83YgMO36b3EMt8B6c5Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add FRDM-IMX91 initial support
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Francesco Valla <francesco@valla.it>, 
 Jacky Bai <ping.bai@nxp.com>, Joseph Guo <qijian.guo@oss.nxp.com>, 
 Justin Jiang <justin.jiang@nxp.com>
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

On Fri, Dec 12, 2025 at 3:20=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wro=
te:
>
> This series add initial support for the FRDM i.MX91 11x11 development
> board in U-Boot:
> https://www.nxp.com/design/design-center/development-boards-and-designs/F=
RDM-IMX91
>
> Include:
> - Device tree for the board.
> - Defconfig and Kconfig for the board.
> - Header file defining memory layout and hadware addresses.
>
> The board devicetree already attempted to upstream, but not been accepted=
 yet:
> https://lore.kernel.org/all/20251114-imx91_frdm-v1-0-e5763bdf9336@nxp.com=
/
>
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>

Applied to u-boot-imx/next, thanks.
