Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9803C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F671807D9;
	Tue, 11 Mar 2025 14:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GAEWmELH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAB780FB9; Tue, 11 Mar 2025 14:35:33 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BA38003E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2b38896c534so2629728fac.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741700129; x=1742304929; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Si6cYkRBZRPTuYkaZqyDflfr0lAVKFNSXfgSiR+OLbE=;
 b=GAEWmELHCAPnoIdlXcy6iT9qiDdq8HDUaq86Ks9gv/X5Ge4pCJzLSRfBwph8dHrUqw
 VoFaDQDaiknaXHvL4YjrLiXd5g32/bXSg+z+XkaZOBPB9y6nfCdrodjvXIgSfrLJX99E
 9gqRcuWjMyGpkSWUYOC1BG0tblMG1l6f/CaCZczd2Gt623IpQc69v7Eso09S8ROOnp9X
 4YjyTMjfz7UBvoaES5qwfUv6dm0aq74RpT7+UNP9T7WvA7H2hdWnvGRKQI2EQhd45txH
 jLwtZsDKxr9shQ+8VATnEgMj8v/qR2wtQudGKVEn6lAS1gAJXyPmxUoVoAKPARkm/Jpg
 oqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700129; x=1742304929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Si6cYkRBZRPTuYkaZqyDflfr0lAVKFNSXfgSiR+OLbE=;
 b=tAcp1qZaBUokkmwzXVsZQgEn880riUz4cZ1qs4BKB8FlpzyT9bxgfCKhcVdqYGnuam
 Yc0ogR2q6p8gjujr8QaP+t1eR7+79wIh11c61EemJvSgplm/Oyh1w+PWAXG+BYzP/OCv
 61jghAcG7u/+B69jk30kdztQFz87f2LBbRtjHX3uMHs9VOogKf6Dmh1IVvOEhQQb7pIT
 DCGmvw8h+uyRwl/AI5zQAYlCtpFTkiJJ3iD4cdrLK4nmh6NRpYE24EtdVQye22HkdkCR
 k+9BSIcMX07MFgOpwt3mPBwnCbPlRdVR4kxXrcTtuTY0fpx/c2otp2PCiO/0OCn8CqFO
 fGNA==
X-Gm-Message-State: AOJu0Yy3tXe/djKrLL++OLJLUadZ+5S6kGhnI92lo4fj6RRIk0QvELB5
 Z4MPzDL97AzgA4TFSBtSTnSYVsf3L+OKA3Vz/Z2HCpf86trAYfwSBXd/wPCm4s0qsz7htkG0zW5
 SvO8=
X-Gm-Gg: ASbGncs+2+PaxpPhVzmhu1DtABvnl0kfQoqNn6k+ii7rQ2AnmzLJ/hRrAN4WiB3vxHX
 3KCa+FI66Z3v8863zOU2amRHAqOKNAM8YkEMbGvmel3AHiZO8QFswnMNnNgeR9XtOduXtwUhw5j
 QvS4qftMFI2QuRwde7A9OdXPatsNZC61d4gGG3voQBk9ZkzkBcipiCRiQXMVHkPQ6LIaE3NVf6d
 EBQPVKj2qFuMwteCxoGlAVhD8pXGyd4GfZI80VfnimR4NkWSFZJXV0PxTRO8eWlprl99Del1vhO
 mK7T8XyTC75xtclucmo1zQ6ARy4dm6pmyTZSfOirntd0fSqmTiOKWNcdsREVn8v9cA==
X-Google-Smtp-Source: AGHT+IEvrCdWt0eYRG645DaU2//cpoF2pLLLS9na65hAxbFnUZhSyXgVX3XIZ6SUZXxi5hdpKN79ug==
X-Received: by 2002:a05:6871:358e:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2c2612f368amr3871780fac.30.1741700129240; 
 Tue, 11 Mar 2025 06:35:29 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-2c24883035bsm2578036fac.5.2025.03.11.06.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:35:28 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Janne Grunau <j@jannau.net>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v1 0/3]  Risc-V 32 bit/64 bit images
Date: Tue, 11 Mar 2025 13:35:02 +0000
Message-ID: <20250311133506.124914-1-mchitale@ventanamicro.com>
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

This series adds support for building different images for 32-bit vs
64-bit Risc-V CPUs and also for verifying the target arch of an image
before booting it.

Changes from RFC:
- Rebase on latest master branch
- Improve commit message for patch 3

Mayuresh Chitale (3):
  riscv: image: Add new image type for RV64
  riscv: Select appropriate image type
  booti/bootm: riscv: Verify image arch type

 arch/riscv/dts/binman.dtsi      | 14 ++++++++++----
 arch/riscv/include/asm/u-boot.h |  4 ++++
 arch/riscv/lib/bootm.c          |  4 ++++
 boot/image.c                    |  3 ++-
 cmd/booti.c                     |  5 ++++-
 include/image.h                 |  1 +
 6 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.43.0

