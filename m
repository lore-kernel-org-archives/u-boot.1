Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427E606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VITvbZs6;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=ONRag+3N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CFA760733;
	Fri, 13 Nov 2026 02:33:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AiMX58E4JoPy; Fri, 13 Nov 2026 02:33:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A609B60E23
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537181;
	b=PBHol1jtI2RqDfD55rUOkKg+9GEjJsBzYrQTSiuBm//yR+8YLhXLMrAFh2TImYJcBhgk
	 i79tjOgo6CsEm+QmsEkKUeti41vigKAxN4pRtFa3OoQIbStTQyX33dFXkViE3rJFv+f3U
	 YH4w5jTs046Cz6HU7YdDLYgbDH/IDEWCNbqj6TNkvcN18f0wtGgrmYNfvf3VSs8FegBpK
	 bR3p9xh3aYSZvq6AFb3jlbpd0hqcfGz774eicbcAeqyQcUfOCOnSP7s7A6apU8wRphy+c
	 WhwwByce9gxn0vvsWGXoYC19cYBI1GF+BN9JP2oU1hJBvVwVuL4Nx+Bu9faPSejR9wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537181;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZaA8Ttu6jtBsq9TKYqT2+So20h/23skD6alveByOCIA=;
	b=NGsV/8Y3ZhZXXPsJNlE+I3eg41tmqfxtHpREBBffvDWbe0T4kYEKX69bgpbIsl9wBzRC
	 BALPIBWNc1cr3FdLnyBahu8mwELGkAQ9hvrzviEvH3KlUEDEL+vTjObxl4TIxvl5UU7r8
	 hsrN2IOIG89+o+PW2FryOrh0DHmOcum6eAQXZ9/AWG/ubxcj0QQAm7GwQtbCOuw1LZtkn
	 UX3bJv5EmuND4xiJ5bEBEaFdty2QGr4d89o1t2/qk5N1dAJ3iCU/EYyH2gUaHf0VpyhyP
	 rN2+vlb4L4ohNVU0BAHpeWlrsDhasm/87WIgY/Iz5Awf69D1LZgzn3cd9k/PlD9bQmw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=ONRag+3N;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537181;
	bh=ZaA8Ttu6jtBsq9TKYqT2+So20h/23skD6alveByOCIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VITvbZs6bdHBcggI1NAweykXruJZy+GLKWMwwW0J//A0VZrk+vIw62f1ZQH+a9wYf
	 197JTeloJ9cU5L/zuaZAVTIbK8q17Q7Qt5KOJPgYQftPaDx2R4QtHLvfIgk2Kk5nLH
	 4mrDSod/SZxFmZvJJUWPXj+MqihgjnW3DuYAW47wghFy0NyKRQLnGg1JwXYIunNuWW
	 GBA1e8C9JVh8N1lnLPs+1GeOjPVsyD26FviUncDL5i07SS/oS60dL3L/rcGKR3BeT1
	 ghK7YDXcr135hkbwyx1ejloQfs1ssE4LUb8ciDEICiYQGudC5FHuCeuSgGLcTxtyFZ
	 lHZefb8+GuS3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A609B60E23;
	Fri, 13 Nov 2026 02:33:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A47C1370
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE1C460733
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BF4jnh6jPVWR for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3857460E39
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256
 header.s=2025a header.b=ONRag+3N
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3857460E39
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:00 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 88A8841EBB;
 Fri, 13 Nov 2026 13:32:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaA8Ttu6jtBsq9TKYqT2+So20h/23skD6alveByOCIA=;
 b=ONRag+3NBB801sGRkEFwRYj3vSEKvbtWYE/Ekt+V7rbDceDqe2qw0YjVooI4bZE6nuHMPS
 7ep8tfMO0yZL65xsvOvxrqjDWblEPpjgqpZyYnwwvMGmrywAXvOu4ZvIXg8yeaEI+gAH3t
 qpAUyfW3YnotfiuLqFhcO0EBgImgsV3A/f9+sktEsU+3avOMoJcAiB4TrMQa832yhH5vok
 10/bIS47Xk1dct4F887MGECPQNZEY+dAWMzbue04ormVyG73wS5pv67dCufCiBPbn6H9fH
 6KUIxYaP2zGUVmBgSS3foLe4HDAO4u1wAUMtxWdJqBwjBJFajkN3aLnqCSuIaw==
X-GPT-Reason: The email is classified as legitimate personal/professional
 correspondence. The content is a technical patch submission regarding
 a Linux kernel driver (AXP318W power management), which aligns
 with the sender's identity (alastair@d-silva.org) and the recipient's
 domain (d-silva.org). There are no phishing indicators, no unsolicited
 marketing, and the From domain matches the internal context of
 the mailbox.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 02/26] power: pmic: axp: Fix AXP318W sysreset shutdown register
Date: Fri, 13 Nov 2026 13:32:12 +1100
Message-ID: <20261113023236.569054-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AXP318W moves the PMIC poweroff control bit (BIT(7)) to register 0x55
because register 0x32 is repurposed as the CLDO4 voltage control
register. Define AXP318_SHUTDOWN (0x55) in axp_pmic.h and select it in
axp_sysreset_request() when driving AXP318_ID.

Fixes: 71f07932756f ("power: regulator: add AXP318W support")
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/power/pmic/axp.c | 4 +++-
 include/axp_pmic.h       | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
index 7d8348b0769..c24165ef67e 100644
--- a/drivers/power/pmic/axp.c
+++ b/drivers/power/pmic/axp.c
@@ -10,12 +10,14 @@
 #if CONFIG_IS_ENABLED(SYSRESET)
 static int axp_sysreset_request(struct udevice *dev, enum sysreset_t type)
 {
+	ulong id = dev_get_driver_data(dev->parent);
+	u8 reg = (id == AXP318_ID) ? AXP318_SHUTDOWN : AXP152_SHUTDOWN;
 	int ret;
 
 	if (type != SYSRESET_POWER_OFF)
 		return -EPROTONOSUPPORT;
 
-	ret = pmic_clrsetbits(dev->parent, AXP152_SHUTDOWN, 0, AXP152_POWEROFF);
+	ret = pmic_clrsetbits(dev->parent, reg, 0, AXP152_POWEROFF);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/axp_pmic.h b/include/axp_pmic.h
index 2f547da74c2..5df0e269b9d 100644
--- a/include/axp_pmic.h
+++ b/include/axp_pmic.h
@@ -26,6 +26,8 @@
 #define AXP_PMIC_SEC_DEVICE_ADDR	0x745
 #define AXP_PMIC_SEC_RUNTIME_ADDR	0x3a
 
+#define AXP318_SHUTDOWN			0x55
+
 enum {
 	AXP152_ID,
 	AXP202_ID,
-- 
2.53.0

