Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE64BC25B79
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0001D880A5;
	Wed, 15 May 2024 14:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TaAvdHYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D4BC880D2; Wed, 15 May 2024 14:32:36 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385EB88013
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34d8f6cfe5bso5306912f8f.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715776353; x=1716381153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IwL3uAIQIH65yIVGk63of2C/GXaqpV7gvAyRi6DoR3A=;
 b=TaAvdHYDHqsqA2XXiTt64ZiaV/dbO7Ndf/vF5CTwOlUq0yNW/j6lDr/2nDTBWuUHcN
 lu44yuqC1w0ndDMTOrnKcsfsHDDuYuWxrZVS5x+598hpu3TgGPZ5zO+Sm0BAqaGTOaHA
 r24zYOuqSRN26+nfufYghOKym6t4NUJGSYvbTHXRcTZKpTjQilDHEQN5bl4WmhBmLhZM
 CVGa+lhVSmc+zgno1D/yaF79sTkjKtyfTe7cBGHovn/ZW5C5nl/y/nvFBsJBJ8z7M2HA
 p2adnnr2TtoCD8nrXg8VJJdmwBjwhU7KbL8gPAEVbRKwtJvQH87ksIxu8GCLt4PmRVHq
 wxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776353; x=1716381153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwL3uAIQIH65yIVGk63of2C/GXaqpV7gvAyRi6DoR3A=;
 b=F6MNRhcQFk1hlsldhtuosllnXOPSD7N/J686C5KBjrPe00phAIVKlHZDzM/iw4RaW7
 ihsX0hP7jjYodXvXbPVhWYdoDXo98ixwes1oy49asJRIM+jXWqd0hVeyJmVBiiUMnDhx
 O/n+2SBvykfEjJFl28eZt2ggIyvwLLqC5FvVxKaxpi89UA5BDexDWACt3sN+xYG5JC7D
 HPoTN8k8B5TO0vjeMgWB6EIm0bzAva5U1i8xldxzRmJWLXtOccaY5hVkmhqN1J2FoJHl
 XpJnsKS5sD61CX04LIHuVSstxTOliJU/ITE4EqsQTohlEH3as/qzgsAgM06lRDA/1jjw
 2jwA==
X-Gm-Message-State: AOJu0Yw0Vek86THsshM3axY0/2/FrfG+/k0k2NulI9YUGwjq9dgS30qq
 6eDzZpA3A9VzeM5FmPrPxpBGLioO6R0QajO6OfrX6uwqxLCf//oWTs1WJXFsXYfQU2q/8GqFmTr
 B
X-Google-Smtp-Source: AGHT+IF7ezRxEoFfjmjM0cGLL3dM+ihURgsJ79RWV5gQQgv5pHpMg2eXWXZg6bpL/RuKN1eqe+RatQ==
X-Received: by 2002:a5d:4e10:0:b0:34a:ed29:8d1d with SMTP id
 ffacd0b85a97d-3504aa62eefmr12182826f8f.64.1715776353034; 
 Wed, 15 May 2024 05:32:33 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad042sm16406896f8f.80.2024.05.15.05.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 05:32:32 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Tony Dinh <mibodhi@gmail.com>, Phil Sutter <phil@nwl.cc>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 0/4] Clean-up patch set for MbedTLS integration
Date: Wed, 15 May 2024 05:31:55 -0700
Message-Id: <20240515123213.1701691-1-raymond.mao@linaro.org>
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
 cmd/part.c                     |  2 +-
 common/button_cmd.c            |  2 +-
 drivers/cpu/mpc83xx_cpu.c      |  2 +-
 drivers/crypto/hash/hash_sw.c  |  8 ++++----
 include/stdio.h                |  1 +
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
 21 files changed, 27 insertions(+), 49 deletions(-)

-- 
2.25.1

