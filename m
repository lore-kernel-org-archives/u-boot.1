Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC4C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB7C660801;
	Wed,  9 Sep 2026 20:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VNJRS1r7Am7v; Wed,  9 Sep 2026 20:44:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 457A360819
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986699;
	b=cdlZ8k+ooBItfwwZzv7Xo5v8nBLgxIomeFzwTQYb/yvc+myrc+V7uv6M1dS0Zwpvnxgt
	 XwZqBrDW3d7i35DxuR3DVEOXiHJJATUnQvUFvf7vcDcXN+QHKoV8Xpok3YrWoXVVe1Asf
	 se9QFacjhgNCC8MFQTfADkiyoG/mw0uTNHrRKusZGJ3g0RAxzFseOKjnZ8mwRtjVgtQKv
	 VskzqijS36aEbaH3d1JBcnvFWezcja7Aw0IgICYMrG8991XXR5+FdLdQdai0CGZBBI3Qj
	 aFDpmJzG6+kPANwlMPO0TFxDdC5yALu+gDxAS8g/8CoyvQsYJ0xaBfruCtL/0lNFRIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QPEUn9vFg6BSltIHK69X+GkdTZTZ6FSamem479G3ftU=;
	b=eL6iaCb2F+irU/XPUQSCGS9p2cpNiIB2j1b4ZKuYsLozjE1+VnAHRv094wlq8pYp7bek
	 B+6IpilPv8wZnJN7ej5MjjACRXx1BiGx2t0nPH7PuvaeO4smFVuRfJfblqKMMXlvgD5gq
	 Y8VpCah891RLwlpafF5eWt8RKlOw09LgOXuzqFAB5iTlx5F00KtZdoQWFDdVNdjCsKvU+
	 U8MloyXRBjUrJn/T6SCjFyuaOw4KQFNNrUsZsN/DvWrzDorh5j9UzkITw2jZIsNPL3qhP
	 t9fq8jTRSjuWaPWsx3EdjxvfpKqKQo4Q4dLdSDB4Ii5G8FvCY6YZcRABI/L7R+lyl/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986699;
	bh=QPEUn9vFg6BSltIHK69X+GkdTZTZ6FSamem479G3ftU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NpoWAunj87ETjVwMCs2WfoNfnN/RD1q2EG0jYvsXb7yzvIQmyPmPdJlf4NtCxbyzc
	 b6BHqwmS82LEhNOcS4wLMA59xyqWlmP2kN0iYccAHI3Kv9Ni3inm8bdugs/2JVRe5Q
	 CrNuTNGKxA5isFU52SZPgcgNO9c1yWpeDTHmcvx1X+o6F0WoMuQ9Yu9j41ierT6fD/
	 ehZaOKEEvB5SzlrjV8CAcaMCQ/MwsAzxs5UU8chDfmM4z8ZqrVaXHQq80qCMBzDb+Q
	 r9gzNveQW+7/gbEzOXfqLh/biex8/uYDcOHkLyqszBIckop7jqJFKGgEedJoOzmM8l
	 m/nona7bB4gNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 457A360819;
	Wed,  9 Sep 2026 20:44:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D93B432
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F38E14117F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mO6maWgA1kT for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:20:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6C7084117C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788981635;
 b=r5muw0QxXszdao3FYvihrxDovziDl1K/mCTTA1j+7r52imFfR9ae7Gf0nfSD9Uo4Rox9
 sO/695kjmFGOdie4XKcg8CdcOwZa3KMi1rVB6wl0YIeLh3wyf29MaB1KB1E6eg1+DpMem
 TMYshD/JKJJ/Vy4gXTJd1u6J44qIMTd1pmrSYcaR/j3sjmVh0kAO8adiFAtucVe3JfEaQ
 xxqaIRUEziAig0+GnA7oIuLudNfRDjGwUsoPmUQ1n2EpO/0BdFkXt/bDXvjgKgpuc1KSs
 7+wC4zJid/8+2wUWbYF2Q+cYbFHzDnVq+bI0D8S49yqdX2Ta/3EXFZwgNCKezkAVyfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788981635;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=QPEUn9vFg6BSltIHK69X+GkdTZTZ6FSamem479G3ftU=;
 b=amo/qUHPvsT+bbZLzGgAqyMneeC11/zWSjEv83/cWwqOPGbf8OHyKPxtbuMZrQ19TH7e
 NYgCDoJKNbAT/A7DeSG/wUX9uX3b0xGUy145DiG0WbTEdhON0zIP+35Vd3G9YYJkeliJj
 9kfpt+zk7gmJf1Bf/LUAuXNxXUSjbPT7cvhKwAX2FcurYlmCCcDd8MzxhR/PMwoEv8nLK
 Q8MMRUiolrVS/HFKf5/tCD8oWE9DSPXgCyPkm7p2DkuNA1bC3vpxbK7TAz296nyMNZPw6
 WGXV2iohz2c/Lh9R56xGa39I3Kgjbz5m+PZ5mcYuzSSIUNgKGbLGvEXtiWuatIu6B7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=MXCN1yT1; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=MXCN1yT1
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C7084117C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:35 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id A979B20B7169;
 Wed,  9 Sep 2026 12:19:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A979B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788981593;
 bh=QPEUn9vFg6BSltIHK69X+GkdTZTZ6FSamem479G3ftU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MXCN1yT14CBEjR+/X+E7t936TEYU2Bx4KlDPgJVbgr7HatrkMKFqbxJPVMV52YD8R
 UsIf2Edzg8d9vqIWZZVsD74yxUmPRjVbmDO44JQKM4iwB0i7D5oBF2oqkI5DVW7kXf
 AKQBzqg4EA99G12RZIu3BiE7IIWkpM05F7BPIJTU=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH 4/4] fs: ext4: widen ext4fs_update() block-group loop counter
Date: Wed,  9 Sep 2026 12:20:16 -0700
Message-ID: <20260909192016.217183-5-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 20:44:50 +0000
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

