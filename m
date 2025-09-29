Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CEFCAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 19:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F2483448;
	Mon, 29 Sep 2025 21:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="oy4/GxRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A830E82A9E; Mon, 29 Sep 2025 21:53:00 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1240832DA
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 21:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: ecd63055-9d6d-11f0-ad1a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id ecd63055-9d6d-11f0-ad1a-005056999439;
 Mon, 29 Sep 2025 21:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=Jl8HifOhTkMYNCCYHvz3vpuXQe0pz4ZYNLbtPLHef6Y=;
 b=oy4/GxRzOl4txtJV5nsh3cXVcfqd5B27ehNaxyKVog5gHo2u8uV0a1fGx9lcG2lhYl+6gM2jvfhzp
 q+6ehsOxZX2aY/6uzfWv86XRneir9NmOp4joJBixlIW9vLHwrMWMZ7hwQ+F1J7wJ0oGxMPLroFZZwQ
 BYoNwQsg9UOdaGAk=
X-KPN-MID: 33|zRzkQP8pvKZ7zy/OnX2eqtjstbupsuSXXlNyzHAinVOlIlpRU1uHYqMCSCUvfOx
 UG62q2r8Y6zM/3s5Zh64BQhWnDrLuCn7saPbnVLJISio=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|ZPOx/+8l1b6W7sguZxzcdVrr6yQeoaeVyWo/zJ+nMjIvTlrWMllWDBLgJQcRtYc
 L3z3torK4OfaZSCqQTD3ZiQ==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e6132b0d-9d6d-11f0-8d3e-00505699b758;
 Mon, 29 Sep 2025 21:52:58 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	trini@konsulko.com,
	Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2 2/3] iopoll: Add readb_poll_sleep_timeout
Date: Mon, 29 Sep 2025 21:52:40 +0200
Message-ID: <20250929195241.70351-3-kettenis@openbsd.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929195241.70351-1-kettenis@openbsd.org>
References: <20250929195241.70351-1-kettenis@openbsd.org>
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

Add a variant of readl_poll_sleep_timeout that reads a single
byte to match the readb_poll_timeout API that Linux has.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 include/linux/iopoll.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 0ee2bddaa83..955ab881006 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -46,6 +46,9 @@
 #define readx_poll_sleep_timeout(op, addr, val, cond, sleep_us, timeout_us) \
 	read_poll_timeout(op, val, cond, sleep_us, timeout_us, addr)
 
+#define readb_poll_sleep_timeout(addr, val, cond, sleep_us, timeout_us) \
+	readx_poll_sleep_timeout(readb, addr, val, cond, sleep_us, timeout_us)
+
 #define readl_poll_sleep_timeout(addr, val, cond, sleep_us, timeout_us) \
 	readx_poll_sleep_timeout(readl, addr, val, cond, sleep_us, timeout_us)
 
-- 
2.50.1

