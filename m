Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8D6F36C5C
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF260842A4;
	Mon, 20 Apr 2026 18:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="McM4g9jX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF71842E1; Mon, 20 Apr 2026 18:47:34 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92ABB84258
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3079E3F617
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776703652;
 bh=BxUjOYscHpwTA5f0txuEEqhlLOW8gCE0axz+dJyAeME=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=McM4g9jXFrGFgxDYlgIqOWgyxMeEndstJjORv5zAUMB2EGtXu/fHgHZjEsDsMqwgE
 j5tyQZ2i8gvFHBPaxLpCBfqWh3FvtX7irFIgmmL13/ZhQz8nRS1H4bU2YoY+CmKJBT
 YfaT3b6Gjfk4mAPusEZ9RH3kf5EzrLYPtGB7i716HgwdohdEWPIaEd4v8oa6+mWAwG
 QQBPwQWKTxcmCP3LIwJUDfbXtrOudIV/UxFcntqyJ8k72+kHAPf6Sjp5VyQGz+6aVE
 jUY2TQBIdVJinlghlOHuzJpSUYFNOZ4HRgLWkgN1yB68yAGp6V2LR2JB/5tyyRsho9
 5wxvyIn6LV9XxAzTKf4H4tSMlEdiLxXL/Tg8l+sif0Qx0SqJ3ErhM4q81M6DBPmqKd
 M2EqDqWhNSNuNAffEGlpBMn6E/YwFS2N77Ry7q2DwlZlBdPZYZ3atzY4fIsM/I4uSM
 WZmQVSMqXjq4BKkNNgD2fF8M49Mzo7CME7G3mzT69u9+TqAhkyRtCA1O4dvvY17SQc
 OL8frcPkX+MQ9ZFwiPum5+/TEhXzy7iHKlW5g+7pSh3ASdAz1JwxyoBdC8bL8nwuuH
 mxeBP++3D4kdrMVoMcjU7M6OcH/qVbdumQEJ2nBD6oTpJj3z0SV2dcMdIGPD4iNJzd
 QP3VOEAHgYhVeH7EcGBn/b64=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488d9e1e61aso27885125e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776703651; x=1777308451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxUjOYscHpwTA5f0txuEEqhlLOW8gCE0axz+dJyAeME=;
 b=ih9cYA717CeRckjTSSv2cFnnx53bb+EjZBOOImFEOmhLQgAUQo3p6peOfA+u8+GFsr
 HciDDzQSZdM0dGp/KUVK+KBGr0cwrlWa6+IFJbuwlgYxxgus0UPzo53xmWupI8OBwrGu
 J2tQ9alDcaKWaqwPKiWzEL3yGUvBufz5l8XbNAyeguazKKLr7Q5wMhHpHG/AfGGM4c2C
 oEbnnFIICABrOZByRL8Rliw2ej1PK/XVpW4kHLOeAWP7e0IN5X1CVkF5RPkhw16fzohX
 PYs+bcoQ1neTpkQKoLO1fueSdJf99pYMD9upIdV0swV/vZx4CIJt5KUlJSFv3p8TN4Ev
 nZUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pwmJHr+l1dzWfzZF+v6OsrkUYZbPf10Wvx6zabkac5K8kyLj3mY+mEGe2XsMgTyfd1rHDQ1U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8CLzADkaq/OROFyHcy5dQy5iCAMnseHrUTw2d95v/pJjLEUhn
 +zc9jcwlh+3zyDALr4400xuGoxl+sOcHUnimPclrgaeBJFbLmUQ9TQxlxvRphAWHMPAa5NUbfrC
 HhOomDaqPNs4B/JrX+IMIg07Jdr9zxj842F/tX/cW2wo8hx1MhkXrb+uW4qYloupAf5q83LQ=
X-Gm-Gg: AeBDieuV1GcwJyBftI3VniU+t1VvJoc8Fhrvxj22pLOET9TaBtjelXuhJmODCVpnpLq
 paIsz44I9/ZuWxs2eg9ayDb5WurqFkUcd6MAHP8AwoiEw2k1bKhGuft11OfKbhZQibML1KYN1/6
 koMnOTI+ao51ZTM1q5hRRQDGkhy7N2bSLcXPhlTZNC1RmyyLW+BTXCkPGXWurmGwwTSit0eZ8n4
 Iyx721dpqsDAVxMChkAoZKfTWYQckJkQY2IrSER+IV0XRdiEiw9A/RaLzb7oO99WBYRiKCh82iN
 DlteRCkyeVl4yUW/VoB0YCeW/AaZXcDuSz/rAzVKVGp7Y2x6mgw+0+e/Oc/y9SXLaj/MrTGcK4P
 +v5nB5VbC7nd/dXLqHDc09urV0VSxUFZ7n4kbseyI7GVB6mTEaJp9xVbqVXc4pn3oxMBN0YTkqv
 +nlr7M5aWD6lSZ+NM+gskX2QVbJwlK5lOhZXH0iRyDImiVofz4xt6ZgwcSEEkiKn18wJ8BCWsc+
 g==
X-Received: by 2002:a05:600c:a416:b0:488:af48:af11 with SMTP id
 5b1f17b1804b1-488fb73a9b8mr166422705e9.1.1776703651206; 
 Mon, 20 Apr 2026 09:47:31 -0700 (PDT)
X-Received: by 2002:a05:600c:a416:b0:488:af48:af11 with SMTP id
 5b1f17b1804b1-488fb73a9b8mr166422375e9.1.1776703650775; 
 Mon, 20 Apr 2026 09:47:30 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm368177525e9.4.2026.04.20.09.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:47:30 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Roese <sr@denx.de>, Saket Sinha <saket.sinha89@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: fix initial RSDT and XSDT size
Date: Mon, 20 Apr 2026 18:47:25 +0200
Message-ID: <20260420164725.359539-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

When creating the RSDT and the XSDT table they contain no entries.
The table size therefore must equal the header size.

Without this change a NULL deference has been observed in
acpi_find_table() when running `ut dm` on sandbox64_defconfig
executed via `sudo ./u-boot -D`.

Fixes: 94ba15a3f13f ("x86: Move base tables to a writer function")
Fixes: 7e586f69070d ("acpi: Put table-setup code in its own function")
Fixes: ab5efd576c4e ("x86: acpi: Adjust order in acpi_table.c")
Fixes: 867bcb63e79f ("x86: Generate a valid ACPI table")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/acpi/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/acpi/base.c b/lib/acpi/base.c
index 5c755b14c16..01ebad8994a 100644
--- a/lib/acpi/base.c
+++ b/lib/acpi/base.c
@@ -44,7 +44,7 @@ static void acpi_write_rsdt(struct acpi_rsdt *rsdt)
 
 	/* Fill out header fields */
 	acpi_fill_header(header, "RSDT");
-	header->length = sizeof(struct acpi_rsdt);
+	header->length = sizeof(struct acpi_table_header);
 	header->revision = 1;
 
 	/* Entries are filled in later, we come with an empty set */
@@ -59,7 +59,7 @@ static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
 
 	/* Fill out header fields */
 	acpi_fill_header(header, "XSDT");
-	header->length = sizeof(struct acpi_xsdt);
+	header->length = sizeof(struct acpi_table_header);
 	header->revision = 1;
 
 	/* Entries are filled in later, we come with an empty set */
-- 
2.53.0

