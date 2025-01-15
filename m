Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F254E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A528060C;
	Wed, 15 Jan 2025 02:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="jo62Ecsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C208060C; Wed, 15 Jan 2025 02:56:20 +0100 (CET)
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com
 [203.205.221.209])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA15180027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1736906172; bh=WRstnnVrvgLQJ8v09DQsCSBAXp+Y174MVZmFAA6eDRg=;
 h=From:To:Cc:Subject:Date;
 b=jo62EcsbytIZvpbAaWhb03x5CIYAWPuP+131l8KlDIjtYtO9nc4mepBWtH3pgWLCw
 Yzn07MstO1RWfDV/TyidUiLMj4cU5TyxcK1YB3TMM7rLDxYbcYnUGMyXR6gDoFLd3t
 wDEnl/D28WsEOzk9pDpM/WHBOGeQH+LW7Hnnm894=
Received: from ubuntu.localdomain ([218.104.140.83])
 by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
 id E0A80811; Wed, 15 Jan 2025 09:56:10 +0800
X-QQ-mid: xmsmtpt1736906170tgva0w43j
Message-ID: <tencent_CCE8303926957C427AAE06F9D91282458109@qq.com>
X-QQ-XMAILINFO: MgBIhzogXqENcxknT8tX1n4Rv8vjrAQ5ZAe272yokKUz/atuil/M2XeZoAbekC
 noboOP/kyL+uaCtMjBrSesY8iAhkSjOAtAyu8xC19FH4xjZL4uM+6prOWsdvFQVWDvPE2rq6ZOeF
 NfvDpXu2pM9pyqjqLNcTN7bF0Iy7lZSm0j0p6NrU7Sx+lzRirXCP2yjdkNPPJzLL77OQ3wC64KKM
 l+5t40BfT5KSLJ1fQJRGkkQjnHONSRF7NBuJfKj9erlYbUdKONWOIJ7jdgDaHYafkU5XSEktgTsX
 26lyBeQBUd/eSpsicqmK3XfBq0enmejLWSntTmp1Qn2AwCOmFKdCA+QBt1Qmv0LaFCz2b1LVS4ZY
 DSXQvrvxlRIO56Yf/vQkAIs/PqZMHc4TFZjqpa2g8nFzCYWH2OgC0UI+A85cy6h8wigAklVQRuPn
 Ek/ZJhlKgVq4ra6DF42AndDPuhhLI62xwUC/tudd98RxuDK1PaYPf9qa91ddrHwFQu0m/UcypnRN
 5R+2B3D3xRPz5SrS81TVukwIAa6/YEpyieFG2Z/sy9eY1dLV7MW0DSEmGT7JTRMsbjjTYdajWbfx
 bBnusUAtxVrck71gJfdGEdgBJfqeCwlRGiOI2COErm+orQspiUK5YHinLfKdbhCG8CvqyLhGMU2S
 cQS8+Qzng7V3NhrmtsXMi69r/k6H4bVq7d5rOBiwRMO/GZA4G7ndO+74bBOa/dN+FepFMnQTInOM
 RaiH3bop6tfxqqrG9qiJygmWLMnEVHwFW6+7DAgWg/UK56oQbxzmNMs45GSsAGEgKGudDMVKjMz0
 PZSdIEsEZOl8Rr1MlSCLFrwkbw2UYeJ3scsVMQgMHoXvHkM1K++jw3ERquHI2Nd7puebGY8gic3V
 8l1QIPWyXYu4ouc9QhiHNKleoIJCvjAquDG7gUoC4mq+SvAsNxG85Q6ZlTwoTAPw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: 1425075683@qq.com
To: u-boot@lists.denx.de
Cc: Liya Huang <1425075683@qq.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: Remove redundant loading of image copy start
 offset.Because the beginning is already computed
Date: Wed, 15 Jan 2025 09:56:06 +0800
X-OQ-MSGID: <20250115015606.9356-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Liya Huang <1425075683@qq.com>
---

 arch/arm/lib/relocate.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index 345e282e3e..bffadfecba 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -83,8 +83,6 @@ relocate_base:
 	add	r1, r3			/* r1 <- Run &__image_copy_start */
 	subs	r4, r0, r1		/* r4 <- Run to copy offset      */
 	beq	relocate_done		/* skip relocation               */
-	ldr	r1, _image_copy_start_ofs
-	add	r1, r3			/* r1 <- Run &__image_copy_start */
 	ldr	r2, _image_copy_end_ofs
 	add	r2, r3			/* r2 <- Run &__image_copy_end   */
 copy_loop:
-- 
2.25.1

