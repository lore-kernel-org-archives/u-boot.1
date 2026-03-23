Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADCDF483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746368419C;
	Mon, 23 Mar 2026 20:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UEjNc3H6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE3E8419C; Mon, 23 Mar 2026 20:52:53 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF7C8415D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-467161c4a1cso1454250b6e.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295569; x=1774900369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ldmQsjh+CSYRcJi6d6QGoDGcQUySJe4MBrml4Lm3VhQ=;
 b=UEjNc3H6OVXDIHoCt1onYRUesI5eOmndg+NGXOsCCrtYTg3oZj2ThQ7NRKhG+4cxyZ
 +fxI5OX48dPl4fWFQnhJHQRZkd896uqMZANIFC9WlI5Xqvcp2WRDbNu1LDeyAuAnAJBg
 07l9Sf4E0AN+I0vyGd8PvA/0rn7UyciY2c33w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295569; x=1774900369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ldmQsjh+CSYRcJi6d6QGoDGcQUySJe4MBrml4Lm3VhQ=;
 b=c5cylAv6HX4VTrSYPwNexNjXKnh6rq2AwJv7v8h5ApIrvpbGgSjQj4/8WwmVcavcEV
 waVlyMPW/ULe58csI4Hr8Y/N5GBhNuiTAK76ZBBVU2NRh5tfFu9t6GACbSjC2ChCsCVN
 9G3DyoTQ7+JZ9lZpw8E//Uhz8LnNgzLHGsHilfDeHLjp7mXGqRF+kpp2WRocdbr2ayKq
 WLc4xqnYEHk8J1klyHWNObmqQfXxwx4hGNlkUoclgrKZGjuzDyBNcqLxSZXI3FFrSXr4
 9Pi8NLhZJoo1X83s2uYQ6PlhquY0yVmR32mcKTdXRYcSRFMBg326uFL3H4SU9udL6VLB
 rHYQ==
X-Gm-Message-State: AOJu0YzXLb6I8qg7xpcr6tkSgyx1d4u6zKeDDKSzG2BJXOl4KoBE8MSZ
 akza7r6enjSFhLRJ0kOUJbhcdVqFnDiUGElX1qIjwYQUUsFqQequ6jLg6gNiPWSM+LRY75WnhXQ
 FpzVWFaU=
X-Gm-Gg: ATEYQzyQ777fxfzmcTiDBOCRwNeIq0xPDNmf1KHl6UZkYRwM5SW4v59q4kNpo32DB2S
 c08uawDx0q5LGqBX7nVbIEY2cCTXpKvDGu9ojv33gFPce90+Vb8ZoI79yn7l8V9rIqWgf1aizWl
 d1Kqy+KIzfDQOZgteFDp3tuF8XVZ+3Okuox7VrM4mAxKFESr3oEST5ZpSGT0KrQH9RRAdUZ++ry
 X/oh55qSeF6ONCNCa44WJ6gyw9abIVc+NwTvPxIAxzXzc3YSohJAH/QTl33rLjlPagn91n4KTD0
 UnuIcoqBfIu9mz5//McoWZVJnSwW9ND60B4jfzjetcNZLdnwoTA8TUf6UP3qmIG1y+AtR2u8fQ1
 CpvCgxEehymIHHGu2nLfNxOv4BCbNjtqI4S/uXNdbPvzfWUdzbJ+NRDKx/0ygkyS+FQ5pR5rCL4
 D8k3m2UyuJ7NY5hOwhswi2hUIatXcq82Bk/pDKcsLUDdsbJXHdrjPaeI3TN0HODiv9GIVyTZEUq
 3f8LhiaAaHaLOv8cfVDcEMuRSN/W21cxELuvpwlFJBDLxQR00o=
X-Received: by 2002:a05:6808:4a87:b0:467:1c6b:ee14 with SMTP id
 5614622812f47-467e5f05ea0mr6233379b6e.33.1774295569219; 
 Mon, 23 Mar 2026 12:52:49 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7d19ef9sm7381278b6e.4.2026.03.23.12.52.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:52:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] lmb: boot: Update dependencies within BOOT_DEFAULTS_CMDS
Date: Mon, 23 Mar 2026 13:52:47 -0600
Message-ID: <20260323195247.2363434-1-trini@konsulko.com>
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

The CMD_BOOT[IZ] symbols have a dependency on LMB, correctly,
currently. Make sure that in BOOT_DEFAULTS_CMDS we only select these
commands if LMB is enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f37e7a0c380b..75fd64f02054 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -434,8 +434,8 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_DHCP if CMD_NET && !NO_NET
 	select CMD_PING if CMD_NET && !NO_NET
 	select CMD_PXE if CMD_NET && !NO_NET
-	select CMD_BOOTI if ARM64
-	select CMD_BOOTZ if ARM && !ARM64
+	select CMD_BOOTI if ARM64 && LMB
+	select CMD_BOOTZ if ARM && !ARM64 && LMB
 	imply CMD_MII if CMD_NET && !NO_NET
 
 config BOOT_DEFAULTS
-- 
2.43.0

