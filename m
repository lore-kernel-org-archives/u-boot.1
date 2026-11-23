Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1094606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=izFk81VL;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=qFgtZfrQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D083A40620;
	Mon, 23 Nov 2026 01:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VtaxMcbXUkRf; Mon, 23 Nov 2026 01:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3582240623
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795396570;
	b=dhaXmP6MNcsteKuRtiCoi49al/eeO6RZdbcQf0kpdCilP7HmD/Wyd/1TZ/1ZH8iJ+eX3
	 Tozcketz4bL758WbJ1czTTYsBvom+X8WnhJDqnfTSKaOcvh26EspPDHS4gyFiLR+AFial
	 Ve2Bq8d6DK1lG5fdytaFn8K/BV+KFirH12MfIu1fzVNzHFP5H3GW7Jon08b69wQL0g4vQ
	 w3c+Y2VZmjFn34wwmzsf9RZ2lKFpxMkxREAv/KH6cOj7gCjI61XzXiboSM+uOcpR9XeNj
	 htXJRDYjIr/Vj/XcUK3j2CFI+DtQPbs9TPFgLjiYKtUe9kVke6TkzGrb1pgSQ05A0KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795396570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L3JJFYO6w2ZQqiiP370awpYu7GNPqlh/p6ErW/UAQm4=;
	b=qk0nKIOYCYkX0a+HCc0FQUlZvzKMpL3MPkwv9i32+1nW/bvj2fcCjlhRM1iju+rr90Vc
	 TQ5FxtJpYyWHYsBLUG2+l4kC5IiVmBsQCAwK5m4VCpgq8G0McyixCZM6THm90pTOFwyFO
	 c47g5nOR+Q4UkP7MoP+xOXa7wWLYRz6KZ3ldppNFkfnc/sAG9iGdNu8mEdizcgogb85d9
	 mBhhHARwMDbTBREGQiGPW0y4uaZrrDgol1cJxMaVEvgncRHKXyauqf0BsJmG3HKpbQ0gI
	 0yKcZRUhn4n8WldlatUga4ELRhaS+/tV0YDvFKqe4XZ+JI52wX9uqdKEhBd2r3Y+TjQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	spf=fail smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=qFgtZfrQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795396570;
	bh=L3JJFYO6w2ZQqiiP370awpYu7GNPqlh/p6ErW/UAQm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izFk81VL2QVbFSY5Nq1vpAmqj6ev6dj9ne8OHqEc12xa79NiAcQpTnPnLoqsgc3sk
	 4fXxSgl4SfgvLSCIjm/O9ASg2EijRFtD0HWvN/WJuTpisB/T7ylEtYxBrLMkdMe/tj
	 hcyxkpQiGK1mkeoAFF/Rt3EVzguneEpxOmGm9Lce3a9sW6JsPz2bTV28mMTGIiqEh4
	 B16Xh+gKWcYSRsh6GwCw77YnuWTtfV3ncGb3ddQbqDS9bFHMvRtf42/YNaUupwogYb
	 WSf8A+QGse6mIVh9mAo/Te0O9NTXvyWYTaqD7DmkqEIxuLxzGfTXwHxoSJ7Zflhqmm
	 ZdaHulgmIyRhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3582240623;
	Mon, 23 Nov 2026 01:16:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2F0F371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F09AC40623
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TOodLRaZFGN for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 01:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C93240620
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=qFgtZfrQ
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C93240620
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:16:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3039F84717; Mon, 23 Nov 2026 02:16:05 +0100 (CET)
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F3D84409
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 02:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=d-silva.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alastair@d-silva.org
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 027D142720;
 Mon, 23 Nov 2026 12:15:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795396547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3JJFYO6w2ZQqiiP370awpYu7GNPqlh/p6ErW/UAQm4=;
 b=qFgtZfrQEb1Ne2K/Mc/TmtD7/flSu0Hi/KuxBp2Dp3DccC9Zxj3wDqtAimR3A3t3+QRTUQ
 S98b2w/Gzq+oOe55R6UIk6tF16dR/iY1up9B26wIUIK6blhVw5dReOl9J8JwG43rsvEqGu
 /4cP6C8zf0SxqybiwqczO2nxiGmdPkYA4ifwAfB4EMeXCE74ZEWjRQmwvyQUDp6xAgbZV5
 pMVoAyP242HNT1/a82mVSwYWoxqA5Sog40g49Bv/gen5tQviFn0t6OUIBgNIr6us6xUqVv
 cZnB/BxW1zsNaFzDKnLoeW9qjGRceQX7OZ/egZN/xDi7uwdrkf3Vh3S3X/dsTA==
X-GPT-Reason: legitimate personal/professional communication.
 The email content is a technical patch description for a Linux
 kernel driver (PMIC power management) which perfectly aligns with
 the sender's identity (Alastair D'Silva) and the intended mailbox
 (alastair@d-silva.org). No phishing markers, urgency, or marketing
 elements are present, and the technical detail regarding register
 addresses (0x55, 0x32) and signed-off-by lines confirms a standard
 developer workflow.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 2/3] power: pmic: axp: Fix AXP318W sysreset shutdown register
Date: Mon, 23 Nov 2026 12:15:33 +1100
Message-ID: <20261123011534.1692975-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123011534.1692975-1-alastair@d-silva.org>
References: <20261123011534.1692975-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AXP318W places the poweroff bit (BIT(7)) in register 0x55 instead of 0x32.
Register 0x32 controls CLDO4 voltage on AXP318W.
Powering off via sysreset currently corrupts CLDO4 instead of
shutting down.

Define AXP318_SHUTDOWN (0x55) in axp_pmic.h.
Select it in axp_sysreset_request() when the PMIC ID is AXP318_ID.

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

