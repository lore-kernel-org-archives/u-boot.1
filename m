Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B134AC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 19:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74E6080F01;
	Fri, 28 Aug 2026 19:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhEI_0G0rR4c; Fri, 28 Aug 2026 19:33:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787945629;
	bh=CxtFCezYO0efNEibd/XM1kMuCeC8H+3rEwKNbSpb23A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uagB3unFR5s6YP8luohVz6LUz8jKoQKAViaPDpPJzuY2G6xZd5YcuVUcWcIvlJgyA
	 rNLxB3eAnz3clWjOA52fnLIAkARc+WTvx/HIp9F3NTdiKp18kWucyGecnfml9XYgIV
	 Oee4kKLGKbGM+8UL/zxrwT1x6ErZvTDWdGEsceLG+VbsZUDfbjA0PKyomCaQrk/79A
	 P2rp49XVND4R8xdwW++kILLToZTvgWySxVW6R7zp2nryb2WFkN2VJ2GUeb/56f2TSQ
	 iBJL0EMfp9U+okkFQkX0BbYgIV59b2Sgkv3yTk3HrzzpCmcaCj8isPWosAO/hAVxkq
	 edCEGE56Krb5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94DDE80E0F;
	Fri, 28 Aug 2026 19:33:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 03915386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 19:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E92B4606B6
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 19:13:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndKeDIkvffM8 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 19:13:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a03:4000:8:213::1;
 helo=s1.jo-so.de; envelope-from=joerg@jo-so.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jo-so.de
Received: from s1.jo-so.de (unknown [IPv6:2a03:4000:8:213::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 097D660679
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 19:13:11 +0000 (UTC)
Received: from mail-relay (helo=jo-so.de)
 by s1.jo-so.de with local-bsmtp (Exim 4.98.2)
 (envelope-from <joerg@jo-so.de>) id 1x020f-0000000878X-44r2
 for u-boot@lists.u-boot-project.org; Fri, 28 Aug 2026 21:13:05 +0200
Received: from joerg by tux.jo-so.de with local (Exim 4.100-RC3)
 (envelope-from <joerg@jo-so.de>) id 1x020f-00000002qWZ-1F3G;
 Fri, 28 Aug 2026 21:13:05 +0200
From: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
To: u-boot@lists.u-boot-project.org
Cc: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
Subject: [PATCH] nfs: Handle NFSERR_IO as symlink
Date: Fri, 28 Aug 2026 21:10:17 +0200
Message-ID: <1d8518e3944411ede8e6be4e060e15d67ffb42f8.1787944217.git.joerg@jo-so.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Aug 2026 19:33:47 +0000
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

The Linux kernel's NFSd changed [1] its response code on access of symbolic
links to be RFC 1094 compliant. When a symbolic link is encountered in NFSv2
mode it returns no longer NFSERR_INVAL (22) but NFSERR_IO (5).

This change from 7.0-rc1 got backported to different other versions like
6.12.75 and 6.18.14. Therefore, U-Boot needs to handle this new response
code.

[1] https://lore.kernel.org/all/20251210002850.318350-3-cel@kernel.org/

Signed-off-by: Jörg Sommer <joerg@jo-so.de>
---

There's a discussion going how to hande this in the kernel:
https://lore.kernel.org/all/178791679053.3510150.70411349578293852@noble.neil.brown.name/

 net/nfs-common.c | 3 ++-
 net/nfs-common.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 637fcfd9bb8..ee24cd07196 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -855,7 +855,8 @@ void nfs_pkt_recv(uchar *pkt, unsigned int len)
 		if (rlen > 0) {
 			nfs_offset += rlen;
 			nfs_send();
-		} else if ((rlen == -NFSERR_ISDIR) || (rlen == -NFSERR_INVAL)) {
+		} else if ((rlen == -NFSERR_ISDIR) || (rlen == -NFSERR_INVAL) ||
+			   (rlen == -NFSERR_IO)) {
 			/* symbolic link */
 			nfs_state = STATE_READLINK_REQ;
 			nfs_send();
diff --git a/net/nfs-common.h b/net/nfs-common.h
index a19b98b7b1f..04671d3c87a 100644
--- a/net/nfs-common.h
+++ b/net/nfs-common.h
@@ -23,6 +23,7 @@
 
 #define NFSERR_PERM     1
 #define NFSERR_NOENT    2
+#define NFSERR_IO       5
 #define NFSERR_ACCES    13
 #define NFSERR_ISDIR    21
 #define NFSERR_INVAL    22
-- 
2.55.0

