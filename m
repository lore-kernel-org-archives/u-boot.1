Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D95CFF8864
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6478842A2;
	Tue, 28 Apr 2026 05:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=archcloudlabs.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=archcloudlabs.com header.i=@archcloudlabs.com header.b="AX9jK1MJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809A48426C; Tue, 28 Apr 2026 05:14:49 +0200 (CEST)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675CB84258
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=archcloudlabs.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dllcoolj@archcloudlabs.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archcloudlabs.com;
 s=key1; t=1777336307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gzWyTQ54ibAMIDGAOoDibXbskSUiC+tw4kNw87MOoCY=;
 b=AX9jK1MJJUSqyJPPxyk4Xd6gxWXs1HKRVlPt9ImT2x2opNs7PJf/leYmxSvRxXeiU7ybvc
 XcBjqvIhC6KmaLL781IFfuRv9sSEVkWsqN4MWnAnFCeZ19USyEHwji3IiL2K01hGdtP756
 3sTr2pB6i/GhviZceNhjexn3DrADaGxAdn3g7YvQ3HKbpDMe1KuYdwzZnCZUs1w/LLTSzX
 hPSv34sRJ7BJ+2wyNE3dwMPZISXIM8fDMPE9NddfWVKPAThuG+6HASrF3e96GqzcbvYd7l
 4n0QRCZ85D5U5+w9qyl/aDg/VjE4SXPjM7MCkH0uTuVfQ0ecNrmQOrExumrvLw==
From: Jared Stroud <dllcoolj@archcloudlabs.com>
To: u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 trini@konsulko.com, Jared Stroud <dllcoolj@archcloudlabs.com>
Subject: [PATCH] adding check to prevent overflow in sqfs_find_inode
Date: Mon, 27 Apr 2026 20:31:00 -0400
Message-ID: <20260428003100.123201-1-dllcoolj@archcloudlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

While fuzzing attributes of the squashfs_reg_inode structure, if the file_size attribute is a large value,
&base->inode_number within the sqfs_find_inode function will jump to an arbitrary location 
in memory resulting in a invalid memory access and crash.
This bug is similar to CVE-2024-57254 in that memory operations are occurring based on inode values.                                               
I applied a similar fixed via the commmit c8e929e5758999933f9e905049ef2bf3fe6b140d.

Prior to the fix, the bug was triggered via the following commands from
the U-Boot shell:

```
=> host bind 0 random3.sqfs
=> ls host 0 /
AddressSanitizer:DEADLYSIGNAL
=================================================================
==122741==ERROR: AddressSanitizer: SEGV on unknown address 0x0000670e4716 (pc 0x55a504b86ea6 bp 0x000019af1280 sp 0x7fff04b3b740 T0)
==122741==The signal is caused by a READ memory access.
    #0 0x55a504b86ea6 in sqfs_find_inode fs/squashfs/sqfs_inode.c:131
    #1 0x55a504b7f17e in sqfs_search_dir fs/squashfs/sqfs.c:489
    #2 0x55a504b80ffb in sqfs_opendir_nest fs/squashfs/sqfs.c:977
    #3 0x55a504b426e9 in fs_opendir fs/fs.c:669
    #4 0x55a504b42a6d in fs_ls_generic fs/fs.c:66
    #5 0x55a504b42dc8 in fs_ls fs/fs.c:537
    #6 0x55a504b42dc8 in do_ls fs/fs.c:881
    #7 0x55a504b42dc8 in do_ls.isra.0 fs/fs.c:870
    #8 0x55a504a0eb40 in cmd_call common/command.c:582
    #9 0x55a504a0eb40 in cmd_process common/command.c:637
    #10 0x55a5049f00c4 in run_pipe_real common/cli_hush.c:1672
    #11 0x55a5049f00c4 in run_list_real common/cli_hush.c:1868
    #12 0x55a5049f0800 in run_list common/cli_hush.c:2017
    #13 0x55a5049f0800 in parse_stream_outer common/cli_hush.c:3207
    #14 0x55a50492efcc in parse_file_outer common/cli_hush.c:3299
    #15 0x55a50492efcc in cli_loop common/cli.c:306
    #16 0x55a50492efcc in main_loop common/main.c:86
    #17 0x55a50492efcc in run_main_loop common/board_r.c:584
    #18 0x55a50492efcc in initcall_run_r common/board_r.c:776
    #19 0x55a50492efcc in board_init_r common/board_r.c:806
    #20 0x55a50492efcc in sandbox_main arch/sandbox/cpu/start.c:584
    #21 0x7f60aa6276c0  (/usr/lib/libc.so.6+0x276c0) (BuildId: ca0db5ab57a36507d61bbcf4988d344974331f19)
    #22 0x7f60aa6277f8 in __libc_start_main (/usr/lib/libc.so.6+0x277f8) (BuildId: ca0db5ab57a36507d61bbcf4988d344974331f19)
    #23 0x55a50491e414 in _start (/usr/src/u-boot/u-boot+0x285414) (BuildId: 964ae5120238bc46d7af63402fa25331ca86b3b4)

==122741==Register values:
rax = 0x00000000670e470a  rbx = 0x000055a504ef7100  rcx = 0x0000000000020000  rdx = 0x0000000000000000  
rdi = 0x0000000000006fd5  rsi = 0x0000000000007abd  rbp = 0x0000000019af1280  rsp = 0x00007fff04b3b740  
 r8 = 0x000000004d5f348a   r9 = 0x00000000670e4716  r10 = 0x0000000000000501  r11 = 0x0000000000000001  
r12 = 0x0000000000000002  r13 = 0x0000000000000001  r14 = 0x00000000199caa00  r15 = 0x0000000000000001  
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV fs/squashfs/sqfs_inode.c:131 in sqfs_find_inode
```


Post-patch, the following behavior is observed:
=> host bind 0 random3.sqfs
=> ls host 0 /
Error while searching inode: unknown type.


Signed-off-by: Jared Stroud <dllcoolj@archcloudlabs.com>
---
 fs/squashfs/sqfs_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index ce9a8ff8e2a..d2efc07c78e 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -135,6 +135,9 @@ void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
 		if (sz < 0)
 			return NULL;
 
+		if (__builtin_add_overflow(offset, sz, &offset))
+			return NULL;
+
 		offset += sz;
 	}
 
-- 
2.54.0

