Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092AACA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE2A838C2;
	Fri,  5 Sep 2025 15:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QiY2/dRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CB1838C5; Fri,  5 Sep 2025 15:34:04 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D01DF838B7
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-55f6507bd53so2207820e87.3
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757079241; x=1757684041; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9oj004G6UgiFIGeGZJCEMfWu6/qq8cMCHB2J1YesdY=;
 b=QiY2/dRz3Vc7HjsWwQpncUQi9A1/fZ1rP0f1HfxXBNUfFOdfe2naABZZbY/7mEi5+b
 X6iPWPUp4UZbpzYl2gG7/ZYFaAs1t4jfP0CbRW0kq6PHxLxyNRQO39CqPsNyRSbPN+MU
 GHsu2zt0lVcQaIlIkGj7Ynr51GdqG5fAhP5V5RuUU6k4V4+PKslHv30ujOrqgM7vMgtz
 pksGFPBudU92En1ecFkzuVgjtihgZT5RaFMYUDPI662Apslz/s1E67Rg+7b/len4Y0Dn
 5AMGIR7MQ9xnc7zLyoOnnhtVZsUN6yq7lisP7gzTnoIOjDAGN6avSq/b1V0UdsIh8wli
 UlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757079241; x=1757684041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9oj004G6UgiFIGeGZJCEMfWu6/qq8cMCHB2J1YesdY=;
 b=hEUOBKtkiFHp3eZB5G37Mvep6jD/a1Ya+4G5kA3iv5UMNMD6FQJzwXAAySbSrwlTBC
 9g8YaeSlbGDPymvdTwxJ5SUh/zUBVUlVj8cXT3DD3Zj3mCAQGHIgt3nFtdzHhdC3Q+pL
 aNQW+yRkKCiDI+6ZQOmVW/1yoUtDBkbjhs1sHN9FRXi1CR7AU75cdYz6oVkgA8Vr6RK0
 krnYk8arx1oSJg4MF3t2dH6WSu07q+LBWzb8CR4OGrn3Fl4nwRNMKg5mT4hW65Kd9VVu
 FJH30MZzd3r+INxEun5HxI+tXM1X4irQfk7ze9JNz8Zc6dNYJTjYKZXRNrqCeAwFtUcA
 Qwgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrLOB7/9CT3+zsOw125vUHiwaZjFwZ+a31vKeBvfujqlj8D3gM+SlstASKs3Zo4AIhXWt84U4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6QlY5csUZT/uAgnJ9TRzLlIaYgGSGs7NHI4SmPRoWi8eYar6U
 tIEJwjzY4N1fyIJjWRHYRsBBYzl9vWrfMVKmg3RQX1l1Csbi601pEjNxCfA1+qJ516qzaW9Zmfg
 SAjXMGxk9p5vZp4ge5crIuXc62blCvVQ=
X-Gm-Gg: ASbGncs/KTEHg62dxIa5kfD9Ax5dT7aPuBbUoVqFw+lPTsoLXrFCi4UUmoUEVe2hJin
 1jXXISlTt86pKBxtWmOiTW5NmnAFxAXsVfUQqBKqGyDmsK0Nm0e0cY3YpmZGw7L6uXhuCIzwJRm
 KaQqqnVhskso0M02jbkBG7KQOyXB/Cp6DwWmfW7M3UtzpYFYzdn3lhairJBDpSL4WJ6LzJCddgZ
 ckpZihp/qzC5SCoKCOqMDntTgndAKbyLM4auoQ=
X-Google-Smtp-Source: AGHT+IER8fDWLUlxfiH+6DZ8sVBdI05zRrI+nDWSiuHjT7XRNv8jfskxSuRiNmovS9plNDPfVOZXFljr3CGAoxFyI9o=
X-Received: by 2002:a05:6512:4608:b0:55f:61de:5359 with SMTP id
 2adb3069b0e04-55f708bcd00mr5933285e87.24.1757079240860; Fri, 05 Sep 2025
 06:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250902-imx8mp-libra-fpsc-v4-1-34836a7086aa@phytec.de>
In-Reply-To: <20250902-imx8mp-libra-fpsc-v4-1-34836a7086aa@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Sep 2025 10:33:49 -0300
X-Gm-Features: Ac12FXzgEcQqaquqE_kNxPYaxjy_QTIjiKh5osDsSdJws-ryhP7W5c1BEEifR4E
Message-ID: <CAOMZO5Ceyn8nJ2iTdRti9B26p4iTLj5q5hJjX=8B8=vSNAXPZg@mail.gmail.com>
Subject: Re: [PATCH v4] Add imx8mp-libra-fpsc board
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Benjamin Hahn <b.hahn@phytec.de>, 
 Teresa Remmet <t.remmet@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Tue, Sep 2, 2025 at 3:08=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrote=
:
>
> From: Benjamin Hahn <B.Hahn@phytec.de>
>
> Add new imx8mp-libra-fpsc board.
> Bootph tags as well as USB device tree nodes are in u-boot.dtsi for now
> and will be removed when upstreamed.
> The Libra i.MX 8M Plus FPSC is a single board computer. It uses an i.MX
> 8M Plus FPSC [1] System on Module which utilizes the FPSC standard [2].
>
> [1] https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-8m-pl=
us-fpsc
> [2] https://www.phytec.eu/en/produkte/system-on-modules/fpsc
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
> Tested-by: Teresa Remmet <t.remmet@phytec.de>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Applied for next, thanks.
