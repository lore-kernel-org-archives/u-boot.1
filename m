Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79787C67861
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 02:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F3888027;
	Sun,  7 Apr 2024 04:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mailtundra.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailtundra.com header.i=@mailtundra.com header.b="AWAWDu1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2834687FCD; Sun,  7 Apr 2024 03:47:52 +0200 (CEST)
Received: from mail-4330.protonmail.ch (mail-4330.protonmail.ch [185.70.43.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B6287FC8
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 03:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mailtundra.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwleeds@mailtundra.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailtundra.com;
 s=protonmail2; t=1712454469; x=1712713669;
 bh=p0rExyWmX/OLYZLhs3iFjYNgr15eXExBop6+L+cwjwA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=AWAWDu1ZGjh5BWaivLQFvwRghYlZ0uVRAez95R84IuYhWdFYp9Dlza9r9prn1F0Bt
 fnW3L14nJ2M/9fy22PxdfA2LJMbpvIngNwJkHexLUL2DT0ipGaPJCLDCsjrO6SNgud
 ffto9vU9W3ZXqboJnRBe9ADm/XpIzzHRn1c/37dm/UzGvVRE2KoEulN/QVlddVkhpH
 RdtJ6DslMyX+w9MI+IOs2K/sC/52H7HoGCGyFzrEzV0SGJrPtMym7Utd9MK3ytS4lE
 KnzbsqrUv+Kkghxbv9H8YQ/BGWm76TifLqSWdRzL/FstwuSPD9mpXo5GphH7er4IBC
 kC4fg46ETqTQw==
X-Pm-Submission-Id: 4VBw8h5Ppfz4wwdR
From: mwleeds@mailtundra.com
To: u-boot@lists.denx.de
Cc: Phaedrus Leeds <mwleeds@mailtundra.com>
Subject: [PATCH 3/5] zfs: Fix unaligned read of uint64
Date: Sat,  6 Apr 2024 18:47:27 -0700
Message-ID: <20240407014743.13872-4-mwleeds@mailtundra.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240407014743.13872-1-mwleeds@mailtundra.com>
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Apr 2024 04:00:03 +0200
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

Without this patch, when trying to boot zfs using U-Boot on a Jetson TX2
NX (which is aarch64), I get a CPU reset error like so:

"Synchronous Abort" handler, esr 0x96000021
elr: 00000000800c9000 lr : 00000000800c8ffc (reloc)
elr: 00000000fff77000 lr : 00000000fff76ffc
x0 : 00000000ffb40f04 x1 : 0000000000000000
x2 : 000000000000000a x3 : 0000000003100000
x4 : 0000000003100000 x5 : 0000000000000034
x6 : 00000000fff9cc6e x7 : 000000000000000f
x8 : 00000000ff7f84a0 x9 : 0000000000000008
x10: 00000000ffb40f04 x11: 0000000000000006
x12: 000000000001869f x13: 0000000000000001
x14: 00000000ff7f84bc x15: 0000000000000010
x16: 0000000000002080 x17: 00000000001fffff
x18: 00000000ff7fbdd8 x19: 00000000ffb405f8
x20: 00000000ffb40dd0 x21: 00000000fffabe5e
x22: 000000ea77940000 x23: 00000000ffb42090
x24: 0000000000000000 x25: 0000000000000000
x26: 0000000000000000 x27: 0000000000000000
x28: 0000000000bab10c x29: 00000000ff7f85f0

Code: d00001a0 9103a000 94006ac6 f9401ba0 (f9400000)
Resetting CPU ...

This happens when be64_to_cpu() is called on a value that exists at a
memory address that's 4 byte aligned but not 8 byte aligned (e.g. an
address ending in 04). The call stack where that happens is:
check_pool_label() ->
zfs_nvlist_lookup_uint64(vdevnvlist, ZPOOL_CONFIG_ASHIFT,...) ->
be64_to_cpu()

Signed-off-by: Phaedrus Leeds <mwleeds@mailtundra.com>
Tested-by: Phaedrus Leeds <mwleeds@mailtundra.com>
---
 fs/zfs/zfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 61d58fce68..9a50deac18 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -1552,35 +1552,53 @@ nvlist_find_value(char *nvlist, char *name, int valtype, char **val,
 			if (nelm_out)
 				*nelm_out = nelm;
 			return 1;
 		}
 
 		nvlist += encode_size;	/* goto the next nvpair */
 	}
 	return 0;
 }
 
+int is_word_aligned_ptr(void *ptr) {
+	return ((uintptr_t)ptr & (sizeof(void *) - 1)) == 0;
+}
+
 int
 zfs_nvlist_lookup_uint64(char *nvlist, char *name, uint64_t *out)
 {
 	char *nvpair;
 	size_t size;
 	int found;
 
 	found = nvlist_find_value(nvlist, name, DATA_TYPE_UINT64, &nvpair, &size, 0);
 	if (!found)
 		return 0;
 	if (size < sizeof(uint64_t)) {
 		printf("invalid uint64\n");
 		return ZFS_ERR_BAD_FS;
 	}
 
+	/* On arm64, calling be64_to_cpu() on a value stored at a memory address
+	 * that's not 8-byte aligned causes the CPU to reset. Avoid that by copying the
+	 * value somewhere else if needed.
+	 */
+	if (!is_word_aligned_ptr((void *)nvpair)) {
+		uint64_t *alignedptr = malloc(sizeof(uint64_t));
+		if (!alignedptr)
+			return 0;
+		memcpy(alignedptr, nvpair, sizeof(uint64_t));
+		*out = be64_to_cpu(*alignedptr);
+		free(alignedptr);
+		return 1;
+	}
+
 	*out = be64_to_cpu(*(uint64_t *) nvpair);
 	return 1;
 }
 
 char *
 zfs_nvlist_lookup_string(char *nvlist, char *name)
 {
 	char *nvpair;
 	char *ret;
 	size_t slen;
-- 
2.44.0

