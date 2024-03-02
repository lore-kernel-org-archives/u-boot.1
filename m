Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649C5C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8775887D9C;
	Sat,  2 Mar 2024 23:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C4Wjpw6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A9A87D8D; Sat,  2 Mar 2024 23:01:16 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6343687D37
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d855caf7dso425725f8f.0
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709416873; x=1710021673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jUXDBg7ty+Q7wPaVwujyBgA7YPWCoMv6Pq3RqkR+bjA=;
 b=C4Wjpw6swcYDmqddoHvVDlJr0fUcaeVPXFGBl1XrmoFrL2UpBTlZkNgGPr1YLDluy3
 xc4ZAl9O9EHgSqdFomWhIFpezb+xVLQ12d/VrZm+WWLtLhMb2XOyOGQA+8ElLIB5lHv3
 BFuAlsUlme7GFTLt5De7VnbyDOCdpa8gS4EFy34Pqw5fBL47yxS/BtbSrnHqPwhRWVwQ
 K0Cra8Wdds+mj1G5t1em1nMY6DxtIdB5yVxTLMDnGPYDe3IyEf0Sg5RVRH/mNstFaNJZ
 lB72pz7xVFP00YexHvBLONdXKXKSGjuXIDzV9+RZWKotanr77GlMxm9X81gAi0n0Sb7Q
 lrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709416873; x=1710021673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUXDBg7ty+Q7wPaVwujyBgA7YPWCoMv6Pq3RqkR+bjA=;
 b=bwH1TovdQ6pCm1PoMaN5QRCEJjDszPuhfOIPqEO8hUOqKBItFo1a23q4Pc0qx7bREr
 aqw4Oq0tQdssvHqOr80EjeCqpbVmTTb3viyQ3v7grxS2J7fUBmUAvvNymDvDtC97u8oP
 gFMK/0ItZdeW/WruND/872jJwRp0i54mQHt/op1vm19ljCzS8jLzPZMPu76P4Qmyarsk
 nMEurGl8kXbff+mspHBKSmgv8gGlFQMcM0Ifh4Bf4z/JR6L3L7rFRcDB6dOfID2RDF/J
 tlDJFQaYtvHFZA0Xp7hKlPs/1KKS3iNC575mHUA9tXmqi5P6bDEruxOJYttSSmtGD7T5
 PWdQ==
X-Gm-Message-State: AOJu0YwjYalVARbv3MYDK4ZQDOvbFSmc20nN2naO95aPIDNGLaUI1gJU
 3RSbiWcl5oQY1nOuhsTzGrrsK9up8OzCSO/kOEfp++bgnhQcjAkgW6l0IQs6
X-Google-Smtp-Source: AGHT+IEQgvqbV5GEafJa9uDrIlVQjZfPmqOBfjES0XdnU1XOaWEpSxOD9mvVcgjCg7+sfJbJCO6yXw==
X-Received: by 2002:a05:600c:4f0e:b0:412:ae70:9934 with SMTP id
 l14-20020a05600c4f0e00b00412ae709934mr4404936wmq.3.1709416872717; 
 Sat, 02 Mar 2024 14:01:12 -0800 (PST)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 i4-20020a05600c354400b004101f27737asm13063636wmq.29.2024.03.02.14.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 14:01:11 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/5] TEE: minor cleanup
Date: Sat,  2 Mar 2024 23:01:03 +0100
Message-Id: <20240302220108.720637-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


- Address some spelling errors and typos
- Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
- Remove common.h inclusion for drivers/tee

Changes in v2:
- Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
- Applied R-b and T-b tags

Igor Opaniuk (5):
  tee: optee: fix description in Kconfig
  tee: sandbox: fix spelling errors
  cmd: optee_rpmb: build cmd for sandbox
  test: py: add optee_rpmb tests
  tee: remove common.h inclusion

 cmd/Kconfig                        |  4 +++-
 drivers/tee/broadcom/chimp_optee.c |  3 ++-
 drivers/tee/optee/Kconfig          |  2 +-
 drivers/tee/optee/core.c           |  1 -
 drivers/tee/optee/i2c.c            |  1 -
 drivers/tee/optee/rpmb.c           |  1 -
 drivers/tee/optee/supplicant.c     |  2 +-
 drivers/tee/sandbox.c              | 10 +++++-----
 drivers/tee/tee-uclass.c           |  1 -
 test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
 10 files changed, 32 insertions(+), 13 deletions(-)
 create mode 100644 test/py/tests/test_optee_rpmb.py

-- 
2.34.1

