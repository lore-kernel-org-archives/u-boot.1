Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC9C83F10
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 01:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23BBF86B18;
	Sat, 26 Aug 2023 03:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n1nMt5KP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E945386AB1; Sat, 26 Aug 2023 03:53:03 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8B986AE8
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 03:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2D98D3F6CE; 
 Sat, 26 Aug 2023 01:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693014779;
 bh=r9xIeWBk8f2BkEhZZmYEbFZoSMq0eTN/1HqYSUkMTxE=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=n1nMt5KPYVMX5R+UuNFuG/ZzwZOt5uwNhPZdZWf+VgCEPhZ5Bx22m+83JBxx3Z37R
 BLDLFUsK5uQFaF3lsu132bvGOnszE+IxEKCmmW/XtJ5txzyRbuLYClfAamsQ5pJA7l
 5QN9bXa2s3Ln/WgOuvtvMufZuVuRB0OBSBVA4WqLZDgfjBcfyCFfZp+xAJpR4pOS6M
 y3A4mButGoq0TQ1b+/EbTV0hRw2oJMIMfyPQtWmaVy+K1+zrStJ/SCsgPu6WY9P7Z3
 yWm7/EVYhBVWfocjREnANx96azJC241pT666UVCqHEzt2hVjB9rX5j3o+tDjE42pYW
 Pv6SBYzYCfTkg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Joshua Watt <jpewhacker@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] cmd: let gpt_partition_entry be hexadecimal
Date: Sat, 26 Aug 2023 03:53:43 +0200
Message-Id: <20230826015343.167612-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
References: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In commands like 'ls mmc 0:f' the partition number is hexadecimal.

In command 'gpt setenv' variable gpt_partition_entry needs to be set
to a hexadecimal value to allow its use as a parameter in a
subsequent command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/gpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 99ca0a6163..964056bd28 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -744,7 +744,7 @@ static int gpt_setenv_part_variables(struct disk_partition *pinfo, int i)
 	if (ret)
 		goto fail;
 
-	ret = env_set_ulong("gpt_partition_entry", i);
+	ret = env_set_hex("gpt_partition_entry", i);
 	if (ret)
 		goto fail;
 
-- 
2.40.1

