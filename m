Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF360606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z7hrYFPb;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=LvTvnEDg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B83D4080C;
	Mon, 16 Nov 2026 17:41:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0Do6vWpyCre; Mon, 16 Nov 2026 17:41:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D21D1407FA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850908;
	b=XhSFNtxB283s9ojO+h/WMUeywFFpp7ZSYCnORIH7hNyYDjfri4kuyuqLBDzl17D0TxBV
	 CZrKWDed3Mag5ju751iKKf9tJo45Z1ppXOk56lA/O3lhbVk7bxuzfxJ2WC8sD3ZTF2Jdn
	 vBiw6tXN1oQkxm76/hEgze6k68wkfBhvojZ0NI7A1OOkFxXCY9NsL4dgHXN4RbS+sin19
	 XevuiciRE8VyP7dIwhxl6tfQRlJe4wwHRnvNlUmQGID5wJPO0mX5czEopUYFtWyCrT4tm
	 OmL+O22oG1FsNFR3OBCIMo6U46csPzuYlCP6bn+3ooVoRA3dwTZ2i5ru4vMvjON2cjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J7DKNuVDZrfInGHGd1wjCKHF03QITAuJPSSLTIN/AAY=;
	b=Y2I1ldbdm/lAicpEbTVcYIzuDTjXiqEUjPzw8tvGSaPypw7kOwsYtOytwjhZlZMozDvK
	 OTpYMbmxN/RBPbkjGn5TaL6KzRv9ctUK3JpgV0VNKNFGTQ45ntAknY8bFKGn7i5DrQbY2
	 O01FG7l9k927h1Cghe/KmPOxYQEHHWXrsImHe7SBJR7LgFPKbb//264xu+iKU8LkGxBIO
	 m9Cy0nIhPwF5+L6es2Ls2W0UQfzLITu7aIvfo5uLXHkIk12Nhsi0P1uUP6qzPnKdtm5Q7
	 YJEbH9cW7JOcL+i5d2w7dl0kbmUvSeJkMUjaTx6nGvsy6mXPaeQNCBXa3Foye4ipp9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850907;
	bh=J7DKNuVDZrfInGHGd1wjCKHF03QITAuJPSSLTIN/AAY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z7hrYFPbvIoaVYKpyPRay+NOfYyQuqc55UmlzwF5RqgaTmNhmDdSP4G8UewS1uT7l
	 BF2nR66mWNpimDr/y2X+xEzC72r0Vq0kdWG4z4RGZzoGF1ufAMGL9V4Bj/b1GFJS7w
	 9KVDMzBHWoCYjK7l0Nkkke0s2MTlhOrM6uE1/MksMdyo0FLj8ruxu45zwKPpNCFTug
	 cDseeiA4SVvOvAx9lIRrOJ2H816mY2907512I7wzTr/azhua8F1mLOdhWtBzqmooN7
	 ztpkVOg9nlHtCD4qvvcStfEj9XAZn2K592UsD9g0HWVFSF9usOi/V9qgZEtYq+fg5i
	 4RqPWu+F6PU/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D21D1407FA;
	Mon, 16 Nov 2026 17:41:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2E982FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E46E14009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T86EMMaVVb2n for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:41:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0D9B640282
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=LvTvnEDg
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D9B640282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:44 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSwCT59P7zKr6D;
 Mon, 16 Nov 2026 18:41:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J7DKNuVDZrfInGHGd1wjCKHF03QITAuJPSSLTIN/AAY=;
 b=LvTvnEDgsLnwz8jql9lc8I2G8iyz5YAc9aXX56rmyawpMtAaWocyCNiowsaFr7j+Tu0kyn
 n+vm/fpDBKu/0onFwbXUMWqpoLYWqimVm70P8oq+gOaSbhD8IBWt8wR+n49DSPToxkex08
 e1j1VsQ2v93NEDMAsKA9mucxSQXc6wpAmB/PsroWQUF0hqsi+M0hQ8kW5UQwtsK6J1XUgG
 TA7RIALigh3bMJkg+0FCScjJZzH/gEY4ZTfmQkuwj4moVoPEc/7VB8bxNNlCaDO9hR4MpA
 v9jiLwTrz/7vXRBJc9FsE5X6dTFFMM9K7SbBkRuxDTGhTA1sBy2MVGxZax5GqQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] power: acpi: Constify driver ops
Date: Mon, 16 Nov 2026 18:41:23 +0100
Message-ID: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: aqd6333cyi3k5316pcws8otswmehu4i1
X-MBO-RS-ID: a22360a7efd102655dd
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/power/acpi_pmc/pmc_emul.c | 2 +-
 drivers/power/acpi_pmc/sandbox.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/acpi_pmc/pmc_emul.c b/drivers/power/acpi_pmc/pmc_emul.c
index 8eff3d9fa7a..cfbe6e22268 100644
--- a/drivers/power/acpi_pmc/pmc_emul.c
+++ b/drivers/power/acpi_pmc/pmc_emul.c
@@ -216,7 +216,7 @@ static int sandbox_pmc_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_pci_emul_ops sandbox_pmc_emul_emul_ops = {
+static const struct dm_pci_emul_ops sandbox_pmc_emul_emul_ops = {
 	.read_config = sandbox_pmc_emul_read_config,
 	.write_config = sandbox_pmc_emul_write_config,
 	.read_io = sandbox_pmc_emul_read_io,
diff --git a/drivers/power/acpi_pmc/sandbox.c b/drivers/power/acpi_pmc/sandbox.c
index ed1bb198093..b6265c48cf7 100644
--- a/drivers/power/acpi_pmc/sandbox.c
+++ b/drivers/power/acpi_pmc/sandbox.c
@@ -76,7 +76,7 @@ static int sandbox_pmc_probe(struct udevice *dev)
 	return pmc_ofdata_to_uc_plat(dev);
 }
 
-static struct acpi_pmc_ops sandbox_pmc_ops = {
+static const struct acpi_pmc_ops sandbox_pmc_ops = {
 	.init			= sandbox_pmc_fill_power_state,
 	.prev_sleep_state	= sandbox_prev_sleep_state,
 	.disable_tco		= sandbox_disable_tco,
-- 
2.53.0

