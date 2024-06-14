Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281A3C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDECB889CF;
	Fri, 14 Jun 2024 14:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="M0TjBvu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9965C889DC; Fri, 14 Jun 2024 14:19:36 +0200 (CEST)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com
 [95.215.58.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF041889D2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: jagan@amarulasolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718367573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpXA2aS2NTssOXnHNMdzy7H/mieGuZZtMDIntKc1hz0=;
 b=M0TjBvu1n+g8rDisY8AoZp40jxTP+hECCE7/1z+WJH5EfmCT0ji2dHPwH9ZcZPTrw0x9Ml
 dZpuyuvgtX+BPQil/JuUrHhbOVAXKpbVuKtOIPeHT/CnNdzwakmPulyLt5Chjad4++uYEN
 p3G/ZcQ7DMr9ovcqQbGJi5ZHAnTccw10fTUMqEZFVW4K5QPaa8Xe+su/oNIcB1XG54mdoy
 AvrgJWrkfrAMB86X1xBo4tkVzJUOdLb7JH0dS/sRlmAc5TKy8xDN1EuEXnGw/BKL3RHaNj
 +qXIHkWA1ArSnTxRheXrXhgfb9oNKeDvpTx1sNHLE70diDwMoLkt7eUIXGhPJw==
X-Envelope-To: agust@denx.de
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:18:41 +1000
Subject: [PATCH 1/5] spi: Return old wordlen in spit_set_wordlen
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-mipi_dbi-v1-1-946eb82f8533@jookia.org>
References: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
In-Reply-To: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718367536; l=1370;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=IUmROq0U3IEa42gVai3F6LYhozMwfML6Dn97dCcmEvA=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAuogheZcotvyeyfEGtUEBZyP
 0tLBadb07yXD7fGuaWXS81DOJm4OcbN51nlpSyuyLDbc6X+9iNNRmNVJd1pDiCQUAAP+P
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT
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

Return the current wordlen to the caller so they can restore it back
when done. This is required to avoid clobbering the bus state.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/spi/spi.c | 4 +++-
 include/spi.h     | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 22910de0dd..3649c9c25b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -10,6 +10,8 @@
 
 int spi_set_wordlen(struct spi_slave *slave, unsigned int wordlen)
 {
+	int oldwordlen = slave->wordlen;
+
 	if (wordlen == 0 || wordlen > 32) {
 		printf("spi: invalid wordlen %u\n", wordlen);
 		return -1;
@@ -17,7 +19,7 @@ int spi_set_wordlen(struct spi_slave *slave, unsigned int wordlen)
 
 	slave->wordlen = wordlen;
 
-	return 0;
+	return oldwordlen;
 }
 
 void *spi_do_alloc_slave(int offset, int size, unsigned int bus,
diff --git a/include/spi.h b/include/spi.h
index 7e38cc2a2a..d5acf4f9e9 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -259,7 +259,7 @@ void spi_release_bus(struct spi_slave *slave);
  * @slave:	The SPI slave
  * @wordlen:	The number of bits in a word
  *
- * Returns: 0 on success, -1 on failure.
+ * Returns: The old word length on success, -1 on failure.
  */
 int spi_set_wordlen(struct spi_slave *slave, unsigned int wordlen);
 

-- 
2.45.2

