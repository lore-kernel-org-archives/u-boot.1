Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03312C44520
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EABA84DEA;
	Fri, 17 Jul 2026 14:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="VcGYX0Jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F165584E14; Fri, 17 Jul 2026 14:33:45 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FCA84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 14:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so10627495e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784291623; x=1784896423; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=giZjvpxZ6mEEIE0GCG1w1vvaXpwPsS77N3eEBJ1unt8=;
 b=VcGYX0JzailCKxJUTR/HWFOL64bCDigZSQP9ajNPO0PgXp9257tDNAP/O9YlLFJWBt
 QovimUj/wh5GjTaEXeUoIzBwNldtBInqR4FOk0MKhl+UANqrMkSwOLeaG/k9+VsvevG5
 VYhA7UyvwQVUc3WPfbmshvtDB2oMUbbdcERHMWBAkf8N52jr1qpIExPTFu0wbq/CtyEt
 f88hCon2GWRJSKh26sktTgcQx1KMV9uPMMiAcH3Hm3+srxpkFVBRAP+sJCvTCfTmFvWo
 UJWVpJHE4Nzu58J+TK0WFRRsZNiNIoY6TmQNlYKUCSyc+02+02eOXdGI5rRTZrI+Yomo
 ZYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291623; x=1784896423;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=giZjvpxZ6mEEIE0GCG1w1vvaXpwPsS77N3eEBJ1unt8=;
 b=hRNhVXwYZJZOZ6RVsj8B3FFwP0d/sXFRGQSZp9okhp8rnE+vSZimIsNBGjJjd7jZP7
 I/5h4k4dQsLEEF3wlJmrLYR1/kfk+iFFKm1g/pENz1ij5UWNPNk5Yod4/laKcAMUEXV2
 tOnaOfI/z+T/jwyZuFxzm7vt0DsTXEJqk19RX+GovsFQcK8rxpSbInlCBLU5K13z6Ce2
 yaQ0GHWplG4gBytK+NL9ZsKMLbpJvNneOaLnUCh18ZzCMq9a8NZRcCRO82ByBOMp2R5U
 nFj4GGwR1Be/V0ipc+e/mhAz6qw1PvPewBAbSNwioDglcDriQRd9DCKnmCnMNuMV0B/A
 LpTQ==
X-Gm-Message-State: AOJu0Yy3230qXO3Nb/g9y/Z0fM+ZPrcp4nM0TW85yO5gpKb2RmOhgGcJ
 hWblOa5nRrJR8Ge6jX/DyVwq4ttltnIUc7L3l7u6t27EcUaV0oGoOxX/2oQyNbR3oHU=
X-Gm-Gg: AfdE7ck631LqWhG9EfYWfymZZBXu0cb3WDMHX975/MUmIUBiX8QhBPMDbVF8CcEPMc2
 Q7hYwKzD+ThLXxJcjWFnsywHDqQe5BKI5lDOhvTbw+p5hSL/WJrQ8RTh6N3NayktOt3Um4tUrZR
 ivN6T0bb+f4eE2Y0PgNgKnhVsSXmH01tVUiqYl73gRe59ETfn7D1aicj1NoW9ALyLvtWGs4I5J9
 cht6m7SV5+LIoABKDGXJwDA/uFAMXVff1HqlLbQM4b11mi4Bz4Jxr1TiBqXX2TjSoLgGj+m4yCa
 7yfX6uxN6F+99O6Btdf6HG9WuVxa7n14fBtKbJX0J7aoRhAWjldDpRrP8XRY7FY1YKBtunrMZHs
 WbwiYkyG8AxspxTLUjzF0FontEc4tW7xBq2TaGPaHGB/D/tx8iRyNQrG2bfNNjSVkLJCbwXoRmj
 Gnmt3rbxbJraLhSP9SEqF/fkukwXh8nGp1oBf6vpzw7IswiBNDxSiQmWIpLVzSD3WVm/NSKDrvh
 RZjyf9QjmkyUnxTGC+nfnQ+zXVB+NjYo6BwRBZ/AjW/EfEyqfkTstVvV+jOZdYubajmDBY=
X-Received: by 2002:a05:600c:a210:b0:493:c566:7bd6 with SMTP id
 5b1f17b1804b1-4954a341bcdmr16372265e9.18.1784291623191; 
 Fri, 17 Jul 2026 05:33:43 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499f3f99sm44199595e9.0.2026.07.17.05.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:33:42 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/2] i2c: add HDMI DDC driver for MT8188 and MT8195
Date: Fri, 17 Jul 2026 14:33:39 +0200
Message-Id: <20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2N0QrCMAxFf2Xk2cDSQa3+ivjQNZlGcGraDWHs3
 626xwPnnrtAFlPJcGwWMJk162OsQLsG0jWOF0HlyuBa59s9ebyXQCFgZEbmhOoSsukshhQ7dsN
 BPFMPdf80GfT9a5/Of85Tf5NUvsHNMHlN9bRs2rp+AElU0taSAAAA
X-Change-ID: 20260716-mt8188-add-ddc-i2c-driver-1a3d2f9e6d1b
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Schocher <hs@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

This series adds an I2C driver for the HDMI DDC (Display Data Channel)
found on MT8188 and MT8195 based SoCs, such as the Genio 510 and Genio
700 EVK. The DDC channel is used to read the sink EDID over the HDMI
connector.

While at it, a generic EDID_ADDR macro is added to edid.h for the
standard 0x50 EDID slave address.

The full HDMI support will be added later, as a separate series to ease
review.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (2):
      edid: add default EDID_ADDR macro
      i2c: mtk_mt8195_i2c_ddc: add new driver

 arch/arm/include/asm/arch-rockchip/edp_rk3288.h |   1 -
 drivers/i2c/Kconfig                             |  11 +
 drivers/i2c/Makefile                            |   1 +
 drivers/i2c/mtk_mt8195_i2c_ddc.c                | 398 ++++++++++++++++++++++++
 include/edid.h                                  |   3 +
 5 files changed, 413 insertions(+), 1 deletion(-)
---
base-commit: 78bfaf6281605509fd49262b0138cf1fb338ef62
change-id: 20260716-mt8188-add-ddc-i2c-driver-1a3d2f9e6d1b

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

