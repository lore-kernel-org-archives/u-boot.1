Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7DBC982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 271FD6082E;
	Wed, 23 Sep 2026 11:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xQOoskVPhGyj; Wed, 23 Sep 2026 11:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6073760752
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790164272;
	b=AGN2wnU7WKzGSBcf3knq3NtVMwgRmjLfX6A2moQx8Cv9yhhn/RT9sXXNGfgPVdZOgOrJ
	 oATus/OO+vJ0g0pVkO5uRxXZ9D8yidQksLLHGl9bxTR3P6FRrNK6DBMU5hGLGPng10Irs
	 70Y2iqyZXTrb0Kw4bmUi5pCNGub5kMhJdXSfFPsyqFJ0g1rZ6oBagbrS7ZkfIJi0XPxrD
	 HnnXXNZ+k/L7Cp1Q9hWa6u0d7Rnv68cG681tgALEGbxcZXNBDCKVm8MD6FtEV20h2T7Gu
	 a1I35XKkidfiKFHvm6aF6C4mBMSHLm7teYYjnkgXiV4fOHmzVpZbXPi4IK4Q/sR8QzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790164272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
	b=sLbH5qcGbJ3jxp1d3h7W9VsdstnvYOPfzf8MfMixLnrgrzSwgOtYD/8fHlkepRbQOgQ7
	 +AQPCKvHrGTluMUDwaNqNOFzsBvgUiorgMyw3LbxlBOtlGJgG9QqE10YN8ExRnaY5icPn
	 mX/7xNjkP7FP4j2G6DkAdGNeWmEqtYWK8BQt7JImQgvqKj83SlMCAyUMW/Ijod0mJadj3
	 TYAorYdKlpON/5fjt+2Jsr0g6i0DeZ+KpmT//p8Zf5jjZjl8HK4iGrvX1Gef+OdESxMio
	 MGubf1o2vqahaHYvL4dusou/X4kdpYbk0sDPWtsghRgdQIAaSebxF/kJnmGR91YyQoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790164272;
	bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xEZWuuBVBUmVAvNT/IKWx0+omjpMq1XU4r7at5Vc7L4tfiLqCkCyQpd0R6OCnfeg3
	 Qg9XRh//Fb2dxN1O0k/n6o/Xe3qQAu8tqWo6PdC3thBTKyPqAOA/b5zF3q9lMkzauo
	 2Z7A6ZZDwU3spk71kQ7cuz+hxTuxsc95uxQkejCmiU0bDvr52exbP+CcTgSqWjV1M4
	 xqNhFv4gh+W1wUQwCrc31533av2FAIQG0DCniZE2YuxQ7iavPSeRVuBef6nZmCZhOX
	 W+33hKttELcqwgL+zb++0wr7xTnucICdp+H2BxVwBGW0gsZwtWacs/E4b/nawS4ruh
	 ONu0skSaOLdJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6073760752;
	Wed, 23 Sep 2026 11:51:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D1CE194
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F272A406AE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UZC2Kur7Rzxa for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EFF6C406EA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790164262;
 b=qkOjYulX0TMqSDe+8IDQ1PC9CBZO1Tmv3lqRMfA5F820tAYW0bn33IEs4+Il//5iQHFX
 moCSOJg8PtN5+fEayFW53VXniYYIQ23XKXxJWfpOzkKIi3SbyIsgCZXYh9SWhEITu9XkJ
 SMbqH+B+XxTYE0sMKwziWXw4ImVWdJWkf2ry0LcqS1Lh1O+VTWJCtsnyeZ725Tk8jkW02
 aKlw7AoDxCwpiDC75cqqMmIz9Q1cpBtOTJ4rEVVBjgcgyaqbATtDOgeeSZHDLHwHwiJaU
 mGIBXeq7p6S3kHQg6G8b6eBIgXA9KqdRWY+NromxgBgIxFf2THnEo4b+cHrLTV9HiUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790164262;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
 b=PQZdEVMmIAX0AALdTAqIxrY6L2GE3nYM263oRDfTKp9guhITGLgowkb7yNrTDcHhoXXN
 uxdhgi0uI/gU7j/raVpLnhlhe/FDtJS7lfLiUdimojzko2DebTSdk0dwNW4QNGZW1vJvk
 VcsEneXjJHJla8FQ07A8B1bbi8bYWSvI4Uyl4Bwne/8gKzt5OVDCtThONcggAysN9NKyN
 21RXwkklHV6hxBkdDDCFB3sCgG5rPegYF06NEJjBuNFtiTncS05fsMUmCCcJd75ILOWgu
 PqdGm7bECqZNvXKBgOcw7ZsliDM8+1G+C8GnD1YfX3MJyn9c/qjr7zEdFIpgfJT4EdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=gLeX9k31; 
 arc=none smtp.remote-ip=185.136.64.226
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 23 Sep 2026 11:51:00 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=gLeX9k31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-1328817-202609231149539c2f7dabcc00020796-ldsmfl@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFF6C406EA
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:50:59 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202609231149539c2f7dabcc00020796
 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:49:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
 b=gLeX9k31S+A05ocYa+pAhKCwGCDjcbj7Hp1Ti1n0n1rBKmNaJ2stJO/hTmAVzyTbOWC6oU
 THs7lmJd6rji42NHuHvPV7+7dNSH74BjyH43XP5GQfdOn3B3Q/V+Kv5DKfOVKwlW863ybp9E
 j2xPSPcG/74j2qE9I1ANSd4LEPS/2PajEhEii1nzPJ9+u04vZrvp5fnAY2IJRlglfdhOW/G9
 EuCfZ/ybt8Z16NdZREnTGrEEmHBCR0IY9Vd8LImuSh5PNBXvJQth9FeW6Y9TuP3U74rq4q3v
 wg1Tv1L4oXqdHpA5VGKoBV/A5B4VMP7J4H5gIcz5l0Pga3qpsJUBJJlA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 2/7] mkimage: define log_err and log_info
Date: Wed, 23 Sep 2026 13:49:29 +0200
Message-ID: <20260923134933.v10.2.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
In-Reply-To: <20260923114940.349985-1-ludwig.nussel@siemens.com>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Define log_err and log_info centrally in mkimage.h so any file used in
this context benefits from it.

This patch is in preparation for a change in image-fit-sig.c in the
next patch.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v4)

Changes in v4:
- fix and reword comment

Changes in v3:
- make log_err use stdout too

 boot/image-pre-load.c | 3 ---
 tools/mkimage.h       | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..cd319ddb777 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -35,9 +35,6 @@ ulong image_load_offset;
  */
 static struct image_sig_info *host_info;
 
-#define log_info(fmt, args...)	printf(fmt, ##args)
-#define log_err(fmt, args...)	printf(fmt, ##args)
-
 void image_pre_load_sig_set_info(struct image_sig_info *info)
 {
 	host_info = info;
diff --git a/tools/mkimage.h b/tools/mkimage.h
index 5d6bcc9301a..d8d292a8098 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -31,6 +31,12 @@
 #endif /* MKIMAGE_DEBUG */
 
 #define log_debug(fmt, args...)	debug(fmt, ##args)
+#define log_info(fmt, args...)	printf(fmt, ##args)
+/*
+ * Use stdout rather than stderr so error messages stay
+ * interleaved with normal output in the order produced.
+ */
+#define log_err(fmt, args...)	printf(fmt, ##args)
 
 static inline void *map_sysmem(ulong paddr, unsigned long len)
 {
-- 
2.43.0

