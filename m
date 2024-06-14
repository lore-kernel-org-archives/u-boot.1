Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42F9C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C0A889D2;
	Fri, 14 Jun 2024 14:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="o6y+qxjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD884889D8; Fri, 14 Jun 2024 14:19:43 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [91.218.175.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1FC1889D2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: jagan@amarulasolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718367581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emWWhDx0/VeL+rLlM4ue4RA7bpk2wRFBXDZ05MQiqwA=;
 b=o6y+qxjmsMsmtQ134AtamCh5RorsZftkF8Un2z/ijt5HZdbUScqnOpHPdGLgroWsfmmsOn
 h58idnD/Z/RDHdAAD6sTUAIYMjpPzHOC5ZKHk7CwaukLssbhyc+7iibGGLBHQhIh39kTn6
 MQp8AoUelUJRBvbafvkq6lmHBe+Yy0CtgcSSinCKV5KfKviCO/iGjZIQ5VKt5OPJD1bmC0
 0yUvm4YUW8rf42larMOCKHpGlOK5nfX62+llIsVcLuoLbghBpL/bUGZ3fUf5v0SgunqZKy
 6vb/58Zdty/gczjGvwgPzrieC93qmigwYmT39Bk4XXCLOKnuAYojKukYO8ZJaA==
X-Envelope-To: agust@denx.de
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:18:42 +1000
Subject: [PATCH 2/5] spi: Limit spi_set_wordlen to SPI_DEFAULT_WORDLEN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-mipi_dbi-v1-2-946eb82f8533@jookia.org>
References: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
In-Reply-To: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718367539; l=692;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=IjR2SlyUYvSw+pzu3vrAhstMW7aXu4RnvA2p8lD7ZS8=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAiRiBz30jfMOLdY4irMLi4rB
 KF3cJom5I5C7AGbFZdJ9KqU3JW7kqk7Xte3HoIYnMnkBj1s12sNb8WdPzBCv6AQUAAP+f
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

We have no way to tell if we can actually set the wordlen in non-DM
code, so limit it to the default wordlen already in use.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3649c9c25b..7be9bf9b17 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -12,7 +12,7 @@ int spi_set_wordlen(struct spi_slave *slave, unsigned int wordlen)
 {
 	int oldwordlen = slave->wordlen;
 
-	if (wordlen == 0 || wordlen > 32) {
+	if (wordlen != SPI_DEFAULT_WORDLEN) {
 		printf("spi: invalid wordlen %u\n", wordlen);
 		return -1;
 	}

-- 
2.45.2

