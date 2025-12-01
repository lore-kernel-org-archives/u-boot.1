Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B132ED116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3718A83C65;
	Mon,  1 Dec 2025 18:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D2/ZLUqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9365F83C93; Mon,  1 Dec 2025 18:17:12 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FA883C01
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5945510fd7aso3624870e87.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764609429; x=1765214229; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAO1CmvcMj+B3GPpmqq6YE0kf1S1H296jaFadoR9AxI=;
 b=D2/ZLUqd9u2zHioZTBLXwjrqdGWe2t/JISBzfp/lAvcMwHztolfQ9o0PPBq+lf1Eds
 TOO38V7Gtrf6tWG1kdYqIOqxMzTpSk8Qq2Vz9t1NK4uGUL7KGe2kUa8Bi+P3xdBiAgS0
 ytJ9+RNNlCRdu4962wFAXpe4PYL77lC8CsbxnCD4J4vqDPB0S1JXw4nK25B8I7TBmI+G
 9A2goAz2Uiqe02LUXcL8tt0TYbRs0gPpa/hfVb94WQljmbHYoTi7kRBsElwZ9D/eTnSg
 iC9D1LFVEG1VYiqZ9nJigsD28Ik3D6K3JQuOsulIR0w9D4SYs65G+Fkl2ZQ/Bp94j2Xd
 p57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764609429; x=1765214229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iAO1CmvcMj+B3GPpmqq6YE0kf1S1H296jaFadoR9AxI=;
 b=Ppv0xgigASTubzK1mm7ieatuZsqLg8ppgrrdg9OLEZVk6mIynoDd2UiWwsDBq3jm0N
 aBOQr3dyZlhzs4Ihv/c1NLAcsGrlq0RTkzZtnT+Dv8gx2t91NX0/q6UKUSw6daINy2vx
 M/YYizXYPq6U+m3s5cHQy1LodqHFEMvEtpZwBDwd6uao48SIj28dyO3eP0V3ZQwAQov9
 0H6ZTZpux3t9+sV6Oz65mEgsoIkzj/duR4rxOaGME9moHl/oz4RXPHMrSfvolnDe8xfO
 opgxSJTX5NJJZRtJ7dbABIqstU3qq8V0Ur0J0loO+VkOBUlf4j/R54/AemvDP4j2V0M1
 /9uw==
X-Gm-Message-State: AOJu0Ywr1kqjNiAmO+E+vcFOlZBLwuF5ngJXUXFR4qJSZr75+qekNn7q
 4+m2ZXgrBqP4CMWzCklSLqCFr4ENGb+lD0U66DhIaTedmsTbUL4Wwbqd5/4yHMI9tfTWIyz457b
 wXdu+TeJ5LFMSxXlFds3scTayfS4QV70=
X-Gm-Gg: ASbGnctbZSxd2qTWD2LMgkfQmXdfmyeUvomFVQbJ/2ngXOQgByBDOWEIpXpe91M9SPK
 V3jCKvzcQetpmm00ZUDSElC4lQO8GhHu8Rr9tYcSIDpc/wokJmLc6rlGhtpTWavbowPWbbsohLW
 8URXWV4NLbTCQS5Ct8b+8Gzga4gVLyMH887HXkfD82ADOrgY//Aa/fzC53OFFflcenuLFh9Q5BM
 fhpz0dMFo3PIQBUGVxHP/W5EKAuWMTQq3kgWprcptIO8tkd9u1YgJO6HnaJ/f4aFUYg1jfdQ0Ft
 qncwdBzgJBoXNI5I9NzrhlDA9w==
X-Google-Smtp-Source: AGHT+IHxd35Aajjsa/p1p02FxfYQW1nTTyhQzTJmZBQMy37xL0XdoEQ/bonK5BC6OmHuM9aoUfub0IC2fyS3RD2yRLs=
X-Received: by 2002:a05:6512:3d10:b0:595:831d:2308 with SMTP id
 2adb3069b0e04-596b4e5298amr9904560e87.1.1764609429114; Mon, 01 Dec 2025
 09:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
 <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
In-Reply-To: <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 1 Dec 2025 14:16:56 -0300
X-Gm-Features: AWmQ_bmnlj1VE6bjId0nL5rNYcYuLA6kx0KlxnXdSYd5RYyqFkPmoj45W2FQZk4
Message-ID: <CAOMZO5AJerYOAURcsWEL2ambMNBGTbp3akhO6dVsYRzLAwRmAQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] board: toradex: add splash screen to Toradex i.MX7D
 Colibri board
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Thomas,

On Tue, Nov 25, 2025 at 8:42=E2=80=AFPM Thomas Bonnefille
<thomas.bonnefille@bootlin.com> wrote:
>
> This commit fixes the PWM<A> that was previously used as a GPIO output

Nit: don't start with "This commit fixes the PAM...". Use the
imperative mood: "Fix the PWM..."

The same applies to other patches in this series.

Thanks
