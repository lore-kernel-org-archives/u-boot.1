Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867CDEB1076
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D4F8409A;
	Tue, 10 Mar 2026 16:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="GCpK0Nwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947D8840DF; Tue, 10 Mar 2026 16:58:55 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC6C84090
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202603101558537718c0392800020717 for <u-boot@lists.denx.de>;
 Tue, 10 Mar 2026 16:58:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9pDs4ZRGm9i0D8OIgK+DavHrWiG5FoItQi05ZJvhM+Y=;
 b=GCpK0NwyCkwNx6eV9PsEKWAqEhdYg4UBw7sdt8x/vIkFq5B7nmTf47LNq45wYW1eD/EMwF
 aIU7+rOM9SSxyz4Mg/YFc1kpoNXzPuQ/XgAeD1tNxepTfxZQkva6TEK+sMJsj/AtDFQbM3+7
 qqskBFqrSr9ZHrAUf2mqFlZft/EJQaB2WjKX44+JucVAy6foDV5kHzmPtPefaGyuBhFAHq3d
 bS1bbHRKWEmnLz+/tndH7/lTbUoHRDXn4F0a+lqy7kM9m5zIYtipKghSlwU39PvlXyhYqSoE
 AgOlNQpbwa0QOMi0/+0Q0HmqenNGRBFSHw+pl6ufTM+UwvCryOPsUMRQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] Add back debug output of hashed nodes
Date: Tue, 10 Mar 2026 16:58:26 +0100
Message-ID: <20260310155841.126525-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Commit 2092322b31cc ("boot: Add fit_config_get_hash_list() to build
signed node list") removed printing the list of hashed nodes during
verification. Add it back to have a chance to compare the list when
debugging.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

 boot/image-fit-sig.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index f426ead13c0..e7a768b9add 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -476,6 +476,10 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 		return -1;
 	}
 
+	debug("Hash nodes (%d):\n", count);
+	for (int i = 0; i < count; ++i)
+		debug("   '%s'\n", node_inc[i]);
+
 	/*
 	 * Each node can generate one region for each sub-node. Allow for
 	 * 7 sub-nodes (hash-1, signature-1, etc.) and some extra.
-- 
2.43.0

base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
branch: patch-signatures
