Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2B5C61DD3
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C53D260856;
	Thu, 27 Aug 2026 19:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjJdp_22WdTs; Thu, 27 Aug 2026 19:54:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860471;
	bh=jo6z0pqlpt+3EPxzjS1uUyOWHyk7DCh8vGC5hR63htk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N9/50TLJm+6U5YEJ+ANPL7ELSHlGnRfJBjj7QzMONQCg1BEnXIVmPME7LVYZqIKg6
	 IdHKQ9nlineuQWHzkRzGIEE3Kek8y69SCRGrrC0XmgSSkL11q24dcvuVi/qiHE8G0w
	 aqXGcqmhftRLQMrP3Rifas0GFZ4htrbZcpSA5JxjPMrkKyzxn1jAFRQtYf/NxAwEXQ
	 Id1WCDTUZl4xsumWDtiR4FSOWSslqT+bSsm7wbNk4dCiqUkSx+XFSExu1QOdqUwVmu
	 f+k+t5MH+P6CrUeMAWKZsz5QP8xvVE4Np+ewSkwMV1t/mj+1F//Jw/SjXLscco6gJS
	 /AMtKa5SzTzCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB65760863;
	Thu, 27 Aug 2026 19:54:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 13482B2C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 055A340843
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6eRtQTRUUH7R for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.171;
 helo=smtp-42ab.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=n1bxZyy2
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12C8D40851
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:16 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzl67tDzVM;
 Thu, 27 Aug 2026 21:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860451;
 bh=jo6z0pqlpt+3EPxzjS1uUyOWHyk7DCh8vGC5hR63htk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n1bxZyy2BdWvh4BgUIgQKf3baYhkgmCzJVVnRV2jhJTJKy4dfyF7C5afkTyUjEDFL
 BgELVffIJySaUxt6l4PimhtJl64T7PesLB5DlewcMmtGZjge2F1qFMuwGsJgcYlIEV
 NUTtWkR//WH/zXFhb0d/X6AOgCQdwU6cObC588b2LsrRCLg31NPYxdS2MH+NVkZojW
 n2A/0fFuw5uGZ0537uHzRgvUtdUVu1W8QPZBYprlnvzBfzQAP0nleHI+7OEqjX9uDn
 c5dNl2y/td0o2ZGtBv6msfcLQXa84448swP7EWEqJYLCsAgAj8ate0yH+E+Rpa+iME
 kKZSMKyBl5+LQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzj5rCdzQqp; Thu, 27 Aug 2026 21:54:09 +0200 (CEST)
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
Subject: [PATCH 42/45] doc: develop/sending_patches: use link from ozlabs.org
 mailman archive
Date: Thu, 27 Aug 2026 21:53:10 +0200
Message-ID: <20260827195313.129994-21-foss+uboot@0leil.net>
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

This avoids triggering checkpatch that asks us to use lore.kernel.org
where the patchwork mailing list isn't hosted.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/sending_patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index ca30c6dde1b6..27363a448b23 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -506,4 +506,4 @@ for an overview on how to use it.
 pwparser
 ^^^^^^^^
 
-See http://www.mail-archive.com/patchwork@lists.ozlabs.org/msg00057.html
+See https://lists.ozlabs.org/pipermail/patchwork/2010-January/000186.html
