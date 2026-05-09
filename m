Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EFDCD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AD784CF4;
	Sat,  9 May 2026 17:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P60Ow7la";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PU19773M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC6784D13; Sat,  9 May 2026 17:13:19 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DCB84CC7
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gCTyN6ZmZz9t5H;
 Sat,  9 May 2026 17:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nBxbZf1/zT6amR2O6yVu0BOofLyZ15QEdacEFEqbVqc=;
 b=P60Ow7laceHqvS05JhmDeNgVkdnw5QqCyRqbVKzxWk3ymor0fHE/ERIqbdKY6TYvb+5ISF
 fSy77tM/3X02rVexeVeMB/yaCdTUlMLTf5HXY07nD17d2wWEKmQLL2DJkrgoPpqJFpx1Su
 cM6kMYI5Q08EY5MKh3tLNQwm/13GDDD5t8JnrVax7V2vevzlAZDgvjIkEZgUmbxmB9tyE2
 QVGC4m+sYqJlItpvhQMz6ClaTzrh177XXCMbO8+oleNvt0lxL3ALHd4yR/bXcH30qJBbpf
 GjvXXMHzjEmQbB6jfP35Mp5RKl0euyAt+CAsW2AU0T2kwXOsCEhZ0r+Milrw0Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=PU19773M;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nBxbZf1/zT6amR2O6yVu0BOofLyZ15QEdacEFEqbVqc=;
 b=PU19773MxtozzWbeMqCFo77TicE4aqQj2mx1cOP0gceH2DSEBaWKi3PO62gyVmXjKdAMXa
 okVQZCqw2Sj7A+lLBB2axjoZeTmZvwm+7MRr8tPbIvA3/IXfksQ0kf7iimQYy2vjFSAPRi
 kD9MJQWYAsMUgKFvAy6/sG3/3MpvNrtxbZimyCKmrhKcR+o8f8f4/Nq6d9qKJzzFHOdymi
 9+gJ0NHoaWJ5Qdjd7lurBxufV88+KN9X7htG1D78qmJNvBoo2cJ6pX882RlfhAFbvmCxE7
 HsE9F5GRULD1h4yNPRm3w30d4v7i6OsE/ZnItiEOR4i5DaJpTefxi/K2tcJ9LA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/14] reset: ast2500: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:24 +0200
Message-ID: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 651a5feef877c9d95c6
X-MBO-RS-META: a3udn6nozsyp9cmnpyypseobsmpwsjb7
X-Rspamd-Queue-Id: 4gCTyN6ZmZz9t5H
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
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/reset-ast2500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-ast2500.c b/drivers/reset/reset-ast2500.c
index f3543fa8cc1..39b3d025713 100644
--- a/drivers/reset/reset-ast2500.c
+++ b/drivers/reset/reset-ast2500.c
@@ -91,7 +91,7 @@ static const struct udevice_id ast2500_reset_ids[] = {
 	{ }
 };
 
-struct reset_ops ast2500_reset_ops = {
+static const struct reset_ops ast2500_reset_ops = {
 	.rst_assert = ast2500_reset_assert,
 	.rst_deassert = ast2500_reset_deassert,
 	.rst_status = ast2500_reset_status,
-- 
2.53.0

