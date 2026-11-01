Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF43606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ue3ARR/F;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdpH63PC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19C92807E5;
	Sun,  1 Nov 2026 05:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUEXXFhPQvkZ; Sun,  1 Nov 2026 05:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6FF680986
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512416;
	b=B2HAvAr3kQen8Cj1oEuYiP31/CarDiPqC2NvaD0vL8d/SUljCfszoZXphOkUegn5+WRx
	 XqqX4dMbrH2Xq3nMKDUzzjW54E6APltBLuN+Fwny4Ja+jjcRoYlvtQojAYNH3MJXrUhu4
	 4NjMmsp/c3eoTGkYSPwhbXJ2KChrYhxbIkU4xkI1/rVjoVIt/YRuK0OtnIhHRHvM/5+tZ
	 3xJAzgt46PIySPBwTOJeaznlok1OUenfFsdEVrnOuWx04LrX+f8WACpZ1mvlj+ZiQj2gf
	 YtRA3NUWGBtFvrZId2DDtiz490fyr8G2mwF8GcVLXlLuzMPffY3LqdHTIoJIX4uxQ+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793512416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Ds2oBKA6OMLkxQNUdxz7F0NwV1E49jfeYYCnAjm+X8E=;
	b=ExCaEU7mT+FX76yv+RHmv04CGRZj7C6EqAG8at4Z563Jmha2U5kd3zUgoJF5ehAXaQch
	 ZADb48Nqb0qH+aTk8no5U8tzVMfOw5jFKDsV0YwdhzS0ARTmGdN0LoA8+j3MKumqZKIfD
	 xfAt/yPb41+CHN82dYSba4+3oB9bWsj/ql848HQrPOM9UEvt4KyZw0ZwxKyNNO5mcXfPG
	 3gw8Kbxyq8F1Xjv4KTj8oA6EkX4x+j009jSlZE97CxIPy4HCNPjhvTAULr/2XAjl3WFVx
	 0AgCmo55k98738SXdRjdvUQx0QmkX/ae5KhurV2w1hoBa6i7OyXN2RrFZjBBtkUpLAw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdpH63PC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793512416;
	bh=Ds2oBKA6OMLkxQNUdxz7F0NwV1E49jfeYYCnAjm+X8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ue3ARR/FzLwqZgsiB/9u2XjNs12KkypdJILzsyBsLFJmJtRbkqyS6iS2gRzF/Ev2B
	 +mdH8fRcZhzGoJ/hi2gxel5WqcITrT9QlY7sGUe683H2av2KsMRsHbBnP3/JYR1GP5
	 pcufuwLRqfCcaIhpP7TRqer6O2wxNHqN1LZfh4iEfiqdzI593CF6pPHqbZged+sdJr
	 5ztjUfE1xV6MNxkuOr9QXyKB5GBur63iO6/lV0u7N6abcmx4l6wkITaLFsm3qz9nH7
	 X6BpgIT0WQVSWGfcEABU0ajjhDx0NwZeO+9FAhZsVY/3+sXh3RR86XeIMMZkTUFtZf
	 bCl0nw+xUY7KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6FF680986;
	Sun,  1 Nov 2026 05:53:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2D1432A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B49D98107C
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JvrvH8FOLQUr for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B55E58102A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512410;
 b=g4PnPtlVrNeMo/gX3FXCJrCvdQrxOM3aOwC3dGJewfPPv38ttAGD0bPYDDyljaOQjaNk
 tWhhN5XzN0VtGYBqi6ycoqAG9fcuSBEOuo0UV7FI3eXGXklPgkHkavhOUp+WIh0Og503c
 0sB5K2xqzGErLlKbfjIysnx4aVX52agmbSnTtC6cs0iZ2pCXWR9Xl6acA+q3hOxOLQTRU
 12malz4vLTtUsJ3K+mE64nKSKk8ynzgx+pmdRB70WbiFHFeH/IEVmVrfcCcrGAIBbU/aB
 oG5zbky7VXtOkhyHgjTUs4FfAtPE7V/TnfVZhaI8bEFfVoYv8jRQTbzy8Ns/43OeUxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793512410;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=Ds2oBKA6OMLkxQNUdxz7F0NwV1E49jfeYYCnAjm+X8E=;
 b=qPzTLe4Rg/MKkBcM44/1oepby8D2WMFFo4u/tXPGYJv3Z/zvF2OXxxyqazcEJ0xT/2pD
 znDkNxNcU71vS9RdFUjAYMFJYEKyfSZl6AD58y8Gva7DoxxInfF9yrjQ+bLet7ZeV7h11
 SH4/dxZb1FPvyItsWu9Ln9nrrSbXWOs2zs3m3Bxe8UGnQJRkEA7SuhgBu+AyLaMZ4vTQC
 CbLuMR/ajj9zwXyMQdub96JuTA0HGXg/eOoJK3LFXl90UZ7DwcRIzrTkzQv0s9utlMEZZ
 /rqjTlaufzvXpC7UCGBztgnxAkDVAr2l5T2sNtjBloQoWM3Z9RyTPTAMlez3hCJSSlw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FdpH63PC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FdpH63PC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B55E58102A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 38652605D4;
 Sun,  1 Nov 2026 05:53:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793512408;
 b=HBRZH8MkVic3jCydKBKxXQL+/u8tRMZCnZK8mn2kuP1ZVfH08mD8SjnRW5AhOWdO9uDh
 NI8qrsmnr3+UsfPj4nwq02Y+/6XTsC/PFk0kmtx94vEMXqy3hLqzIMT78BguEcZAjo5fy
 Lg9d1iUD+fjlusu2U4gmEv/XI1yZY/a+6+raT3FfGhjqbcYJChGLQczXD45ydZ1tqyIDn
 ogVKoDf3EaJLhTE2Tt7zTmyzSS5WU0solHiAh2SkaGhhG8nDEWk/nI9yLLeHwFqosXJuc
 KhDxSRAELIVkdoTm7R6F2HRfWtorgTLNbe65DloUM49z3OrXszyqWimWXTllThBZLRg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793512408;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Ds2oBKA6OMLkxQNUdxz7F0NwV1E49jfeYYCnAjm+X8E=;
 b=a5plgn3d+KXr3pbwJQfnWDX2HaM+Y3t1Pwq4WuGxE1ieMwbpf5BR+pt5Ui0xLOIdJks5
 SZASvkodqt+2WK5HVdSw/fcBz/w83Cj8PB/8XQPEpLi42CStGs2Hl3r2zOcjHondowg25
 YI8ufXt0pd26/F/3ne9Llu+OEyAWPoK7jgl6BOm9b24t/EJNZpo+gufqJ6JBSJ7wesgfF
 fRJPYsLiCGjcOwjfCq3UPwPVQa1KDZZxe+WMlQvmWDemgvs6dXq+puwT0sCXZZTMo3ddr
 liKLZj8D32XlGqpT/2IPQONWpfgjLexpJcx+bbFSGDyYuVYPSKfSABdavabBCHiqDzw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B0A661F00919;
 Sun,  1 Nov 2026 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793512408;
 bh=Ds2oBKA6OMLkxQNUdxz7F0NwV1E49jfeYYCnAjm+X8E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=FdpH63PCeauJILBX9Mfe1n1dSpJW7lHHfxsLB8h2qXhtCzvdlYWC0ZUm5TQQctOE6
 m03R+xMBkMeVDe9gbP6MWApLLLSXO1r94XlmhCtUXsPN8FwAGNuk3JXedniMgcki2n
 tOgpwkNHgRgKIVgD+ONwImg4UNcfYCLPOD4YvwXlI6aTsr0xTAroznkzQvw9iWhO1u
 ZFp64yk+VKjGBjmFLNMBrRzdj4ArtvnKyEW0M+bAipSqG8mMIDWKVrs7HbxFG71kro
 Yy7/SWoc/uDTmabJHqDDn68mwvSi0+Dio8mjgxaC361bXcFiRrzClD8fFZpMw/S/5+
 1UHyqhEJLsV+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 40EF5460B9;
 Sun,  1 Nov 2026 05:53:27 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 01 Nov 2026 07:53:24 +0200
Subject: [PATCH 2/4] net: lwip: wget: hand the payload to an optional sink
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261101-b4-wget-blk-r4-v1-2-e27a009e4043@iav.lv>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
In-Reply-To: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6395; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=lCIJ4dMzfcMD6q4KqvwuhsLovHe/rjJNuwpcPbY7Jfk=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnPLl9x4EteI91onbLZ94mEx7PT0oqeVfsjbl+xTtpX7
 uu0hUW+o5SFQYyLQVZMkWXCIY1bGUuu/vX3MH8AM4eVCWQIAxenAEwkJ5rhDy+Dn/Ocyl8yQmt2
 O8RwfWqOKPyU1JiYO/uo/cw6t2Nuaxn+x6l/zKx7vF9J/C8H+3Ne+XWOrltusjzdee+RpnDMHQM
 7JgA=
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

wget copies every received block to memory, so a download cannot be
larger than the free RAM. Writing a disk image to a block device while
it arrives needs the blocks one by one instead.

Add a sink callback to struct wget_http_info. When a client sets it,
store_block() passes each block to the sink and copies nothing, and
wget does not set fileaddr. altcp_recved() follows the sink, so the
TCP window reopens only after the sink has taken the data.

lwIP hands the body to the receive callback whatever the HTTP status.
With a sink, wget checks the status in the headers callback and refuses
the body of any reply other than 200, then reports the server error.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 include/net-common.h |  6 +++++
 net/lwip/wget.c      | 76 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index f1f670dbd8b..75640d4ba41 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -623,6 +623,10 @@ enum wget_http_method {
  * @hdr_cont_len:	content length according to headers. Filled by wget
  * @headers:		buffer for headers. Filled by wget.
  * @silent:		do not print anything to the console. Filled by client.
+ * @sink:		if set, receives the payload piece by piece, and wget
+ *			writes nothing to the destination address; a negative
+ *			return aborts the transfer. lwIP only. Filled by client.
+ * @sink_priv:		first argument of @sink. Filled by client.
  */
 struct wget_http_info {
 	enum wget_http_method method;
@@ -634,6 +638,8 @@ struct wget_http_info {
 	u32 hdr_cont_len;
 	char *headers;
 	bool silent;
+	int (*sink)(void *priv, const void *buf, size_t len);
+	void *sink_priv;
 };
 
 extern struct wget_http_info default_wget_info;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 615ea035a28..5d275d28a81 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -41,6 +41,8 @@ struct wget_ctx {
 	ulong hash_count;
 	enum done_state done;
 	bool aborted;
+	/* status that made headers_done refuse the body, for the message */
+	u32 bad_status;
 };
 
 static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
@@ -141,25 +143,19 @@ static int parse_url(char *url, char *host, u16 *port, char **path,
 }
 
 /**
- * store_block() - copy received data
+ * copy_block() - copy received data to memory
  *
- * This function is called by the receive callback to copy a block of data
- * into its final location (ctx->daddr). Before doing so, it checks if the copy
- * is allowed.
+ * This function copies a block of data into its final location (ctx->daddr).
+ * Before doing so, it checks if the copy is allowed.
  *
  * @ctx: the context for the current transfer
  * @src: the data received from the TCP stack
  * @len: the length of the data
  */
-static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
+static int copy_block(struct wget_ctx *ctx, void *src, u16_t len)
 {
 	ulong store_addr = ctx->daddr;
 	uchar *ptr;
-	ulong pos;
-
-	/* Avoid overflow */
-	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
-		return -1;
 
 	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
 		if (store_addr + len < store_addr ||
@@ -176,6 +172,35 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 	memcpy(ptr, src, len);
 	unmap_sysmem(ptr);
 
+	return 0;
+}
+
+/**
+ * store_block() - store received data
+ *
+ * The receive callback calls this function to pass a block of data to the
+ * client's sink or, without one, to copy it to memory.
+ *
+ * @ctx: the context for the current transfer
+ * @src: the data received from the TCP stack
+ * @len: the length of the data
+ */
+static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
+{
+	ulong pos;
+	int ret;
+
+	/* Avoid overflow */
+	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
+		return -1;
+
+	if (wget_info->sink)
+		ret = wget_info->sink(wget_info->sink_priv, src, len);
+	else
+		ret = copy_block(ctx, src, len);
+	if (ret < 0)
+		return -1;
+
 	ctx->daddr += len;
 	ctx->size += len;
 
@@ -235,6 +260,11 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 		ctx->done = FAILURE;
 		return;
 	}
+	if (ctx->bad_status) {
+		log_err("\nHTTP server error %d\n", ctx->bad_status);
+		ctx->done = FAILURE;
+		return;
+	}
 
 	if (httpc_result != HTTPC_RESULT_OK) {
 		log_err("\nHTTP client error %d\n", httpc_result);
@@ -270,7 +300,8 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 				rx_content_len);
 	wget_lwip_set_file_size(rx_content_len);
 	if (env_set_hex("filesize", rx_content_len) ||
-	    env_set_hex("fileaddr", ctx->saved_daddr)) {
+	    (!wget_info->sink &&
+	     env_set_hex("fileaddr", ctx->saved_daddr))) {
 		log_err("Could not set filesize or fileaddr\n");
 		ctx->done = FAILURE;
 		return;
@@ -279,13 +310,35 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 	ctx->done = SUCCESS;
 }
 
+/* Status code from the "HTTP/1.x NNN ..." line, or 0 if there is none */
+static u32 http_status(struct pbuf *hdr)
+{
+	char line[16];
+	u16_t n;
+
+	n = pbuf_copy_partial(hdr, line, sizeof(line) - 1, 0);
+	line[n] = '\0';
+	if (n < 12 || strncmp(line, "HTTP/", 5))
+		return 0;
+
+	return simple_strtoul(line + 9, NULL, 10);
+}
+
 static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct pbuf *hdr,
 				   u16_t hdr_len, u32_t content_len)
 {
 	struct wget_ctx *ctx = arg;
+	u32 status;
 
 	wget_lwip_fill_info(hdr, hdr_len, content_len);
 
+	/* the body of an error page must not reach a sink */
+	status = http_status(hdr);
+	if (wget_info->sink && status != 200) {
+		ctx->bad_status = status;
+		return ERR_VAL;
+	}
+
 	/* lwIP passes U32_MAX when the reply has no usable Content-Length */
 	if (wget_info->check_buffer_size && content_len != U32_MAX &&
 	    (ulong)content_len > wget_info->buffer_size)
@@ -423,6 +476,7 @@ int wget_do_request(ulong dst_addr, char *uri)
 	ctx.content_len = 0;
 	ctx.hash_count = 0;
 	ctx.aborted = false;
+	ctx.bad_status = 0;
 
 	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
 	if (ret)

-- 
2.43.0


