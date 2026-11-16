Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E04606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PmauiiiS;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdkJNpk9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2844D605CB;
	Tue, 17 Nov 2026 04:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZqWhZbJE390W; Tue, 17 Nov 2026 04:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6DAD1605DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794890084;
	b=pHWKSe6fiucFy+/KL/Ta1eNNHbUiiPM/TxWT8gY2aJUac1a7R+Nkws94OGfG2/9LYYGI
	 foKV8ZKn7fqNyemaQ841eI8r4yvxqCIlE9Xj+ffVkgZg6g0oF+So6dHtkT6tWTNdlhpFy
	 nkDdXRaklfxefMz+OdYLdJy1qXLlq+CybGe3CKswHBzNJdIy+lz2hqLHM/xs66XBjhxdH
	 2I8/v+g/m/cRRufxcYns/95MwMNkjWUoGzKbKELBKdMNNDTJ66+T1/xbgsCrzTjI3VeIt
	 m3NsQLSoBilMzY6bSX+vWjEXEH23oOpU10SyvvQ7Qrxu3Uo8+NOTxqmYE+Atz2g1WFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794890084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vUrO9jphDSwhafEHzxkcRGpkKIwGI4iB9NaMOLbhxCo=;
	b=QjljNAoFoUqZQrMexIrV8vevJr8RsmJ/FMRt8DF2DCoSqpSttx7ovmDrpus0pOOYOSf8
	 c3y5HOOAVoYn2f5oUl0A0QEPLEg7sSF/lJyR15EQkJvHNVKqWnt69IZ+HZfoKvFESJSne
	 DIdUvTQYt2W17p3VWONTGHf05zqnRKitDhnF8CKgq3wVBXBC+2Ka4QMK4KlhhVGcqZMbT
	 wYi8CUgmf3Xfx10q8YwCR+YRtpM06pbwIUDESspLYhSXkbYRxzTRCE8+KjpoJDaqXsswo
	 sHNj1cWDXKzmD7fc7dNdwAURWB1dJdsHh6RwWBh5BMKwgSmkBOo7/WLzYc4cd67kbGw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794890084;
	bh=vUrO9jphDSwhafEHzxkcRGpkKIwGI4iB9NaMOLbhxCo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PmauiiiSWEJjzoir76gGaRn9i+88LkvDH+niYhyRfku7jASqNySOVsCo7+IENbc7K
	 BZCh4m4ioLnjBkIQ+LtXKvggaxitJHmNHFEXdehWIs9NPRMewtepbbjSVqU4DUHMVj
	 GrwuEKmyR6EXWbCE4eeFgQ3Qi3EleIHObZkh5CrW5opOWKCafxTtIt5zQpKwlOyJhY
	 C7f0n1dO1tcHSZr5WQ/DR1/QrIMppi5jTB5RvXYslOnJZ1Y8uXaPtegdd7mO9Cd/wp
	 IAtIELjtSf1K9xCrtrz4XOvalEyyZS9hz+FUVjnOp2yevVNJ1wtRvcVWdG21uTHrfy
	 3j0B+mJkZZCgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DAD1605DA;
	Tue, 17 Nov 2026 04:34:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FD354DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 088F540723
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3mI6-WMb5RG2 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4AF5E40684
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=dilipchowdary21@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tdkJNpk9
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AF5E40684
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:55:33 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b2d14968c9so39510197b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794862533; x=1795467333;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vUrO9jphDSwhafEHzxkcRGpkKIwGI4iB9NaMOLbhxCo=;
 b=tdkJNpk90QZqwZQFX2wmrchn+xfIMf0brtu5frZILHIn7R8a/83e4mwcC11cxs1Vua
 XORpqaiX0d9BdAA1VaOYXtId3ZYGGeNtdAhd4nK661JJ12lrUymZWdCJv7WvsKEw0tLY
 hCBZzdAauhySPfBJlxZmdjptjkSXG+rEpRZppHzrkMn3knF2ehnD5ozFecGB1CppV41w
 CraP7y4CBtN9pL85PQCkIPKncAs3T99ZovicdW+4dfKDoFw6bhPsm1MOfyEYQIb8zMSc
 3g/mN1UUU5Z4stK/MpFY0g79WeVbh0bi1vuEPjcexWgR7cPH3JP+Y+rNfe50BjNKdqaK
 rjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862533; x=1795467333;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vUrO9jphDSwhafEHzxkcRGpkKIwGI4iB9NaMOLbhxCo=;
 b=DV0HhRs6CDR1X21Iqe62omOdVAabqgVzC+WX50GfSGD+p81ZK4BXK4L7Xmiv4cThb/
 wBji8dZzgGysw4mvyPjRDJu8MTpRzpeMVXh5ofFVZYc8dt1jGECy4xU7AOO1qL8pnUsX
 Ysaa8xfFsvq8864N765Mhv5t9+V+kbR863JfBM335tNEzlx70rzmCabiHx4qzqXcJUJB
 6lEyuR/oOdYetDALM/wuGZJ+GuDUFrF0MtvjrnKFO50svzFXx+HY5pc/SdUdoicOcw2I
 mMPWEXMlE0U/+uzZlAY9dGmkA+oDdgXzJVr17UbylQXeo83+261B65D/RkPJrQle61MU
 8mMw==
X-Forwarded-Encrypted: i=1;
 AL+hErEjHn1fPm3LQuOIhydaVkBBUoqH2g5jbEjRdm+k4w55rJ6UcyR+qlWXBfylZ7Z1DzamYGO3/4Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/rprYrfq1FXM/HzPKqw5nVEAbpnoHip7hYdMfy/6EueK/AFLbd
 TucNlZp1HuOhKFpwAo4GkK9fBN/QnyMMNPPQmQn4nDP/dBpx7QvWwjAA
X-Gm-Gg: AZFdTZe0/ZOqBs+r+bv1M/0RkXiTyiQh9xIUm227lqEhAw/FuV0X01T8zeCcYqM5Lg9
 KtHQI0ViQKiHRyAKpAoDIANE2TF3vidvTylhAr+i8tLgbqzujapo03Chgo7CYzoyEJvFHGJ5G0s
 +C14kNp6N31sgDh1HffsF55ixfeMf42yOiRBs6ZLj9lNDFO1BJnzypF+V6ZE2yPDEmR4P9nzZp6
 kZUStEoigHYRrAajBTX0wTuITspO0tqm0CToHCA2YAmmpmdfhrK1YierQ9FXoPIKsO9XzR0/jP8
 gwA8nnsau7x6h3Z5qZqMbrf3FXLHsTs1y6aC14vD2NArmRoIn6+oZYoed19ndA6Ta6vrVrtEF40
 pt5keOxQ5appoOdrXK3iszcLskhyqcZZJEb4V3P9qZOqAKT5mr/TeB2M7Pub6cZTJDQQbEtKRNk
 mq6kd2iJzWwGzeeMYT1dwf8uOqjNyqrCehHmiiAolUFn1gO5hSO6apg7g6b/Ipi4bd1fb0YnG8j
 hTBqqI8D5jOoWR5YjDzEWje4pPRihIRVkDDtLUOJ8LBMGlRmVr7B0Pr+UXT+ErRVT/kD4M9dcIk
 qE7gvsw6q3OgMuFuLvd9g6g2jJ5byZCZTmkEFwjkLAO+NsQdOp7SUOIDYUL5opbVezYDpzNnTgf
 qw/p+zTjMP+TqSknjfEqa7cWtFdKl
X-Received: by 2002:a05:690c:113:b0:8b4:cb03:c8ed with SMTP id
 00721157ae682-8b4cb03d0abmr28161447b3.46.1794862532752; 
 Mon, 16 Nov 2026 12:55:32 -0800 (PST)
Received: from d3sec.localdomain ([216.170.66.174])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ebd4ea26sm8587217b3.16.2026.11.16.12.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:55:32 -0800 (PST)
From: Dilip Mallavarapu <dilipchowdary21@gmail.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Dilip Mallavarapu <dilipchowdary21@gmail.com>
Subject: [PATCH] fs/btrfs: fix path buffer overflow in subvolume listing
Date: Mon, 16 Nov 2026 14:55:02 -0600
Message-ID: <20261116205502.14884-1-dilipchowdary21@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 04:34:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

get_path_in_subvol() and list_one_subvol() accumulate a path across the
on-disk inode-ref / root-ref chain with strncat(path_ret, tmp, PATH_MAX).
strncat()'s bound limits the source copy, not the destination total, and
there is no depth/cycle limit, so a deep or cyclic ref chain overflows
the PATH_MAX path_ret buffer (CWE-787/120).

Use strlcat()/strlcpy(), which bound the total length, and reject the
path if it would be truncated (which also terminates a cyclic chain).

Reachable via the btrsubvol command on a crafted btrfs image.

Signed-off-by: Dilip Mallavarapu <dilipchowdary21@gmail.com>
---
 fs/btrfs/subvolume.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 68ca7e48e48..bac9c1d1722 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -64,7 +64,16 @@ static int get_path_in_subvol(struct btrfs_root *root, u64 ino, char *path_ret)
 				   (unsigned long)(iref + 1), name_len);
 		path_ret[name_len] = '/';
 		path_ret[name_len + 1] = '\0';
-		strncat(path_ret, tmp, PATH_MAX);
+		/*
+		 * strncat()'s bound limits the source copy, not the
+		 * destination, so a deep/cyclic ref chain would overflow
+		 * path_ret (PATH_MAX). strlcat() bounds the total; reject
+		 * the path if it would be truncated.
+		 */
+		if (strlcat(path_ret, tmp, PATH_MAX) >= PATH_MAX) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
 
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 		cur = key.offset;
@@ -128,7 +137,10 @@ static int list_one_subvol(struct btrfs_root *root, char *path_ret)
 				   (unsigned long)(rr + 1), name_len);
 		path_ret[name_len] = '/';
 		path_ret[name_len + 1] = '\0';
-		strncat(path_ret, tmp, PATH_MAX);
+		if (strlcat(path_ret, tmp, PATH_MAX) >= PATH_MAX) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
 
 		/* Get the path inside the parent subvolume */
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
@@ -146,9 +158,12 @@ static int list_one_subvol(struct btrfs_root *root, char *path_ret)
 		cur = key.offset;
 	}
 	/* Add the leading '/' */
-	strncpy(tmp, path_ret, PATH_MAX);
-	strncpy(path_ret, "/", PATH_MAX);
-	strncat(path_ret, tmp, PATH_MAX);
+	strlcpy(tmp, path_ret, PATH_MAX);
+	strlcpy(path_ret, "/", PATH_MAX);
+	if (strlcat(path_ret, tmp, PATH_MAX) >= PATH_MAX) {
+		ret = -ENAMETOOLONG;
+		goto out;
+	}
 out:
 	btrfs_release_path(&path);
 	free(tmp);
-- 
2.53.0

