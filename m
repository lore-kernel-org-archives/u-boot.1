Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E437ECA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A500F80DC7;
	Sat, 10 Oct 2026 22:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DfKw5FOtkmkd; Sat, 10 Oct 2026 22:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDE7480FA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671542;
	b=WYtOuhxF28uiVICSB2N8v3rqwBYCrGs95b1SIR+58dH+DP2jRdIMNlA/V7Zel7Tq//G6
	 QfpJ4sVJVO8+z7w9Py4w8jOg3M/S0w1/kC8xngIDxproe1CGu1e1Z0HR4L4ECkwrW+6Sa
	 YqE8rhI0f2QgqHQwoo8/PHD90dmQCFZygkaylnkLnejon2RO9xW2CZiTtexbKohLH6tmC
	 dI42LjObtlNbuyGqKQ0Nox4htARaW1QtkgDXxeZKTJpzRWHAQwuw51rdSz8jSqUtQXhzB
	 WzN9J7/Psyp+EE5wWnFxh3+moqnlj2QCHmTwIZb36CV0HIdgTxu4FazoPKK9WibF7Cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=3i6ZFl8JgJ434buHAh4mWfsD707cPAKyhE5UPqtsb7Q=;
	b=UxC6HMShtRJEJqxq+gKJ+6Kq68EItQHbmi+ETMJCdX+b2+ISH8X6xbT/QNfrokCwS3Jp
	 qOlx9zE6Ya9JFTOKnxj5DvDKgT95HWQnN9F0/Z8ZM7bNmoNKwVEZyU127TPOziUUGLq6F
	 ceKkj3wVzN3DBxLywGoxlRolxleXku6pDSbKUAq0zQn73EQfXAjLr6qJWhh+gQfC1txtO
	 u0q0BV0H4TdcfC5Md7vLL2cBRdTUKPhLJxEpWe1vkTpEBCo+LWLpjPPr1bxI0RjfceL2P
	 qOcFpivHcNp1jrlKIi02gTDHfsHiDrsM1ufMVAvBzgnnxlzvIUlD4c0Ob1t5F1NZ+Cw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671542;
	bh=3i6ZFl8JgJ434buHAh4mWfsD707cPAKyhE5UPqtsb7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nMbf9N0zZ7NW0QGr4qPadJyVKXyq2MmWxY4lEgZiMJfrHPW75F0tpgSfhzFEYhvjl
	 aF8LuGNmdBO3kss51MYfXaCyZhgNRME0ikIz5ue/nOPFyRE1bPFkNjoDXgyNXO8R+t
	 p9D6gzhRHjwoHXY8b6xQlkR2ywSdd4gCtdGqaACl3gLt98Df/TJXikzKStGI5zThrd
	 H1r/Zjhq/Wlsj/Dw+6r/PxewI4Zpq59qrTxB7eAhh+8G89DUHQnRuYxfBRXhzmEAu3
	 xesTRbF4gXDe7/x82cnXUUFkbD3i7xSn0f0xN2m026DvvrWQdUav9YtX1Lb5fz0mDM
	 Dtvw3QSbukA6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE7480FA6;
	Sat, 10 Oct 2026 22:32:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2E6DDE0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B77B64005A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AIv2OfcDeiW8 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 004B0400AE
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666489;
 b=BTdCCxIeN8ZFHgRycTjh/wG5D4KID8zKR8j3HrTN+K8IIhBSl4kqM2NzwYvgNjuIHSJF
 cmvAIPvPCLOZyHm6nFgzvszcWreSg7A6YRKpDVe733uZsJ/CRoWWI5THUAgvBG1B8wmtV
 YvY9xuSk1iEdnK4ou86xyvF5NaS1vKysHUIsGLdyj21dUs36o+UY8TNRddkA3ylsnf0SK
 b6cgXQOka+6yO0JXtTodoe1iLuXl+gMeSADWyzqJcpiBDEm67nxddxe7XUW8rTfV1G1Rz
 X26jZX7Z9roIzeZMSUJecAicdmd7B2d51u92x8ANNvr8Kq9N+2vXOhCcC3/Y43e5iNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666489;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=3i6ZFl8JgJ434buHAh4mWfsD707cPAKyhE5UPqtsb7Q=;
 b=NQRLyHT8cIVVHdw8hl55CjHuyPAf1TEvWmLYRxyzA0c58UQud/W3FZ/B7boJfjTwKdiw
 3SbhMtMtmpTV16p3bvgB9Akx+trTGCk3Gli7r/qc2pW3mt0jc5IAcl0RuWeXK7cVzn1Kw
 Nje8GKthwEt1z6l23KEEFAaobb6yrSVOCj6Rw0x1FO5JF1d7F+bq748NI0p/RSeW/YJU3
 1SClnLi4OvDn4ZQwX8bYPQgaEpfGEuPF6n5ehdLaaTrj8PlO426hUdztOL3fWnNQE+7/m
 Q3fOnNqofO02lPMl/I01nUrGqPv3vQsL8dTkmSfLOlcJqUsy/aRIdZBUEkKtXqo8cOQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nNwUVkNY; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=nNwUVkNY
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 004B0400AE
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 94D174401F;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79A89C2BCFF;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=PbN+a3HXLj90XUgJCWdBUU3f9g5tMM7fgWivYUT0yH8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=nNwUVkNYzXLuoB55rP8eUkncpYRdytlvZBXSw+PxEmeOdJJuL55aFHLReNmnzFQ0p
 NnCrvqHfnJpKtJCFh/n6CiaWmhoyuMeK0vDWhRSSwyI+k71Jeni4c7Gwx9QOu0Kj92
 IUl5fxi0aYZr7UzGqAjWL1NaCIRyJRN/goZzOB7r5/9FNArhn2FQwdoobsHBkoNQLc
 6v3TnSsrd469vyBgayuGvcpO9hPDfslW9TvUMREsBps1wGHnNPqXL1o7C7GXTs1UkC
 pn7NGNkl8VxnXehl8W675BikOPAmtGpHOqlotBIw6BOBMecHT6A/AMs+K0RIVjF/fO
 AvrLwEZ4zvazA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 68EDBCA9EC1;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:56 +0200
Subject: [PATCH 08/11] cmd: phonemenu: show PMIC PON status in the header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-8-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=4846;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=u1rUtxX6vWbMpiKwFd7SUmHwHmkYwGmjTNjSk2KAbiQ=;
 b=iSCrAwApJhluMQSO6VJAiB0J0sHhZpsWXtL6x2ATwphYNLZgy3XERkSaDe44xY3AJ9tg7DLh5
 t24LS8LrA+0CjA5gY1JKex52DAxUa1U0ZVa+MnVBf+p7RlrZT0gz0b5
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Show in the boot menu header the PMIC Power-On Notification trigger
from the QPNP-PON block of a PMIC, distinguishing cold vs. warm reset
and its cause.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 cmd/phonemenu.c      | 10 +++++++
 cmd/phonemenu_qcom.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/phonemenu.h  |  3 ++
 3 files changed, 97 insertions(+)

diff --git a/cmd/phonemenu.c b/cmd/phonemenu.c
index 8f29d8d704b..f031b891641 100644
--- a/cmd/phonemenu.c
+++ b/cmd/phonemenu.c
@@ -458,6 +458,12 @@ __weak int phonemenu_ab_slot(void)
 	return ab_select_slot(desc, &misc, false);
 }
 
+/* PMIC power-on trigger for the header, NULL if unknown */
+__weak const char *phonemenu_pon_status(void)
+{
+	return NULL;
+}
+
 static const char *pm_slot(void)
 {
 	int slot;
@@ -510,6 +516,7 @@ static int do_phonemenu(struct cmd_tbl *cmdtp, int flag, int argc,
 	static char slot_line[96];
 	const char *slot = pm_slot();
 	const char *reason = pm_reason();
+	const char *pon = phonemenu_pon_status();
 	const char *sub = (argc > 1) ? argv[1] : "main";
 	int n = 0;
 
@@ -519,6 +526,9 @@ static int do_phonemenu(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (reason)
 		n += snprintf(slot_line + n, sizeof(slot_line) - n,
 			      "%s%s", n ? "  -  " : "", reason);
+	if (pon)
+		n += snprintf(slot_line + n, sizeof(slot_line) - n,
+			      "%s%s", n ? "  -  " : "", pon);
 
 	if (!strcmp(sub, "advanced"))
 		return pm_run(pm_advanced, ARRAY_SIZE(pm_advanced),
diff --git a/cmd/phonemenu_qcom.c b/cmd/phonemenu_qcom.c
index d8a295c10dc..20a1cced8d9 100644
--- a/cmd/phonemenu_qcom.c
+++ b/cmd/phonemenu_qcom.c
@@ -5,8 +5,12 @@
 
 #include <android_ab.h>
 #include <blk.h>
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
 #include <part.h>
 #include <phonemenu.h>
+#include <power/pmic.h>
 #include <linux/errno.h>
 
 #if IS_ENABLED(CONFIG_ARCH_SNAPDRAGON)
@@ -25,4 +29,84 @@ int phonemenu_ab_slot(void)
 	return ab_select_slot(desc, &unused, false);
 }
 
+/*
+ * PMIC PON ("Power-On Notification") boot trigger from the QPNP-PON block
+ * in the primary PMIC. Two registers are interesting:
+ *
+ *   PON_REASON1 (PON base + 0x0c) - cold-reset trigger:
+ *     0x80 KPDPWR   = power button press
+ *     0x40 CBLPWR   = cable inserted while off
+ *     0x20 PON1     = generic PON
+ *     0x10 USB_CHG  = USB charger inserted
+ *     0x08 DC_CHG   = DC charger inserted
+ *     0x04 RTC      = RTC alarm
+ *     0x02 SMPL     = sudden mains power loss / auto-restart
+ *     0x01 HARDRST  = hard reset requested
+ *
+ *   WARM_RESET_REASON1 (PON base + 0x0a) - warm-reset trigger:
+ *     0x80 KPDPWR        = power-button reset
+ *     0x40 RESIN         = volume-down (or assigned) reset
+ *     0x20 KPDPWR_RESIN  = power + vol-down combo (force reset)
+ *     0x04 PMIC_WD       = PMIC watchdog
+ *     0x02 PS_HOLD       = SoC pulled PS_HOLD low (normal reboot)
+ *     0x01 SOFT          = soft reset request
+ *
+ * If WARM_RESET_REASON1 is non-zero this was a warm reboot and we use it;
+ * otherwise PON_REASON1 wins. Returned strings are short for the menu
+ * subtitle. NULL if we can't find a PM660-class PMIC at all.
+ */
+const char *phonemenu_pon_status(void)
+{
+	struct udevice *pmic;
+	int r;
+
+	for (uclass_first_device(UCLASS_PMIC, &pmic);
+	     pmic;
+	     uclass_next_device(&pmic)) {
+		if (ofnode_device_is_compatible(dev_ofnode(pmic),
+						"qcom,pm660"))
+			break;
+	}
+	if (!pmic)
+		return NULL;
+
+	r = pmic_reg_read(pmic, 0x80a);
+	if (r > 0) {
+		if (r & 0x20)
+			return "warm: pwr+vol-";
+		if (r & 0x80)
+			return "warm: pwr";
+		if (r & 0x40)
+			return "warm: vol-";
+		if (r & 0x04)
+			return "warm: wdog";
+		if (r & 0x02)
+			return "warm: reboot";
+		if (r & 0x01)
+			return "warm: soft";
+		return "warm";
+	}
+
+	r = pmic_reg_read(pmic, 0x80c);
+	if (r > 0) {
+		if (r & 0x80)
+			return "cold: pwr";
+		if (r & 0x40)
+			return "cold: cable";
+		if (r & 0x10)
+			return "cold: usb";
+		if (r & 0x08)
+			return "cold: dc";
+		if (r & 0x04)
+			return "cold: rtc";
+		if (r & 0x02)
+			return "cold: smpl";
+		if (r & 0x01)
+			return "cold: hardrst";
+		if (r & 0x20)
+			return "cold";
+	}
+	return NULL;
+}
+
 #endif /* CONFIG_ARCH_SNAPDRAGON */
diff --git a/include/phonemenu.h b/include/phonemenu.h
index 5d6ded84197..ad33e9511c1 100644
--- a/include/phonemenu.h
+++ b/include/phonemenu.h
@@ -11,4 +11,7 @@ struct blk_desc *phonemenu_storage_desc(void);
 /* Active A/B slot (0 = a, 1 = b) or a negative errno */
 int phonemenu_ab_slot(void);
 
+/* Short PMIC power-on trigger string, or NULL if unknown */
+const char *phonemenu_pon_status(void);
+
 #endif

-- 
2.55.0


