Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01859C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62CD4816AF;
	Tue, 11 Mar 2025 14:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JQRWlzw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8DB581703; Tue, 11 Mar 2025 14:35:46 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CC4816AF
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2b2b6019a74so3085885fac.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741700143; x=1742304943; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjOED73fnntTZ+zKrNES+E2LaW1y7aRIjI3jvPRofyA=;
 b=JQRWlzw7YtX3TsaAJhUKLbUVjoboZ5rkVUG87CNzXFaPc58Z99Dl1w7b7Ad6mcEMGJ
 8Q9oG/9OiJL1RqGbxnA1OL+2dH6X/Yo7HzZwylK8ZcKUPRHXTEG5mRasLB/eYsEUMzQj
 ftdOhwyc59TIWFyAfpx3zgRJh7rW0CrDdP+NYu7jFEKzKhg3DtraBB4THQbDxC687gGC
 BodAO7pViUdLRjr4gWVFhnrL+rvomybo4eOOA3wXcOecrmRqo3gujxJ/IBunlbCADl0n
 RM+2X/Ih9E2URRxUcLHXq/XHWWuFptEXZH3d7bAvhL5cGMONjLxYG07tQukXtM1KlBOi
 iWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700143; x=1742304943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjOED73fnntTZ+zKrNES+E2LaW1y7aRIjI3jvPRofyA=;
 b=Xxi7FzX4xrlt6aqVJ7Ahpx/zNQ3dBHUcKQj8ToAwKg7OUsPSs6QNk0ygdAxFvia3Jb
 BK+R1vJkWPuDhqTNKtSI2YjwIcdM5cvOkNnog6zdFk15pg8JLxbGLlXtlqJ+qk36PvJw
 7M+lNQAmnHugeWGRfQ9yrht7CPCQBd/dSHb7JYbMyOR4V9sKPmq04AMBVh5KFVgoxqYX
 fwSyiKvnekJTk1U9rdCBZjF6v4MauwlvuaQ8cMqn404+HnUygN5GIsVEyydTWLTdFhG4
 bJL/Y5gEfYGMHbvFKWEVQmQ2CYOBok35BUqo8Mj+U+GkJrG31ByZct1f4262zzMJnCki
 C+Cw==
X-Gm-Message-State: AOJu0YyyyVwyXh02gEVFISWnjDDM8EC4h19fz15PlmiQ6zVH/olAv3uR
 0OyJ4QUT9cewHbZlDds0NBf2CV+U41rNWp/N8wAWQJhw8NbV8LJk+Wa+ejXPhB56XnN4J90cUdt
 6
X-Gm-Gg: ASbGncv2+0sSN7WqMvOowdwTNeVMKMgRbAnBOtLNSmLWNwfhy942XMU4AGU8fUh6lJ/
 O2FCBiW3iKmH3btpCcE+XjuTeYk/3hQAV+X0F+kI4oJQ+JrcphvjSkkCZgpwR8DZ52yx8lyteqw
 Zu72AuPFPeI8n9bFS8atLJS9203M1KN70hQX5/2Flt0nE346aob35wp5P/kS4ptaAAOMK95XRzS
 3UbV5FPooZVkwAxNIfJnX3X0ivX9efwax3ePsit2aHnf2nRcVN6OuRxBFbkfIqz1DKlkNeivhrG
 qPN+bQCCFwZRhocvJngo2zRBZF99G69QGAHToYezC/C5jBRl1zb8dgmPY4WCZNWvgg==
X-Google-Smtp-Source: AGHT+IEquvSC/G3AmSn+lAwLBP64KyY9+3rGR0IAaLQLqrVFGuun9s2N3bPd6AjIF0YXoG1jjvKfiQ==
X-Received: by 2002:a05:6871:e785:b0:2c2:3fad:760f with SMTP id
 586e51a60fabf-2c26138fa5amr8636559fac.37.1741700142818; 
 Tue, 11 Mar 2025 06:35:42 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-2c24883035bsm2578036fac.5.2025.03.11.06.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:35:42 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Janne Grunau <j@jannau.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v1 3/3] booti/bootm: riscv: Verify image arch type
Date: Tue, 11 Mar 2025 13:35:05 +0000
Message-ID: <20250311133506.124914-4-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311133506.124914-1-mchitale@ventanamicro.com>
References: <20250311133506.124914-1-mchitale@ventanamicro.com>
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
---
 arch/riscv/lib/bootm.c | 4 ++++
 cmd/booti.c            | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index 1a57fe91397..00921ec4a9d 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -131,7 +131,10 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	images.os.os = IH_OS_LINUX;
 	if (IS_ENABLED(CONFIG_RISCV_SMODE))
-		images.os.arch = IH_ARCH_RISCV;
+		if (IS_ENABLED(CONFIG_64BIT))
+			images.os.arch = IH_ARCH_RISCV64;
+		else
+			images.os.arch = IH_ARCH_RISCV;
 	else if (IS_ENABLED(CONFIG_ARM64))
 		images.os.arch = IH_ARCH_ARM64;
 
-- 
2.43.0

