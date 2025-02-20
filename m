Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A402FC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 12:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF4380A46;
	Thu, 20 Feb 2025 13:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="dneUbI4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 229E7801DE; Thu, 20 Feb 2025 13:50:05 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0318F8007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 13:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20250220125001e46aef54fc7c27d974 for <u-boot@lists.denx.de>;
 Thu, 20 Feb 2025 13:50:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=0am+NklbSSCz+YJqS9na6fQp41gU5yM3iBENcwWDdi4=;
 b=dneUbI4vSlGL4y16UwCFSjxQrJE83YziMXm8hsHu6kYjTp4IFKu5p77L7dOQ+ER8QtOVr6
 5rBcJQdu2ycvkIAVhXE9qMvIDa3BSa02n50q+uZFaadjOZ4yrMLYydb3cox3ZkQTkwqGCZha
 af1vsItYlB49LAWTu5VJk/jXChm63767+yQbaRH4hhTtI5ZQsLTRPOmCs0zp4jkv8uwD8CKd
 Ty69lH3QIxKb4SCVO7j5fLG3WUV46Znhq8giKM57e3K0Qq08T7PVDtDwV5uBUALxx59sANxu
 c8flgLWEMQdttpamP2VJrKW4r4H+LJD+4FkPaD7lGJBaONcKZ+GJJ+EQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>, Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH] tiny-printf: emit \0 as %c
Date: Thu, 20 Feb 2025 13:49:07 +0100
Message-ID: <20250220124908.3396843-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The current code has a problematic corner case with formar "%c" and
0 as parameter. The proper zero byte is being emitted into digit buffer
but the final copy into outstr expects null-terminated string and doesn't
copy the required \0 byte. This has lead to malformed TFTP packets, refer
to tftp_send() which relies on %c to generate multiple zero-terminated
strings in one buffer.

Introduce a variable to force the copy of one character in this case.
The new behaviour is consistent with non-tiny implementation.

Reported-by: Chintan Vankar <c-vankar@ti.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 lib/tiny-printf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 0503c17341f..faf55d7f327 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -211,6 +211,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 			bool lz = false;
 			int width = 0;
 			bool islong = false;
+			bool force_char = false;
 
 			ch = *(fmt++);
 			if (ch == '-')
@@ -300,6 +301,8 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 				break;
 			case 'c':
 				out(info, (char)(va_arg(va, int)));
+				/* For the case when it's \0 char */
+				force_char = true;
 				break;
 			case 's':
 				p = va_arg(va, char*);
@@ -317,8 +320,10 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 			while (width-- > 0)
 				info->putc(info, lz ? '0' : ' ');
 			if (p) {
-				while ((ch = *p++))
+				while ((ch = *p++) || force_char) {
 					info->putc(info, ch);
+					force_char = false;
+				}
 			}
 		}
 	}
-- 
2.48.1

