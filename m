Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5269AC4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 11:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3165B87EAD;
	Sat, 10 Feb 2024 12:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZMWkKKrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D30B87EAE; Sat, 10 Feb 2024 12:07:01 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F188B87EAC
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 12:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 94EA640A27
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707563214;
 bh=ocz6KRE5Igk4aiYi+KY4YUC9QFUBZqdpmf4Lu3/DvtU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZMWkKKrTl1S1lOHOYlfsYtBH1zqBB16Fe7A9KyYDJuMJnuMyliXz2sql9uwFNwf3T
 C09PAUyhDuB1UnQMLPSyDHYkAWJ3k9Wp44w+p8zZtkHHGHqNMKCUGTlpGA6iJnhNH6
 plDxxs40Sj3tj0IOBlQiOArBRwc+9qTaLzcZ0n328rxcZRS9T6M+HCjE8f/f4RzbYl
 A1ch7DgMhR32VxorOIG0sqNedwwtXrHlDPwUtgyJC/n5h+g9slLAjvSqgQXU6oIWcR
 TkrJkJBH1xK8YeezVPuYAkMkboZ4zz6qph1NUMg4g0Yg470DNMDHk0qogUZMcHiHqe
 /Kn7aA9qlvVkw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40fb74433ebso10895295e9.3
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 03:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707563214; x=1708168014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ocz6KRE5Igk4aiYi+KY4YUC9QFUBZqdpmf4Lu3/DvtU=;
 b=LELjI8xF9ucRrELyBEzPO0W0KJ5/7LvHgbGl5iuQzYmsTYTKvgbZiiUEeZV/zoO7Gy
 IWqk9yF0Qcj+oXzcDrWujvAgJUSPkFzHStTEm2kbhZShvR30VMDeFoTz6GW/pXLOc8HI
 eeizk4TzYU/fhSw6AVlOn/gC78yL+OIhq5qvkVIvYNInuxMORjYas+QuB/QJixhbA4ik
 YPcMHIx8TBchffboDh77DWcpif/y6/YxBXAb6cfRpSiLlqmeUKYpVSEdgiwCxh7vXmHK
 dNoCRdd+9XNi/ooV3QtMqumPu2UnhfO+BGXOKuTWflvCtq4cpOzLcXVK+H72SKHpgM07
 xxXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXslYb6zV3H8bHZmx88xPWjkLQmP8v1F8b5hArlGIeSOaJfSoROUGwjNiLPG+YXpB/zmfPMhn4KLPpUUkyPzDuPTfhDhw==
X-Gm-Message-State: AOJu0YzlgCOP4weLJv4MbhyF6lZ6IQ0lmafJgAiYReFC0GkN80jJRicL
 nNPtKsmOWy2OOUJ+Qed1XbEi84WnxjsHL+aLOtGo+VwZcoEHL7qOCDtr+G2u6zselsqnlSF2crJ
 EqES/D+FpxzFga8jO5uQJcYeNgstnLOZdDckQCby73YavriGw2+pDK+SG8DOHgWI2d5o=
X-Received: by 2002:a05:600c:46d1:b0:410:ae8:4c2d with SMTP id
 q17-20020a05600c46d100b004100ae84c2dmr1472743wmo.3.1707563213848; 
 Sat, 10 Feb 2024 03:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGla70pEerGX499Nwkyv/yPOqBPlQNMWEoLXXhlLKmXjeu9GluKqyA2JcBZtBQyblEEQXJK1A==
X-Received: by 2002:a05:600c:46d1:b0:410:ae8:4c2d with SMTP id
 q17-20020a05600c46d100b004100ae84c2dmr1472728wmo.3.1707563213537; 
 Sat, 10 Feb 2024 03:06:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUmAmjbeqg1Nyw7QUzbM6geLW9yUBv1QbxO9Nq/bYoLCfEour75Rc2sCn9cKEZqpAS7mQ3WmbidA5KdpPHWpFnmYVtencba3QhDaKZlsXOQHK3ZVNE3M7daEp74HIqHfEy3WKTtVzRn07HbtyQRt9Rr4Cx2NcoSIwPj
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b0040ef95e1c78sm3069231wmd.3.2024.02.10.03.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Feb 2024 03:06:53 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/2] smbios: fill wake-up type
Date: Sat, 10 Feb 2024 12:06:48 +0100
Message-ID: <20240210110648.21977-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210110648.21977-1-heinrich.schuchardt@canonical.com>
References: <20240210110648.21977-1-heinrich.schuchardt@canonical.com>
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

We should not use the reserved value 0x00 for the wake up type but
use 0x02 (Unknown).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	use an enum for the constants
v2:
	use wake-up type 'Unknown' as our default
	add more SMBIOS wake-up type constants
---
 include/smbios.h | 27 +++++++++++++++++++++++++++
 lib/smbios.c     |  1 +
 2 files changed, 28 insertions(+)

diff --git a/include/smbios.h b/include/smbios.h
index 3df8827b60..a4fda9df7b 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -108,6 +108,33 @@ struct __packed smbios_type0 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+/**
+ * enum smbios_wakeup_type - wake-up type
+ *
+ * These constants are used for the Wake-Up Type field in the SMBIOS
+ * System Information (Type 1) structure.
+ */
+enum smbios_wakeup_type {
+	/** @SMBIOS_WAKEUP_TYPE_RESERVED: Reserved */
+	SMBIOS_WAKEUP_TYPE_RESERVED,
+	/** @SMBIOS_WAKEUP_TYPE_OTHER: Other */
+	SMBIOS_WAKEUP_TYPE_OTHER,
+	/** @SMBIOS_WAKEUP_TYPE_UNKNOWN: Unknown */
+	SMBIOS_WAKEUP_TYPE_UNKNOWN,
+	/** @SMBIOS_WAKEUP_TYPE_APM_TIMER: APM Timer */
+	SMBIOS_WAKEUP_TYPE_APM_TIMER,
+	/** @SMBIOS_WAKEUP_TYPE_MODEM_RING: Modem Ring */
+	SMBIOS_WAKEUP_TYPE_MODEM_RING,
+	/** @SMBIOS_WAKEUP_TYPE_LAN_REMOTE: LAN Remote */
+	SMBIOS_WAKEUP_TYPE_LAN_REMOTE,
+	/** @SMBIOS_WAKEUP_TYPE_POWER_SWITCH: Power Switch */
+	SMBIOS_WAKEUP_TYPE_POWER_SWITCH,
+	/** @SMBIOS_WAKEUP_TYPE_PCI_PME: PCI PME# */
+	SMBIOS_WAKEUP_TYPE_PCI_PME,
+	/** @SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED: AC Power Restored */
+	SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED,
+};
+
 struct __packed smbios_type1 {
 	u8 type;
 	u8 length;
diff --git a/lib/smbios.c b/lib/smbios.c
index c83af730a9..b190b010f3 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -394,6 +394,7 @@ static int smbios_write_type1(ulong *current, int handle,
 	} else {
 		t->serial_number = smbios_add_prop(ctx, "serial", NULL);
 	}
+	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
 	t->sku_number = smbios_add_prop(ctx, "sku", NULL);
 	t->family = smbios_add_prop(ctx, "family", NULL);
 
-- 
2.43.0

