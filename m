Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE1606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UQlT05iw;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uVDER+Li
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A2D480DE9;
	Mon, 16 Nov 2026 17:34:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atWWVCv9T6uX; Mon, 16 Nov 2026 17:34:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6915C80DA6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850449;
	b=LQxc7DMsCtOsUnD6P62XpSz2jrGGlqsoV9fN1OoIc5XuLltyE/7QS65XUuGFNlLMJApz
	 jCIcUiKtbxGV9evq1iPeMQTTSDBN5/JprhuCpPWGyMZe0g637eIY7pO8xr/HW7ATGEHu3
	 QX9t2dsE10t+9rLQr0SpvzcqhFAet/5Yke4cH2a8hCHZbxT3Rkh6HEUwIb//2vXiRYgTi
	 yMWN4lew5D4soIDbQXBhbR4t7xmT6alWQlbDVecFRpxP8PkF1egUyZhOyDHluPt3jJ8Gp
	 Dv94iTaMsw7If7/CbGf53+8oaS6HPXOle75qcHhjqGba4T+ZB9z6jhP/xYUIiOQbqXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WYFcpE0dN3mZNkjVaiplqrfIuHTMAP1gXqqgbLYAz9k=;
	b=oQfAAT1BXoLqnXU5YltKgN9aGCXfTlF5g/pKck9SPqzjDCWPOs89r8zogLG6U1txHv+8
	 HgtFAMIESeX/mqlW/cc4gSOlMPzZA6rCDIeGwW+LO7Lozo6Wlpn8vJwi4awAHS14VJHPe
	 0sex61MrwbfhMWzSPAs35SvwkQY09kmnewHDxIU/7qyQaSqaBBde9wok1tfCnqbfTf8TX
	 BCshXSJMwt2dDnBepdFRVIHoewE/AQwsFbq6Jf6gIAQq9drNWHMc+YoueXsXQVDMeh7AT
	 lYg/x4TcgevpkVwO3HoMM/rwZ8wCzWawzBJ4f8ceJ7/1mr2FLt0mWElCCC0JRYTgpQA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uVDER+Li;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850449;
	bh=WYFcpE0dN3mZNkjVaiplqrfIuHTMAP1gXqqgbLYAz9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UQlT05iwSham8AnUQFzEtgJq3vScIOzcsPbHGINK9oYNSIzkzOawGTSrNS0WtLrIg
	 2Zl+QHEZLrqss93vgUu+5fV798Lj2QrSFnt7Lt0tNu1+m1Wg+IVBAdpLBiqsAaOuo/
	 6lKFA+1GZBTgMSGUf8pamPD8/2VaXy7nxHZ1P+j3Id6oxnnYmPA8P7zl2ZzA+3/ZI4
	 6yCh+QSReeMdT5tsQPfoETcOafSawlIwtVyB/kBzyxvD/FGKMURZWsACDV2xIgBdPo
	 RDnSkWqDZXpxTu7c6qtPuv3cSdaSqR/ENL/4yFyvjYtNYJJEwXTH4VodtrEbW1cg8S
	 eYBOTCKq+27xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6915C80DA6;
	Mon, 16 Nov 2026 17:34:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B5DC28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1228C80D49
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bO2PxKWMVdhu for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:34:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2FED180D4A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=uVDER+Li
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FED180D4A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:02 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw2c025PzMlwJ;
 Mon, 16 Nov 2026 18:34:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WYFcpE0dN3mZNkjVaiplqrfIuHTMAP1gXqqgbLYAz9k=;
 b=uVDER+LiI5OHkj87YZoQH7yDSB5LA1sEh4x0ag1kMxfhEJYoJN0ikcLgdEaChzUaxdrlBS
 zV6Wa1N8VWW/linv9sFVgBWDjdFPXHASzEGkR62hwAr4DsIBMiV8I86y3Yh1IMq7AiN6WI
 tog+nfFskpC9iqCjk0u4S48ackYUAAEwSgpGcnJSweOjvf7g2BkP8dUvJILTVSgOI8i1RO
 RlfTrp/pnamtWzJRwNyLIl6rZWUpqHzXDnyzPBa9R0RsjlnaLd+4vyWgqlQfalg/ij/6Y0
 UOZN9/D2dD2yIMhsQqVgQwHnu0JUr2y8ku2xeIAmd0fiqX++vQWavNt/xFPC2A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] spi: octeon: Constify driver ops
Date: Mon, 16 Nov 2026 18:33:34 +0100
Message-ID: <20261116173354.3487744-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173354.3487744-1-marek.vasut+renesas@mailbox.org>
References: <20261116173354.3487744-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ac679533290981204f8
X-MBO-RS-META: 8t55r1po7owpfybx8n9wxputiau8ft69
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/spi/octeon_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/octeon_spi.c b/drivers/spi/octeon_spi.c
index ab7c5673df1..dadb8464dc1 100644
--- a/drivers/spi/octeon_spi.c
+++ b/drivers/spi/octeon_spi.c
@@ -550,7 +550,7 @@ static int octeon_spi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
-static struct dm_spi_ops octeon_spi_ops = {
+static const struct dm_spi_ops octeon_spi_ops = {
 	.claim_bus	= octeon_spi_claim_bus,
 	.release_bus	= octeon_spi_release_bus,
 	.set_speed	= octeon_spi_set_speed,
@@ -562,7 +562,7 @@ static struct dm_spi_ops octeon_spi_ops = {
  * Octeon TX2 needs a different xfer function and supports
  * mem_ops
  */
-static struct dm_spi_ops octeon_tx2_spi_ops = {
+static const struct dm_spi_ops octeon_tx2_spi_ops = {
 	.claim_bus	= octeon_spi_claim_bus,
 	.release_bus	= octeon_spi_release_bus,
 	.set_speed	= octeon_spi_set_speed,
-- 
2.53.0

