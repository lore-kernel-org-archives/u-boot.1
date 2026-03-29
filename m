Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E92FF4927
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 23:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBDB383B48;
	Mon, 30 Mar 2026 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XNWN/7P3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qGGd7Dbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FFDD83CD3; Mon, 30 Mar 2026 01:12:01 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B328063E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 01:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fkVWd0xPYz9t3C;
 Mon, 30 Mar 2026 01:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774825917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xZEtDe0D6pLuEaTwEGISxJYnmxVTcjtpGFJZt8c9I2U=;
 b=XNWN/7P3dAg2bQqQYTPuKGACl7iU0vDvhdFSEhFea2ndZYQX+d9keN9oxT5fDSWMHT4IWf
 bcqoqJzK2Sa7nRpAko7fg1WNIP4R1JCrPsM6Ekn8KP7h4wRsZ/ICR0/zH4aQJ6CIUHUF17
 UH815hKwP/z1wjmMk+cFmWwijPLU/hYsA0tKVkY+Q7OzIVc9eTa4U9FuwwBWZa0f0d91UE
 ATEbCcsmV/DmjM8B9R0XWTJW3YA/jgXmFrdGV4q9wghzDKHrAgw2MYVdwcX8b9Vfznmf7x
 hXCih7U/s4hgrijejyIIUQ4nQyT51xDwUzYJ1iHKgUTwMdUQrfOscak5PNjjMA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qGGd7Dbu;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774825915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xZEtDe0D6pLuEaTwEGISxJYnmxVTcjtpGFJZt8c9I2U=;
 b=qGGd7DbuBf4P9zMKERuZlbUAqkzA6iQXNPZXhdsIz5OH0HPdilxbtk7QvryNgyaK6YMzwz
 pYOujjRu+5q5de5md3Jk2t6yqmxehVyCUj37rzEzLkOVHNhSkSdxlqVzXdCn37xV9DE59R
 K+xyCSbB5HpH2rrRHolImcJczoaX9eOphWmXFZrNAwChzsBfD7FVUybgChKYFhjX2AZ0+k
 HgXcBOAAATo0R+77Vf1SQzMKjumhe1wLuTe3XQHEzPPYd/d3scig0ZkEDjFyJaWUNMrV5t
 Fxzvxb7DMX+iM5Q1IAn/5VJ6A406ZkytyzTpdA6K/+kzxc9m7I8HCfSs+/lVmw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ufs: core: Fix heap corruption due to out of bounds write
Date: Mon, 30 Mar 2026 01:11:36 +0200
Message-ID: <20260329231151.332108-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4xggxr9dq6rri7bzbfsnmak6ozqtkidz
X-MBO-RS-ID: bcae9ff1b46e56d0717
X-Rspamd-Queue-Id: 4fkVWd0xPYz9t3C
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

The ufshcd_read_string_desc() can perform out of bounds write and
corrupt heap in case the input utf-16 string contains code points
which convert to anything more than plain 7-bit ASCII string.

This occurs because utf16_to_utf8(dst, src, size) in U-Boot behaves
differently than Linux utf16s_to_utf8s(..., maxlen), but the porting
process did not take that into consideration. The U-Boot variant of
the function converts up to $size utf-16 fixed-length 16-bit input
characters into as many 1..4 Byte long variable-length utf-8 output
characters. That means for 16 Byte input, the output can be up to 64
Bytes long. The Linux variant converts up utf-16 input into up to
$maxlen Bytes worth of utf-8 output, but stops at the $maxlen limit.
That means for 16 Byte input with maxlen=32, the processing will stop
after writing 32 output Bytes.

In case of U-Boot, use of utf16_to_utf8() leads to potential corruption
of data past the $size Bytes and therefore corruption of surrounding
content on the heap.

The fix is as simple, allocate buffer that is sufficient to fit the
utf-8 string. The rest of the code in ufshcd_read_string_desc() does
correctly limit the buffer to fit into the DMA descriptor afterward.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
NOTE: This is for 2026.04, but please do test it on your hardware too.
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Padmarao Begari <padmarao.begari@amd.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ufs/ufs-uclass.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 81fd431f951..6a51f337e47 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1751,7 +1751,15 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 			goto out;
 		}
 
-		buff_ascii = kmalloc(ascii_len, GFP_KERNEL);
+		/*
+		 * utf-8 is encoded using up to 4-Bytes per character,
+		 * however, we only allocate such a buffer because the
+		 * utf16_to_utf8() converts the entire $ascii_len worth
+		 * of input characters into up to 4-Byte long utf-8
+		 * characters. The rest of the function uses only up to
+		 * $ascii_len bytes of that utf-8 string.
+		 */
+		buff_ascii = kmalloc(ascii_len * 4, GFP_KERNEL);
 		if (!buff_ascii) {
 			err = -ENOMEM;
 			goto out;
-- 
2.53.0

