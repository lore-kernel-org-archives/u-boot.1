Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8241CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 875E987D5C;
	Wed,  1 Nov 2023 17:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bwzgWqRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D2787D5B; Wed,  1 Nov 2023 17:28:52 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0242687D3E
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-66d24ccc6f2so9362556d6.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856121; x=1699460921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r7mIFz4h2/5PAoCFa8K8rUQ4IUtlk0x8HXh7/LdwQsA=;
 b=bwzgWqRGzGrmeC8fnssII4UxoRsNMbYMuA6xpcjWviPdZSeBx/PyV/P5EZqh6rIRQJ
 fv8WohDCNuBEYhoetEPKWDcbhIzVW6D/rw/5RLz1o4IEz3Oa2Xbe2wYG3xpse2X2L8rX
 SqE3yckKA3WZWToy/oWvLw0fhzbz1PgrNbgC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856121; x=1699460921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7mIFz4h2/5PAoCFa8K8rUQ4IUtlk0x8HXh7/LdwQsA=;
 b=EVtX7YEOpD9LCl8ZhcOqEEZv7LkcCyr9Q2FV5ZdNXMD7jcrWM2jquh4D1gyqLle441
 PnE9SyWrzjk1xC3nP5kKuROtLIwS8Tf6zVNofD67JOYLTuxvaHbIqV/GORuKS1fUd2YM
 ujbNZ/JzmwuXN8aD88F+ygRaAby47pKnXpFbNggU3aEpz92lSH8/rHtkiSzdeRtv9JuB
 iCBshzzBNg/MzkyV4YXu5QEIdH7JJOsmU3Qp/6r2mF7h9sYY9tB+3bgk4DfXjI5hbCgA
 9L/AP53TD7a+VMWOX4C6TNoICu+YljPisAE/CE6p4f2yYzjLI1bsBsY2lLs5RJUtJX2o
 Ykeg==
X-Gm-Message-State: AOJu0YywYU/+z+v2yZPNWD9lWrd+Ib4jEmAUHfLgBTQhIBAErUfiQBQ8
 PrpfUe/6VeaxlidYrYyItUkFRegk1C5pbaid3e2QpA==
X-Google-Smtp-Source: AGHT+IH980WTnMmOqfRpVeH1lSWYdOWaJtQDjp6UFf55+ts/djGnyezNavR0MyYJkAzyKct6JDQmXQ==
X-Received: by 2002:a05:6214:48f:b0:66d:9b75:750b with SMTP id
 pt15-20020a056214048f00b0066d9b75750bmr9544651qvb.8.1698856121666; 
 Wed, 01 Nov 2023 09:28:41 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 19/20] arm: Drop <common.h> from remaining header files
Date: Wed,  1 Nov 2023 12:28:23 -0400
Message-Id: <20231101162824.3755579-19-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

None of these header files need to include <common.h> so we can just
drop that entirely.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-davinci/include/mach/dm365_lowlevel.h | 1 -
 arch/arm/mach-ipq40xx/pinctrl-snapdragon.h          | 2 --
 arch/arm/mach-keystone/include/mach/mux-k2g.h       | 1 -
 arch/arm/mach-mvebu/include/mach/efuse.h            | 2 --
 arch/arm/mach-tegra/xusb-padctl-common.h            | 1 -
 arch/arm/mach-zynqmp/include/mach/psu_init_gpl.h    | 1 -
 6 files changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/dm365_lowlevel.h b/arch/arm/mach-davinci/include/mach/dm365_lowlevel.h
index eb1488e74425..0cd13d8aaa59 100644
--- a/arch/arm/mach-davinci/include/mach/dm365_lowlevel.h
+++ b/arch/arm/mach-davinci/include/mach/dm365_lowlevel.h
@@ -8,7 +8,6 @@
 #ifndef __DM365_LOWLEVEL_H
 #define __DM365_LOWLEVEL_H
 
-#include <common.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 
diff --git a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h b/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h
index 2341a713495d..b4823a309fce 100644
--- a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h
+++ b/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h
@@ -8,8 +8,6 @@
 #ifndef _PINCTRL_SNAPDRAGON_H
 #define _PINCTRL_SNAPDRAGON_H
 
-#include <common.h>
-
 struct msm_pinctrl_data {
 	int pin_count;
 	int functions_count;
diff --git a/arch/arm/mach-keystone/include/mach/mux-k2g.h b/arch/arm/mach-keystone/include/mach/mux-k2g.h
index 67d47f817216..dfb5ad43506a 100644
--- a/arch/arm/mach-keystone/include/mach/mux-k2g.h
+++ b/arch/arm/mach-keystone/include/mach/mux-k2g.h
@@ -9,7 +9,6 @@
 #ifndef __ASM_ARCH_MUX_K2G_H
 #define __ASM_ARCH_MUX_K2G_H
 
-#include <common.h>
 #include <asm/io.h>
 
 #define K2G_PADCFG_REG	(KS2_DEVICE_STATE_CTRL_BASE + 0x1000)
diff --git a/arch/arm/mach-mvebu/include/mach/efuse.h b/arch/arm/mach-mvebu/include/mach/efuse.h
index b125c30beb8c..fd8ebceb26cf 100644
--- a/arch/arm/mach-mvebu/include/mach/efuse.h
+++ b/arch/arm/mach-mvebu/include/mach/efuse.h
@@ -6,8 +6,6 @@
 #ifndef _MVEBU_EFUSE_H
 #define _MVEBU_EFUSE_H
 
-#include <common.h>
-
 struct efuse_val {
 	union {
 		struct {
diff --git a/arch/arm/mach-tegra/xusb-padctl-common.h b/arch/arm/mach-tegra/xusb-padctl-common.h
index e3fd613f2be1..a576e6f61658 100644
--- a/arch/arm/mach-tegra/xusb-padctl-common.h
+++ b/arch/arm/mach-tegra/xusb-padctl-common.h
@@ -6,7 +6,6 @@
 #ifndef _TEGRA_XUSB_PADCTL_COMMON_H_
 #define _TEGRA_XUSB_PADCTL_COMMON_H_
 
-#include <common.h>
 #include <fdtdec.h>
 #include <dm/ofnode.h>
 
diff --git a/arch/arm/mach-zynqmp/include/mach/psu_init_gpl.h b/arch/arm/mach-zynqmp/include/mach/psu_init_gpl.h
index 434a7fa20e43..783d7c45c7ba 100644
--- a/arch/arm/mach-zynqmp/include/mach/psu_init_gpl.h
+++ b/arch/arm/mach-zynqmp/include/mach/psu_init_gpl.h
@@ -4,7 +4,6 @@
 #define _PSU_INIT_GPL_H_
 
 #include <asm/io.h>
-#include <common.h>
 
 int mask_pollonvalue(unsigned long add, u32 mask, u32 value);
 
-- 
2.34.1

