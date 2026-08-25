Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65377C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2069D405FB;
	Tue, 25 Aug 2026 17:00:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H20fWA1-YNBO; Tue, 25 Aug 2026 17:00:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677226;
	bh=GnusEdOvaucIR4QZL7VvwNYEqPLjTZlxrtG+jwIYw6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A9pUvw75RSSAcP2/KoJ9ES0g9m6R748f5lBxgRS/DxuQ25fU4I4iJNJJiQAVKdu7t
	 rRV1s7P9MDgNK6U2VEt08kwU4KJAbW3Re7ykSV6P2aF7Z4E2AGEIh73jDwiqQjjhS7
	 9xzRFXIAOIoYZixjhSVA3wW839K/45VrN+BXm0C6pKjYOE2aYpwaoZHbC98dhprM/9
	 vFkpoTRL366B1a715AsfQH60z0OnNMRT2+WGCFpKY+Xe0ke4KU/QFtVokT+tcZU9Nz
	 YM5b4rDDSRNwq/qw53UvcF18yc+2dlWZe7wrtFvDRF7HE6iYMlnCMMwkPlbc6zF/Lm
	 p3o2hSUG34YfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C51D40647;
	Tue, 25 Aug 2026 17:00:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCCCD1AF
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C39514004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Mu_kP4JnfbX for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::8fad; helo=smtp-8fad.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ULYQgTt6
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::8fad])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A941C4002B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:17 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0c6JjZzl3m;
 Tue, 25 Aug 2026 18:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676624;
 bh=GnusEdOvaucIR4QZL7VvwNYEqPLjTZlxrtG+jwIYw6Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ULYQgTt6gSrz9iOXO9nOf4OsrwxJ8GNLQqmzXuiivEAhcMogPXiS2Pf+FKYWX7Jcu
 MsFgWDXlnnR9IV2dat9zINtsp9Cx1TEOn1Kx+b07Ytlpt1ee62Sym2C0kTGUyzVhmd
 /pC0NU4l7IPsDVexFRznKGWOihm8LZJlrMWpyg80dxHWl0du8jDbzFt/uStXz5fSQ3
 h6bTjxivpC/Xtm+0s+HMOnzb+qfhVeLvMb39p42d2RHwOIjLghsyp0ph5lqLpQ3RDS
 pOATRLE5nECkJmEzU9OS6CprJoq1pK5YkjnmCIjNTa40iA7zRpux7dia09TOPqh/iJ
 DJTcqYOGQt1zQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0b0mNxzZV9; Tue, 25 Aug 2026 18:50:23 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:51 +0200
Subject: [PATCH next 14/45] doc: develop: sending_patches: update link to
 Email Clients and Patches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-14-ee7573fe3a4a@cherry.de>
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

The article doesn't exist anymore. On the Wayback machine[1], one can
see that the article merely quotes a patch from the mailing list. It
eventually got merged and moved around a bit and is now residing at the
link in this commit.

[1] https://web.archive.org/web/20120512160209/https://kerneltrap.org/Linux/Email_Clients_and_Patches
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/sending_patches.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 8286808173d6..3944ca4206a0 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -353,8 +353,8 @@ posted before, look up the old threads, and then manually compare if anything
 has been changed, or what.
 
 If you have problems with your e-mail client, for example because it mangles
-white space or wraps long lines, then please read this article about `Email
-Clients and Patches <http://kerneltrap.org/Linux/Email_Clients_and_Patches>`_.
+white space or wraps long lines, then please read this about `Email
+Clients and Patches <https://docs.kernel.org/process/email-clients.html>`_.
 
 Notes
 -----

-- 
2.55.0

