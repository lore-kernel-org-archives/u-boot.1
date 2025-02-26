Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85427C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 15:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C0780FD8;
	Wed, 26 Feb 2025 16:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wm8HHmCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05ABC80FDD; Wed, 26 Feb 2025 16:55:04 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE02380FD8
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30613802a59so72523701fa.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740585299; x=1741190099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9gKOzRQdvZ5hZZTklAcm6Yhtodv4eS5i1XSa+zbnUo=;
 b=Wm8HHmCn2Fra1cetwnap6ke1YqVZjS2bv9Rrsw77fzpEKL2gMTR4fLpyBnE0M0E7Iv
 TcyBPwxzwK7Mi2ybN7QtnDoNR8D8RzF5Yv6j1jpwjzoI63lqc3JItJ6EDVVi+C9lYsQ9
 EI8v2zR1ys3MLINRymhiln4PD/CKpRDWotI6ClSLIFI+iC81Pq1b5hgdWQEUVKR2ItKp
 PKqOMDNLYSArj9/sPnIHlfPH689ZtGZrgPTt1yjDVAToh7qqjEHwFXmTvr3Uh6SQEtW1
 mv+2WMOit5S/JjT3mkvXR/rfoYgv+TyRtlGq6frB3W6kiWj1Z+WjC68GvoSftEpO+cC9
 ajfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585299; x=1741190099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9gKOzRQdvZ5hZZTklAcm6Yhtodv4eS5i1XSa+zbnUo=;
 b=h5EJu6teBkHWoH10kX1x8xPE65v2sXd2Hn2o8QWjasYq+X9ij+WSurG9W9lwP6UIev
 u0rd/84h+8pcwn1bZnCfQXFLyLIrURWaJ2pNVynd6XHZfRw9wvf0s6u5PL/4MCWvjfWc
 8ksXwv5CRba5CMkldZRhd7mAxOL4s9A6SyVRcezSLYlwpfXjp0tII+jZp/g35acV7aoe
 KR0UuYu2LAxVhlb+xvX9ggyCAkCDa5ajzbc9YAY9HMnuhL5wEuJNHfcp9pyFaYd8JWwf
 VBEY1flzjlH8fK/Dq+3VN58COpRGBNFs+n51SuNI3qR+qzC5bHqucrS4cyrRJ3fOy+Hq
 J6dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW37VofOxvVJeWrTV8lg0eisRb4qFGxiW/QZT7mzjFNWzW/HrhUbcAFRDl8Lg2iuvaXIniDe1U=@lists.denx.de
X-Gm-Message-State: AOJu0YzhAvOXk90VjT8rIVFPLmaD180Z6qyoxnnnhHxxU6AAJHwJvuQ+
 rYx4hT3GWe5h6Pf73+7sp15k48xFJKkK4QERll60pvBPomL2F3I7
X-Gm-Gg: ASbGnctKLeSKV0yGZuCicMGlc3ASxPdJUU6RPy61U/j62OxqYCRcIOCQ3uUtuKegj9N
 rfHrUCykiKWtkcdNVdzPt7CfCg/Bq5nwnHgRXc4ydQ8gkeNWypjuRvngTa6TwoomepxslDu+OO+
 EA865Ip1fVxXh8my4yZgMNYRmatNR9HKBfSNxdJzqPB6J2KPM+bwM7xUX77h7dV4oQ8q1B98R4F
 uadCgdL/F4sWf3RJkHTsBP5NRfxdyHoL2fdbtiCdCIbO4Y7LURGC/Q6suQCA4yBxCm1UUJgvjoO
 RBh+qyhYqOxVeWiLeX8oV9bJe8QP407so9VEg0bVuBt1TnSTIK9r+ORqxXATrmjmMz3+E2DHYaO
 Gew==
X-Google-Smtp-Source: AGHT+IEQA+JhhfSXzDdcoMLKHiv9fXBQO4q2Irw7K/uICkwj+f3JfUMxR9uKDiFP3TuLMaH0IxC5qw==
X-Received: by 2002:a2e:6a13:0:b0:308:fd11:7700 with SMTP id
 38308e7fff4ca-30b79184946mr27165401fa.20.1740585299172; 
 Wed, 26 Feb 2025 07:54:59 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30a819e1462sm5709901fa.21.2025.02.26.07.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:54:57 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>,
 Kuba =?UTF-8?B?U3pjem9kcnp5xYRza2k=?= <kuba@szczodrzynski.pl>,
 Icenowy Zheng <icenowy@aosc.io>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/2] sunxi: sun50i_h6: clock: fix PLL_PERIPH0 rate
 calculation
Date: Wed, 26 Feb 2025 16:54:55 +0100
Message-ID: <1914474.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20250226113712.1257061-3-andre.przywara@arm.com>
References: <20250226113712.1257061-1-andre.przywara@arm.com>
 <20250226113712.1257061-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne sreda, 26. februar 2025 ob 12:37:12 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> On the Allwinner D1/R528/T113-s3 SoCs (NCAT2) the factors encoded in
> the PLL register describe the doubled clock rate, as in the other SoCs.
>=20
> Correct for that by always dividing the calculated rate by 2, except on
> the H6, where we need a divisor of 4 (no change here).
>=20
> This corrects the PERIPH0 clock rate as read by the MMC driver, and
> actually doubles the MMC performance on those NCAT2 chips.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Kuba Szczodrzy=C5=84ski <kuba@szczodrzynski.pl>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


