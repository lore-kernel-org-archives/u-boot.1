Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0AAC61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DEFA40840;
	Thu, 27 Aug 2026 19:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XIN4JrQbrrGZ; Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860444;
	bh=I5ezwHMbT6Ip9MG6DDRjkxC3YuXL1MIE3fZ4pF87ztM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ok3cbOzvPcU1tUpzeIiBcpDSboirJV5kUX/74vA7W3uoj+k4GO3Yfacwj7QjiPZ9p
	 XyOjB8+udpjypSzqlRVw2M94SSzbmsJSBAEJ13YSlC/r96JbshAPMA8dXeK6R4PvJB
	 4/gdtTL5B+rtGkEmnkrIlzdCJUz65HPScAILp5C+mXdxxdCu9qgmK5Y8WasrkAopxF
	 uauwvi+ZYtLhPeOXBjEScx9nh6h3iqRL1lPasZhciKJyWwH2kwmzQFE+mnF7q7pLMD
	 fgnLG7lturMbZmQDUIPI28u5m9pgdcrmkxDVsZ9nA6yF+hl3veUasK8+pPZA26eeoQ
	 gr+cLthhxGqTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE4B840812;
	Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A64575
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C5D24081B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1UAik-cpJXG for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::bc09; helo=smtp-bc09.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=iRdUZ53B
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::bc09])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A33340810
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:56 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzQ0Lm5z1Zg;
 Thu, 27 Aug 2026 21:53:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860433;
 bh=I5ezwHMbT6Ip9MG6DDRjkxC3YuXL1MIE3fZ4pF87ztM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iRdUZ53B7hgNshtUNZBAkgmWtz/oKzuw0DXp0SSEXEzJLOKgf+24SxWi823EiF88O
 idHcpaXOnpvWX3nVHpIuqHBwp1rGH7TDZlSE+PN+ApICh+zIGxkft5+7PxGNq3W5Gi
 tCksCj4Fnqt6ldRhCUflONw/hUbfopeCyMTCm08QV3MI6b31yz0MhY/b7jTt1MTvru
 ad50rdr4Nk66qc33hYWs6rQgo04gG0rCqVs+ldX7ZS0jTFTc9g5Sn5A9sJMDhjXDZm
 wYqW6s99n7EK2v+OkFSIWlS+8yHsBljfbZzOwjTO7p+lz6Hy/rC9dydJPlgbZJ/m5j
 WZdz2I+yuZ27A==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzN1mwVzR0T; Thu, 27 Aug 2026 21:53:52 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 30/45] doc: bootstd: update link to BSL
Date: Thu, 27 Aug 2026 21:52:58 +0200
Message-ID: <20260827195313.129994-9-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

The link states the current version has moved to
https://systemd.io/BOOT_LOADER_SPECIFICATION/ which itself says it's now
hosted at
https://uapi-group.org/specifications/specs/boot_loader_specification/
so used that link instead of making the user hop through multiple hoops.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/bootstd/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index ec9fafa0fa05..106586f667bb 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -882,7 +882,7 @@ Other ideas:
 
 
 .. _distro_bootcmd: https://github.com/u-boot/u-boot/blob/master/include/config_distro_bootcmd.h
-.. _BootLoaderSpec: http://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
+.. _BootLoaderSpec: https://uapi-group.org/specifications/specs/boot_loader_specification/
 .. _distro_boot: https://github.com/u-boot/u-boot/blob/master/boot/distro.c
 .. _bootflow_h: https://github.com/u-boot/u-boot/blob/master/include/bootflow.h
 .. _migrate_patch: https://patchwork.ozlabs.org/project/uboot/patch/20230727215433.578830-2-sjg@chromium.org/
