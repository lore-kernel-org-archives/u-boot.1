Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41861C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 12:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFED878FE;
	Tue, 16 Jan 2024 13:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nJ86L53D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D4D6879A0; Tue, 16 Jan 2024 13:36:58 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C12878EE
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 13:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28bc7155755so4929374a91.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705408614; x=1706013414; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2xeu+GM1OYQX3eyV17tcSSH4221NiYuNh3VAbwLNh2A=;
 b=nJ86L53D9G3Mg6WFxKGRItjR0IM4TG0oWqDq5qUVvAoYFBbHuYNr7cJWUqoP6VpQRK
 3EVH8ZEqzWzCBxMR+qyiOsgQPw96neK5uNKONngnxMbm+JOXsxjdSU6ChUtUreWRLH9Z
 qhTZ2qg6aPy31nFdi38/91oWSIfkJ3d38+sShZeLuDKGLrMaYAnVUnhgpL7Bfio/6Ocg
 uleyoIsza79tUBDdyU2m2J8iT8N6l9KmzKRtkHvYgDxev1jrlTM4JYuiHys3IGs9wTdY
 wTXfeYJcoVjLGazb9Qd3jfNkWuNPPS7gH5MiQxjn0kwMDrd81dGuRMbX3Lsq3vS9OLZY
 8Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705408614; x=1706013414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2xeu+GM1OYQX3eyV17tcSSH4221NiYuNh3VAbwLNh2A=;
 b=hFTprSvC3qqcX0MXiuAxQzXH+gwsvWI+ZhacQsFQ9DoKXSFKqkaYkHQmhg4m/r9Rr7
 H5uvWB6vCjDkvfiDBcMrqRksxRxaibHTJcYP1OP2G4KeCKKg1YjRGST2VlgRlk97mefj
 NZNmYOYy+MZN2s4scg3aANeWJYqRW2c1FOpx0B70GUVjxY4z12RjZ+KZ+Elgg/wIe0Ah
 w6m6SZ7dOMzcCj3A4Fu0lB1aCGLrDTVEngOxEWJU50hx2t/EZ0oYaD/H7J65mEKoXRD9
 DNDAc2NtAgV5Bglf+vSTWOko4Ib3DrGyj4IfTQdTIucW26UCg8amdlOeyik1OLhIUXVN
 Vw5g==
X-Gm-Message-State: AOJu0YwKqtHvUJofiX6VEAzkkY8JochqUpL145+8+XoJu+wNSb25N0Jr
 a3SG53P9X7nztKmhf1MKrTQSOwlwfU/e1g==
X-Google-Smtp-Source: AGHT+IGSc2V2gOqPuWk/sBXPip8fxDIqtkUnF2b9pBNJgPrJnUOkJvtlmO05x05M0jwJhZSm9f7h3w==
X-Received: by 2002:a17:90a:dd84:b0:28b:a14:8172 with SMTP id
 l4-20020a17090add8400b0028b0a148172mr3873208pjv.19.1705408614534; 
 Tue, 16 Jan 2024 04:36:54 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:562a:8545:ac:19eb:49f7:baa8])
 by smtp.googlemail.com with ESMTPSA id
 mt1-20020a17090b230100b0028e8160327esm449544pjb.0.2024.01.16.04.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 04:36:54 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Bin Meng <bmeng@tinylab.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Johan Jonker <jbx6244@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/2] SPL EBBR - EFI System Partition support
Date: Tue, 16 Jan 2024 18:06:41 +0530
Message-Id: <20240116123643.563412-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

This series adds support to locate an EFI System Partition on a disk and
boot the next stage from such a parition if found. The next stage image
is expected to be under the FIRMWARE directory as described in the EBBR
specification [1]. Also update the spl_blk_fs and spl_fat drivers to
prefer booting from ESP and fall back to the configured parition in
case of a failure.

Changes in v2:
- Rebase on latest next branch
- Enable SPL_ESP_BOOT by default
- For NVMe boot, remove fallback in case of ESP boot failure

Mayuresh Chitale (2):
  part: Add a function to find ESP partition
  spl: Add support for booting from ESP

 common/spl/Kconfig      |  8 +++++++
 common/spl/spl_blk_fs.c | 51 ++++++++++++++++++++++++++++++-----------
 common/spl/spl_fat.c    | 34 +++++++++++++++++++++++----
 disk/part.c             | 16 +++++++++++++
 include/part.h          | 11 +++++++++
 5 files changed, 102 insertions(+), 18 deletions(-)

-- 
2.34.1

