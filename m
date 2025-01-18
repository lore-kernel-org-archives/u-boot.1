Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F31C02183
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 03:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B983880657;
	Sat, 18 Jan 2025 04:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="y8SrnNs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D1B18069D; Sat, 18 Jan 2025 04:16:22 +0100 (CET)
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com
 [203.205.221.209])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825F78036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 04:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1737170173; bh=wmsfRt6/bnrS20okV841+OgNwHWnc+2SQn0kQJnX+RE=;
 h=From:To:Cc:Subject:Date;
 b=y8SrnNs2m8rfDRGGKxsM3oRhwQmTzjy73rgvlmpU2+tsmtZNby9KrTJzfkTu0KhOQ
 kI1jcmeERPYvJLpJuT9BBIIlh38Io0X9lLpRzUe3IQKZZiUH06ALlpvaYudenlSrjD
 OlF6Esg09gGWuVAyxy4Ox126Xq2t30hVQilKpWwA=
Received: from ubuntu.localdomain ([183.253.34.159])
 by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
 id 40C216E4; Sat, 18 Jan 2025 11:16:12 +0800
X-QQ-mid: xmsmtpt1737170172to58oholz
Message-ID: <tencent_49E0062008CCBCC96E1FFB1E894172B6D807@qq.com>
X-QQ-XMAILINFO: NXMmzHJ6C+tbnQWsnNxNBi7u0y0uqJhWCMOPwIG+kG7upYSFuuYWBs8LxYWP3P
 2pyT/RQ4kwFJQAbNr0z/vPtcurIsXRLs9YJzwNuw/lo0DoBQ2HonVCUUIITruS98jbFh5n+lpmPG
 SYlRNHewJt5m9DmP6NGlgQo1DKfYivcoZKAjiaiEPOe8x8NRgQaD9qjQYLo0wU/MqvbDqrmigBGp
 7A60PvV4fIpVIqOkRPaSBKnyqzK4L37uEf37IuboIEeCISZGHXhM8KWM6xjbY04vETrdzzdGVm1a
 7U0jztApBPMc6/HB+ZAn3k12mdLevNEQkOGXnr6FGqdAJXYw78/+AnDr9t3Tz+6NwGw89r8DvxlX
 TdpevwKRamPg+bO8spI/Xx3sZRH7kRhgI8B4g3hxoex9FjZ8GHw7b4IeWC7mz8DoLGwKw5MKMJ6m
 jxPsDlAhasyloPSIQxVWa47OhLIIGH4fSkSG57rFT5HPPd0bpgRhasH6/4qtOuoEBMjr6z3TR/LD
 QdKBnQFZne2M0g9fDriUBARUsk8RZIrVLmX9c6CkZPtaW1lwKuTNpf+/mXlieWb/7+7MIBHzGiJy
 OZPrW/MjcLRR6LVgRGmrL45/pG9VO2VS5eAQeEuc/E6mUFCAfMMttVA0eFqtDZ40iCrnE3Y5oCIn
 Aaofvh+DEb88FWUUKdTaWFuUzOOlW8BkdGyYPg1l2ceHv9zIfJDMkAFa55qtcshWtI3XIypsqQ0R
 wBLuTk0E3I8IK0BqykZ3NG/jIBK6N0qcRn/LhgroBLHLE0/yu5sLCe+mVihDJ7V3AnUcJJdG/nla
 lHnhIKYFUTJ78iIJxvfInsnHQ02Iq5h4gIvrC2y6N4+wqKIIhZqUfgCOjTiXMu6+kIXzucfxdOEg
 Tf/Ds+2pm4xlXBBShgxo1t208mM9SrG0/K/H5rCTlQCQWBUrPkTwWn/ZE0j8HbwCwOitmE2+78J6
 hYskzMFtkSMuiYlFe0g09dvTjbbG7n4sFGFx7Rm68=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: 1425075683@qq.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Liya Huang <1425075683@qq.com>
Subject: [PATCH v1] linker_lists:Update the alignment using
 CONFIG_LINKER_LIST_ALIGN
Date: Sat, 18 Jan 2025 11:16:09 +0800
X-OQ-MSGID: <20250118031609.16647-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

This patch updates the alignment of linker lists to use the
CONFIG_LINKER_LIST_ALIGN macro instead of a hardcoded value.
This ensures that the alignment is consistent with the configuration.
Replace __attribute__((unused)) with __maybe_unused and
__always_unused to eliminate the warning of checkpatch.pl.

Signed-off-by: Liya Huang <1425075683@qq.com>
---

Changes in v1:
- Due to an error, the patch was resubmitted, leaving the code unchanged

 include/linker_lists.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index f9a2ee0c76..e8791430d7 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -68,8 +68,9 @@
  *   };
  */
 #define ll_entry_declare(_type, _name, _list)				\
-	_type _u_boot_list_2_##_list##_2_##_name __aligned(4)		\
-			__attribute__((unused))				\
+	_type _u_boot_list_2_##_list##_2_##_name		\
+			__aligned(CONFIG_LINKER_LIST_ALIGN)		\
+			__maybe_unused							\
 			__section("__u_boot_list_2_"#_list"_2_"#_name)
 
 /**
@@ -91,8 +92,9 @@
  *   };
  */
 #define ll_entry_declare_list(_type, _name, _list)			\
-	_type _u_boot_list_2_##_list##_2_##_name[] __aligned(4)		\
-			__attribute__((unused))				\
+	_type _u_boot_list_2_##_list##_2_##_name[]		\
+			__aligned(CONFIG_LINKER_LIST_ALIGN)		\
+			__maybe_unused							\
 			__section("__u_boot_list_2_"#_list"_2_"#_name)
 
 /*
@@ -125,7 +127,7 @@
 #define ll_entry_start(_type, _list)					\
 ({									\
 	static char start[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
-		__attribute__((unused))					\
+		__always_unused			\
 		__section("__u_boot_list_2_"#_list"_1");			\
 	_type * tmp = (_type *)&start;					\
 	asm("":"+r"(tmp));						\
@@ -153,7 +155,8 @@
  */
 #define ll_entry_end(_type, _list)					\
 ({									\
-	static char end[0] __aligned(4) __attribute__((unused))		\
+	static char end[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
+		__always_unused			\
 		__section("__u_boot_list_2_"#_list"_3");			\
 	_type * tmp = (_type *)&end;					\
 	asm("":"+r"(tmp));						\
@@ -249,7 +252,8 @@
  */
 #define ll_start(_type)							\
 ({									\
-	static char start[0] __aligned(4) __attribute__((unused))	\
+	static char start[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
+		__always_unused								\
 		__section("__u_boot_list_1");				\
 	_type * tmp = (_type *)&start;					\
 	asm("":"+r"(tmp));						\
@@ -274,7 +278,8 @@
  */
 #define ll_end(_type)							\
 ({									\
-	static char end[0] __aligned(4) __attribute__((unused))		\
+	static char end[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
+		__always_unused								\
 		__section("__u_boot_list_3");				\
 	_type * tmp = (_type *)&end;					\
 	asm("":"+r"(tmp));						\
-- 
2.25.1

