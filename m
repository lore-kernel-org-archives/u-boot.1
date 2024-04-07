Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB71EC67861
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 02:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB4E687FF2;
	Sun,  7 Apr 2024 04:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mailtundra.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailtundra.com header.i=@mailtundra.com header.b="ve4PfO7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD1C87FEE; Sun,  7 Apr 2024 03:47:50 +0200 (CEST)
Received: from mail-4329.protonmail.ch (mail-4329.protonmail.ch [185.70.43.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 149F387FBF
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 03:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mailtundra.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwleeds@mailtundra.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailtundra.com;
 s=protonmail2; t=1712454468; x=1712713668;
 bh=OfdFunpK6W/nBZ3AuyJzEoVsclhAcF+vnTjIVMHgNUA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ve4PfO7hALmaGkP2DfnhwHKWK+yxNv88ek4noLM+VZ64GSk7VNs0LoQj620hwNwGu
 2XHIKRtqlX0Ph2qaYNBfJ4KidWsM23Yy5QUhZQn+9xi54Bao+ul1Yc1OXyPlM4bsCx
 PivnpcoEN/VcfyMtnDmiG2Ym9iFr83UCQJymrPRyU3JeFrhSbhH8mOYt1iV4MYgH6Z
 5D0UNp94iXcGv3E7/WgvIM9+bKRIgW+7s46/X4K3v/zcZYAi9JIm4h44oJfWyYW9o2
 X/8CTt8S85oA2BtQO00FzX7Teixi1bsA618rWGqjNpardLbi8WOj3mEKAlPG0fYJf5
 emxZ18CoqV/Lw==
X-Pm-Submission-Id: 4VBw8g3s6Hz4wwdS
From: mwleeds@mailtundra.com
To: u-boot@lists.denx.de
Cc: Phaedrus Leeds <mwleeds@mailtundra.com>
Subject: [PATCH 2/5] zfs: Add a comment to clarify nvlist memory layout
Date: Sat,  6 Apr 2024 18:47:26 -0700
Message-ID: <20240407014743.13872-3-mwleeds@mailtundra.com>
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

Signed-off-by: Phaedrus Leeds <mwleeds@mailtundra.com>
Tested-by: Phaedrus Leeds <mwleeds@mailtundra.com>
---
 fs/zfs/zfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 14779dee32..61d58fce68 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -1610,20 +1610,25 @@ zfs_nvlist_lookup_nvlist(char *nvlist, char *name)
 {
 	char *nvpair;
 	char *ret;
 	size_t size;
 	int found;
 
 	found = nvlist_find_value(nvlist, name, DATA_TYPE_NVLIST, &nvpair,
 							  &size, 0);
 	if (!found)
 		return 0;
+
+	/* Allocate 12 bytes in addition to the nvlist size: One uint32 before the
+	 * nvlist to hold the encoding method, and two zero uint32's after the
+	 * nvlist as the NULL terminator.
+	 */
 	ret = calloc(1, size + 3 * sizeof(uint32_t));
 	if (!ret)
 		return 0;
 	memcpy(ret, nvlist, sizeof(uint32_t));
 
 	memcpy(ret + sizeof(uint32_t), nvpair, size);
 	return ret;
 }
 
 int
-- 
2.44.0

