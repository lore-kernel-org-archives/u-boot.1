Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36734C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F35644081B;
	Thu, 27 Aug 2026 19:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVpVqsX8zo3n; Thu, 27 Aug 2026 19:54:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860441;
	bh=ygR5Oz3F+6yRDDIlaEnjn3gJOomhWj2kBgp4TLOFLgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IaTNbWhUF4W8Kw6m0j+ZCPwx/gl7+D1lmWgd/RUZXz133qi4nDJXAv25/1zXmCuFo
	 DkGbE4qbaQq8iImMpqUoVTtf/D9DdaAA6BeQaQ8psIciiJaVK4UbrtPIiYinww+LZg
	 Tqj1HuHkbNXoHqKmbZ9AhIj+K7MfgrxjOCgezmlcuaoii+Uej2yQg39/pl043azCa8
	 xV1uCXKAtlvJxglSNFsvbDxteiOJ5kcWxx3CcSMT0xJzW9dPb4Q9JAVO0MeOkhFEv/
	 EmFt0KROSsD8IIR5tLoByL3SRJQz5TZGzizlDrQ63zyJXBxuYFKF3qbtQ2sigjd/Yy
	 FhqSQpwwaEOYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DF8C4081C;
	Thu, 27 Aug 2026 19:54:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 603B9334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52951400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qwh4FBWfC0LE for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::1908; helo=smtp-1908.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=jnKvPfMH
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::1908])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D1B4400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:53 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzM2g0lzym2;
 Thu, 27 Aug 2026 21:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860430;
 bh=ygR5Oz3F+6yRDDIlaEnjn3gJOomhWj2kBgp4TLOFLgI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jnKvPfMHml+7rGhGx2k5b+4lgkeY7UyiWdGwwXdaW8ZY8VVJIAdEuAjwC7HNhX9xf
 09r8w+l4vNKVJgvgLrB5V2vgXHzzJ+fpT2r18cBg9PWVXTrL44RI+goNjKhE0vfPey
 y4iGAWuPAkx1akuT7TRl/xh6GkEgmQf/12tBTQAO8f1x/lAYcVTn5vtRhKv1b6DLZT
 Ig9yxpdY6pFByZL/88IRXbpDxtRipZaWLXGLlL15l7u4NuuUK4JiiYxuKlUL2w4W45
 Kvun/de2sbbDNUj7N9Uke/f5TljCts1kImX8ubyPhQ/zD7HzAGbcMgvHvV4jw60iyO
 wqOn5+vHvqkbw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzK4w5tzRxY; Thu, 27 Aug 2026 21:53:49 +0200 (CEST)
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
Subject: [PATCH 28/45] doc: develop/driver-model: fs_firmware_loader: update
 link
Date: Thu, 27 Aug 2026 21:52:56 +0200
Message-ID: <20260827195313.129994-7-foss+uboot@0leil.net>
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

The current link redirects to a generic page on the Intel website.
Looking at the Wayback Machine[1], it really looks like what is
currently exposed in the official kernel docs, so used that instead.

[1] https://web.archive.org/web/20220916014111/https://01.org/linuxgraphics/gfx-docs/drm/driver-api/firmware/index.html
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/driver-model/fs_firmware_loader.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/fs_firmware_loader.rst b/doc/develop/driver-model/fs_firmware_loader.rst
index 149b8b436ec3..630daf636f18 100644
--- a/doc/develop/driver-model/fs_firmware_loader.rst
+++ b/doc/develop/driver-model/fs_firmware_loader.rst
@@ -6,7 +6,7 @@ File System Firmware Loader
 
 This is file system firmware loader for U-Boot framework, which has very close
 to some Linux Firmware API. For the details of Linux Firmware API, you can refer
-to https://01.org/linuxgraphics/gfx-docs/drm/driver-api/firmware/index.html.
+to https://docs.kernel.org/driver-api/firmware/index.html.
 
 File system firmware loader can be used to load whatever(firmware, image,
 and binary) from the storage device in file system format into target location
