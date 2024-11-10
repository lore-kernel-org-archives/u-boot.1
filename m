Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0359FD10C0C
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32C6288969;
	Sun, 10 Nov 2024 12:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gxsZvrrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6E789009; Sun, 10 Nov 2024 12:51:27 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72C788D14
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314b316495so29488435e9.2
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239485; x=1731844285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4TdiMcB/0i/CdAGfR03w/+OwqJEAxPgYqieKWsKwBKE=;
 b=gxsZvrrPoyNDusTnGsyc/5QBHAvGLdhKqSvGePezV5CPT4c/w6eMmYIBXnaY8O2WAQ
 3JtOVdRgURMUCh9/uEUs0YrdV1X33W63QtrlHeV0W6yIuHuVFeWx0bNxtK+2f+hadS2B
 iwNFchIGH+B3UJ9uG3JnCNXuxXBVo3bKW1fsGfQ8T8DjWNYk2JQwZS0ISImwztozCP79
 gBkgYwmyiJCqRszDdoTtBwGxTuiWErPoUeUBfwPOshraoSTx78TvkwYC6SxQOnIq5Tjq
 6oQHFYGbngZQ8U1cCrvnRM2kyi/06NTwsgn5qH9Mz2Xw+ZI2FNeGEC0yC1yhDZ6DLx4H
 Z0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239485; x=1731844285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4TdiMcB/0i/CdAGfR03w/+OwqJEAxPgYqieKWsKwBKE=;
 b=K47/wLsO6YySjLaKnaVcRi40Vy/Y8p23nfeiktRz8uXdmqjMW+n885ge8xh8jWYJz0
 dvhBVgqm6vtsBAav09UwyQOZAhC7ymazyWvDXVG68H5L7c12pD6666d2i9NpK7bs7QcT
 aELhPWroU74QrTBcF304Jkf1vowtRPFtDg6/ryCTbTfli210W2H7THsDHHfzE/Ve3Zhq
 ZsWJ+NpH63PSKKYt4Ama955/uQBJblptPNc2e5TO1uR7UQPcQP/C31y5b+ztbt5kRbDq
 RmO8Ll+br4sT7KNST9TLFiFSSE2dr6Omgv9jKXYg283J5pTKJpklAGnNC0PVinitcdE0
 EJLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoY91QH9jz7IlwP9WnrPMNnqIrOPRzGF7FopTrV5364TZdjiLZgc0UJoCYh+mXj7HyYw+UAt8=@lists.denx.de
X-Gm-Message-State: AOJu0YzE/ZX/K7urgJo/nWzlyzFvUKHMPHF0fatnU9PlYsw8h+kfA6Fg
 1Tf8aEhIar1wrvsVk1q4bsP0LmtbTzfNZzW1YnG6/2qnNGAXI+cd
X-Google-Smtp-Source: AGHT+IFdYuarKs/43T2vOgdAIJxrBIzc3eIN145rlWlkafkBNNaWUWKlFIRQh7uIeeEe03gFULhg5A==
X-Received: by 2002:a5d:584a:0:b0:37c:d23f:e465 with SMTP id
 ffacd0b85a97d-381f1848a9emr7393586f8f.55.1731239484982; 
 Sun, 10 Nov 2024 03:51:24 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:24 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v2 0/8] led: update LED boot/activity to new property
 implementation
Date: Sun, 10 Nov 2024 12:50:19 +0100
Message-ID: <20241110115054.2555-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

This series is split in 2 part.

While adapting the LED boot and activity code to the new property
accepted by Rob in dt-schema repository, a big BUG was discovered.

The reason wasn't clear at start and took me some days to figure it
out.

This was triggered by adding a new phandle in the test.dts to
introduce test for the new OPs.

This single addition caused the sandbox CI test to fail in the
dm_test_ofnode_phandle_ot test.

This doesn't make sense as reverting the change made the CI test
to correctly finish. Also moving the uboot node down
after the first phandle (in test.dts the gpio one) also made
the CI test to correctly finish.

A little bit of searching and debugging made me realize the
parse phandle OPs didn't support other.dts at all and they
were still referencing phandle index from test.dts.
(more info in the related commit)

In short the test was broken all along and was working by
pure luck. The first 4 patch address and fix the problem for good.

The other 4 patch expand and address the property change for
LED boot/activity.

Posting in a single series as changes are trivial and just
to speedup review process. (and also because the second
part depends on the first)

All CI tested with azure pipeline.

Changes v2:
- Fix handling of flat tree for phandle
- Fix test and other.dts changes

Christian Marangi (8):
  dm: core: implement oftree variant of parse_phandle OPs
  test: dm: fix broken dm_test_ofnode_phandle_ot and get_by_phandle_ot
  dm: core: implement ofnode/tree_parse_phandle() helper
  test: dm: Expand dm_test_ofnode_phandle(_ot) with new
    ofnode/tree_parse_phandle
  dm: core: implement phandle ofnode_options helper
  test: dm: Add test for ofnode options phandle helper
  led: update LED boot/activity to new property implementation
  test: dm: Update test for LED activity and boot

 arch/sandbox/dts/other.dts |  31 ++++++++-
 arch/sandbox/dts/test.dts  |  16 +++--
 drivers/core/of_access.c   |  61 ++++++++++++-----
 drivers/core/ofnode.c      | 124 ++++++++++++++++++++++++++++++++-
 drivers/led/led-uclass.c   |  30 +++++---
 include/dm/of_access.h     |  86 +++++++++++++++++++++++
 include/dm/ofnode.h        | 107 +++++++++++++++++++++++++++++
 test/dm/led.c              |  18 +++--
 test/dm/ofnode.c           | 136 ++++++++++++++++++++++++++++++++-----
 9 files changed, 551 insertions(+), 58 deletions(-)

-- 
2.45.2

