Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1208C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DDB888B8;
	Sat, 13 Jul 2024 15:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SFTBYvZ3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vqYKYVDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7EC888B0; Sat, 13 Jul 2024 15:21:34 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F4F888A4
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WLpyN3HpTz9sbh;
 Sat, 13 Jul 2024 15:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6nh1XVlrte+e7bR5+2kFOJ/uEdqspSxYcjj4TfGnlYI=;
 b=SFTBYvZ3M1Q2jRjzt6dLHFHUiEKRlUlrhPIrpL84BafRDWZ/p8ypUgvZ/IniSP10DnKxiq
 2cJ0p5Lo2BfgqWUsDf+8am57rwvSCGmuh+2VxeqnJ8TZXSB6px0PlQV5ksKEhUlEgvxVFP
 p3dSmGKJ0d+L43X5xDKVizMxskzcz+t0tnPXi+Aq4aywA+QEtASOATwd+iedh6UHfz5g/J
 TwjFxLFTr/XOvu+wsY5tVBKWXsDaKbQs3Q3Yn4gcUv3lEdstqSmdYt32Nm4Wd+wLEGvypu
 LwRYcfsjBU6ON81DbDsxTxZfHoLbRvRmkpekfkws1RVSqKr4MtIheKVkucbBtw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6nh1XVlrte+e7bR5+2kFOJ/uEdqspSxYcjj4TfGnlYI=;
 b=vqYKYVDoAit/8vAVSh4p/fxtjTVbypMkKQI9/IjewoolEfPFE8nBKknPyIv1ASgs89HQvJ
 L8n3GV/fRvMr/TqACE0biQpPvoKROEjLPqpiFWgnGiA6TyTv4KvWYcg67bkGdZR13cDD79
 SYCz6YUGeiVBywz21/EoiMkrX8LtTAedv3QYpT8YvBAahy9HCmRcTlWW/OiG27v6zPyMFd
 BcIpadv1Ss7fVuo8P3mqLO4nRk8zfbZU9+geZtPXrwuNXpkg6UT+Rutm84Rh44i/gdTGfM
 C5nTBumaQUKWOhqeAz1vWeUrjhhZjbBdPsN0pZVQTInAUC6SthBXwuai9qMugA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 24/45] boot: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:15 +0200
Message-ID: <20240713132021.57650-24-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1af9afdf2febc6fa392
X-MBO-RS-META: msxgsej1knryjx8d9z6g9wi8zqjdaxsc
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 boot/pxe_utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 53d6cf700b2..4e27842b088 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1470,7 +1470,6 @@ static struct menu *pxe_menu_to_menu(struct pxe_menu *cfg)
 			override_num = label->num;
 	}
 
-
 	if (label_override) {
 		if (override_num)
 			default_num = override_num;
-- 
2.43.0

