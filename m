Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F65FF5109
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 15:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FB08404A;
	Tue,  7 Apr 2026 17:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KGvx1ra1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AAC3840B0; Tue,  7 Apr 2026 17:51:50 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02CE83F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 17:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4042905015cso3284041fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775577106; x=1776181906;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssLGCJdLs76DkWjr2G8Witl0TT5ApbQO2ccuTt1ZgZs=;
 b=KGvx1ra1hYzegXhMi3apfwL4FK65p06cbNgOJE2zKvkdOPrTB7svocYt1XUz4z9u8I
 i/NRKWdExfzbtJOmCuQuZaySXuoP89iswqPHzzXhOnpDqgjHySoDD1P2Sd1FGB7E5U0r
 dcpnn8E2BcXSk+34GAj4iSS4dQXOTkk9l2deIJxgkZx3JfNDt0viuxrk8RP2qY2c5GlA
 jiEFk30ouNWfsYEgmr3iJofqLayy/VFe6WW50YhfOhb9p/8fwwMD6Yhva3g5uDD8F7iI
 rtBY2t9TAM2P2vfwwUWoA+HOV9qewMrTToDrW+JiDxLudLSuVXH4HgjJmRbWK0oJKTLo
 157A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775577106; x=1776181906;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ssLGCJdLs76DkWjr2G8Witl0TT5ApbQO2ccuTt1ZgZs=;
 b=gQXWw9MkZ3OsmrvRYwr2A8QT/KAoTMtzCtaUKcyII1FWoeXJs9RA7HwhGqR4lCgeBM
 PyVXPUP47rkMewNTUeF6Bahqjm+Sw2dP0C3CXKMIPEqqVRM53prqjInIWteNsKtR0x5H
 ww4jYoI86OwFPkzPCABlwCZGOlzVmNWCVxp0nSabnbWoVgwTRK5G1Ebxj365a01tm0cM
 63246iv2WzNyXMXPHFJbY9QceFbtsBc8sl2WLiPU/U2H11uWM13T1qDHrgHPOf5LA70a
 tVvqhscMQBoR4coV/DyN5FolcP8oXYQMxg4AeYC7mXWyBwrEWAsKr1mFlyIA4jMz/nuY
 z4QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9sKffjS18YY5dzwEXEQnEtdYSK0542ezBNQbskLpgBFivIFQmgq5JLPbn7zfsHWIPdTRAgT4=@lists.denx.de
X-Gm-Message-State: AOJu0YxRhcrTCBRa6BlA5YsyzxlR6lt6AkLDyuverIYcg+ByZM+vEjYg
 b7zIVuaKd+iuOkOTSwHgpOoIPH5rPyP+R/9yebMLBdWupPZZdU7kdyBv33prZtwVRQk=
X-Gm-Gg: AeBDieuJPwg0W1VngeMTg3yAUeiBdegnoXDUAysm5Ttasrpt2Rg+BbBoNTpEP7p6FCD
 xkuLRuz46uLNh5pA1H5c9+LqRBnqfamuSB+fgy3d+hle1za7IULhOKKZCe1aXKSY6lye9GZbVVE
 yI4/7Qxgoz8Z5AicFgFAZ/gknLpOvGnnnDoGi7Uf3v0yQwSy4LuAdSUKTbNnwn50BSqmEB7gTQz
 +oszMDShMyfTWLbgjzrS1REzPlMcDNfrZvIT3PZaZsLE9f4+2zhlsV44YwS3MTrPjA4wFrihJeR
 XNxdYElrWeICIm+6IJ650z71nKLoOz/5EKTivYyH/Yw4zY6JwPLJB+1ylO/1zTt9vPnu1votnH0
 unKwHp6XvK2X0kAtb/0KvmhULacy2NKUs0knuK/FPLdls+hqwbbNvtN7MEqniCFrDNlkicqC72b
 a7qbWGox3mflW/UA2cxlsNau7fvRex
X-Received: by 2002:a05:6870:ff96:b0:41b:cc55:c398 with SMTP id
 586e51a60fabf-4230fcd57b8mr9865375fac.15.1775577106336; 
 Tue, 07 Apr 2026 08:51:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm9550808fac.6.2026.04.07.08.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:51:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
References: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
Subject: Re: [PATCH v2 0/4] pinctrl: mediatek: fix mt8189 MSDC and I2C pins
Message-Id: <177557706092.837601.16901196602163566586.b4-ty@b4>
Date: Tue, 07 Apr 2026 10:51:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3qU2U0L08wwkK1H7B03evrkJ/PfxnfCbXUmObOnyxCA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1SgJ2ORWkfprveyzoRGoJlkKCw8DEVbH7lVNl
 dFR0ozQttiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadUoCRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABvAH/0lzof3uBJGddcGNsjm0mQzcRjwXJVWiXkrQM+z
 tjbCfzmVbJcnYMSqOtWy0Df5LfQyTGB5m2WKrGJKnerNfFWvLnACCLA6rV8lIxv7jlr3vXrkhNj
 Pbk4Vll0IsXSpFhoDZy3dfzwe0G4bn0JS43LBdGwwFSGXJpYwXAttHR315sBpSeTHY6CShjhjIc
 yPOfDjmuYtHzatWVGd5MYcZcoLCjrja66EsD6W48QAwRHKloDxygPBXxHNOOat5XrZOlK+b5QHo
 tM7X6GJMRRw73j9g5XnQ+ns2Sp/jeIP3cMWahPWz1SLXeZpl6bQs/LFEd1JxigDwXeHo7xZrnDH
 u8bQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Mon, 30 Mar 2026 11:00:32 -0500, David Lechner wrote:
> pinctrl: mediatek: fix mt8189 MSDC and I2C pins
> 
> When trying to use the SD card slot on the Genio 720 EVK, we found that
> the pin configuration was not working entirely correctly.
> 
> It turns out that there are a couple of different ways to set bias
> depending on the pin. One requires setting an RSEL register, which
> hasn't been seen before in U-Boot, so we add a new pinctrl-mtk-common
> function to handle this. Then we can fix the mt8189 driver.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/4] pinctrl: mediatek: add handling for RSEL register
      commit: 937884083ea8be579ac910cd9b9c69d15741aa12
[2/4] pinctrl: mediatek: mt8189: fix pinconf bias
      commit: 108e752b2aff29fa4f3fd141045a6cbaab389373
[3/4] pinctrl: mediatek: print bias info along with pinmux
      commit: 76da7482cf39633a05a3ffc2b3c77e9c576cb0c3
[4/4] pinctrl: mediatek: mtk8189: set get_pinconf functions
      commit: 29739f15c06ad59340fa638cf1af65567ea37e13

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

