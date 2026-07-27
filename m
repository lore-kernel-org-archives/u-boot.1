Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C52C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 878FB406D2;
	Mon, 27 Jul 2026 11:29:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UoWXKkl6O6e6; Mon, 27 Jul 2026 11:29:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E79B40675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785151773;
	bh=nkRBB7CRg4y6BxdCxbNg3/N73pmciDjs+SbJONoFHcI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fB9B7UfyF2THvr7DAI7OI/rbfc2NH+EhfG/1iq+ctyiCXEho6M3Kb2UXahlAR4pXM
	 vnzXRp1r4EXKC+xiXA0FlSOMSBBohjDb1njE5YciSGtOAtiCkmZlpSFGR7VLQzhC4t
	 KQyitVeDS6Li105KjLyrgev3K/O8+qP3YkkblsVRU/P1XgaMKgzIVat+F3hsElRob2
	 XAWSobZ4mxAmiSew5bbQrks8UWWAgpO9R52J2JI7/ULi5PnpeylbyC4HrqVuSBTgkd
	 wgdttfOzXL1gKAczlkdTmsqBge6Gq/iY5/QTrVjWh3tlEQyu2cZ8WfgFKENdH60fmC
	 NypvLexaBPbKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E79B40675;
	Mon, 27 Jul 2026 11:29:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B024350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 695394006A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jlc2XvKKN_q7 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:29:30 +0000 (UTC)
X-Greylist: delayed 1130 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 27 Jul 2026 11:29:29 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9707140065
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9707140065
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9707140065
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:29:29 +0000 (UTC)
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJEB-000JA2-38; Mon, 27 Jul 2026 13:10:36 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJEB-0000IM-1t; Mon, 27 Jul 2026 13:10:35 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 u-boot@ew.tq-group.com, u-boot@lists.u-boot-project.org,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [RESEND] configs: tqma6ul: add support for redundant environment
Date: Mon, 27 Jul 2026 13:08:32 +0200
Message-ID: <20260727110834.26653-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=nkRBB7CRg4y6BxdCxbNg3/N73pmciDjs+SbJONoFHcI=; b=aLtdYT1g1AkmtvKTsvMmQWC1kP
 wD1LYVQ/eECGZHMHe4EFZw1PWY3esKRUEbOVW8RRdfSQmuaUgiG/JZcGNNoFuEmyhAorj/lzBREzT
 UemTI4dQEJgCC3xXSEbeilcIPC7IGsh7yfuJktK4sSoCFfRD+XQUm74u3OksZYj+cuETD5Ud3913E
 pg5nmWfqKcO2jpPffRVIwuqmnkvjVxEqUJgm9meUZpSfGaSXzKm0Ie8qUDDYRJgWgMZlGQr/BlN5x
 TfdCi1zNXIFJZVc6Xz/OzzzDykL1g2PYdSGS/iGWlis6PC8eL+kqW9y7cJnNffIZao08SfYTlKzL9
 3WwB9upQ==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=aLtdYT1g
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Activate the redundant environment and set the required offset.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---

Resend to the new U-Boot mailing list after the project moved to
u-boot@lists.u-boot-project.org. The series has also been rebased
to branch onto main. No functional changes.

Link: https://lore.kernel.org/all/20260715064618.462554-1-Max.Merchel@ew.tq-group.com/

 configs/tqma6ul_common.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/tqma6ul_common.config b/configs/tqma6ul_common.config
index c076fb5d295..6b1fecb9071 100644
--- a/configs/tqma6ul_common.config
+++ b/configs/tqma6ul_common.config
@@ -18,6 +18,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x88000000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x110000
 CONFIG_IMX_MODULE_FUSE=y
 CONFIG_SYS_MEMTEST_START=0x82000000
 CONFIG_SYS_MEMTEST_END=0x83000000
@@ -76,6 +77,7 @@ CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_ROOTPATH="/srv/nfs"

base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
-- 
2.43.0

