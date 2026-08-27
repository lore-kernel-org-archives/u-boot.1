Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AA8C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19F4240854;
	Thu, 27 Aug 2026 19:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TfEqcq-oLfnu; Thu, 27 Aug 2026 19:54:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860453;
	bh=vKprHBopFITRFgf7tqRZZJn3IN6LVb9NZoF2aeT6PMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WTkafBCsLWWtxnz4OUydMayZnzbmrus29bMvCiLOiOzDVd25BStiLoFcenk4+2LQd
	 nwi0PRQQ5jCQ8+VaJE99FtVbLOYlJZDBDtdkZr+iAEqXNyvIXkhyTc1nIyMmSG7cv2
	 V44Gu1yED6m0ejQAh95GI6Ye1isaiTTXckcNEt/4Gf/lJ4+0cA0u3U1UYlFeiPXuYV
	 FfU0jyt8/rqhPM2fLTY9ciAq8sokYfJYh5VjrapAerswv3HpcgRZ8rfLwcKIMPsPgi
	 82JpO+ZCBpiueumHTMHObLllkSrZxGHikxcwZE+RC5J4BG8Z3XuOqmZokSHFop4ujZ
	 VJbiNjZ2adUQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 520BA40845;
	Thu, 27 Aug 2026 19:54:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DAE2105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C2D940809
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZRtng3M7LwT4 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.169;
 helo=smtp-42a9.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=RUYiNRyL
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 352224081E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:00 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzV3V61zcQ;
 Thu, 27 Aug 2026 21:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860437;
 bh=vKprHBopFITRFgf7tqRZZJn3IN6LVb9NZoF2aeT6PMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RUYiNRyL6jwrlY3hCjCBZfwipJ4ni29WRb6EGOujWP0oPyvPKNBRd3kNk3zagoWiE
 JhH1aPatMu4xfAHhH+TFcTy0pBbhR2o0s9SpugSbZnGIkIKBCBFxtvSfIikwe6Quad
 Ae0c9FULJGYtH3v/Lh+6wl7Ji/BPYRDtM2MdchrcmBSUCBBj17pVVG8C4Q6fJGj2xi
 znru5wjYJAmL3BUZ2ncLbMwv3I7b5EX00XZqKkYeCP92z80b+3PWD6AFlbMMgZCAm3
 pU2JB/e5uHofeVyxlErrZPDIthLUVHqmN/rfbbzVDdcJWnQhhCMZLysrc8x1qghgA8
 SfKuWo6Hr2+CA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzS3ZSBzRYv; Thu, 27 Aug 2026 21:53:56 +0200 (CEST)
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
Subject: [PATCH 33/45] doc: board/highbank: update links to cxmanage and
 ipmitool tools
Date: Thu, 27 Aug 2026 21:53:01 +0200
Message-ID: <20260827195313.129994-12-foss+uboot@0leil.net>
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

Both repos on GitHub do not exist anymore. ipmitool is still packaged in
distros and they point at sourceforge as the source, which itself says
development is happening on codeberg now.

For cxmanage, it's unclear where the source code resides as no distro
packages it. There is a cxmanage package on PyPI and they list
maintainers that are also maintainers of pyipmi, so I guess this is good
enough.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/highbank/highbank.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/highbank/highbank.rst b/doc/board/highbank/highbank.rst
index 654ef8a02699..21d76436b369 100644
--- a/doc/board/highbank/highbank.rst
+++ b/doc/board/highbank/highbank.rst
@@ -73,6 +73,6 @@ existing U-Boot, and execute it with bootm::
     => tftpboot 0x8000 u-boot-highbank.img
     => bootm
 
-.. _`ipmitool`: https://github.com/Cynerva/ipmitool
+.. _`ipmitool`: https://codeberg.org/IPMITool/ipmitool
 .. _`pyipmi`: https://pypi.org/project/pyipmi/
-.. _`management script`: https://github.com/Cynerva/cxmanage
+.. _`management script`: https://pypi.org/project/cxmanage/
