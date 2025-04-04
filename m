Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB44C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA4082A0D;
	Fri,  4 Apr 2025 16:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oKcFU0z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EDE82A0C; Fri,  4 Apr 2025 16:49:52 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897F0828AB
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 16:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224019ad9edso28922065ad.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743778188; x=1744382988; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3+88lxcyigCrziUjCy8/JMVtxotNgrX6nDbP8CR55I=;
 b=oKcFU0z+yVZShk8EL7GY6Ue/fvyjYaPJeKnM2hl/8+INKl2GZtBe/mHH7iydmIu6UN
 CKmUpZB8z36dIC2i2Lc+YHoTi4IqQEvSfIgCa6OukKfMNNgGp+yTB4B5wYmY+lmyGCHp
 VN29uTWuynL6NnsjzX6FLhjpYHPjfpYtb643sDJOyP7E9XYAW8gMFLqYVoJZl/glBYfZ
 3whj5w7UEXOTorc/Sm7NeSL0rD8CVQ/pBOeb9abCsUBTBoPPc6X+/FKBnd3zYyRUbMbA
 XKLlqcKLPaqKRRyc36qd4HJE5zslzLzm+NcSkI8P69WHHmjiDTm5cGAtc5mkWQ1+x54I
 a6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778188; x=1744382988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3+88lxcyigCrziUjCy8/JMVtxotNgrX6nDbP8CR55I=;
 b=ZNqrhUPf4wkpbMyKYgR9N4CKijCrmSfowwV2gPvDJ1598EH6whIK8BQqtC7Gk6YfdX
 UTnCdOkoCWGMzVCp0+4xjZTpYOXWRP3jKiw3AxEXSNprR8U1jC1QqLAQk1t/QdnXj769
 C+J+VV5q+dC/n5IQkPJNi+wX8mj/6OUiv2oVSLpHPvLnMljp2arK9f5h4vZjpYrlM5vF
 H0K9YzCqoJYbtH455y+5ebRkEHDARQhadRT4n2KNSNoIWImHBDciu/Pcr+wYQHHDeJLo
 VgDq18Q4+kT+JUKzgRzU53nwrk/fHK+NmE6YPz0/LXDsYWdKf4ENnontV2A2oYwd0LpR
 BFZA==
X-Gm-Message-State: AOJu0YxWbRml0sE99EN61auRICTSVWUe7Opqh/jqOvb227lOwIh2+c7+
 0z3WLf/oZP8eyip5s7NKik8EXv1TzUmsLlKvJFuJPbK2vGeybGiQ+LgPPaIy9sWrrNnsNGvLpVB
 m
X-Gm-Gg: ASbGncsLmAZdlbe9gfTAFt9spHMoPaIRpoOycT+taG04/kj3Rljs4miLFCnXw/1kzBI
 RW38kMWaSJuvOBfXIk6ZY62hAQF/nA4Y0x0xNv+xloUn58wOdT0D6gnxoC8tYjHZsAD80FrBV7b
 EprNk1WnC8HExEQCFLdY0vfMWZ4LcjcPXtSkjYmI7unAuYi6DI3pUPO0tvnwz9Ez6T846D3r/4l
 dnZA4TH11sHYYQyWOP4EEfC6Uv+4W1x+wZk+vVbd+YDWqJ5TS+0cva0DjYARHCnYfmiD0Xt9FeU
 e8xQXWj1QH7O/HMxjOUcnlXtZxGbC39m5F332jL2mMUynZqLm3HlRlVKQU8MpUsI3Q==
X-Google-Smtp-Source: AGHT+IFwbNNirXEykX1Iz3svsdQGs35InEF8IvCD65qOUrsvzHiTGqXZQJRScnso803NhmsLheHT8A==
X-Received: by 2002:a17:902:f547:b0:224:76f:9e44 with SMTP id
 d9443c01a7336-22a8a045df2mr32148405ad.8.1743778187779; 
 Fri, 04 Apr 2025 07:49:47 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2297866dccbsm32950705ad.176.2025.04.04.07.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 07:49:47 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 3/3] booti/bootm: riscv: Verify image arch type
Date: Fri,  4 Apr 2025 14:48:57 +0000
Message-ID: <20250404144859.112313-4-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
References: <20250404144859.112313-1-mchitale@ventanamicro.com>
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

Unlike ARM and X86, booting 32-bit images on 64-bit CPUs is currently
not supported for Risc-V. Hence, for bootm, disallow booting a FIT
or a legacy image that was built for an arch type which is different
than the current arch and for booti, set the arch type to be the
same as the current arch.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/riscv/lib/bootm.c | 4 ++++
 cmd/booti.c            | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 76c610bcee0..90f71bee6a5 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -94,6 +94,10 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	announce_and_cleanup(fake);
 
 	if (!fake) {
+		if (images->os.arch != IH_ARCH_DEFAULT) {
+			printf("Image arch not compatible with host arch.\n");
+			hang();
+		}
 		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
 #ifdef CONFIG_SMP
 			ret = smp_call_function(images->ep,
diff --git a/cmd/booti.c b/cmd/booti.c
index 1a57fe91397..ced2c1047ab 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -130,8 +130,11 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bootm_disable_interrupts();
 
 	images.os.os = IH_OS_LINUX;
-	if (IS_ENABLED(CONFIG_RISCV_SMODE))
-		images.os.arch = IH_ARCH_RISCV;
+	if (IS_ENABLED(CONFIG_RISCV))
+		if (IS_ENABLED(CONFIG_64BIT))
+			images.os.arch = IH_ARCH_RISCV64;
+		else
+			images.os.arch = IH_ARCH_RISCV;
 	else if (IS_ENABLED(CONFIG_ARM64))
 		images.os.arch = IH_ARCH_ARM64;
 
-- 
2.43.0

