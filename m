Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A79ED2FEF4
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 23:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D22841E2;
	Wed, 28 Jan 2026 00:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ynXW06xT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pJN+hHpX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B209F841E3; Wed, 28 Jan 2026 00:52:11 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B452F841D7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 00:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f12J92Q2Dz9tgh;
 Wed, 28 Jan 2026 00:52:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769557929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=enw3Nps7p/cp0YglUeLYTV02FsyCm/jaQzF3mNfuX0Q=;
 b=ynXW06xTpqEyA3rEWcAoenZcyImJ5fbdcopfhfK4rkjgmsnZqO82vJ/3ByfoZZoTQiXMl6
 4YJq7/f9bEdjckRkfDoU8bIhuOcnHCf+mR5cxQDUHGOe5Z0Qoxv+GWPdX/nRkZxOmJ5Fjw
 gjGEemJmltkgJncIF5Ex1Su3wTLEO8iRLDAwY0Aq6HziK1GNTOi6+QCdnCXOh1AmqSkdAQ
 LgMEy3WbFStlw8Pton6UEmIVt3FwGkAHwuzXX+h5jS6KI0B2K4ri5l/v2a1pc4L1KELLQ8
 NwRIMVnKprh1ZjgUXUZlmD1RzF83EGUpfl+o5/zsZCX0CogIEqnPAPdjg75qLw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pJN+hHpX;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769557927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=enw3Nps7p/cp0YglUeLYTV02FsyCm/jaQzF3mNfuX0Q=;
 b=pJN+hHpXF5v04nDDXOM1jkVtzeRe2rEDZRTj3c1xB1b36jkFmBHFu+Wn1rUeEQCl/HK9J9
 RdFznBeewsNL3vykOnJr7nuTf/x7300U/UYNNXrRmYCrvANWFcUDIOiUA7tqfgE5IIsz6P
 star6RCa2DlDShWdujymbiuHdWhYKpT6ujPkHPKwT0fCm/XV6oufUeY9qPtrMRsy5SHacm
 b4uq2Mw56jB587+ELFVzKijSNILihNnZYZ9zLaUT0z5q21WLAJ5hysl5s9JUxg1DdUtu5z
 JpP332AnnHKOS3fqo0oa2ln8j+QNEpzcVbP+MDy6tym8+CE7Lacntg1g1Q1m3g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] gunzip: Fix len parameter in function signature
Date: Wed, 28 Jan 2026 00:51:35 +0100
Message-ID: <20260127235156.1503207-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 064c7ac338cf0b9f8ac
X-MBO-RS-META: 1d3pnmdztg69he6wnq8gqd58i1skfdhz
X-Rspamd-Queue-Id: 4f12J92Q2Dz9tgh
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The only call site of gzwrite() is cmd/unzip.c do_gzwrite(), where
the 'len' parameter passed to gzwrite(..., len, ...) function is of
type unsigned long. This usage is correct, the 'len' parameter is
an unsigned integer, and the gzwrite() function currently supports
input data 'len' of up to 4 GiB - 1 .

The function signature of gzwrite() function in both include/gzip.h
and lib/gunzip.c does however list 'len' as signed integer, which
is not correct, and ultimatelly limits the implementation to only
2 GiB input data 'len' .

Fix this, update gzwrite() function parameter 'len' data type to
unsigned long consistently in include/gzip.h and lib/gunzip.c .

Furthermore, update gzwrite() function 'szwritebuf' parameter in
lib/gunzip.c from 'unsigned long' to 'ulong' to be synchronized
with include/gzip.h .

Since the gzwrite() function currently surely only supports input
data size of 4 GiB - 1, add input data size check. The limitation
comes from the current use of zlib z_stream .avail_in parameter,
to which the gzwrite() function sets the entire input data size,
and which is of unsigned int type, which cannot accept any number
beyond 4 GiB - 1. This limitation will be removed in future commit.

Reported-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de
---
 include/gzip.h |  4 ++--
 lib/gunzip.c   | 13 ++++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/gzip.h b/include/gzip.h
index 304002ffc42..5396e3ffec7 100644
--- a/include/gzip.h
+++ b/include/gzip.h
@@ -77,8 +77,8 @@ void gzwrite_progress_finish(int retcode, ulong totalwritten, ulong totalsize,
  *		for files under 4GiB
  * Return: 0 if OK, -1 on error
  */
-int gzwrite(unsigned char *src, int len, struct blk_desc *dev, ulong szwritebuf,
-	    ulong startoffs, ulong szexpected);
+int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
+	    ulong szwritebuf, ulong startoffs, ulong szexpected);
 
 /**
  * gzip()- Compress data into a buffer using the gzip algorithm
diff --git a/lib/gunzip.c b/lib/gunzip.c
index a05dcde9a75..040450c0e79 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -116,11 +116,8 @@ void gzwrite_progress_finish(int returnval,
 	}
 }
 
-int gzwrite(unsigned char *src, int len,
-	    struct blk_desc *dev,
-	    unsigned long szwritebuf,
-	    ulong startoffs,
-	    ulong szexpected)
+int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
+	    ulong szwritebuf, ulong startoffs, ulong szexpected)
 {
 	int i, flags;
 	z_stream s;
@@ -133,6 +130,12 @@ int gzwrite(unsigned char *src, int len,
 	u32 payload_size;
 	int iteration = 0;
 
+	if (len > 0xffffffff) {
+		printf("%s: input size over 4 GiB in size not supported\n",
+		       __func__);
+		return -1;
+	}
+
 	if (!szwritebuf ||
 	    (szwritebuf % dev->blksz) ||
 	    (szwritebuf < dev->blksz)) {
-- 
2.51.0

