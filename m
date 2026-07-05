Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E050C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 04:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA9984874;
	Sun,  5 Jul 2026 06:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gXYXjWID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5D5801A9; Sun,  5 Jul 2026 05:44:44 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4049C84659
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 05:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E81CC3F169
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 03:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783223081;
 bh=jUNZVq/935GLcMXYoA0SO+I8+d+2pSvmdJVopw5CYOU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gXYXjWIDIDQnG9VjJqUT9ydw+AOg4XyFDp462A9m27vMUhE42gjmil4mkwhrojhme
 zOnmnLykkV8leTuQSvkd0TS/RB/mwaG+nOlebLztdL8doaffaOQD5jDC0+x2pdOl1u
 CvC5jSvuZxd5a91EWO3OZESyYWXersWG57NVfp/E82c1WVytsTomHWpfALmyj0q8dW
 UNunBCotdkg47LmZfRNFcJZIoFLAHycUhQjJmTeuqS6wVXp4aqe+ZpPT/51qKNTB8X
 Vpxol70FWs+Py9KHim+6f9XWD7qtI4Ikzi5KCgi2xKvcIAiQcHOG+EDjw3Z4YTYUkB
 rM6eE6eqAGuGFRitkPnDQaBTKm5eVYGXweEekmlIbOZRr14kBUSg5n6u0n4f7cIggg
 wuTmSm+MmHKNGGwpPevNlIXjfFUDzU/IURB+Enx0qzaCVN4e6I5+PjCFYGuYOUHPa2
 YEPO4IVfLsDWKQLLGrl5+N2Yku0YR0nGOEuCvFIT/3MVzQ7fmZj5sCIx35vcwsxGWF
 ZhYtfsv0A37hDl/fFy5/j5CpE5fes8BXFOSbcd5j0S56+b8JJ4Lru6oPvftutBtwSr
 1cJ37w/ln6pyOWpFsUjI1qki4pdiONTjx7fzoDxxEJKfypjW6wwLPQrQC9AC3Lk+sr
 UCwfdLh+DuTxXVgCHYnqaboU=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8478947e047so3405668b3a.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 20:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783223080; x=1783827880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jUNZVq/935GLcMXYoA0SO+I8+d+2pSvmdJVopw5CYOU=;
 b=MUW4Yiss/U+yiGUBN8LvmsDClSssoo+1AbjG6QIUD4pnwodcpMtVg8/jC7eA94cIJk
 gvnhYpwqPj2zONscHmOP4MJGvyQvtlqFhkiEhxLUYw+eUdU2zbGkWhWcnuWTPGzbCot4
 twfuQvWYK49ds2rJEpJDkLzvLlav/6vmAwohqWzET7SbRmintEiWlKegICnRkYay4q8J
 6JvflFwxBUaqqu2QUq42JMWPCrMxoKqfgqM+wYH4Om4ss8ABtMhrGBndeSAANl6uqYsh
 OFbfrpRc0ZzSnNQ/c/K4KDy7SGb2Kpm35XXJIoXy/tpDARr5jzCd16x8lLXbqD8kJKXf
 HZuw==
X-Gm-Message-State: AOJu0Yzly3UB7OH5aq9gS4i3Oncd6T2JbVmHYaqT8MR6B1+jFSlSoK8N
 ybp1kmP2Vkc+wZADWNthNcUf7K3vSxOaTDQT54Vxj7ZTUwSJQyOJp5y44T4jvWiVL1yiYo5X8vd
 v9KFZ6o5IaFvmkRcvqZdVrHyDYUWyHAqr5R+oA75B39FUX9yqohABvZn1Q5v0EBylBwt7WX+LxC
 OXK5hSaA==
X-Gm-Gg: AfdE7cloDHa6wGv4Lx4YcJUjjAdmqtgARuAW9NRlhDcR4OcheWJuswN6brvtuRRvA9m
 pnNWJKyo7aaVG3OrJAiUN7CJ0IM6BL6uxfYmadTfd4vQzrX4AcdNOBrT8Cvsmpvhs5F9oHuMl8P
 M7Mg8HGn6ikxf2pLKHosyoTadDmitKI3yr+KfCjih8XVZjTjtqtSc5G3aPZt49aZtmEUI7RGD9u
 7D2AcflaDJpkKaj3AL8VtMslgR8TsdSrvCTK20Aek3yTsGcP3WlEZIYs8cZLwGVpT5aHxenBu7o
 4LQfiC+Vn7825fXitVoZno90BLVWHvZZnzkOGS1my0q/Mfe+3Md7DoXOpYtQEPyoKHHqKwyt/2s
 xR6zljtE7v8t6KPg5wuuIWeUTfIt6rAewNat3lcidnJBA9lxXYydUgvlULvPWyxyjs7/xkqyH/x
 OH8lVH
X-Received: by 2002:a05:6a20:c79b:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3c03e1a28b6mr5412751637.3.1783223076363; 
 Sat, 04 Jul 2026 20:44:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:c79b:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3c03e1a28b6mr5412728637.3.1783223076002; 
 Sat, 04 Jul 2026 20:44:36 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e926a4294sm4424735a12.26.2026.07.04.20.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 20:44:35 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH v3 1/3] sandbox: vbe: size firmware1 area to fit the binman
 fw-update section
Date: Sun,  5 Jul 2026 03:44:09 +0000
Message-ID: <20260705034414.2247-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705034414.2247-1-aristo.chen@canonical.com>
References: <20260702071425.9204-1-aristo.chen@canonical.com>
 <20260705034414.2247-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Jul 2026 06:05:54 +0200
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

The firmware1 node in test.dts declares area-size = 0xe00000 (14 MiB)
but the binman fw-update section in sandbox_vpl.dtsi is 0x2000000
(32 MiB) and the FIT inside it carries ~16 MiB of external data
(spl + u-boot subimages). The FIT therefore extends past the
declared firmware area, contradicting the documented contract of
vbe_read_fit() that the FIT must fit within @area_size.

The mismatch was tolerated because no caller actually bounded the
external-data load against area_size. Bring the devicetree in line
with the binman section size so the FIT extent stays within the
trusted firmware area, in preparation for vbe_read_fit() enforcing
that bound.

state-offset and version-offset are left as-is; they were already
inside the FIT data region and are not exercised by test_vbe_vpl.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/sandbox/dts/test.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 0887de4333b..37a36705b36 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -176,7 +176,7 @@
 			storage = "mmc3";
 			skip-offset = <0x800000>;
 			area-start = <0>;
-			area-size = <0xe00000>;
+			area-size = <0x2000000>;
 			state-offset = <0xdffc00>;
 			state-size = <0x40>;
 			version-offset = <0xdffe00>;
-- 
2.43.0

