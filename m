Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A485FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DC9846F8;
	Wed, 29 Apr 2026 10:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cEDclRk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56643846F9; Wed, 29 Apr 2026 10:48:02 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974EA846EA
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso63425095e9.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452478; x=1778057278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzPxWkmT+bKORN0lrklHH/odmXNU8lP5Aj1TrOAm4BU=;
 b=cEDclRk4KGZuTej2pV7jxo7kDuN1cm8LDHfP6x8LZPReoeF8goXPSq6nf3597Stgyx
 7lWFzUqw64MnE4aPVBRyTs3fgHb8DRjwBas0+oaIyFWpz++4+YO3XPee/tZOUe6ZO/Tp
 24jAt/cDNRE5fRLsjGko9aWsGjCLwq2xdDLHUeu6goEiFEshAWywJ7DjIXRQtYScL+Aq
 ClCqtf1WG7oDsxpgEmLNpMXps60ZPp9k0Bjm0pvD2S4xIUrJD76bijRextOOSpuCbeRI
 TLXawwM+l37/PJxCSCyhGKEt+C35fZp8s9rz9jiIqCj2qJK/W8DH82lWTrXpVREIRzOb
 k4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452478; x=1778057278;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TzPxWkmT+bKORN0lrklHH/odmXNU8lP5Aj1TrOAm4BU=;
 b=pHOIRX7+a2EWlXU9LM/qKx3sFV/XXvuxvKCkZD/Qmg6KbKhXpcA+Tj8tWnYm2Lq5ft
 qjs300IyjQ/F7jnPNfrb9CgQ6yB1vdqN3mh+PAFrYFyRqwOj1lhmel3SxXKLccQsVN6X
 1TRCTu17U3nTu75ax4xATDc8LuPNj3LXOgodtFKrLuJ2FEgoxWI6ZO9+Mj1x8YLWyS/j
 ch5khW78Ivnn2lt92mQrO6bHuHjQILZKwM6GQdzYa500bOReC1rFAsdxhT75I9uj6F/p
 wHCdQkngYxMCMd4pC19XyaAxwI4nGLk2gpppCMYDHTKlMeWCi8gc0nkWZnXAS6dUr8aa
 WWfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/01UbkNmLOygSoAzWK3Io0dSRhBD8qFb3/ukXUSp4+GSGQBgE347DH0hoHpDQvOxdn5mRSxPI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz8yAdwNDAJbt34fLZbnAjbl0ByhCFOMVP1zxttUIL21KoAvrk
 KW/WiTmCWBQ0YXo15wnoVXG2Qqmm0PAOvOw7FokpQVW1In11nMWRYmVzLFsf5YfLYMs=
X-Gm-Gg: AeBDievZzKggCwfyePBlZApebj+gerhucSfcAyjZZVNgqWGHidOMY2vAsGXGijwcKQ6
 hkLJMqHBtO93tGXpCPYUbUnusgfE/9T8w6hLcOHoBbAkG2IQZRYy/dgpTAjna/VqPDxwMerGLlw
 JQX5Jcx7evfMI1Hq6/Hk8m2J1PTFhP8sPdosu8KjU66X7/wQGkVst9vxGZydkjAuDb4mNTQCpyP
 i7aBRHwQDA2OFv6gP5AOOLsr0iMbzT4ErHFEiEuQn2LTMkCcAszbhFNhqD87wKU0qwBSFlG2t+5
 rrxz/ubuvu/1TRpYp2G+TcpIMNDerP2IJi6onwviLyy1e7U48rLkYeDgBeRIaqzxDFJOwIzAgaA
 17sRGaF8bKaPUN9kwtrYOMLAdsxcqmMt04ec6B0rJBef30UJd/uPsPi9GdE6q03Kqjb7ahn0844
 kfuBXKkc/61I0vmcc0hwGTtAK2muXSqbL+GSWYkJzCzYXGrZWHiRiEtV+MrxD8lQgBUVBjIhYbx
 mO/YUs=
X-Received: by 2002:a05:600c:4790:b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-48a7b83f121mr27456875e9.4.1777452477819; 
 Wed, 29 Apr 2026 01:47:57 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c2e8a6csm20907375e9.5.2026.04.29.01.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:47:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Luca Weiss <luca.weiss@fairphone.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
References: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
Subject: Re: [PATCH v2 0/7] Qualcomm Milos SoC bringup
Message-Id: <177745246465.126665.4670703580585777068.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:47:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=bTYQU2I8I3GTEXkM9ld1VCOW+HaOeEe5QhZQKxOU4iY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPR/cIip9pqiu9v/pc8OsnEuZHqmau8lz1ZEKCO2Oqt
 Z3r929POkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEmmQZ/uk2KM2br+XWvFnG
 5H/Gwb6Txpxz69JWTd4X3d7uzT/7yxuG32x5G/KsWH9Pj9h6Jkq5yuC69dElTFbHnhz4wZH78G+
 TVTgA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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


On Wed, 18 Mar 2026 13:46:26 +0100, Luca Weiss wrote:
> Qualcomm Milos SoC bringup
> 
> Add pinctrl, clock drivers, UFS PHY configuration, PM7550 regulators and
> GPIOs to support the Milos SoC in U-Boot.
> 
> The milos.dtsi is part of Linux since v7.0-rc1. UFS is still on the
> mailing lists but parts are slowly getting picked up, so hopefully v7.1
> will contain that fully.
> 
> [...]

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/7] drivers: pinctrl: Add Qualcomm Milos TLMM driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/09e14e095c9b
[2/7] clk/qcom: Add Milos clock driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/386b599bdcf9
[3/7] phy: qcom: Add Milos to QMP UFS PHY driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/2a30866fb2b4
[4/7] regulator: qcom-rpmh-regulator: add support for PM7550 regulators
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/a723975b9825
[5/7] gpio: qcom: Support GPIOs on PM7550 PMIC
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d97d7e8a228c
[6/7] qcom_defconfig: Enable Milos clock driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c490d70cd13c
[7/7] board/qualcomm: add debug config fragment for Milos
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/34266280ecd7

Best regards,
-- 
// Casey (she/they)


