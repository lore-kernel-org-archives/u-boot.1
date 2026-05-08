Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DADCD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 799B984CD1;
	Fri,  8 May 2026 14:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PfGsI50B";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RrOoUnJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6396884CCF; Fri,  8 May 2026 14:23:24 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517048488B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBpDn1HLNz9tsN;
 Fri,  8 May 2026 14:23:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Is/+SkyWghA6OWnlV8R/jgihd6pPGyZABIHvkNdxsdc=;
 b=PfGsI50BEH6QKBVakR8bfdUUxD7uGVrAb/9XCk+pCaGwEuJ8KVkdGQPl7l8MqQeR1dQ0Mc
 Vxd131FUzljePvn+0LECSE0JA7InYQyb2gpOsccEPivGBfSPy7ABlJciewLHnM6BQv5CH7
 DFuko3wJUw5RK3sx/gxreALoLAi9SvwQpnLV4pIiDj1g4zT+q2BbSdxRlkfaW5MVjCxQ5D
 U3EiA8QkH1IzHh/R2tx0RNCuq3MpSUtm7Hl7cbsHmtnvSJfi7SdwIadG3wL7Q6rM3RkX2b
 Wl76WaVzD6V6+49U7C6HDYZC9/aq/eROWtICjyE/IVtL+ANU525+ZSnEc6DNJg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778243000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Is/+SkyWghA6OWnlV8R/jgihd6pPGyZABIHvkNdxsdc=;
 b=RrOoUnJWkD228Wq5NelgJXkOwKV5c+N+szwJQVHVZn82j585mwNmpiIU3it/erKfCIbWTq
 FFv+SX29tcikfNovFnrmhXT6NaRqFuBYosh5oSvRrwljrva1PoP7yfecWc+4jY/5p3CiK+
 O61suW8rQmy6WhedmsO2sAgQCe96R50oi8uVIxGdVbRQJjrQoj0aRT/+S4voY7oIv8Qafu
 EUViTlCnVlKUQ5K8JNqyDHalEDMsAXH6JIr3+SSFrpr4I0IB6AilIWsaHsyvjH2zfIHpkh
 kaW85n8Gf1jbt1zv2bGWYoz/YTOgpcsHaNvb+F6gnCWImtcPtBkQMk7zoGPWiA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/14] power: domain: sandbox: Staticize and constify driver
 ops
Date: Fri,  8 May 2026 14:22:11 +0200
Message-ID: <20260508122247.512862-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2d0e205f8acdca1cafa
X-MBO-RS-META: k5mmgcnjou3zjuh9kfxwhm88k6h9jehw
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
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/sandbox-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/sandbox-power-domain.c b/drivers/power/domain/sandbox-power-domain.c
index a8031657638..a30826a3b4d 100644
--- a/drivers/power/domain/sandbox-power-domain.c
+++ b/drivers/power/domain/sandbox-power-domain.c
@@ -78,7 +78,7 @@ static const struct udevice_id sandbox_power_domain_ids[] = {
 	{ }
 };
 
-struct power_domain_ops sandbox_power_domain_ops = {
+static const struct power_domain_ops sandbox_power_domain_ops = {
 	.request = sandbox_power_domain_request,
 	.rfree = sandbox_power_domain_free,
 	.on = sandbox_power_domain_on,
-- 
2.53.0

