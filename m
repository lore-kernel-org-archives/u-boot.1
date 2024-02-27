Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCBCC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 835B388047;
	Tue, 27 Feb 2024 17:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fT3kK0MY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E30fWP36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2161888049; Tue, 27 Feb 2024 17:10:29 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C3188027
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TkjBT2ZVdz9snc;
 Tue, 27 Feb 2024 17:10:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PesjVh+xCY4KzF1lcXQxcPG/f5XZBjuHl/o0n3n7YAM=;
 b=fT3kK0MYbYg1r764/igQem1w8qtOfAHrNXAYo1rciVKHMhw2tQ9cQFg/gLdtZwK5/e8x+5
 Zk51MQUyTit/k8nwv0m+845ZkkdQc9Fi88HYzwPwMVvUhooVn5/JyHcVjH8iuulc0Lwg5f
 XPX1E4V1SMEzQDgm5orhBq8VtcyjNHZFJ3gg62nMrnHN1lzKNCQRpZ4RFI7axdoQez+8w/
 qxq3TbCcJwxJo4GnVlocyoADx+JO55uzJDa1g1gSqdJl0WVrRNRodm0M1VdqtMMgJuEWs+
 v8T/SDhfsQUfR4N6BTLWRpM1ylWhohLzHg9IxmQrXW88Be06xMCzx48t8mkTkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PesjVh+xCY4KzF1lcXQxcPG/f5XZBjuHl/o0n3n7YAM=;
 b=E30fWP36iuWlq/axnNWHFrgEV/+jaX6XI6YSKrlOMaqGvMKE6DMAynCgrJu+iT4rc8B/Jn
 /TN3CU8j9JiRE7GLWoTVcA8izF36mdEJllu9agwUwXrqzYG1ovoQWWUzd27un0ng158xa6
 u0EJe3NJTKke9EtbpqqVPQduuv3uoCTXd/aaxs3NbiA8xPINS6PAG3oDvAt1cevI4mnoZA
 eaWl4aq8dsulnGmCk6XFpXvrg0M9sX/Tip2swEwUpY0tB4arDD69sXlq5p+G6OLefHVJKI
 4JHj0v4EpEnLD89XzEkVrwKEEiEyzADe42iKmRZDXcBURKwYrKEZnKvG24T65Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/19] git-mailrc: Add renesas entry and update rmobile entry
Date: Tue, 27 Feb 2024 17:05:59 +0100
Message-ID: <20240227160912.412181-20-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o99zodmagufk4rbh5tn7whrcuytyy894
X-MBO-RS-ID: 435c01bb6cbe5f948f0
X-Rspamd-Queue-Id: 4TkjBT2ZVdz9snc
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

Add new renesas entry and update rmobile entry to match.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 doc/git-mailrc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/git-mailrc b/doc/git-mailrc
index 0ceb9eb88b5..ca2f67a3b6e 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -66,7 +66,8 @@ alias imx            uboot, sbabic
 alias kirkwood       uboot, stroese
 alias omap           ti
 alias pxa            uboot, marex
-alias rmobile        uboot, iwamatsu
+alias renesas        uboot, marex, iwamatsu
+alias rmobile        uboot, marex, iwamatsu
 alias s3c            samsung
 alias s5pc           samsung
 alias samsung        uboot, prom
-- 
2.43.0

