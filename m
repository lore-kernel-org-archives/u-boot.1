Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D75C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E552B60825;
	Thu, 27 Aug 2026 19:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ajc3obe_CP7F; Thu, 27 Aug 2026 19:54:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860451;
	bh=HfxRReS1kME7p3FetYxDw6A2C24xp+9Ut6CtiGXy0QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JuhPCVSv+uVWMk5pGEqfHrFY8n73kK8cjBICHj0bdNkGmfd87KQ+Dtp706BJRqGyw
	 /jN/SgWmqK+pLfOsSGYovcyM61V/ao8SZ4XnpJWN2b+ONI9QpmW2lRnc99VOR0LxkY
	 2li5Vq80IF6xRMRBwTG9CFKP1OJkF+ItnOxSZtPaF9ZPQwJqeq4S1D1Wx4AmqyCLHT
	 JDjcCyh3bgcq3KwaFjv/iv0rOfOkFckeEtY3BS1BoR9LdkeVIfteoUnIicjUOVo/5G
	 6eWgbRLcjMOL3Z0LeRJZI7tkVxqiZbg6NVTd9Q4IyhkYl7ag6QRlKdrqzQuJHlseRq
	 okQFV5CVTFZiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 214E360828;
	Thu, 27 Aug 2026 19:54:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE34E105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD2446083A
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPwTwBFNG-vA for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::8fae; helo=smtp-8fae.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=May6crFk
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::8fae])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBEF260826
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:59 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzS66wcz10ZQ;
 Thu, 27 Aug 2026 21:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860436;
 bh=HfxRReS1kME7p3FetYxDw6A2C24xp+9Ut6CtiGXy0QQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=May6crFkc9Gk+f7oJ+D9WXLsdEP77KQP4YgfmK3zi+1dSmWHRByGS/Gb8CG14k6dH
 Db4qg3xuOsJP53bcqF5GICUTtAuKbwHE7b0IwYp+aUIfvABgrMnYhz5ITzU2sG3aUK
 75Xn9hsgJ2LincnH7DL3GBRcPP3q+pazAKxKrPUR16O7puKJh1n2BG93IgaCvoV01Z
 ye9aEa8QRt0DUT3/bGNBYD7kXM6Dsug6FZ71rW1FA1H2A6NZtF2H6d1PZUS61psSyF
 AIr8erw6YstVCQUTiT3BIyjH/UkaaEkaf//dXY0RF2NbKSKqZqoHHO6MaL/5cIwSTW
 je9NKx2P1Cctw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzR166gzQQ8; Thu, 27 Aug 2026 21:53:55 +0200 (CEST)
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
Subject: [PATCH 32/45] doc: build/gen_compile_commands: update link to point
 to the right page
Date: Thu, 27 Aug 2026 21:53:00 +0200
Message-ID: <20260827195313.129994-11-foss+uboot@0leil.net>
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

linkcheck complained that the anchor doesn't exist anymore. Instead, a
separate page is available so link to that instead.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/build/gen_compile_commands.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_commands.rst
index 5eb9e4ccb0aa..e67263eb82f4 100644
--- a/doc/build/gen_compile_commands.rst
+++ b/doc/build/gen_compile_commands.rst
@@ -61,7 +61,7 @@ manage build configurations and code analysis. Some of these IDEs include:
 3. **Qt Creator**: Qt Creator, a popular IDE for Qt development, also
    supports compile_commands.json for C/C++ projects. Instructions on how to
    use this feature can be found at
-   https://doc.qt.io/qtcreator/creator-clang-codemodel.html#using-compilation-databases.
+   https://doc.qt.io/qtcreator/creator-how-to-use-compilation-databases.html
 
 4. **Eclipse CDT**: Eclipse's C/C++ Development Tools (CDT) can be
    configured to use JSON compilation databases for better project management.
