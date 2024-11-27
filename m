Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3185ED6ACF7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41BE08958D;
	Wed, 27 Nov 2024 18:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JhkS+1Y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F0D89803; Wed, 27 Nov 2024 18:23:08 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C9378980D
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d4531d1309so207336d6.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728178; x=1733332978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yZKGpo3V98CBXIiznsYuO/LIiEdpDahL/lwFfxMw90=;
 b=JhkS+1Y2o+Spa5GqPzH/aQtG/NnypJYBsJKiVMFoAgV2Wn3pNF+yXCIGXOgMynV6t0
 B7X0jCTdVi64mBtg2SanYsuXLuCXnE5OGiHxyv1yYMuK1gTmHe/6QKdFWKg3VZk6ZYi3
 72mWblPohQRYkHWaXix5xjhgDCr5095IdKpbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728178; x=1733332978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yZKGpo3V98CBXIiznsYuO/LIiEdpDahL/lwFfxMw90=;
 b=R+dleEaK8jaaLnI2MpIUCB+gvU0ocbisklTKD7mp3LI+WTxf763kxGdwZD1Pg7Ehyr
 Sxa5s1lXF881O9+Y5FpzEl8wFOlnvg0pAx2etl82J+j/MfUe7Gd/IcTtLqVWZ/W0cqXK
 3jKRX7POaBCmaskvZ0sXVmoiCPNdiqMjOAgT6ZTVXurA3l7Te69fGVkx+Z0UWwaUaxpz
 55iEMvakT9VnLYxias2ObPq147pnppuqJZVZzDj/901zU8SDEFummC0WuVMKuMb93uwW
 Cc29EcPg+efjhBiyst3Xt8Q2vVUtUhwVQZo57t6io+g3/uw7qCBsbEpUlju8AUzFnMbG
 OktQ==
X-Gm-Message-State: AOJu0YzEM+iJ4QEcz5vS2V2FjXI+0x4fz0ZaFTKHxaI/AVXn3gAx/sGm
 wH3WiR8w/53nYPCY1zLQRdxKd/vo8LCpHtPvPnp4tAXLhLtweB+P1m7R1XhyiyWIgHi72albToD
 Vh8c=
X-Gm-Gg: ASbGncuTM/KzGm055DaLVqaz4DxaAv3U2EtsOGI3ShIX3vuOk5RS7kqbZ1p7dco6tmi
 KTPW1EtE9eYYzpEoXLmRP3uKYq/35MqIRFk6WIf0pbcc7qN8lBrq+ZUXrYplmPUrOn+2H9fcGwc
 GPvn0ZruL4l1n7FBvuZnRNT1xWOLHjkocyiMltbHV+LpVqIATrD8RbgLqyTBI4xc6NOdrT/sYgg
 4zSa8vuyPDP34ZFTC4VgGRuezInGDmAhVgSd2BldttrC3vEyRU0b0c8TprqdKTAo+5LUaRD
X-Google-Smtp-Source: AGHT+IEpz98V30vlOVPqfv3gCYIoLvmhFexISlzc+iOatRL06BSamdL/Npv1CFTXjACcBVssHLMtyQ==
X-Received: by 2002:a05:6214:da3:b0:6d4:1f44:1688 with SMTP id
 6a1803df08f44-6d864d4ae49mr42368186d6.15.1732728178199; 
 Wed, 27 Nov 2024 09:22:58 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:22:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 03/12] docker: Add kernel.org x86_64 toolchain
Date: Wed, 27 Nov 2024 11:17:21 -0600
Message-ID: <20241127172247.1488685-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

Add in the x86_64 toolchain, but do not enforce using it for sandbox.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- New patch
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 967ac89fbde8..0f6890b78218 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -27,6 +27,7 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-riscv64-linux.tar.xz | tar -C /opt -xJ
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-riscv32-linux.tar.xz | tar -C /opt -xJ
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-sh2-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-x86_64-linux.tar.xz | tar -C /opt -xJ
 
 # Manually install other toolchains
 RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
@@ -280,7 +281,6 @@ RUN /bin/echo -e "[toolchain]\nroot = /usr" > ~/.buildman
 RUN /bin/echo -e "kernelorg = /opt/gcc-13.2.0-nolibc/*" >> ~/.buildman
 RUN /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman;
 RUN /bin/echo -e "\n[toolchain-alias]\nsh = sh2" >> ~/.buildman
-RUN /bin/echo -e "\nsandbox = x86_64" >> ~/.buildman
 RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
-- 
2.43.0

