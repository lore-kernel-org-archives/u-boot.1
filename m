Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28760CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A4484CB5;
	Fri,  8 May 2026 14:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fftXbX9t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CsY7AcS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4283784CB4; Fri,  8 May 2026 14:23:08 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D548488B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBpDV1fy5z9vCl;
 Fri,  8 May 2026 14:23:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3xJOezV8D33GYATv3okC4w5+8KVxzPuSsyH18YhvNs=;
 b=fftXbX9tZMIJc/sNkB3CY+ryIJaCL8KjRepqbLzcGrXJQaUCOS89i1Vb7hnVNi/Wp5O1LH
 aI1PSWvFGJYJcVIlnWhIApnr2MWVVz3FipZZW6Iurt0uM7NWvbcpfatZTaddpsfOQLepL/
 KNr6gmXpkpbZYqIhwwWfTru9b0iMBIcehbR6hDGPxK0yIyZVw3iupt/OeBYUxc0Rq5b2AU
 6AvqR40YEHB6EwFJk625TOCjP4whMAqj1U2PzRddQI9qFXMtrt4tIEqY9Eei/nXlVREOmS
 magAg94GY7GVW1ZLMzcu4VCtQRoDi4PONOGWEnMGg7bWfmqRBJBcqGJeV6XMRg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CsY7AcS6;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3xJOezV8D33GYATv3okC4w5+8KVxzPuSsyH18YhvNs=;
 b=CsY7AcS6u/pkMEawF7Gp3Cu7mLHzCg8WUGkhLmO9DgjhlDNMH4vf9N+RecvKO27qV32yfh
 eISdij9K03hPkSU/ZgvxMRcc30O2Q/2xRfqU8bHz7WnFaA4WPFZPcTTyv7lJLcMpglQ3R9
 mpc1b09BKt5xn8C6mSNgoDk6Te/Mzysfx6uFDd/QqhuskkNJtXxeAHpUx7PV/MkUaf9P64
 xY6UeO5fzY7Pc++AE10tMIaB/1N8JqHfysCWIxVIhTEEiXj5mp29/iZifAnRZQu9vIzsLk
 /mIbkS9fKqyP2ypf/Jxc7qm54iDqMpqsQsnbMvHAPH83UtKo8CN6IoOFex31IQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/14] power: domain: imx8mp-mediamix: Staticize and constify
 driver ops
Date: Fri,  8 May 2026 14:22:06 +0200
Message-ID: <20260508122247.512862-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cc662b7ffb2b463680a
X-MBO-RS-META: 8dgdxynmjktqne6xyoept8qiqjxad4wo
X-Rspamd-Queue-Id: 4gBpDV1fy5z9vCl
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
 drivers/power/domain/imx8mp-mediamix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/imx8mp-mediamix.c b/drivers/power/domain/imx8mp-mediamix.c
index 504c22f7d36..66ea5d8e60c 100644
--- a/drivers/power/domain/imx8mp-mediamix.c
+++ b/drivers/power/domain/imx8mp-mediamix.c
@@ -194,7 +194,7 @@ static const struct udevice_id imx8mp_mediamix_ids[] = {
 	{ }
 };
 
-struct power_domain_ops imx8mp_mediamix_ops = {
+static const struct power_domain_ops imx8mp_mediamix_ops = {
 	.on = imx8mp_mediamix_on,
 	.off = imx8mp_mediamix_off,
 	.of_xlate = imx8mp_mediamix_of_xlate,
-- 
2.53.0

