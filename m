Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0822C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 06:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063D48750C;
	Thu, 11 Jan 2024 07:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XvLZ9wYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15416876CF; Thu, 11 Jan 2024 07:34:22 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 106BD8718A
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 07:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 040DA43015; 
 Thu, 11 Jan 2024 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704954859;
 bh=DqtYmFIOanTwPuGkUzFGCbtXDyy2PIFrxcFMgAuMsbk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XvLZ9wYGh1xPUUpIeP2jEpJraZBqE4X3Uuiqefih9797VDCuY0XaokG0dPOYzWJkD
 VeJfhPns5fEitwn6KqFpf5GYHQ+aqJqN3jpfMkkcrbpw3ecYOQy/HlWC6i3G+8eJQ4
 Hktbk8zfE1u4+gLti3zKNcIP5yMETc7xtUMaAGntyMDWnjx02/pwoqc81/4YoK5KMG
 WhOm0N4HbaymRySMMJzvwB7SizyRt22yro7YrB6kP1PSc9ad2QX7aIr7gvCKlSc+eD
 SEo+0hhErXrrmf3X6lJ61WFe5msp1yGxg2DKqzX5biYMOJoW/NVsn4P35XFdyYh03G
 r6SHHPQdl8kgA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] smbios: buffer overflow when zeroing entry point
Date: Thu, 11 Jan 2024 07:34:08 +0100
Message-ID: <20240111063408.9807-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

A SMBIOS 3 entry point has a different length than an SMBIOS 2.1 entry
point.

Fixes: 70924294f375 ("smbios: Use SMBIOS 3.0 to support an address above 4GB")
Fixes: 1c5f6fa3883d ("smbios: Drop support for SMBIOS2 tables")
Addresses-Coverity-ID: 477212 ("Wrong sizeof argument")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/smbios.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 41aa936c4c..25595f55ab 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -591,8 +591,8 @@ ulong write_smbios_table(ulong addr)
 	table_addr = (ulong)map_sysmem(tables, 0);
 
 	/* now go back and write the SMBIOS3 header */
-	se = map_sysmem(start_addr, sizeof(struct smbios_entry));
-	memset(se, '\0', sizeof(struct smbios_entry));
+	se = map_sysmem(start_addr, sizeof(struct smbios3_entry));
+	memset(se, '\0', sizeof(struct smbios3_entry));
 	memcpy(se->anchor, "_SM3_", 5);
 	se->length = sizeof(struct smbios3_entry);
 	se->major_ver = SMBIOS_MAJOR_VER;
-- 
2.43.0

