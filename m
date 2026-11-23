Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73319606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BpiuQ26h;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0PvojkF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C56280D87;
	Mon, 23 Nov 2026 04:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 04p-UVKD9fl1; Mon, 23 Nov 2026 04:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79E7080D84
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406620;
	b=L99wNTBJmMSKj8GRT9FfEYyjzDZMOZvwWXXUS1Zl+QfmHCC/27kcMPDrvI+R/+2yKkwF
	 qypuXcHhHMW15hNJsKKivsUN57hxZnny9RftY9Cl3D6+RPH65RtzxUcxXop78tjpv7sAW
	 zZR9ekgRGCLk+K+/YsztFTVBR5lHECKxgS0/wyl33WNKhyp2oqJCrSKdYwdI0H3rWXTNW
	 du4UuJ89vucCGr4rdLbvxLM3wlKdG6dBF2zGI+r5NWo2sFrX20nswkB2Mnsh3n/MeTiy9
	 8cV47oguTs+A9rtOpAzT9/iQ4f91pQ3yUggxZZ66W/hq3TH2msWOUIOSR00J5Ov9jdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=0ug8vXBL2QwXLLQkgItIz2bVdmJ9XMYrcknRoaa0CZo=;
	b=eWM9RiYgTTxq/80dpajiHFKpYnmhzohaILdHHnTePj6d8YNOmVYfSCPqxWTFPQyI88Ke
	 MCe1bCNyHDJNBaURJlnu///zWhfUMh+RSkKhWZx38da3FnRSHxoRoJIJEAMHecaECXU1R
	 mP9DrztD8pNorDFWGGcExuY4frERLERk/eKn1d9A+p0Q/1oUjwYf8W60FgBcr031qQDHD
	 VnHG6gTQbdXDdDR22W4dGHV82u8cPxCBQ204UYlqJEIhXnLOSXZgcHQ9c3eMfbcveFaeF
	 UaI63yIB96Xxzc9WVjogZKCNgItKsI2mYXsJ9FU0EIhkVigiQKhsWJVQYPUf5ck0/DQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0PvojkF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795406620;
	bh=0ug8vXBL2QwXLLQkgItIz2bVdmJ9XMYrcknRoaa0CZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=BpiuQ26hqC7e3c50VQzEU5ul6DKilczEUPLtDr6M3T8scJt37S0O0GgV4e15/uJvb
	 HVFTxy9CdB0EHLpaSDOAa5VMdKfu5qT+OLeJNvbY41pvu2m/YrU+jjxGKd1kcihAM/
	 ydLzhz6BsElBKmRyRpGtLhSLlgx68wfZJwFo2CkJsLfITKH53o4dvL23J3769FBIy8
	 CX/ek79G9Nwn88YoKoLwKgD/nB/lW8e9QQh1yokjLXm8NihdXwbA/Pk7bl6D6/z2oD
	 EjrcOh3oOlzLnCCQ1WgW7788aMqXAbf8kLjml5FIEXFwaO65eNnaWV1l9/6Wu/aNsh
	 2E4+VqoajOtmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79E7080D84;
	Mon, 23 Nov 2026 04:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E7101AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7301280BE6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqDXE_JjCQ4K for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7EA3180BFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=G0PvojkF
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EA3180BFB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19AA960F04;
 Mon, 23 Nov 2026 04:03:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F0DD61F000D0;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795406613;
 bh=0ug8vXBL2QwXLLQkgItIz2bVdmJ9XMYrcknRoaa0CZo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=G0PvojkFSrGGHenrNd+L/Rqho1OasbEqECpaXUebLQsTvzLxqssWXtdvagd2RNMF8
 jm2XJcIGQYvbnFoPj0P4slRurVAbMFSSJz5Nup/QtWUzW62JvXaD8qi832n26BqfdB
 PZQjhHku0NyDkyI4E3JptDSD95vkd9Af/QyR8dTsFXWwIkgUu5DpPnVTLIlDTEee2o
 gL58h0ssV5KNu/p0kAoGbjyVotvmFoaqXUysFOq/QRyARcfKJlKDySshjp529tbJg/
 1pazz9L8lKOM00mSvv2SJsiC3sYnWD8Z9M7oGh51iMk+pZ0XviGaSs2/boB7vEdSvV
 Yvp6ey9qR6Gzw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 82A3C4C329;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 04:03:18 +0000
Subject: [PATCH v2 3/8] net: lwip: wget: count the download in 64 bits
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-wget-blk-r4-v2-3-073d800a5aaa@iav.lv>
References: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
In-Reply-To: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4188; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=KTvGhk7ZDeUDMXlzfgNhEN22uQJ+f1/rYUDCm6GrcSA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMu9kumx6vaclvWLf+eOpnwd2fOtn2fTi85+WBEwFTG
 uULNK4odJSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJPBZi+B/voMbJGjBZru71
 h7wnNyOOi73TnWJ36rmlZuL0xW5SEVEM/72qJJZrL9ztevjNxr7qh5o9QRXvduULBVr1b7M5Yrp
 +AhcA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

wget keeps the number of bytes received and the content length in a
ulong, and struct wget_http_info keeps the size of the client's buffer,
which the length is checked against, in a ulong too. On a 32-bit board
all three stop at 4 GiB.

Make them u64 and do the progress and speed arithmetic in 64 bits.
wget_lwip_fill_info() takes a 64-bit length and passes on one that does
not fit in the 32-bit hdr_cont_len of struct wget_http_info as U32_MAX,
the value that an absent length has there.
The progress bar does not divide by a content length of zero.

The lwIP HTTP client still hands over 32-bit values: the next patch
widens them.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 include/net-common.h |  2 +-
 net/lwip/wget.c      | 25 ++++++++++++++-----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 844840ce59c..6d671afd4a2 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -665,7 +665,7 @@ struct wget_http_info {
 	enum wget_http_method method;
 	u32 status_code;
 	ulong file_size;
-	ulong buffer_size;
+	u64 buffer_size;
 	bool set_bootdev;
 	bool check_buffer_size;
 	u32 hdr_cont_len;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index f0ba9b3d1ab..54c8bc612fd 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -7,6 +7,7 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <linux/kconfig.h>
+#include <linux/math64.h>
 #include <lwip/apps/http_client.h>
 #include "lwip/altcp_tls.h"
 #include <lwip/errno.h>
@@ -33,16 +34,16 @@ struct wget_ctx {
 	char *path;
 	ulong daddr;
 	ulong saved_daddr;
-	ulong size;
+	u64 size;
 	ulong prevsize;
 	ulong start_time;
-	ulong content_len;
+	u64 content_len;
 	ulong hash_count;
 	enum done_state done;
 	bool aborted;
 };
 
-static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
+static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u64_t hdr_cont_len)
 {
 	if (wget_info->headers) {
 		if (hdr_len < MAX_HTTP_HEADERS_SIZE)
@@ -51,10 +52,11 @@ static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_
 			hdr_len = 0;
 		wget_info->headers[hdr_len] = 0;
 	}
-	wget_info->hdr_cont_len = (u32)hdr_cont_len;
+	/* hdr_cont_len is 32 bits: a longer length gets the value of none */
+	wget_info->hdr_cont_len = min_t(u64, hdr_cont_len, U32_MAX);
 }
 
-static void wget_lwip_set_file_size(u32_t rx_content_len)
+static void wget_lwip_set_file_size(u64_t rx_content_len)
 {
 	wget_info->file_size = (ulong)rx_content_len;
 }
@@ -154,7 +156,7 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 {
 	ulong store_addr = ctx->daddr;
 	uchar *ptr;
-	ulong pos;
+	u64 pos;
 
 	/* Avoid overflow */
 	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
@@ -181,9 +183,10 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 	if (wget_info->silent)
 		return 0;
 
-	pos = clamp(ctx->size, 0UL, ctx->content_len);
+	pos = min(ctx->size, ctx->content_len);
 
-	while (ctx->hash_count < pos * 50 / ctx->content_len) {
+	while (ctx->content_len &&
+	       ctx->hash_count < div64_u64(pos * 50, ctx->content_len)) {
 		putc('#');
 		ctx->hash_count++;
 	}
@@ -260,8 +263,8 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	if (!wget_info->silent) {
 		printf("\n%u bytes transferred in %lu ms (", rx_content_len,
 		       elapsed);
-		print_size(rx_content_len / elapsed * 1000, "/s)\n");
-		printf("Bytes transferred = %lu (%lx hex)\n", ctx->size,
+		print_size(div_u64(rx_content_len, elapsed) * 1000, "/s)\n");
+		printf("Bytes transferred = %llu (%llx hex)\n", ctx->size,
 		       ctx->size);
 	}
 	if (wget_info->set_bootdev)
@@ -287,7 +290,7 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 
 	if (wget_info->check_buffer_size &&
 	    content_len != HTTPC_CONTENT_LEN_INVALID &&
-	    (ulong)content_len > wget_info->buffer_size)
+	    content_len > wget_info->buffer_size)
 		return ERR_BUF;
 
 	ctx->content_len = content_len;

-- 
2.43.0


