Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D194C4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3937F87CCF;
	Fri,  2 Feb 2024 13:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CqHTPL95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9700875E9; Fri,  2 Feb 2024 10:44:36 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38498756C
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6dc36e501e1so1241850a34.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706867072; x=1707471872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S9kbkLuji1zKdxu7IbA/Lw0uMdeE+SXILZMoqITs84s=;
 b=CqHTPL95TGHIp5liQ1xSJik3C/EBbisFmnqOyiEC22eY6rusvMhhY2VHybo30qPm/Z
 fi6NpouKn0F9BHNUirSAovdSzuLzt9EUxqPMSW10/8otQH19XkiM75ujUmAud0333Yl6
 vK+ujr16NAWJNL62Sz0k20XQ8k34KkmZiOAiLLbamhjhbNY+CFGvtN6ZfpTcpYsTTWj4
 CD0cowHsGlPh1or8rJ/JnGDal0/lef/qLCi1EBSTe9XigtxlmAdT8hj49cAEHIjnLwo3
 xi2h39h6W7QkFkzhn9orSCH1DiF1CA7I4qEwwHkzm+7iX3W8c1sAAzZdAqY4QxSLrAKa
 C63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706867072; x=1707471872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9kbkLuji1zKdxu7IbA/Lw0uMdeE+SXILZMoqITs84s=;
 b=bRdf0RUkTq2CIl5c5Yo6N0116kU3q0o/ERqh/tAUcCBdnMIi86qS3f0C6FxpH6jWUy
 YwzRiMxE8pu8h5JABGbfDfuB2Y4eHgupAE0Pyy2/uYHSW6x+vqy4ISyVd+XfFB5FEEOI
 WTZJUXYWVCeRXSWQwhfqtDrDeFU9oGGYHThrRvCvqsf/0g9OO6b7nNc5OXcRBZVbXDrO
 m49iFplKaTB3ib9L3NhAERRu4IkJ/V2HyRludOJc20o98pSZbBOL35lJyrhUuUXB8+C7
 uuUYNM2eQ0IGBVWO/36uVNW/32BE4E7lhr0xBp/b3pAZFQ7x7W3xVzBrrOq/tvceLnZf
 pPIA==
X-Gm-Message-State: AOJu0YzOa4QYle5Tn6oKl4T0A8qBfgwjKuYE+GyhXTAKJJ/4WOV8yY7t
 6hH1KMWkbQIURW/RYJciu89u9UusoAPaZd0xbuSgfoq9tVvYHxcOCXsGM1YORfO9dpWN
X-Google-Smtp-Source: AGHT+IF8wM1+OfjgG12ZIUhkzJs10rRbxXCuILOlmJWA6wXdScpLrmWlrlaVzcqrwb7xOFjcEeBNNA==
X-Received: by 2002:a05:6830:1516:b0:6e1:115b:fdb5 with SMTP id
 k22-20020a056830151600b006e1115bfdb5mr7491016otp.19.1706867072382; 
 Fri, 02 Feb 2024 01:44:32 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUSzRVFJDUlWFLC6oMICG/+V8eSbMV4DOiXO5iyC67cm0t2Hax1X/dHX2nVdoTb7gv5wzXEit6Bcjybt8m7EtdCZdHd+aR+yGgBbKgzWPP2ukePC6UwSjkteFqVccEL1Bovbppng3gBPOG+ICcdvIWqwAZwnQqBTaIwSVOXZ03HoOL46vJj9EaqvE/mkM/8QEjdnGKfLBM/9b1itpbLUpd6ojvn2dv/Ee4x2MpKzyw7nFqFfzummI+KnKkyJXduo4nlwvVVyDZ5WSOQmV9eCB2cAGxxpgTY3oNZ+7NzGrQbfiI/9TAzEhokhFAPjDl9BXg793m1z39d/xpAgcBjtEDEX6pPuTRLqq9L2FgA89aGbsfTE0AwUycYpx3VQMZkSQINO0eR
Received: from localhost.localdomain ([125.126.161.226])
 by smtp.gmail.com with ESMTPSA id
 fn27-20020a056a002fdb00b006dd8985e7c6sm1190979pfb.1.2024.02.02.01.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:44:31 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Geis <pgwipeout@gmail.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] mmc: sophgo: milkv_duo: Add SD card support for Milk-V
 Duo board
Date: Fri,  2 Feb 2024 17:43:32 +0800
Message-ID: <20240202094418.334221-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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

This series add sdhci driver for cv1800b SoC and enable SD card support for
Sophgo Milk-V Duo board.


Kongyang Liu (4):
  mmc: cv1800b: Add sdhci driver support for cv1800b SoC
  riscv: dts: sophgo: Add clk node
  riscv: dts: sophgo: Add sdhci node
  configs: milkv_duo: Add SD card configs

 arch/riscv/dts/cv1800b.dtsi |  27 ++++
 arch/riscv/dts/cv18xx.dtsi  |   6 +
 configs/milkv_duo_defconfig |  16 ++-
 drivers/mmc/Kconfig         |  13 ++
 drivers/mmc/Makefile        |   1 +
 drivers/mmc/cv1800b_sdhci.c | 243 ++++++++++++++++++++++++++++++++++++
 6 files changed, 303 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mmc/cv1800b_sdhci.c

-- 
2.41.0

