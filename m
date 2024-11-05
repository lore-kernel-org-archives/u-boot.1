Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA72FD3E778
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 22:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC1489078;
	Tue,  5 Nov 2024 23:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA4789001; Tue,  5 Nov 2024 22:31:37 +0100 (CET)
Received: from mr5.vodafonemail.de (mr5.vodafonemail.de [145.253.228.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB16F88E96
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr5.vodafonemail.de (Postfix) with ESMTPS id 4XjhNl38Dfz1y5w;
 Tue,  5 Nov 2024 21:31:35 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XjhNc1cjnz8snW;
 Tue,  5 Nov 2024 21:31:25 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id BD87B2E01AF; Tue,  5 Nov 2024 22:31:24 +0100 (CET)
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@qrv-systems.net>
Subject: [PATCH] bios_emulator: for non-x86, print warnings if PM_{inp,
 outp}* access is attempted
Date: Tue,  5 Nov 2024 22:30:49 +0100
Message-Id: <20241105213049.42423-1-yuriz@qrv-systems.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 2046
X-purgate-ID: 155817::1730842291-437FD465-21808015/0/0
X-Mailman-Approved-At: Tue, 05 Nov 2024 23:00:26 +0100
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

Currently the PM_{inp,outp}* macros are completely broken on non-x86 architectures,
because they will essentially access random memory locations if called (and produce
a lot of rightful compilation warnings too). For now, replace those macros with
warnings (until the code is fixed), so the user at least knows that the emulator
attempted to access some x86 I/O port.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/biosemui.h | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/bios_emulator/biosemui.h b/drivers/bios_emulator/biosemui.h
index 954cd88315..739a17cae5 100644
--- a/drivers/bios_emulator/biosemui.h
+++ b/drivers/bios_emulator/biosemui.h
@@ -128,6 +128,7 @@ typedef struct {
 	u32 finalVal;
 } BE_portInfo;
 
+#if defined(X86EMU_RAW_IO)
 #define PM_inpb(port)	inb(port)
 #define PM_inpw(port)	inw(port)
 #define PM_inpd(port)	inl(port)
@@ -135,6 +136,46 @@ typedef struct {
 #define PM_outpw(port, val)	outw(val, port)
 #define PM_outpd(port, val)	outl(val, port)
 
+#else
+
+/*
+ * Until the emulator code is fixed, at least print warnings.
+ */
+
+static inline u8 PM_inpb(u16 port)
+{
+	printf("x86 port 0x%x read attempt, returning 0\n", port);
+	return 0;
+}
+
+static inline u16 PM_inpw(u16 port)
+{
+	printf("x86 port 0x%x read attempt, returning 0\n", port);
+	return 0;
+}
+
+static inline u32 PM_inpd(u16 port)
+{
+	printf("x86 port 0x%x read attempt, returning 0\n", port);
+	return 0;
+}
+
+static inline void PM_outpb(u16 port, u8 val)
+{
+	printf("x86 port 0x%x write attempt, ignoring\n", port);
+}
+
+static inline void PM_outpw(u16 port, u16 val)
+{
+	printf("x86 port 0x%x write attempt, ignoring\n", port);
+}
+
+static inline void PM_outpd(u16 port, u32 val)
+{
+	printf("x86 port 0x%x write attempt, ignoring\n", port);
+}
+#endif
+
 #define LOG_inpb(port)	PM_inpb(port)
 #define LOG_inpw(port)	PM_inpw(port)
 #define LOG_inpd(port)	PM_inpd(port)
-- 
2.39.5

