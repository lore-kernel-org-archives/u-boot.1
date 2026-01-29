Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E9ED73E87
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 22:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDF884106;
	Thu, 29 Jan 2026 23:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LsjWr2VA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UZvhV9uI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4EF38410B; Thu, 29 Jan 2026 23:31:30 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E44C84101
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 23:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f2DQ8150rz9vHR;
 Thu, 29 Jan 2026 23:31:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769725888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ged+bq2TXxx4gGgkdJCE/aBQrUa6s1ey4OGMBnnJZLE=;
 b=LsjWr2VAgYRQa/2UegnjHJ0mmRCHyflnrlKV2jOv3GIlr/aCstROy8wK4iAeK4jsZxZDQA
 9DJ6gSLpbSj2r12IfY7DG9v8wsZT2Svj8Bgz2qJu3+Kgid3tD9EgZheX2I2jSPTZ9V4J6x
 2abu1cR/p9QGT5BwbOAtZ5zy07Jyhffe6KQzMNIF6/Ekt28sJgJbpgL4mSEMV4zzKOa22v
 K7yILR4kEsGF/pHxz2q+Q845e5kg50cLKz5W1lSeSZyABgcnhlIgff7wKPB5vtWZmy9PpG
 qs1ygneGY0vcEISMYzFaPbOX2EYOe8RMTkuPavRFvHNYtJyaO4n5Z/nLhwBazg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769725886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ged+bq2TXxx4gGgkdJCE/aBQrUa6s1ey4OGMBnnJZLE=;
 b=UZvhV9uIA/cq8tcDoVsuWHp4cnH2OCYK6/OC+fqJhaSevLeuQSfCul/uPFYRpooA4xfH3F
 OgV5Tk91XsQ5cOh8l+3d0XESSTEpPtGiiPptw8gmAXYK2rak7RWjP89An4UFGmmm8CHhXj
 5CYznKIiSTav/SKz1J08QzJMBhnO26ovpiDLz9+NrVDNiSpcgbBl4M+rABzVg1wn3Gw+an
 P7pmvNTESHRbydO71PVUow9IVJugU188VT/VKnKeud+Nrm2C1FEwc+2jy3j+IGakCmKP4C
 l+9Q8jzH6JEOL03I75I+Poq/AB5sF9ASAi0NYLFy4j/EAWouu0/6blDhzHmkiA==
To: u-boot@lists.denx.de
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] net: Stop conflating return value with file size in
 net_loop()
Date: Thu, 29 Jan 2026 23:30:18 +0100
Message-ID: <20260129223116.653124-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a4534b2d64f15bce094
X-MBO-RS-META: fe98i4ashhg8pemr7wqt5bybzot5rk4j
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

From: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>

The net_loop() currently conflates return value with file size
at the end of successful transfer, in NETLOOP_SUCCESS state.

The return type of net_loop() is int, which makes this practice
workable for file sizes below 2 GiB, but anything above that will
lead to overflow and bogus negative return value from net_loop().

The return file size is only used by a few sites in the code base,
which can be easily fixed. Change the net_loop() return value to
always be only a return code, in case of error the returned value
is the error code, in case of successful transfer the value is 0
or 1 instead of 0 or net_boot_file_size . This surely always fits
into a signed integer.

By keeping the return code 0 or 1 in case of successful transfer,
no conditionals which depended on the old behavior are broken, but
all the sites had to be inspected and updated accordingly.

Fix the few sites which depend on the file size by making them
directly use the net_boot_file_size variable value. This variable
is accessible to all of those sites already, because they all
include net-common.h .

Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Alvin Šipraga" <alvin@pqrs.dk>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Leonard Anderweit <l.anderweit@phytec.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de
---
 cmd/mvebu/bubt.c |  2 +-
 cmd/net.c        |  9 +++++----
 common/update.c  | 10 +++++-----
 net/net.c        |  2 +-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
index 2755c26cdf7..f8e97d03920 100644
--- a/cmd/mvebu/bubt.c
+++ b/cmd/mvebu/bubt.c
@@ -661,7 +661,7 @@ static size_t tftp_read_file(const char *file_name)
 	 */
 	image_load_addr = get_load_addr();
 	ret = net_loop(TFTPGET);
-	return ret > 0 ? ret : 0;
+	return ret > 0 ? net_boot_file_size : 0;
 }
 
 static int is_tftp_active(void)
diff --git a/cmd/net.c b/cmd/net.c
index 24099764493..f6f556f36ae 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -354,8 +354,8 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
 	char *s;
-	int   rcode = 0;
-	int   size;
+	int rcode;
+	u32 size;
 
 	net_boot_file_name_explicit = false;
 	*net_boot_file_name = '\0';
@@ -396,8 +396,9 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	size = net_loop(proto);
-	if (size < 0) {
+	rcode = net_loop(proto);
+	size = net_boot_file_size;
+	if (rcode < 0) {
 		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
 		return CMD_RET_FAILURE;
 	}
diff --git a/common/update.c b/common/update.c
index 6801b49479d..0bafffede9e 100644
--- a/common/update.c
+++ b/common/update.c
@@ -32,7 +32,7 @@ static uchar *saved_prot_info;
 #endif
 static int update_load(char *filename, ulong msec_max, int cnt_max, ulong addr)
 {
-	int size, rv;
+	int rv;
 	ulong saved_timeout_msecs;
 	int saved_timeout_count;
 	char *saved_netretry, *saved_bootfile;
@@ -54,12 +54,12 @@ static int update_load(char *filename, ulong msec_max, int cnt_max, ulong addr)
 	/* download the update file */
 	image_load_addr = addr;
 	copy_filename(net_boot_file_name, filename, sizeof(net_boot_file_name));
-	size = net_loop(TFTPGET);
+	rv = net_loop(TFTPGET);
 
-	if (size < 0)
+	if (rv < 0)
 		rv = 1;
-	else if (size > 0)
-		flush_cache(addr, size);
+	else
+		flush_cache(addr, net_boot_file_size);
 
 	/* restore changed globals and env variable */
 	tftp_timeout_ms = saved_timeout_msecs;
diff --git a/net/net.c b/net/net.c
index 8a8160e633f..ae3b977781f 100644
--- a/net/net.c
+++ b/net/net.c
@@ -692,7 +692,7 @@ restart:
 
 			eth_set_last_protocol(protocol);
 
-			ret = net_boot_file_size;
+			ret = !!net_boot_file_size;
 			debug_cond(DEBUG_INT_STATE, "--- net_loop Success!\n");
 			goto done;
 
-- 
2.51.0

