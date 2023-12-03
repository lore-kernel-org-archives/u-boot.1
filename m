Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C847EC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD9687717;
	Sun,  3 Dec 2023 14:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ISNpw8iV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k9T5YuYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77BA087617; Sun,  3 Dec 2023 14:17:15 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03FD087622
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4SjnQJ346Wz9sSx;
 Sun,  3 Dec 2023 14:17:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAM16HPky0ytTGjvf5ODHxuAqVmP4iHj0v0QNx3JgTg=;
 b=ISNpw8iVMg9xEFEYuUmq55WQ75NTg0N4akq+dwtDfv66ZHl8fC6EL9+Y+eMODQvBfkOfBe
 BVR3cO6J6riF0PjGZnsaCJEOwJiMeZ3zgwe5xRMwynwc4O9rRyZqTt5yjFJSXWHy9nZgs/
 +3sMey3stW6XPV+rhfOQbM/cYI0co4mbU4Vn0V/tI7fkLxUVa+Z1yBDGyWILvX+Bb6IHO7
 2sPvCzLUfpHB2nQEDzI47gV2HforWpJnzZhHFqvTm1Jfuql/xcX/svhpAgUzTiX1LgaoXT
 E0M/AyMH0jQgG830OLZMpiBrTvmKztYFElDlk66EveU+ARfptlpY5o5xa9doPw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAM16HPky0ytTGjvf5ODHxuAqVmP4iHj0v0QNx3JgTg=;
 b=k9T5YuYxugbgqzpUYX3LSp+TybxsLIXn1wpFo66vVi7yjMHChJwnFi2aNd3S3/umZkzupI
 K49oGcxCmXU+7Zj1NXOQBZ96hw4dm74S7dgEmBSezFm03o7QaNRv+mrpyFc1FRw263+JB+
 Oo/nQWNr0e+AC8DKd1nake9naUXIu36axIfr2dEB56tVDko6cBsUozR61uvG9znQRDyZVW
 Lb/kc5fpxCXPqau5zMJVp33a2WPdUtf7EheMxUYFa848Xg0MtCh1M0y7Q+5FFiKO6QFHll
 egeGvqlQJbDP/nezuczujqeuHzHo2U0OuU3Qn/9kEUsH83TQdqDObIkc+PPpww==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/12] clk: renesas: Synchronize RZ R8A774C0 RZ/G2E clock
 tables with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:19 +0100
Message-ID: <20231203131635.119191-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xs5rewisq8h7dkayno7n5k35gu51hu4e
X-MBO-RS-ID: e9beadcdd3c1e9163e9
X-Rspamd-Queue-Id: 4SjnQJ346Wz9sSx
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

Synchronize RZ R8A774C0 RZ/G2E clock tables with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 4768ceb0fa6..ec8ce6ad7d6 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -211,6 +211,7 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 	DEF_MOD("rpc-if",		 917,	R8A774C0_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A774C0_CLK_S3D2),
 	DEF_MOD("i2c5",			 919,	R8A774C0_CLK_S3D2),
+	DEF_MOD("adg",			 922,	R8A774C0_CLK_ZA2),
 	DEF_MOD("iic-pmic",		 926,	R8A774C0_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A774C0_CLK_S3D2),
 	DEF_MOD("i2c3",			 928,	R8A774C0_CLK_S3D2),
-- 
2.42.0

