Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DD8C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 14:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63999811B3;
	Sun,  2 Mar 2025 15:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="McQJtUTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 616A6811C1; Sun,  2 Mar 2025 15:21:58 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4358F811B2
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 15:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 53C7242826; 
 Sun,  2 Mar 2025 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740925300;
 bh=sDpG3jVD3JPwxRWtFCZMDPGs63cEHdAyc3urBcgsEso=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=McQJtUTY46K4QbvUnboBa2kifi+bfh7CiK3A5anBZNH3M8atUY02/+Uv02cS88lfL
 BAhZuR8xxLp0sVAHaJ2kHS3oZJTdvlqWV55Qd50FtYacA8z1s7WCUa+av0U1Nrm6Cq
 CDxRLV5KK4fTqP+uGv0rkJaUjgTB6pM9DTh+z/P2msXznw6t0DV+A4gMMNZ/aUt5jk
 VeClLmI0CFAa1YTZzIfwo/E4HY/cpdpWLm3OVV7U0BWk7z1jUaQ2x+wnUXCc8lWRSY
 4OwFPGa26XBfJqLiFuBS6O7WkHLaCWwZWlN9M9Nw4pIUka24cV9Iau77Hcu14ir2GC
 YRDNl6bamcjyg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Janne Grunau <j@jannau.net>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/5] arm: include asm-generic/int-ll64.h in setjmp.h
Date: Sun,  2 Mar 2025 15:21:18 +0100
Message-ID: <20250302142121.150480-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
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

Don't assume that u32 and u64 are already defined.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/include/asm/setjmp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
index 662bec86321..9a7f5af9f8f 100644
--- a/arch/arm/include/asm/setjmp.h
+++ b/arch/arm/include/asm/setjmp.h
@@ -7,6 +7,8 @@
 #ifndef _SETJMP_H_
 #define _SETJMP_H_	1
 
+#include <asm-generic/int-ll64.h>
+
 /*
  * This really should be opaque, but the EFI implementation wrongly
  * assumes that a 'struct jmp_buf_data' is defined.
-- 
2.48.1

