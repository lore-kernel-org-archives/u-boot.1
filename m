Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98137C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 596A560842;
	Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EtQL12RdI-zM; Thu, 27 Aug 2026 19:54:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860442;
	bh=6IExs6McSy+rd2c1Ab5hZa3CO5mZAULE9VMRgqDBfLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a5qEI/GQeTolAoeN4hsRAPnJ0Xykjbm7k1DSGkqM0m0Dax9J12rtLbHz4UzPGULx5
	 r7lNwrtgSwaAa7qLxSpGGo2SQlp74xu2zaAqePbIqSU1fOhlCNKcRjpqVrhU+w5dQY
	 Z3yY5wxIbBhXPmr/MU+c8XfqK7/+/Y1mjrBh1DJZNsababpSnJp9nvLp1luNtO48nV
	 hQ+SXlwkcfYOLfKBbXEM8fKaGw2COmeQ2rC+lHL1fh9Ot4bO5mUMCQbNH9y/pevRIo
	 YqjhmbM4bJd+4PYKKdMlLtlc4Vz6bXtC0NrBO+wT14+Dg1UVOLqzNNaZapqHFt360e
	 y7GT2ii8W0ntw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4211060824;
	Thu, 27 Aug 2026 19:54:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ECF475
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E39B040775
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsYAP-OY_uA5 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.11;
 helo=smtp-bc0b.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=BbC21CWJ
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B014C407FA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:48 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzG6rk6z1gd;
 Thu, 27 Aug 2026 21:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860426;
 bh=6IExs6McSy+rd2c1Ab5hZa3CO5mZAULE9VMRgqDBfLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BbC21CWJbZUXHqQ/cfiEv86+IAWSH882XEATmGHIGllO7GqGqQj16RGE7AyjzaEEV
 B+ZQxXQ4V6+hItggA0F9LD34oLag9RUpbJdf7AEDLgHg43c1sYEBO2KlWstf1zQl4I
 HA6dNQ+92jA7LFw/0ZFD9PF1aXEQP3cRnT5RlP7K5eoYMvHOVn1C4O9GXssAZkJsgN
 Aq0xGRx3orUqWKu8USI4zCYvUaCIUMnLVYLgJ6c1ZCqc+K7qYBLJP1FLAVxvKwkbEg
 OjjyOrHsLAfUcKKneEW1JaZGQphWH1RQiDrf1dR4jTgaqN6OUoZ9C+M72HiSrW9nbU
 4cNzEV8ddVyow==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzF22kdzRYm; Thu, 27 Aug 2026 21:53:45 +0200 (CEST)
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
Subject: [PATCH 25/45] doc: chromium: update link to Developer Mode
Date: Thu, 27 Aug 2026 21:52:53 +0200
Message-ID: <20260827195313.129994-4-foss+uboot@0leil.net>
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

The current link just says to click on another link as the resource has
migrated, so simply use that new link instead.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/chromium/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/chromium/overview.rst b/doc/chromium/overview.rst
index 790233cb6688..23f224b30594 100644
--- a/doc/chromium/overview.rst
+++ b/doc/chromium/overview.rst
@@ -13,7 +13,7 @@ available:
    - Running U-Boot from the 'altfw' feature, which is available on selected
      Chromebooks from 2019 onwards (initially Grunt). Press '1' from the
      developer-mode screen to get into U-Boot. See here for details:
-     https://chromium.googlesource.com/chromiumos/docs/+/HEAD/developer_mode.md
+     https://www.chromium.org/chromium-os/developer-library/guides/device/developer-mode/
 
    - Running U-Boot from the disk partition. This involves signing U-Boot and
      placing it on the disk, for booting as a 'kernel'. See
