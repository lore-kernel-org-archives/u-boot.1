Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956B1CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3796B84B5D;
	Thu,  7 May 2026 18:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="So1oshgU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DL3cPK7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A762384B58; Thu,  7 May 2026 18:43:25 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE6D84B5D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBJ3G26KRz9tV1;
 Thu,  7 May 2026 18:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tCNr2F0dJKpoSe83/+wgKS+QRG0hvODkkFdx9VJBoFQ=;
 b=So1oshgUzDEvE96pMqWnR88V75t4eTLYzKEvylAjqjeHblLAkLXGPcK/a1u995lMPyfUR+
 7Td+74F8AUM5aAOK3Y0m7NOiJwlY6MQKv++WozFrlaUQEgJdyOlDTWFagSZrmfp5r9oua/
 UkDqyu1ZUM4AmYo5S0te2qRpyUkYmNrXUkSZzDlEFe2Eipz2pSWLyxCT4W3ySpEmTPXfVR
 M5YYeZWJsmeM89Pk/9RREcXvl/xKwFtMEReoYpGlQpba/F2liK0UeHm6q0MGcsbKT4NFLh
 zTqflAU4+XVlsh3Qip9Nh7iX2Qm1WiOHOToV6lwa7iV1mf790/fYfcJV4+SWTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tCNr2F0dJKpoSe83/+wgKS+QRG0hvODkkFdx9VJBoFQ=;
 b=DL3cPK7HZpz5v4poPkG6mOGkUl1lkBL6v0mkUlCYdptgfvdTKoOxmC2EEJrTF+2C+uuEWN
 U6t/4AireUgFqPfZZ3AOjAVFJ10sWPbHgnX4O0Ti421CXUOFInXZAHFe6hezavZAIMxLsE
 5hDklz67vNhnTtsI+YvZyPp2rkUjtXVCgwTSe6cSaCYH6WfY0oq79AYtzxewJm0jEmrn0d
 CBHZcU87JvOp+1bE64O+awcIsNxq739mZZphymd6lvn6sgZYUfkOTKpx4y8VaexDoeGZk/
 ooVQFuXq5EjdqV5xVOcRmJttst3Sg94D1Rk5W99tlZ/SSnenvaNz9RvjlA1UkA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] clk: ast2500: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:42:57 +0200
Message-ID: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uoo7cjgatia1kq173rygj6ohtf5x6oat
X-MBO-RS-ID: 09efc6c3202256ef52a
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
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/aspeed/clk_ast2500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/aspeed/clk_ast2500.c b/drivers/clk/aspeed/clk_ast2500.c
index a330dcda4dc..b07d7cd419c 100644
--- a/drivers/clk/aspeed/clk_ast2500.c
+++ b/drivers/clk/aspeed/clk_ast2500.c
@@ -534,7 +534,7 @@ static int ast2500_clk_enable(struct clk *clk)
 	return 0;
 }
 
-struct clk_ops ast2500_clk_ops = {
+static const struct clk_ops ast2500_clk_ops = {
 	.get_rate = ast2500_clk_get_rate,
 	.set_rate = ast2500_clk_set_rate,
 	.enable = ast2500_clk_enable,
-- 
2.53.0

