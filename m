Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD3606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BNF6tT41;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PUXoGJCg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B50F80F3E;
	Wed, 28 Oct 2026 14:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vCd3u0ezoCMc; Wed, 28 Oct 2026 14:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE6E980F91
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198764;
	b=GkpdpMa8wgY3lInUgvWzyDBmuQPO8SzlN6dIbgPQQT5LW/gOanYKSPwqLmCEKELSOxfn
	 gbIm732aVY2jbEfozEj8RhQfBZ+yluuj27rbzcZin0BqqgR2kblj6OoQClPzGOoYlvFHZ
	 OVG/AP1K2huRwhuGzrM3Ry5dwd359unigygspvofZDq+pV1v96h0VAHLaeXS0JkFYjlDO
	 v9fLBqo9fwghTEWQjPrf+E9GR1zzVe7tXNjoySKWzSVVUMKwdOk9MXSgQDEqxIv+4MEC1
	 LGLASNWywsFUZOZog8yhjyBkN/dFv2kKXuTXcVpiQc9dLJ0Z6bVwj4u7DYsY6uoCMLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zs6dAz0kxByaTGWlW+dNQA0ct613Hjpi5fC3yNKOxqU=;
	b=NejuLWt1qnKfLTkHbzlQx3DrRFtvFDZng5JbGKHlG9gVPOWtBpNWaCDE+boG4Vci0QqA
	 Mkf3cR0ncWK+wEFMjxe/I5WxItk4o81BXqGIa/LyJ8vg4rEA+fy9yreyLkORN35/hw+eD
	 Y58W2fKj2qFsjKU8aRQo3jQS73JHaFBufN1/7p7Btj6rb9pYSeC0rVG7HqiN1qzvy4Y7j
	 TV2IYxUxPqr0zn/JgXT4D8Rcq+eC8jFkRIBf9Dc3eBo8/tb6nzq3qNZapBavSyjG/0LT+
	 vkk/pGT7IMf6FERYZP8lIbIhLsJBP8yJxpBb042l36pG9GQ6j3rbH86U9T9lPrUSCpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198764;
	bh=zs6dAz0kxByaTGWlW+dNQA0ct613Hjpi5fC3yNKOxqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BNF6tT41VGdvmk7820esp004U6LDvjk2gzX0q6DAFUQ046w7xm+NOCoZXDPLbAFB9
	 AkSqxy7j++YzSN4LXBIUCfi8q0TNvv5rCLxz7l7TJLRdOf4UgH0dk0yHcHJNCc8ElR
	 lggRF+Zp4JbKujUayMRebbIIsiBRlOrkc8lnbEDkziPv1bkM/qySBfA3g3sbkIhPNg
	 L3aGVa0bXlgq/CrhfjNuoZl/bY8u4CpuJJlvUMkah18lnP/0MYIT8TUparWnXncvMg
	 Q2hw/Uv9F1pgLbP5G52wNKPNKH3pakMYNLdFIW5TpCXf91NqItxhw/Ry3bDCbYvgWV
	 8kjjofrrStCyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE6E980F91;
	Wed, 28 Oct 2026 14:46:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF34F529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B4E7860633
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AtapZhFUACDB for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2BC4605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196593;
 b=c8Tws2Sd9xqMLLMG7auuv6MJn0o/7arQJ5LqzEx3it9OM3tqWA7H0qQZTH6a+yKq6RbT
 DB/adrI9Wa8Qdkvd4vT7hxWEDto4XLt2k4B6S1rquNsaC3sxn8Qt34nSQQXzb4+gw5ee9
 4AlNhJe1ZL/F0cuinisIarXyqWu0OS2igXAJ9Judb5FAekF5ZC6PpYzKR1/vhYZUmsIZN
 CZwbReFd80b9bQrnMV57AmdYlHhgWI8K5qUbio4qHxzIpmxRPk75xKntT/3CEKTleenT3
 p3BsotMhlIpw8alw7H0JKO0jwTMKSDQc6algnv8eAbtKsEgBHXfExeAwRHCsYV6qKKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196593;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=zs6dAz0kxByaTGWlW+dNQA0ct613Hjpi5fC3yNKOxqU=;
 b=lpjHZYo2iLunj34XP9FZ02j+F5YPCrc9X1VX4nc6oB9cg153IHdM3nQYXc6dJTgfCtzo
 q/4Lm1sQmYDe9U5KNVWSv9rfSq6AIKtCDyuRcWAhp1pgqpOUHvrDt1ye4RbACyH15BFI8
 WAEfnS1pGT9L6D9pOq89bf19Da6U3BOZKz7J7BQ+KyfNJaLtcQMgALehj2ar/IK8RnFFV
 4ws6VW/Qj9wHE4xaxWE+nbJ6qc38xiE0KLD1feqmH8FKiEE7qh7IGSACR4jzJSioe8shZ
 e0aZA5ageNTl2DCUa1eZGkxqulmzRbPrxPAyvqN5idLUVIIHMzN8TB6CucuqoP3pRxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PUXoGJCg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PUXoGJCg
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2BC4605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:52 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c4015fb0b42so10356766b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196590; x=1793801390;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zs6dAz0kxByaTGWlW+dNQA0ct613Hjpi5fC3yNKOxqU=;
 b=PUXoGJCgyDSbAli/lLpEHYf220LnbWgKqijtUWwg4iB62FtN8G/kmWurJe73opJmdz
 Kz+IDTMtzDXuWQ3Als7GkFS+nY0pkzwzBq6qDE8MDctc5JfFB91zjk3RskMyo8ps6b4y
 Epb8Sin5V6K+JLWSGP/2cplnq7LbwRE7g+AiICPT1+ya9ckMTiJucst5FD4mUG9w61dq
 2ElN3kNUeqa1UCOCz1TeOc4hA6e3isIVYswS+23VceUQjXS2FalydOqY2IDBtgeyh0w6
 p/RYz0yzcKqSbvc3fBYiezUf78rmAU+i0BDQn/NG3QLjJd1La9HemmJD4KqypPUyv1CI
 0a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196590; x=1793801390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zs6dAz0kxByaTGWlW+dNQA0ct613Hjpi5fC3yNKOxqU=;
 b=zElyuuC4UJT9z5EhDk0Bfvrs4y1KnURAlnFcgtUk13/w1YB48i1XT+6X+oEBZ6qhHt
 Y+slJipF5F4fzhPkeptQdWUYwfC23CfhQHBFuF8flEJ9Mk6N1Uo6SVow4ctha3W4rHRH
 h2j72kKPKL5mbdrBQd/AaFMz86W5ZlycRMSno+TjnEJlcxn6kja97zh8idGiO3xxf3v3
 FKAF9RMilzV4gKrVP2omZUKwbr5vPproRC1/Th41jhoiXbLZkjK3JU1dWQWAA1avpgY/
 8vlhtw9L+CNBj7vtRAIilb7oqak+q8GFOoO+T5/zAhmeldlaEDFyaI6qXKAcUFR1sp7Z
 6s3A==
X-Gm-Message-State: AFq9FYIadaaPDyBlgxy/av5e0HkZU6m3eZZ4O8x8PfB2sjLj98IAVQRJ
 BZP5Zv+13NC9UXPLGiElFG60+QaPpswChYEc/qibzbMEIACTrmZM36pRnSsh2BbCUJYwZ0XFAA+
 6MacW
X-Gm-Gg: AYBFou0M2FCwfS0zVc49M6gAuPdWLJ5v5AjknEePym6+1uMAMGOajnVSrNy41UxDu1H
 GHckuetbS9c+0kcpkqwrPjVAZg95dYV1KcjmZGKqvStwJXnIHEU11lcLU5YymMphiNDczYAKCj3
 hvbZKjToK7NikBB4QxSdOUz6l3mVrpDgEdv5NOnwi89/Yuizy/l5+hzNV8POSW960J04v0+PfdG
 53JyXX/Ay/7CnMMOIZ0sw0LdY32FKVLcNyVxgA1i+l8SmiuCZMvmhL2xOakiNQIb0bCVEOfNtK/
 kmY6NOnhGndZOi9gUo2DCzovHKj682GYxgNZQtiX6VgzClDzxw4kurpwEXt+n6npkCVLDpT4Zpy
 hmzEmGD8CJoEqV7Q1F+oun+jl9cZxJEoR8YsxeJfz5qdFUzjWCzvlon5SV4hb8P30MsPdSIup8u
 wqpE1+cORLRPYtdYCve4ATEd/QGmdBIH2jMiIZ7Bbu74MtrGv20/xDC8wnz4QEVt7M9x75TqmOb
 pfGlVKvw9MWMhsd79nSo27WxlGcrfCx6H4I93WfigcclDqqA7Z4wgGVsGs/7A9ju2YtGM0zTkol
 ouVxnDII60qtCKcOz5uBBJyKKiS4fdgru+5ZQt83kCJI1YTv7CC5zX7XZiWs2rsYfsaeUZH1LiI
 oX4/ul35Uog==
X-Received: by 2002:a17:906:18e9:b0:c41:3963:6f1f with SMTP id
 a640c23a62f3a-c49bdeae450mr225319166b.4.1793196589271; 
 Wed, 28 Oct 2026 07:09:49 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm607807266b.68.2026.10.28.07.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:48 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 02/63] usb: dwc3: restore to original v3.19-rc1 kernel
 import
Date: Wed, 28 Oct 2026 15:08:28 +0100
Message-ID: <20261028140930.3025368-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Restore the dwc3 source files to the state of the original import in
commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
u-boot").

[Anders: rebased on origin/main. dwc3-am62.c conflicted here, because
this commit deletes it but upstream had changed it. Kept the delete, the
file comes back in a later commit. Kept samsung_usb_phy.c. It is U-Boot
code and was never part of the kernel import, like dwc3-generic.c.]

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c          | 1090 +++++++++++++-----------------
 drivers/usb/dwc3/core.h          |  231 ++-----
 drivers/usb/dwc3/debug.c         |   32 +
 drivers/usb/dwc3/debug.h         |  228 +++++++
 drivers/usb/dwc3/dwc3-am62.c     |  125 ----
 drivers/usb/dwc3/ep0.c           |  217 +++---
 drivers/usb/dwc3/gadget.c        |  502 +++++++-------
 drivers/usb/dwc3/gadget.h        |   30 +-
 drivers/usb/dwc3/io.h            |   54 +-
 drivers/usb/dwc3/linux-compat.h  |   16 -
 drivers/usb/dwc3/platform_data.h |   47 ++
 11 files changed, 1250 insertions(+), 1322 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.c
 create mode 100644 drivers/usb/dwc3/debug.h
 delete mode 100644 drivers/usb/dwc3/dwc3-am62.c
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 create mode 100644 drivers/usb/dwc3/platform_data.h

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index be198041f08c..25ddc39efad8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1,48 +1,55 @@
-// SPDX-License-Identifier: GPL-2.0
 /**
  * core.c - DesignWare USB3 DRD Controller Core file
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/core.c) and ported
- * to uboot.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
  *
- * commit cd72f890d2 : usb: dwc3: core: enable phy suspend quirk on non-FPGA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <clk.h>
-#include <cpu_func.h>
-#include <malloc.h>
-#include <dwc3-uboot.h>
-#include <dm/device_compat.h>
-#include <dm/devres.h>
-#include <linux/bug.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/list.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/err.h>
-#include <linux/iopoll.h>
-#include <linux/ioport.h>
-#include <dm.h>
-#include <generic-phy.h>
+#include <linux/of.h>
+#include <linux/acpi.h>
+
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/bitfield.h>
-#include <linux/math64.h>
-#include <linux/time.h>
+#include <linux/usb/of.h>
+#include <linux/usb/otg.h>
 
+#include "platform_data.h"
 #include "core.h"
 #include "gadget.h"
 #include "io.h"
 
-#include "linux-compat.h"
+#include "debug.h"
 
-static LIST_HEAD(dwc3_list);
 /* -------------------------------------------------------------------------- */
 
-static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
 
@@ -59,144 +66,54 @@ static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 static int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
-	int		retries = 1000;
+	int		ret;
 
-	/*
-	 * We're resetting only the device side because, if we're in host mode,
-	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode, then we can return early.
-	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST)
-		return 0;
-
-	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-	reg |= DWC3_DCTL_CSFTRST;
-	reg &= ~DWC3_DCTL_RUN_STOP;
-	dwc3_gadget_dctl_write_safe(dwc, reg);
-
-	/*
-	 * For DWC_usb31 controller 1.90a and later, the DCTL.CSFRST bit
-	 * is cleared only after all the clocks are synchronized. This can
-	 * take a little more than 50ms. Set the polling rate at 20ms
-	 * for 10 times instead.
-	 */
-	if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
-		retries = 10;
-
-	do {
-		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-		if (!(reg & DWC3_DCTL_CSFTRST))
-			goto done;
+	/* Before Resetting PHY, put Core in Reset */
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg |= DWC3_GCTL_CORESOFTRESET;
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
-		if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
-			mdelay(20);
-		else
-			udelay(1);
-	} while (--retries);
+	/* Assert USB3 PHY reset */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	reg |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
-	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
-	return -ETIMEDOUT;
+	/* Assert USB2 PHY reset */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	reg |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
-done:
-	/*
-	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
-	 * is cleared, we must wait at least 50ms before accessing the PHY
-	 * domain (synchronization delay).
-	 */
-	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
-		mdelay(50);
+	usb_phy_init(dwc->usb2_phy);
+	usb_phy_init(dwc->usb3_phy);
+	ret = phy_init(dwc->usb2_generic_phy);
+	if (ret < 0)
+		return ret;
 
+	ret = phy_init(dwc->usb3_generic_phy);
+	if (ret < 0) {
+		phy_exit(dwc->usb2_generic_phy);
+		return ret;
+	}
 	mdelay(100);
 
-	return 0;
-}
-
-/*
- * dwc3_frame_length_adjustment - Adjusts frame length if required
- * @dwc3: Pointer to our controller context structure
- * @fladj: Value of GFLADJ_30MHZ to adjust frame length
- */
-static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
-{
-	u32 reg;
-
-	if (dwc->revision < DWC3_REVISION_250A)
-		return;
-
-	if (fladj == 0)
-		return;
-
-	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
-	reg &= ~DWC3_GFLADJ_30MHZ_MASK;
-	reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | fladj;
-	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
-}
-
-/**
- * dwc3_ref_clk_period - Reference clock period configuration
- *		Default reference clock period depends on hardware
- *		configuration. For systems with reference clock that differs
- *		from the default, this will set clock period in DWC3_GUCTL
- *		register.
- * @dwc: Pointer to our controller context structure
- * @ref_clk_per: reference clock period in ns
- */
-static void dwc3_ref_clk_period(struct dwc3 *dwc)
-{
-	unsigned long period;
-	unsigned long fladj;
-	unsigned long decr;
-	unsigned long rate;
-	u32 reg;
-
-	if (dwc->ref_clk) {
-		rate = clk_get_rate(dwc->ref_clk);
-		if (!rate)
-			return;
-		period = NSEC_PER_SEC / rate;
-	} else {
-		return;
-	}
+	/* Clear USB3 PHY reset */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	reg &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
-	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
-	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	/* Clear USB2 PHY reset */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
-	if (dwc->revision <= DWC3_REVISION_250A)
-		return;
+	mdelay(100);
 
-	/*
-	 * The calculation below is
-	 *
-	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
-	 *
-	 * but rearranged for fixed-point arithmetic. The division must be
-	 * 64-bit because 125000 * NSEC_PER_SEC doesn't fit in 32 bits (and
-	 * neither does rate * period).
-	 *
-	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
-	 * nanoseconds of error caused by the truncation which happened during
-	 * the division when calculating rate or period (whichever one was
-	 * derived from the other). We first calculate the relative error, then
-	 * scale it to units of 8 ppm.
-	 */
-	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
-	fladj -= 125000;
+	/* After PHYs are stable we can take Core out of reset state */
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &= ~DWC3_GCTL_CORESOFTRESET;
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
-	/*
-	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
-	 */
-	decr = 480000000 / rate;
-
-	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
-	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK
-	    &  ~DWC3_GFLADJ_240MHZDECR
-	    &  ~DWC3_GFLADJ_240MHZDECR_PLS1;
-	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
-	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
-	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
-	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+	return 0;
 }
 
 /**
@@ -207,7 +124,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
-	dma_free_coherent(evt->buf);
+	dma_free_coherent(dwc->dev, evt->length, evt->buf, evt->dma);
 }
 
 /**
@@ -223,20 +140,17 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 {
 	struct dwc3_event_buffer	*evt;
 
-	evt = devm_kzalloc((struct udevice *)dwc->dev, sizeof(*evt),
-			   GFP_KERNEL);
+	evt = devm_kzalloc(dwc->dev, sizeof(*evt), GFP_KERNEL);
 	if (!evt)
 		return ERR_PTR(-ENOMEM);
 
 	evt->dwc	= dwc;
 	evt->length	= length;
-	evt->buf	= dma_alloc_coherent(length,
-					     (unsigned long *)&evt->dma);
+	evt->buf	= dma_alloc_coherent(dwc->dev, length,
+			&evt->dma, GFP_KERNEL);
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
 
-	dwc3_flush_cache((uintptr_t)evt->buf, evt->length);
-
 	return evt;
 }
 
@@ -254,8 +168,6 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
 		if (evt)
 			dwc3_free_one_event_buffer(dwc, evt);
 	}
-
-	free(dwc->ev_buffs);
 }
 
 /**
@@ -274,8 +186,8 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
 	num = DWC3_NUM_INT(dwc->hwparams.hwparams1);
 	dwc->num_event_buffers = num;
 
-	dwc->ev_buffs = memalign(CONFIG_SYS_CACHELINE_SIZE,
-				 sizeof(*dwc->ev_buffs) * num);
+	dwc->ev_buffs = devm_kzalloc(dwc->dev, sizeof(*dwc->ev_buffs) * num,
+			GFP_KERNEL);
 	if (!dwc->ev_buffs)
 		return -ENOMEM;
 
@@ -370,9 +282,13 @@ static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
 	if (!dwc->nr_scratch)
 		return 0;
 
-	scratch_addr = dma_map_single(dwc->scratchbuf,
-				      dwc->nr_scratch * DWC3_SCRATCHBUF_SIZE,
-				      DMA_BIDIRECTIONAL);
+	 /* should never fall here */
+	if (!WARN_ON(dwc->scratchbuf))
+		return 0;
+
+	scratch_addr = dma_map_single(dwc->dev, dwc->scratchbuf,
+			dwc->nr_scratch * DWC3_SCRATCHBUF_SIZE,
+			DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(dwc->dev, scratch_addr)) {
 		dev_err(dwc->dev, "failed to map scratch buffer\n");
 		ret = -EFAULT;
@@ -398,8 +314,8 @@ static int dwc3_setup_scratch_buffers(struct dwc3 *dwc)
 	return 0;
 
 err1:
-	dma_unmap_single(scratch_addr, dwc->nr_scratch * DWC3_SCRATCHBUF_SIZE,
-			 DMA_BIDIRECTIONAL);
+	dma_unmap_single(dwc->dev, dwc->scratch_addr, dwc->nr_scratch *
+			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
 
 err0:
 	return ret;
@@ -413,8 +329,12 @@ static void dwc3_free_scratch_buffers(struct dwc3 *dwc)
 	if (!dwc->nr_scratch)
 		return;
 
-	dma_unmap_single(dwc->scratch_addr, dwc->nr_scratch *
-			 DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
+	 /* should never fall here */
+	if (!WARN_ON(dwc->scratchbuf))
+		return;
+
+	dma_unmap_single(dwc->dev, dwc->scratch_addr, dwc->nr_scratch *
+			DWC3_SCRATCHBUF_SIZE, DMA_BIDIRECTIONAL);
 	kfree(dwc->scratchbuf);
 }
 
@@ -444,34 +364,6 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
 }
 
-static void dwc3_hsphy_mode_setup(struct dwc3 *dwc)
-{
-	enum usb_phy_interface hsphy_mode = dwc->hsphy_mode;
-	u32 reg;
-
-	/* Set dwc3 usb2 phy config */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-
-	switch (hsphy_mode) {
-	case USBPHY_INTERFACE_MODE_UTMI:
-		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
-			DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
-		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_8_BIT) |
-			DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_8_BIT);
-		break;
-	case USBPHY_INTERFACE_MODE_UTMIW:
-		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
-			DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
-		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_16_BIT) |
-			DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_16_BIT);
-		break;
-	default:
-		break;
-	}
-
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-}
-
 /**
  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -515,13 +407,8 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u3_susphy_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
-	if (dwc->dis_del_phy_power_chg_quirk)
-		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
-
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
-	dwc3_hsphy_mode_setup(dwc);
-
 	mdelay(100);
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
@@ -538,84 +425,11 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u2_susphy_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
-	if (dwc->dis_enblslpm_quirk)
-		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
-
-	if (dwc->dis_u2_freeclk_exists_quirk)
-		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
-
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
 	mdelay(100);
 }
 
-/* set global incr burst type configuration registers */
-static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
-{
-	struct udevice *dev = dwc->dev;
-	u32 cfg;
-
-	if (!dwc->incrx_size)
-		return;
-
-	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
-
-	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
-	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
-	if (dwc->incrx_mode)
-		cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
-	switch (dwc->incrx_size) {
-	case 256:
-		cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
-		break;
-	case 128:
-		cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
-		break;
-	case 64:
-		cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
-		break;
-	case 32:
-		cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
-		break;
-	case 16:
-		cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
-		break;
-	case 8:
-		cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
-		break;
-	case 4:
-		cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
-		break;
-	case 1:
-		break;
-	default:
-		dev_err(dev, "Invalid property\n");
-		break;
-	}
-
-	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
-}
-
-static bool dwc3_core_is_valid(struct dwc3 *dwc)
-{
-	u32 reg;
-
-	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
-	dwc->ip = DWC3_GSNPS_ID(reg);
-
-	/* This should read as U3 followed by revision number */
-	if (DWC3_IP_IS(DWC3)) {
-		dwc->revision = reg;
-	} else if (DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) {
-		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
-		dwc->version_type = dwc3_readl(dwc->regs, DWC3_VER_TYPE);
-	} else {
-		return false;
-	}
-
-	return true;
-}
-
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -624,15 +438,25 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
  */
 static int dwc3_core_init(struct dwc3 *dwc)
 {
+	unsigned long		timeout;
 	u32			hwparams4 = dwc->hwparams.hwparams4;
 	u32			reg;
 	int			ret;
 
-	if (!dwc3_core_is_valid(dwc)) {
+	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
+	/* This should read as U3 followed by revision number */
+	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
 		goto err0;
 	}
+	dwc->revision = reg;
+
+	/*
+	 * Write Linux Version Code to our GUID register so it's easy to figure
+	 * out which kernel version a bug was found.
+	 */
+	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
 
 	/* Handle USB2.0-only core configuration */
 	if (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
@@ -642,17 +466,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	}
 
 	/* issue device SoftReset too */
+	timeout = jiffies + msecs_to_jiffies(500);
 	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	ret = read_poll_timeout(dwc3_readl, reg,
-				!(reg & DWC3_DCTL_CSFTRST),
-				1, 5000, dwc->regs, DWC3_DCTL);
-	if (ret) {
-		dev_err(dwc->dev, "Reset Timed Out\n");
-		ret = -ETIMEDOUT;
-		goto err0;
-	}
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			break;
 
-	dwc3_phy_setup(dwc);
+		if (time_after(jiffies, timeout)) {
+			dev_err(dwc->dev, "Reset Timed Out\n");
+			ret = -ETIMEDOUT;
+			goto err0;
+		}
+
+		cpu_relax();
+	} while (true);
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
@@ -703,9 +531,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->is_fpga = true;
 	}
 
-	if(dwc->disable_scramble_quirk && !dwc->is_fpga)
-		WARN(true,
-		     "disable_scramble cannot be used on non-FPGA builds\n");
+	WARN_ONCE(dwc->disable_scramble_quirk && !dwc->is_fpga,
+			"disable_scramble cannot be used on non-FPGA builds\n");
 
 	if (dwc->disable_scramble_quirk && dwc->is_fpga)
 		reg |= DWC3_GCTL_DISSCRAMBLE;
@@ -728,27 +555,27 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
+	dwc3_phy_setup(dwc);
+
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
-		goto err0;
+		goto err1;
 
 	ret = dwc3_setup_scratch_buffers(dwc);
 	if (ret)
-		goto err1;
-
-	/* Adjust Frame Length */
-	dwc3_frame_length_adjustment(dwc, dwc->fladj);
-
-	/* Adjust Reference Clock Period */
-	dwc3_ref_clk_period(dwc);
-
-	dwc3_set_incr_burst_type(dwc);
+		goto err2;
 
 	return 0;
 
-err1:
+err2:
 	dwc3_free_scratch_buffers(dwc);
 
+err1:
+	usb_phy_shutdown(dwc->usb2_phy);
+	usb_phy_shutdown(dwc->usb3_phy);
+	phy_exit(dwc->usb2_generic_phy);
+	phy_exit(dwc->usb3_generic_phy);
+
 err0:
 	return ret;
 }
@@ -756,10 +583,82 @@ err0:
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_free_scratch_buffers(dwc);
+	usb_phy_shutdown(dwc->usb2_phy);
+	usb_phy_shutdown(dwc->usb3_phy);
+	phy_exit(dwc->usb2_generic_phy);
+	phy_exit(dwc->usb3_generic_phy);
+}
+
+static int dwc3_core_get_phy(struct dwc3 *dwc)
+{
+	struct device		*dev = dwc->dev;
+	struct device_node	*node = dev->of_node;
+	int ret;
+
+	if (node) {
+		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
+		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
+	} else {
+		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
+	}
+
+	if (IS_ERR(dwc->usb2_phy)) {
+		ret = PTR_ERR(dwc->usb2_phy);
+		if (ret == -ENXIO || ret == -ENODEV) {
+			dwc->usb2_phy = NULL;
+		} else if (ret == -EPROBE_DEFER) {
+			return ret;
+		} else {
+			dev_err(dev, "no usb2 phy configured\n");
+			return ret;
+		}
+	}
+
+	if (IS_ERR(dwc->usb3_phy)) {
+		ret = PTR_ERR(dwc->usb3_phy);
+		if (ret == -ENXIO || ret == -ENODEV) {
+			dwc->usb3_phy = NULL;
+		} else if (ret == -EPROBE_DEFER) {
+			return ret;
+		} else {
+			dev_err(dev, "no usb3 phy configured\n");
+			return ret;
+		}
+	}
+
+	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
+	if (IS_ERR(dwc->usb2_generic_phy)) {
+		ret = PTR_ERR(dwc->usb2_generic_phy);
+		if (ret == -ENOSYS || ret == -ENODEV) {
+			dwc->usb2_generic_phy = NULL;
+		} else if (ret == -EPROBE_DEFER) {
+			return ret;
+		} else {
+			dev_err(dev, "no usb2 phy configured\n");
+			return ret;
+		}
+	}
+
+	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
+	if (IS_ERR(dwc->usb3_generic_phy)) {
+		ret = PTR_ERR(dwc->usb3_generic_phy);
+		if (ret == -ENOSYS || ret == -ENODEV) {
+			dwc->usb3_generic_phy = NULL;
+		} else if (ret == -EPROBE_DEFER) {
+			return ret;
+		} else {
+			dev_err(dev, "no usb3 phy configured\n");
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
+	struct device *dev = dwc->dev;
 	int ret;
 
 	switch (dwc->dr_mode) {
@@ -767,7 +666,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
-			dev_err(dwc->dev, "failed to initialize gadget\n");
+			dev_err(dev, "failed to initialize gadget\n");
 			return ret;
 		}
 		break;
@@ -775,7 +674,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
-			dev_err(dwc->dev, "failed to initialize host\n");
+			dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
 		break;
@@ -783,39 +682,24 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
-			dev_err(dwc->dev, "failed to initialize host\n");
+			dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
-			dev_err(dwc->dev, "failed to initialize gadget\n");
+			dev_err(dev, "failed to initialize gadget\n");
 			return ret;
 		}
 		break;
 	default:
-		dev_err(dwc->dev,
-			"Unsupported mode of operation %d\n", dwc->dr_mode);
+		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static void dwc3_gadget_run(struct dwc3 *dwc)
-{
-	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_RUN_STOP);
-	mdelay(100);
-}
-
-static void dwc3_core_stop(struct dwc3 *dwc)
-{
-	u32 reg;
-
-	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg & ~(DWC3_DCTL_RUN_STOP));
-}
-
 static void dwc3_core_exit_mode(struct dwc3 *dwc)
 {
 	switch (dwc->dr_mode) {
@@ -833,50 +717,74 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 		/* do nothing */
 		break;
 	}
-
-	/*
-	 * switch back to peripheral mode
-	 * This enables the phy to enter idle and then, if enabled, suspend.
-	 */
-	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-	dwc3_gadget_run(dwc);
 }
 
 #define DWC3_ALIGN_MASK		(16 - 1)
 
-/**
- * dwc3_uboot_init - dwc3 core uboot initialization code
- * @dwc3_dev: struct dwc3_device containing initialization data
- *
- * Entry point for dwc3 driver (equivalent to dwc3_probe in linux
- * kernel driver). Pointer to dwc3_device should be passed containing
- * base address and other initialization data. Returns '0' on success and
- * a negative value on failure.
- *
- * Generally called from board_usb_init() implemented in board file.
- */
-int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
+static int dwc3_probe(struct platform_device *pdev)
 {
+	struct device		*dev = &pdev->dev;
+	struct dwc3_platform_data *pdata = dev_get_platdata(dev);
+	struct device_node	*node = dev->of_node;
+	struct resource		*res;
 	struct dwc3		*dwc;
-	struct device		*dev = NULL;
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
 
 	int			ret;
 
+	void __iomem		*regs;
 	void			*mem;
 
-	mem = devm_kzalloc((struct udevice *)dev,
-			   sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
+	mem = devm_kzalloc(dev, sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
 	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
 	dwc->mem = mem;
+	dwc->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "missing IRQ\n");
+		return -ENODEV;
+	}
+	dwc->xhci_resources[1].start = res->start;
+	dwc->xhci_resources[1].end = res->end;
+	dwc->xhci_resources[1].flags = res->flags;
+	dwc->xhci_resources[1].name = res->name;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	dwc->xhci_resources[0].start = res->start;
+	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
+					DWC3_XHCI_REGS_END;
+	dwc->xhci_resources[0].flags = res->flags;
+	dwc->xhci_resources[0].name = res->name;
 
-	dwc->regs = (void *)(uintptr_t)(dwc3_dev->base +
-					DWC3_GLOBALS_REGS_START);
+	res->start += DWC3_GLOBALS_REGS_START;
+
+	/*
+	 * Request memory region but exclude xHCI regs,
+	 * since it will be requested by the xhci-plat driver.
+	 */
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	dwc->regs	= regs;
+	dwc->regs_size	= resource_size(res);
+	/*
+	 * restore res->start back to its original value so that,
+	 * in case the probe is deferred, we don't end up getting error in
+	 * request the memory region the next time probe is called.
+	 */
+	res->start -= DWC3_GLOBALS_REGS_START;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xff;
@@ -890,35 +798,73 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 	 */
 	hird_threshold = 12;
 
-	dwc->maximum_speed = dwc3_dev->maximum_speed;
-	dwc->has_lpm_erratum = dwc3_dev->has_lpm_erratum;
-	if (dwc3_dev->lpm_nyet_threshold)
-		lpm_nyet_threshold = dwc3_dev->lpm_nyet_threshold;
-	dwc->is_utmi_l1_suspend = dwc3_dev->is_utmi_l1_suspend;
-	if (dwc3_dev->hird_threshold)
-		hird_threshold = dwc3_dev->hird_threshold;
-
-	dwc->needs_fifo_resize = dwc3_dev->tx_fifo_resize;
-	dwc->dr_mode = dwc3_dev->dr_mode;
-
-	dwc->disable_scramble_quirk = dwc3_dev->disable_scramble_quirk;
-	dwc->u2exit_lfps_quirk = dwc3_dev->u2exit_lfps_quirk;
-	dwc->u2ss_inp3_quirk = dwc3_dev->u2ss_inp3_quirk;
-	dwc->req_p1p2p3_quirk = dwc3_dev->req_p1p2p3_quirk;
-	dwc->del_p1p2p3_quirk = dwc3_dev->del_p1p2p3_quirk;
-	dwc->del_phy_power_chg_quirk = dwc3_dev->del_phy_power_chg_quirk;
-	dwc->lfps_filter_quirk = dwc3_dev->lfps_filter_quirk;
-	dwc->rx_detect_poll_quirk = dwc3_dev->rx_detect_poll_quirk;
-	dwc->dis_u3_susphy_quirk = dwc3_dev->dis_u3_susphy_quirk;
-	dwc->dis_u2_susphy_quirk = dwc3_dev->dis_u2_susphy_quirk;
-	dwc->dis_del_phy_power_chg_quirk = dwc3_dev->dis_del_phy_power_chg_quirk;
-	dwc->dis_tx_ipgap_linecheck_quirk = dwc3_dev->dis_tx_ipgap_linecheck_quirk;
-	dwc->dis_enblslpm_quirk = dwc3_dev->dis_enblslpm_quirk;
-	dwc->dis_u2_freeclk_exists_quirk = dwc3_dev->dis_u2_freeclk_exists_quirk;
-
-	dwc->tx_de_emphasis_quirk = dwc3_dev->tx_de_emphasis_quirk;
-	if (dwc3_dev->tx_de_emphasis)
-		tx_de_emphasis = dwc3_dev->tx_de_emphasis;
+	if (node) {
+		dwc->maximum_speed = of_usb_get_maximum_speed(node);
+		dwc->has_lpm_erratum = of_property_read_bool(node,
+				"snps,has-lpm-erratum");
+		of_property_read_u8(node, "snps,lpm-nyet-threshold",
+				&lpm_nyet_threshold);
+		dwc->is_utmi_l1_suspend = of_property_read_bool(node,
+				"snps,is-utmi-l1-suspend");
+		of_property_read_u8(node, "snps,hird-threshold",
+				&hird_threshold);
+
+		dwc->needs_fifo_resize = of_property_read_bool(node,
+				"tx-fifo-resize");
+		dwc->dr_mode = of_usb_get_dr_mode(node);
+
+		dwc->disable_scramble_quirk = of_property_read_bool(node,
+				"snps,disable_scramble_quirk");
+		dwc->u2exit_lfps_quirk = of_property_read_bool(node,
+				"snps,u2exit_lfps_quirk");
+		dwc->u2ss_inp3_quirk = of_property_read_bool(node,
+				"snps,u2ss_inp3_quirk");
+		dwc->req_p1p2p3_quirk = of_property_read_bool(node,
+				"snps,req_p1p2p3_quirk");
+		dwc->del_p1p2p3_quirk = of_property_read_bool(node,
+				"snps,del_p1p2p3_quirk");
+		dwc->del_phy_power_chg_quirk = of_property_read_bool(node,
+				"snps,del_phy_power_chg_quirk");
+		dwc->lfps_filter_quirk = of_property_read_bool(node,
+				"snps,lfps_filter_quirk");
+		dwc->rx_detect_poll_quirk = of_property_read_bool(node,
+				"snps,rx_detect_poll_quirk");
+		dwc->dis_u3_susphy_quirk = of_property_read_bool(node,
+				"snps,dis_u3_susphy_quirk");
+		dwc->dis_u2_susphy_quirk = of_property_read_bool(node,
+				"snps,dis_u2_susphy_quirk");
+
+		dwc->tx_de_emphasis_quirk = of_property_read_bool(node,
+				"snps,tx_de_emphasis_quirk");
+		of_property_read_u8(node, "snps,tx_de_emphasis",
+				&tx_de_emphasis);
+	} else if (pdata) {
+		dwc->maximum_speed = pdata->maximum_speed;
+		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
+		if (pdata->lpm_nyet_threshold)
+			lpm_nyet_threshold = pdata->lpm_nyet_threshold;
+		dwc->is_utmi_l1_suspend = pdata->is_utmi_l1_suspend;
+		if (pdata->hird_threshold)
+			hird_threshold = pdata->hird_threshold;
+
+		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
+		dwc->dr_mode = pdata->dr_mode;
+
+		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
+		dwc->u2exit_lfps_quirk = pdata->u2exit_lfps_quirk;
+		dwc->u2ss_inp3_quirk = pdata->u2ss_inp3_quirk;
+		dwc->req_p1p2p3_quirk = pdata->req_p1p2p3_quirk;
+		dwc->del_p1p2p3_quirk = pdata->del_p1p2p3_quirk;
+		dwc->del_phy_power_chg_quirk = pdata->del_phy_power_chg_quirk;
+		dwc->lfps_filter_quirk = pdata->lfps_filter_quirk;
+		dwc->rx_detect_poll_quirk = pdata->rx_detect_poll_quirk;
+		dwc->dis_u3_susphy_quirk = pdata->dis_u3_susphy_quirk;
+		dwc->dis_u2_susphy_quirk = pdata->dis_u2_susphy_quirk;
+
+		dwc->tx_de_emphasis_quirk = pdata->tx_de_emphasis_quirk;
+		if (pdata->tx_de_emphasis)
+			tx_de_emphasis = pdata->tx_de_emphasis;
+	}
 
 	/* default to superspeed if no maximum_speed passed */
 	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
@@ -930,21 +876,35 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 	dwc->hird_threshold = hird_threshold
 		| (dwc->is_utmi_l1_suspend << 4);
 
-	dwc->hsphy_mode = dwc3_dev->hsphy_mode;
+	ret = dwc3_core_get_phy(dwc);
+	if (ret)
+		return ret;
 
-	dwc->index = dwc3_dev->index;
+	spin_lock_init(&dwc->lock);
+	platform_set_drvdata(pdev, dwc);
+
+	if (!dev->dma_mask) {
+		dev->dma_mask = dev->parent->dma_mask;
+		dev->dma_parms = dev->parent->dma_parms;
+		dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
+	}
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	pm_runtime_forbid(dev);
 
 	dwc3_cache_hwparams(dwc);
 
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err0;
 	}
 
-	if (!IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
 		dwc->dr_mode = USB_DR_MODE_HOST;
-	else if (!IS_ENABLED(CONFIG_USB_HOST))
+	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
 		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
 
 	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
@@ -952,28 +912,55 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 
 	ret = dwc3_core_init(dwc);
 	if (ret) {
-		dev_err(dwc->dev, "failed to initialize core\n");
+		dev_err(dev, "failed to initialize core\n");
 		goto err0;
 	}
 
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+	ret = phy_power_on(dwc->usb2_generic_phy);
+	if (ret < 0)
+		goto err1;
+
+	ret = phy_power_on(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_usb2phy_power;
+
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err1;
+		goto err_usb3phy_power;
 	}
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
 		goto err2;
 
-	list_add_tail(&dwc->list, &dwc3_list);
+	ret = dwc3_debugfs_init(dwc);
+	if (ret) {
+		dev_err(dev, "failed to initialize debugfs\n");
+		goto err3;
+	}
+
+	pm_runtime_allow(dev);
 
 	return 0;
 
+err3:
+	dwc3_core_exit_mode(dwc);
+
 err2:
 	dwc3_event_buffers_cleanup(dwc);
 
+err_usb3phy_power:
+	phy_power_off(dwc->usb3_generic_phy);
+
+err_usb2phy_power:
+	phy_power_off(dwc->usb2_generic_phy);
+
 err1:
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	dwc3_core_exit(dwc);
 
 err0:
@@ -982,276 +969,151 @@ err0:
 	return ret;
 }
 
-/**
- * dwc3_uboot_exit - dwc3 core uboot cleanup code
- * @index: index of this controller
- *
- * Performs cleanup of memory allocated in dwc3_uboot_init and other misc
- * cleanups (equivalent to dwc3_remove in linux). index of _this_ controller
- * should be passed and should match with the index passed in
- * dwc3_device during init.
- *
- * Generally called from board file.
- */
-void dwc3_uboot_exit(int index)
+static int dwc3_remove(struct platform_device *pdev)
 {
-	struct dwc3 *dwc;
-
-	list_for_each_entry(dwc, &dwc3_list, list) {
-		if (dwc->index != index)
-			continue;
+	struct dwc3	*dwc = platform_get_drvdata(pdev);
 
-		dwc3_core_exit_mode(dwc);
-		dwc3_event_buffers_cleanup(dwc);
-		dwc3_free_event_buffers(dwc);
-		dwc3_core_exit(dwc);
-		list_del(&dwc->list);
-		kfree(dwc->mem);
-		break;
-	}
-}
-
-MODULE_ALIAS("platform:dwc3");
-MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
-
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
-__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
-{
-	return 1;
-}
-
-/**
- * dm_usb_gadget_handle_interrupts - handle dwc3 core interrupt
- * @dev: device of this controller
- *
- * Invokes dwc3 gadget interrupts.
- *
- * Generally called from board file.
- */
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	struct dwc3 *dwc = NULL;
+	dwc3_debugfs_exit(dwc);
+	dwc3_core_exit_mode(dwc);
+	dwc3_event_buffers_cleanup(dwc);
+	dwc3_free_event_buffers(dwc);
 
-	if (!dwc3_uboot_interrupt_status(dev))
-		return 0;
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	phy_power_off(dwc->usb2_generic_phy);
+	phy_power_off(dwc->usb3_generic_phy);
 
-	list_for_each_entry(dwc, &dwc3_list, list) {
-		if (dwc->dev != dev)
-			continue;
+	dwc3_core_exit(dwc);
 
-		dwc3_gadget_uboot_handle_interrupt(dwc);
-		break;
-	}
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-#endif
 
-#if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
-int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
+#ifdef CONFIG_PM_SLEEP
+static int dwc3_suspend(struct device *dev)
 {
-	int ret;
-
-	ret = generic_phy_get_bulk(dev, phys);
-	if (ret)
-		return ret;
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	unsigned long	flags;
 
-	ret = generic_phy_init_bulk(phys);
-	if (ret)
-		return ret;
+	spin_lock_irqsave(&dwc->lock, flags);
 
-	ret = generic_phy_power_on_bulk(phys);
-	if (ret)
-		generic_phy_exit_bulk(phys);
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+	case USB_DR_MODE_OTG:
+		dwc3_gadget_suspend(dwc);
+		/* FALLTHROUGH */
+	case USB_DR_MODE_HOST:
+	default:
+		dwc3_event_buffers_cleanup(dwc);
+		break;
+	}
 
-	return ret;
-}
+	dwc->gctl = dwc3_readl(dwc->regs, DWC3_GCTL);
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
-int dwc3_shutdown_phy(struct udevice *dev, struct phy_bulk *phys)
-{
-	int ret;
+	usb_phy_shutdown(dwc->usb3_phy);
+	usb_phy_shutdown(dwc->usb2_phy);
+	phy_exit(dwc->usb2_generic_phy);
+	phy_exit(dwc->usb3_generic_phy);
 
-	ret = generic_phy_power_off_bulk(phys);
-	ret |= generic_phy_exit_bulk(phys);
-	return ret;
+	return 0;
 }
-#endif
 
-#if CONFIG_IS_ENABLED(DM_USB)
-void dwc3_of_parse(struct dwc3 *dwc)
+static int dwc3_resume(struct device *dev)
 {
-	const u8 *tmp;
-	struct udevice *dev = dwc->dev;
-	u8 lpm_nyet_threshold;
-	u8 tx_de_emphasis;
-	u8 hird_threshold;
-	u32 val;
-	int i;
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	unsigned long	flags;
+	int		ret;
 
-	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xff;
-
-	/* default to -3.5dB de-emphasis */
-	tx_de_emphasis = 1;
-
-	/*
-	 * default to assert utmi_sleep_n and use maximum allowed HIRD
-	 * threshold value of 0b1100
-	 */
-	hird_threshold = 12;
-
-	dwc->hsphy_mode = usb_get_phy_mode(dev_ofnode(dev));
-
-	dwc->has_lpm_erratum = dev_read_bool(dev,
-				"snps,has-lpm-erratum");
-	tmp = dev_read_u8_array_ptr(dev, "snps,lpm-nyet-threshold", 1);
-	if (tmp)
-		lpm_nyet_threshold = *tmp;
-
-	dwc->is_utmi_l1_suspend = dev_read_bool(dev,
-				"snps,is-utmi-l1-suspend");
-	tmp = dev_read_u8_array_ptr(dev, "snps,hird-threshold", 1);
-	if (tmp)
-		hird_threshold = *tmp;
-
-	dwc->disable_scramble_quirk = dev_read_bool(dev,
-				"snps,disable_scramble_quirk");
-	dwc->u2exit_lfps_quirk = dev_read_bool(dev,
-				"snps,u2exit_lfps_quirk");
-	dwc->u2ss_inp3_quirk = dev_read_bool(dev,
-				"snps,u2ss_inp3_quirk");
-	dwc->req_p1p2p3_quirk = dev_read_bool(dev,
-				"snps,req_p1p2p3_quirk");
-	dwc->del_p1p2p3_quirk = dev_read_bool(dev,
-				"snps,del_p1p2p3_quirk");
-	dwc->del_phy_power_chg_quirk = dev_read_bool(dev,
-				"snps,del_phy_power_chg_quirk");
-	dwc->lfps_filter_quirk = dev_read_bool(dev,
-				"snps,lfps_filter_quirk");
-	dwc->rx_detect_poll_quirk = dev_read_bool(dev,
-				"snps,rx_detect_poll_quirk");
-	dwc->dis_u3_susphy_quirk = dev_read_bool(dev,
-				"snps,dis_u3_susphy_quirk");
-	dwc->dis_u2_susphy_quirk = dev_read_bool(dev,
-				"snps,dis_u2_susphy_quirk");
-	dwc->dis_del_phy_power_chg_quirk = dev_read_bool(dev,
-				"snps,dis-del-phy-power-chg-quirk");
-	dwc->dis_tx_ipgap_linecheck_quirk = dev_read_bool(dev,
-				"snps,dis-tx-ipgap-linecheck-quirk");
-	dwc->dis_enblslpm_quirk = dev_read_bool(dev,
-				"snps,dis_enblslpm_quirk");
-	dwc->dis_u2_freeclk_exists_quirk = dev_read_bool(dev,
-				"snps,dis-u2-freeclk-exists-quirk");
-	dwc->tx_de_emphasis_quirk = dev_read_bool(dev,
-				"snps,tx_de_emphasis_quirk");
-	tmp = dev_read_u8_array_ptr(dev, "snps,tx_de_emphasis", 1);
-	if (tmp)
-		tx_de_emphasis = *tmp;
-
-	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
-	dwc->tx_de_emphasis = tx_de_emphasis;
-
-	dwc->hird_threshold = hird_threshold
-		| (dwc->is_utmi_l1_suspend << 4);
-
-	dev_read_u32(dev, "snps,quirk-frame-length-adjustment", &dwc->fladj);
-
-	/*
-	 * Handle property "snps,incr-burst-type-adjustment".
-	 * Get the number of value from this property:
-	 * result <= 0, means this property is not supported.
-	 * result = 1, means INCRx burst mode supported.
-	 * result > 1, means undefined length burst mode supported.
-	 */
-	dwc->incrx_mode = INCRX_BURST_MODE;
-	dwc->incrx_size = 0;
-	for (i = 0; i < 8; i++) {
-		if (dev_read_u32_index(dev, "snps,incr-burst-type-adjustment",
-				       i, &val))
-			break;
-
-		dwc->incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
-		dwc->incrx_size = max(dwc->incrx_size, val);
-	}
-}
-
-int dwc3_init(struct dwc3 *dwc)
-{
-	int ret;
-	u32 reg;
+	usb_phy_init(dwc->usb3_phy);
+	usb_phy_init(dwc->usb2_phy);
+	ret = phy_init(dwc->usb2_generic_phy);
+	if (ret < 0)
+		return ret;
 
-	dwc3_cache_hwparams(dwc);
+	ret = phy_init(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_usb2phy_init;
 
-	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
-	if (ret) {
-		dev_err(dwc->dev, "failed to allocate event buffers\n");
-		return -ENOMEM;
-	}
+	spin_lock_irqsave(&dwc->lock, flags);
 
-	ret = dwc3_core_init(dwc);
-	if (ret) {
-		dev_err(dwc->dev, "failed to initialize core\n");
-		goto core_fail;
-	}
+	dwc3_event_buffers_setup(dwc);
+	dwc3_writel(dwc->regs, DWC3_GCTL, dwc->gctl);
 
-	ret = dwc3_event_buffers_setup(dwc);
-	if (ret) {
-		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto event_fail;
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+	case USB_DR_MODE_OTG:
+		dwc3_gadget_resume(dwc);
+		/* FALLTHROUGH */
+	case USB_DR_MODE_HOST:
+	default:
+		/* do nothing */
+		break;
 	}
 
-	if (dwc->revision >= DWC3_REVISION_250A) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
-		/*
-		 * Enable hardware control of sending remote wakeup
-		 * in HS when the device is in the L1 state.
-		 */
-		if (dwc->revision >= DWC3_REVISION_290A)
-			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
-		if (dwc->dis_tx_ipgap_linecheck_quirk)
-			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
+	return 0;
 
-		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
-	}
+err_usb2phy_init:
+	phy_exit(dwc->usb2_generic_phy);
 
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+	return ret;
+}
 
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+static const struct dev_pm_ops dwc3_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+};
 
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
+#define DWC3_PM_OPS	&(dwc3_dev_pm_ops)
+#else
+#define DWC3_PM_OPS	NULL
+#endif
 
-	ret = dwc3_core_init_mode(dwc);
-	if (ret)
-		goto mode_fail;
+#ifdef CONFIG_OF
+static const struct of_device_id of_dwc3_match[] = {
+	{
+		.compatible = "snps,dwc3"
+	},
+	{
+		.compatible = "synopsys,dwc3"
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_dwc3_match);
+#endif
 
-	return 0;
+#ifdef CONFIG_ACPI
 
-mode_fail:
-	dwc3_event_buffers_cleanup(dwc);
+#define ACPI_ID_INTEL_BSW	"808622B7"
 
-event_fail:
-	dwc3_core_exit(dwc);
+static const struct acpi_device_id dwc3_acpi_match[] = {
+	{ ACPI_ID_INTEL_BSW, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
+#endif
 
-core_fail:
-	dwc3_free_event_buffers(dwc);
+static struct platform_driver dwc3_driver = {
+	.probe		= dwc3_probe,
+	.remove		= dwc3_remove,
+	.driver		= {
+		.name	= "dwc3",
+		.of_match_table	= of_match_ptr(of_dwc3_match),
+		.acpi_match_table = ACPI_PTR(dwc3_acpi_match),
+		.pm	= DWC3_PM_OPS,
+	},
+};
 
-	return ret;
-}
+module_platform_driver(dwc3_driver);
 
-void dwc3_remove(struct dwc3 *dwc)
-{
-	dwc3_core_exit_mode(dwc);
-	dwc3_event_buffers_cleanup(dwc);
-	dwc3_free_event_buffers(dwc);
-	dwc3_core_stop(dwc);
-	dwc3_core_exit(dwc);
-	kfree(dwc->mem);
-}
-#endif
+MODULE_ALIAS("platform:dwc3");
+MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index cdbfdce76bb7..4bb9aa696ede 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1,28 +1,37 @@
-/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * core.h - DesignWare USB3 DRD Core Header
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/core.h) and ported
- * to uboot.
- *
- * commit 460d098cb6 : usb: dwc3: make HIRD threshold configurable
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
  *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_CORE_H
 #define __DRIVERS_USB_DWC3_CORE_H
 
-#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
 #include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
+#include <linux/debugfs.h>
 
 #include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
-#include <linux/usb/phy.h>
+
+#include <linux/phy/phy.h>
 
 #define DWC3_MSG_MAX	500
 
@@ -56,7 +65,6 @@
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
 #define DWC3_GSNPSID_MASK	0xffff0000
 #define DWC3_GSNPSREV_MASK	0xffff
-#define DWC3_GSNPS_ID(p)	(((p) & DWC3_GSNPSID_MASK) >> 16)
 
 /* DWC3 registers memory space boundries */
 #define DWC3_XHCI_REGS_START		0x0
@@ -76,7 +84,6 @@
 #define DWC3_GCTL		0xc110
 #define DWC3_GEVTEN		0xc114
 #define DWC3_GSTS		0xc118
-#define DWC3_GUCTL1		0xc11c
 #define DWC3_GSNPSID		0xc120
 #define DWC3_GGPIO		0xc124
 #define DWC3_GUID		0xc128
@@ -100,9 +107,6 @@
 #define DWC3_GPRTBIMAP_FS0	0xc188
 #define DWC3_GPRTBIMAP_FS1	0xc18c
 
-#define DWC3_VER_NUMBER		0xc1a0
-#define DWC3_VER_TYPE		0xc1a4
-
 #define DWC3_GUSB2PHYCFG(n)	(0xc200 + (n * 0x04))
 #define DWC3_GUSB2I2CCTL(n)	(0xc240 + (n * 0x04))
 
@@ -119,7 +123,6 @@
 #define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
-#define DWC3_GFLADJ		0xc630
 
 /* Device Registers */
 #define DWC3_DCFG		0xc700
@@ -143,17 +146,6 @@
 
 /* Bit fields */
 
-/* Global SoC Bus Configuration INCRx Register 0 */
-#define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
-#define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
-#define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
-#define DWC3_GSBUSCFG0_INCR32BRSTENA	(1 << 4) /* INCR32 burst */
-#define DWC3_GSBUSCFG0_INCR16BRSTENA	(1 << 3) /* INCR16 burst */
-#define DWC3_GSBUSCFG0_INCR8BRSTENA	(1 << 2) /* INCR8 burst */
-#define DWC3_GSBUSCFG0_INCR4BRSTENA	(1 << 1) /* INCR4 burst */
-#define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
-#define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
-
 /* Global Configuration Register */
 #define DWC3_GCTL_PWRDNSCALE(n)	((n) << 19)
 #define DWC3_GCTL_U2RSTECN	(1 << 16)
@@ -178,26 +170,9 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
 #define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
-/* Global User Control 1 Register */
-#define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
-#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
-
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
-#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
-#define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
-#define DWC3_GUSB2PHYCFG_PHYIF(n)	((n) << 3)
-#define DWC3_GUSB2PHYCFG_PHYIF_MASK	DWC3_GUSB2PHYCFG_PHYIF(1)
-#define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	((n) << 10)
-#define DWC3_GUSB2PHYCFG_USBTRDTIM_MASK	DWC3_GUSB2PHYCFG_USBTRDTIM(0xf)
-#define USBTRDTIM_UTMI_8_BIT		9
-#define USBTRDTIM_UTMI_16_BIT		5
-#define UTMI_PHYIF_16_BIT		1
-#define UTMI_PHYIF_8_BIT		0
 
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
@@ -249,17 +224,6 @@
 /* Global HWPARAMS6 Register */
 #define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
 
-/* Global Frame Length Adjustment Register */
-#define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
-#define DWC3_GFLADJ_30MHZ_MASK			0x3f
-#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
-#define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
-#define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
-
-/* Global User Control Register*/
-#define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
-#define DWC3_GUCTL_REFCLKPER_SEL		22
-
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -409,8 +373,6 @@
 #define DWC3_DEPCMD_SETTRANSFRESOURCE	(0x02 << 0)
 #define DWC3_DEPCMD_SETEPCONFIG		(0x01 << 0)
 
-#define DWC3_DEPCMD_CMD(x)		((x) & 0xf)
-
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
 #define DWC3_DALEPENA_EP(n)		(1 << n)
 
@@ -440,7 +402,7 @@ struct dwc3_event_buffer {
 	unsigned int		count;
 	unsigned int		flags;
 
-#define DWC3_EVENT_PENDING	(1UL << 0)
+#define DWC3_EVENT_PENDING	BIT(0)
 
 	dma_addr_t		dma;
 
@@ -674,7 +636,6 @@ struct dwc3_scratchpad_array {
  * @ep0_trb: dma address of ep0_trb
  * @ep0_usb_req: dummy req used while handling STD USB requests
  * @ep0_bounce_addr: dma address of ep0_bounce
- * @setup_buf_addr: dma address of setup_buf
  * @scratch_addr: dma address of scratchbuf
  * @lock: for synchronizing
  * @dev: pointer to our struct device
@@ -682,21 +643,18 @@ struct dwc3_scratchpad_array {
  * @event_buffer_list: a list of event buffers
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
- * @ref_clk: reference clock
  * @regs: base address for our registers
  * @regs_size: address space size
- * @ref_clk_per: reference clock period configuration
  * @nr_scratch: number of scratch buffers
  * @num_event_buffers: calculated number of event buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
- * @ip: controller's ID
  * @revision: revision register contents
- * @version_type: VERSIONTYPE register contents, a sub release of a revision
  * @dr_mode: requested mode of operation
- * @hsphy_mode: UTMI phy mode, one of following:
- *		- USBPHY_INTERFACE_MODE_UTMI
- *		- USBPHY_INTERFACE_MODE_UTMIW
+ * @usb2_phy: pointer to USB2 PHY
+ * @usb3_phy: pointer to USB3 PHY
+ * @usb2_generic_phy: pointer to USB2 PHY
+ * @usb3_generic_phy: pointer to USB3 PHY
  * @dcfg: saved contents of DCFG register
  * @gctl: saved contents of GCTL register
  * @isoch_delay: wValue from Set Isochronous Delay request;
@@ -725,8 +683,8 @@ struct dwc3_scratchpad_array {
  * @has_lpm_erratum: true when core was configured with LPM Erratum. Note that
  *			there's now way for software to detect this in runtime.
  * @is_utmi_l1_suspend: the core asserts output signal
- *	0	- utmi_sleep_n
- *	1	- utmi_l1_suspend_n
+ * 	0	- utmi_sleep_n
+ * 	1	- utmi_l1_suspend_n
  * @is_selfpowered: true when we are selfpowered
  * @is_fpga: true when we are using the FPGA board
  * @needs_fifo_resize: not all users might want fifo resizing, flag it
@@ -747,12 +705,10 @@ struct dwc3_scratchpad_array {
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
- *	0	- -6dB de-emphasis
- *	1	- -3.5dB de-emphasis
- *	2	- No de-emphasis
- *	3	- Reserved
- * @index: index of _this_ controller
- * @list: to maintain the list of dwc3 controllers
+ * 	0	- -6dB de-emphasis
+ * 	1	- -3.5dB de-emphasis
+ * 	2	- No de-emphasis
+ * 	3	- Reserved
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -764,17 +720,12 @@ struct dwc3 {
 	dma_addr_t		ep0_trb_addr;
 	dma_addr_t		ep0_bounce_addr;
 	dma_addr_t		scratch_addr;
-	dma_addr_t		setup_buf_addr;
 	struct dwc3_request	ep0_usb_req;
 
 	/* device lock */
 	spinlock_t		lock;
 
-#if defined(__UBOOT__) && CONFIG_IS_ENABLED(DM_USB)
-	struct udevice		*dev;
-#else
 	struct device		*dev;
-#endif
 
 	struct platform_device	*xhci;
 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
@@ -785,13 +736,16 @@ struct dwc3 {
 	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
-	struct clk		*ref_clk;
+	struct usb_phy		*usb2_phy;
+	struct usb_phy		*usb3_phy;
+
+	struct phy		*usb2_generic_phy;
+	struct phy		*usb3_generic_phy;
 
 	void __iomem		*regs;
 	size_t			regs_size;
 
 	enum usb_dr_mode	dr_mode;
-	enum usb_phy_interface	hsphy_mode;
 
 	/* used for suspend/resume */
 	u32			dcfg;
@@ -801,13 +755,6 @@ struct dwc3 {
 	u32			num_event_buffers;
 	u32			u1u2;
 	u32			maximum_speed;
-
-	u32			ip;
-
-#define DWC3_IP			0x5533
-#define DWC31_IP		0x3331
-#define DWC32_IP		0x3332
-
 	u32			revision;
 
 #define DWC3_REVISION_173A	0x5533173a
@@ -829,33 +776,6 @@ struct dwc3 {
 #define DWC3_REVISION_260A	0x5533260a
 #define DWC3_REVISION_270A	0x5533270a
 #define DWC3_REVISION_280A	0x5533280a
-#define DWC3_REVISION_290A	0x5533290a
-#define DWC3_REVISION_300A	0x5533300a
-#define DWC3_REVISION_310A	0x5533310a
-#define DWC3_REVISION_320A	0x5533320a
-#define DWC3_REVISION_330A	0x5533330a
-
-#define DWC31_REVISION_ANY	0x0
-#define DWC31_REVISION_110A	0x3131302a
-#define DWC31_REVISION_120A	0x3132302a
-#define DWC31_REVISION_160A	0x3136302a
-#define DWC31_REVISION_170A	0x3137302a
-#define DWC31_REVISION_180A	0x3138302a
-#define DWC31_REVISION_190A	0x3139302a
-#define DWC31_REVISION_200A	0x3230302a
-
-#define DWC32_REVISION_ANY	0x0
-#define DWC32_REVISION_100A	0x3130302a
-
-	u32			version_type;
-
-#define DWC31_VERSIONTYPE_ANY		0x0
-#define DWC31_VERSIONTYPE_EA01		0x65613031
-#define DWC31_VERSIONTYPE_EA02		0x65613032
-#define DWC31_VERSIONTYPE_EA03		0x65613033
-#define DWC31_VERSIONTYPE_EA04		0x65613034
-#define DWC31_VERSIONTYPE_EA05		0x65613035
-#define DWC31_VERSIONTYPE_EA06		0x65613036
 
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
@@ -882,10 +802,6 @@ struct dwc3 {
 	u8			test_mode_nr;
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
-	u32			fladj;
-	u32			ref_clk_per;
-	u8			incrx_mode;
-	u32			incrx_size;
 
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
@@ -912,20 +828,11 @@ struct dwc3 {
 	unsigned		rx_detect_poll_quirk:1;
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
-	unsigned		dis_del_phy_power_chg_quirk:1;
-	unsigned		dis_tx_ipgap_linecheck_quirk:1;
-	unsigned		dis_enblslpm_quirk:1;
-	unsigned		dis_u2_freeclk_exists_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
-	int			index;
-	struct list_head        list;
 };
 
-#define INCRX_BURST_MODE 0
-#define INCRX_UNDEF_LENGTH_BURST_MODE 1
-
 /* -------------------------------------------------------------------------- */
 
 /* -------------------------------------------------------------------------- */
@@ -943,30 +850,6 @@ struct dwc3_event_type {
 #define DWC3_DEPEVT_STREAMEVT		0x06
 #define DWC3_DEPEVT_EPCMDCMPLT		0x07
 
-/**
- * dwc3_ep_event_string - returns event name
- * @event: then event code
- */
-static inline const char *dwc3_ep_event_string(u8 event)
-{
-	switch (event) {
-	case DWC3_DEPEVT_XFERCOMPLETE:
-		return "Transfer Complete";
-	case DWC3_DEPEVT_XFERINPROGRESS:
-		return "Transfer In-Progress";
-	case DWC3_DEPEVT_XFERNOTREADY:
-		return "Transfer Not Ready";
-	case DWC3_DEPEVT_RXTXFIFOEVT:
-		return "FIFO";
-	case DWC3_DEPEVT_STREAMEVT:
-		return "Stream";
-	case DWC3_DEPEVT_EPCMDCMPLT:
-		return "Endpoint Command Complete";
-	}
-
-	return "UNKNOWN";
-}
-
 /**
  * struct dwc3_event_depvt - Device Endpoint Events
  * @one_bit: indicates this is an endpoint event (not used)
@@ -1096,38 +979,20 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
+void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
-void dwc3_of_parse(struct dwc3 *dwc);
-int dwc3_init(struct dwc3 *dwc);
-void dwc3_remove(struct dwc3 *dwc);
-
-#define DWC3_IP_IS(_ip)							\
-	(dwc->ip == _ip##_IP)
-
-#define DWC3_VER_IS(_ip, _ver)						\
-	(DWC3_IP_IS(_ip) && dwc->revision == _ip##_REVISION_##_ver)
-
-#define DWC3_VER_IS_PRIOR(_ip, _ver)					\
-	(DWC3_IP_IS(_ip) && dwc->revision < _ip##_REVISION_##_ver)
-
-#define DWC3_VER_IS_WITHIN(_ip, _from, _to)				\
-	(DWC3_IP_IS(_ip) &&						\
-	 dwc->revision >= _ip##_REVISION_##_from &&			\
-	 (!(_ip##_REVISION_##_to) ||					\
-	  dwc->revision <= _ip##_REVISION_##_to))
-
-#define DWC3_VER_TYPE_IS_WITHIN(_ip, _ver, _from, _to)			\
-	(DWC3_VER_IS(_ip, _ver) &&					\
-	 dwc->version_type >= _ip##_VERSIONTYPE_##_from &&		\
-	 (!(_ip##_VERSIONTYPE_##_to) ||					\
-	  dwc->version_type <= _ip##_VERSIONTYPE_##_to))
 
+#if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
+int dwc3_host_init(struct dwc3 *dwc);
+void dwc3_host_exit(struct dwc3 *dwc);
+#else
 static inline int dwc3_host_init(struct dwc3 *dwc)
 { return 0; }
 static inline void dwc3_host_exit(struct dwc3 *dwc)
 { }
+#endif
 
-#ifdef CONFIG_USB_DWC3_GADGET
+#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_gadget_init(struct dwc3 *dwc);
 void dwc3_gadget_exit(struct dwc3 *dwc);
 int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode);
@@ -1157,4 +1022,20 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 { return 0; }
 #endif
 
+/* power management interface */
+#if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
+int dwc3_gadget_suspend(struct dwc3 *dwc);
+int dwc3_gadget_resume(struct dwc3 *dwc);
+#else
+static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
+{
+	return 0;
+}
+
+static inline int dwc3_gadget_resume(struct dwc3 *dwc)
+{
+	return 0;
+}
+#endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
+
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/debug.c b/drivers/usb/dwc3/debug.c
new file mode 100644
index 000000000000..0be6885bc370
--- /dev/null
+++ b/drivers/usb/dwc3/debug.c
@@ -0,0 +1,32 @@
+/**
+ * debug.c - DesignWare USB3 DRD Controller Debug/Trace Support
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Felipe Balbi <balbi@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "debug.h"
+
+void dwc3_trace(void (*trace)(struct va_format *), const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	trace(&vaf);
+
+	va_end(args);
+}
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
new file mode 100644
index 000000000000..07fbc2d94fd4
--- /dev/null
+++ b/drivers/usb/dwc3/debug.h
@@ -0,0 +1,228 @@
+/**
+ * debug.h - DesignWare USB3 DRD Controller Debug Header
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Authors: Felipe Balbi <balbi@ti.com>,
+ *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DWC3_DEBUG_H
+#define __DWC3_DEBUG_H
+
+#include "core.h"
+
+/**
+ * dwc3_gadget_ep_cmd_string - returns endpoint command string
+ * @cmd: command code
+ */
+static inline const char *
+dwc3_gadget_ep_cmd_string(u8 cmd)
+{
+	switch (cmd) {
+	case DWC3_DEPCMD_DEPSTARTCFG:
+		return "Start New Configuration";
+	case DWC3_DEPCMD_ENDTRANSFER:
+		return "End Transfer";
+	case DWC3_DEPCMD_UPDATETRANSFER:
+		return "Update Transfer";
+	case DWC3_DEPCMD_STARTTRANSFER:
+		return "Start Transfer";
+	case DWC3_DEPCMD_CLEARSTALL:
+		return "Clear Stall";
+	case DWC3_DEPCMD_SETSTALL:
+		return "Set Stall";
+	case DWC3_DEPCMD_GETEPSTATE:
+		return "Get Endpoint State";
+	case DWC3_DEPCMD_SETTRANSFRESOURCE:
+		return "Set Endpoint Transfer Resource";
+	case DWC3_DEPCMD_SETEPCONFIG:
+		return "Set Endpoint Configuration";
+	default:
+		return "UNKNOWN command";
+	}
+}
+
+/**
+ * dwc3_gadget_generic_cmd_string - returns generic command string
+ * @cmd: command code
+ */
+static inline const char *
+dwc3_gadget_generic_cmd_string(u8 cmd)
+{
+	switch (cmd) {
+	case DWC3_DGCMD_SET_LMP:
+		return "Set LMP";
+	case DWC3_DGCMD_SET_PERIODIC_PAR:
+		return "Set Periodic Parameters";
+	case DWC3_DGCMD_XMIT_FUNCTION:
+		return "Transmit Function Wake Device Notification";
+	case DWC3_DGCMD_SET_SCRATCHPAD_ADDR_LO:
+		return "Set Scratchpad Buffer Array Address Lo";
+	case DWC3_DGCMD_SET_SCRATCHPAD_ADDR_HI:
+		return "Set Scratchpad Buffer Array Address Hi";
+	case DWC3_DGCMD_SELECTED_FIFO_FLUSH:
+		return "Selected FIFO Flush";
+	case DWC3_DGCMD_ALL_FIFO_FLUSH:
+		return "All FIFO Flush";
+	case DWC3_DGCMD_SET_ENDPOINT_NRDY:
+		return "Set Endpoint NRDY";
+	case DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK:
+		return "Run SoC Bus Loopback Test";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+/**
+ * dwc3_gadget_link_string - returns link name
+ * @link_state: link state code
+ */
+static inline const char *
+dwc3_gadget_link_string(enum dwc3_link_state link_state)
+{
+	switch (link_state) {
+	case DWC3_LINK_STATE_U0:
+		return "U0";
+	case DWC3_LINK_STATE_U1:
+		return "U1";
+	case DWC3_LINK_STATE_U2:
+		return "U2";
+	case DWC3_LINK_STATE_U3:
+		return "U3";
+	case DWC3_LINK_STATE_SS_DIS:
+		return "SS.Disabled";
+	case DWC3_LINK_STATE_RX_DET:
+		return "RX.Detect";
+	case DWC3_LINK_STATE_SS_INACT:
+		return "SS.Inactive";
+	case DWC3_LINK_STATE_POLL:
+		return "Polling";
+	case DWC3_LINK_STATE_RECOV:
+		return "Recovery";
+	case DWC3_LINK_STATE_HRESET:
+		return "Hot Reset";
+	case DWC3_LINK_STATE_CMPLY:
+		return "Compliance";
+	case DWC3_LINK_STATE_LPBK:
+		return "Loopback";
+	case DWC3_LINK_STATE_RESET:
+		return "Reset";
+	case DWC3_LINK_STATE_RESUME:
+		return "Resume";
+	default:
+		return "UNKNOWN link state\n";
+	}
+}
+
+/**
+ * dwc3_gadget_event_string - returns event name
+ * @event: the event code
+ */
+static inline const char *dwc3_gadget_event_string(u8 event)
+{
+	switch (event) {
+	case DWC3_DEVICE_EVENT_DISCONNECT:
+		return "Disconnect";
+	case DWC3_DEVICE_EVENT_RESET:
+		return "Reset";
+	case DWC3_DEVICE_EVENT_CONNECT_DONE:
+		return "Connection Done";
+	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
+		return "Link Status Change";
+	case DWC3_DEVICE_EVENT_WAKEUP:
+		return "WakeUp";
+	case DWC3_DEVICE_EVENT_EOPF:
+		return "End-Of-Frame";
+	case DWC3_DEVICE_EVENT_SOF:
+		return "Start-Of-Frame";
+	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
+		return "Erratic Error";
+	case DWC3_DEVICE_EVENT_CMD_CMPL:
+		return "Command Complete";
+	case DWC3_DEVICE_EVENT_OVERFLOW:
+		return "Overflow";
+	}
+
+	return "UNKNOWN";
+}
+
+/**
+ * dwc3_ep_event_string - returns event name
+ * @event: then event code
+ */
+static inline const char *dwc3_ep_event_string(u8 event)
+{
+	switch (event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		return "Transfer Complete";
+	case DWC3_DEPEVT_XFERINPROGRESS:
+		return "Transfer In-Progress";
+	case DWC3_DEPEVT_XFERNOTREADY:
+		return "Transfer Not Ready";
+	case DWC3_DEPEVT_RXTXFIFOEVT:
+		return "FIFO";
+	case DWC3_DEPEVT_STREAMEVT:
+		return "Stream";
+	case DWC3_DEPEVT_EPCMDCMPLT:
+		return "Endpoint Command Complete";
+	}
+
+	return "UNKNOWN";
+}
+
+/**
+ * dwc3_gadget_event_type_string - return event name
+ * @event: the event code
+ */
+static inline const char *dwc3_gadget_event_type_string(u8 event)
+{
+	switch (event) {
+	case DWC3_DEVICE_EVENT_DISCONNECT:
+		return "Disconnect";
+	case DWC3_DEVICE_EVENT_RESET:
+		return "Reset";
+	case DWC3_DEVICE_EVENT_CONNECT_DONE:
+		return "Connect Done";
+	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
+		return "Link Status Change";
+	case DWC3_DEVICE_EVENT_WAKEUP:
+		return "Wake-Up";
+	case DWC3_DEVICE_EVENT_HIBER_REQ:
+		return "Hibernation";
+	case DWC3_DEVICE_EVENT_EOPF:
+		return "End of Periodic Frame";
+	case DWC3_DEVICE_EVENT_SOF:
+		return "Start of Frame";
+	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
+		return "Erratic Error";
+	case DWC3_DEVICE_EVENT_CMD_CMPL:
+		return "Command Complete";
+	case DWC3_DEVICE_EVENT_OVERFLOW:
+		return "Overflow";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+void dwc3_trace(void (*trace)(struct va_format *), const char *fmt, ...);
+
+#ifdef CONFIG_DEBUG_FS
+extern int dwc3_debugfs_init(struct dwc3 *);
+extern void dwc3_debugfs_exit(struct dwc3 *);
+#else
+static inline int dwc3_debugfs_init(struct dwc3 *d)
+{  return 0;  }
+static inline void dwc3_debugfs_exit(struct dwc3 *d)
+{  }
+#endif
+#endif /* __DWC3_DEBUG_H */
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
deleted file mode 100644
index 57a34d69fbeb..000000000000
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * TI AM62 specific glue layer for DWC3
- */
-
-#include <dm.h>
-#include <dm/device_compat.h>
-#include <regmap.h>
-#include <syscon.h>
-#include <asm/io.h>
-
-#include "dwc3-generic.h"
-
-#define USBSS_MODE_CONTROL		0x1c
-#define USBSS_PHY_CONFIG		0x8
-#define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
-#define USBSS_PHY_VBUS_SEL_SHIFT	1
-#define USBSS_MODE_VALID	BIT(0)
-#define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
-static const int dwc3_ti_am62_rate_table[] = {	/* in KHZ */
-	9600,
-	10000,
-	12000,
-	19200,
-	20000,
-	24000,
-	25000,
-	26000,
-	38400,
-	40000,
-	58000,
-	50000,
-	52000,
-};
-
-static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
-					enum usb_dr_mode mode)
-{
-	struct clk usb2_refclk;
-	int rate_code, i, ret;
-	unsigned long rate;
-	u32 reg;
-	void *usbss;
-	bool vbus_divider;
-	struct regmap *syscon;
-	struct ofnode_phandle_args args;
-
-	usbss = dev_remap_addr_index(dev, 0);
-	if (!usbss) {
-		dev_err(dev, "can't map IOMEM resource\n");
-		return;
-	}
-
-	ret = clk_get_by_name(dev, "ref", &usb2_refclk);
-	if (ret) {
-		dev_err(dev, "can't get usb2_refclk\n");
-		return;
-	}
-
-	/* Calculate the rate code */
-	rate = clk_get_rate(&usb2_refclk);
-	rate /= 1000;	/* To KHz */
-	for (i = 0; i < ARRAY_SIZE(dwc3_ti_am62_rate_table); i++) {
-		if (dwc3_ti_am62_rate_table[i] == rate)
-			break;
-	}
-
-	if (i == ARRAY_SIZE(dwc3_ti_am62_rate_table)) {
-		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
-		return;
-	}
-
-	rate_code = i;
-
-	/* Read the syscon property */
-	syscon = syscon_regmap_lookup_by_phandle(dev, "ti,syscon-phy-pll-refclk");
-	if (IS_ERR(syscon)) {
-		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
-		return;
-	}
-
-	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "ti,syscon-phy-pll-refclk", NULL, 1,
-					     0, &args);
-	if (ret)
-		return;
-
-	/* Program PHY PLL refclk by reading syscon property */
-	ret = regmap_update_bits(syscon, args.args[0], PHY_PLL_REFCLK_MASK, rate_code);
-	if (ret) {
-		dev_err(dev, "failed to set phy pll reference clock rate\n");
-		return;
-	}
-
-	/* VBUS divider select */
-	reg = readl(usbss + USBSS_PHY_CONFIG);
-	vbus_divider = dev_read_bool(dev, "ti,vbus-divider");
-	if (vbus_divider)
-		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
-
-	writel(reg, usbss + USBSS_PHY_CONFIG);
-
-	/* Set mode valid */
-	reg = readl(usbss + USBSS_MODE_CONTROL);
-	reg |= USBSS_MODE_VALID;
-	writel(reg, usbss + USBSS_MODE_CONTROL);
-}
-
-static const struct dwc3_glue_ops ti_am62_ops = {
-	.glue_configure = dwc3_ti_am62_glue_configure,
-};
-
-static const struct udevice_id dwc3_am62_match[] = {
-	{ .compatible = "ti,am62-usb", .data = (ulong)&ti_am62_ops },
-	{ /* sentinel */ }
-};
-
-U_BOOT_DRIVER(dwc3_am62_wrapper) = {
-	.name	= "dwc3-am62",
-	.id	= UCLASS_SIMPLE_BUS,
-	.of_match = dwc3_am62_match,
-	.bind = dwc3_glue_bind,
-	.probe = dwc3_glue_probe,
-	.remove = dwc3_glue_remove,
-	.plat_auto	= sizeof(struct dwc3_glue_data),
-};
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 680756532f0d..1bc77a3b4997 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1,34 +1,40 @@
-// SPDX-License-Identifier: GPL-2.0
 /**
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/ep0.c) and ported
- * to uboot.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
  *
- * commit c00552ebaf : Merge 3.18-rc7 into usb-next
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
-#include <cpu_func.h>
-#include <dm.h>
-#include <dm/device_compat.h>
-#include <linux/bug.h>
+
 #include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/list.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
 
 #include "core.h"
+#include "debug.h"
 #include "gadget.h"
 #include "io.h"
 
-#include "linux-compat.h"
-
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req);
@@ -50,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
 }
 
 static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
-				u32 len, u32 type, unsigned chain)
+		u32 len, u32 type)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_trb			*trb;
@@ -60,14 +66,11 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 
 	dep = dwc->eps[epnum];
 	if (dep->flags & DWC3_EP_BUSY) {
-		dev_vdbg(dwc->dev, "%s still busy\n", dep->name);
+		dwc3_trace(trace_dwc3_ep0, "%s still busy", dep->name);
 		return 0;
 	}
 
-	trb = &dwc->ep0_trb[dep->free_slot];
-
-	if (chain)
-		dep->free_slot++;
+	trb = dwc->ep0_trb;
 
 	trb->bpl = lower_32_bits(buf_dma);
 	trb->bph = upper_32_bits(buf_dma);
@@ -75,28 +78,21 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 	trb->ctrl = type;
 
 	trb->ctrl |= (DWC3_TRB_CTRL_HWO
+			| DWC3_TRB_CTRL_LST
+			| DWC3_TRB_CTRL_IOC
 			| DWC3_TRB_CTRL_ISP_IMI);
 
-	if (chain)
-		trb->ctrl |= DWC3_TRB_CTRL_CHN;
-	else
-		trb->ctrl |= (DWC3_TRB_CTRL_IOC
-				| DWC3_TRB_CTRL_LST);
-
-	dwc3_flush_cache((uintptr_t)buf_dma, len);
-	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
-
-	if (chain)
-		return 0;
-
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
 
+	trace_dwc3_prepare_trb(dep, trb);
+
 	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number,
 			DWC3_DEPCMD_STARTTRANSFER, &params);
 	if (ret < 0) {
-		dev_dbg(dwc->dev, "%s STARTTRANSFER failed", dep->name);
+		dwc3_trace(trace_dwc3_ep0, "%s STARTTRANSFER failed",
+				dep->name);
 		return ret;
 	}
 
@@ -161,7 +157,8 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 		if (dwc->ep0state == EP0_STATUS_PHASE)
 			__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
 		else
-			dev_dbg(dwc->dev, "too early for delayed status");
+			dwc3_trace(trace_dwc3_ep0,
+					"too early for delayed status");
 
 		return 0;
 	}
@@ -225,7 +222,8 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (!dep->endpoint.desc) {
-		dev_dbg(dwc->dev, "trying to queue request %p to disabled %s",
+		dwc3_trace(trace_dwc3_ep0,
+				"trying to queue request %p to disabled %s",
 				request, dep->name);
 		ret = -ESHUTDOWN;
 		goto out;
@@ -237,9 +235,10 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		goto out;
 	}
 
-	dev_vdbg(dwc->dev, "queueing request %p to %s length %d state '%s\n'",
-		 request, dep->name, request->length,
-		 dwc3_ep0_state_string(dwc->ep0state));
+	dwc3_trace(trace_dwc3_ep0,
+			"queueing request %p to %s length %d state '%s'",
+			request, dep->name, request->length,
+			dwc3_ep0_state_string(dwc->ep0state));
 
 	ret = __dwc3_gadget_ep0_queue(dep, req);
 
@@ -286,6 +285,8 @@ int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 
 int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 {
+	struct dwc3_ep			*dep = to_dwc3_ep(ep);
+	struct dwc3			*dwc = dep->dwc;
 	unsigned long			flags;
 	int				ret;
 
@@ -301,7 +302,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	int				ret;
 
 	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
-				   DWC3_TRBCTL_CONTROL_SETUP, 0);
+			DWC3_TRBCTL_CONTROL_SETUP);
 	WARN_ON(ret < 0);
 }
 
@@ -380,7 +381,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = sizeof(*response_pkt);
-	dwc->ep0_usb_req.request.buf = (void *)(uintptr_t)dwc->setup_buf_addr;
+	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_status_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
@@ -504,12 +505,13 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 	addr = le16_to_cpu(ctrl->wValue);
 	if (addr > 127) {
-		dev_dbg(dwc->dev, "invalid device address %d", addr);
+		dwc3_trace(trace_dwc3_ep0, "invalid device address %d", addr);
 		return -EINVAL;
 	}
 
 	if (state == USB_STATE_CONFIGURED) {
-		dev_dbg(dwc->dev, "trying to set address when configured");
+		dwc3_trace(trace_dwc3_ep0,
+				"trying to set address when configured");
 		return -EINVAL;
 	}
 
@@ -574,7 +576,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 			dwc->resize_fifos = true;
-			dev_dbg(dwc->dev, "resize FIFOs flag SET");
+			dwc3_trace(trace_dwc3_ep0, "resize FIFOs flag SET");
 		}
 		break;
 
@@ -639,10 +641,12 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	struct dwc3_ep	*dep;
 	enum usb_device_state state = dwc->gadget.state;
 	u16		wLength;
+	u16		wValue;
 
 	if (state == USB_STATE_DEFAULT)
 		return -EINVAL;
 
+	wValue = le16_to_cpu(ctrl->wValue);
 	wLength = le16_to_cpu(ctrl->wLength);
 
 	if (wLength != 6) {
@@ -662,7 +666,7 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = dep->endpoint.maxpacket;
-	dwc->ep0_usb_req.request.buf = (void *)(uintptr_t)dwc->setup_buf_addr;
+	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_set_sel_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
@@ -696,35 +700,35 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 	switch (ctrl->bRequest) {
 	case USB_REQ_GET_STATUS:
-		dev_vdbg(dwc->dev, "USB_REQ_GET_STATUS\n");
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_GET_STATUS");
 		ret = dwc3_ep0_handle_status(dwc, ctrl);
 		break;
 	case USB_REQ_CLEAR_FEATURE:
-		dev_vdbg(dwc->dev, "USB_REQ_CLEAR_FEATURE\n");
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_CLEAR_FEATURE");
 		ret = dwc3_ep0_handle_feature(dwc, ctrl, 0);
 		break;
 	case USB_REQ_SET_FEATURE:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_FEATURE\n");
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_FEATURE");
 		ret = dwc3_ep0_handle_feature(dwc, ctrl, 1);
 		break;
 	case USB_REQ_SET_ADDRESS:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_ADDRESS\n");
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ADDRESS");
 		ret = dwc3_ep0_set_address(dwc, ctrl);
 		break;
 	case USB_REQ_SET_CONFIGURATION:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_CONFIGURATION\n");
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_CONFIGURATION");
 		ret = dwc3_ep0_set_config(dwc, ctrl);
 		break;
 	case USB_REQ_SET_SEL:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_SEL\n");
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_SEL");
 		ret = dwc3_ep0_set_sel(dwc, ctrl);
 		break;
 	case USB_REQ_SET_ISOCH_DELAY:
-		dev_vdbg(dwc->dev, "USB_REQ_SET_ISOCH_DELAY\n");
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ISOCH_DELAY");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
 	default:
-		dev_vdbg(dwc->dev, "Forwarding to gadget driver\n");
+		dwc3_trace(trace_dwc3_ep0, "Forwarding to gadget driver");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		break;
 	}
@@ -742,7 +746,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	if (!dwc->gadget_driver)
 		goto out;
 
-	dwc3_invalidate_cache((uintptr_t)ctrl, sizeof(*ctrl));
+	trace_dwc3_ctrl_req(ctrl);
 
 	len = le16_to_cpu(ctrl->wLength);
 	if (!len) {
@@ -775,10 +779,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	unsigned		transfer_size = 0;
-	unsigned		maxp;
-	void			*buf;
-	u32			transferred = 0;
+	u32			transferred;
 	u32			status;
 	u32			length;
 	u8			epnum;
@@ -790,50 +791,34 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	trb = dwc->ep0_trb;
 
+	trace_dwc3_complete_trb(ep0, trb);
+
 	r = next_request(&ep0->request_list);
 	if (!r)
 		return;
 
-	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
-
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 	if (status == DWC3_TRBSTS_SETUP_PENDING) {
-		dev_dbg(dwc->dev, "Setup Pending received");
-		dwc3_gadget_giveback(ep0, r, -ECONNRESET);
+		dwc3_trace(trace_dwc3_ep0, "Setup Pending received");
+
+		if (r)
+			dwc3_gadget_giveback(ep0, r, -ECONNRESET);
+
 		return;
 	}
 
 	ur = &r->request;
-	buf = ur->buf;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 
-	maxp = ep0->endpoint.maxpacket;
-
 	if (dwc->ep0_bounced) {
-		/*
-		 * Handle the first TRB before handling the bounce buffer if
-		 * the request length is greater than the bounce buffer size.
-		 */
-		if (ur->length > DWC3_EP0_BOUNCE_SIZE) {
-			transfer_size = (ur->length / maxp) * maxp;
-			transferred = transfer_size - length;
-			buf = (u8 *)buf + transferred;
-			ur->actual += transferred;
+		unsigned transfer_size = ur->length;
+		unsigned maxp = ep0->endpoint.maxpacket;
 
-			trb++;
-			dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
-			length = trb->size & DWC3_TRB_SIZE_MASK;
-
-			ep0->free_slot = 0;
-		}
-
-		transfer_size = roundup((ur->length - transfer_size),
-					maxp);
-		transferred = min_t(u32, ur->length - transferred,
-				    transfer_size - length);
-		dwc3_flush_cache((uintptr_t)dwc->ep0_bounce, DWC3_EP0_BOUNCE_SIZE);
-		memcpy(buf, dwc->ep0_bounce, transferred);
+		transfer_size += (maxp - (transfer_size % maxp));
+		transferred = min_t(u32, ur->length,
+				transfer_size - length);
+		memcpy(ur->buf, dwc->ep0_bounce, transferred);
 	} else {
 		transferred = ur->length - length;
 	}
@@ -855,7 +840,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 			ret = dwc3_ep0_start_trans(dwc, epnum,
 					dwc->ctrl_req_addr, 0,
-					DWC3_TRBCTL_CONTROL_DATA, 0);
+					DWC3_TRBCTL_CONTROL_DATA);
 			WARN_ON(ret < 0);
 		}
 	}
@@ -872,6 +857,8 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	trb = dwc->ep0_trb;
 
+	trace_dwc3_complete_trb(dep, trb);
+
 	if (!list_empty(&dep->request_list)) {
 		r = next_request(&dep->request_list);
 
@@ -883,7 +870,7 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 
 		ret = dwc3_gadget_set_test_mode(dwc, dwc->test_mode_nr);
 		if (ret < 0) {
-			dev_dbg(dwc->dev, "Invalid Test #%d",
+			dwc3_trace(trace_dwc3_ep0, "Invalid Test #%d",
 					dwc->test_mode_nr);
 			dwc3_ep0_stall_and_restart(dwc);
 			return;
@@ -892,7 +879,7 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 	if (status == DWC3_TRBSTS_SETUP_PENDING)
-		dev_dbg(dwc->dev, "Setup Pending received");
+		dwc3_trace(trace_dwc3_ep0, "Setup Pending received");
 
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc3_ep0_out_start(dwc);
@@ -909,17 +896,17 @@ static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
 
 	switch (dwc->ep0state) {
 	case EP0_SETUP_PHASE:
-		dev_vdbg(dwc->dev, "Setup Phase\n");
+		dwc3_trace(trace_dwc3_ep0, "Setup Phase");
 		dwc3_ep0_inspect_setup(dwc, event);
 		break;
 
 	case EP0_DATA_PHASE:
-		dev_vdbg(dwc->dev, "Data Phase\n");
+		dwc3_trace(trace_dwc3_ep0, "Data Phase");
 		dwc3_ep0_complete_data(dwc, event);
 		break;
 
 	case EP0_STATUS_PHASE:
-		dev_vdbg(dwc->dev, "Status Phase\n");
+		dwc3_trace(trace_dwc3_ep0, "Status Phase");
 		dwc3_ep0_complete_status(dwc, event);
 		break;
 	default:
@@ -936,11 +923,11 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 
 	if (req->request.length == 0) {
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
-					   dwc->ctrl_req_addr, 0,
-					   DWC3_TRBCTL_CONTROL_DATA, 0);
-	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket) &&
-			(dep->number == 0)) {
-		u32	transfer_size = 0;
+				dwc->ctrl_req_addr, 0,
+				DWC3_TRBCTL_CONTROL_DATA);
+	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
+			&& (dep->number == 0)) {
+		u32	transfer_size;
 		u32	maxpacket;
 
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
@@ -950,18 +937,10 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 		}
 
-		maxpacket = dep->endpoint.maxpacket;
-		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
-			transfer_size = (req->request.length / maxpacket) *
-						maxpacket;
-			ret = dwc3_ep0_start_trans(dwc, dep->number,
-						   req->request.dma,
-						   transfer_size,
-						   DWC3_TRBCTL_CONTROL_DATA, 1);
-		}
+		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
 
-		transfer_size = roundup((req->request.length - transfer_size),
-					maxpacket);
+		maxpacket = dep->endpoint.maxpacket;
+		transfer_size = roundup(req->request.length, maxpacket);
 
 		dwc->ep0_bounced = true;
 
@@ -971,8 +950,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		 * TRBs to handle the transfer.
 		 */
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
-					   dwc->ep0_bounce_addr, transfer_size,
-					   DWC3_TRBCTL_CONTROL_DATA, 0);
+				dwc->ep0_bounce_addr, transfer_size,
+				DWC3_TRBCTL_CONTROL_DATA);
 	} else {
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
@@ -982,8 +961,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		}
 
 		ret = dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
-					   req->request.length,
-					   DWC3_TRBCTL_CONTROL_DATA, 0);
+				req->request.length, DWC3_TRBCTL_CONTROL_DATA);
 	}
 
 	WARN_ON(ret < 0);
@@ -998,13 +976,13 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
 	return dwc3_ep0_start_trans(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type, 0);
+			dwc->ctrl_req_addr, 0, type);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	if (dwc->resize_fifos) {
-		dev_dbg(dwc->dev, "Resizing FIFOs");
+		dwc3_trace(trace_dwc3_ep0, "Resizing FIFOs");
 		dwc3_gadget_resize_tx_fifos(dwc);
 		dwc->resize_fifos = 0;
 	}
@@ -1045,7 +1023,7 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
-		dev_vdbg(dwc->dev, "Control Data\n");
+		dwc3_trace(trace_dwc3_ep0, "Control Data");
 
 		/*
 		 * We already have a DATA transfer in the controller's cache,
@@ -1059,7 +1037,8 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		if (dwc->ep0_expect_in != event->endpoint_number) {
 			struct dwc3_ep	*dep = dwc->eps[dwc->ep0_expect_in];
 
-			dev_vdbg(dwc->dev, "Wrong direction for Data phase\n");
+			dwc3_trace(trace_dwc3_ep0,
+					"Wrong direction for Data phase");
 			dwc3_ep0_end_control_data(dwc, dep);
 			dwc3_ep0_stall_and_restart(dwc);
 			return;
@@ -1071,13 +1050,13 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		if (dwc->ep0_next_event != DWC3_EP0_NRDY_STATUS)
 			return;
 
-		dev_vdbg(dwc->dev, "Control Status\n");
+		dwc3_trace(trace_dwc3_ep0, "Control Status");
 
 		dwc->ep0state = EP0_STATUS_PHASE;
 
 		if (dwc->delayed_status) {
 			WARN_ON_ONCE(event->endpoint_number != 1);
-			dev_vdbg(dwc->dev, "Delayed Status\n");
+			dwc3_trace(trace_dwc3_ep0, "Delayed Status");
 			return;
 		}
 
@@ -1090,10 +1069,10 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 {
 	u8			epnum = event->endpoint_number;
 
-	dev_dbg(dwc->dev, "%s while ep%d%s in state '%s'\n",
-		dwc3_ep_event_string(event->endpoint_event),
-		epnum >> 1, (epnum & 1) ? "in" : "out",
-		dwc3_ep0_state_string(dwc->ep0state));
+	dwc3_trace(trace_dwc3_ep0, "%s while ep%d%s in state '%s'",
+			dwc3_ep_event_string(event->endpoint_event),
+			epnum >> 1, (epnum & 1) ? "in" : "out",
+			dwc3_ep0_state_string(dwc->ep0state));
 
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 24ae0c232f63..f03b136ecfce 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1,39 +1,40 @@
-// SPDX-License-Identifier: GPL-2.0
 /**
  * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/gadget.c) and ported
- * to uboot.
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
  *
- * commit 8e74475b0e : usb: dwc3: gadget: use udc-core's reset notifier
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
-#include <cpu_func.h>
-#include <log.h>
-#include <malloc.h>
-#include <dm.h>
-#include <dm/device_compat.h>
-#include <dm/devres.h>
-#include <linux/bug.h>
+#include <linux/kernel.h>
 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/list.h>
-#include <linux/printk.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 
+#include "debug.h"
 #include "core.h"
 #include "gadget.h"
 #include "io.h"
 
-#include "linux-compat.h"
-
 /**
  * dwc3_gadget_set_test_mode - Enables USB2 Test Modes
  * @dwc: pointer to our context structure
@@ -62,7 +63,7 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 		return -EINVAL;
 	}
 
-	dwc3_gadget_dctl_write_safe(dwc, reg);
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 	return 0;
 }
@@ -167,6 +168,7 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc)
 {
 	int		last_fifo_depth = 0;
+	int		ram1_depth;
 	int		fifo_size;
 	int		mdwidth;
 	int		num;
@@ -174,6 +176,7 @@ int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc)
 	if (!dwc->needs_fifo_resize)
 		return 0;
 
+	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
 	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
 
 	/* MDWIDTH is represented in bits, we need it in bytes */
@@ -231,38 +234,40 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
 	struct dwc3			*dwc = dep->dwc;
+	int				i;
 
 	if (req->queued) {
-		dep->busy_slot++;
-		/*
-		 * Skip LINK TRB. We can't use req->trb and check for
-		 * DWC3_TRBCTL_LINK_TRB because it points the TRB we
-		 * just completed (not the LINK TRB).
-		 */
-		if (((dep->busy_slot & DWC3_TRB_MASK) ==
-			DWC3_TRB_NUM- 1) &&
-			usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		i = 0;
+		do {
 			dep->busy_slot++;
+			/*
+			 * Skip LINK TRB. We can't use req->trb and check for
+			 * DWC3_TRBCTL_LINK_TRB because it points the TRB we
+			 * just completed (not the LINK TRB).
+			 */
+			if (((dep->busy_slot & DWC3_TRB_MASK) ==
+				DWC3_TRB_NUM- 1) &&
+				usb_endpoint_xfer_isoc(dep->endpoint.desc))
+				dep->busy_slot++;
+		} while(++i < req->request.num_mapped_sgs);
 		req->queued = false;
 	}
-
 	list_del(&req->list);
 	req->trb = NULL;
-	if (req->request.dma && req->request.length)
-		dwc3_flush_cache((uintptr_t)req->request.dma, req->request.length);
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 
 	if (dwc->ep0_bounced && dep->number == 0)
 		dwc->ep0_bounced = false;
-	else if (req->request.dma)
+	else
 		usb_gadget_unmap_request(&dwc->gadget, &req->request,
 				req->direction);
 
 	dev_dbg(dwc->dev, "request %p from %s completed %d/%d ===> %d\n",
 			req, dep->name, req->request.actual,
 			req->request.length, status);
+	trace_dwc3_gadget_giveback(req);
 
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
@@ -274,6 +279,8 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 	u32		timeout = 500;
 	u32		reg;
 
+	trace_dwc3_gadget_generic_cmd(cmd, param);
+
 	dwc3_writel(dwc->regs, DWC3_DGCMDPAR, param);
 	dwc3_writel(dwc->regs, DWC3_DGCMD, cmd | DWC3_DGCMD_CMDACT);
 
@@ -299,38 +306,11 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
 {
+	struct dwc3_ep		*dep = dwc->eps[ep];
 	u32			timeout = 500;
-	u32			saved_config = 0;
 	u32			reg;
 
-	int			ret = -EINVAL;
-
-	/*
-	 * When operating in USB 2.0 speeds (HS/FS), if GUSB2PHYCFG.ENBLSLPM or
-	 * GUSB2PHYCFG.SUSPHY is set, it must be cleared before issuing an
-	 * endpoint command.
-	 *
-	 * Save and clear both GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY
-	 * settings. Restore them after the command is completed.
-	 *
-	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
-	 */
-	if (dwc->gadget.speed <= USB_SPEED_HIGH ||
-	    DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
-			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
-			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-		}
-
-		if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
-			saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
-			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
-		}
-
-		if (saved_config)
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-	}
+	trace_dwc3_gadget_ep_cmd(dep, cmd, params);
 
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
 	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(ep), params->param1);
@@ -342,8 +322,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
 			dev_vdbg(dwc->dev, "Command Complete --> %d\n",
 					DWC3_DEPCMD_STATUS(reg));
-			ret = 0;
-			break;
+			return 0;
 		}
 
 		/*
@@ -351,21 +330,11 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 		 * interrupt context.
 		 */
 		timeout--;
-		if (!timeout) {
-			ret = -ETIMEDOUT;
-			break;
-		}
+		if (!timeout)
+			return -ETIMEDOUT;
 
 		udelay(1);
 	} while (1);
-
-	if (saved_config) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		reg |= saved_config;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-	}
-
-	return ret;
 }
 
 static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
@@ -378,15 +347,17 @@ static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
 
 static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 {
+	struct dwc3		*dwc = dep->dwc;
+
 	if (dep->trb_pool)
 		return 0;
 
 	if (dep->number == 0 || dep->number == 1)
 		return 0;
 
-	dep->trb_pool = dma_alloc_coherent(sizeof(struct dwc3_trb) *
-					   DWC3_TRB_NUM,
-					   (unsigned long *)&dep->trb_pool_dma);
+	dep->trb_pool = dma_alloc_coherent(dwc->dev,
+			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
+			&dep->trb_pool_dma, GFP_KERNEL);
 	if (!dep->trb_pool) {
 		dev_err(dep->dwc->dev, "failed to allocate trb pool for %s\n",
 				dep->name);
@@ -398,7 +369,10 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 
 static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 {
-	dma_free_coherent(dep->trb_pool);
+	struct dwc3		*dwc = dep->dwc;
+
+	dma_free_coherent(dwc->dev, sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
+			dep->trb_pool, dep->trb_pool_dma);
 
 	dep->trb_pool = NULL;
 	dep->trb_pool_dma = 0;
@@ -640,6 +614,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		const struct usb_endpoint_descriptor *desc)
 {
 	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
 	unsigned long			flags;
 	int				ret;
 
@@ -654,9 +629,10 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 	}
 
 	dep = to_dwc3_ep(ep);
+	dwc = dep->dwc;
 
 	if (dep->flags & DWC3_EP_ENABLED) {
-		WARN(true, "%s is already enabled\n",
+		dev_WARN_ONCE(dwc->dev, true, "%s is already enabled\n",
 				dep->name);
 		return 0;
 	}
@@ -675,7 +651,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		strlcat(dep->name, "-int", sizeof(dep->name));
 		break;
 	default:
-		dev_err(dep->dwc->dev, "invalid endpoint transfer type\n");
+		dev_err(dwc->dev, "invalid endpoint transfer type\n");
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
@@ -688,6 +664,7 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 {
 	struct dwc3_ep			*dep;
+	struct dwc3			*dwc;
 	unsigned long			flags;
 	int				ret;
 
@@ -697,9 +674,10 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 	}
 
 	dep = to_dwc3_ep(ep);
+	dwc = dep->dwc;
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		WARN(true, "%s is already disabled\n",
+		dev_WARN_ONCE(dwc->dev, true, "%s is already disabled\n",
 				dep->name);
 		return 0;
 	}
@@ -728,6 +706,8 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	req->epnum	= dep->number;
 	req->dep	= dep;
 
+	trace_dwc3_alloc_request(req);
+
 	return &req->request;
 }
 
@@ -736,6 +716,7 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
 
+	trace_dwc3_free_request(req);
 	kfree(req);
 }
 
@@ -748,11 +729,14 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, dma_addr_t dma,
 		unsigned length, unsigned last, unsigned chain, unsigned node)
 {
+	struct dwc3		*dwc = dep->dwc;
 	struct dwc3_trb		*trb;
 
-	dev_vdbg(dep->dwc->dev, "%s: req %p dma %08llx length %d%s%s\n",
-		 dep->name, req, (unsigned long long)dma,
-		 length, last ? " last" : "", chain ? " chain" : "");
+	dev_vdbg(dwc->dev, "%s: req %p dma %08llx length %d%s%s\n",
+			dep->name, req, (unsigned long long) dma,
+			length, last ? " last" : "",
+			chain ? " chain" : "");
+
 
 	trb = &dep->trb_pool[dep->free_slot & DWC3_TRB_MASK];
 
@@ -815,8 +799,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
-	dwc3_flush_cache((uintptr_t)dma, length);
-	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
+	trace_dwc3_prepare_trb(dep, trb);
 }
 
 /*
@@ -833,6 +816,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 	struct dwc3_request	*req, *n;
 	u32			trbs_left;
 	u32			max;
+	unsigned int		last_one = 0;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
 
@@ -882,14 +866,59 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 	list_for_each_entry_safe(req, n, &dep->request_list, list) {
 		unsigned	length;
 		dma_addr_t	dma;
+		last_one = false;
 
-		dma = req->request.dma;
-		length = req->request.length;
+		if (req->request.num_mapped_sgs > 0) {
+			struct usb_request *request = &req->request;
+			struct scatterlist *sg = request->sg;
+			struct scatterlist *s;
+			int		i;
 
-		dwc3_prepare_one_trb(dep, req, dma, length,
-				     true, false, 0);
+			for_each_sg(sg, s, request->num_mapped_sgs, i) {
+				unsigned chain = true;
 
-		break;
+				length = sg_dma_len(s);
+				dma = sg_dma_address(s);
+
+				if (i == (request->num_mapped_sgs - 1) ||
+						sg_is_last(s)) {
+					if (list_is_last(&req->list,
+							&dep->request_list))
+						last_one = true;
+					chain = false;
+				}
+
+				trbs_left--;
+				if (!trbs_left)
+					last_one = true;
+
+				if (last_one)
+					chain = false;
+
+				dwc3_prepare_one_trb(dep, req, dma, length,
+						last_one, chain, i);
+
+				if (last_one)
+					break;
+			}
+		} else {
+			dma = req->request.dma;
+			length = req->request.length;
+			trbs_left--;
+
+			if (!trbs_left)
+				last_one = 1;
+
+			/* Is this the last request? */
+			if (list_is_last(&req->list, &dep->request_list))
+				last_one = 1;
+
+			dwc3_prepare_one_trb(dep, req, dma, length,
+					last_one, false, 0);
+
+			if (last_one)
+				break;
+		}
 	}
 }
 
@@ -1007,14 +1036,6 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	req->direction		= dep->direction;
 	req->epnum		= dep->number;
 
-	/*
-	 * DWC3 hangs on OUT requests smaller than maxpacket size,
-	 * so HACK the request length
-	 */
-	if (dep->direction == 0 &&
-	    req->request.length < dep->endpoint.maxpacket)
-		req->request.length = dep->endpoint.maxpacket;
-
 	/*
 	 * We only add to our list of requests now and
 	 * start consuming the list once we get XferNotReady
@@ -1094,6 +1115,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 		ret = __dwc3_gadget_kick_transfer(dep, 0, true);
 		if (ret && ret != -EBUSY) {
+			struct dwc3	*dwc = dep->dwc;
+
 			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
 					dep->name);
 		}
@@ -1107,6 +1130,7 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 {
 	struct dwc3_request		*req = to_dwc3_request(request);
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
+	struct dwc3			*dwc = dep->dwc;
 
 	unsigned long			flags;
 
@@ -1114,22 +1138,21 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (!dep->endpoint.desc) {
-		dev_dbg(dep->dwc->dev,
-			"trying to queue request %p to disabled %s\n", request,
-			ep->name);
+		dev_dbg(dwc->dev, "trying to queue request %p to disabled %s\n",
+				request, ep->name);
 		ret = -ESHUTDOWN;
 		goto out;
 	}
 
-	if (req->dep != dep) {
-		WARN(true, "request %p belongs to '%s'\n", request,
-		     req->dep->name);
+	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
+				request, req->dep->name)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	dev_vdbg(dep->dwc->dev, "queing request %p to %s length %d\n",
-		 request, ep->name, request->length);
+	dev_vdbg(dwc->dev, "queing request %p to %s length %d\n",
+			request, ep->name, request->length);
+	trace_dwc3_ep_queue(req);
 
 	ret = __dwc3_gadget_ep_queue(dep, req);
 
@@ -1151,6 +1174,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 	unsigned long			flags;
 	int				ret = 0;
 
+	trace_dwc3_ep_dequeue(req);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	list_for_each_entry(r, &dep->request_list, list) {
@@ -1229,6 +1254,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 {
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
+	struct dwc3			*dwc = dep->dwc;
 
 	unsigned long			flags;
 
@@ -1244,6 +1270,7 @@ static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 static int dwc3_gadget_ep_set_wedge(struct usb_ep *ep)
 {
 	struct dwc3_ep			*dep = to_dwc3_ep(ep);
+	struct dwc3			*dwc = dep->dwc;
 	unsigned long			flags;
 	int				ret;
 
@@ -1359,9 +1386,9 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	}
 
 	/* poll until Link State changes to ON */
-	timeout = 1000;
+	timeout = jiffies + msecs_to_jiffies(100);
 
-	while (timeout--) {
+	while (!time_after(jiffies, timeout)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
 		/* in HS, means ON */
@@ -1396,7 +1423,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
-	u32			timeout = 2000;
+	u32			timeout = 500;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
@@ -1422,10 +1449,9 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		dwc->pullups_connected = false;
 	}
 
-	dwc3_gadget_dctl_write_safe(dwc, reg);
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 	do {
-		udelay(2000);
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 		if (is_on) {
 			if (!(reg & DWC3_DSTS_DEVCTRLHLT))
@@ -1437,6 +1463,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		timeout--;
 		if (!timeout)
 			return -ETIMEDOUT;
+		udelay(1);
 	} while (1);
 
 	dev_vdbg(dwc->dev, "gadget %s data soft-%s\n",
@@ -1486,6 +1513,9 @@ static void dwc3_gadget_disable_irq(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
 }
 
+static irqreturn_t dwc3_interrupt(int irq, void *_dwc);
+static irqreturn_t dwc3_thread_interrupt(int irq, void *_dwc);
+
 static int dwc3_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
@@ -1493,14 +1523,24 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	struct dwc3_ep		*dep;
 	unsigned long		flags;
 	int			ret = 0;
+	int			irq;
 	u32			reg;
 
+	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
+	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
+			IRQF_SHARED, "dwc3", dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
+				irq, ret);
+		goto err0;
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	if (dwc->gadget_driver) {
 		dev_err(dwc->dev, "%s is already bound to %s\n",
 				dwc->gadget.name,
-				dwc->gadget_driver->function);
+				dwc->gadget_driver->driver.name);
 		ret = -EBUSY;
 		goto err1;
 	}
@@ -1584,6 +1624,9 @@ err2:
 err1:
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	free_irq(irq, dwc);
+
+err0:
 	return ret;
 }
 
@@ -1591,6 +1634,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
+	int			irq;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
@@ -1602,56 +1646,10 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	return 0;
-}
+	irq = platform_get_irq(to_platform_device(dwc->dev), 0);
+	free_irq(irq, dwc);
 
-static struct usb_ep *dwc3_find_ep(struct usb_gadget *gadget, const char *name)
-{
-	struct usb_ep *ep;
-
-	list_for_each_entry(ep, &gadget->ep_list, ep_list)
-		if (!strcmp(ep->name, name))
-			return ep;
-
-	return NULL;
-}
-
-static struct
-usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
-			     struct usb_endpoint_descriptor *desc,
-			     struct usb_ss_ep_comp_descriptor *comp_desc)
-{
-	/*
-	 * First try standard, common configuration: ep1in-bulk,
-	 * ep2out-bulk, ep3in-int to match other udc drivers to avoid
-	 * confusion in already deployed software (endpoint numbers
-	 * hardcoded in userspace software/drivers)
-	 */
-	if (usb_endpoint_is_bulk_in(desc))
-		return dwc3_find_ep(gadget, "ep1in");
-	if (usb_endpoint_is_bulk_out(desc))
-		return dwc3_find_ep(gadget, "ep2out");
-	if (usb_endpoint_is_int_in(desc)) {
-		/*
-		 * Special workaround for NXP UUU tool in SPL.
-		 *
-		 * The tool expects the interrupt-in endpoint to be ep1in,
-		 * otherwise it crashes. This is a result of the previous
-		 * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
-		 * which did special-case EP allocation for SPL builds,
-		 * and which was since converted to this callback, but
-		 * without the special-case EP allocation in SPL part.
-		 *
-		 * This reinstates the SPL part in an isolated manner,
-		 * only for NXP iMX SoCs, only for SPL builds, and only
-		 * for the ep1in interrupt-in endpoint.
-		 */
-		if (IS_ENABLED(CONFIG_MACH_IMX) && IS_ENABLED(CONFIG_XPL_BUILD))
-			return dwc3_find_ep(gadget, "ep1in");
-		return dwc3_find_ep(gadget, "ep3in");
-	}
-
-	return NULL;
+	return 0;
 }
 
 static const struct usb_gadget_ops dwc3_gadget_ops = {
@@ -1661,7 +1659,6 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
-	.match_ep		= dwc3_gadget_match_ep,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -1700,7 +1697,7 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 		} else {
 			int		ret;
 
-			usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
+			usb_ep_set_maxpacket_limit(&dep->endpoint, 1024);
 			dep->endpoint.max_streams = 15;
 			dep->endpoint.ops = &dwc3_gadget_ep_ops;
 			list_add_tail(&dep->endpoint.ep_list,
@@ -1776,6 +1773,8 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	unsigned int		s_pkt = 0;
 	unsigned int		trb_status;
 
+	trace_dwc3_complete_trb(dep, trb);
+
 	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
 		/*
 		 * We continue despite the error. There is not much we
@@ -1850,23 +1849,35 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	struct dwc3_request	*req;
 	struct dwc3_trb		*trb;
 	unsigned int		slot;
+	unsigned int		i;
+	int			ret;
 
-	req = next_request(&dep->req_queued);
-	if (!req) {
-		WARN_ON_ONCE(1);
-		return 1;
-	}
+	do {
+		req = next_request(&dep->req_queued);
+		if (!req) {
+			WARN_ON_ONCE(1);
+			return 1;
+		}
+		i = 0;
+		do {
+			slot = req->start_slot + i;
+			if ((slot == DWC3_TRB_NUM - 1) &&
+				usb_endpoint_xfer_isoc(dep->endpoint.desc))
+				slot++;
+			slot %= DWC3_TRB_NUM;
+			trb = &dep->trb_pool[slot];
+
+			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
+					event, status);
+			if (ret)
+				break;
+		}while (++i < req->request.num_mapped_sgs);
 
-	slot = req->start_slot;
-	if ((slot == DWC3_TRB_NUM - 1) &&
-	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		slot++;
-	slot %= DWC3_TRB_NUM;
-	trb = &dep->trb_pool[slot];
+		dwc3_gadget_giveback(dep, req, status);
 
-	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
-	__dwc3_cleanup_done_trbs(dwc, dep, req, trb, event, status);
-	dwc3_gadget_giveback(dep, req, status);
+		if (ret)
+			break;
+	} while (1);
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 			list_empty(&dep->req_queued)) {
@@ -2137,8 +2148,10 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_INITU1ENA;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
 	reg &= ~DWC3_DCTL_INITU2ENA;
-	dwc3_gadget_dctl_write_safe(dwc, reg);
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 	dwc3_disconnect_gadget(dwc);
 	dwc->start_config_issued = false;
@@ -2187,7 +2200,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
-	dwc3_gadget_dctl_write_safe(dwc, reg);
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	dwc->test_mode = false;
 
 	dwc3_stop_active_transfers(dwc);
@@ -2297,17 +2310,18 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		 * BESL value in the LPM token is less than or equal to LPM
 		 * NYET threshold.
 		 */
-		if (dwc->revision < DWC3_REVISION_240A	&& dwc->has_lpm_erratum)
-			WARN(true, "LPM Erratum not available on dwc3 revisisions < 2.40a\n");
+		WARN_ONCE(dwc->revision < DWC3_REVISION_240A
+				&& dwc->has_lpm_erratum,
+				"LPM Erratum not available on dwc3 revisisions < 2.40a\n");
 
 		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
 			reg |= DWC3_DCTL_LPM_ERRATA(dwc->lpm_nyet_threshold);
 
-		dwc3_gadget_dctl_write_safe(dwc, reg);
+		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	} else {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_HIRD_THRES_MASK;
-		dwc3_gadget_dctl_write_safe(dwc, reg);
+		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	}
 
 	dep = dwc->eps[0];
@@ -2415,7 +2429,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 				reg &= ~u1u2;
 
-				dwc3_gadget_dctl_write_safe(dwc, reg);
+				dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 				break;
 			default:
 				/* do nothing */
@@ -2447,7 +2461,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
 		unsigned int evtinfo)
 {
-	unsigned int is_ss = evtinfo & (1UL << 4);
+	unsigned int is_ss = evtinfo & BIT(4);
 
 	/**
 	 * WORKAROUND: DWC3 revison 2.20a with hibernation support
@@ -2485,10 +2499,10 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_wakeup_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		if (!dwc->has_hibernation) {
-			WARN(1 ,"unexpected hibernation event\n");
+		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
+					"unexpected hibernation event\n"))
 			break;
-		}
+
 		dwc3_gadget_hibernation_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
@@ -2517,6 +2531,8 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 static void dwc3_process_event_entry(struct dwc3 *dwc,
 		const union dwc3_event *event)
 {
+	trace_dwc3_event(event->raw);
+
 	/* Endpoint IRQ, handle it and return early */
 	if (event->type.is_devspec == 0) {
 		/* depevt */
@@ -2549,8 +2565,6 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
 	while (left > 0) {
 		union dwc3_event event;
 
-		dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
-
 		event.raw = *(u32 *) (evt->buf + evt->lpos);
 
 		dwc3_process_event_entry(dwc, &event);
@@ -2654,31 +2668,31 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 {
 	int					ret;
 
-	dwc->ctrl_req = dma_alloc_coherent(sizeof(*dwc->ctrl_req),
-					(unsigned long *)&dwc->ctrl_req_addr);
+	dwc->ctrl_req = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+			&dwc->ctrl_req_addr, GFP_KERNEL);
 	if (!dwc->ctrl_req) {
 		dev_err(dwc->dev, "failed to allocate ctrl request\n");
 		ret = -ENOMEM;
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(sizeof(*dwc->ep0_trb) * 2,
-					  (unsigned long *)&dwc->ep0_trb_addr);
+	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+			&dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
 		ret = -ENOMEM;
 		goto err1;
 	}
 
-	dwc->setup_buf = dma_alloc_coherent(DWC3_EP0_BOUNCE_SIZE,
-					(unsigned long *)&dwc->setup_buf_addr);
+	dwc->setup_buf = kzalloc(DWC3_EP0_BOUNCE_SIZE, GFP_KERNEL);
 	if (!dwc->setup_buf) {
 		ret = -ENOMEM;
 		goto err2;
 	}
 
-	dwc->ep0_bounce = dma_alloc_coherent(DWC3_EP0_BOUNCE_SIZE,
-					(unsigned long *)&dwc->ep0_bounce_addr);
+	dwc->ep0_bounce = dma_alloc_coherent(dwc->dev,
+			DWC3_EP0_BOUNCE_SIZE, &dwc->ep0_bounce_addr,
+			GFP_KERNEL);
 	if (!dwc->ep0_bounce) {
 		dev_err(dwc->dev, "failed to allocate ep0 bounce buffer\n");
 		ret = -ENOMEM;
@@ -2688,6 +2702,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.ops			= &dwc3_gadget_ops;
 	dwc->gadget.max_speed		= USB_SPEED_SUPER;
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
+	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
 
 	/*
@@ -2705,7 +2720,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	if (ret)
 		goto err4;
 
-	ret = usb_add_gadget_udc((struct device *)dwc->dev, &dwc->gadget);
+	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
 		goto err4;
@@ -2715,16 +2730,19 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 err4:
 	dwc3_gadget_free_endpoints(dwc);
-	dma_free_coherent(dwc->ep0_bounce);
+	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
+			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 err3:
-	dma_free_coherent(dwc->setup_buf);
+	kfree(dwc->setup_buf);
 
 err2:
-	dma_free_coherent(dwc->ep0_trb);
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 err1:
-	dma_free_coherent(dwc->ctrl_req);
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+			dwc->ctrl_req, dwc->ctrl_req_addr);
 
 err0:
 	return ret;
@@ -2738,37 +2756,69 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 	dwc3_gadget_free_endpoints(dwc);
 
-	dma_free_coherent(dwc->ep0_bounce);
+	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
+			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
-	dma_free_coherent(dwc->setup_buf);
+	kfree(dwc->setup_buf);
 
-	dma_free_coherent(dwc->ep0_trb);
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+			dwc->ep0_trb, dwc->ep0_trb_addr);
 
-	dma_free_coherent(dwc->ctrl_req);
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
+			dwc->ctrl_req, dwc->ctrl_req_addr);
 }
 
-/**
- * dwc3_gadget_uboot_handle_interrupt - handle dwc3 gadget interrupt
- * @dwc: struct dwce *
- *
- * Handles ep0 and gadget interrupt
- *
- * Should be called from dwc3 core.
- */
-void dwc3_gadget_uboot_handle_interrupt(struct dwc3 *dwc)
+int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
-	int ret = dwc3_interrupt(0, dwc);
+	if (dwc->pullups_connected) {
+		dwc3_gadget_disable_irq(dwc);
+		dwc3_gadget_run_stop(dwc, true, true);
+	}
 
-	if (ret == IRQ_WAKE_THREAD) {
-		int i;
-		struct dwc3_event_buffer *evt;
+	__dwc3_gadget_ep_disable(dwc->eps[0]);
+	__dwc3_gadget_ep_disable(dwc->eps[1]);
 
-		dwc3_thread_interrupt(0, dwc);
+	dwc->dcfg = dwc3_readl(dwc->regs, DWC3_DCFG);
 
-		/* Clean + Invalidate the buffers after touching them */
-		for (i = 0; i < dwc->num_event_buffers; i++) {
-			evt = dwc->ev_buffs[i];
-			dwc3_flush_cache((uintptr_t)evt->buf, evt->length);
-		}
+	return 0;
+}
+
+int dwc3_gadget_resume(struct dwc3 *dwc)
+{
+	struct dwc3_ep		*dep;
+	int			ret;
+
+	/* Start with SuperSpeed Default */
+	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+
+	dep = dwc->eps[0];
+	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, false,
+			false);
+	if (ret)
+		goto err0;
+
+	dep = dwc->eps[1];
+	ret = __dwc3_gadget_ep_enable(dep, &dwc3_gadget_ep0_desc, NULL, false,
+			false);
+	if (ret)
+		goto err1;
+
+	/* begin to receive SETUP packets */
+	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc3_ep0_out_start(dwc);
+
+	dwc3_writel(dwc->regs, DWC3_DCFG, dwc->dcfg);
+
+	if (dwc->pullups_connected) {
+		dwc3_gadget_enable_irq(dwc);
+		dwc3_gadget_run_stop(dwc, true, false);
 	}
+
+	return 0;
+
+err1:
+	__dwc3_gadget_ep_disable(dwc->eps[0]);
+
+err0:
+	return ret;
 }
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index e4f5a096956b..18ae3eaa8b6f 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -1,18 +1,19 @@
-/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/gadget.h) and ported
- * to uboot.
- *
- * commit 7a60855972 : usb: dwc3: gadget: fix set_halt() bug with pending
-		       transfers
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
  *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_GADGET_H
@@ -86,7 +87,6 @@ int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		gfp_t gfp_flags);
 int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
-void dwc3_gadget_uboot_handle_interrupt(struct dwc3 *dwc);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
@@ -104,18 +104,4 @@ static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3 *dwc, u8 number)
 	return DWC3_DEPCMD_GET_RSC_IDX(res_id);
 }
 
-/**
- * dwc3_gadget_dctl_write_safe - write to DCTL safe from link state change
- * @dwc: pointer to our context structure
- * @value: value to write to DCTL
- *
- * Use this function when doing read-modify-write to DCTL. It will not
- * send link state change request.
- */
-static inline void dwc3_gadget_dctl_write_safe(struct dwc3 *dwc, u32 value)
-{
-	value &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
-	dwc3_writel(dwc->regs, DWC3_DCTL, value);
-}
-
 #endif /* __DRIVERS_USB_DWC3_GADGET_H */
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index c1ab02881424..6a79c8e66bbc 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,29 +1,32 @@
-/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  *
- * Taken from Linux Kernel v3.19-rc1 (drivers/usb/dwc3/io.h) and ported
- * to uboot.
- *
- * commit 2c4cbe6e5a : usb: dwc3: add tracepoints to aid debugging
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
  *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef __DRIVERS_USB_DWC3_IO_H
 #define __DRIVERS_USB_DWC3_IO_H
 
-#include <cpu_func.h>
-#include <asm/io.h>
+#include <linux/io.h>
+#include "trace.h"
+#include "debug.h"
+#include "core.h"
 
-#define	CACHELINE_SIZE		CONFIG_SYS_CACHELINE_SIZE
 static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 {
-	unsigned long offs = offset - DWC3_GLOBALS_REGS_START;
+	u32 offs = offset - DWC3_GLOBALS_REGS_START;
 	u32 value;
 
 	/*
@@ -33,12 +36,20 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 */
 	value = readl(base + offs);
 
+	/*
+	 * When tracing we want to make it easy to find the correct address on
+	 * documentation, so we revert it back to the proper addresses, the
+	 * same way they are described on SNPS documentation
+	 */
+	dwc3_trace(trace_dwc3_readl, "addr %p value %08x",
+			base - DWC3_GLOBALS_REGS_START + offset, value);
+
 	return value;
 }
 
 static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 {
-	unsigned long offs = offset - DWC3_GLOBALS_REGS_START;
+	u32 offs = offset - DWC3_GLOBALS_REGS_START;
 
 	/*
 	 * We requested the mem region starting from the Globals address
@@ -46,21 +57,14 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 	 * However, the offsets are given starting from xHCI address space.
 	 */
 	writel(value, base + offs);
-}
-
-static inline void dwc3_flush_cache(uintptr_t addr, int length)
-{
-	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
-	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
 
-	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
+	/*
+	 * When tracing we want to make it easy to find the correct address on
+	 * documentation, so we revert it back to the proper addresses, the
+	 * same way they are described on SNPS documentation
+	 */
+	dwc3_trace(trace_dwc3_writel, "addr %p value %08x",
+			base - DWC3_GLOBALS_REGS_START + offset, value);
 }
 
-static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
-{
-	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
-	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
-
-	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
-}
 #endif /* __DRIVERS_USB_DWC3_IO_H */
diff --git a/drivers/usb/dwc3/linux-compat.h b/drivers/usb/dwc3/linux-compat.h
deleted file mode 100644
index 563f8727cdde..000000000000
--- a/drivers/usb/dwc3/linux-compat.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/**
- * linux-compat.h - DesignWare USB3 Linux Compatibiltiy Adapter  Header
- *
- * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
- *
- * Authors: Kishon Vijay Abraham I <kishon@ti.com>
- *
- */
-
-#ifndef __DWC3_LINUX_COMPAT__
-#define __DWC3_LINUX_COMPAT__
-
-#define dev_WARN(dev, format, arg...)	debug(format, ##arg)
-
-#endif
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
new file mode 100644
index 000000000000..a3a3b6d5668c
--- /dev/null
+++ b/drivers/usb/dwc3/platform_data.h
@@ -0,0 +1,47 @@
+/**
+ * platform_data.h - USB DWC3 Platform Data Support
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * Author: Felipe Balbi <balbi@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/usb/ch9.h>
+#include <linux/usb/otg.h>
+
+struct dwc3_platform_data {
+	enum usb_device_speed maximum_speed;
+	enum usb_dr_mode dr_mode;
+	bool tx_fifo_resize;
+
+	unsigned is_utmi_l1_suspend:1;
+	u8 hird_threshold;
+
+	u8 lpm_nyet_threshold;
+
+	unsigned disable_scramble_quirk:1;
+	unsigned has_lpm_erratum:1;
+	unsigned u2exit_lfps_quirk:1;
+	unsigned u2ss_inp3_quirk:1;
+	unsigned req_p1p2p3_quirk:1;
+	unsigned del_p1p2p3_quirk:1;
+	unsigned del_phy_power_chg_quirk:1;
+	unsigned lfps_filter_quirk:1;
+	unsigned rx_detect_poll_quirk:1;
+	unsigned dis_u3_susphy_quirk:1;
+	unsigned dis_u2_susphy_quirk:1;
+
+	unsigned tx_de_emphasis_quirk:1;
+	unsigned tx_de_emphasis:2;
+};
-- 
2.53.0

