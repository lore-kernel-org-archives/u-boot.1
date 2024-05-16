Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2888EC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53F6B88459;
	Thu, 16 May 2024 23:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SlioGL6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFD78841A; Thu, 16 May 2024 23:12:05 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE9C88463
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 23:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5a5c930cf6so361715866b.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715893922; x=1716498722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+1WQZga33AW+n7NBX+isvfmcKIKI2o2iCowhO+9bYJ4=;
 b=SlioGL6u5CHA3Gg04Z/mkOGlK3Q25yrN7f+nrT1G00pN+lCeTniqbwcA3Eo6LgAQZh
 YOnDnEVeozzzlNYVzx1gnqEM0pMErKHyi8bTw2uwH+JyuZzARVH93SeqTeGMMNMyiR/h
 aZKswUze0BBE3dl+AswVq3RMKaVk/CMByrroQUZswbQcQvettH9IYr+lEFoNVcv29s4U
 LWdMUNyQzcSDz246JBK406L0NYQJ5QEbvOTy3ZD9p6MTMRMhMx6uNnLoxKu43NbyJPCw
 qMuJz746ee9C7oGoAd7PJ15Cl8Cb3BnElJtMEa4hC0z+jybxWyc4d9/FARkfO7iiVUeB
 Sn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715893922; x=1716498722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1WQZga33AW+n7NBX+isvfmcKIKI2o2iCowhO+9bYJ4=;
 b=ZW0RqKeKMlYGbaoCCH5g7ex2i2rVJb4GevQWvYgKMry5C5RUcMcCqmp3RCI1gLtpx/
 7UsPfdYoC0LMW+lqMaZaXiG+oUG/jq1OX4T+RnT09mFgGv5RV8U/h3BsCWflzBXFWcJJ
 a+2RvDkSyRBb0K0fEd2KOB+vhf1PgBkA87IsvZS9LUocYDGxigO1eC8lyaZ+mMbI84BL
 j2KYizzLX92Nj7ZTB/YJ/dMUlWo8eYo/JudOjLaEOFjlFNi7RyuohBbg7LZQAr2r5sY/
 0RgkYH0LHL2f/EiRq2+ZPe1WTyQxKNQV0ba4O6czYthUwFV8O2TebhgrlTIErKsKv8Q6
 Dwqg==
X-Gm-Message-State: AOJu0Yw2NBPoI/NN6HOdVC7501mo/8eVaVC840R15ffEdAfe7WYhmYKf
 cAocfl/yqzTgCELzX3jQfmE5pctmltJZ3XiyTEB+Ci8FnHMe+TqIuqsbCQoxpBi3GrxIL0ewFf0
 j
X-Google-Smtp-Source: AGHT+IHBEdXFsitnMW8kdU7dSDS9Mip1BiiXDs+Vgv5T+cbExmURBFqCgNUGV8fExi+bmEzyV47bmA==
X-Received: by 2002:a17:907:8687:b0:a59:cb29:3fb3 with SMTP id
 a640c23a62f3a-a5a2d666ad7mr1643580066b.53.1715893922327; 
 Thu, 16 May 2024 14:12:02 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d09sm1021582266b.107.2024.05.16.14.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 14:12:01 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Phil Sutter <phil@nwl.cc>,
 Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 0/4] Clean-up patch set for MbedTLS integration
Date: Thu, 16 May 2024 14:11:48 -0700
Message-Id: <20240516211156.1819939-1-raymond.mao@linaro.org>
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

This patch set is picked from the previously posted serie:
"[RFC] Integrate MbedTLS v3.6 LTS with U-Boot"

They are not directly related to MbedTLS integration, but the
prerequisite for a few clean-up, refactoring and minor fixes.

For V2, the linker script patch is dropped and added one patch
to move the snprintf to stdio.h

Raymond Mao (4):
  image: remove redundant hash includes
  efi_loader: remove redundant hash includes
  md5: Use typedef for MD5 context
  include: Move snprintf to stdio.h

 arch/arc/lib/cpu.c             |  2 +-
 board/Synology/common/legacy.c |  1 +
 board/ti/common/fdt_ops.c      |  2 +-
 boot/image-fit.c               |  4 ----
 boot/image.c                   |  2 --
 cmd/part.c                     |  1 +
 common/button_cmd.c            |  2 +-
 drivers/cpu/mpc83xx_cpu.c      |  2 +-
 drivers/crypto/hash/hash_sw.c  |  8 ++++----
 include/stdio.h                | 17 +++++++++++++++++
 include/u-boot/md5.h           | 10 +++++-----
 include/vsprintf.h             | 17 -----------------
 lib/display_options.c          |  1 +
 lib/efi_loader/efi_signature.c |  1 -
 lib/efi_loader/efi_tcg2.c      |  3 ---
 lib/fwu_updates/fwu_mtd.c      |  2 +-
 lib/hexdump.c                  |  2 +-
 lib/md5.c                      | 10 +++++-----
 lib/vsprintf.c                 |  1 +
 test/dm/scmi.c                 |  2 +-
 test/print_ut.c                |  1 +
 21 files changed, 43 insertions(+), 48 deletions(-)

-- 
2.25.1

