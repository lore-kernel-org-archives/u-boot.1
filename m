Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6BEFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A33D384688;
	Tue, 28 Apr 2026 12:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="YN+8+68r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6D384664; Tue, 28 Apr 2026 12:56:17 +0200 (CEST)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::190c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF0984679
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g4cmv2GSZznq0;
 Tue, 28 Apr 2026 12:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777373775;
 bh=YlMF0NvojWlag3rSWOoYR6P/e2ABgBZCur1LvhSNL/g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YN+8+68rEClceLlaHQqt50SHp0R2/ynAJY0uZwHPfDb/rRBmH/ebnfAkAyI1ToQYE
 O39LfW6qUP1ur38btNjl8XJqWTa3LOS6REFvz8VteXyiLb3gdP4QxZuZ0nSJhn2jiJ
 4LEfcW/cIXDduEkm4nqV6kSfE8LtwckARPiAzgHn75zZOloT/QxfHp322XgBXofIfK
 uXsafNu3pqCfj4K8KQRyOasQmed5rxmJj0voVLQqdtttxr9zJ8RWgZyfg7gSgpThtV
 3MuQbZFl3J7LhqRcBufI9nyMzGYHONXnN2jf6y63dIfiVJGNBL1zfGpI4eZkrnUyG4
 tJVQmxYaC5qBw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g4cmt3JJNzpr4; Tue, 28 Apr 2026 12:56:14 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Apr 2026 12:56:04 +0200
Subject: [PATCH 1/2] cmd: ufetch: show net feature when NET_LWIP is
 selected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ufetch-net-v1-1-5d58c7618239@cherry.de>
References: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
In-Reply-To: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

We've had a new lwIP networking stack for a couple of years already, so
let's show there is a "net" feature if it's selected. Since NET_LEGACY
|| NET_LWIP is the same as NET, let's check on NET.

Reported-by: Simon Glass <sjg@chromium.org>
Closes: https://lore.kernel.org/u-boot/CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/ufetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index f8dc904bdd0..bc5db08eee1 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -159,7 +159,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		case FEATURES:
 			printf("Features:" RESET " ");
-			if (IS_ENABLED(CONFIG_NET_LEGACY))
+			if (IS_ENABLED(CONFIG_NET))
 				printf("Net");
 			if (IS_ENABLED(CONFIG_EFI_LOADER))
 				printf(", EFI");

-- 
2.54.0

