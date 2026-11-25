Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B4606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PCiskPxH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NqW+qUAw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02A9B60892;
	Wed, 25 Nov 2026 12:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Of-kj5owPL3x; Wed, 25 Nov 2026 12:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 24AAA6089D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795610601;
	b=tJyD0CLQsAkV26HtQm07Iwg4+Y1n4BlWVSS+kjLDkv8wsRipgWo88YwNDrh5xIa96vwK
	 K0LbQyQh+JHM94z7iF/LAlYdhyTtp2w1FrECgpcvuQe1VT19vHOz7nmAB9EyvF9Z6R807
	 +QwxplmuF6k8ofXG3+xWTrI3wAGXqPSlCw5scD8YClNmNEOEQhtzRGAYIHgib0RvoljTo
	 RRTcIVmwTnEXsiEcyKB8cXg24ugSk2OUY/OJz0qzhQFUvXV7c4SxHwJ1fvZSN1p7I99Js
	 x7TkDl7SiTBbuTPYhjPr2VdKIxmlGlW/rhg0HMK1xQNWQ47YF6hwb9HuUfpRU9YAlpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795610601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=d6fCVOF7hMI1+IVsik436SzmOa7YOc3Bgu6cq9sqNMI=;
	b=AvDAVeK1SMjHMj9pnXHEzr6nGy6JNMWpqq20WBPW1LMbWVPUK0xBl2d0LJ1I+U1cUtWX
	 l+hn6SJ1Hqf4V44gXQhF2mSL0tpvhWO/pxDLdYGIBBWmZN6SoC0YsOzE17GytBpgTgtbD
	 9Bvg5+d2hHkdqTqvOBLW41UkMqu7elK0LheeP10tlrYPrLXK6h6OBuSUJ3NpJQcDxjNAs
	 Rb3Z22hLf7sFZWyKyyHR0b6YzxLJdgOBN7AhKjtH0yCq6ufu+r7HLP5vg9r9ZxG1lkvl8
	 sJ0cScHGZ+vl1iQJAOn7Im2Tuh5DB498f1tdoMg3nRIyzFTWV0G7UEijxHXL5EUDPJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795610601;
	bh=d6fCVOF7hMI1+IVsik436SzmOa7YOc3Bgu6cq9sqNMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PCiskPxHdcRsJryf8HTtbb8ijm1IfLPMyWAVAt5OM7bp3EGRLSsbdQYlLwyvn7ZMY
	 ZnvgSy1oCsibHRZLmnTfY9aO6ED97Fk1RH9ZgTwrd+Ym9OspNS8CCkk3EL8NawCr3H
	 3Rcyr6c86ztnBH7Ukc3A7My15FgGQcac0k5Rf1IXp7IhMxXmyOCr4WbgWzkLAuux3c
	 OElN6ilQt64xO9B+mXxqhjjQIyapF7aZoY4AE9CnNNAU8DJ4a3XQUq32tENDr7/lB0
	 F59z8NZE9WBtlIPynkzIlaqPMkurMLrN4FRE7D4GxcwO8wKB/2Pg+XUGcHgYVoMsgo
	 7uCNAoBTecF8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24AAA6089D;
	Wed, 25 Nov 2026 12:43:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6162C325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5346B80BB9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALNgICkmq5-u for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 39B2080851
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=NqW+qUAw
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 39B2080851
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:10 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso56454465e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610589; x=1796215389;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d6fCVOF7hMI1+IVsik436SzmOa7YOc3Bgu6cq9sqNMI=;
 b=NqW+qUAwkeWC9U8jAihEf1zwvGP2iDktXa+ZtQy+akhl6UpdALj4jbjbJMvWLtVLhd
 lv6UBOEdXjIRvpS3KhussYvWW/pH1/UMPfqXFNekjiVRvyEpP/2TtRyXnXKc+DBnbzsB
 m+Yme09LJSotPH58dud+ggdD6+7o7s9YLd4Mp5Tn3hUcd3ouxYcjBPuZTXYKLtl/vHID
 /jvU4Gll5sj+hUxRgmPYMj3hd/ctqL5PXZMALf7zazkMNnejmkqo3Ko2BzpgROgcJ0ne
 OiLXOZrAWML+8Tnkrzx3uGiB2D0EoabTGlsoGiY38Tu/PI/9hOvonuS/PHTaBQhpcFom
 h2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610589; x=1796215389;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d6fCVOF7hMI1+IVsik436SzmOa7YOc3Bgu6cq9sqNMI=;
 b=GzdnD6jrlkOBDYohSPnfge9bDhIozIIe7+P561Xq8ZAEpJWnDXDoSwBJrqQNreN0UN
 s5GwtlnCLvj41lj+lBJj3xiZm3+KYiAYstteRnsPybV5U0SquJB2zkR8pWv8SOqlRJ2y
 ODvjUZv1M71CtCCEkHMvtwTrUNJX/QrfMXzOHERUwCOyCGSnplqVX+iVy0b9DuRrzDkt
 gZJojgLLo8RrEsMQ1Ut1UKDxgV7xSAw1IUvw/O+fu1aNPxQk7LDIb2xdInOmA6LSQgyh
 RZxrg8Xl1Z1IdSQDECfX3zg+7wfgxndWGLswo8eMLVXRsdRrIRqubIAokaJY9Pa40lh3
 TqPQ==
X-Gm-Message-State: APuU4Z+qn5WOE1ikjz6gPekOpZklS3Mar10EO+2WQv1TI6+boBuxUXJg
 mXSBx/9NR9rTj3hcLUi/4Z2UdeB8Baa5Vzbx0NTLU/316fLxKh/3bnB1dgcXTtsi
X-Gm-Gg: AZFdTZecFdW0IYUMRtGYOa4H2uytL9dWWqxh/h2ogYJKkWn69F2JMKdzEB/7w03jpzZ
 lravxSOkDbUORKjENNfS1U9MiLulqJvSbCbI/oGfLsSJBBXIdcFX4EUWUNbcL39Urm8Z82v4/Zy
 jkVNXYOxF5BBXxzbN65Ts8cba6KFgw8YwdqZ7j2A2vSv1gejXL+Sm1yv5DbcGwRy5uOAY4Wt+gN
 IrCu9MIaGikxcol9Lr01CpUSAFk5jwznZNbWiKYoc0LyllKGC1dShLvijBli+rkLcF5/FG0/DHH
 JDLKlfzWyT+jk79JVRhJi0dLxzacG9d522wdCBIVp4054EmFm50suHzvOQAg2wlrwgV89fOiG+4
 4RwYrfKqnu+faJZVtay71YdBl73Rw+JS9sH/aoPHktX4zFhqNH0Apot54DG70XTpr0TvgT2Rog5
 Cnje76gp4ql3QnVGd0TP3+oRzUaQLderBy+a9/wC1fPWsnBR8rB2l2rutU+BcCPFZpUVvIqN75U
 Lg8lYKk+Ugf/F0n9XU/4ASHwZP3MUWpdEKcr+9+vcHrRlJ59MZhHEREuqeuj9BSoQ7G0hV4R2oa
 qb6NQCBlfsPnZlS0IwCnEVflkZvny0Pof/e8dLZMpnLge3P515uAk09/0UK2dd352/PEZZDMuvF
 G/YQNpNdUAdaAy1lcQDOpWfelKtW1mvq3nNZIiD3heP7z4YVq4vfINBk+0IUTnzcqY9mlOzGBG6
 DinIy0xDpJZ9fkJB54cHEqo+UyDuSPAeLL8qhLASdvafSn8ZtE2w2RHg==
X-Received: by 2002:a05:600c:848d:b0:4a4:3a2d:15da with SMTP id
 5b1f17b1804b1-4bb88812026mr337511905e9.15.1795610588798; 
 Wed, 25 Nov 2026 04:43:08 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-7575-e1e3-dbaf-96fb.ipv6.o2.cz.
 [2a00:1028:8388:a84e:7575:e1e3:dbaf:96fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm536486045e9.2.2026.11.25.04.43.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 04:43:08 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, linux-btrfs@vger.kernel.org,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 6/6] fs: btrfs: Avoid the remaining 64-bit divisions
Date: Wed, 25 Nov 2026 13:42:59 +0100
Message-ID: <20261125124259.95636-7-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 32-bit PowerPC, GCC turns the u64 divisions in btrfs_stripe_length()
and in the RAID5/6 code of __btrfs_map_block() into calls to
__udivdi3(), which U-Boot's private libgcc does not provide.
calc_stripe_length() has the same divisions.

U-Boot never runs these divisions. btrfs_stripe_length() and
calc_stripe_length() have no caller, and the RAID5/6 divisions sit in
the branch that fills a raid map, which needs a raid_map_ret. Both
callers of btrfs_map_block() set it to NULL. Builds of turris_1x_nor
and turris_1x_sdcard still link that branch, and with it __udivdi3().

Use div_u64(). Its divisors fit into 32 bits: num_stripes is a u32 or
an int and stripe_len is an int. full_stripe_len is the product of two
ints, so declare it as a u32.

linux/math64.h pulls in linux/log2.h, whose is_power_of_2() conflicts
with the copy in compat.h, which returns int instead of bool. Include
linux/log2.h in compat.h and drop the copy.

Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Tom Rini <trini@konsulko.com>
---
 fs/btrfs/compat.h  |  6 +-----
 fs/btrfs/volumes.c | 19 +++++++++++--------
 fs/btrfs/volumes.h |  9 +++++----
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index e6784884835..f973f3f1185 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -4,6 +4,7 @@
 #define __BTRFS_COMPAT_H__
 
 #include <linux/errno.h>
+#include <linux/log2.h>
 #include <fs_internal.h>
 #include <u-boot/uuid.h>
 
@@ -74,9 +75,4 @@ static inline void uuid_unparse(const u8 *uuid, char *out)
 	return uuid_bin_to_str((unsigned char *)uuid, out, 0);
 }
 
-static inline int is_power_of_2(unsigned long n)
-{
-	return (n != 0 && ((n & (n - 1)) == 0));
-}
-
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 71b0b55b9c6..fcb20a761f5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2,6 +2,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <fs_internal.h>
+#include <linux/math64.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "volumes.h"
@@ -825,17 +826,17 @@ u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
 		stripe_len = chunk_len;
 		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
-		stripe_len = chunk_len / num_stripes;
+		stripe_len = div_u64(chunk_len, num_stripes);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
-		stripe_len = chunk_len / (num_stripes - 1);
+		stripe_len = div_u64(chunk_len, num_stripes - 1);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID6:
-		stripe_len = chunk_len / (num_stripes - 2);
+		stripe_len = div_u64(chunk_len, num_stripes - 2);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
-		stripe_len = chunk_len / (num_stripes /
-				btrfs_chunk_sub_stripes(leaf, chunk));
+		stripe_len = div_u64(chunk_len, num_stripes /
+				     btrfs_chunk_sub_stripes(leaf, chunk));
 		break;
 	default:
 		/* Invalid chunk profile found */
@@ -1085,17 +1086,19 @@ again:
 			int rot;
 			u64 tmp;
 			u64 raid56_full_stripe_start;
-			u64 full_stripe_len = nr_data_stripes(map) * map->stripe_len;
+			u32 full_stripe_len = nr_data_stripes(map) * map->stripe_len;
 
 			/*
 			 * align the start of our data stripe in the logical
 			 * address space
 			 */
-			raid56_full_stripe_start = offset / full_stripe_len;
+			raid56_full_stripe_start = div_u64(offset,
+							   full_stripe_len);
 			raid56_full_stripe_start *= full_stripe_len;
 
 			/* get the data stripe number */
-			stripe_nr = raid56_full_stripe_start / map->stripe_len;
+			stripe_nr = div_u64(raid56_full_stripe_start,
+					    map->stripe_len);
 			stripe_nr = stripe_nr / nr_data_stripes(map);
 
 			/* Work out the disk rotation on this stripe-set */
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9d1a07ae789..d66547c6c10 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -4,6 +4,7 @@
 #define __BTRFS_VOLUMES_H__
 
 #include <fs_internal.h>
+#include <linux/math64.h>
 #include "ctree.h"
 
 #define BTRFS_STRIPE_LEN	SZ_64K
@@ -138,16 +139,16 @@ static inline u64 calc_stripe_length(u64 type, u64 length, int num_stripes)
 
 	if (type & BTRFS_BLOCK_GROUP_RAID0) {
 		stripe_size = length;
-		stripe_size /= num_stripes;
+		stripe_size = div_u64(stripe_size, num_stripes);
 	} else if (type & BTRFS_BLOCK_GROUP_RAID10) {
 		stripe_size = length * 2;
-		stripe_size /= num_stripes;
+		stripe_size = div_u64(stripe_size, num_stripes);
 	} else if (type & BTRFS_BLOCK_GROUP_RAID5) {
 		stripe_size = length;
-		stripe_size /= (num_stripes - 1);
+		stripe_size = div_u64(stripe_size, num_stripes - 1);
 	} else if (type & BTRFS_BLOCK_GROUP_RAID6) {
 		stripe_size = length;
-		stripe_size /= (num_stripes - 2);
+		stripe_size = div_u64(stripe_size, num_stripes - 2);
 	} else {
 		stripe_size = length;
 	}
-- 
2.54.0 (Apple Git-157)

