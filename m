Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC30C36010
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 19:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC8681D3B;
	Sun, 30 Mar 2025 21:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VzwtcUcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E6C81A0C; Sun, 30 Mar 2025 21:27:08 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC6F812BC
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 21:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so6096740a12.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743362825; x=1743967625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z6QWu5n3rqLZ10jKzlITRfuH3kc/W21CIsL4q0hJECM=;
 b=VzwtcUcNJ5aQZrd8JCw2vTz0+AHJzVim+Oci68Y7PqTvtvtkJdHNPBKaZ5PQaJxdH6
 ETh8mtoVWT8Onqkya6sy6/IGm0AAAkUG0NGIgb+O2zi/lAVi8bF9e3E8wyDwyKUh+UtT
 KuaLC9cT5n+Ds5niqSKlFi7ue7iilItGWDp5fEB8326oSZQZEUA9JooOC5m/H1pczUhR
 CZu4x6GWusfMx3bcamFUDaMDfWhlMeOM7D705LkFbL1Zgq4vT9/fT7dzYEkKCFcFZija
 zeDAsYgPKUj/9Mq0Qalj4Pgev57H6bP6slFBDW+ewj9GYxZeGTmTt5YE9lHuXl3Cpdw2
 nw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743362825; x=1743967625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z6QWu5n3rqLZ10jKzlITRfuH3kc/W21CIsL4q0hJECM=;
 b=MzKLv5dHWDMrF8Q4O/4Sx0AR3wrTfSIaGREUmO9oiJjVWQX2qs+QoHstQuA+X5v+vh
 VMwjX8t0XMCdPyt5fkF8V3VruwErc6LbJep++TxMWrql28pbatLHpUa4BP0ogf0RHihD
 7m64E0K64oSObGX0WOKo6N6MFYQSMkZaWcBUYUZ5INCRHYDpUgbIAw6MUlsnmkzBuE1b
 Jybq/TAIH/4bbIcDmIr9Yj6xDZ+/WTkO02CLBmG4YXXdxuBIdIiY5i8me6v97bV6ZZui
 gFk7y3kVgWAZhiFm02RSEfyX9TCZHvQ0+f5sJ8iZKVt2vsik24eqqdvzTHZsNztyJnld
 JfMA==
X-Gm-Message-State: AOJu0Yzslo8GVKlVF/gelft/8MaySB6P5VCSdX33I6WTWGNKmhQMhTzm
 0r9iEKRI5vuPilTnGCK27qbuhBIoFeaBZiP8MEnOUy8qZaXN+Vz2ANDjq10z
X-Gm-Gg: ASbGncu9zuCMjUACMBPI8NcE1xFFe9cTzXavpwyF1qAUsgk2UGSBNe5fuOdhj/i6qkJ
 Vzt+DQZS/XBmoEpndbJ3ri1d5hAwyktr1PbOif8TTE3Crwtl6g11cwTXf9G1vOv2MKbGv/T8cMx
 XVW/fqDes2xRC7xowUCFV95KivQChn/J1FFFYUrmG/8tOl249G9ta87uXk54TGtYGfd49z7yXDs
 C9koku/jaVtx/9PjQp3j18BPYdA8Px5DsntNmCZErJ2AP4D3CEPdlRXgwFFZTE0jDUU3t/x67Wo
 DOlUZK/gMRRxtSGAldfZN1aMe5cVHIAvUwpu6tD04mSB9/4C3aA=
X-Google-Smtp-Source: AGHT+IHxxm5gl5n6cyVpCOog0iVwAz3qt1o9yJhCCsJodgD00Xrz4ialycfCkAL9tZUPiFVjZhutcA==
X-Received: by 2002:a17:907:c1f:b0:aaf:103a:e6e3 with SMTP id
 a640c23a62f3a-ac738b4fa46mr525270766b.43.1743362824937; 
 Sun, 30 Mar 2025 12:27:04 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:1d7c:64d:f4dd:a029])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922029fsm522118966b.11.2025.03.30.12.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 12:27:04 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH v2 0/3] Support UART over MicroSD slot on Transformer T20
Date: Sun, 30 Mar 2025 21:26:38 +0200
Message-ID: <20250330192656.1280403-1-arturkow2000@gmail.com>
X-Mailer: git-send-email 2.48.1
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


v2 no longer forces UARTA to SDB/SDD on Transformer 20. Instead
CONFIG_TEGRA_UARTA_MICROSD is used for this purpose. Additionally,
user does not needs to configure additional DT files as that is handled
internally with preprocessor directives.

Changes in v2:
- fixed indentation of preprocessor directives
- added TEGRA_UARTA_MICROSD Kconfig option
- removed .dtsi for enabling UART over microSD
- modified transformer DT to use UARTA and correct pinmux when
  TEGRA_UARTA_MICROSD is enabled; it is enough to flip a single
  switch to enable/disable UART over microSD

Artur Kowalski (3):
  tegra: add funcmux for exposing UART over uSD slot on Tegra 20
  tegra: respect CONFIG_TEGRA_ENABLE_UART* options on Transformer T20
  tegra: allow to expose UART on microSD slot

 arch/arm/dts/tegra20-asus-transformer.dtsi  | 24 +++++++++++++++++++++
 arch/arm/include/asm/arch-tegra20/funcmux.h |  1 +
 arch/arm/mach-tegra/board.c                 |  2 ++
 arch/arm/mach-tegra/tegra20/Kconfig         | 18 ++++++++++++++++
 drivers/pinctrl/tegra/funcmux-tegra20.c     |  9 +++++++-
 include/configs/transformer-t20.h           | 10 +++++++++
 6 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.48.1

