Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80923C54F4D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 17:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F559608C6;
	Tue, 28 Jul 2026 17:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uF4kxauXz0I9; Tue, 28 Jul 2026 17:54:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FA2C608D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785261256;
	bh=Yk6XGEED0V/tAmivdZotWlY3/O77+RJG+puPb/JX6pg=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Cx/1QbK8h/VArv/YBYa64rMugPY4AFsX1122hB/1QeLU6Qcq8p871DmxP68TP3km2
	 zcIspg5SiMky9820Jofd+5VjpHCyn+oASaBfPDP59LbkIBQyHUolt/jdfAOqvwgNTI
	 lWe2aK2WC8ZUI8jSAHcIOTXsDrS2Vsr6USSDZ0+bd/wcgLBM2fe+oLlpbq4TA/4KxY
	 qYiCAJGNa6BWNgp+WEsaQmUyBpiqhyHIfoiqExeUk9CTZzqlsNpjHiNy/T4Oh7GUVt
	 v7FuJCNDAlCt7ebIvJrywUGUv8dl00zrrvCIimVtsW7rhbdwCE0B6Q+6ajbzhLzTjC
	 jkdPrbGC2cBfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FA2C608D0;
	Tue, 28 Jul 2026 17:54:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EBBDB490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1B5A40975
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kQwxiLWNnpmM for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:54:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4CACB4096A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CACB4096A
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CACB4096A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:54:13 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h8jl719LPzMlGM;
 Tue, 28 Jul 2026 19:54:11 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: cmd: gpt: Reinstate gpt setenv
Date: Tue, 28 Jul 2026 19:53:38 +0200
Message-ID: <20260728175407.90993-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 91sc5uru7bmi1j4bhfbb78gepofedxcn
X-MBO-RS-ID: 6d2591c10b658a8e7a1
X-Rspamd-Queue-Id: 4h8jl719LPzMlGM
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785261251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yk6XGEED0V/tAmivdZotWlY3/O77+RJG+puPb/JX6pg=;
 b=D8M+PGVMmbGJm223Nqt98wdL8IszivrhiCCoIlRyDNOwPjVZY6ducrkHlw7tFrME/2sZZB
 vsJPdffboDFhM++OwdFATSVp+wSsOLYucIVM98XgRReoBTrNMcx73YepIvui57qBU0DuzK
 bkLf6TfYTaR8CyJpZurAdOwiyAv0JOj4pSK2PGYunayCrcBNHFFx3EytmggZW3QbUHyvm5
 82Q6gf3UXKMWaMIuYFxz5BddNSBFyeJ1nSIXAv051NM3D9REGCvtB64metdiK5jhWsLpr5
 OdNg/VrJUuq1yh/uUylnl1m3fkX02eLCXoMAFk4mvFNCV5fhreUtHfsr1fJ3lQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785261249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yk6XGEED0V/tAmivdZotWlY3/O77+RJG+puPb/JX6pg=;
 b=wJajPfRVo53/MRFlV6XjXqmHiFsMKy3Ec5HZOEtSY7HpXwd7m+BuTXWhNYRIXPJPYudd6m
 AXBse6wiDQACyRnTka/cgIWSjNBvmLYrlz1CBVG0WNfr+fDAOKk1fcat4pUbZxYwDoR92G
 YjfixoT8JZS1QZ+0mpzy3H5c6Jd7xgeOeuAItKh375yQ5RotSdNm0MeHOMWgmPXogTqVH+
 mNnibc68epdtR43IpXSx4ZAwUtj33BalQ7XgGtxUZ/73mmPppZ3HFcLQrPY+yWI1ufEFRn
 TwtluZ6AfZuWOHuEfxbM2N8AyTZ1oOk+FzIFQ6RLxaLSLk0M+c8sR4GAHsd4xg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=D8M+PGVM; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=wJajPfRV
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wJajPfRV;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Commit dc3765ede5a4 ("doc: Switch from setenv to env set") was
too eager to switch "setenv" to "env set" and also incorrectly
rewrote "gpt setenv" to "gpt env set". Undo this error.

Fixes: dc3765ede5a4 ("doc: Switch from setenv to env set")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 doc/usage/cmd/gpt.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index a2f116d05ad..6afc634eb0a 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -119,10 +119,10 @@ Sets the bootable flag for all partitions in the table. If the partition name
 is in 'partition list' (separated by ','), the bootable flag is set, otherwise
 it is cleared. CONFIG_CMD_GPT_RENAME=y is required.
 
-gpt env set
-~~~~~~~~~~~
+gpt setenv
+~~~~~~~~~~
 
-The 'gpt env set' command will set a series of environment variables with
+The 'gpt setenv' command will set a series of environment variables with
 information about the partition named '<partition name>'. The variables are:
 
 gpt_partition_addr
@@ -199,7 +199,7 @@ $gpt_parts::
 
 Get the information about the partition named 'rootfs'::
 
-    => gpt env set mmc 0 rootfs
+    => gpt setenv mmc 0 rootfs
     => echo ${gpt_partition_addr}
     2000
     => echo ${gpt_partition_size}
@@ -231,19 +231,19 @@ Set the bootable flag for the 'boot' partition and clear it for all others::
 
 Swap the order of the 'boot' and 'rootfs' partition table entries::
 
-    => gpt env set mmc 0 rootfs
+    => gpt setenv mmc 0 rootfs
     => echo ${gpt_partition_entry}
     2
-    => gpt env set mmc 0 boot
+    => gpt setenv mmc 0 boot
     => echo ${gpt_partition_entry}
     1
 
     => gpt transpose mmc 0 1 2
 
-    => gpt env set mmc 0 rootfs
+    => gpt setenv mmc 0 rootfs
     => echo ${gpt_partition_entry}
     1
-    => gpt env set mmc 0 boot
+    => gpt setenv mmc 0 boot
     => echo ${gpt_partition_entry}
     2
 
-- 
2.53.0

