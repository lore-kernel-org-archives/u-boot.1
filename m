Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA49C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236D2807A7;
	Sat, 18 Jan 2025 08:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXTS+5lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0340807B9; Sat, 18 Jan 2025 08:29:47 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 169D5807A7
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so470118466b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 23:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737185382; x=1737790182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2AmFxt4+aN7bqCGwSgc6MOH4S2fqgDX+AG+SrwurYI=;
 b=gXTS+5lOBEvpJ0jaX9D5BQgvkuW6hV6KQiK4WLAx4P05hulw2KcLy/HR9H7DApEPSF
 SAZ5s+r98gFC0vEnrpdvD2esSOdhmja3t90vdCGoC71e+/FreVV32n9/fAYBfR9uoQP7
 RIwC1b7/jHhYrxHvctWPISPtOJbkbPP+DNU4/kn/l0CfsawsttDOB7JT+MYniinCctoO
 MydjMOs07Ps6JEP1p6slLt4Eq+NNMFGhkkHozexY8mrianhRF1xtaWHQCrlE5LNIhXsY
 spdotqNaoPyRgE9WuSNwXKyht5f6bHWy5aG5phepZuj4fz26iV8bOv/4dEnb/OjKvzxM
 /LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737185382; x=1737790182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2AmFxt4+aN7bqCGwSgc6MOH4S2fqgDX+AG+SrwurYI=;
 b=Zm4yRzngSwBsyUUAqxRo3VpdUkSwz9Fu/MO78zDJvVvmzHocIJCsLJj+Z01ouEQl8n
 ASxCGtsWdbs8Nxwg+3zRvsa5BWNXWMnhssxIc2HjgUf9mF4f4uYvZvDkxcThYWS2ARmK
 AqI4vtzBpbpoeJaRkmt/KRRMccW+qQBdI1+UDAx0Oo6rdm5aTjJXkC8nK8IyA51litiF
 khRe8PhYXhdpdKWHaVzAj1AdvJy/vUAWbnEkYch3Yu7E+c40hOJquQVI+1/IOh5P8Vcq
 Zx+HWh6/ETKT/D86LL+kkWOXj4qWVnLWS2b0DzZxjsO+tl9SWIqQ5i78ZWD34XFB9DWV
 qNvQ==
X-Gm-Message-State: AOJu0YxhLsSjZg5WuSPCj7YnuTVvTdU3vmNSXHEMyLUdV33zt736V/ms
 cQzSFYRrzhZpIyJkJJGbd9HfdsdgtSOTu/MagIEqAX/HeQde0uWNAjI0vA==
X-Gm-Gg: ASbGnctif2qhqsq1KVENfAZHIbzi+n8IVEIpp2ECS5LiGoHgLy9t2xBFBAUzsKv68nH
 OEU8+FAB4YPYh4InUaxY8LqoCm9TWkevIBRghCuZRck1PjHOU9e1Q9c+/go+TgHpNSyVlsfqAXQ
 GvvSS4WcbD7ExK4pqr5tAAtlHytonr+ocLHsJm5x3bMIVbXRNloRBb+SsAef+0hK01NSOJpWA4c
 jzHF/eBbasM3woQlQL9jGV0EyrXJf0LAJjT9Xsuw6ueIWajX1GDbhnlpOrPMssz7ntttqZF8rVK
 ip3XR+H0UdFnINE=
X-Google-Smtp-Source: AGHT+IHR7qTc96Z2y9tFOwncSihKZnT4bJk0zyDZbwWCUnNXwUqqYIL4r3LTH0yl+gNfwdEW7rerWw==
X-Received: by 2002:a17:907:9408:b0:aab:daf9:972 with SMTP id
 a640c23a62f3a-ab38b29cf07mr489715566b.28.1737185382455; 
 Fri, 17 Jan 2025 23:29:42 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384d2e519sm290242066b.83.2025.01.17.23.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:29:41 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 6/8] power: pmic: sunxi: add SPL support for the AXP803
Date: Sat, 18 Jan 2025 08:29:40 +0100
Message-ID: <8475686.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20250117014537.22513-7-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-7-andre.przywara@arm.com>
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

Dne petek, 17. januar 2025 ob 02:45:35 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> The AXP803 has been around for about a decade now, but so far we didn't
> need SPL support, since the DRAM rail was wired up correctly at reset.
>=20
> Now some boards using the A133 SoC use the (compatible) AXP707 with DDR4
> memory, which requires the SPL to set the required 1.1V voltage manually.
>=20
> Add the descriptions for the DC/DC regulators of the AXP803, and enable
> that when CONFIG_AXP803_POWER is enabled.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


