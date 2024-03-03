Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4386CC48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 14:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BBDC87F06;
	Sun,  3 Mar 2024 15:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="zlOmr5h1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660B787F0A; Sun,  3 Mar 2024 15:37:40 +0100 (CET)
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com
 [203.205.221.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA5087DFC
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 15:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1709476649; bh=xZeySlevRlUCF1ClBBMg3pQnA4Vl9NgCLalXGQs9BcA=;
 h=From:To:Cc:Subject:Date;
 b=zlOmr5h19f82adKX0MCpxw7htVF9vgMz0J1lYWmgx9yPnwNUyplRBs1whovLZ9QsE
 PMshVPvEyel0lpg/3Ghdnc7vS52JqdQLGzH6MVH5hueghnBEGViM4fBO6plfcFDf2b
 WCH6enIEohQP9DLdyBjcKZctkhbcMbvMkf0hXlao=
Received: from localhost.localdomain ([183.172.216.136])
 by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
 id 95A9DA66; Sun, 03 Mar 2024 22:37:26 +0800
X-QQ-mid: xmsmtpt1709476646t2gg7qof7
Message-ID: <tencent_68E23FA4C49CA30D00D138F38BC53267D305@qq.com>
X-QQ-XMAILINFO: OC704IrkdJt6z2Ib1fSBb1KSATyaJ75SUBp0LN8DTV5jlwZzagAXDpuYmxcBJC
 eS/F0EmhCsdrhE0qMqb/qESXBzAztyvMUGnMVAn08oFNVeeTZGUmDxSwcJqrgIEfAoR1p/2eeRIW
 t6QpUBxGGDc2Shr79NF31VRByj17ogDSid6lO/kD8Ypa/O7ZsBqH+VlQNkBQZu8yA4GIRPq9oOhD
 JkcthlAH2WR3tmDK7mTM3U8O1C7NGZP/Od17kKhvf0jVD8p4BMv3H/TZJW3x52tz8m49953GQ20O
 DVjmPvmu9FsnCq1Tc/XKYFUssW9UytTNxNrNYeBEMuo+l40PTbl0pTC8k6QNLbEJW28itAn+fwjn
 qS0bVzoqIzusCh3V4NhwG+3OIPgtL+GcQjVgYyrjWValAT0jYjlU7c/KzHxRr5fR1WB4ghlOFAN6
 iko1wQuR0/4FmFwaZ0quj0Ofmspm3XeCV1JYxCgOTnMOnQd+VapZfwef9h9DM/FaHR/IFQEsSbYA
 z8Swp5oWPA/0kJ9V779bHURMQB8U3z9P7X9l3GnFapYMTWtYh7GDaDUOEj+q2bFynwJL76u7BZb6
 77beptJ5M7QOXAcrmAhMcm65WWUQXXo2KUxxt2nctvPeaAjMEcmUWhdSScDUYqYsEWCigv77hWiE
 H04n/uDFEh8crX3zgY/wv+pfwQwOGY52cGxuze/jysXcX5OSDpaR/WagBAjhUHtlDauY+P5aqJIa
 Vq05Z9JO0a8GAMZ27nMsblPVIkXGoz8CjByXDLxP9CniBwa5QWeMZBm/LaZcxQ/WAWaaGu1KMwX+
 TkRB622gpcJkjMVtmmHKBlBkRdckm/DPDGg07GMBOg/nYZYETxgpAsuDzT4Nk9xgXCUIWxPxZlW+
 /8quANlHT6s8Js8gOgVWit+2HwHTscJEEe2RYAD02I6YZ9ZLKdzwjpnDJuVMn0TyT/9GsA0GZjys
 c9KKQeFZA/MHTmIcFEf9fgvQLNbpK7VE165AIaZwoSJK1ICoBQTG+lAEdViyaN
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH v2 1/2] cli: panic when failed to allocate memory for the
 history buffer
Date: Sun,  3 Mar 2024 22:34:45 +0800
X-OQ-MSGID: <20240303143445.7030-1-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
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

This commit simply modifies the history initialize function,
replacing the return value by panic with reasons. The calling
chains of hist_init don't have steps explicitly throwing or
dealing with the ENOMEM error, and once the init fails, the
whole system is died. Using panic here to provide error
information instead.

Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
This is v2 of patch series cli: allow users to disable history if unused at all
---
Changes v1 -> v2:
  - Remove the lines surrounded by macro CONFIG_CMD_HISTORY, since if the
user says N to CMD_HISTORY, the whole C file won't be compiled, i.e. the
history is disabled already.
  - Remove default y to CMD_HISTORY. Here we should follow the original one.
---
 common/cli_readline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 2507be2295..99e7efdfe5 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -110,7 +110,7 @@ static int hist_init(void)
 
 	hist = calloc(HIST_MAX, HIST_SIZE + 1);
 	if (!hist)
-		return -ENOMEM;
+		panic("%s: calloc: out of memory!\n", __func__);
 
 	for (i = 0; i < HIST_MAX; i++)
 		hist_list[i] = hist + (i * (HIST_SIZE + 1));
-- 
2.34.1

