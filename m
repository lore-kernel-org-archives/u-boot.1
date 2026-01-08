Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7413ED185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659D684172;
	Thu,  8 Jan 2026 14:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mlkJDxVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C4683B87; Thu,  8 Jan 2026 12:17:28 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CCC283B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b728a43e410so526801366b.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767871045; x=1768475845;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MgO6/5APo5bY9U9GByEI17ZkqlRZWGM8MQmHGkZSNXg=;
 b=mlkJDxVQDCcobDzoCbiLPdtFXsPQUvQrj11tAi7USfIsDVQ4yNmcdTfWn0mVmB3P4n
 r25XpUZGJl/qILmmaIU5sON3ibXUKUVROyYPN2G4kPFa7qFV34GJ5vVx75DK6wzVuI1H
 WwcHOShHxoxpXWOmt7uBv0VvArsH8TjSgb6DH71xIvfZDu1gy9CbZIJA+SrF9xwttl6m
 yInCI077LyAu8iRPQGg2pN2lrqAqe8yvFtCbChlu3yBOPDtkkmnRRu5heuA2ZkSJUBRY
 9xJRkI8zPoRDyhIh90gTKiR5hh5vRF6T75MZqIuv+WPfUYgXqXxmM8XMlKgGJSEUtX4A
 iIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871045; x=1768475845;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgO6/5APo5bY9U9GByEI17ZkqlRZWGM8MQmHGkZSNXg=;
 b=e7Rop4/XQY5v6ZNDmv6H8ZUzizjzhlvWkFyrrFi6qY0mJBJ5vt7NMAOj5Gvpq2IjlS
 akkqRnp2IBvRo+wRloXQCk7p7AF3gqHuqM+t35hoSZWqCtxSXtOzLcnEhO5DpL6j157p
 zimXYb3EN4MSep+5sl0JAI39howXiWu+JPC3kEECN/i9X4qf2wgbi2vZi01QOnV4xijw
 VeqzQ1xLjBL5aFs9SCD+SRnqmtXfae1XelJMV9yTYVnuwL0XjzqH17iWRxpYc/HQRiCW
 gAm8nOwqHsxw+lr169R8LBiqM5xMxzwYNsp18ekb7DEVxZs3Dk3MqCB1LLkRyehYsugo
 d/hA==
X-Gm-Message-State: AOJu0YzPsl919ayQ+bZaU7UDp1f+89t6FAfWJp3cbbZ2EbapJWZTORBk
 XgfmPugmbG2Djm4y+MxcRiRRaJKs+E1tfvQuBoXVpQBA4g9Zicdz8LkI12bqzUFuf1A=
X-Gm-Gg: AY/fxX6c6G3oJHfNw6tcwiVnPz/Jfos5Kzqug8rUfGf7QrMCKhY1N4ef5kdqOnMn3/3
 src/6SIB8Ti87pqdYiIWu44pCxdI93DVKc0U/84cFM3LGAzyGN00buMjc4Jk6jonVKcufOLaNN6
 55Sk7IrYSPQ9FV7mDKp8CQiOlVdlwXaU7oP9/Qpc89CIlA7sXRvVMabUCr6bUS4hudj7p42SNfv
 /V8nuaqQcHfLaWBGpCp4Y2HGRWNANgAsLY86mdvkJsK95mT5z1/RdfKgnU3Er3x62GoEeW8TKMC
 T47UDSygHY/1shGfkLqQLLioGtb6FYDDSLojNUGYqJGnB+HjBtdi+OSHHRiDb6ZmaV0cdSmQAx2
 9ZjYtxWDjgJItouIcGjaWJCdfq4zMuF7i5NG3Wtewp7hR0wAhgMMibd27WTNjBjPiW14hP24Efu
 /9NBrBf2ttIU35MmXgZuU=
X-Google-Smtp-Source: AGHT+IFjraasfcRe8LweosJ9WYbDub695HPZsk0LPJMwEY8yLcdaYfSydbiWRG/jQo8BX5PHVz1k5Q==
X-Received: by 2002:a17:907:7285:b0:b72:588:2976 with SMTP id
 a640c23a62f3a-b8445407314mr500370466b.60.1767871044953; 
 Thu, 08 Jan 2026 03:17:24 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a563f73sm816451266b.61.2026.01.08.03.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 03:17:23 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v2 0/6] dm: core: Support same compatible in host/gadget
 musb drivers
Date: Thu, 08 Jan 2026 12:16:26 +0100
Message-Id: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAuSX2kC/33NTQqDMBCG4avIrDslE3/pqvcoLkxMdKAaSWyoi
 HdvKnTb5fsNPLNDMJ5NgFu2gzeRA7s5hbxkoMduHgxynxqkkCWRLHF1C2ucXkHh4p3iecCYjhU
 KQsqL3FrbUF0pSMLijeX3qT/a1COH1fntfBbpu/7c6q8bCQUmt2900dSUi7vqticrb67aTdAex
 /EBedEptskAAAA=
X-Change-ID: 20251125-topic-musb-probing-v2026-01-1343fff8176b
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=msp@baylibre.com;
 h=from:subject:message-id; bh=wBWAemlGrp3KmswIr0vmJlxa2CwDzzzGXD6WF1moa+Y=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz4SYKF9qdEJBh/XV3LLCmnfs6zeH55oujbnv1Wr69bb
 5u/QZWno5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaiqMrIcOGt44TL01hkt0xY
 FLe09WSFUdCbL/J72xd9NZvOJ1f0cTkjw7xVl94ZrV/BsjNY8gyvnViilrzS/SrPo4JS7HPFd5x
 vYgcA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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

musb currently uses a wrapper driver that binds on the parent device of
the actual musb devices to manage the differentiation between gadget and
host modes. However in the upstream devicetree this parent devicetree
node can not be used to match the wrapper driver.

To be able to probe the musb devices in host/gadget mode directly, this
series introduces support for returning -ENODEV in bind functions
resulting in iterating the remaining drivers potentially binding to
other drivers that match the compatible.

It also changes the address parsing of musb-ctrl to be able to parse
relative addresses.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v2:
- Added a few patches to remove nearly unused variables
- Changed the inner loop in lists_bind_fdt to support set drv and not
  set entry->of_match.
- Cleanup the loop a bit more
- Link to v1: https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (6):
      dm: core: lists_bind_fdt: Remove unused variable
      dm: core: lists_bind_fdt: Replace found variable
      dm: core: Support multiple drivers with same compatibles
      test: dm: Add compatible multimatch test
      usb: musb-new: Relative ctrl_mod address parsing
      usb: musb-new: Add compatibles for ti,musb-am33xx

 arch/sandbox/dts/test.dts      |  4 +++
 drivers/core/lists.c           | 73 +++++++++++++++++++++---------------------
 drivers/usb/musb-new/ti-musb.c | 36 ++++++++++++++++++++-
 test/dm/core.c                 | 15 +++++++++
 test/dm/test-driver.c          | 25 +++++++++++++++
 5 files changed, 115 insertions(+), 38 deletions(-)
---
base-commit: 127a42c7257a6ffbbd1575ed1cbaa8f5408a44b3
change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

