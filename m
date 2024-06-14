Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477C1C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B616B889D7;
	Fri, 14 Jun 2024 14:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="y0guYoHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D968F889E3; Fri, 14 Jun 2024 14:19:54 +0200 (CEST)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D7E889C5
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: jagan@amarulasolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718367592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdjQ/sNEYkqXz5nUiDB6l7pnOHwLgYY20k5O3F6c/1I=;
 b=y0guYoHxq0E28/b/BsaGXtMtxf/al4tF6Ld1GPENkclhRYMCLQkmfC2wpd2g+9IUVDYWN2
 ILTyQnl/1PG4ipBymD+1Psj+vOAXgimeRRxDoSO3aE9kQ0GPK7f+pSS3jVEFJz3Jvr94/u
 IWu8AbtRjG14Z13+inzPwAK8mCkmLN2IQ7qX9QkBKfWNax00ZuV8GA3a9UmGBKr2s6khde
 zZSuT5cMTjZ8/wL7jTgY2Ab8Toa5vT0KVmvESK1+hdTDZKlmDAFFI5Ra/vcy8pQUcd5vYc
 Evc9l6BKc8IIjGyNDikb5t+oekVBT6A2q1CP9+KvW+wCHON7H/90EWmvQGRasA==
X-Envelope-To: agust@denx.de
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:18:43 +1000
Subject: [PATCH 3/5] spi: Implement spi_set_wordlen for driver model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-mipi_dbi-v1-3-946eb82f8533@jookia.org>
References: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
In-Reply-To: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718367546; l=1382;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=I8RuEJ8g/cBh8hAckeVnNnUKcdafw1PPjrDVQFThuUk=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAYpUwJ3KhyWHIu5BglUcvyo9
 46fPfU76riOOMp/j/EmDPCJ560X0GCEyNtGNWd1mBJr4vmgXTaOfCz9DX8eYACgUAAP+l
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

Implement spi_set_wordlen for driver model devices.

Not all drivers support this interface, so we will assume the default
wordlen is safe and allow setting that unconditionally.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/spi/spi-uclass.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index f4795e6867..c2baf9a262 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -130,6 +130,35 @@ void spi_release_bus(struct spi_slave *slave)
 	dm_spi_release_bus(slave->dev);
 }
 
+static int spi_try_set_wordlen(struct spi_slave *slave, unsigned int wordlen)
+{
+	struct dm_spi_ops *ops;
+
+	ops = spi_get_ops(slave->dev->parent);
+	if (ops->set_wordlen)
+		return ops->set_wordlen(slave->dev->parent, wordlen);
+	else if (wordlen == SPI_DEFAULT_WORDLEN)
+		return 0;
+	else
+		return -EINVAL;
+}
+
+int spi_set_wordlen(struct spi_slave *slave, unsigned int wordlen)
+{
+	int oldwordlen = slave->wordlen;
+	int ret;
+
+	ret = spi_try_set_wordlen(slave, wordlen);
+	if (ret < 0) {
+		dev_err(slave->dev, "Cannot set wordlen (err=%d)\n", ret);
+		return ret;
+	}
+
+	slave->wordlen = wordlen;
+
+	return oldwordlen;
+}
+
 int spi_set_speed(struct spi_slave *slave, uint hz)
 {
 	struct dm_spi_ops *ops;

-- 
2.45.2

