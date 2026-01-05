Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8234AC79F8B
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 13:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F9283D7D;
	Mon,  5 Jan 2026 14:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k6eSG12T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04B183D17; Mon,  5 Jan 2026 10:37:03 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C575B83AB7
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso142955695e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 01:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767605820; x=1768210620;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+5xdQx+6M/6CAYLRoAlezOvYDZWZzGC0WoBFw9D1knQ=;
 b=k6eSG12To6KUdUFJNo/nLmcfLOFWXLlH3AGwVFxRTCjVP18tIltuDBMErqx8W/iakU
 A5UGUf2RanFk2tLhUhriDAGUPpWXAamwcv4wskK9f802qTMECEHl1L/Agp2/V841RxlQ
 xjh5HgfOee2JI9FI/NZ+5VleTxItdoWe+adRKdI2gqTMFLG9nTZ6cT9hqmiEv03bkge/
 drdDq36C2idIQGlGCAbVUtFogMRVGebLtpZaLvv/9sw0K43sAismRh9c2pNyfxJMdigt
 QHM9c+g332MIS+xu9D+kyJhruZs5f7GcW6gsNxeN0CWIsaQSus9Uw9HqLSDpua/2fuKU
 mwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767605820; x=1768210620;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5xdQx+6M/6CAYLRoAlezOvYDZWZzGC0WoBFw9D1knQ=;
 b=DrPdcvvWHkQNeVgVaLUef199kqZQUKEaVbOtdcrs6pJT8xUGY8HMTWuAhEPIUReOFF
 BdsJmVFbpUzaqZeVkw0cB/Sv9psdW+TLhZK696eDEuzPIEt1kDktArKlUz404JnkuYX9
 jknRfRUdPI5lVj3iQVExjrfJ0oYYv6Pleb/47EhEsbEainEXV2KcYIu24f3mlWuXsvTR
 yHaVY4AoyYgPSn9l4QCYUIGLH8mUpB/xsMxJdGoaKp79PpfVx6DW4DZd5FQTSrknQyBp
 A+SsbkOtx5bQ0UGj7UySYlBzXQ0Sg56hs05yuRYLUWA5rBan7pnEGq0RcYA0wyCKnqUV
 P+Xg==
X-Gm-Message-State: AOJu0YwonfXiZDWpFafiXaNVhSMzBYeriZpxFrKn5LGvqCxyVk4bumvS
 tDJaUNp4idQ4xYPyI7YuZfdiyZ3NmeETvMVSdMs96+YSmRTs5zY4I/Om6z9GTCQjLOQ=
X-Gm-Gg: AY/fxX6ViG1KTQtHZPZYacDan8V75XmdfLnJKjeyjO5pgzmRPOTgr67hkC/xbmexR89
 WXpExkJ7fq0Nsv3Z3K5TRTtEXUDDZdkik0nAvnq83fwJbWOgVQALYymK2Is1gfbcih0FHJFM4V1
 nuKiSKiiQfTcweItqkxhy2M8AvfmQRMgHHd5j3OxdmiPYfxQNjdUhetr6QYqmy4jWUS7rQ4kbOc
 w/ug8LC4FKPoY5tsbF74vnbIToBNN0HXNWbYn3fLTfahjute2AZaDFTTs536RgYT8sYUJb5dRJk
 aD6Klnmwud43Zkfquoe3yjvCcTN6B5u1jdnTDIj3JZgTDkBC+5ID5OVuRvi3c3ymLTB+H5aqdri
 5FYglBsPYalTC3cw29Kd3VIYzXigUZsMavoWkulvz9H6pCUvLdOpH0p00m0dL5CAj/cj5H36JJa
 jn0cURTJrkYBYXkFIlZ0Y=
X-Google-Smtp-Source: AGHT+IHYDokQqBfSY1VAqSmxUQEj4EGnIsdcwVQsEiMLl96QiECPSl3jn7nSSqZ0ZH0H2czdsMnU0g==
X-Received: by 2002:a05:600c:444b:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-47d1959fa3emr601060265e9.25.1767605820094; 
 Mon, 05 Jan 2026 01:37:00 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d452c69sm175808175e9.9.2026.01.05.01.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 01:36:59 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v4 0/4] video: simple_panel support for am335x evm panel
Date: Mon, 05 Jan 2026 10:36:25 +0100
Message-Id: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABmGW2kC/43NwQrCMAzG8VeRno10SevEk+8hHro01YJzo5Oij
 L27nRdFRDz+v8AvoxokRRnUdjGqJDkOsbuUMMuF4pO7HAWiL61Qo60q3MC16yODa4lAcgtn9pD
 LcQ26Aq1NqI1D5sCqCH2SEG9PfX8ofYrDtUv357Nczet/bi40SKitN0Tak9817n6OTZIVd62a6
 YwvDjX95rBwuEYOJpCRxn7h6J0zvzkqHLvabCw13gb9wU3T9AC/Okq5ZwEAAA==
X-Change-ID: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=msp@baylibre.com;
 h=from:subject:message-id; bh=A68nUP3YmDF0IboBzPu/y5M3x4lSMDncdxQpwOVM4IE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszoNvnvG6JrClrnfzJyXtTS1bCuJst+Uorub3Ou2xqRf
 3bc2ZzTUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABMRaGJkWOe3fsE+QTXZD8K2
 +oek7NRZ+8+5J+f9UjhdzvXoIbvlXUaGZyKHLgmev9guXM4Q87Dw5wIX1tf3PUNaTCTOzJ1x0G0
 mLwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:03:25 +0100
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

Hi,

this series adds the capability to define hardcoded panel settings to
the simple_panel driver similar to the Linux Kernel and adds the panel
used on am335x evm. panel-uclass.c is extended to support get_modes()
for panels and drm_display_mode conversion. In a second step the tilcdc
is extended to support OF graph to be able to connect to the simple
panel devicetree node.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v4:
- Fix missing null pointer check in check for data->mipi_dsi
- Link to v3: https://lore.kernel.org/r/20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com

Changes in v3:
- Fix typo in first patch timining -> timing
- Link to v2: https://lore.kernel.org/r/20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com

Changes in v2:
- Add support for struct drm_display_mode in u-boot and in particular
  the simple panel driver to make copying definitions from Linux easier
  as suggested by Fabio
- Link to v1: https://lore.kernel.org/r/20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (4):
      panel: Add missing comment for the timing argument
      panel: Lightweight support of get_modes()
      video: simple_panel: Add tfc_s9700rtwv43tr_01b
      video: ti: am335x: Support OF graph

 drivers/video/panel-uclass.c | 38 +++++++++++++++++++++--
 drivers/video/simple_panel.c | 62 ++++++++++++++++++++++++++++++++++----
 drivers/video/ti/tilcdc.c    | 46 +++++++++++++++++++++++-----
 include/panel.h              | 72 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 200 insertions(+), 18 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

