Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C755BCD37AF
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059B884CF4;
	Sat,  9 May 2026 17:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CcfDjNdO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S8oeM4eg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E1284DCA; Sat,  9 May 2026 17:13:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0493784CC7
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gCTyt5kG2z9vC5;
 Sat,  9 May 2026 17:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=V0GR3mkVbpexik+cTfROBNqltWftr3qStsRGLj2Ci0I=;
 b=CcfDjNdOFdIfN8gdQ4zNXs4KfL3UTU4xkJPpMVSpGCHdJ4eOzopAVf0vW3h07P/bzjWGHp
 JEAcUC7ihYxWGPkYfy1UpZNSKPMSsXlJZuC8mzBdz10Y6y3jRHJzIS2hPaAEmy5yjjzQrJ
 +sUy6zgfX8gx7ODjFHKtXWZEREIfQrIwqSmcXlrzXad8P8ZDvRurw5KLW4G/CMK2tcaUb6
 +S6JwkDi/+hwDpKTypzyez6kE1UuABGFFZjG6zVIJfzFwAC3AuSwTl4odN+leoWOjPVhcC
 sasmFLiJQu4FR3IJOMySlp9/BgrPykh0vzMQcJYE1wqzd8A8d60nFznVzlgcdw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=V0GR3mkVbpexik+cTfROBNqltWftr3qStsRGLj2Ci0I=;
 b=S8oeM4eg0ZK/B5WYFzO388IqQwqhzaYNH1dSSeaUTKwch89QueZkXhdgZpG4xuST0EEtct
 N5obBvUe43NvlIDyyE2nYEMc+hg+8FKFX8ccwa5KRVR1ldjUR+ufg+eqzcGUwfCR539ftL
 yL6eC3d9INhesFdz+8yS0ISsEg781ZM/MG/zgrVSWryq8vf5l029o1cC5YPsSiQuAo7wWz
 qc9U/EE0J1mAUJO3fBIdSPx3jZU+/5W6mY/PTu/bY3vNzCugne7BJYHntz3MBECW3JlGS3
 ays9FiYdK6QFCxt3vWysfBXJCY8bENlZC30rqQYrefhO34n5nDcFh9rbKAmUZQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] rtc: emul: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:13:32 +0200
Message-ID: <20260509151339.23116-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4ami9renthzurjb7qh4u8dzi5gbayshx
X-MBO-RS-ID: c12cdd7fe7d5408bca6
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/rtc/i2c_rtc_emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/i2c_rtc_emul.c b/drivers/rtc/i2c_rtc_emul.c
index ea11c72c964..41bdf275f1e 100644
--- a/drivers/rtc/i2c_rtc_emul.c
+++ b/drivers/rtc/i2c_rtc_emul.c
@@ -191,7 +191,7 @@ static int sandbox_i2c_rtc_xfer(struct udevice *emul, struct i2c_msg *msg,
 	return 0;
 }
 
-struct dm_i2c_ops sandbox_i2c_rtc_emul_ops = {
+static const struct dm_i2c_ops sandbox_i2c_rtc_emul_ops = {
 	.xfer = sandbox_i2c_rtc_xfer,
 };
 
-- 
2.53.0

