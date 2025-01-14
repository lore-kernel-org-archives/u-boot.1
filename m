Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3515E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3B9805CD;
	Tue, 14 Jan 2025 14:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="wR4sSbAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BAE80658; Tue, 14 Jan 2025 08:10:01 +0100 (CET)
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com
 [203.205.221.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA31C80619
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1736838588; bh=GmuIwOJ+tlegUMrP6E2AKwmhw3pUWNaFUVYPzbHWh2Y=;
 h=From:To:Cc:Subject:Date;
 b=wR4sSbAqRb4sEpE2qohfO3nIJHZ3Iao4cZ6ZkdHQruo1rG4W+QgtQPGGxEccRJb+s
 6HAolFrICGngbNH6nJfHnYzOoCScHFIn3DmrXFbxnuDlscTFL1Jlr3UUYS6C+a7ZcM
 1Ps3j/goZhs/oRBomcVQ9jmYE0nfyjnmacsrayWg=
Received: from ubuntu.localdomain ([218.104.140.83])
 by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
 id 26DA7449; Tue, 14 Jan 2025 15:09:45 +0800
X-QQ-mid: xmsmtpt1736838585tvv60n4ns
Message-ID: <tencent_9739C1044069984893BE3E6D3DB783BB6C08@qq.com>
X-QQ-XMAILINFO: NKDEJ657lpu+wtqo7SdMkQZFPpTSKJKMYXEXadM5E3t6ui714+CfTeQuhFhFER
 TXzW9Rb1anE167HrXE6DGWXyW5v15eFC7JpmBRJfzj5Bs8nvKm/QOcmi5BkQCNgp8KRbm/SUdYsh
 hiDDXXcFPLKr8UzN5qAN7Nhjx/G3WpbhKTEf/40PZk+ffdKCmL2nCn2UgUyuqL2AHYV3hI4c+3cn
 prAD6ZNW/j/aTeEARJXj3jWUb03tT1mFJ3EyvDUE2pVfyPKsRjNVgEW3SOfZhv6AiYI8E1xVdYwE
 TdMjESuR+rRmxJG5ZpxAJPmu3n7E0zr/hKXOCiXfPeNiaT467JLmLLvYuYiD05JqEzIdrvmR9WHV
 Vqmq+JxirooFkqOhi2xTcwrp5IFDt5yyGeRTGa0zfK7sn4fdKu8AZkwafYSAgJH64by1xQuixThO
 s8w3ChGrTFzZvcJDfK6YoL/TAvgYPH+YkeT81/UjGEFivyfXyI192kRlYANTtV9sthKseynl/oPO
 kJ/vbEHagjiZI2SPWktJ7yrzge4m1gF1VQ17h3EVOlGb9CxRt/jVZ0suIcooA8G2ZtRrZFoQ6NGW
 CxEFaYbBxcXf4/TA5t4XOkgQ/l9OenCsf3lV8MvnZv1mI/3ylZ4TL77g582E8x+dOkUroV3NKUVh
 jtp6OvK1WLTtgRMCPmobLeMDRtXSd6Dp30b+WiqXS9/ILLfp1TBpBlHgUddLdrSNus+vjejNMREn
 DKlV0cPSuQ5EZnjD0vw4XNcCKMXvBCk7Zf9mP2ptc/sk/jbj+OzGpv5t9twMCySmbqbwZ2hR5+SY
 YphNecptNI07m/jp/vRlxF4URYc8cSNhu3xsvpAL93qUTZmQpl9fsOWlqvg61fSlgyyO+ViqLZaF
 e4RlAZ51anSi9odNmAUrmBn8p95EuXxnOVzJGj/d4ZCgqW0CffdVxPN07W+3ilmiBHZh6CtSmKld
 O7CaKrt3W6XiokNHGXZUp6zzvBQPAW
X-QQ-XMRINFO: OW8WShJdN8S2cMc/fs8JwkE=
From: 1425075683@qq.com
To: u-boot@lists.denx.de
Cc: Liya Huang <1425075683@qq.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] linker_lists: Update the alignment using
 CONFIG_LINKER_LIST_ALIGN
Date: Tue, 14 Jan 2025 15:09:41 +0800
X-OQ-MSGID: <20250114070941.7488-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jan 2025 14:25:27 +0100
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Liya Huang <1425075683@qq.com>
---

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

