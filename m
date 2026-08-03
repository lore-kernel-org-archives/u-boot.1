Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE0BC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 18:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FDE280BCC;
	Mon,  3 Aug 2026 18:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1DIKDrz_zbu; Mon,  3 Aug 2026 18:49:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D317D80BE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785782950;
	bh=lu1uv8XYCO36qi58/dpq/cJyWPkf0dQrcBTCO0TIIPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PhFi3287XsP+Ip9ya1Y0ZupTFsoZLxKoDwiIKqACU+RtXCXFF68qftigvwKtGVl5r
	 04oqtWB9TXwsbbXBhKinwOJZaLF2sx1mlLoYw1xJxHCQ0ZunMNRClgcPXjuggO+PH4
	 oCehbfvOWSYYqv769RG+tX/AJWMWtpEMw2w7JBZVVu1W+Wu0Wt7oG28FaxcZmcsMnO
	 Zf6tt6G2EFLBxlVu/f25EU9wivOixPKdBImaUjV82zKfWUDMEp3XSlhKjvlYi5cB8P
	 L057SdC9oRT7Sex01QC9qdBejffboxdSrbsevxjxqF+uXxvZRMUFCyG/2VBXXvX8JY
	 aGughqBAeScng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D317D80BE9;
	Mon,  3 Aug 2026 18:49:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3B132AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA0AB606A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 38uzFjILVivF for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 18:49:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BB5546069D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB5546069D
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB5546069D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:49:07 +0000 (UTC)
X-Forward-Email-ID: 6a70e1490b3ab441388a895e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/2] include: linux: Import hw_bitfield.h from Linux v6.18
Date: Mon,  3 Aug 2026 18:43:12 +0000
Message-ID: <20260803184314.2240153-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803184314.2240153-1-jonas@kwiboo.se>
References: <20260803184314.2240153-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785782947; bh=lu1uv8XYCO36qi58/dpq/cJyWPkf0dQrcBTCO0TIIPw=;
 b=e0A+SGOnMg8ZNeON3c8SYDMFuMbz6+ONE7bb5qfLjniRnOk6gLWTlTMGIA8FiTHYaGZ+q8rmW
 D2/9E7PMgDr/qkod4sX0Krdy06BUBNvbtFDfzbc+aocCfEGX8BDK0gsLI+WiHY1xkLGbZUXrnFT
 QioDtbfL1q7cSmsSnpZLeH4FoqMVysyadvO0ec4a7y9s2WdhCJevtsHyHM9NVzod3s1waYijqdm
 k2bm/lFyoy3ZBWmBbWU9GZGJSw7XNqg5onL+xdBjpbgFfemDJZsvuxPsqyzLyO2iQM2ZaA1rwFr
 VVLyrHNh00kqDEi6ESoH7Ro0lfTsTAhiVl/6bF8BXXAw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=e0A+SGOn
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hardware of various vendors, but very notably Rockchip, often uses
32-bit registers where the upper 16-bit half of the register is a
write-enable mask for the lower half.

Add hw_bitfield.h with two macros: FIELD_PREP_WM16, and
FIELD_PREP_WM16_CONST. The latter is a version that can be used in
initializers, like FIELD_PREP_CONST.

Import hw_bitfield.h from Linux commit 21368fcbb124 ("bitmap: introduce
hardware-specific bitfield operations"), first introduced in v6.18-rc1.

This contains two changes compared to the Linux version:
- include of linux/limit.h was dropped
- use of const_true() in FIELD_PREP_WM16_CONST() was dropped

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 include/linux/hw_bitfield.h | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 include/linux/hw_bitfield.h

diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
new file mode 100644
index 000000000000..6e74d902ed33
--- /dev/null
+++ b/include/linux/hw_bitfield.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025, Collabora Ltd.
+ */
+
+#ifndef _LINUX_HW_BITFIELD_H
+#define _LINUX_HW_BITFIELD_H
+
+#include <linux/bitfield.h>
+#include <linux/build_bug.h>
+
+/**
+ * FIELD_PREP_WM16() - prepare a bitfield element with a mask in the upper half
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP_WM16() masks and shifts up the value, as well as bitwise ORs the
+ * result with the mask shifted up by 16.
+ *
+ * This is useful for a common design of hardware registers where the upper
+ * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
+ * register, a bit in the lower half is only updated if the corresponding bit
+ * in the upper half is high.
+ */
+#define FIELD_PREP_WM16(_mask, _val)					     \
+	({								     \
+		typeof(_val) __val = _val;				     \
+		typeof(_mask) __mask = _mask;				     \
+		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
+				 "HWORD_UPDATE: ");			     \
+		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
+		((__mask) << 16);					     \
+	})
+
+/**
+ * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
+ *                           the upper half
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP_WM16_CONST() masks and shifts up the value, as well as bitwise ORs
+ * the result with the mask shifted up by 16.
+ *
+ * This is useful for a common design of hardware registers where the upper
+ * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
+ * register, a bit in the lower half is only updated if the corresponding bit
+ * in the upper half is high.
+ *
+ * Unlike FIELD_PREP_WM16(), this is a constant expression and can therefore
+ * be used in initializers. Error checking is less comfortable for this
+ * version.
+ */
+#define FIELD_PREP_WM16_CONST(_mask, _val)				 \
+	(								 \
+		FIELD_PREP_CONST(_mask, _val) |				 \
+		(BUILD_BUG_ON_ZERO((u64)(_mask) > U16_MAX) + \
+		 ((_mask) << 16))					 \
+	)
+
+
+#endif /* _LINUX_HW_BITFIELD_H */
-- 
2.54.0

