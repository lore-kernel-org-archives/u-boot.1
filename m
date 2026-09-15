Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE00C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C50280ADA;
	Tue, 15 Sep 2026 20:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cG1Fgi1S1msX; Tue, 15 Sep 2026 20:52:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CECDD80AC8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789505544;
	b=Nl7uq+CVENpoSGfQeWgtw8/fptpSOXTRm0WF5xWNIQAF6RF3nteQbRI2REq/+6Nr6jkb
	 OtYG9FNLfu1+FRuoWfgo2nnqKAiSfQ8GVVmK9W6+Hrg2h0yIhk+RnFVEomfTznsOc+vb0
	 hmhfMelDCBfGzOVM84mbNWx3S9WN3ixXC60Un5lbFQgq1l1JzlOtID673brhDm3JLzwzy
	 4Br71mFxOJtRB5mXU+3FCesgGcv/mw9EzG/v7SXO9qGQZFs9zF5RN+1N8KskgYKpOrGHx
	 hipuqm8mG8MShy495enWmp+FlX+eVlqJog5oyyA9KtSZHtRfety3l+hrxEKDyemvKPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789505544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VogqdfzvwPfHNKF6QHdmAXyhr4c75JvEsr/oOIFx1Ps=;
	b=IoH4cQLVxEeIh/+9AC29/jDx9urkVQUTLUYtbTmDSRDyKxe/iV5RikdGqbMc4ii+S9Nx
	 Za6M0FUSfVc18ZHAIPAy8XtZb6/2qu+rpWZbFLI6bbMAXgomSsVsc+Nl5xJ7OowNnzsBN
	 Cz6BNWzQpoHHleUzX+D9DxywWWhEASdVhJ23xSbDjw4y33VGt2gus2Fp8EAm1uojwOE+z
	 8frzTybFHi2lMBtFtfBcHNk1tKKgmiq04DK/KjfewfCqBCmvF0grnsrBWzujlOk3z3GhE
	 MbEHEkkmgyCm0sjy925CJaLgp2phyrmrXc93GSWDSkAWSdkAC04qkNQiMQLSj8vAQ0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789505543;
	bh=VogqdfzvwPfHNKF6QHdmAXyhr4c75JvEsr/oOIFx1Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NJ8JoN7ULTkKmCzzcoAQtootkQRV2fsxbN8boP0vdQisz6hHxl4cPkmE4wR99Snl8
	 ElntCJO2cgJzTUpIQCGSqoOsq5Q1qh+0kpCPyckGYG8oT/3saOwGhKDAVtY0xkAQba
	 3+aI16yIXMakQOgbvxgPB2zR5ID2g/u+hIogiCd/UoK/uODtS9izBvlHgqokpe9s24
	 XTDxYzaixPM1M26xHTVqK/2tmQPKY5YwGEgoeF1msMchOKisvCSAYKKA2wOTooAfvr
	 /JHBRCdZXHNlhG2qUPay6flxaLUBVMW9S0rmTiJUlHsSUk20HTELNA55UJw5bD24pg
	 qgMy96KbV4Osg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CECDD80AC8;
	Tue, 15 Sep 2026 20:52:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A91AF23F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6FFB40231
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7iY0pAbJhZB for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:52:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1ECF840224
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789505542;
 b=s9P1Llsp5YRKJkgioAfcEdWyjcx+k4dBhuJdgKNmAlA/a0USlXvWmPDyiCJ6GWnDvPMQ
 3SIlSpYFMMTEsj1O6jiu2npGV383mv2+xA3nPTUUzNKdV5DVVQtME+t3gHvCXjw36Sw2c
 aFwPqianA4SpnSSXyCZtIuJzaHpFC9N3iF9g0x79b2NHGxQEtfavX+MJwJZ2nIzxsg7Mp
 vw6RwMK5wnvIYD0RdS4BXzGOMrYeJTqBwNJ55o38UaZSr/7rrC+61xdpICPs4BoBpwKmf
 rKLS9NFVWva83edc0hKvVV7kh/pBBAANH+R8mfUlF7pndnEEUoJVPh7QaeBPR6zAecg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789505542;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=VogqdfzvwPfHNKF6QHdmAXyhr4c75JvEsr/oOIFx1Ps=;
 b=a/kcaNNUztCWoXciWZrGVaTCLPmfd8KgVMdyZxBqWUMMu+uqTA2BOAXcFE8lWVuan1xj
 shcDwPi3dxoZoNUPJoE37UnTI4U9P0YpVJY38H6+L3jDAl390f4CyEMK1uQuyvj1w9JQ6
 JE3lm/BdXFBusI7B0B523yDStVws18meJCBPetpREcBDqKgLr32fl8EWmilSvvuxTs6eB
 shlNtNjeUqyxkBKh7ZGYz0MZbIshUN7GepdHzlkgnr9zkmFWfxhn3Pq+PIC9PCrA1cmP+
 sOU6PFHXxzxJk09Q6xt32DlD3fU63+CtoPIakeI+r+gC2I6H5CcOdNl9SrjKFvuOV6w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=ofObV3k4; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
 header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default
 header.b=ofObV3k4
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1ECF840224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:21 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id AB01720B716B;
 Tue, 15 Sep 2026 13:51:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB01720B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789505496;
 bh=VogqdfzvwPfHNKF6QHdmAXyhr4c75JvEsr/oOIFx1Ps=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ofObV3k4Ft7+rKCxfbDET1fJRdXVeUkPiLCeUyD7oNgOoBvcf/NOPnc0o0jQWvWM9
 ueALny43iouh+ndBocldRf5yIfXeziH3X/y3VWYpObinx0tMEcJY/Ru/X9gIhaevD9
 GTwWWs6NFcUzGkafzUGAMWFVu6jlBpAh5xVPa3f8=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
 counter
Date: Tue, 15 Sep 2026 13:52:10 -0700
Message-ID: <20260915205210.260404-4-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Daniel Munic <v-dmunic@microsoft.com>

ext4fs_update() iterates over all block groups with a signed 16-bit
loop counter:

	short i;
	...
	for (i = 0; i < fs->no_blkgrp; i++)

fs->no_blkgrp is a uint32_t. On a filesystem with more than 32767
block groups the counter cannot represent every index: incrementing
past SHRT_MAX is signed overflow (undefined behaviour) and the
comparison against the unsigned no_blkgrp never terminates correctly,
so the bitmap/group-descriptor write-back loops misbehave. The mixed
signed/unsigned comparison is also flagged by static analysis.

Use u32 for the loop counter, matching the width of no_blkgrp.

Signed-off-by: Daniel Munic <v-dmunic@microsoft.com>
Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
---
Changes in v2:
 - No change, rebased onto current master.

 fs/ext4/ext4_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 1abedcede72..2fba2197c19 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -67,7 +67,7 @@ static inline void ext4fs_bg_free_blocks_inc
 
 static void ext4fs_update(void)
 {
-	short i;
+	u32 i;
 	ext4fs_update_journal();
 	struct ext_filesystem *fs = get_fs();
 	struct ext2_block_group *bgd = NULL;
-- 
2.49.0

