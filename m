Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACDA10F2867
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 19:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E496F83FC6;
	Fri, 27 Mar 2026 20:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OfCmIg/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C19683FC6; Fri, 27 Mar 2026 20:03:52 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE3AD83C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 20:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-41c0aae84e5so1769870fac.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 12:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774638227; x=1775243027;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QpijRvXMZLza+y9tsYI7jToC5F1U+gnnD3QUXIOp6Sg=;
 b=OfCmIg/nZe1QhorL3Dl+df4Xj/aGXRzp3mpFqe1PZL8Zsaw005Gttyp4nZMhYQoVkz
 7FfTSvdr8pfFVFmFd3KABe/xutkbC5IevlVjzrs7EghLCji64kfHc6hASTUsFzfuRU6L
 CCcFqHOJM8nN1tRdWwX2/F3wA3HQeqJksrvv9WHUcbNIducCztPIAGO7l412e5IneOXU
 7UsY0bwjXlxW3qHZ8SD29Q2OsgAQfZhpTQv+hwgvMp9vBmyVcQvqxxcYpUAztBkGmtaH
 kNflYx6eTiJ2sIJphPDO03ENDMeh7W76xXeMEuI3UV5ZIkByJEQjPk4zSrfdkcBDaJGg
 PnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774638227; x=1775243027;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpijRvXMZLza+y9tsYI7jToC5F1U+gnnD3QUXIOp6Sg=;
 b=AtpE6q4hBK8sJNqmzsSg+mSd8k64MSZ00dIikXRov54dj3XYAJSKZtbPd+GboGAqkE
 nvjm/iWFxMYyhXeP8ZBTEE5IcOLMs3WvbKkqssbQ+bmB8TneLX5YoA2/ar1xu0JhT/+9
 /FKepVu+RP2jjTt1x4igS+/opNYf+x72qjDiYTLFoRNMEQ5AJhqKoWsKW2xHb4VLdGtc
 GnbdsLFNzPdtQMSf8ukxPB2KQgEfODPDxfHYx7W92HJzdpN50GGO58oCvEyyHaI+Osqj
 DS7R4buvTfn2rNinwr5OBKZfzJAj43SGRQ+tlA8OML7dYCZynDseyrpBXPvMVBFr+oDF
 4CDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU3+TBmbGltqhKzUvSSOAZFW2B2lhmeUnkREQxqVwfzg3xoimgf0jExM0PUEZkYCf+73jty4A=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7AdB+8/ZFwrn1475A/HsPmvmU4fXn0+QmdcN8b4tlnYPlXWoX
 54oOG/CzRZtQjM262MJlafHSMCDrkhyqULJRwg7HOROzQVii2J9cbekAE6VWO2fdxQ0=
X-Gm-Gg: ATEYQzyED14+851Qbh8GPpGjRQX0ebCfLzwUUwtjryM2VoSGhAtwraBN1iI48HGuA6o
 phZfCUWSmUs/s5wj6pDwXk9K8THmMcf1+0LXwzJj/BXlzOVSIemb9xaG7lumQRowPql5HqfiQKA
 +CjOA+kGDD6TpY9sLPZp6RUhvvJB2Bf2WhMHrzlEQMjxA/xV7l8QvoDMellkv7tIkJIDvOwWzby
 pCItQeRMkYtz9aKoeTfOPI5DG/AsDZaxNFED7NzhGfCR2rkFNDa+HbGmmIcr3AUR5xIP2rSzeN1
 GAOD9WoOAwnjG2maWcOd5Om4L3xlMWlZ49EaxdlK4ja6NqZIPUXzr3JySg5A+lH9EBpM3cfYR1I
 mJ0pH4aAh2FH2/jLd4oDwyU3+a2HO45OI6etam9pXGNhDkVbbAu2plI8JSJ2jRfxmaFT+XGsZWj
 zv+YCb8ypyAj43dDQc6cvO7L7/y7Bn
X-Received: by 2002:a05:6871:4191:b0:41c:d06a:2943 with SMTP id
 586e51a60fabf-41cec38a694mr2289590fac.44.1774638227497; 
 Fri, 27 Mar 2026 12:03:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d0496591csm113534fac.8.2026.03.27.12.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:03:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] power: pmic: mtk-pwrap: add more capability flags
Date: Fri, 27 Mar 2026 14:03:15 -0500
Message-Id: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2N2w7CIBBEf4XssxuBRk36K6YPXNa6GqACNU2a/
 rtofTyZOTMrFMpMBXqxQqY3F06xgToIcHcTR0L2jUFLfZadumCoT5wCO7zxQgWdOunOKiu98dC
 kKdMvaM512LnM9kGuflf+jUyvuT3VvQbWFEKXQuDai5R55HiMtFQYtu0Dzr96F6EAAAA=
X-Change-ID: 20260317-mtk-pmic-fixes-c1523b1b0dad
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=taEQJJHfa8iEufi1MOIgpppHL848+kMOx2MyrD8NRQY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxtR1LGut7j1kxFnJ3mdSBmwyUV4NwlT+bn9Z6
 RMqI2iEgdqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacbUdRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aan8IAI51RRzPLh87txnAkc+eUmO9pKtUAgdiKXEKV4E
 VJrAwbOYLXVYLRCV7NzWy+e1yjzio/H5lnPdg98ldNzGjm+mVBeHrvqHuNXnPqPQ+g0+1hBnrQ9
 JWlP4i/fL8YC1uhro8sFpIGHwMkzESEOMwtrFUBoQmeazFxY7cewXimQMzJuUz1sQ46IAeBWOQS
 8+VsFylQyXBPf72lnP3u0hwdWi3BXXWraInM+p4wPBsLUNhLcnuPdztewNd/KsBumTgbJRk13EA
 dev7AT2Szy5TgHzaqP0JRAK5/YWtNIcWyymW4VGeEd41qKnI/dk/pEmJUF00xH5FVh1kk3WlAHi
 n9uY=
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

After using the mtk-pwrap driver a bit, we noticed that there were a few
places where it was writing to registers that were not defined on all
platforms. The undefined registers are treated as 0, which is the DONE2
register on the affected platforms. This could cause the DONE2 register
to have an incorrect value, which could cause Linux to re-initialize the
PMIC unnecessarily.

To avoid this issue and ensure that we only write to registers that are
defined on a given platform, we can add some more capability flags to
conditionally call any register writes that aren't common to all
platforms.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (3):
      power: pmic: mtk-pwrap: add init capability flag
      power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
      power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on mt6359

 drivers/power/pmic/mtk-pwrap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)
---
base-commit: 80a4c49a4ab2ad06fa84a8b7bdf6e33b3b5101bf
change-id: 20260317-mtk-pmic-fixes-c1523b1b0dad

Best regards,
--  
David Lechner <dlechner@baylibre.com>

