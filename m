Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F10606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f7IlQP/x;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XoBP1ALc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BDAF80D58;
	Wed, 28 Oct 2026 14:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWCWrL4H-ury; Wed, 28 Oct 2026 14:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98BE480DA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198749;
	b=ryKw+E3X4Lvn736dnmMK9YLehLYfJ8jmMcR+pjn69HrWO8KYlvGcg7jZSSUx4qV3ELh8
	 8P3h8bXp7hdKVI0puFQbssMCzOY2t2w1vYThEnv1tDlHZotHKmCu5if00lR/EoEzFFoOb
	 DdD//4pk3fgYoarNl9cFLtumftJ7oiGj38HtNXMkknyfzjhbVf3Q6CXsbpM9oU65TnGVQ
	 LilrsBizNPpJ/wt6u8UsCgNL3X2o2sUsDXnT/qbHhAI/DqAdfHgtDQQmoRtk7EH1NfQce
	 uQP3F6T1hY5xD7V9/EkoIiMXpn+mAI9lOHczbJE+BeK8yW14I45p52i0GfGyUEP1q0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bgeOTwxBkL1HcC4crkgz7rpbo+GSbYwYcynH6L0ROUI=;
	b=mUy7tJT/wMPmrGEGNd4akqEU62mAkpdhFx1Px8prTfW3GMNEA13DFoydyYKuM02y5auq
	 t/NjFoW2hG/iUoztcxiptPH+ex7hqmaWB9sxsjXOYvdnrktzJqrL2yI9crZCiuCjZ7MNP
	 0e5o2wgU6FmliJvjcow/ErGnkZ19frAflEwshpPLfZ4bUevanYxXXnHziQoPo7urVPnEv
	 MPRPoUu2aBkvhlj41ejDsNGe5LAswo3TnrFFpff3iUz4KUChl6xiVsXDmcEj1f2cSUT9S
	 EO53NnZgFzK1yy2lgk/VtT3G1RWhnayyfBylbqISqfejdeKr3yOi4szO+TEVHdYX2Sw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XoBP1ALc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198749;
	bh=bgeOTwxBkL1HcC4crkgz7rpbo+GSbYwYcynH6L0ROUI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f7IlQP/xnnshA9EfCbA3ge0KQObaap7zful3sHQV6eA89mPI6cDYZuWp5wX8lQw8u
	 GNQWJuE80wP+y+N1VlpdKP2nIlcQBLSsJOyDaNIVK3QfYQWDTeFZYdhX3DRkS6SQpY
	 au9eeCieoC+UmebAcPyREIDXKe59bQhy0xOMwJJPCCdNrxBwvnI3/f9LkOs8p3DP1O
	 G7bAT79dTjFvw2As5h1Xj8lvVv1R9IglljLOOhFh53PTwbxBYp02CXVl0Dkf1fUCtN
	 VZnuS67Hy8ufCVFqXle/+oWckVKlOdBEprrEdtxux8iLvmF/MpyjY3LrBt9jbV9hwS
	 MVCZD+fuwW3Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98BE480DA9;
	Wed, 28 Oct 2026 14:45:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B57E7356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B0A980BD4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:48:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkBt6SAvuaV9 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 13:48:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B18B980EBE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793195284;
 b=K5/e6CmGLAcoTERonq7e/0DP8GaQDn2WBPfYLoJ5asUZUzYetsAoaw46ubGWPKKfBGU0
 KC7RsNDk7YdELHtr9SG/8KPLkDd81qWw/d/a78SMR5xr8mtlsOuUVnUJEWRrVefVtq9Hf
 KwzY1YI5HQRNFC61iCBufFsle5SCAJ7Xotbr9DBak4npws3S5VBfkz3yGrIKUw2mNQYS8
 Elq4ydvAso2vb6dQZYz5/3tZMQwrxxC3Sp8Do03BNTrlHRJfu2LihRZIloqFARX1iLRtb
 VQS7Fpsqr9LmCVQrG6MbYeZvcbP9ee9XcmhlZPnZ9rT4GRR+OsJMt2hlmEj8/CmswQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793195284;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=bgeOTwxBkL1HcC4crkgz7rpbo+GSbYwYcynH6L0ROUI=;
 b=XBrslE5ThlQ5J6J3KTpDYTczSp3OI+1rA1tnzEsl5Pqqc393ypqU1B82300HilSGFX6g
 +7FHaH2AuFOpH7E/jt4JI/I596BUhGT6UU4MsT6d9pN8PPXwib4iaNt0jUrXEP7u3cd4+
 lf6o2Ba0Ii6pHd/LR4tZ4gpy0AAZLZciPWERQHVT4R6zLe6GOsaxwIdYhJwFa9fqpO6l3
 USguzuoP2oKYcobVRwNu+wzzWqww+x1EFCzGMpyp1qRcrXUs6zWj0q/G6f7q+lAly6kYw
 KqVUXS11Sy6AF9YoIIr5KxJK//oB2TjDWwt8cyhk2UBfu3e9w074vB77ikqISSWGkVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XoBP1ALc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=odeschamps.mail@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XoBP1ALc
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B18B980EBE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:48:03 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso8520895e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793195281; x=1793800081;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgeOTwxBkL1HcC4crkgz7rpbo+GSbYwYcynH6L0ROUI=;
 b=XoBP1ALcK3ZeiPQNd2K9a2GSe7KJ5JiQ+NiSmJNKwG3i3BRXRoRw0UYXaHHN90cI1Z
 iG7f7Cut9lyeqZhnF98E4wL4SK5FbWiDKdCRmo2Z5bLS75DL7FfeXEeH/jnDhtmK7sEC
 7ErIiFosvTVUnoqr14EWWBWHLNNZfzADczM3GNU0LKA5lwc+goQ2IW/DlgXkmEqkaa2f
 zCdTApAl8JPSEzXqtg1JE8umoac6nxE256LhHqe2ZNkYU7bGRpMFH1EzsrT89/csfBJK
 au7Prb+KzrlEoteeQ/U9ftRVC0JSrpapiQ7EYTPpnfo8mFfpEYemVbw8lJZdUTvKYtfE
 IQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195281; x=1793800081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgeOTwxBkL1HcC4crkgz7rpbo+GSbYwYcynH6L0ROUI=;
 b=FpnC2g1P+ozYD8IqVYVNu7khC97Hrrvb0uQ/qDGkEM6NTVJFk25yc5QwLFeRZsXxxl
 xAuxQfpN5FiidbYbp3IJiNFacds0uOc8yRrm+077r+OxKWT0kEx8rUy+vp0cZxcY/Cnl
 6enbh4HzI5fQmjM2UVROLmV+bSH5gzhJkYmzW1z1euJDJ4HCHu2wUCBA9YnRdF11i14S
 NDVVEQt+bIQK24HPggbuJtKVohZtBSnER7e0cgFCvt5/5HfkS1rVVeMUeCzpZ+EBzdIf
 BAzgrWhnon6xeSHy5qNvBScgMFi3qLHC4a4/0esGAqG+kdrdIWYwhBfHCY2rRzrkh5Tm
 da9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMi/JADQgNxGTcT0C2KKhneumC540tq6WH9UuKsrcp4fprjC8Qgvmg8hi0gIKwcRFbD8caAYk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJqrWbxRA2fZKlwC/W4VCAttV7+1mGQ2dx93xLHJFPqDNlUSnPE
 ifITWkd/JjzygW2Q1cAyNnIvWml/UUAkW9FD/qfg4ntEI3VnW0GBX2Bk
X-Gm-Gg: AYBFou0oeQoRSn/xc4FIOu0ykZQarrXI120DURQOC6Lqgf243ASJIEMzR7MK+6tb4tK
 knyDsc2RJuVocvIfVsLeD+B12md8XOzYy3Qxvo6OyDuIbjJ0nVWDdu459S92TyRcRC92/xCQxvm
 8zL9upzF+aHxaREhlo0FhRfXlJnl6KpalA1F2stT0sHPzBpgzs/8AdO51R+61CQdpRjGyXcu5Pw
 gUgychgW5DeU5m9yskcDyoSqWIWli2UMfr7jEF68FUlTbLSgdriBETsUl3vTg5GNw5VhkI6X+Jp
 RW6lF6HM7Jnx1l2NIfYaDfk/zd+xdRHSzDBGIlaPVphYfjlxXIyanObieypGw/YAJ9u19WEzQrU
 xb5jzBmJyf8SaI+ceJ1OYTKIACR47aC8eJBxUfktzeHzmLv8Dx62MMr2NFeFmO6KT4S7QWGukaf
 Sa6ICbo/Y4yrzXCexgVLE8RTxkxh+IzmqlKRhKmol4K7eGp7N/baK+GDcVO0GXdkzxPC2i5ttMv
 6dpq8571nfttP/aSX782eVYntHyRAhjG4bqidy2vIeugHVd48FEdFcyq4oMBvA7Rm+LcinPPaE/
 aiBypjYkKziPv38GIElJJtbTGh9xQM7wEYXt4OQRqH/mJ7rVJmqzXEMC
X-Received: by 2002:a05:600c:4e43:b0:4a6:42cc:bf65 with SMTP id
 5b1f17b1804b1-4a96658730cmr53287885e9.17.1793195281029; 
 Wed, 28 Oct 2026 06:48:01 -0700 (PDT)
Received: from test-Standard-PC-i440FX-PIIX-1996..
 ([2a01:e0a:ee9:fa60:9b53:f22:3391:990f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9797e98a7sm43370065e9.15.2026.10.28.06.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:48:00 -0700 (PDT)
From: Oscar Deschamps <odeschamps.mail@gmail.com>
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org,
 Oscar Deschamps <odeschamps.mail@gmail.com>
Subject: [PATCH] fs/squashfs: fix NULL dereference on failed symlink resolution
Date: Wed, 28 Oct 2026 14:44:27 +0100
Message-ID: <20261028134427.405740-1-odeschamps.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sqfs_resolve_symlink() can return NULL, on its symlink_size overflow
guard or on an allocation failure. sqfs_read_nest() and sqfs_size_nest()
use the result without checking it, unlike sqfs_search_dir(), and the
NULL reaches sqfs_split_path() which dereferences path[0]. A crafted or
corrupted image can thus crash U-Boot (a NULL read) while reading or
sizing a file through a symlink.

Check the result in both callers and guard sqfs_split_path() against a
NULL path. Found by fuzzing the SquashFS parser.

Signed-off-by: Oscar Deschamps <odeschamps.mail@gmail.com>
---
 fs/squashfs/sqfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 0ea6dcaba1a..28d6e64e79c 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -1295,6 +1295,10 @@ static int sqfs_split_path(char **file, char **dir, const char *path)
 
 	*file = NULL;
 	*dir = NULL;
+
+	if (!path)
+		return -EINVAL;
+
 	dirc = NULL;
 	basec = NULL;
 	bname = NULL;
@@ -1561,6 +1565,10 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		dirs->entry = NULL;
 		sqfs_closedir(dirsp);
 		dirsp = NULL;
+		if (!resolved) {
+			ret = -EINVAL;
+			goto out;
+		}
 		ret = sqfs_read_nest(resolved, buf, offset, len, actread);
 		free(resolved);
 		goto out;
@@ -1848,6 +1856,10 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
 		 */
 		sqfs_closedir(dirsp);
 		dirsp = NULL;
+		if (!resolved) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = sqfs_size(resolved, size);
 		free(resolved);
 		break;
-- 
2.43.0

