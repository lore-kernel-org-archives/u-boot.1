Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32EB606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q/m9Q/5A;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jer5InnG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A403480C26;
	Mon, 23 Nov 2026 04:03:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UYPqJPCz6Lt4; Mon, 23 Nov 2026 04:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC9CC80BE6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406614;
	b=a3Zt7vhyeP2pvoBGfsb5B636A7Q8fMOMoqBzeHOGDrE28Qas4HJwrOAjDs0KZn7GwoSf
	 ucsbNCK1XDq/wqqdA6sugsjD3PmvFCQU3jBRgVavI0Yr1SKmd89rPe2RS1aON/Sxk3UNP
	 ptgLCAGHKeDKQxk6qlijzrLDruVVzzcBVMC7t87nOmI+0Bd9Kwkq+2DHHBQdeYhLspm8o
	 Ttd/t+pW5BvoK4AO8DSqwqk+P13hdZ8z1H5nRdFFNCSIpZlribWm7g8Wf35DRIzj3TqmF
	 H9gcNw6AciQlV5h0fzY7vZHum1gDf9shdmlMLidcA91kBD139WhDZfHRRPUx2SjOy0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=XXohRDnkx6tKY2s19refNg4BmSroeuA+57QyHNGXVIE=;
	b=tXz0jjTkSAwRYoCvgWE8phllUTUOH5apqzDl0MEzKCtttceov+LNg92I7wm9S6Y6FQtc
	 FT6125yGtCV5UBv7tE1Pk/EKB36pZmE4YO5BSWHVfSfMArxzXqPIC1tn8Z6JYsVqEqALv
	 d9zopCrzQM2M7JPaXSSVGu+qKVfRJU/xgtouioehYAXZe7eUYT1gtRFApgeEqVOHIkbZt
	 YR/0aFBDMCQ1lXA/U5i6er14sKmETS7R7+378Pa8CrfCdFM3ByfD4oMXpmHuUw+UXdesl
	 7dZHGSmyG11G8BB0GEfNhxgmC86ouY7rZEPEpXPtMlQW96Tqey3BwbyEBnWtsuNEHjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jer5InnG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795406614;
	bh=XXohRDnkx6tKY2s19refNg4BmSroeuA+57QyHNGXVIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Q/m9Q/5AYnNCB9GClSJAqux++DGFxgm3s6xeozXywrV1IXBycssCWkx5iuVf87RtQ
	 3oEwDBjw0EJov6Iu2wZcfq9iD/KL2Z1i5ODkVbs/2+tZVLcLHgdqxoRapcrZR0SQJM
	 094aExeRhrWvF2PnyRQP7gghJdtt5cwnP+y0srt2JEYtcP/DYgkWF1Cp9WVRwSglz8
	 xSHIwQXAwIYegirc4+R2ej2dxZp+R8sDLUyMBDlMmu+BW/L2i8APmOruOfe/L3oTYZ
	 RYROwZtNBjYZUFxuLsDK7r47gmpxIvu9jx0m2Wt2oqjDxMV3ymz8OtvAtduvRoBL/G
	 8fhsvpxQK9xhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC9CC80BE6;
	Mon, 23 Nov 2026 04:03:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDB461AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6BFB80BE6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKDcKOIhrbl3 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C452380B9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Jer5InnG
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C452380B9D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16F8943729;
 Mon, 23 Nov 2026 04:03:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BA1C31F000C6;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795406608;
 bh=XXohRDnkx6tKY2s19refNg4BmSroeuA+57QyHNGXVIE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Jer5InnGF0LYcSes8hutXz5KbiM93MSBClvyzqIzAhlG0Awg/gkVsExpXoi1zT5WP
 xmdg5Emo9SM9Q90kriQxkHTcfrOT1N+Pqi/sWyAF7wB8Pfv98giTyUSR9us3Q1y9vz
 kAoV7ptRLaTcUOJudS+toAtq5wOAWJys+is/oL99EM/ZWrqh9YE9f2UjHDySXQ21xe
 9/6KOjvrcFXxFEL8yD9DSaJTceSdZ25gvRm8czwVOEXiKOU4ww5qU0V9BGHrvdGIBk
 QR3dCxXNT3cbh8O2vbdV6TxOAH/Lhc4g2RsZ2ETMtK5zRAK6OQhfXrvDH3RFXqgi32
 YeFlclVRj5raQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4A6D24C313;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 04:03:16 +0000
Subject: [PATCH v2 1/8] net: lwip: move HTTPC_CONTENT_LEN_INVALID to
 http_client.h
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-wget-blk-r4-v2-1-073d800a5aaa@iav.lv>
References: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
In-Reply-To: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2346; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=I0WSHlQEBZMTKu3wIKgA7J/V/0zbYXGn/rWQDSqBYc8=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMu1kPnDty8CRPTmLJjP2S73bHLvfXLH61g6tvwvmEM
 zmP2phaOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBE9LYw/K/xe5oSliN6eK/+
 79TEGfU67f+7HHL84xYwZobN2N/9ro/hn6rPJWM7V5UPZ4VXnWmO949f3cInszKt661esue1w+7
 MfAA=
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

The HTTP client passes HTTPC_CONTENT_LEN_INVALID to the headers callback
when a reply has no usable Content-Length, but the value is defined in
http_client.c only, and the header documents it as -1. Move the define
to the header, so that a callback can test for it by name.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 lib/lwip/lwip/src/apps/http/http_client.c         |  2 --
 lib/lwip/lwip/src/include/lwip/apps/http_client.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/http/http_client.c b/lib/lwip/lwip/src/apps/http/http_client.c
index 6ed739e13fd..06533c55c22 100644
--- a/lib/lwip/lwip/src/apps/http/http_client.c
+++ b/lib/lwip/lwip/src/apps/http/http_client.c
@@ -87,8 +87,6 @@
 #define HTTPC_POLL_INTERVAL     1
 #define HTTPC_POLL_TIMEOUT      30 /* 15 seconds */
 
-#define HTTPC_CONTENT_LEN_INVALID 0xFFFFFFFF
-
 /* GET request basic */
 #define HTTPC_REQ_11 "GET %s HTTP/1.1\r\n" /* URI */\
     "User-Agent: %s\r\n" /* User-Agent */ \
diff --git a/lib/lwip/lwip/src/include/lwip/apps/http_client.h b/lib/lwip/lwip/src/include/lwip/apps/http_client.h
index 50403fb4cb3..322e51cc852 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/http_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/http_client.h
@@ -67,6 +67,13 @@ extern "C" {
  */
 #define HTTP_DEFAULT_PORT         LWIP_IANA_PORT_HTTP
 
+/**
+ * @ingroup httpc
+ * Content length that the headers callback gets when the client read none
+ * from the reply
+ */
+#define HTTPC_CONTENT_LEN_INVALID 0xFFFFFFFF
+
 /**
  * @ingroup httpc
  * HTTP client result codes
@@ -117,7 +124,8 @@ typedef void (*httpc_result_fn)(void *arg, httpc_result_t httpc_result, u32_t rx
  * @param arg argument specified when initiating the request
  * @param hdr header pbuf(s) (may contain data also)
  * @param hdr_len length of the headers in 'hdr'
- * @param content_len content length as received in the headers (-1 if not received)
+ * @param content_len content length as received in the headers
+ *                    (HTTPC_CONTENT_LEN_INVALID if not received)
  * @return if != ERR_OK is returned, the connection is aborted
  */
 typedef err_t (*httpc_headers_done_fn)(httpc_state_t *connection, void *arg, struct pbuf *hdr, u16_t hdr_len, u32_t content_len);

-- 
2.43.0


