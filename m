Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B84EC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 01:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB7486FB6;
	Mon, 13 Nov 2023 02:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gQFWj2ek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955AA87005; Mon, 13 Nov 2023 02:49:31 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1039386FDD
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 02:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b41132c33aso471562b6e.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699840166; x=1700444966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jGjFBN6tXCNMGqz5YzIdG2NFXfUcEZCghLNV7Fh22g8=;
 b=gQFWj2ekuFpbDGHH1+MEvDUQrDcUhFjgzx0SLWcjEgV9x1Nwp3UL4V+cOOuPqz8x4j
 nnoCdpp9ftp/97sjyskip5e2kN9B6lIkRI/KdH4CfQdpiulfYiD2iW2uQ0CedujB2f5V
 avXkDuy5yECou0eTTHd5cX7AVUyzMDgjxQmNgo9xupcKdWzX0sqvMxZU6rKZzYl8WV6D
 RQuIRP4a00OKOnmgR1dn1N27TXu0uM7rpdQGU/wt8IZ5/YHzg3876LYdd11dzkXkFHH3
 5gIC0xp+IZzBk1Fv6u/6cFCm2MkCulWKbPytzLsi1OuycrwykrYu13HVlYDb7BVxX3AA
 XaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699840166; x=1700444966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGjFBN6tXCNMGqz5YzIdG2NFXfUcEZCghLNV7Fh22g8=;
 b=rSUXXqQ64yHHc/v1Hr1aGV1R6L2dha4ex/aq5BbFd6p0DJYw1aaqeFEJ4OcxyqnN2V
 XkNHPr6E8x21Aasm0OwEs2yC/7FNgqHaqr5ofQKHQR8qWPhAYlstKaCLjCveTPXn7LdR
 RJ74tvEDZYG/KmseAqLpR5+RH1s/HfQUCxacdVUyW74B7GBEXNYUTiYMQkIGbhxgG2HH
 VlAqGxKrTY7OPe7svnxR61bxmZjhVb+6Q4o2+X78LRVeENnAGHd4+nzaTPuZD7X2YUZ8
 L9lvBoXNkZtf4DdRnnbpzsu1wbANKFUqjYE763oEHUvwvVTFf2atHunbTj0HKXlE3Zee
 m74w==
X-Gm-Message-State: AOJu0Yy5WwtuIfbeVxBOy84uWimjrgibZDvuSskeBSJE1KxBO7OkCNge
 eol/B8gI4iSGoNScwvwi9bzqwA==
X-Google-Smtp-Source: AGHT+IGQaLu2qDMJB8WRegHi0Cnn1Co/wBNgP631AbDN/4vA6pI51zmJ+SzB+Byuc9d295uJOutLMQ==
X-Received: by 2002:a05:6808:f07:b0:3ae:5e6a:5693 with SMTP id
 m7-20020a0568080f0700b003ae5e6a5693mr6600035oiw.0.1699840166486; 
 Sun, 12 Nov 2023 17:49:26 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:ba59:509b:48bc:9f1])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a65644e000000b005b92e60cf57sm2635549pgv.56.2023.11.12.17.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:49:26 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 0/5] cmd: add scmi command
Date: Mon, 13 Nov 2023 10:49:06 +0900
Message-Id: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
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

"Scmi" command will be re-introduced per Michal's request.
The functionality is the same as I put it in my patch set of adding
SCMI base protocol support, but made some tweak to make UT, "ut dm
scmi_cmd," more flexible and tolerable when enabling/disabling a specific
SCMI protocol for test purpose.

Each commit may have some change history inherited from the preceding
patch series.

Test
====
The patch series was tested on the following platforms:
* sandbox

Prerequisite:
=============
* This patch series is based on the latest master.

Changes:
========
v2(Nov 13, 2023)
* localize global variables to avoid pytest errors.

AKASHI Takahiro (5):
  test: dm: skip scmi tests against disabled protocols
  firmware: scmi: support protocols on sandbox only if enabled
  cmd: add scmi command for SCMI firmware
  doc: cmd: add documentation for scmi
  test: dm: add scmi command test

 cmd/Kconfig                                  |   9 +
 cmd/Makefile                                 |   1 +
 cmd/scmi.c                                   | 384 +++++++++++++++++++
 configs/sandbox_defconfig                    |   1 +
 doc/usage/cmd/scmi.rst                       | 126 ++++++
 doc/usage/index.rst                          |   1 +
 drivers/firmware/scmi/sandbox-scmi_agent.c   |  27 +-
 drivers/firmware/scmi/sandbox-scmi_devices.c |  78 ++--
 test/dm/scmi.c                               |  93 +++++
 9 files changed, 687 insertions(+), 33 deletions(-)
 create mode 100644 cmd/scmi.c
 create mode 100644 doc/usage/cmd/scmi.rst

-- 
2.34.1

