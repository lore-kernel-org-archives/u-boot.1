Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B82C61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 21:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E115040A0C;
	Fri, 28 Aug 2026 21:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B-y-3p6qRRB6; Fri, 28 Aug 2026 21:00:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787950824;
	bh=FATs1ZX4NRcFTFrthxCY31DFLv1GMOkwanRQlVNuKy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CrCan3WRQGaUjt28bpqceK8KV53fgRSP9GlqBYF8UK31dwXmm4IM9Wu1NjSGP6QhA
	 luoRDevdKfnKUOqusfwuI0ZZwxN7OS7mDL7cZLSbH+w67i7XEgZIpgX/GBR60Dbupr
	 omPiHYC2TVfS4d4wgslhP7PEb7W1gHDMh5PnUEK5KqRS6NNB/mcKu5Ye0N7jI8J9Df
	 LNS3UI3wRc8K3c7oqOp+zMmLODrl+CQRGFn6alLVZfar33gqiQpQAhRNwg/ovUYqpq
	 a10MYHnfHh2LuOvBwKXVsM9tjswy4scCsAkVUpjEisN3qEFga62HAqM0LQWXWH+mPE
	 PMsMwqbJ0ij1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 033524085C;
	Fri, 28 Aug 2026 21:00:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12C9C23E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 21:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 047A44085C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 21:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mYB6xcHwh3ZT for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 21:00:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::1909; helo=smtp-1909.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=jcASiOJQ
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::1909])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BCBD40854
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 21:00:20 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWrPZ3K1ZzQRw;
 Fri, 28 Aug 2026 23:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787950817;
 bh=FATs1ZX4NRcFTFrthxCY31DFLv1GMOkwanRQlVNuKy8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jcASiOJQNWgYmJkGFFi/Awbsan0vT/MCAXgHfaqnN9HjGIaJMl0h2XaaWc1ijPqTM
 tD4dx2ufR9eftdN1nJEqMkFEr3tSzqLD/WpbjJYnloksefBHVBkLBD/pvOW5uG1mih
 gL9Ym1O17VUXnvaQcYqQfb/svLLPauWBMERMYQId9QjbqH5UXQx7ybdQJzGFjSdvXi
 yCJAq80/eiVeqRLhLCorv369elUqOhAqrrV/ZpU2vibXwx3uXM1BW0tRLFAybtzcD0
 8FQR+PgfNGTAST0TkXVXuEb6OdbW4n/dgM0TnUml8K9FFZ4jNwhHlysH56N8CYjspx
 JHG+d3duiIaHA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWrPX3h2CzmNL; Fri, 28 Aug 2026 23:00:16 +0200 (CEST)
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
Subject: [PATCH next 45/45] binman: gbb: update link
Date: Fri, 28 Aug 2026 23:00:03 +0200
Message-ID: <20260828210003.823954-2-foss+uboot@0leil.net>
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

The current link results in a 404. Looking at the Wayback Machine[1], I
found a similar page currently being served. It's probably very outdated
by now but at least it's not a 404 anymore.

[1] https://web.archive.org/web/20230520044331/https://www.chromium.org/chromium-os/firmware-porting-guide/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/etype/gbb.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/etype/gbb.py b/tools/binman/etype/gbb.py
index cca18af6e2fa..70067a545047 100644
--- a/tools/binman/etype/gbb.py
+++ b/tools/binman/etype/gbb.py
@@ -48,7 +48,7 @@ class Entry_gbb(Entry):
     the root and recovery keys that are used to verify the boot process. Some
     more details are here:
 
-        https://www.chromium.org/chromium-os/firmware-porting-guide/2-concepts
+        https://www.chromium.org/chromium-os/developer-library/guides/firmware/firmware-porting-guide/2-concepts/
 
     but note that the page dates from 2013 so is quite out of date. See
     README.chromium for how to obtain the required keys and tools.
