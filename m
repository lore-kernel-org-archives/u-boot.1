Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C4606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zy+DI4LX;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=UVETEtVZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A83680D88;
	Tue, 17 Nov 2026 09:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q1TzWq9ECmNK; Tue, 17 Nov 2026 09:37:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB47580DA1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794908268;
	b=psZeLcQaTlsSLqOKSA3C1LulNJC7VjDbMF/D9xVkCY9XW1mJGG16YU/xdtaPqCotZ7ux
	 4du/JyJNx1ZAgnIpD9u/szf6NuNKkWA8VJXMAHgV5VpcCB1uHMWCX7bXtiLzO57Bu0BUd
	 9Pqw+k/X3AIKuhuOkvvfnXTrrmsnhhHiLX1RqmS6w1hJifPTy5OKkkY7RJDb0Di9Iz3N7
	 HK9zCJrnY+etp5YWU1pq0opIvCoxTaEBBsoU3qpsmoyyQnDLB16d6kgIzBGAIa5LRgjVx
	 fZwR2BH07Kz9nfXPLyIXNVXwGW5tiFCJdoSevpgDnOMTMXS8fxRWaY6p2uz7D6Myr2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794908268;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aIQt9zULO3WSnlBEoO9LUU54dZOS/xzFpxGAsXJe08M=;
	b=sbESnrUbyXWD0ZaKA61eh+9pI2A0boma9lXJ+56mlx+glUBxtmUdMJFeZf4E9V5ObNny
	 6ESGFAUaUgVjXHWxi5fWQgSdqtQNHIdCsnJEa9Bl9LTPTgFDKHs1/C6ZDg70Bcp1CAeRw
	 QsJYvYKAnsARTgM/kBq9cKSGDFYtj0rDbOIljhFxRf3D/5fYXvv0ckzZeW7DWnup3uYe1
	 D1Z4uDHy5RPDvLOJIgg2AEw2ApSEfhpKjaC6dwl/ODxFDQwhWC3tgiE9ZoZNco5HWT7RY
	 +RYkUAjO6/7IEpUjW1cu2BhGMLfmPHtA/2CxzP1RvDK8wzXhOUSLvv2+54A3QtwlCag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=fris.de;
	dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=UVETEtVZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794908267;
	bh=aIQt9zULO3WSnlBEoO9LUU54dZOS/xzFpxGAsXJe08M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zy+DI4LXu3dwV6baSp9yt6OSLnxfAldwZa923B138b3MsZ5LyvZDSybFMf7dRC+Qj
	 RJ+49sdIarTlJrlP+XOaERq2ocqMeAi13t9Dxf0w30xVjBuDhcApgNokf7v8NpHySU
	 2mAFU5LMg/H4jtgzLaWjfhzrCVXAySPGcEJMjEgLQ2QceNNOZAt096ESLDXJDRdGEk
	 w+OeqR+uR5HOG+lq4UZo0IcT9ZKVaB0mm5nRLxeeq82enrqvsBMYgTi44w7ekfn2ah
	 0agyM4UDqgEhVe2SKZcvyN87iLnd9sv2C07WJvOR2LLZ1QyXm6VChY62OZafvjGufu
	 s2uWaybi8J11g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB47580DA1;
	Tue, 17 Nov 2026 09:37:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 083688F1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9F9880DA1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4fycPzMhTYpN for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7C6D80D88
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=UVETEtVZ
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7C6D80D88
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:37:43 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1794908260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aIQt9zULO3WSnlBEoO9LUU54dZOS/xzFpxGAsXJe08M=;
 b=UVETEtVZTpyQfPJ/OSxI5HMlauPGki2Fp9fjrZlrXC1Yip8mXMvhJzX2ziDbeHGbhuSyP5
 8JfVFmP91NPhT3rxgY/cZGvsz25JwLonmf/QT6h67JYLPwv7LQZ0YmP4wnJgZJSml+cRwz
 MCUjPdHqNprJR4ys1I8MK6KV7mHKe1OethXeOgom/dPnoJ9IeLITANZP/1lWkdRYhXLClW
 qx2ebTi1h/suLwXs6SIInyfuxFsVFq+vqM9NLGviEXaGh6hKsBeGo4IK1Ed0teXk6jILDZ
 I1Mp+voFJxzkD4Vxc23It4HR1V6oVLAoNbD3Ax4A36tvvZadAY+Xya5UszbZsA==
To: u-boot@lists.u-boot-project.org, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Cc: Petar Krstov <petar.krstov@kontron.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alain Volmat <alain.volmat@foss.st.com>
Subject: [PATCH] i2c: stm32f7: Fix zero-length transfers used by i2c probe
Date: Tue, 17 Nov 2026 10:37:24 +0100
Message-ID: <20261117093726.582644-1-frieder@fris.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Petar Krstov <petar.krstov@kontron.com>

Zero-length messages (e.g. i2c probe) skip the data loop entirely,
so the driver never waits for the address phase to complete before
handling STOP/NACK. Add an explicit wait for TC/NACKF/errors in
the zero-length case and initialize status to avoid using it
uninitialized.

Fixes: 3bf699f7a8c6 ("i2c: stm32: do not set the STOP condition on error")
Signed-off-by: Petar Krstov <petar.krstov@kontron.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com
Cc: u-boot@lists.u-boot-project.org
---
 drivers/i2c/stm32f7_i2c.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
index 3f51b1dd1db..cb4e2eb504b 100644
--- a/drivers/i2c/stm32f7_i2c.c
+++ b/drivers/i2c/stm32f7_i2c.c
@@ -420,7 +420,7 @@ static int stm32_i2c_message_xfer(struct stm32_i2c_priv *i2c_priv,
 				  struct i2c_msg *msg, bool stop)
 {
 	struct stm32_i2c_regs *regs = i2c_priv->regs;
-	u32 status;
+	u32 status = 0;
 	u32 mask = msg->flags & I2C_M_RD ? STM32_I2C_ISR_RXNE :
 		   STM32_I2C_ISR_TXIS | STM32_I2C_ISR_NACKF;
 	int bytes_to_rw = msg->len > STM32_I2C_MAX_LEN ?
@@ -432,6 +432,21 @@ static int stm32_i2c_message_xfer(struct stm32_i2c_priv *i2c_priv,
 
 	stm32_i2c_message_start(i2c_priv, msg);
 
+	/*
+	 * Zero-length message (e.g. i2c probe): no data phase, so wait for
+	 * the address phase to finish (TC on ACK, NACKF on NACK) before
+	 * deciding whether to send a STOP.
+	 */
+	if (!msg->len) {
+		ret = stm32_i2c_wait_flags(i2c_priv,
+					   STM32_I2C_ISR_TC |
+					   STM32_I2C_ISR_NACKF |
+					   STM32_I2C_ISR_ERRORS,
+					   &status);
+		if (!ret && !stop && (status & STM32_I2C_ISR_TC))
+			return 0;
+	}
+
 	while (msg->len) {
 		/*
 		 * Wait until TXIS/NACKF/BERR/ARLO flags or
-- 
2.56.0

