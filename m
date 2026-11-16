Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DF606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XiQUKY8q;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sueiEqvy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B7166085D;
	Tue, 17 Nov 2026 04:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GBclSu8WCHwc; Tue, 17 Nov 2026 04:34:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B76F60849
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794890095;
	b=gon5J0jretnJlTwRjwVmlt5WzzkUMShY2NfNlZfm/1I1cLSHh96DySu9g2Lr4FdYvDXS
	 g27HDj8q7c/It+y8zLX0te38Eroplk9mRe4tzFTLy6beH1R3mVtYK20U8JUJZ7T1Z+2WH
	 vC6k4YfVnC7iw6td6yjh/MgQh3Z3nPX/MPcNaijThGcnQOu79gojtK2vJhSWjoyj36Hzn
	 Qta2r0n6Kyh3LWvQYOKEWkK1tBpqPjQ6NdlCrh9fqrIbXqklgKGJXt0kgoko8pdMrCsaE
	 GfmFrSoO1zyj8YWdvCDw1KrWeKtrQInCJfWmshrzYpmJKVVwHysuZXUR7uojvnwnhrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794890095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Nv7Psu8WEx+4zKSsz0ct9qGuND9uBk+q8iMocyWDLjM=;
	b=PoqK3q1J5D2O8ZA1b2m1IEBqUnf1xUMM87ugtKJSOafMEk3c2LVIdi1hHbIiUwz7DGsN
	 TlutDQf0rG0xWW2roB/yQg134fJt6RE5WEedo70K6ta02jrBhHBOZROw5l2pgP2Wn8fHu
	 SuSHAXc5zF/+sSrgu1Cu4lVNpBoj2fFt3TjFLDxVmL4Rn1Q1S8uN7SmOx71MEzxCv7gR0
	 NTTmc5YxVM55wWe99RNmcI3I3Uwd9jNK0s3kWswKc59xMePGUMEpkn6M6OgCUdpkHbCY/
	 5RyZyEf/c0KdGMAlUBoetR2BUKm+pOZxp3oM+YCWOEaComE7L2TbOvQgd/qPWieoWgg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sueiEqvy;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794890095;
	bh=Nv7Psu8WEx+4zKSsz0ct9qGuND9uBk+q8iMocyWDLjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XiQUKY8qm/5GPyVPB/KmTTr7Mk5VsIft+ND8INva5Ul0C9mhtk0qXZNMEBWoBf5cm
	 23c8qFdYy0SKauGgFOEGnCNyreBD5Fo7vdkXF0xI71UC0WATarF5YYma7ONysXSDBO
	 /eo3opnxkVhBDy8nxWwoJ/m2cqLNRcxEFjxTpKL3xJQF2WvHATr66Yctzi3G/art9r
	 cMfGFRNd9UpJEt3D1jgDtyknwdKC67D9JfKZBSIZZPpywGp/+kg4lDkQoXYyd4109v
	 48mR6DIIKl7+UEaXegqmJ5Irh3jCJqXk6MhIq6hvUdLa7ri0X/WdYvwx38Zy0+UEop
	 J5a0w3OMcse9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B76F60849;
	Tue, 17 Nov 2026 04:34:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 203481A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A02B6067D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xyoiTtFry6Xq for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 500E060600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com;
 envelope-from=dilipchowdary21@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=sueiEqvy
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 500E060600
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:43:50 +0000 (UTC)
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67dc7eb1442so358616d50.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794865430; x=1795470230;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nv7Psu8WEx+4zKSsz0ct9qGuND9uBk+q8iMocyWDLjM=;
 b=sueiEqvyl6ywTsbzHNFWjKUJbyWweWQPx/4qsASBOm8RvaO7P+Ark2mGArek726Ddo
 +iStwh48JAUZtW9uJmMb4GQpSepFM/anQQlbxw26/4ObJ+fnXm/NRaZvgLXuqLMJOQJa
 XZj7WaQ4kTaUezI3bKV5qC0CrsbcMpRQPlCLTIo05Ng1haYV3diULzCaeagCpTquHjpI
 cuFja2nGqbH0LS7qVoJOVgK10zvxLxytqkW0jC6S6TH5uxLc7x22j5rE+39xv3tHoulw
 aTSHG6eh8tIPMvyMv5rWKF7EbRGwvI4KzcehjyL60u2xekOMnhD6yTWUySY4wb0lFYSZ
 NOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865430; x=1795470230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nv7Psu8WEx+4zKSsz0ct9qGuND9uBk+q8iMocyWDLjM=;
 b=uN198FG2qE/MXRTpecilrHmTUK8DjNCo2+st61RrDLFgZUlutRg+EHPsJEsGNNO23j
 OkFu1aJn7L+eeXuxWy26/ToqjbtuPK0G+403fZ6+4bA4fnhV+PAyVacx+p46J8x2yH55
 cCWGVQHhlXRDJ9b12kIgnnN3nLlkdNtIaEGdE9tME2YiSzU4YCSAeufW+H8ZD0loHzmP
 +S9cSllVM5qnONjsgqFBlSqAybAZE4VAdI/hOiXWazmSmNtzeY0xlDiZH7lSe5F4biJH
 zPG8obX5S9Q3uBld4egNV885/u8GBDOZ6CsBbLmXwkLzkPoZUTc4Xk8r/hKZTbL7Igsp
 yB0g==
X-Forwarded-Encrypted: i=1;
 AL+hErEx8atNEiW9nhTpElt+ha/IV1OriJYgtRomkOGb3sbS7TBUxkGb70952ViAQrAFFKDiG646JSY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9dWS+imW1h96tJ/LNiiSZvXymyEErHBdtaOcysORv8+pSGHb8K
 FTJbGcw4ARMzijVdPsTrjE+496z6uxzXi9yhLR+Lp6797Wn8MfesgX59Ai6dV7aI
X-Gm-Gg: AZFdTZcxIvd7iX7QhAuwU3oicISBi76myURYa/h+vRmivnHHQfGUPciHoTyhK/DKttF
 DUDizJtXWGzQbuZdht+0GUmnlh3Wp1A7qQrpQpboUi8RdVzPZq7e/hz2LQbGNsF1paIGIR1bw44
 XUSL+y1+nyf+oe5wp9doUMq6x0rM2w5xqzbvoZaMgYwsaZn/hyd1lna7LBPtTTo/vOyfyC34dO1
 Vgd4v0gte04kJDJbeG3XDER0Sj8CtZtjM/HARLIwrB1loD2mWmbvlgRkuFy2QfWjdO1op1WXEOS
 1z9c1/3Rt/euXff0YU/kaxcuDwidp4ZjXmySyr3QrcU18oIUcRGoqzEvA4v7wxuV8RapwVuOwM/
 w8TpoWFUVdaXeq5fvCHl7sl/aJgtI+6LJ3VaD3qZi8BIoze3IYTYoiizQo58JDumQsY6ZUSpRf4
 fj152Cyr1ikxVfmeWu+RtDDO3wYA6Du2QDoih+alA1QcuQiB6Sytm6DPmV/Ydxq7eLfXkte/1XM
 /HA/E3HxVm21/A8ywkKYSmqaarec/uE+zGUqB18ncO0KExp9S3N1L8offHsfn76Rw53WLZYMkis
 HVu5YWvboQnidqN2XkEAdyiZJYD+9mIN/M3lzMYynf99w8U/7xNN2+pAHB693fv2yypx32tVeFF
 Uei49X7YucrTO7P1zvIad+xPiQIKFLg==
X-Received: by 2002:a05:690e:1441:b0:67d:b8a9:2574 with SMTP id
 956f58d0204a3-67db8a92965mr2707159d50.20.1794865429690; 
 Mon, 16 Nov 2026 13:43:49 -0800 (PST)
Received: from d3sec.localdomain ([216.170.66.174])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ec2a5b1dsm9280467b3.36.2026.11.16.13.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:43:49 -0800 (PST)
From: Dilip Mallavarapu <dilipchowdary21@gmail.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Dilip Mallavarapu <dilipchowdary21@gmail.com>
Subject: [PATCH v2] fs/btrfs: fix path buffer overflow in subvolume listing
Date: Mon, 16 Nov 2026 15:43:33 -0600
Message-ID: <20261116214333.17947-1-dilipchowdary21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116205502.14884-1-dilipchowdary21@gmail.com>
References: <20261116205502.14884-1-dilipchowdary21@gmail.com>
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---

Changes in v2:
- Drop the inline explanatory comment (Qu Wenruo, Tom Rini)
 fs/btrfs/subvolume.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 68ca7e48e48..a62d547b3b7 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -64,7 +64,10 @@ static int get_path_in_subvol(struct btrfs_root *root, u64 ino, char *path_ret)
 				   (unsigned long)(iref + 1), name_len);
 		path_ret[name_len] = '/';
 		path_ret[name_len + 1] = '\0';
-		strncat(path_ret, tmp, PATH_MAX);
+		if (strlcat(path_ret, tmp, PATH_MAX) >= PATH_MAX) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
 
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 		cur = key.offset;
@@ -128,7 +131,10 @@ static int list_one_subvol(struct btrfs_root *root, char *path_ret)
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
@@ -146,9 +152,12 @@ static int list_one_subvol(struct btrfs_root *root, char *path_ret)
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

