Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0057CEFD19
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D2E83C62;
	Tue,  6 Jan 2026 23:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YMyvkIbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FFE83B32; Tue,  6 Jan 2026 23:05:56 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC1583935
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4507605e19aso1005551b6e.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767737153; x=1768341953;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d9QUKxwq+zRcwDBAMaaNzXmLAMqnlPNa851RGtYR/yE=;
 b=YMyvkIbFf4RRmdhDZ+NvHsQ/F73WeUpPY6jAmCDD+ymUdCN1J/ACOohzk2MzF5p0/P
 +npiGQaL+F8WF6QKY+CGG10d8xWSZ10wB0/N6Jq2y+5500WgwFEmkhi11zjz+DDcIVcC
 QU7EjAcr/6AdTT7Tew5W72GrI/FPh1/MgGDdqQdNCLUBZ580H23HewGeGSFfXwwzKnMq
 B/bIxhPwM7I0EGY8vJjRWTXSBcbjQ4KT0LLH9PWZQtyKPR5FWwQVYgXmJiwhky8qqmLw
 RWbRpBs79b4PrejcsQPh1G6j8TPZrchVYprtfnlaSQs/RhxmTy8MuixkBtaF2v1BDK3f
 3z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767737153; x=1768341953;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9QUKxwq+zRcwDBAMaaNzXmLAMqnlPNa851RGtYR/yE=;
 b=VnKa9aR1NRLmjVbU2O5yVvSQ6nq2JHaAQk206NG8y78qWRrybOTSJym+g/0Q5tt2kM
 g3DlVHqLXr3LsmP0uXmOMFjwdSF+MxfSeHMiIGwR7eL+BQjM1X1CFvzgAZHALUEwcLZG
 f0jY31FBalw2v7VzbxU+7BHX294Bb0ebVq97Lw6q+nZEfgVFWIQuMJ4FKTTsCIGY62gn
 42p6idnHCYB/MEMXJrBszTY9G5cPBQH7TPyjDIOAuXFvJnjj7omNMiLBCLhMQcE2sbwc
 K/9QDv+bmqsh+yO/F9lLN8wCMIHnmTECr8dHl2Z9pnvNbkZv/uosW64g7N/5biiHdjQm
 Hd0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0c5UHdLzhLXlptoNazQgpIKoKRfoXHWc8/SCaY99fQZi00KFfNtdRI2b0CqurZO8UGHXMQa0=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz2EdoJavlGuBQO5Mal5bpx0upqll0OTF12/WFoeha1GBnsUeS
 1oWUuKd/acFgT+9G8O6oHJ1G69RrAYbEBQ32E6cXXq0y0rFDIOHN+MkZkH4IaURGDg4=
X-Gm-Gg: AY/fxX7VKj089ws0y4iIT6oiReatGG998aMiOgvVL4l4EGY/NZxn2O8yfHmyqmDSl62
 M5DUyhU2B5H8pFWzVeVhO0LffdmhyQqf7OU/l1nkaU3iTibCoweOlf67mjKox82M9wbhrYYwN2D
 YJx3N480QiMETEKeZWXiWrqVTp61fo2lsVk5j5PV3/3qiyDPJxE9Ki0wZmUULsY2sZLNXYvvIFE
 vWmFwjQ0rS9SYnJq7NWtWMJ3kxUZthEKKsnnfKF1UNIWSgyTOxWCY3qqo0LjjHs1MN0W5lCLqLH
 WTWGrGswq5UNFckXHCXVOjDAFIQvqORgHWXipecB3BcEaLZxcPWkybqm1Z33gAh1bdTB/D1+vJY
 y4Bkb3b+UnOWDkmKSKevmcubwJL/X0ZgTgj2Nug3x3xNJ7n55RO+JGiA40/aIL0BzjFJhEutFbk
 8dH/+CnZ41+N42HdE=
X-Google-Smtp-Source: AGHT+IHNKUDGUQQKe0aFSgncrHYeSz4pKJxjBm9R4qcg+lKqdb2Po5ww0ISdIYxtKv8SoOjHz1VrSA==
X-Received: by 2002:a05:6808:22a5:b0:455:daf0:9951 with SMTP id
 5614622812f47-45a6be89d1bmr205008b6e.47.1767737153298; 
 Tue, 06 Jan 2026 14:05:53 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f98:2205:4ba4:3e65])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e183916sm1575124b6e.5.2026.01.06.14.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 14:05:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] pinctl: mediatek: add mt8365 support
Date: Tue, 06 Jan 2026 16:05:18 -0600
Message-Id: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TtisRPpKdLDaaqlMNCIQ/550m
 MMcZiIE8kwBuiKCp4cDXzZLVRYwbcauJHjODhKlwgqVcGyn+xDnvWd0rVqBWrZUGxwbaSB3ztP
 C7//sh5Q+Ak2zbWMAAAA=
X-Change-ID: 20260106-pinctl-mtk-mt8365-0825e3a0b42a
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=c2Qne8L+oBi08eNBqP+hD3DFVnijMgQIJ3Lc43zFAaY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXYcmwc0c3+dL0KTJXjqEEMuRMGmoTEkbPyqke
 Ee0E2UZqCuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV2HJhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AULQH/2JGyvPSFMiRSsD2gY/gUk48AjVfbTXaLxvZC4o
 ulrLVohzhSyu2Vig0AP/4rIT72wKpU5SMFyg48JMjDbZAGsepe5zeDfYKYW9M85y6DyCGGdQ80a
 /np7pUR+8kJ27TjxFRC0jcVYSfZe4KXed9peZh0dmWyOCrdKNB2qsrzLLMUAUzljY+jLEl1gSkW
 PBgJ0DvztYlU7wjcH2raqxrg9Fcl8PzLnZ5I7FZxhxkh/e4hGIckVz+QezOZWHpykTbUQSwp/7E
 0zPVQEaOxyaQnbt3wOtcSVMsPdBQUzTXpLn4u6+g/qbWPEHfzbX1MHN600RMAfCLzYEziYIDl66
 9UT0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 06 Jan 2026 23:57:11 +0100
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

MT8365 has different pinctrl register layout compared to other SoCs in
the family, so needs its own driver.

This is also the first SoC in this family supported in U-Boot using an
upstream devicetree that has the mediatek,pctl-regmap property, so we
need to add support for that to the common mediatek pinctrl code first.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      pinctrl: mediatek: support mediatek,pctl-regmap property
      configs: mt8365_evk: enable pinctrl

Vitor Sato Eschholz (1):
      pinctrl: mediatek: add pinctrl driver for MT8365 SoC

 configs/mt8365_evk_defconfig                  |   3 +
 drivers/pinctrl/mediatek/Kconfig              |   4 +
 drivers/pinctrl/mediatek/Makefile             |   1 +
 drivers/pinctrl/mediatek/pinctrl-mt8365.c     | 469 ++++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  38 +++
 5 files changed, 515 insertions(+)
---
base-commit: 6488538bd8b8dfb0a22c6eec0eca28e5ae27b989
change-id: 20260106-pinctl-mtk-mt8365-0825e3a0b42a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

