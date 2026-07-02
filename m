Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF15C43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A7684CE1;
	Thu,  2 Jul 2026 11:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MT8AyLYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F9DF84C92; Thu,  2 Jul 2026 09:14:57 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB0B8056B
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 15B193F979
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782976495;
 bh=jUNZVq/935GLcMXYoA0SO+I8+d+2pSvmdJVopw5CYOU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MT8AyLYw6vjDJkOx/etqwZ+3eqeaURMMLHTPO5Cz74Km9Vj/PXHoR1mtro239AysU
 hnBaWUxEUockm5Wg/RpcBy93N9VZiu2SmjZsnMUa4A2baZQJJJw5JjiPmOitqNIgab
 gE6gexYDt1tJVDodHnqIv9z2MeNx/MnMf1BeuxNjDRcskyNkOP/5+jE/xd5mhs+Avd
 SGRHzXyBymPC+Wg92lA8LKAhHzTT4XhnF9ZiHUicouFehIv0H2kQ22tW0xEZn+MHH/
 xH8smbgo2EgMeyaZVB+Ef0NRtDclvkygCeN7+P6p47lvzZ/PjyUqGYPtcMZPR2g6OA
 xCLbZ5FmmPOYsmoqz/jCTC3xyHJCfqCcCT5+Yiv1+Qqj3Dwg657gR6BN9uhTUgfPrr
 79rdhG9eFmegmu36akhsbiyDoEIk4ic1CKe3I7YA8hZaJvBFsYj6Z+XWuJMAB0DsIi
 /dYhRgtanYqfO0E0veTpySHz+GjyI/EE83ts6kxprhEhbDz0A/loh/Lo0qi6gCeCM0
 0ahE1ScXlNXO/IPTqcQLPKcIX2qTbp8eDyxx3lZVrzdqblopZ6rxERkewUbrtVBDQI
 6nhMWxZgjHkvcYI32ebAVmGMuh8XLcDZt5xOQ0jt4yjw2RBGHgP7YJHg0FVPtRTk7e
 xD5hkB8I4HNkYhtoWKIZ6AOs=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-847a2509456so2047900b3a.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782976493; x=1783581293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jUNZVq/935GLcMXYoA0SO+I8+d+2pSvmdJVopw5CYOU=;
 b=B0WQwHip5SXjmNft3KWtGoQ14YyhASt1t3U1ugHy6IUg2h4iZG78GP0wN50snyFoxF
 3PuIqqWJzhe3yqxfOvC43VI9yne8Ba80rrWU6SLbZlMyBgUKxhgw556NwdQzP4N8cLNV
 9cVHucQBCBHQJcCJQ7PlZI6Tl0qCfyAlx7hc3kYk4fkgkMs2ZPkEXfJBQpO1D8Peex3L
 SH09WtNdXwltKeFiXNRjyWBHIucfT+JqVhseLEOtr9rC7eoC0vhMa2ejpO9+S5Zfivl5
 HQt+8nbBxwfRH4Lgk/4ee26lJ06XhaGz6jpCCphJBIv6ab5ckBnQk9mMEFkQfwZavKN3
 uTQQ==
X-Gm-Message-State: AOJu0YyntXYnTUuhfRXgqYZJqkWXasZRJGVAmgyAEExTcO/0K8FjRgT/
 e9kwJlK+4imYUBPnTy1EtiYw/kBbizLJ4cqAlYxh0Z2/X3o1e7BW4Sf8urk3kDtR+MLvHcadwVN
 U1GTJMH3AB1PFBXdd+1QUBXJrxzosFfqw5aHsq3jn1BaGVAHmrGaHdhUXDPL5S5Y+nz9l2xj3Gm
 hIVxXx6Q==
X-Gm-Gg: AfdE7clHbGIv7ZuaCa1a5srIcXLzGVBYOjI6pNmfRMOGVyy2lMuj3+N4GrCXvVop16c
 9OvjSI3euS0LFllM0kKNv7M6nAU1GmByELn4Z9l/TIIuDfv/PlwLsruAyuVoXMmSODDY9nLrXc7
 v9hOhDLzW2ueVA6ezKVG7Ezw2CG345svup1zaG3PjF98Oy2jQfcm/VdNCrhKKIVFkbnqCIi0owa
 SH2cJMCggPd1XZU8P8l7vLDeI2Uz7dDBAQIwaT9sfRQMsse+SsNX049LdDEplHEFGio//1abyzy
 t1Ft45+Rgz25BCYQtIrO+aVbUxFZPuN8avIpuA+Xz50wNKwvqHkXh6A3Y+YDd0Q/zh2F6wdIoqG
 4VwU8vX0APuZ2I2JU+VtL46RByyP03E8uZeUKVnJ9JdO8V0MX0LS+KNmQDRnWU7ZHHMO2UYIypI
 8+Hw==
X-Received: by 2002:a05:6a00:b53:b0:843:468d:7804 with SMTP id
 d2e1a72fcca58-847c0879346mr4915645b3a.34.1782976493417; 
 Thu, 02 Jul 2026 00:14:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:b53:b0:843:468d:7804 with SMTP id
 d2e1a72fcca58-847c0879346mr4915603b3a.34.1782976492891; 
 Thu, 02 Jul 2026 00:14:52 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cba05575sm894056b3a.61.2026.07.02.00.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 00:14:52 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rasmus Villemoes <ravi@prevas.dk>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH v2 1/3] sandbox: vbe: size firmware1 area to fit the binman
 fw-update section
Date: Thu,  2 Jul 2026 07:13:57 +0000
Message-ID: <20260702071425.9204-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702071425.9204-1-aristo.chen@canonical.com>
References: <20260621143938.2863-1-aristo.chen@canonical.com>
 <20260702071425.9204-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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

