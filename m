Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0C7D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B6C83B95;
	Fri, 28 Nov 2025 23:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zB6uJkff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B33E83B9D; Fri, 28 Nov 2025 21:22:48 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C778583B63
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477770019e4so17621265e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764361365; x=1764966165;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5mIkXqN3AR3oDLgfje+IzgZ6PWXkm/p0NMw3xmhXBKo=;
 b=zB6uJkffwEys0qiEfBrLYJFMV/FgUI5gnFYlSe8jYBeKfouqq8C6Jh/C5g3/vnvStI
 ffKUGZIBw/T1jleKvrDjalrPCrdjwyO2FWI38CZUaDrnQFD666SY4V5Q8kUzCwzyMweM
 ZsP3KYgypdY/uOdKCRxtZRXIWG0QXGSFcpX8waip/Zt8iLHHnNZsjva6GXi8R9OsSyOj
 HzghKxGXymofg64ksLMBQ76SLc3p27YHl5HiXihA+Br7fbOzmek7g6GTtc4WTfJ222C8
 5Il5OgSbWuk0KAqMSrYdf0MPb4aa4tCF3dSH915LhNDlRrjO0Z29meP//jL2kwUv6HTo
 Y78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764361365; x=1764966165;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mIkXqN3AR3oDLgfje+IzgZ6PWXkm/p0NMw3xmhXBKo=;
 b=jNCoFM38NVhkNGcsIgmdeZHLXsrnLmScbnjzvSWAlcJGbG9pEZ6ztC1RK0+C4n/1E+
 hvbxShH9M7ArrZu3bTX1Ju5orYKuFtxHOon/YyxVEJdeEdqMit05Y5M+LrhoDQJfexYa
 NVXUwrassBIVbjSpf0ExTm2ZBFTbWYVi0OsHC6EmkK2tM1SxvtO7BaHwCG/bf/13cozp
 3/vi2UqFQHFXxdk9Coxp5pCiv293eq3qISzZkETSavFaTxhsh5XSMn9mKYnTunOJNthu
 vl4+qBKB0mTDY8iwuj6DJmWOIiHIuq5GFdLsi5fyJd32zpppYVsFQ+Bq+5RpPkmUwRXy
 ferQ==
X-Gm-Message-State: AOJu0YyBbfxi4+2lnyE0sThbC4UU7ZkmQDTcr9jreZS5/k/oBMMBN68S
 Drw5I/gt7fPPThwc7wB6T99YaNi9BBOE2STGKNvgRW9CBs2ubZTYO83seqySSBLl/m0=
X-Gm-Gg: ASbGncu/NeXUWs7uSgnP9qdHsVoZvAIElGlWIvVUlXCxmtLF5KjiL956LtoUIquv1TW
 hOO0Qb/gid5Nn73CaYl7yGLKVNzApDFDQF8fFtqZ4Vprdp0zjmp/fj5Lz8BZ9aZBERpLAxetQ7B
 4uUydqYrWJk8xPP7MgDXhehOZRWIt0hJdMXdetSXA93GtVBeipF4ljvxuLtbHvmA2w27h4Gq7YT
 XybKu3cJyw+eitR3tLFRxErrpvTBDFGS2AF4/WTSRSEVrBaJX5/gNhmNp24RSVRLWx3QGwMhTCK
 Kv2XpTIaxb5bE0rZUgJ6lKGzm93L25V5roOVe4+DklNpEUceKGc/6CdU0FkOwtPVPU9xyuCvJh1
 h555Iur2IztpjRGYYejphd3R2s8bZI7uJS0pxBgrFtC4kAhmc/QAKXOnjbLuvoqX5bZiw3llijE
 3FDMySXXk=
X-Google-Smtp-Source: AGHT+IG1863j5Jux6Opp5GAF9a35GsqWpp3BSum6zBpcK+FB/gjA79DDFdgY5FD/J9RxXyPsEw4FDw==
X-Received: by 2002:a7b:cb59:0:b0:479:1348:c653 with SMTP id
 5b1f17b1804b1-4791348cc95mr50358095e9.18.1764361365106; 
 Fri, 28 Nov 2025 12:22:45 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1ca1a4bbsm10960332f8f.21.2025.11.28.12.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:22:44 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v2 0/2] clk: ti: Cleanup common functions and omap-cm
Date: Fri, 28 Nov 2025 21:22:17 +0100
Message-Id: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkEKmkC/42NywqDMBBFf0Wy7pRkxFdX/Y/iIo+phqoJiYSK+
 O9Nhe67PJfLOTuLFCxFdit2FijZaN2SAS8F06NcBgJrMjPkWAmBFazOWw1yLkvQ0wsCDbP0YMh
 Dyp8auACsW5Rlp4iMZFnkAz3t+4w8+syjjasL29lM4rv+9O0/+iSAg2kQddNVvFZ4V3KbrAp01
 W5m/XEcHxvQzmfXAAAA
X-Change-ID: 20251125-topic-am33-clk-regmap-dep-v2026-01-2682a39beeda
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MPwN4t/KLit2KqJDTjSw2tb7F/oZJ/P+ZMI/dvxpmiw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtlpqTJsoJ8zaKHtz0UPfWXrtzjn4N9g3xHw5HcJyyP
 yfl6cHUUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPZVsvI0Phb7PnzVm3bbzNE
 ohtta2c8mthSWMC+lD9c3EhJ+XjDFUaGywp+rbsPHOJyOPA57r5WxudJf45sylK9saGgfLGUiyU
 XKwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

this series cleans up the direct dependency of ARCH_OMAP2PLUS to compile
ti/clk.c which holds common functions for other clock drivers. It
creates its own config symbols for these common functions and for the
omap-cm driver as well.

The omap-cm driver config symbol is added as default enabled.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v2:
- Do not add CLK_TI_OMAP4_CM to all defconfigs, instead add the symbol
  as default enabled
- Link to v1: https://lore.kernel.org/r/20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (2):
      clk: ti: Split common omap2plus functions into new symbol
      clk: ti: omap4-cm: Add Kconfig symbol

 drivers/clk/ti/Kconfig  | 18 ++++++++++++++++++
 drivers/clk/ti/Makefile |  4 ++--
 2 files changed, 20 insertions(+), 2 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251125-topic-am33-clk-regmap-dep-v2026-01-2682a39beeda

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

