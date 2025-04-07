Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773DFC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 06:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0B282C87;
	Mon,  7 Apr 2025 08:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y+pawrG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA0782CA4; Mon,  7 Apr 2025 08:47:19 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C5782C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-136.46.114.pool.telefonica.de
 [46.114.108.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 274803F928; 
 Mon,  7 Apr 2025 06:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744008436;
 bh=QsyzUaKVy+LIEcZM2R5ofJE7IfiVDLUjMuTvS2OhqK4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y+pawrG8X5LZqgCZdGpmEzZwVqea8yXA/jk6wcRxmGy3+f7oLscZ4h3RcgN1FQoMr
 LXdkU8VVCccPnKpnR3pObLQBHpGMo5KrIQVVphtVZw1YfHYwR190p7JmFA70r7d6qW
 46LRyycQKqwep/nMZx6so8xKchPd02AWRuGI1w5kd3kDvRgUFtWrGazP8HBPSsJvek
 blN4TGprxM4SHhr4W+HnYPISSzlXnofYo3mYtQYnH6/PQxZltswCiVzL65GjhM2ZAk
 KrgWAGQSCXoUAbugrt4UyvEfSjA0REkI8pc9ITDUrtHaT5X1QLod5feJYHs3YkR6fe
 8a9Ee/28uMC1w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] buildman: update PyYAML requirement
Date: Mon,  7 Apr 2025 08:47:12 +0200
Message-ID: <20250407064713.71814-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

On Ubuntu 25.04 installing the dependency pyyaml 6.0 fails with

    License classifiers are deprecated

Update PyYAML to the current release.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/buildman/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 052d0ed5c6f..a6b1aecdbe0 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,5 +1,5 @@
 coverage==6.2
 jsonschema==4.17.3
 pycryptodome==3.20
-pyyaml==6.0
+pyyaml==6.0.2
 yamllint==1.26.3
-- 
2.48.1

