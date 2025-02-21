Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742EDC021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 12:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B0F806FE;
	Fri, 21 Feb 2025 13:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V1o4+t7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5E680EC0; Fri, 21 Feb 2025 13:59:24 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8DE8039E
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fc11834404so3293142a91.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 04:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740142760; x=1740747560; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ntHUeJHZyXl61TpY4nHxq3ttkKxjsb+9nZR0Zt/Qzdk=;
 b=V1o4+t7X9SzMqa7fcF8FByJZ8FNJlJyE9Fjq62jDWkBOab4GrhM7VgFq2AedUDZB6m
 qGzHmCZjEwHHMLwN3RtwV9Iy3Rv+heIpZAAO9oIlIb39BgfXFlJE7uTvlWaFa5L7jpi0
 XSmMtaFvvwEj1aI3n3XgcklGgDmRVtCN8i7UYHh7Lz8dSpXSGPjxx9+AfpVKFVUvEtez
 FPg1A/pnNOeDEJ+yxlE7aBimjNcuQdAqmRXS6PaVIRJGhJGB5haxPpxY5bXOCbtZzaY9
 v+6EXPx/tis3Wt95J+0jGZHYgBSCal0HzM5L/DmnIX/HCc7HyP55GKGVeUxvF6R7iKvS
 9fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740142760; x=1740747560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ntHUeJHZyXl61TpY4nHxq3ttkKxjsb+9nZR0Zt/Qzdk=;
 b=MR2LFuzxlmHNm+IFhRq0pcRbW4gKb8IJYtZvROZHYmOV4VEIM0Z9Zp/CPPFDXrE9qg
 KrmY+oVWmLXKvzeDCBG/UdQlJKoFhr7Pdy1vYeVn2dsAqhyKcTDa65RFT9Db52WFv8wv
 nMxEx7vsm2JqPPLPseK+SBfFJaLLphxRUaBn1Y4Rcp5mwmoX0MMfhZMJKWsW87WYKYz9
 WhFVcEif1FlZGyfVUIiubD5S8LqKow2A1H1SQotA3QBGJ3jfBf6V79h4vymROVR7iPZ/
 5YfLoPsEY6jEimEH0SRdtUzuwC5VHoJ9JRa+8ZecKM794aEKdr2UTE/RGw6CA0DjIAk6
 BFfg==
X-Gm-Message-State: AOJu0YyGDpArFKggK02NUGQEGsUui7aU1rBjbJGc0hPspCHR5hfc/UDk
 wSXzLrXLms24xnueq+6Pt/j5WNmmhP9JttRQWvjAPe6RlrrCZwx8afbIueXtvNRPeNig5kZ8h/s
 qauo=
X-Gm-Gg: ASbGncu+ZqHdjzNcRlU8Cleb5VNcVcT3D+zYr6hbZQp7qbQzJULiMkEFC3vCmDZvzIZ
 /D8St1noHio+zR3qRXcB7RMj9a2ViCbHmpsavFixXN0hQp/NF93G62L9paQx1FcJpD2+Hk+DjB1
 XVj/zRXdNJdGb8TwQm3VL39jLSm1lO6OgrROiu8oLpk1xm+UCiUCH64BacfuZSBNH7g3sOaLqKP
 Z15agC75HUKNa1AVwrwE3fvW4/DGf106fXjwJxGakO69cDtl+F9Lo5MQX/HIxD8607mvcTMHsk3
 V1KJvMUiL5+JEpmU4z2zK+4=
X-Google-Smtp-Source: AGHT+IFjMSzrH2RuFdvehsqHxnc8lZzYbPlpg0hWaa8DUWkjKPTPh5JjqvIdLxOHXPKgh9vuJ93BwQ==
X-Received: by 2002:a17:90b:3cc4:b0:2ee:ee77:227c with SMTP id
 98e67ed59e1d1-2fce868cbb8mr4103533a91.3.1740142760570; 
 Fri, 21 Feb 2025 04:59:20 -0800 (PST)
Received: from vm.. ([106.195.8.203]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2fceb09f6basm1273971a91.42.2025.02.21.04.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:59:20 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tom Rini <trini@konsulko.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Janne Grunau <j@jannau.net>, Sam Protsenko <semen.protsenko@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH 0/3] Risc-V 32 bit/64 bit images
Date: Fri, 21 Feb 2025 12:58:50 +0000
Message-ID: <20250221125855.300717-1-mchitale@ventanamicro.com>
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

This series adds support for building different images for 32-bit vs
64-bit Risc-V CPUs and also for verifying the target arch of an image
before booting it.

Mayuresh Chitale (3):
  riscv: image: Add new image type for RV64
  riscv: Select appropriate image type
  riscv: booti/bootm: Verify image arch type

 arch/riscv/dts/binman.dtsi      | 14 ++++++++++----
 arch/riscv/include/asm/u-boot.h |  4 ++++
 arch/riscv/lib/bootm.c          |  4 ++++
 boot/image.c                    |  3 ++-
 cmd/booti.c                     |  5 ++++-
 include/image.h                 |  1 +
 6 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.45.2

