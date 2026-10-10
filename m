Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB76DCA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B441F40878;
	Sat, 10 Oct 2026 22:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqUo9lp99ZTf; Sat, 10 Oct 2026 22:32:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F14BB40960
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671552;
	b=Gg3SBWhn/y7goy/J8vQC3hqkglF3TnL1GqJoDDMwpSf+b7mMY5Wxk/4Yhdz3YsiKyeSw
	 het2EIlaFQAZTEo7nY2URrNoUk5Om/8W7M/yml4V8LpPCaLxydCTGyFAfbWRaA1N/DoGq
	 fIOVwYZ6XczFc24OLOniP6qL5pWKVkuwXyzHHNCy3RVDEB2RpHG7uxWMXo97m+enkDLUK
	 HDJuWBDrqNOjHawH7t8yjFMbHqhD+0iwwgvosy6g5+GNSBLZBb8E2/zQibv5nCgZxqOuu
	 9ntGrBXa5qdAAPW3bt5iuGB+QE5+mhCAt/OLKHcHNjEeGohHPaaO9gvi5sHTwNWFppw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mtNEPWdilQ/l4uF48YhmtVaQ4W8DBfZD+MnoH+3Y+no=;
	b=MECZazLPmUxkLyNQI+VS+OX1bMsP29Y04HG5RptuG/lBJmzf1pBTDpA0BBEcJce9/6NP
	 JgpFfuUM8R6d1LmvCnHZSDwabfE9DSRsZl1cUZ/0JOjQba59Nal+i+smtwfSz0H8hjsp6
	 BQeqa6oJCMwgzuALyqWrkTk+3JYu3IfZAb+acfI7llewJsc+mU4dvzxqUjDvIUKiI7H/A
	 MTv+BcTMkjz27uX+s4hBfJON3nyi3fXjSN890bwVtVNLQUQL/Fec2LxgNGHhITekktAM+
	 hSjj9/QNS+UwXt5SjxJxcTUuU1MH8V4SgbVSkMj1r3N+hJLknWKp9nSpOi8RPhG9l0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DauXenOg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671552;
	bh=mtNEPWdilQ/l4uF48YhmtVaQ4W8DBfZD+MnoH+3Y+no=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=cYc4py0VdKWuYaaZ+8VoNXaJhrjxeY6DmcVG8lk503OzWZzVnXAtKD67HnnPNq3Po
	 UIKbd1bTYyjncYyLAhA7vlqTprMSc5fepM0C6DDJVLu3ZXP2UWFn7BRPRkrvMqkeAH
	 iqcNaIsHnvH4FuHO9Ij1gDHrPjDjLpWE2aaAYU9ParQgICrY5b2zda/nPyLg2iz/it
	 lONFK8g10bCG5J4TI7v4WDWooaH2qD/TwCReGJpZNLak4gW6SSfEHmlc8bwR+7mciv
	 2aIiUPYmnrDAor/Tt5EXXtOhiY+/XsAREP90AsmHY8OOiNMYVDwBEq4oH/LtzH038h
	 OY7IY0WgsYHfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F14BB40960;
	Sat, 10 Oct 2026 22:32:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B70089D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D1C44082D
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_cbVQECOEaA for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E28DC4082C
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666490;
 b=jEwtJe0opOnV7DBJuXxlGVi0wfrly+INPvWv00V7rk0lBwuPpaq1UgCFBVNR9NORXYK0
 qZ5UH2QI4eoG8ZMYkPT8JfPBKyKACAGQdSItnI6/RmSUirpwbHI4XU5aXWOcxHVujWDHH
 wf4k1WuDy7Gqwwvun7qPy5osUC9fKQRN1EgCvklKZ/k0eaT/Ko0FfMYXZ2SKdLqu0Xit4
 M71wZXUeHit8Qr5YVz8hIhOMoN9VQBNzOOXVfKX+NNfv4LvrYQjQJNg9Vi4HObdsCFGx+
 yNRtVL+F45dyMwi/TN+1aeslD4TqlGdXMGlDFUHgavDD69F/EAatirmgUjTyRBeEtbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666490;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=mtNEPWdilQ/l4uF48YhmtVaQ4W8DBfZD+MnoH+3Y+no=;
 b=b7kAuGiW+WWNXJ0ikHgffFWH8mDPzHbFufwiiobx62rcLyTviuZtJ9ju9prH/sOI2sqF
 aaGuQCSL8FddWNH/hBRflwWJEnRMrUUIfx0Kyrsgo/GV+fzZNLZGC2Ig5Xd3/OVB5J+lc
 sekPQM4E2DeTcDvXViSOKSLwDhKifc9s5EFL9+JsNwFARnU/Jr5ueykeQo/ml/vqA/rgy
 WoSMhDsobdcYijjKWFfx4Q1cP7c6p3bxTyf4nbLNupkhdbGPOb3DziH9KvcrSzYMKW4CD
 5RIlz27qBG3j4+UNNV6YMt+yxQb8B9IhMwv/K0iDCcQKjDY1OZgT4JIwgX2AWGdHMww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DauXenOg; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DauXenOg
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E28DC4082C
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AF80602D1;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C193C2BCFA;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=x6k/VA/8ymJD6YpmDlr+uywvqsjyz/d5SBVX5RcPKoI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DauXenOgZz1pJRoPiwMZxPkcemadqHR7AGmCT/C1kDHHMiei4OcnkWSRX5RBbNrlr
 FLMID84WBRBbtZ30DzrMfO8VXekefy5t+Cfsg8t7BIx9qusDznGzv/alyILz+svE4D
 K/TriCHfFYZraQhTWuveOsEE+VagEmXKg1wqiy1QWmiLBuIXFVSg3v+G1XQjDqnwTf
 1pNkEI/Fddr7mouIhOff73Cxa/letIi8yaCwz+DM2VCxcRAeTDJTeGn3ADEU2tyCFG
 /xBT6ZjPq7FKM1JYozwTHH/XQd6bRc4XrLBU1K2/bYjd1RaFN4zsgD9+W06RbpDMKH
 HgAjHiaIo4odw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 28186CA9ECC;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:52 +0200
Subject: [PATCH 04/11] boot: android_ab: read the A/B slot from the GPT on
 Snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-4-bfa23de6eb0b@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=2142;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=//DmpccicaexghVlCBHa4ZEw776XyWUG38BTdmOwT/c=;
 b=h3jpZxqENsNLkODNvYYzin5PdF1qljqJp5cI93q0YvK/icOhsIiekPzG1fc7O7vxm6rMJktKW
 8AiHekXUXlfCDzL7xycKDJ02ccRMeM97NMLrimSaDY7aGHXHQOPRG+U
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

Qualcomm devices don't use the bootloader_control block in "misc". The
slot active/unbootable state lives in the attribute flags (top 16 bits)
of each "boot_a"/"boot_b" GPT partition entry instead.

Make ab_select_slot() read those flags on CONFIG_ARCH_SNAPDRAGON.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/android_ab.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index f2b1110aa24..aedeb1edf28 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -191,9 +191,51 @@ static int ab_compare_slots(const struct slot_metadata *a,
 	return 0;
 }
 
+/*
+ * Qualcomm devices don't use the bootloader_control_block in "misc" at all.
+ * Slot active/successful/unbootable state is stored directly in the top 16
+ * bits of each "boot_a"/"boot_b" GPT partition entry's own attribute flags.
+ */
+#define QCOM_AB_ATTR_SLOT_ACTIVE	(0x1 << 2)
+/* Not queried below, that is SBL's call */
+#define QCOM_AB_ATTR_BOOT_SUCCESSFUL	(0x1 << 6)
+#define QCOM_AB_ATTR_UNBOOTABLE		(0x1 << 7)
+
+static int qcom_gpt_select_slot(struct blk_desc *dev_desc)
+{
+	static const char * const names[] = { "boot_a", "boot_b" };
+	struct disk_partition part;
+	int slot = -1, i;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		if (part_get_info_by_name(dev_desc, names[i], &part) < 0)
+			continue;
+		if (part.type_flags & QCOM_AB_ATTR_SLOT_ACTIVE) {
+			slot = i;
+			break;
+		}
+	}
+
+	if (slot < 0) {
+		log_err("qcom A/B: no slot marked active in the GPT\n");
+		return -ENODEV;
+	}
+
+	if (part.type_flags & QCOM_AB_ATTR_UNBOOTABLE) {
+		log_err("qcom A/B: active slot %c is marked unbootable\n",
+			BOOT_SLOT_NAME(slot));
+		return -ENODEV;
+	}
+
+	return slot;
+}
+
 int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 		   bool dec_tries)
 {
+	if (IS_ENABLED(CONFIG_ARCH_SNAPDRAGON))
+		return qcom_gpt_select_slot(dev_desc);
+
 	struct bootloader_control *abc = NULL;
 	struct bootloader_control *backup_abc = NULL;
 	u32 crc32_le;

-- 
2.55.0


