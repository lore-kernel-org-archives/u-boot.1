Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C354CA1014
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 11:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EE283564;
	Wed,  3 Sep 2025 13:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="n9/Q0ZaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA6B833C6; Wed,  3 Sep 2025 13:07:40 +0200 (CEST)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E414983564
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 13:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 80E063D544; Wed,  3 Sep 2025 14:07:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1756897655; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding; bh=l7s4W5m3lmVYyDCj3zm8/dyheyvmSEsiEDjJoMWjXl0=;
 b=n9/Q0ZaD/QUkdX3DyCfIvfl5CFFAOMTiNIuWij6h2v3LaKIi9VXbLOGqyQMozUUx1z55LT
 oZnOfyOOV/DxZf+Q6JLHmUKfyV/CnFRG0GVzeO+XZTvsHAYlvoVgC6g0erCJaXdrHeQO1q
 kNnTlZDURy0yhC8grggGxdbfyw+Okv7T0Tqg8PP1dmn4YPeIfng+MBNlrKWChe2nmFLF7h
 JWF+Ta2yT+Jnpkc32NEgeAAl5/jqe/PaAOrKvmUT1zUN6SudFmAcQ2zkb/Aa1Mw363lIzW
 oRnrEZcYbobWz/Pw+sfQmQwFrS2pjmzQ6mytLGx8sVr/amo2zANNvRIReyPyQA==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] ARM: amlogic: fix JetHub D1 eth mac fallback generation
Date: Wed,  3 Sep 2025 14:06:03 +0300
Message-ID: <20250903110726.546083-1-adeep@lexina.in>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

JetHome has allocated a special range for MAC fallback on JetHub D1/D1+
devices.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>

--- 
Viacheslav Bocharov
Shenzhen JetHome Technology Co., Ltd.

---
 board/amlogic/jethub-j100/jethub-j100.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
index 9e87fb9f9d7..79732864d03 100644
--- a/board/amlogic/jethub-j100/jethub-j100.c
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -19,21 +19,17 @@ int misc_init_r(void)
 {
 	u8 mac_addr[ARP_HLEN + 1];
 	char serial[SM_SERIAL_SIZE];
-	u32 sid;
+	u16 sid;
 
 	if (!meson_sm_get_serial(serial, SM_SERIAL_SIZE)) {
-		sid = crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE);
-		/* Ensure the NIC specific bytes of the mac are not all 0 */
-		if ((sid & 0xffff) == 0)
-			sid |= 0x800000;
-
-		/* OUI registered MAC address */
-		mac_addr[0] = 0x10;
-		mac_addr[1] = 0x27;
-		mac_addr[2] = 0xBE;
-		mac_addr[3] = (sid >> 16) & 0xff;
-		mac_addr[4] = (sid >>  8) & 0xff;
-		mac_addr[5] = (sid >>  0) & 0xff;
+		sid = crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE) & 0xFFFF;
+		/* OUI registered fallback MAC address */
+		mac_addr[0] = 0xF0;
+		mac_addr[1] = 0x57;
+		mac_addr[2] = 0x8D;
+		mac_addr[3] = 0x00;
+		mac_addr[4] = (sid >>  8) & 0xFF;
+		mac_addr[5] = sid & 0xFF;
 		mac_addr[ARP_HLEN] = '\0';
 
 		eth_env_set_enetaddr("ethaddr", mac_addr);
-- 
2.51.0

