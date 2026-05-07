Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F8ACD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 17:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D64A80F0E;
	Thu,  7 May 2026 19:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GvB1W8cg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ChzWVnb0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F2284BBF; Thu,  7 May 2026 19:38:14 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABFF80086
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 19:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBKGX1Zkhz9t9B;
 Thu,  7 May 2026 19:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778175492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyEX6efE9dgwwKg9pcEt9byj4pcYPqftxjsRlIiNWn4=;
 b=GvB1W8cgE3aNGdX2HBuDukGZ1nob7njJ7yPwaGS7C2/1CUAtNyClSkr1KZba3A8YIdQG/E
 ND8GNCYjKzDMMLNjQoFOeTf9dRkT+m7PtK47qF4evf0EyATcTSqnZAF+bBEM7D/5aeTBuU
 /Gr6Hgo87uJ5LBQrfZpAKD1ugikxDFffdUJ1fHW//toXAF9v3zQBOEwFBF/wqQYNENB6My
 U7a0Swl9llHiOsULQl6HrZ2I9rE+ime3pkRj0Y24nCCQeQhv6t1kjiAqQDxaqwaIPD1HB1
 cZFU/FwdMxnP/naZ9Avd6UDGnb6ZST5NTJDa5QvWkCZDulkKgTTCuZCC3LIi8Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778175490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyEX6efE9dgwwKg9pcEt9byj4pcYPqftxjsRlIiNWn4=;
 b=ChzWVnb0zKSLZggKm5DcdFDj9GH8QJYIaDTVLsvJkLxFBmtOnlw6nhhB1OtcXce9If4PmO
 qYCsVaRtwBi9PZAHkOU7q3CNVEYvdysl6kf6yiNTEpJQSew4qrph7+kEBNIo+nJ6D+mS9i
 /zyAzdIvEOtryTib+TD1jlAP7CjAJBNE49cc0mVFKy/WwZ2GL/edrlECJgXlyBRHkAAAmr
 JgnBlB+AOARfEeUumqwKoM4C2nrZ8g0X3yGTkI0SJ9UISSo4/1H0Z4pHeF/RSXd81GoNof
 dLVVLB/ZFgyGZU9lpO1y1d3r4IklBhfWB3xEEVnPzYtdvAsGDTm3/JQbBaf+Mw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: dts: renesas: Use SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN
 on R-Car X5H
Date: Thu,  7 May 2026 19:37:49 +0200
Message-ID: <20260507173802.61639-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507173802.61639-1-marek.vasut+renesas@mailbox.org>
References: <20260507173802.61639-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: e5rbmr5oukykatpry8epcs46bsneqoxn
X-MBO-RS-ID: 2228256e1f97a1a6417
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

Use macro SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN for SCMI clock 1691
instead of hardcoding the number in DT. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a78000-u-boot.dtsi               | 2 +-
 include/dt-bindings/clock/r8a78000-clock-scmi.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/r8a78000-u-boot.dtsi b/arch/arm/dts/r8a78000-u-boot.dtsi
index 5e29ad3df33..ee8aa9ee199 100644
--- a/arch/arm/dts/r8a78000-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-u-boot.dtsi
@@ -65,7 +65,7 @@
 		compatible = "renesas,compound-clock";
 		#clock-cells = <0>;
 		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_SDHI0>,
-			 <&scmi_clk 1691>;
+			 <&scmi_clk SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN>;
 		clock-names = "mdlc", "per";
 	};
 };
diff --git a/include/dt-bindings/clock/r8a78000-clock-scmi.h b/include/dt-bindings/clock/r8a78000-clock-scmi.h
index 455402ee8cc..663effddeb4 100644
--- a/include/dt-bindings/clock/r8a78000-clock-scmi.h
+++ b/include/dt-bindings/clock/r8a78000-clock-scmi.h
@@ -43,4 +43,6 @@
 #define SCP_CLOCK_ID_MDLC_MPPHY31	347
 #define SCP_CLOCK_ID_MDLC_MPPHY02	348
 
+#define SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN	1691
+
 #endif /* __DT_BINDINGS_R8A78000_SCMI_CLOCK_H__ */
-- 
2.53.0

