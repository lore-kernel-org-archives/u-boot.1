Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE312CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A6B8489C;
	Tue, 19 May 2026 17:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qP3A1tyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFE184898; Tue, 19 May 2026 17:21:11 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D394A8488B
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4042905015cso3156074fac.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779204066; x=1779808866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAdi2pPcZUgoWb5oWo+8Bi0faLz2GIl/lBnMcm8MDNY=;
 b=qP3A1tyYYy5oSLRYBGAAzKSn7puvAQ66HedJNc6+4VY2O+76VoVprxOdZIE0sC9jFR
 WtlBsLZQQNDxV1AKorNkw7nUpBvm/7kAG56xcr57ybLPxD3FeZ7TN8P1GCcK+FXjEvvv
 v4T3z3e1OkL7iIVbul57s0tFlmBt0NYwr0leA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204066; x=1779808866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TAdi2pPcZUgoWb5oWo+8Bi0faLz2GIl/lBnMcm8MDNY=;
 b=O7V+72it/qm+cYWmml7rg3kxZq96Fa9VMQeKH/5ObKIP3qLywiBhr02fnG90odNxof
 Mu02fw1Gf1KINdPj3s3qs6mJ8wDFD7xh4v0hl4BsRJ1njhs/Z0l60gyHSxt0bPMRGUyL
 pDKBr36TcPuL4sbJ35K3LgRVGC3JDUvEqx6iFerCkBdQAEBj78LB5E13SoLX2I+5eN9b
 2vZhfui3pvIFYiXhH4LhIMfBE0lo2jPxtxuJsgo5v+Qi7yU692P0fNi6IAA1aEE57ECL
 vSOsNz8MKHOwmCnkQ+j6AYYixS7udApsWraRDiTws4+22gM0L+hd9tq99nXwCe2xU0jR
 6MMg==
X-Gm-Message-State: AOJu0YyKNlJ2gnmf/dTALii5ENBdl2QbzVZa2lc7jReiLl/TN1FiSovg
 eo5fpGO86eVejTvMmsUmCcWJ/NKR2GV/vjyozmdEobMFTxqSD8HeFfdKPx66mxBuzo/1B0u4Ok1
 xqx8VUxt9sd5k
X-Gm-Gg: Acq92OGlF5k+lBJ9vb1l+5hsTC7YBerRN/urxEVY+yuh/ZRYcQgOLKMcvR16YIsQkZW
 O4HizhhWmylWADl/bEcjcTcpBY5gtwkPB9KsRIP2PvbHSHA0mEkN59yxoSXRYST72fjV8yFhDrl
 7PFy9+eLIOK8WNq0RJWBZcXZ3/CnILph0nKtebQ4JukV/b42oo31A61xm/bSEE6tFrIIPWRRRuy
 hzowlSpi0QdvmLAGC6LoPdUUpT5l6Oz29xi0HvYdRJbX1P5sisyAc8IpwRnnn3d5uXq+m6J63Kj
 2eVXlvICAeE7/MyIpYMVfWFjKLmhP86eOhE1rvq8aLBSvYT9qi+Tp/HGB1oruO71iLxFIq1oQxd
 54lQZ+4wrg1CqyLLtap8nzF6Q9MnXCkUdQanpTW3isM2E0C0XGH11vjNjAXde/rCUNziwW17UF2
 t0Lc4oKdphhA3+zbK/Sf2uAyM9k2+v2X176yTv/FKFkpec7ln/tUdVCiC/zQ8iIm4mL4X1oZlj+
 KMKSZgGgdquo6PWnRmEzY3WY/9y6A0ILoQih/byVJ4CdqZ6udOERHwL05ssZW+PKHgn1Xj/3K8=
X-Received: by 2002:a05:6870:239e:b0:439:fc23:5797 with SMTP id
 586e51a60fabf-43a2dd33cf4mr11762062fac.25.1779204066543; 
 Tue, 19 May 2026 08:21:06 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a9576cdb2sm7170167fac.16.2026.05.19.08.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:21:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 2/5] block: ide: Drop empty bootdev_ops structure
Date: Tue, 19 May 2026 09:18:17 -0600
Message-ID: <20260519152101.716714-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519152101.716714-1-trini@konsulko.com>
References: <20260519152101.716714-1-trini@konsulko.com>
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

We don't need to provide an empty struct here now that the caller can
handle this being empty.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/block/ide.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index cab5e1bc92b2..c1a46dd2a946 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -969,9 +969,6 @@ static int ide_bootdev_hunt(struct bootdev_hunter *info, bool show)
 	return 0;
 }
 
-struct bootdev_ops ide_bootdev_ops = {
-};
-
 static const struct udevice_id ide_bootdev_ids[] = {
 	{ .compatible = "u-boot,bootdev-ide" },
 	{ }
@@ -980,7 +977,6 @@ static const struct udevice_id ide_bootdev_ids[] = {
 U_BOOT_DRIVER(ide_bootdev) = {
 	.name		= "ide_bootdev",
 	.id		= UCLASS_BOOTDEV,
-	.ops		= &ide_bootdev_ops,
 	.bind		= ide_bootdev_bind,
 	.of_match	= ide_bootdev_ids,
 };
-- 
2.43.0

