Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D6606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AiGctmLu;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=cedric.hombourger@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=oH9YV0Ox
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91DD040813;
	Mon, 26 Oct 2026 17:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C2PVQHDJC4I6; Mon, 26 Oct 2026 17:34:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CD8E407FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793036095;
	b=qn9tFhc3KsoPCh4vboiCUMmsptNL5XhLEC0ssHQpMigboZ/v5OzHz1A/AJZ86wPJ8MmI
	 jSQJPP6BcpGYiVStP3nd3FcemFEqbdpKHIN3Kg1rQeyUB54NkTBR7ZyRdhHAP9WnjlLTb
	 BQPnhXamXey4xtpz3x9oSZaQVSxB5dmNpjoIpvtX4NS5IfthoinK+lOp2E3wG7Weg27oN
	 qH/WJHZDVVS8vBk3UJOL+cXj0yWcVPxQCcdyRVQVWUO1ZynhBAbAkMcIpsTvep102hQVO
	 VQHlDM3umiCmtFfSGTNwpHHGsByEPaklUhuBAR6dhSZlYMK3f1t2onwhkVNwI7TFAKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Flowmailer-Platform:Feedback-ID:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gROQiUfvbelsJ2Rn917jv7iQbxShnSnp2RiH27KRfiw=;
	b=M8aDvUiHeAZrPonz8bx2CvjHPUSY+P9lm7x0WBM4YmsuT92BJfGO+PI+jan0vk+CYv38
	 Qx3GcMabSruetHzFGqq326VRqCloIVh8Ritrvg52CEDXLaHXRAFrHyhn1NEw/wtlx0+jU
	 gGy+GI+VhO4ipWmiRS5UROQwnmh6mNw3BvcdK1lZ47xOHJNbcbOB+rsNTg5y/cEryx/up
	 oO3c5RDgr/V9u3H7kB5GBgIjoW7jOp+E5Wxla8IhfFT8K87VSJCerlY5UDwjdXegt2Xyq
	 XGjN7Z+EzcUc3BerdonfcY26pPpgXx17xNm3agn34eUSTwTmpFLkuxbijhaNlNoxeYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036095;
	bh=gROQiUfvbelsJ2Rn917jv7iQbxShnSnp2RiH27KRfiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AiGctmLu9T7guDqnVFi9C8wH7mljk8bJ5vojDIItXSp3vH9vYunImTNqlCXzU9FjQ
	 xaqwVcdb8tLRcbjafbgskTFC1EwXGuOLegXfolDXzvrs8+rckfZy+RFA3EbaqA03IO
	 fX6lUpnAdJsTOITWDg3FD2efmSV5yIijQUsBEPX477jDeq28KTsJ3FvoL38f+Ub69y
	 AN5Kbek07QQqASMzoabHUYrMOT0/JVBcqjHpaFLF9vOd7oxI4XmJeoKjkozsQzuidM
	 ESwWsCC2bFczXnPuBQBBCGKwzwrfsG2h0Nj9UnOZuHVGCc3cuvBBgGuTRW+zHtZWb5
	 0Mq/P4/LYbONw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CD8E407FF;
	Mon, 26 Oct 2026 17:34:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 51F67D33
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CEBC4023D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJU6Vyr_1DMf for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C19D8401AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032687;
 b=cFoVnscTKM/JpnifFVAV9fphIPh1x9Vsoli5bUrkg2WSafm0zIDn2NgAXTqJlzIakfQJ
 DWBNbXgqemsziP9F5FhDZKZ0WgNBM6ou0XX4HHdxgeYoJl7QshmlqF5E+oEjEimJ8uLfP
 L2OrX5FWHIUCYWtl5GTElHkrsv8mBcjJiZJV5StpBvtF+dvirhHQLQXdxQJQvfOIbtcSg
 /H/P5VHG+kuYyrHXnUuvKKrLRnwmsuKCrw9D8nlSZAWf858TCebRFOXyyMjjft0Gw87OL
 kf5A/p8K7w2wv1vIfjpFIXxeC3duyFxo2i7pX7+RcvTg9cU2kB3vioVYgULwATcQbkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032687;
 h=Received-SPF:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Flowmailer-Platform:Feedback-ID;
 bh=gROQiUfvbelsJ2Rn917jv7iQbxShnSnp2RiH27KRfiw=;
 b=cPhAy1aCl3vXLYizDcRnBe+oCskvuTYk/IYTqGZUlGEOUmM9h/OjzeZpEbbQMJMzVyVs
 uomeqQe3cDsFhff2zXaYJwsyyBIf7sEAZgcDXbbMQs1QP5C79XMmStEm8WzIOKFJAeODR
 KmSQf8YNU3zx3p9G1fgA3/kQJXsDiXW5plZ4CE4sD8XCtnOFk8YsGyGzwWrzELkOdM8r2
 t/yU6JISuLidJpWPRh9uGTDL3PEVeK1wPaTyB+rlmNZOgtCSdQn7uz5deEBoNjC0bj4Uk
 62Gl907DKC17cApm7yLC7NYDNQEqjhoAFo1YS90pnuH70l5Q2xU+AR7ekoM2bOXdVWw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=cedric.hombourger@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=oH9YV0Ox; 
 arc=none smtp.remote-ip=185.136.64.228
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-1212295-20261026163802dc31ed546800020718-hkxz8v@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=cedric.hombourger@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=oH9YV0Ox
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C19D8401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:04 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20261026163802dc31ed546800020718
 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:38:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gROQiUfvbelsJ2Rn917jv7iQbxShnSnp2RiH27KRfiw=;
 b=oH9YV0OxD/A9k9OPsutaTWqIvhAjlEV9b6yewM31bak4rOKnEors9B7cR2hT9JSj+Ru9qk
 fD3GkbcPXV3pWGm+suQeexmROl7b9UKLUogtzMVIWV0Fib8bSOOkjp1MmnVNv8l2pdb5WzvM
 bbQ1yLC2hqUloWhIaYDRkZXDFh4gmHzzbRfRbQz2ICWsZS3LJiIkLPoUCgZZD9cSqDL/YBqp
 r16bnlomhp7WsL/db24en0Ilu9Wj/d/7+ra5P7FjCfTDapA2RXAyB1/XH7w7G4N3kdQOB3pa
 wlkDvQng16hpuBLaD3yE8MXjGxthwWcc0gbn9GjEweXXDAMQkCjIdybQ==;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
Date: Mon, 26 Oct 2026 17:37:25 +0100
Subject: [RFC PATCH v2 2/3] fs: add fs_overwrite() to write without
 trimming the file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-fat-fs-fixes-v2-2-41ae696cd353@siemens.com>
References: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
In-Reply-To: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Cedric Hombourger <cedric.hombourger@siemens.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Qu Wenruo <wqu@suse.com>, Alexey Charkov <alchark@flipper.net>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
X-Mailman-Approved-At: Mon, 26 Oct 2026 17:34:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fs_write() with an offset trims the file at the end of the written
range. Add fs_overwrite() for callers that need to update a part of a
file and keep the rest.

Add an optional overwrite() operation to struct fstype_info and set it
for FAT. A filesystem without it falls back to write(), so nothing
changes for them. fs_write() and fs_overwrite() share the same code.

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
---
 fs/fs.c      | 25 ++++++++++++++++++++++---
 include/fs.h | 16 ++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index b18ccec8cb43d8e575d2c22f7df3a01308f47751..b0bb8d58d2a458f983b9b98a47eefa05416689a1 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -169,6 +169,9 @@ struct fstype_info {
 		    loff_t len, loff_t *actread);
 	int (*write)(const char *filename, void *buf, loff_t offset,
 		     loff_t len, loff_t *actwrite);
+	/* Optional: like write, but keeps data after the written range */
+	int (*overwrite)(const char *filename, void *buf, loff_t offset,
+			 loff_t len, loff_t *actwrite);
 	void (*close)(void);
 	int (*uuid)(char *uuid_str);
 	/*
@@ -205,6 +208,7 @@ static struct fstype_info fstypes[] = {
 		.read = fat_read_file,
 #if CONFIG_IS_ENABLED(FAT_WRITE)
 		.write = file_fat_write,
+		.overwrite = file_fat_overwrite,
 		.unlink = fat_unlink,
 		.mkdir = fat_mkdir,
 #else
@@ -709,15 +713,18 @@ int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 	return _fs_read(filename, addr, offset, len, 0, actread);
 }
 
-int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
-	     loff_t *actwrite)
+static int fs_write_with(bool keep_tail, const char *filename, ulong addr,
+			 loff_t offset, loff_t len, loff_t *actwrite)
 {
 	struct fstype_info *info = fs_get_info(fs_type);
 	void *buf;
 	int ret;
 
 	buf = map_sysmem(addr, len);
-	ret = info->write(filename, buf, offset, len, actwrite);
+	if (keep_tail && info->overwrite)
+		ret = info->overwrite(filename, buf, offset, len, actwrite);
+	else
+		ret = info->write(filename, buf, offset, len, actwrite);
 	unmap_sysmem(buf);
 
 	if (ret < 0 && len != *actwrite) {
@@ -729,6 +736,18 @@ int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
 	return ret;
 }
 
+int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
+	     loff_t *actwrite)
+{
+	return fs_write_with(false, filename, addr, offset, len, actwrite);
+}
+
+int fs_overwrite(const char *filename, ulong addr, loff_t offset, loff_t len,
+		 loff_t *actwrite)
+{
+	return fs_write_with(true, filename, addr, offset, len, actwrite);
+}
+
 struct fs_dir_stream *fs_opendir(const char *filename)
 {
 	struct fstype_info *info = fs_get_info(fs_type);
diff --git a/include/fs.h b/include/fs.h
index 8afc81c0017da1d7fbc2c3a5c63fb00d2fc1c262..02d357cd62849cc19e15ad3fad08964d9ec66c94 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -167,6 +167,22 @@ int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
 	     loff_t *actwrite);
 
+/**
+ * fs_overwrite() - write into a file without cutting off its tail
+ *
+ * Like fs_write(), but data after the written range stays and the file
+ * size only grows. Filesystem drivers without support fall back to fs_write().
+ *
+ * @filename:	full path of the file to write to
+ * @addr:	address of the buffer to read from
+ * @offset:	offset in the file from where to start writing
+ * @len:	the number of bytes to write
+ * @actwrite:	returns the actual number of bytes written
+ * Return:	0 if OK with valid @actwrite, -1 on error conditions
+ */
+int fs_overwrite(const char *filename, ulong addr, loff_t offset, loff_t len,
+		 loff_t *actwrite);
+
 /*
  * Directory entry types, matches the subset of DT_x in posix readdir()
  * which apply to u-boot.

-- 
2.47.3

