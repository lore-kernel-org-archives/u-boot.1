Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D06C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5039880763;
	Mon,  3 Feb 2025 10:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rnIIXsDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE956801DE; Mon,  3 Feb 2025 10:12:11 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7BC80608
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-254.46.114.pool.telefonica.de
 [46.114.108.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 44A2741EB6; 
 Mon,  3 Feb 2025 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738573928;
 bh=v7kUquQoYPodvHQnrrsaD6rLhSzswdTq2ZVkmHQhjls=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rnIIXsDJ7tAnWVL8ad8MBiCpG5DqzoNT5I65N8z6n+fuFxGsvTterEXbchpuB/jwg
 cdhJs7JqGWk9cWx7UwLuNQ0kUT5yQC8EL3CYV4WbLKyvpF0tBQ2ZeqiQCca4eJv1QP
 cFA6sY4hOX6nRMHVBcmpdOzA6+hfHquSOCTF2h26k+OJNZ4NbnEZJfRfOKUGmJKmgZ
 UZRRowOzj43zoDgSiBL/s/gShW34SYUvBtsuRfUS9CgGg4YifAy78GV5SBMa7Wl2vV
 y2rHkX6i1JJS/5+aBF7RUEXS7hiQd2rURwh6CgQHeqJPjITW8Wlw6bjTJG6d54myCd
 ehzawCOGjxvfw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/4] net: lwip: tftp: fix find_option()
Date: Mon,  3 Feb 2025 10:11:59 +0100
Message-ID: <20250203091203.47590-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
References: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
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

Find_option() is used to retrieve the block size value in an option
acknowledgment in response to a request containing a block size option
according to RFC2348.

The format of an OACK response is described in RFC2347 as

+-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
|  opc  |  opt1  | 0 | value1 | 0 |  optN  | 0 | valueN | 0 |
+-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+

The current implementation of find_option() only works if

* blksize is the first option
* lwip_strnstr() ignores the length parameter,
  i.e. is implemented via strstr()

The OACK messages starts with  0x00 0x06. If 'blksize' is the first option,
strstr() reports a match when the first parameter points to 0x06. Adding
the string length of 'blksize' plus 2 to the location of the 0x06 byte
points to the value.

Find_option() would report a match for option 'blksize' if the response
contained an option called 'foo_blksize_bar'. In this case find_option()
would return 'bar' as the value string.

If 'blksize' were the second option, find_option() would return a pointer
to the second character of the value string.

Furthermore find_option() does not detect if the value string is NUL
terminated. This may lead to a buffer overrun.

Provide an implementation that correctly steps from option to option.

Fixes: 27d7ccda94fa ("net: lwip: tftp: add support of blksize option to client")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Tested-by: Jerome Forissier <jerome.forissier@linaro.org> (qemu_arm64_lwip)
---
v3:
	rename variable match to diff
v2:
	new patch
---
 lib/lwip/lwip/src/apps/tftp/tftp.c | 54 +++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index 56aeabc4d73..e85e3623066 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -264,19 +264,55 @@ static u16_t payload_size(void)
   return TFTP_DEFAULT_BLOCK_SIZE;
 }
 
+/**
+ * find_option() - check if OACK message contains option
+ *
+ * @p:		message buffer
+ * @option:	option key
+ * Return:	option value
+ */
 static const char *
 find_option(struct pbuf *p, const char *option)
 {
-  int i;
-  u16_t optlen = strlen(option);
-  const char *b = p->payload;
-
-  for (i = 0; i + optlen + 1 < p->len; i++) {
-    if (lwip_strnstr(b + i, option, optlen))
-      return b + i + optlen + 2;
-  }
+	const char *pos = p->payload;
+	int rem = p->len;
+
+	/*
+	 * According to RFC 2347 the OACK packet has the following format:
+	 *
+	 * +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
+	 * |  opc  |  opt1  | 0 | value1 | 0 |  optN  | 0 | valueN | 0 |
+	 * +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
+	 */
+
+	/* Skip opc */
+	pos += 2;
+	rem -= 2;
+	if (rem <= 0)
+		return NULL;
+
+	for (;;) {
+		int len;
+		int diff;
+
+		len = strnlen(pos, rem) + 1;
+		if (rem < len)
+			break;
+		diff = strcmp(pos, option);
+		/* Skip option */
+		pos += len;
+		rem -= len;
+		len = strnlen(pos, rem) + 1;
+		if (rem < len)
+			break;
+		if (!diff)
+			return pos;
+		/* Skip value */
+		pos += len;
+		rem -= len;
+	}
 
-  return NULL;
+	return NULL;
 }
 
 static void
-- 
2.47.1

