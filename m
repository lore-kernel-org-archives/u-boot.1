Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7852F99C88
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 18:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE5F83FF5;
	Sat, 18 Apr 2026 20:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dOWf401m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F148405A; Sat, 18 Apr 2026 20:15:16 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5560836AC
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4D53442001; 
 Sat, 18 Apr 2026 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776536114;
 bh=nuHrwl8ds0JDf4waqOs0HBbSDogIfITFaPtum8Nm4Q8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=dOWf401mVSpmlOyC2JUxjkLzgdn8ffu+q4Y8dsTSju0yAc317fdPIbID43ZY8sD9r
 4qRBamheg7P3JVbni/sNTLtgMwqbJ26/+08zwgVk7+n0L+6ktsuGjqtUQCJ9gJ70T7
 SILKxXVwdwZX8WTTHrzLShfSz1xOCWRP5ZMqIBKTKGJyp/RQzHeA4Srhe3Ca/2g8g2
 oLgssb2FX6L1p9PYoKJt02Uqo7HJybCi7tP9KivC46k3YG4a2HRmw5CK6QGUTTIWXM
 SkrpZNO/tVQ1Lm5jBuAHCVzVbbCiDczrbx81QKK4LHDRu4yUYPDVXt9LuybVaJvDfi
 YVGkTs+3JStfdKAO7/sUnzl8HtA6hRQCqIfclzjSoVoUKaouiKCl2o8hcvArgucSJw
 wFgN7o3sXHaip/STWY2piIbh7mvIWws/uq5v6fHwYjgw+rNWoKpbpRH5Oaw54swbd+
 C/eJMrDH/cARvsQ0Nm/ET41Jd5yrrOW3D4eMv06rIhkSZnGE3zRxM7EVuwqiksLoQz
 Pn7OzWJ63ZvPNvKtKHZ6ROJ6arNOQwv8W4W76AGFZjWjMF+IDTJmx080Wu4m76zVcG
 v8CbYmf4Q57OyOqg/XBoguTeB4pWPpgi0/Zv7WmZxbOHzHLPOliL5rz3B7KUBnU6mM
 Su1fmsrtDkBI6uY5hTTeRNdY=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] scripts/dtc: avoid discarded qualifiers in
 overlay_fixup_phandle
Date: Sat, 18 Apr 2026 20:15:10 +0200
Message-ID: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When building with GCC 15.2 the following warning show up:

    scripts/dtc/libfdt/fdt_overlay.c:422:21: warning:
    assignment discards ‘const’ qualifier from pointer target type
    [-Wdiscarded-qualifiers]
      422 |                 sep = memchr(fixup_str, ':', fixup_len);
          |                     ^
    scripts/dtc/libfdt/fdt_overlay.c:432:21: warning:
    assignment discards ‘const’ qualifier from pointer target type
    [-Wdiscarded-qualifiers]
      432 |                 sep = memchr(name, ':', fixup_len);
          |                     ^

Define sep as const char *.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/dtc/libfdt/fdt_overlay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/libfdt/fdt_overlay.c b/scripts/dtc/libfdt/fdt_overlay.c
index ee64f0b8110..e40cfe8c3c7 100644
--- a/scripts/dtc/libfdt/fdt_overlay.c
+++ b/scripts/dtc/libfdt/fdt_overlay.c
@@ -407,7 +407,8 @@ static int overlay_fixup_phandle(void *fdt, void *fdto, int symbols_off,
 		const char *fixup_str = value;
 		uint32_t path_len, name_len;
 		uint32_t fixup_len;
-		char *sep, *endptr;
+		const char *sep;
+		char *endptr;
 		int poffset, ret;
 
 		fixup_end = memchr(value, '\0', len);
-- 
2.53.0

