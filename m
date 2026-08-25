Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D455C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2F18401E9;
	Tue, 25 Aug 2026 17:00:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vpwzhckR5wpH; Tue, 25 Aug 2026 17:00:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677239;
	bh=zhPUtAXbz245IdKz+GOnFt7XAs4+Q48AE2C2IjZezOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OUc5qNUqhVQymGg8GPBk4rADGh5qkQnTuHWBc8UzpuhWoZrsQg4FKZLkUELO5aKXV
	 6gQFgbEskwy1OfDdE6lu5dbJd/SfhWftDwX3dQKvkL4Nqw3Xzd8AleukZa8QaSBJbB
	 uSFcnhv7zLJYvyKnDDwOYDT1ONj6O2p88oDWrhR+bWSlr+ohy0dmFSOwP0XwiVYaNX
	 iOU3NRKgRqxagoLMVyAk1sl5Wtwtbig0S1MYW0VziuPFqTe0LqBp9mPhWXdZ1xyL7q
	 adl35BcXrtBt+Hhisdc4o8eQfd4EfAyOhBcXm3wm0vw4Rs+SHjco0SMryX7XhI8OVr
	 v963qhUUMHQIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2003440633;
	Tue, 25 Aug 2026 17:00:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF66135E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9575B60765
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b345nbh4CYTO for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::bc0c; helo=smtp-bc0c.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=H8Aarq+C
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::bc0c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1156860762
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:35 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0g31ZmzjnR;
 Tue, 25 Aug 2026 18:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676626;
 bh=zhPUtAXbz245IdKz+GOnFt7XAs4+Q48AE2C2IjZezOE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=H8Aarq+Cg8nfDfO4rPk9gNFT2F3qDYinXGv/KLnhvKgr9+Mr56HuJSI8mVN20EMVO
 fCMWYcHH+yS4QpUYfWvu/mkK8zMZvf4tVYrc9aDYWXfKs1NWY3/2tBrkRNHQ3LkA/2
 6QSTtQaguFlYM5m2ltYc/VfNGBMfqwwyL8akyIUQrhJdgBsSn+l/2SYsjnjPHhMzhc
 HseviRRoEs4bzPJapi1GRX4n1fWbaKDG1tH1t/V33u6x+tG3Imd5414lmwAjI2UVk8
 ytlZIodv8ufjXXJzopbOrqxGKcYdNjcGfe2yKDVJADfYuf1RLNMhiNWj0LTGt4ICHg
 bck1mSv0eFMnw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0d63b0zYd4; Tue, 25 Aug 2026 18:50:25 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:53 +0200
Subject: [PATCH next 16/45] doc: usage/pxe: use redirect link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-16-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
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

Those links actually redirect to wiki.syslinux.org so let's use those
links directly.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/usage/pxe.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/usage/pxe.rst b/doc/usage/pxe.rst
index 18532f182d5c..523bf9f565eb 100644
--- a/doc/usage/pxe.rst
+++ b/doc/usage/pxe.rst
@@ -30,7 +30,7 @@ Commands
 	try. The order and contents of paths it tries mirrors exactly
 	that of PXELINUX - you can read in more detail about it at:
 
-	http://syslinux.zytor.com/wiki/index.php/Doc/pxelinux
+	https://wiki.syslinux.org/wiki/index.php?title=Doc/pxelinux
 
 ``pxe boot``
         **Syntax:** ``pxe boot [pxefile_addr_r]``
@@ -130,7 +130,7 @@ pxe file format
 ---------------
 
 The pxe file format is nearly a subset of the PXELINUX file format;
-see http://syslinux.zytor.com/wiki/index.php/PXELINUX. It's composed
+see https://wiki.syslinux.org/wiki/index.php?title=PXELINUX. It's composed
 of one line commands - global commands, and commands specific to
 labels. Lines beginning with # are treated as comments. White space
 between and at the beginning of lines is ignored.

-- 
2.55.0

