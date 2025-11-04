Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C91CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 23:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D478F83990;
	Wed,  5 Nov 2025 00:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mapqnpkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48CF983993; Wed,  5 Nov 2025 00:02:08 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F4783981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 00:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7F5BC3FFD2; 
 Tue,  4 Nov 2025 23:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762297325;
 bh=IwRPB9Fy+5DneLr43hS70DjFjGvJKFqKhJcYPphI6aE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=mapqnpkCDLU4Y9cJwEn3aSGf/iC/Vz/DqiUNJY/K8otlt/DbcjOLxBQC3oFfi/rV8
 tOBen7qw5xbwcP7wiHDY15S76V33MTrIbh0T2lHYTMotte5+ewsM/3limLtV/T01rI
 qAv+sg0GIl9dwpTaOldlBnU9UZ/61Vo+lxGpaLVygThANek+jzB3/vI3+JCAPyf6m4
 E5lQnmzgzhs2qrfHwNOsu3VenZdJEZ0JSzlFzvxySB+ET2t+b8TQOBW/Z9W4wVE7Vn
 gKIBqO3SPd3VwgXBk4bMezC1Ul3IzT9N7LuZU5P9IXL0C12z+aBYAc8sLia8wIrfTP
 CbR2Lot+1BaEBzCB0WPSpF71V0BP3dJV/kR7W9qkIn6QlzNM5lZ67/1suJpQu1eBa1
 Otl+80HEN4Q7xzjeLMGv5APA7e5VerjdFBWBmTWhUCWaOsu+195IgSUS02CkQygIIc
 /dWRGBXjiUULkWitMefwNNLasKA0jGVoiq6tyQGGYsClgB1Y9sO/UrEizpcD4hhlhY
 7MLo31jQHcvpiyAOaW1MACBokwggPf7wK/7IG8BPBfAao3Ca69a+5Mzjmrg5kRijA8
 F/zwI+0knzocg4TLWEPlPQfMB1hwVPc2BlgqLzjJ0a9EgW3LA+Be4anpw37zjJf2zB
 7iFwnG6qDpF0LH13ATJ2ViSM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sound: typos 'to be write', 'writen'
Date: Wed,  5 Nov 2025 00:02:03 +0100
Message-ID: <20251104230203.50404-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

%s/to be write/to be written/
%s/writen/written/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/sound/maxim_codec.c | 4 ++--
 drivers/sound/maxim_codec.h | 4 ++--
 drivers/sound/wm8994.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/sound/maxim_codec.c b/drivers/sound/maxim_codec.c
index 505a739ad7d..a3750e18f7d 100644
--- a/drivers/sound/maxim_codec.c
+++ b/drivers/sound/maxim_codec.c
@@ -18,8 +18,8 @@
  * Writes value to a device register through i2c
  *
  * @param priv	Private data for driver
- * @param reg	reg number to be write
- * @param data	data to be writen to the above registor
+ * @param reg	reg number to be written
+ * @param data	data to be written to the above registor
  *
  * Return:	int value 1 for change, 0 for no change or negative error code.
  */
diff --git a/drivers/sound/maxim_codec.h b/drivers/sound/maxim_codec.h
index deaefd93eb1..23f8341e59c 100644
--- a/drivers/sound/maxim_codec.h
+++ b/drivers/sound/maxim_codec.h
@@ -31,8 +31,8 @@ struct maxim_priv {
  * Writes value to a device register through i2c
  *
  * @param priv	Private data for driver
- * @param reg	reg number to be write
- * @param data	data to be writen to the above registor
+ * @param reg	reg number to be written
+ * @param data	data to be written to the above registor
  *
  * Return:	int value 1 for change, 0 for no change or negative error code.
  */
diff --git a/drivers/sound/wm8994.c b/drivers/sound/wm8994.c
index 42947357836..ae27947d43f 100644
--- a/drivers/sound/wm8994.c
+++ b/drivers/sound/wm8994.c
@@ -67,8 +67,8 @@ static int bclk_divs[] = {
  * Writes value to a device register through i2c
  *
  * @param priv	Private data for driver
- * @param reg	reg number to be write
- * @param data	data to be writen to the above registor
+ * @param reg	reg number to be written
+ * @param data	data to be written to the above registor
  *
  * Return:	int value 1 for change, 0 for no change or negative error code.
  */
-- 
2.51.0

