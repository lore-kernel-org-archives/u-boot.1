Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1A606A32C
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NdjFIIe6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZlmueD6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 954244066C;
	Mon, 23 Nov 2026 04:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYvTLTr5HgU4; Mon, 23 Nov 2026 04:03:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE2774064E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406627;
	b=SQ9nNtSqJ/euFyy40jPuKVczELfW97vY3ozWLrWK1/+QPSx4xRL1P8b1l9FzrHjkx/N+
	 6D9XzttCkoUItPxFGMXhmyIQiiizezD1pLRg78CKosj6BGSAQhLdIRPz7SpaPUaEnPNBU
	 CH3N6pFHtEMF2gIAnyDr9aTBSl2OGYb1gumVBV61vBs2JvjtfVW2504G2FcW26sUK81k9
	 y5cEhkR7NFxHmIp8/LNN+91LoKSHXVZSo3vmdTmOZVX3qXUAm3UrFF+UMT3YQVtdJ4Ai5
	 bXmgRXhfp5xYx3st+4OHDQ6AdoBDnU3J6YafvYgqWzY6nltOE7XUnJPVNX3+RtWo13w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=fm0GoPo+DXqsfnyoB3UkqZXhEH3+j6hA5JdrTbyoChI=;
	b=k2az+/NV2Q66p1FrqtVm5LKLlWB06mjpmtHsRgnD8HlSWReSSArvnGgDV4+za6aQbT7b
	 SOnmlS5LWIdENz6Ze98ZhiiG+oE5oiCgJQ8ZdDblCdVfQdwvs7Xa2Hfq1J008NzKuK1Jh
	 EdzhTZ6ihA9oQ2/MTNDSLPqEE3KyEBxgDewCSsGKamy6i945ZUdTYGIpCpbhSwWQcPWb0
	 LnIjs6i5ch9fO7HcVw+CNR5CeaVQLr+Kn6h72OqpyeZOmpZk8A8pbKj3TLnX5aYpcxpBL
	 ykgWjKrtU6lmTuiddxMzRxGvIuVWfm+iSIXdLcPO+WUtf522JPQLDz0yU2i12LkJQjw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795406627;
	bh=fm0GoPo+DXqsfnyoB3UkqZXhEH3+j6hA5JdrTbyoChI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NdjFIIe6nnMEBdACCQ6TaHwqS9PTIBX3QfhgxieUuJUtwsn9OVGYng0LS5hy+Cskd
	 SiQcOm+WLAsQcBPRgh2eH4wFBSFB/Niowbj+27iy38KmhsJcIPGYL7Rz7+oLNTFom3
	 kRNQEaw9ZY1SuYHiF90xnmj/EXiZe6h9gEmm1Oe0mg0Y+Fj8/Dul0FQa1Tr/h4VNqb
	 7tgo0pqPeUaDGqzTO6nOqTRu9+FcD7BxixfwvOqg0UouegsOBgJdu9VqXhfysUXAnn
	 D3bd7vVoXWBiPs54owHNeggNV/8x78iBsUKAGf5Uz9kJi/hXbM/lG73C747V3uO12q
	 2vxrZg7y14K7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE2774064E;
	Mon, 23 Nov 2026 04:03:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D8406DA6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9ABB6069D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPAF3THfgfE8 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B855C60697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IZlmueD6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B855C60697
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E40D60D3B;
 Mon, 23 Nov 2026 04:03:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8370C1F000E0;
 Mon, 23 Nov 2026 04:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795406620;
 bh=fm0GoPo+DXqsfnyoB3UkqZXhEH3+j6hA5JdrTbyoChI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=IZlmueD6X2i/Lvn1O7+lhg+ijGH+dbAXVVI9AL0FSDTJqTAwqj1TGnxNoYJt8XXgg
 Q22BRVRl4cYnDFYcUJUpfX41XlvEf9FFgrJUqDec7cYvDno7URN9lBKa79Iwh6Z7u0
 gijc1XxqoP/OVyunn5ggNaGsjXZI34nNl6iuJ6eL6biSd7TLzS31PWqNiOFvHu0TVL
 f30a/0rD+kg7JQw+UfsDSmuP3QQdj6BqQySmGhXOAqcoBd28PnZLt96gYmhZAgGqeg
 kQWhknJypqd3GbY+neMKcSh16PCgaiKMlwZMFN2yQ6OAkFdYyFaeGPlN0adaJPKvIL
 yX/7XuT98z/8w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BC2AD4C331;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 04:03:20 +0000
Subject: [PATCH v2 5/8] net: lwip: find Content-Length whatever its case
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-wget-blk-r4-v2-5-073d800a5aaa@iav.lv>
References: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
In-Reply-To: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3980; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=Z3h3Kvm50eRr8NesbrJTlyqNQpuFDH8M8H2KGyD8ZYM=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMu9l7i9p+G9Z5v3FsOHFUVvxYRP/5NV9OPra5/nh+z
 8TaFXWhHaUsDGJcDLJiiiwTDmncylhy9a+/h/kDmDmsTCBDGLg4BWAiqnsYGS6ueL50fe/T7prG
 TD+W+CVHqz3Cui/ZMRwUOPX2YqUcgxojw7aNxRNFznmkuJ073PWk9ut187NH1BSX2a/ddup131n
 nWVwA
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

The HTTP client looks for the exact string "Content-Length: " in the
reply. RFC 9110 (5.1) says "Field names are case-insensitive", and in
the field-line rule of RFC 9112 (5) the whitespace after the colon is
optional. A reply with "content-length: 3000000" or
"CONTENT-LENGTH:3000000" reads as one without a length: wget does not
check that the file fits, and a download that the server cuts short
ends with HTTPC_RESULT_OK.

Find the header line by its name without regard to case, and skip
spaces and tabs before the value. The search runs from the start of a
line and stops at the end of the headers: the old one also matched the
string inside another header name, such as X-Foo-Content-Length, or in
the body.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 lib/lwip/lwip/src/apps/http/http_client.c | 42 ++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/http/http_client.c b/lib/lwip/lwip/src/apps/http/http_client.c
index 29afa8bf655..7914b7cc5aa 100644
--- a/lib/lwip/lwip/src/apps/http/http_client.c
+++ b/lib/lwip/lwip/src/apps/http/http_client.c
@@ -294,6 +294,40 @@ http_parse_response_status(struct pbuf *p, u16_t *http_version, u16_t *http_stat
   return ERR_VAL;
 }
 
+/** Find a header line by its name and return the offset of its value, or
+ * 0xFFFF. A field name is case-insensitive (RFC 9110, 5.1) and whitespace
+ * before the value is optional (RFC 9112, 5). 'name' is in lower case, 'end'
+ * is the offset of the end of the headers. */
+static u16_t
+http_find_header(struct pbuf *p, const char *name, u16_t end)
+{
+  u16_t name_len = (u16_t)strlen(name);
+  /* the first line is the status line */
+  u16_t pos = pbuf_memfind(p, "\r\n", 2, 0);
+
+  while (pos < end) {
+    u16_t i;
+    char c;
+
+    pos = (u16_t)(pos + 2);
+    for (i = 0; i < name_len; i++) {
+      c = (char)pbuf_get_at(p, (u16_t)(pos + i));
+      if (lwip_tolower(c) != name[i]) {
+        break;
+      }
+    }
+    if ((i == name_len) && (pbuf_get_at(p, (u16_t)(pos + i)) == ':')) {
+      pos = (u16_t)(pos + name_len + 1);
+      while ((pbuf_get_at(p, pos) == ' ') || (pbuf_get_at(p, pos) == '\t')) {
+        pos++;
+      }
+      return pos;
+    }
+    pos = pbuf_memfind(p, "\r\n", 2, pos);
+  }
+  return 0xFFFF;
+}
+
 /** Wait for all headers to be received, return its length and content-length (if available) */
 static err_t
 http_wait_headers(struct pbuf *p, u64_t *content_length, u16_t *total_header_len)
@@ -301,19 +335,19 @@ http_wait_headers(struct pbuf *p, u64_t *content_length, u16_t *total_header_len
   u16_t end1 = pbuf_memfind(p, "\r\n\r\n", 4, 0);
   if (end1 < (0xFFFF - 2)) {
     /* all headers received */
-    /* check if we have a content length (@todo: case insensitive?) */
+    /* check if we have a content length */
     u16_t content_len_hdr;
     *content_length = HTTPC_CONTENT_LEN_INVALID;
     *total_header_len = end1 + 4;
 
-    content_len_hdr = pbuf_memfind(p, "Content-Length: ", 16, 0);
+    content_len_hdr = http_find_header(p, "content-length", end1);
     if (content_len_hdr != 0xFFFF) {
       u16_t content_len_line_end = pbuf_memfind(p, "\r\n", 2, content_len_hdr);
       if (content_len_line_end != 0xFFFF) {
         char content_len_num[16];
-        u16_t content_len_num_len = (u16_t)(content_len_line_end - content_len_hdr - 16);
+        u16_t content_len_num_len = (u16_t)(content_len_line_end - content_len_hdr);
         if (content_len_num_len < sizeof(content_len_num)) {
-          if (pbuf_copy_partial(p, content_len_num, content_len_num_len, content_len_hdr + 16) == content_len_num_len) {
+          if (pbuf_copy_partial(p, content_len_num, content_len_num_len, content_len_hdr) == content_len_num_len) {
             u64_t len = 0;
             u16_t i;
             /* at most 15 digits fit in content_len_num: no overflow */

-- 
2.43.0


