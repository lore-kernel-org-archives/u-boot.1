Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0847606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xJyS9/BV;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=cedric.hombourger@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=PBVKH4Tx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCE97407FB;
	Mon, 26 Oct 2026 17:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PW5Ew7HNn5qy; Mon, 26 Oct 2026 17:34:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 693C44081E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793036099;
	b=AExbpmuIXh9kEdn/ntlCWq8nXceygHI/PJu3vjQCD3fK0T89VbYaAZYV3KLClJeBkTd0
	 ZS3HTLVAzP8bib2jpK2DNEwFy3KJgmKlEHX8qkj5pomyCePNf9Gnl5jPWpMJTqpI8osQO
	 YtJITIyTbdOhter3lQ1e0uZFLA6NT4SeVPR18nts4dS0EA5navHPMorPLnIW2djr5sK/O
	 vOWn8j8jjGdmUFcASLpdLXShgE19Xfe5YPYVbv377dPTyzWXZFm08fRzhWZGYzKi3ODCC
	 oabwB7LQTmK8SKm2tWrNz3eGBnjlhSYAl5Oln2QJNHmUBidnZRYOOTowoiQri7RL/Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Flowmailer-Platform:Feedback-ID:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=065vaio2E7I+7WGIhrkQacP53VhnwT544YJYWaUphMA=;
	b=LTzu0LjMmc0sQJ2ixE54qR7xsrY8/kTTk6IIMtMwSX/zCZnc2Cw9lko5eJSbtjEeKjC9
	 8Dq2pjau0ud4bUcjtkRyZxRpY/Qov/0uhHpICsPz7Kn/xI3WuKEwPuj2pbNgjfDuhFTtg
	 j+1zVH9KgWuYKuKtjTqUNp5XgdXtFOn4DuvCMoQjoMmQTRaWYABW2A0k+RtprMVtin28+
	 AwO2TM2Q38rjlj8qM83RKDbh97nBpfRoRDfs5pxNLpcdcB/leA4cwTBGmy06uZnYjb5FA
	 OV3+iPE1xVPXxOWObEc8owDpsiX8eLzZK/hWQx0EZrwSR4a2t3Kgus6kyPU7mMoJVwQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036099;
	bh=065vaio2E7I+7WGIhrkQacP53VhnwT544YJYWaUphMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xJyS9/BVEvUDOXMhABalM40FqBCdcFYshbYTYMAM9hU7Gqt1RMzsUEniXDEshYiOs
	 oPLhgmokyN9H0CamTPP5nzjf1vM202MfKH3RmUCccw8vfuSOjj4/SMX+9qtGOkefJ2
	 gGx4BAP3PNwwQNu0s3JWt/YNWgrG2DZAv2ikuIsXSz7J5srD3z0Bs41cCggmVE8bsN
	 L5gZAQnxM1G+lzXVhci6sknoHMjEvLqfkEpsJ8X4HQU7YcBGSfPUVtulLgTS2yYIxt
	 zxBxbvBas+RVCDWiu5qe6G/sW5fQDG14rh40E52FV9MUWUF3j1cAYEUw4iLZSpUiKq
	 z0Ut0YT4cDR2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 693C44081E;
	Mon, 26 Oct 2026 17:34:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58BC6D36
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A7424020B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GsGARXcUmL6H for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A2CF40223
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032687;
 b=l7pN9Do0+uWInge1hOicA1qC1m0wYc9F5zyEsY+ROZBM67jx27ozuT1bFB6q4z3fQlGL
 q6jFBRq2x3LC4ZyT9nfbDEuESbrDvQdijxQQ37t1mfBbgs/1UOcbtKx+e666hoHo35Ppf
 oV6SQ5bu+PcchUGFAsALmfhXl7jdV7l943SuaJqRCVz1HsEERfHg7NCE8dK4PCP+sGoVb
 Qm7l01PGaRNEPjxcuyKFnACNoGQb1MhMgUzi3soLYZPAY/zNBsnoyoQQLmgfgs/2MvQsQ
 gNRdCIiBqfwyhHRQDkhfd+2G0NjcAJc8xgNVobKgLMIoKHv7O48BRcnWPy/SvX6wQKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032687;
 h=Received-SPF:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Flowmailer-Platform:Feedback-ID;
 bh=065vaio2E7I+7WGIhrkQacP53VhnwT544YJYWaUphMA=;
 b=desh7uf4RZALnmA714t3E5BZWQaqPcZQ8iUyZJp2c0YqqS2ZeG5ezjiYgezMIlafzMob
 eFiladgFgdclJo8b1MrPKs5kKc2SdV3U3vL87rl2ZmgUyXZTtSZILct4mc8I0BzM+tHUN
 S3dEZxAB8d2hu3Aj38HKhadZGAo5Zrc9mEWq0xgtU05c8AiBNts7e24Namy6r8IOMYMkx
 x9TY9rtSEkcIGgHBWtnCNO7BqrBoSq2p6NCKlUt2q5T8AiXzjrCoT2FlkmMRsfQD8BIt2
 X5TtqOQm5WYJwXhV8CqdbLrq2B/QEYE63IWgbxJsuDh218Z3roB4ZpR08ywI5BwKyCg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=cedric.hombourger@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=PBVKH4Tx; 
 arc=none smtp.remote-ip=185.136.65.226
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.226;
 helo=mta-65-226.siemens.flowmailer.net;
 envelope-from=fm-1212295-2026102616380112718af1e3000207d1-wknts_@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=cedric.hombourger@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=PBVKH4Tx
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A2CF40223
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:04 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 2026102616380112718af1e3000207d1
 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:38:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=065vaio2E7I+7WGIhrkQacP53VhnwT544YJYWaUphMA=;
 b=PBVKH4TxvI6NrV9QQd+3wnmHsOdkB0ui1yCZi5UsRLMIZzaU0VEXQTZlMq/0fg41R3/J5G
 NBWVhSdGFb4onnWJhoKKhqKPYdvLJNQpSqhJcr5nYz6X3iWTIXKEMRP843UJsQDVdZawgV54
 gSzqtr8Zk6Ma8e+DLjzbdOY4BNL5ExfKN61bf0WVlBLrjVZDEMfjCKDCGf00QKiLYaTrZvVz
 FOdA0YM8vvVSwP7eNGnk4Ph4BtnDR/Wuq8S1Sg3jLJ6mzPYO5L2lbcLZplBidWS4uBV+M8dE
 jlsDVuLUwwC3o/l+VrLXZhfrmM1jHhCC7DUDeAtdoP/imKKL4HOQVvQg==;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
Date: Mon, 26 Oct 2026 17:37:24 +0100
Subject: [RFC PATCH v2 1/3] fs: fat: add a write that keeps the end of the file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-fat-fs-fixes-v2-1-41ae696cd353@siemens.com>
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

A write at an offset that ends before the end of the file trims the
file at that point. This was chosen on purpose in commit cb8af8af5ba0
("fs: fat: support write with non-zero offset") to stay compatible with
the interface of the fatwrite command, which replaces the whole file.

Callers that update a part of a file, like the EFI file protocol, need
the data after the written range to stay.

Move the body of file_fat_write_at() to a static function that takes a
keep_tail flag. With the flag set, set_contents() does not free the
clusters after the written range, and the size in the directory entry
only grows. Keep file_fat_write_at() as a wrapper with the current
behaviour and add file_fat_overwrite() for the new one.

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
---
 fs/fat/fat_write.c | 32 ++++++++++++++++++++++++--------
 include/fat.h      |  2 ++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index a1d28b4e305766b8fb8ee097fafab235faf8ad52..03cd6d368b01d7b4d08502e1783e85f61c39e323 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -925,10 +925,12 @@ static int check_overflow(fsdata *mydata, __u32 clustnum, loff_t size)
  * the file associated with 'dentptr'
  * Update the number of bytes written in *gotsize and return 0
  * or return -1 on fatal errors.
+ * Unless 'keep_tail' is set, a write that ends before the end of the file
+ * truncates the file there.
  */
 static int
 set_contents(fsdata *mydata, dir_entry *dentptr, loff_t pos, __u8 *buffer,
-	     loff_t maxsize, loff_t *gotsize)
+	     loff_t maxsize, loff_t *gotsize, bool keep_tail)
 {
 	unsigned int bytesperclust = mydata->clust_size * mydata->sect_size;
 	__u32 curclust = START(dentptr);
@@ -1045,7 +1047,7 @@ set_contents(fsdata *mydata, dir_entry *dentptr, loff_t pos, __u8 *buffer,
 	if (filesize <= cur_pos) {
 		/* no more write */
 		newclust = get_fatent(mydata, endclust);
-		if (!IS_LAST_CLUST(newclust, mydata->fatsize)) {
+		if (!keep_tail && !IS_LAST_CLUST(newclust, mydata->fatsize)) {
 			/* truncate the rest */
 			clear_fatent(mydata, newclust);
 
@@ -1469,8 +1471,8 @@ static int normalize_longname(char *l_filename, const char *filename)
 	return 0;
 }
 
-int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
-		      loff_t size, loff_t *actwrite)
+static int fat_write_at(const char *filename, loff_t pos, void *buffer,
+			loff_t size, loff_t *actwrite, bool keep_tail)
 {
 	dir_entry *retdent;
 	fsdata datablock = { .fatbuf = NULL, };
@@ -1535,7 +1537,8 @@ int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
 		}
 
 		/* Update file size in a directory entry */
-		retdent->size = cpu_to_le32(pos + size);
+		if (!keep_tail || pos + size > FAT2CPU32(retdent->size))
+			retdent->size = cpu_to_le32(pos + size);
 		/* Update change date */
 		dentry_set_time(retdent);
 	} else {
@@ -1552,7 +1555,8 @@ int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
 		retdent = itr->dent;
 	}
 
-	ret = set_contents(mydata, retdent, pos, buffer, size, actwrite);
+	ret = set_contents(mydata, retdent, pos, buffer, size, actwrite,
+			   keep_tail);
 	if (ret < 0) {
 		printf("Error: writing contents\n");
 		ret = -EIO;
@@ -1578,6 +1582,18 @@ exit:
 	return ret;
 }
 
+int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
+		      loff_t size, loff_t *actwrite)
+{
+	return fat_write_at(filename, pos, buffer, size, actwrite, false);
+}
+
+int file_fat_overwrite(const char *filename, void *buffer, loff_t offset,
+		       loff_t maxsize, loff_t *actwrite)
+{
+	return fat_write_at(filename, offset, buffer, maxsize, actwrite, true);
+}
+
 int file_fat_write(const char *filename, void *buffer, loff_t offset,
 		   loff_t maxsize, loff_t *actwrite)
 {
@@ -1877,7 +1893,7 @@ int fat_mkdir(const char *dirname)
 		set_start_cluster(mydata, &dotdent[1], itr->start_clust);
 
 	ret = set_contents(mydata, retdent, 0, (__u8 *)dotdent,
-			   bytesperclust, &actwrite);
+			   bytesperclust, &actwrite, false);
 	if (ret < 0) {
 		printf("Error: writing contents\n");
 		goto exit;
@@ -1885,7 +1901,7 @@ int fat_mkdir(const char *dirname)
 	/* Write twice for "." */
 	set_start_cluster(mydata, &dotdent[0], START(retdent));
 	ret = set_contents(mydata, retdent, 0, (__u8 *)dotdent,
-			   bytesperclust, &actwrite);
+			   bytesperclust, &actwrite, false);
 	if (ret < 0) {
 		printf("Error: writing contents\n");
 		goto exit;
diff --git a/include/fat.h b/include/fat.h
index 40da0370a4442edad872661408c856b7dac0787c..499e1924838049568466d8d4329c24ac4c26b087 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -225,6 +225,8 @@ int fat_register_device(struct blk_desc *dev_desc, int part_no);
 
 int file_fat_write(const char *filename, void *buf, loff_t offset, loff_t len,
 		   loff_t *actwrite);
+int file_fat_overwrite(const char *filename, void *buf, loff_t offset,
+		       loff_t len, loff_t *actwrite);
 int fat_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 		  loff_t *actread);
 int fat_opendir(const char *filename, struct fs_dir_stream **dirsp);

-- 
2.47.3

