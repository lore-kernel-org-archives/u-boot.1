Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D53D2FEF4
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 23:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C42841F2;
	Wed, 28 Jan 2026 00:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xq5cjGQZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WlndWxAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE69A841F7; Wed, 28 Jan 2026 00:53:18 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0ABA841D7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 00:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f12KS4yJ7z9tpH;
 Wed, 28 Jan 2026 00:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769557996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8l+/+l9TDlWadAf7yifUA/6MQNcmObDh9DQuTIyb0Ag=;
 b=xq5cjGQZjemRlINYdU/zwJStYG6nq+Kc9uVIhqcUKn/XcxWEwpFKzlfrIm/RKw/q650Nyk
 DBX1lfkalCZNXcQdp5LJGSGqKpcs8iB+6m0z1UUTmeHHSHudR/L+U5gB7ISbiLFLvJo2EQ
 ufqm/LpphGZmxtphO/v9hL48Zxn5WnrCwMH+WczI3VF9C2p64u3aLcmop1UwSRH9OZwjmK
 8hCbiJPD8DlvSthMqguQ5Kp7veUexqdyOr+azB2msmxD59to+E0eos7g2m8omwXLUEBSB/
 OVp09tDauX2Op6Xvfs4mFgf3DW9QVKL6Ik4SKW/zx516o4gr2scWvEzWWniWvg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769557994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8l+/+l9TDlWadAf7yifUA/6MQNcmObDh9DQuTIyb0Ag=;
 b=WlndWxAIBm4Ismu0BB43g5DFE3kCQGmGEv9EPSIJ+UBzg0kDCLppY3Y3Adjkd53qMPWvt8
 msTgFAKVa2PiRJTBmljb7/E+MFkF5BGGlH4bdEDgJi8Qadp+IUzn9PZ1DzQHtXUPBtIV9N
 3HHK7QJHwhASLavfJXudE4wPai5b1T+hieFTgi2hkjaQ+kObObc2xhrppJvT/bz3bT7tQW
 HrTysykgGUX5tPybzg+mC7Ayi1JGVwkqczG5NF/ePLq24IQpFzSNkJAkHxMmD0/7dHT2ok
 20hZ99bHvfMTTLNd5Ofit3NCkJOSb0uSQE3/6IEgBvSMFp3L8528UVlO3IjN6w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH] cmd: unzip: Use map_sysmem() with buffers in the gzwrite
 command
Date: Wed, 28 Jan 2026 00:52:50 +0100
Message-ID: <20260127235310.1503239-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c852784885307feaaa6
X-MBO-RS-META: icheowguhs1f88m3rc9eoq65s8keg8nb
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

The current implementation casts an address to a pointer. Make it more
sandbox-friendly by using map_sysmem().

Convert 'addr' variable to unsigned long, as that is the return type of
hextoul() and address parameter type of map_sysmem().

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
 cmd/unzip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/unzip.c b/cmd/unzip.c
index e7a3f9808b2..b265f43f2ea 100644
--- a/cmd/unzip.c
+++ b/cmd/unzip.c
@@ -50,7 +50,7 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
 {
 	struct blk_desc *bdev;
 	int ret;
-	unsigned char *addr;
+	unsigned long addr;
 	unsigned long length;
 	unsigned long writebuf = 1<<20;
 	u64 startoffs = 0;
@@ -62,7 +62,7 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
 	if (ret < 0)
 		return CMD_RET_FAILURE;
 
-	addr = (unsigned char *)hextoul(argv[3], NULL);
+	addr = hextoul(argv[3], NULL);
 	length = hextoul(argv[4], NULL);
 
 	if (5 < argc) {
@@ -75,7 +75,7 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
 		}
 	}
 
-	ret = gzwrite(addr, length, bdev, writebuf, startoffs, szexpected);
+	ret = gzwrite(map_sysmem(addr, length), length, bdev, writebuf, startoffs, szexpected);
 
 	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
-- 
2.51.0

