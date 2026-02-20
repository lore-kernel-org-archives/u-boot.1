Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EC2C5AD57
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 19:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26F183E13;
	Fri, 20 Feb 2026 20:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s1hQrklQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F187F83A5E; Fri, 20 Feb 2026 20:34:05 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5455A83D8A
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 20:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45efd53148eso817984b6e.0
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 11:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771616040; x=1772220840;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SfjY27V8wF5MpxGx0b2sztCIZmCnquqUOrP+y8kaxUc=;
 b=s1hQrklQ4ANlgUbwrcb5Ekj/N4mSa0sPfiteSepWSbNjeuuakhsNQTUq1wm8YRHZD4
 upuBkVmVf+90UOuoR6PvvRuXH+tJ2LbkKPEQHYdR7lHMS6kDHiG7VzKqJQyf7xGzEX9y
 nMNWvZ3MtpIAQdEytSjvrB0tVEeAM3b/dF0KsirahSLamz8UrPUTCs07Kr3TBtw/m5PS
 Dl4a4U3S3rNY+gTDHHkzjPev6MvPIC472W/ibzE7jRNMOcouYXuxgZgJliA9RZmVziLa
 ESUM0C3qMhcTG91qdVV+Hw6rmTnw7dv916iJrmOH+M77CFN84N6ElsiXTwq/mYmCbIge
 WnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771616040; x=1772220840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SfjY27V8wF5MpxGx0b2sztCIZmCnquqUOrP+y8kaxUc=;
 b=BqOEBUMi9bttkAxx7rLfJ2CWoXJx6buGbCVpUEMhg6DpIJ/aKTRQJGl4sNt4xGGBfe
 3oixwTKfQK5uDMJX99CqkShDEfIwlXeCjYqWVCmqfFTS7vPAzNC5iqNqKDJnbUK5C+1L
 LsH1r38R90hxOPZFjurn6No9LiCXdd7osWe8RO9yTUXiQjdI8tcoiiFLtVpy39JFDzDa
 rX1t49+G5AsithSyf1qR+naifwQSs4flrcFF5L9GGKz37VGEJBbXQs+6meeMf/13rsE2
 JcUr3iMGLkeeptT2ivE8qkHfyv94cuEgUyB3NYu+vC6KBc1icidpEKMtNd66Ry2sHMBe
 bemQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU21PoiS5Ig2aGqSW00i+p3kvfanV4UfI4EUYB9mlposYCOdfEQtBQ7+6FwTVcHMhMkgku813c=@lists.denx.de
X-Gm-Message-State: AOJu0YxB1QBFLwD4/AqAVVun6KTMBMg5y0D5crEGXVgF3WrOBct2nlQ8
 NrK/rD771eQ048ASWhb65rUqn+FjJTPnifQqE5de6hUFIXyycmZvbq+NobCfVeotulo=
X-Gm-Gg: AZuq6aJ753EwPFsH+bLzjbBQfNQoUun/3X+onLZ1fuAQF+19ygvJyvJkaZm4J8vimlh
 1m2QYYB7Cv2iFzX/PEYZskyGHCCp3vPiJhhsWua56UM8wdGvCZiFx9Y5ITtB3paVm7buHMIsV/h
 9YnaCNyB3A3RJ04N0OZ1jTEEkNrpgayqiSTJUXYo1RrYVmvDAx+aTE5GaIOF9glX++Jdo5YCcFQ
 eV5yNVPUGPHpfQBrzVROIXxd9WrMTYnajmECmKTJmuGe4Ozol75+Qw8qMv2JqMgwIAaMxBc6h2t
 c783wnAoDvA2P2WqETV8kkHlRtn3K0LLwwoj/8ixfuDIbB26sJ+URZCYDeyfOlOBB0LSB+LJbw4
 giqcbyKHkBT+OskBHe8E+3Iw6kvm6zLExVoy+9rHoUGbIiuGd60WlRLEvgy3WK6HzRG5b+8lmjn
 wSBZl0Qwg0oAZZu9zGbV2AfQpJJ08=
X-Received: by 2002:a05:6808:1c06:b0:45c:8f03:1e18 with SMTP id
 5614622812f47-464463407c1mr565267b6e.44.1771616040019; 
 Fri, 20 Feb 2026 11:34:00 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:339f:eabc:8753:3aa4])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a012dc7sm52370b6e.6.2026.02.20.11.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 11:33:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Feb 2026 13:33:06 -0600
Subject: [PATCH 4/4] configs: mt8365_evk_defconfig: enable PMIC and regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-mtk-pmic-pwrap-support-v1-4-a345ea3b4294@baylibre.com>
References: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
In-Reply-To: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=7FRoNE+VOJiLvDs9UTTbD05iohxQal8vD86PAe6EgMw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpmLcbLDJLKDpdt3xnxUA9uEgQJTX3wzqV2yPh5
 m06zx+E2MuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZi3GxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AxRoIAILqEBOm+SDC6c5xGZ/RLubTXR1sPR4E7CeHDjO
 VFtiN+Tq4C5cAca8vOOflNL76PgCG7U4NrRbdvLgPMOYzHzrR9zJkvxDW+ys4qKxyussggUKk+5
 FOVVccvzTaoMJGQA/wkb9WiKTLeDeWrCRTngZy9Ynt1prBENMRqSR6m3MS8IwzBbT9Bw/cQwGx7
 9ZCKejoQuaxF/PBC++Y0x1k3Y+WOeYgTY5sAqg2hk+CLrLy1q8NSgiuQWIvPjzwMKGxzVx8sSMU
 +oZjx36Zruo6GWEGecwlcMxSBEuZPGlGLlrvky4ljodsyBbIflLB9h5/dZT9lGaWsNmBh0D3OCC
 h5do=
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

Enable PMIC and regulators on MT8365 EVK now that there are drivers for
these. Also enable the associated commands.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8365_evk_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index f1e7d7fc58a..9b403cd7aab 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -15,12 +15,18 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT8365=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MT6357=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y

-- 
2.43.0

