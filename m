Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBE3C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 19:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44961843BF;
	Wed,  6 Aug 2025 21:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cfLh+kKV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vmkP2LmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF3B843C6; Wed,  6 Aug 2025 21:25:14 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A5B2843BF
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 21:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4by0cM6XPGz9sb9;
 Wed,  6 Aug 2025 21:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754508307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n81Rk3NTxPtj9Ao72XN9+SQ2mtdJZ3YklSuvnQJuS2o=;
 b=cfLh+kKVX5ZTJSP/VN9hywm8f99C4NmMIkNC3etgX6aMJt1g0Zz76YJA8N1OzK3alUGN+f
 uz2Kvdgwhq7OdgoSKV0AzRpjvpCjlecRqk2ndFRL3MxiM2FaKqvXduJGbmqMP7sEj1aqpH
 xTlLUeiVAEo004zCDpPwRKK/syyf6RQ723gMiRhxKzYEyGHG1ZGSXBKQkiPimtyvNRBk2W
 xSc/Ei5YXo6J5CxFVJI4G1Mh8OPPEmwi3KCWgx906vZU1MCZUdUluaT6i5pDn0T52fN54W
 oeHn4P0dxBxm9wRO6n8SlkOtLwMIobhaV8AFAn6ew9pzFYndvES+S5iz94tHFA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vmkP2LmX;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754508306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n81Rk3NTxPtj9Ao72XN9+SQ2mtdJZ3YklSuvnQJuS2o=;
 b=vmkP2LmXe/6Nx94rRcrWqxR/wM0Mw9OQzouTZCexiVONWuyf5ec/4n9qT8TCN1uwjhdVWk
 +hLbQ3kfSEybOEfIbxHCO0cv+2JsspAJoqcOg3g7odFhoTKz9N3amdju6HuvdQgrPiLBZE
 s+RH/IQleyF0U9KYkzREJRCOeKbv/AKIG7PqjWlmH2L/7lhZYzfUCr5Z4boo4r44ncviM6
 joEp8Z9tAvfQc5IuMdt5V3fDmF6ZnQTjTGfuVuEVmsO9a05B/2YJKVbbv5yuKE2bCIgXJm
 QFGC46xOu1++WeDvpLRBWOCU2QJJW7iTuVKorpwn4kPpqxdYbxb0IeCF5Juexg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: r8a779g3: Set VDDQ18_25_AVB voltage on
 Retronix R-Car V4H Sparrow Hawk EVTB1
Date: Wed,  6 Aug 2025 21:24:26 +0200
Message-ID: <20250806192456.133098-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c186ac1b852850b1a14
X-MBO-RS-META: nko3zzwwhj1xtccj73xmiz53qzbbcrtt
X-Rspamd-Queue-Id: 4by0cM6XPGz9sb9
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

The Retronix R-Car V4H Sparrow Hawk EVTB1 uses 1V8 IO voltage supply
for VDDQ18_25_AVB power rail. Update the AVB0 pinmux to reflect the
change in IO voltage. Since the VDDQ18_25_AVB power rail is shared,
all four AVB0, AVB1, AVB2, TSN0 PFC/GPIO POC[7..4] registers have to
be configured the same way.

Correct the voltage for EVTA1 boards accordingly by patching the U-Boot
control DT in SPL.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
---
 board/renesas/sparrowhawk/sparrowhawk.c              | 12 ++++++++++++
 .../src/arm64/renesas/r8a779g3-sparrow-hawk.dts      |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/board/renesas/sparrowhawk/sparrowhawk.c b/board/renesas/sparrowhawk/sparrowhawk.c
index 1fd7a63d2fa..58de7f25cbd 100644
--- a/board/renesas/sparrowhawk/sparrowhawk.c
+++ b/board/renesas/sparrowhawk/sparrowhawk.c
@@ -231,6 +231,18 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 		printf("Failed to disable UHS pins in MicroSD node: %d\n", err);
 		return;
 	}
+
+	offs = fdt_path_offset(blob, "/soc/pinctrl@e6050000/avb0/pins-vddq18-25-avb");
+	if (offs < 0) {
+		printf("Failed to locate AVB pinctrl node: %d\n", offs);
+		return;
+	}
+
+	err = fdt_setprop_u32(blob, offs, "power-source", 2500);
+	if (err < 0) {
+		printf("Failed to set AVB IO voltage: %d\n", err);
+		return;
+	}
 }
 #endif
 
diff --git a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
index 0abfff5fe90..2d8474395c6 100644
--- a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
+++ b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
@@ -529,6 +529,10 @@
 			drive-strength = <21>;
 		};
 
+		pins-vddq18-25-avb {
+			pins = "PIN_VDDQ_AVB0", "PIN_VDDQ_AVB1", "PIN_VDDQ_AVB2", "PIN_VDDQ_TSN0";
+			power-source = <1800>;
+		};
 	};
 
 	/* Page 28 / CANFD_IF */
-- 
2.47.2

