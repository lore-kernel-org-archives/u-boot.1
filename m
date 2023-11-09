Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6933C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 16:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E1CE8723E;
	Thu,  9 Nov 2023 17:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="smppXXed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA3387254; Thu,  9 Nov 2023 17:35:22 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B4286F7E
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 17:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [156.39.10.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 479113F2A8; 
 Thu,  9 Nov 2023 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699547718;
 bh=Mv/ilNMSCXjhcwfhY5oP1NCvmvqQ6FZcGY6E9nESAxo=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=smppXXedw3QKyiccv05s0jjyzoLTGqLyhRQh/4m29NsdZMGkBnzLctYpqV0WkvvVz
 EUfXZpgj0fNA4M6BDMgYBAXPk/GeyViH0b/QvN48OVTdDbchIl6HQGvF8POu8BmArL
 Fw4pWxL+FlazJzIqz2C8m/JOCpjMhRcM4BQfbib7qWWnvkhvcNy7AYAn4+GUdfD0Vg
 Rp1B0LMLVEnxT6IeJsoEqQdcJGvtWedhbmGjSpLxAv/lPrs7JKnwjDuE5TIY5hBpSa
 SypgMY270UIrz50X7PkLuyArQjxwEQis/t7NrFX5MCNCMWKgSx3uyqc7gMTfq2xA/o
 kwgyud9wI+lXw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] doc: typo 'form' in qfw.rst
Date: Thu,  9 Nov 2023 08:35:07 -0800
Message-Id: <20231109163507.24096-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

%s/form/from/

Fixes: d46bee8c2d24 ("doc: qfw man-page")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/qfw.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/qfw.rst b/doc/usage/cmd/qfw.rst
index ec13e0967a..e734b26671 100644
--- a/doc/usage/cmd/qfw.rst
+++ b/doc/usage/cmd/qfw.rst
@@ -15,7 +15,7 @@ Synopsis
 Description
 -----------
 
-The *qfw* command is used to retrieve information form the QEMU firmware.
+The *qfw* command is used to retrieve information from the QEMU firmware.
 
 The *qfw list* sub-command displays the QEMU firmware files.
 
-- 
2.40.1

