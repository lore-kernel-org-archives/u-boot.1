Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82561C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B14C80E18;
	Fri, 31 Jul 2026 08:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMIjv-4rzKA5; Fri, 31 Jul 2026 08:30:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8963580DF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785486600;
	bh=2Ti2yNSyGhh5Ow0fuPq8RepzyapPRb1ZO1Sw1LQXcZE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=chvTPFgrPhz5SQ1F46Rcf9oanhh3ahAwrcX0BlPlmZ2rfhn31urR8S/fA/2Oj2p2l
	 UhSsExqJzu+byjDJYA95Jmxb7RrwxMO4GYxGaf7TWXkq65SK0vsSpwqbCl4Y8xu7A+
	 Q4GGrbJR2CwDPNCzahtyagXeru+ICYWi+vEF3YKYdSQGPyAJ8uHhq+XCB9ycH8IUhc
	 rQDucHo7WrTFCgXn4bcz2wWCL5mT6vcm4dnz+3KlVyRMeLVbj5FwqV2slnDvDbOSlP
	 M7J2G7wU0Dmi3LIEgijxL8+tARunEju0zBd9LWKnNqN/2qYR8VgYovDpArKyiCPmRr
	 ldHQML9bLehjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8963580DF8;
	Fri, 31 Jul 2026 08:30:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60AFE26C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 472856081D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IhR5XQrr0l-e for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:29:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8ABD36081B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ABD36081B
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8ABD36081B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:29:57 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so1351294a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785486595; x=1786091395;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2Ti2yNSyGhh5Ow0fuPq8RepzyapPRb1ZO1Sw1LQXcZE=;
 b=XsgH1lj6B7uxb1Tl6jeoKWaZPFI+01VXIyIu0MUaY+SDhGpjJxI3Q7gSidZRRR1CVC
 1QsKC25vQ5Vwm3Lb4SXk6gwJPCkadisLwLQjXU9tLfQoi84ABQvPzE3SSx4W3NLFoKB2
 oIOdujADMySKiio58LcwKuAsAowmryBLPuBgAhjNs/veNI9dBFLLwxqBnnN5HB3R/ds+
 QGl8rRgsfVqaCewBeVYYElNeXkVhYi5FWXXB02sBnVRhO1WczojlYQisz3vYDeS2QYuU
 vacEg0CUCM+GxpIfR0IJGUyylY/86fwiJU7TLl4MojhAfLA1gir7MQg3d2C/ZPGKk3lL
 veAQ==
X-Gm-Message-State: AOJu0YwU6QfOpcy9xA7Hkb2p2mxneriEVnXS7FD6vUBtEIboHvuTLQyU
 ZGYyIRPZcesZGYmzL7R4mDIWQcSZn8eXKW0+RsAO0gbSlgZiyL1jAFWYdZI9XMUgo5Y=
X-Gm-Gg: AR+sD13ocTr69q9t8bectUG0DtfdqXze0GjudghxssDsY6avMYfRmOd+oOlmPm3+sti
 jGm9nN5IFRSahuzEN6s6zRL5G/i7Ls+evqTv/d4g9O5zxTNtUkIEwbUNlWmU0ngddN2svPyT5K1
 q+JSThoxrxAIRC8VWO/RWfFs0NEFVEQcbVw06UKQIdIxt563NaFVATbSayWbLHxxyfiYgNpvP23
 6S1F6mAqq9fkGatG2xvHgNtCJ7a0h/3lzMsF03VRt4Sqxhs9oKFkGejg/FwtH/sInUe2aEEffXw
 r4E0+Sj6se8sWn5QFRDxnCw0pZ/Ms3eorREPl4wyCCQKHxLX17D9gMXIpLUuaaC+brgT1puhYHw
 tKrCS+xda4vTen7jN9Gojpi/rdTyW6cVA54R6DXohU8cPq5OTqyaDJOJ2d1fyid4TRfbvE6kLYT
 xjTnQiHilcWajS1rOT7oE1fWK7XgotUGW/D0aqXetpes1sbjb+pIQ2cyEXAd1P7VfZqcd5NgfDb
 NMxo8zbiNh3pFOcGD0LkWm32uWdzdU2BRSuJViRsPmgAi5Ad4CRhlo/WQp7ON5QkTjkZziMa/Su
 GrmmY7iu4FY1CGVajf409Q==
X-Received: by 2002:a05:6402:e88:b0:6a0:908c:203d with SMTP id
 4fb4d7f45d1cf-6a098d22ca7mr517155a12.41.1785486594906; 
 Fri, 31 Jul 2026 01:29:54 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c661641sm583646a12.29.2026.07.31.01.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 01:29:54 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH RFC v3 0/5] Add fastboot to SPL
Date: Fri, 31 Jul 2026 10:29:36 +0200
Message-Id: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOsU7DQAyGX6W6GUPODQ1lQkLiAVgRg20ccqjJR
 edrRFXl3bkEkBBLBw+2f3+fz840BTV3vzk7JlPgRIN0pXfH0XJS6m96CoO72rikU7AQh7LcllY
 6Gt4VwtsSxgp3VePvQIRKROH3Gmw8QEuWOcYMvm4Jecel6gU5Jm3D5+p/cc9Pj+71e2hH/lDJC
 3mJdcFyTKf1y8mv4R/h/oJw8uBB9kx8yxVTgw9Mp0PgpNcS+1U34R8g4iUgQgXItG0bLzWy/AP
 O8/wFS8PdQVUBAAA=
X-Change-ID: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785486595; x=1786091395;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2Ti2yNSyGhh5Ow0fuPq8RepzyapPRb1ZO1Sw1LQXcZE=;
 b=UG6Q9qMBcg51APsB99EoBkbm1HGgYO5ySSxnbgf3fp8gl7lLmljztFTvTvvgMCNEzr
 lmQoK45tQ/6QKh2VCDOYAZ9XEmeK+ZacmmzDsGy4lKjph1mOUTlRONd7633lnD/7GJFG
 +3NzYdIv6Se1STheteaRxfNwH8ARLwcJuoqJprXD5wGm3reB0J3/b/kqBX8Rw7hqZg0i
 Bo5vN1rO0tXFLKU+rUFEbDyAd9GsF4LPHGePqhYQ013Jdw2GERdw4bD19ez6YrnXXxUe
 OWSTsM10k/klGoFZR9nw6JnsfK6CaUQgi+/CwWupoyNm+LXst4bMQGzlleJwaHT2JvV0
 Uh+A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UG6Q9qMB
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Some recovery and initial-provisioning flows need a standard host protocol
before usable firmware is available in persistent storage. U-Boot already
provides fastboot, but the implementation can currently be started only
from the U-Boot-proper command line.

This series makes USB fastboot available as an opt-in SPL service,
including MMC partition flashing and Android sparse images. The interface
is kept deliberately narrower in SPL: it does not support the boot command
or filesystem probing, and reboot support remains platform-dependent.

The first four patches separate the generic preparation from SPL
enablement. They factor out the USB session runner, route USB reboot
through the common handler, make shared fastboot configuration phase-aware,
and add phase-aware sparse-image support. The final patch then contains the
SPL-specific Kconfig, gadget behavior, and documentation.

No fastboot code or supporting library is added to SPL when SPL_FASTBOOT is
disabled, so the feature has no size cost for existing SPL builds.

---
Changes in v3:
- Rename the USB session helper to fastboot_usb_run().
- Initialize UDP and TCP sessions in their transport helpers.
- Remove a redundant USB session return assignment.
- Collect the Reviewed-by tag.
- Link to v2: https://patch.msgid.link/20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com

Changes in v2:
- Split the common USB session runner into a prerequisite patch.
- Route USB reboot through the common fastboot handler separately.
- Split phase-aware fastboot configuration and build rules.
- Split phase-aware Android sparse-image support.
- Keep SPL-specific behavior in the final patch.
- No functional change from v1.
- Link to v1: https://patch.msgid.link/20260719-ccaione-upstream-spl-fastboot-v1-1-c9bab5b0ba72@baylibre.com

---
Carlo Caione (5):
      fastboot: factor out the USB session runner
      fastboot: use the common handler for USB reboot
      fastboot: make shared configuration checks phase-aware
      image: sparse: add phase-aware SPL support
      fastboot: add SPL support

 cmd/fastboot.c                  | 53 +++---------------------
 doc/android/fastboot.rst        | 27 ++++++++++++-
 drivers/Makefile                |  2 +-
 drivers/fastboot/Kconfig        | 89 ++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/Makefile       | 13 ++++--
 drivers/fastboot/fb_block.c     |  9 ++---
 drivers/fastboot/fb_command.c   | 58 +++++++++++++++++++--------
 drivers/fastboot/fb_common.c    | 25 +++++++++++-
 drivers/fastboot/fb_getvar.c    | 19 +++++----
 drivers/fastboot/fb_mmc.c       | 36 ++++++++---------
 drivers/fastboot/fb_usb.c       | 66 ++++++++++++++++++++++++++++++
 drivers/usb/gadget/Makefile     |  1 +
 drivers/usb/gadget/f_fastboot.c |  6 ++-
 include/fastboot.h              | 10 +++++
 lib/Kconfig                     | 11 +++++
 lib/Makefile                    |  3 +-
 lib/image-sparse.c              |  2 +-
 17 files changed, 322 insertions(+), 108 deletions(-)
---
base-commit: 100e12ea78c73071b9710f08b32fd4590019266f
change-id: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

