Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFD6C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C8683B21;
	Thu,  7 Aug 2025 00:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eyuY/40J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7BB83AEA; Thu,  7 Aug 2025 00:27:31 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE7883457
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-741b8c26fc3so324738a34.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519233; x=1755124033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEQBl7lzEjLrwB86nYWA/KAA0DTeOE1P9Fl1knBIQZ0=;
 b=eyuY/40JpIB86DX6H97Q01WXPhaKPvoi5cNgxwUX1nKLVNTJj5O2DDdzCoWNSPqCog
 OXD3Sr2aQu8txcYBP/Yx/KEMqE4mrK3T8Wji1KAHvJhWMEJiZ0aJPTvBbeCoaru0PYqd
 mW9/ag5In3/6aPZmI5Ep40XYL4heWGb85rQ/ZVzcUVoXU5UaeXv3cQqIvwmoQzYtqFLo
 ZEP9pEWrSSOKj1HFHSsmc7Ordexzl1a8vm6SKWykUEQ9ZIaYCJkRNQA6xk1PodeHiIId
 b+Yr5emQ0mMAToDKaccaRPatyFfhyUfhhld30T/kOM2+9M+fQFEcBInxKdtutkb9iS2v
 lHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519233; x=1755124033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEQBl7lzEjLrwB86nYWA/KAA0DTeOE1P9Fl1knBIQZ0=;
 b=hVHdRpgn4u+0guBBVKEBWrp4foh4ZSsteZF8DVbOV8rxgho/6wq9cbzneNeXx6SYTj
 tTtlSvWWu9cVtpgXSI2fOQLXiOtdOckyuABH/WvSTLHuiZZcydp7qtJ6QT4WC8JScqjG
 738Y6XbU6U7h7PR7zfvzvNuEFKwwlDKGn8R0by8eYwut0imOUBJkhCqDFZOG7+0v8ICS
 qLsJ764KiecAniAkQukJOePK1zKXrO/WJrMzJQ98+DtQzdkMU57nNUvuz85Deo9Eh2hw
 l1XF1g1fCilzSGqr32HdaWz0SrTMEmv3abdMXRj8A8yML6/IvVpL/QAsH/Dr6gRx2Ml6
 4lyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA2y9iVsZxqn+/nsrk6bIZuabd12Apu0UT1Ghq9/ReqUgKHMf6pnXrm2le49d5+QNKldrCz8g=@lists.denx.de
X-Gm-Message-State: AOJu0YybYnaR0wXMjamESgqfNcFjXy5PcRKnHc1x3gC69HZOIxIp5EYi
 xE15vfa8F+T38LdfVCSIALyexyJ3fQ0WcnKcG1ehyyqYtXl0j70Dsi9HsOkp4oDeP/Q=
X-Gm-Gg: ASbGnctOUxX79KWsILtrsLDFMsHHQU+PlZO4WLzOihyki6uVY1u0qCOqCH4n26wZl+o
 CpE03zeZpY9HYsSjPycSyHg6Tbn5+YjkBZdNedie2ctEbojoDHImOmiIN5zIKio3pf+tAUdbBW6
 mjxlGu1pNV01zpUfLHwlRxVuMoQIUeOTDplCgJIO7HgVDCyNK7wnbYzQQ2WruI6ACcNWtxMsNOb
 /LyGPtfi1FAlcQY0SmS+2x7nQKl5xlvF9reQPUroo3x70UaS0sDg933GxWDJacEuL5JbsX4f3wE
 PDLAXvn6RWhx5jqeYy6liETyNKb9wAuIrwlt2wSx2v/Xani6GIHSkJPIXz4OM2onwsibzYCV2nL
 IjocyepwkNVLqgXew7y4qQ2cljQ==
X-Google-Smtp-Source: AGHT+IFxRGGkz9ocs0++YcvmCRs7yzqHZ0tHF93Y8JozjArBIC2siOYzlNGGY3wPHI19HBtkR4qsww==
X-Received: by 2002:a05:6808:81d6:10b0:435:80b6:d27e with SMTP id
 5614622812f47-43580b6e8d6mr1820807b6e.10.1754519233384; 
 Wed, 06 Aug 2025 15:27:13 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4356f21ff44sm971652b6e.12.2025.08.06.15.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:13 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 02/10] board: samsung: e850-96: Set ethaddr
Date: Wed,  6 Aug 2025 17:27:02 -0500
Message-Id: <20250806222710.23773-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
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

Set the environment variable for Ethernet MAC address (ethaddr). Use the
SoC ID to make sure it's unique. It'll be formatted in a way that
follows the consecutive style of the serial number ("serial#" variable),
i.e.:

    OTP_CHIPID0   = 0xf51c8113
    OTP_CHIPID1   = 0x236
    get_chip_id() = 0x236f51c8113
    serial#       = 00000236f51c8113
    ethaddr       = 02:36:f5:1c:81:13

where corresponding bytes of the MAC address are:

    mac_addr[0]   = 0x02   // OTP_CHIPID1[15:8]
    mac_addr[1]   = 0x36   // OTP_CHIPID1[7:0]
    mac_addr[2]   = 0xf5   // OTP_CHIPID0[31:24]
    mac_addr[3]   = 0x1c   // OTP_CHIPID0[23:16]
    mac_addr[4]   = 0x81   // OTP_CHIPID0[15:8]
    mac_addr[5]   = 0x13   // OTP_CHIPID0[7:0]

because OTP_CHIPID1 has only 16 significant bits (with actual ID
values), and all 32 bits of OTP_CHIPID0 are significant.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index a6c264d12481..d489716bfdf2 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <init.h>
 #include <mapmem.h>
+#include <net.h>
 #include <asm/io.h>
 #include "fw.h"
 
@@ -92,11 +93,35 @@ static void setup_serial(void)
 	env_set("serial#", serial_str);
 }
 
+static void setup_ethaddr(void)
+{
+	u64 serial_num;
+	u32 mac_hi, mac_lo;
+	u8 mac_addr[6];
+
+	if (env_get("ethaddr"))
+		return;
+
+	serial_num = get_chip_id();
+	mac_lo = (u32)serial_num;		/* OTP_CHIPID0 */
+	mac_hi = (u32)(serial_num >> 32UL);	/* OTP_CHIPID1 */
+	mac_addr[0] = (mac_hi >> 8) & 0xff;
+	mac_addr[1] = mac_hi & 0xff;
+	mac_addr[2] = (mac_lo >> 24) & 0xff;
+	mac_addr[3] = (mac_lo >> 16) & 0xff;
+	mac_addr[4] = (mac_lo >> 8) & 0xff;
+	mac_addr[5] = mac_lo & 0xff;
+	mac_addr[0] &= ~0x1; /* make sure it's not a multicast address */
+	if (is_valid_ethaddr(mac_addr))
+		eth_env_set_enetaddr("ethaddr", mac_addr);
+}
+
 int board_late_init(void)
 {
 	int err;
 
 	setup_serial();
+	setup_ethaddr();
 
 	/*
 	 * Do this in board_late_init() to make sure MMC is not probed before
-- 
2.39.5

