Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E2BE6BF31
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 18:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D9984535;
	Fri, 30 Jan 2026 19:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="CXIBJ1jG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F00B18452D; Fri, 30 Jan 2026 19:04:41 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC11583C30
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 19:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1769796266; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UJiWMeW7sh9+InIXx9L7/n/aNsoXIWlkZKmii79XUP6ltM85VZ8/a3+Igevfc5qvofZL7oLI1zCQ2x+V0Bq0SEDQ8ub8y4xd85xJE4pX3DkUg/mjRhshbJn0ihDc+KZ3sNAxEjVkGQf8u58eYXVjGcbGllMqybvA6VdOTNgU804=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769796266;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bH4p5M+jX8HEAYsb8KsyibNTT0e/ie/zPTM08cGXSIk=; 
 b=BsGznxDWQ9TxX+CMIX6v97eFcyOfT4B7DeBPI3cGgdsbUALOd8ybq+1vW1bYZYD1WW3flCoIGfXBkI44B0CR/PH/haEMxyaV3jDYYpvhHud1u64nxzf550E22skK89OC/TkXla0D62XznSTud9Jj67Idel3a1w1rfupurJZJyZM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769796266; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=bH4p5M+jX8HEAYsb8KsyibNTT0e/ie/zPTM08cGXSIk=;
 b=CXIBJ1jG7RrlCrua/zXvnuN+9AY4OeVR/M4II3q7/FGgfgqnsF4yv/voI3n4fY25
 7kfC+EtIjjbukeNCISzlkrUKFuCJr1+FyOrRMxMCdpPSPrB2Jk9KrFakeulMMpS70Lg
 biCKFkUq2DEly3RFJTt3L7FRyVn0WQdQ+AS9gkgs=
Received: by mx.zohomail.com with SMTPS id 1769796264573541.4999212104085;
 Fri, 30 Jan 2026 10:04:24 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH 3/3] cmd: mmc: Return symbolic value when part switching fails
 in mmc dev
Date: Fri, 30 Jan 2026 18:03:53 +0000
Message-ID: <20260130180353.42205-4-me@ziyao.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130180353.42205-1-me@ziyao.cc>
References: <20260130180353.42205-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Return symbolic value CMD_RET_FAILURE instead of literal "1" when
failing to switch the partition to improve readability.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 cmd/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 512bd482ae82..bcbe963f8ac0 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -606,7 +606,7 @@ static int do_mmc_dev(struct cmd_tbl *cmdtp, int flag,
 	printf("switch to partitions #%d, %s\n",
 	       part, (!ret) ? "OK" : "ERROR");
 	if (ret)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	curr_device = dev;
 	if (mmc->part_config == MMCPART_NOAVAILABLE)
-- 
2.52.0

