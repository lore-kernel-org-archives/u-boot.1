Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630A910F3DEC
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 17:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84D483642;
	Sat, 28 Mar 2026 18:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Tl7mCNvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79E78394E; Sat, 28 Mar 2026 18:16:50 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8161380077
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 18:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so28934955e9.1
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774718208; x=1775323008;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n69iOfCx8r/tYYbLWbMgDiByJOAylNkX67zhneWbYew=;
 b=Tl7mCNvZPxeo4SU06PZXC75VeKFFEGn+mEsQ5L/JpI/4EyZz+xCHO9b63/Lkz45mBe
 BFaybNEg27CT+rCub6SHOAuxAwcEm6YNN01wBS9DrwNSXRfQ1v140jVoI86Rwb0BFZ7Z
 h94gdcoP2luAXc+aweDZQNFu9PFO9kIrAwp3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774718208; x=1775323008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n69iOfCx8r/tYYbLWbMgDiByJOAylNkX67zhneWbYew=;
 b=GL6hz0r7iKSJjmcme5vQY9ZQ0wPHTWWPyoljDTkpjcTajGKlFehBw9VBLhLsl78IdJ
 /3xgxpixRS4rbITLs1OHMN+aTOkB12HKlqY+wT20zyT1w+C2H8qh9oaPAFirKvendCzh
 juBMx4Bj/SSzAXwYGY4kTaPgCgRPlS63PqJo3uJIEO+FYdAN8MUqbOCIXj7fiKY2MOkU
 W3cvtFMArecTRKnATwGfiMiGuv6d9ZbkZKZ3LvxvrxjZEsKTLw6xS+gZjFfpScTUQks+
 BdBbx8xJdBV/BoC7XfH8FBXJPlDFTZAjFTNEfDLkXE3IwEt/7taSVJ3RcjfKxhcmFc1r
 PPPA==
X-Gm-Message-State: AOJu0YwxLE3WXneEuG8W97qkcFp7WPECi2UUYvIuuDRJIwYybztm34//
 KdLWpkUm5pC6haWjtmha0hOo6KuEDIR1aeDhHzx7n2GAl9fn9E8JYCeyDLhLODhu6Ua3mGmy44/
 F2vPn
X-Gm-Gg: ATEYQzwPBywZ6i+kWVba3/O/A0dZrxjakrQRhvkxks07UH57urMNhv7BZOlWVlUKdc7
 KWszCtoZsKZBLxC5+IKQX03J3Qgrdbe+wbXaKcieH9mcB6jQfnark62H+jbti69Y9YDMXFZ8/XJ
 j1rshtgwGuU9w0pAK2HpJyNKj2v9V5M7K/fXipcDYMQxMTgEZzIMotXi+hhuBiNxWxzFD7LdOtT
 een5oiZgrWy0+GvTqK1FhzwciPj5sEC+ZmAbmNhRoGIBF5YrC7UjoqLl/cuuT4cte2TTBUjHKPk
 AfCZ2EHx/vW/J8FdC5JKzMoBaa7f7k3+4Ipsz+4Itw/rjogr5akNDuKHjupxaxM6RK1RlNprnDV
 0emZAoDSuF8bUj1Gi/wJd1XYhQ5VZZi1EttBBdcUuzvjKc//rH7NugvotXFMPI2V8/eNy6aoXqL
 AKgjbhSlVvMR931tbN6JS+9NFqoZi40gf5oB276vUoxz3JWCJEFQT1YPUXt8jE4M8fxJTqv3M5j
 nzHkfSpyAqqDvpnQxt6GALyTp4njLAkNds/R/Q9/CLna5OSC0Xl5WqTGBeytPYqEOpAj76OB/oT
 TxPrpwU27heqhs9BQLSBUDpu28KrdGqZWjI=
X-Received: by 2002:a05:600c:1d1e:b0:486:fc95:1a91 with SMTP id
 5b1f17b1804b1-48727f2373dmr111216915e9.12.1774718207528; 
 Sat, 28 Mar 2026 10:16:47 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c6b105sm332432465e9.1.2026.03.28.10.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 10:16:46 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/4] Support metadata-driven A/B boot for STM32MP25
Date: Sat, 28 Mar 2026 18:15:13 +0100
Message-ID: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

This series, the mainline version of [1], provides the necessary changes
in U-Boot to support the metadata-driven A/B update flow for STM32MP25
boards. It implements the logic required to dynamically select the boot
bank based on FWU metadata.

These changes are designed to be backward compatible while providing
the necessary infrastructure for the A/B scheme.

The series has been tested on the STM32MP257F-EV1 board.

Additionally, patches 1 to 3 propose some changes with general-purpose
utility:

 1/4 fwu: add helper to get image GUID by type and bank index
 2/4 cmd: part: support lookup by UUID in 'part number'
 3/4 lib: uuid: add partition type GUID for extended bootloader

[1] https://github.com/STMicroelectronics/u-boot/pull/6


Dario Binacchi (4):
  lib: uuid: add partition type GUID for extended bootloader
  cmd: part: support lookup by UUID in 'part number'
  fwu: add helper to get image GUID by type and bank index
  board: st: stm32mp25: support dynamic A/B bank bootup

 board/st/stm32mp2/stm32mp2.c          | 25 +++++++++++++++++++++++++
 cmd/part.c                            |  8 ++++++--
 doc/README.gpt                        |  2 ++
 include/configs/stm32mp25_st_common.h | 15 +++++++++++++++
 include/fwu.h                         |  3 +++
 include/part_efi.h                    |  3 +++
 lib/fwu_updates/fwu.c                 | 24 ++++++++++++++++++++++++
 lib/uuid.c                            |  1 +
 8 files changed, 79 insertions(+), 2 deletions(-)

-- 
2.43.0

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: fwupdate-ab
