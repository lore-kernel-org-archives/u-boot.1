Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809E1C5AD48
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 02:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D36E980F5B;
	Sat,  8 Aug 2026 02:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWDJajI8H1lu; Sat,  8 Aug 2026 02:22:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDA1080F4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786155774;
	bh=LI0ZRbCYf8whN8xlh7ZeJ60sJOTGG2uhBZ1xMvoaJZw=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MJK+HNdFqTKEpFXB1kMjCjD78xJhIOGG+bSA/Xqp4VsG9E80kfBuWikrypo9b5uKe
	 9zhwXlSds++MmyLsg3YWPWnZl4iyukV+Rg4jHZ8sO4nTsjQ/U4SElmmPC1qrwcNfMd
	 46BPE5XN6aOfL+QLDVTMKVLmNFhHepUqL4osjYwUYqQz7yOB8amEVl9VfrCZh6GC+o
	 +vpkmCmxV4nKnq5TOCdypz5/7DrIZ1bi8qvFW/BbwARxqaVCeal3077xWCcS1No58U
	 Xs8JCgtLfF2P/UFu0225+WSiFB++VS0Rs/+6ZgCXOvTjQ1vrrNzwA4Aq1Vrapk0ooT
	 jN2zinjIQKj8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDA1080F4C;
	Sat,  8 Aug 2026 02:22:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58D14392
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56B834011A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IF9CIenZECgQ for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 00:45:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 24848400FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24848400FD
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24848400FD
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:09 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 497723F9C5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:08 +0000 (UTC)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso162296a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 17:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786149907; x=1786754707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LI0ZRbCYf8whN8xlh7ZeJ60sJOTGG2uhBZ1xMvoaJZw=;
 b=kXItN2Ns4/OWJNPctphCJpgWVfRNgDA2zVOllqqPfm9d6iZuESDop6W1TNgQdjTMHd
 aqea5W5+6ekz5lNQyifRc1ZyeLKYlLE6SIuW5izWapej2X9VEBmUUJA+5fVE3cp6CaD3
 bTx9109OPBfZ626xfuNNHsPNYEJiNXZzQOk+dut+OsVZVnlnFoL4MGWgIdCdeLFFPP62
 BqwPkiwmHHYIiwqMhhT0XtiUVgZpGdDz2YbTKM226h33LoeVYzuoINNaWtQBuCmjvNif
 Hnr3rLn/o00zCLy33Bp+f1d3kJLELMj34fW5qn5N9bdVK1RABTRGUPtf2/+VaNSxpVAB
 dvUQ==
X-Gm-Message-State: AOJu0YzVI+/Y/NPsFObsCcLu3dzrPhp591tXA3oukO6RY0NCJbLOHp8y
 dSJiu6xS3EiZpWEhsijXTPJw7O3t74ZItMZJMAWPZByvAP1B6/3z609XIcfVnZxmw1q0FoNJ9fK
 vRFVLmZ4LhpxKe2a7HKbrCq/k65cWbApe4Rzd2ICvbBKAVztChRk8QY/4xa0/D6ipi/oNbHsISc
 6vi2d4QrFT92FTNsQe9Q==
X-Gm-Gg: AR+sD13U14bTrV/NNwZvRR3D1Xs+wYvmAYAbQA98A9P7UhhNjHvYOZyli8i7XY3E3m0
 w+4KZMxmZ6Mq/KbLT4/+Kbg0+nKtIjfullMpQ8m88JCc8E10pW8fPmmT4myXKI+sdgvGuEfUcou
 O9/Iqf79dm1Z3LuLfzGzGcsq6GcDNWW3C5SbxL+DSKAGknL3hIQeCcj2pCEPY3EEwt2Hfyqy4ET
 ZfJPtwkPdn23Kn6/8pAUnaOdFo+STrSQMXi/766p07H4ZDHgV9VzxDfEjNKNegFFyaWCaqqbF5r
 Jx22ZJVSnZStcm0lomdC1DpdL8XUQovj3/4e7t9yah2Nds4BoVLOoVCqgBcA//epKj+uhbbedVh
 U49gkLYcxWeQBQ8zDDSer7Pl3lv8padnuYW+SJ0wjVY+M/L7SJolH9W0bNcxfsHvzVIpihg==
X-Received: by 2002:a17:90b:4d8c:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-3903c544f17mr22402352a91.6.1786149906556; 
 Fri, 07 Aug 2026 17:45:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4d8c:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-3903c544f17mr22402319a91.6.1786149906142; 
 Fri, 07 Aug 2026 17:45:06 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925ff912c7sm4316935a91.17.2026.08.07.17.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 17:45:05 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v2 2/2] test: cmd: Add gzwrite chunk boundary regression test
Date: Sat,  8 Aug 2026 00:44:34 +0000
Message-ID: <20260808004437.4367-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808004437.4367-1-aristo.chen@canonical.com>
References: <20260808004437.4367-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 08 Aug 2026 02:22:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786149908;
 bh=LI0ZRbCYf8whN8xlh7ZeJ60sJOTGG2uhBZ1xMvoaJZw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qhWWIOeBofMip6Qc2iYvYY2VcKFCJqAm6EgvVvvECbXaPUXF8p3mMpDlxLt0HKih8
 YzfnPmsaKVtGtLqkbtzuD8T6MEonaT8xqZ9Sjn1Vs9yQNQ3iTI3E+z5v8hvqwqyAJA
 Ik9wSgDu6U2kfgYMnxjdOOBd15fjRKuB66Rdk6X+KWqoCsal87YDHgWkQP2sOGH7/N
 0cCCt/eZU4zseFtp/UJEQmB6m9oRWKN7B3x4tPxLsm9ZvTwOQG25SJPmaVMek5XwOu
 xskPo7CyD34A/XXNE6qgSKqxfbzdvRlebMtzsTW4xbHpPJWxVJ1WWW5e9cfjsOSxKQ
 kv0ddJ1kzf6s9Fyc79YqLo65ilDsDMePdPT/xPphXsDemd4oVe1s2GkLbvwXA8oIje
 ipuUeXimdOyS05BWe81D3/Jqk7p8dp84qsUc+ljKgnS0b0iPJzxbohYV0lrNCxywsM
 nyjPFEpA4F1jCC5/8cvNxGOTD35ucvz6q9BollNsT5g4rFEJKwJwS1NSWzSNXfZBkp
 Y/BhkQ4i2ErUT+Lw3xGrslNuBfOu8k2Ei9+iWAuUdQ6oFhy0GMKT+TRXDAZQfa8k1g
 NlJf0CW2z9hZgp6vfoAEIO29+CEaR+znObcm5Z72PSCWQ3t/YZiAoSga7bwkd+/TJs
 qn0EL1uBMYOc8nhOQZq3AYjk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=qhWWIOeB
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a deterministic regression test for the gzwrite() case where a
decompression input chunk is exhausted at exactly the same time as
the write buffer fills up. Build a gzip file by hand from two 1 KiB
stored deflate blocks and pick a chunk size that covers exactly the
first block header plus its payload, so that with a 1 KiB write
buffer the first input chunk runs out precisely when the write buffer
is full.

Unlike the existing random data test, which only hits this corner
case for rare byte patterns (about 1 percent of runs on sandbox64),
this test fails 20 out of 20 runs without the preceding gunzip fix:

  Error: inflate() returned -5

and passed 100 out of 100 runs with it.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
Changes in v2:
- Assert on env_set_ulong()/env_set() and move the test body into a
  helper so gzwrite_chunk is unset even when an assertion fails
- Name the stored block constants and derive buffer sizes from
  sizeof(raw) instead of repeating 2 * SZ_1K
- Use mmc_dev_desc->blksz instead of the literal 512

 test/cmd/unzip.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
index 623a2785884..e33b6c3fb3a 100644
--- a/test/cmd/unzip.c
+++ b/test/cmd/unzip.c
@@ -101,11 +101,10 @@ static int dm_test_cmd_zip_unzip(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_cmd_zip_unzip, UTF_CONSOLE);
 
-static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
+static int bind_mmc9(struct unit_test_state *uts)
 {
 	struct udevice *dev;
 	ofnode root, node;
-	int i, j, ret;
 
 	/* Enable the mmc9 node for this test */
 	root = oftree_root(oftree_default());
@@ -113,6 +112,15 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
 	ut_assert(ofnode_valid(node));
 	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
 
+	return 0;
+}
+
+static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
+{
+	int i, j, ret;
+
+	ut_assertok(bind_mmc9(uts));
+
 	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
 		ret = do_test_cmd_zip_unzip(uts, sizes[i], true);
 		if (ret)
@@ -132,3 +140,109 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
+
+/*
+ * Regression test for the case where a decompression input chunk is
+ * exhausted at exactly the same time as the write buffer fills up, in
+ * which case gzwrite() used to call inflate() again with no input,
+ * receive Z_BUF_ERROR back and treat it as a fatal error.
+ *
+ * Craft a gzip file by hand from two stored (uncompressed) deflate
+ * blocks of 1 KiB each, and pick a chunk size that covers exactly the
+ * 5 byte header plus payload of the first stored block, so that with a
+ * 1 KiB write buffer the first chunk runs out precisely when the write
+ * buffer is full.
+ */
+#define STORED_BLK_HDR_LEN	5	/* deflate stored block header size */
+#define STORED_BLK_LEN		SZ_1K	/* payload bytes per stored block */
+
+static int gzwrite_chunk_boundary(struct unit_test_state *uts)
+{
+	static const u8 gzip_hdr[10] = {
+		0x1f, 0x8b,		/* magic */
+		0x08,			/* deflate */
+		0x00,			/* no flags */
+		0x00, 0x00, 0x00, 0x00,	/* mtime */
+		0x00,			/* extra flags */
+		0x03,			/* OS: unix */
+	};
+	unsigned long loadaddr = env_get_ulong("loadaddr", 16, 0);
+	unsigned long decaddr = loadaddr + SZ_1M;
+	u8 raw[2 * STORED_BLK_LEN];
+	const size_t rawsize = sizeof(raw);
+	unsigned char *gzmap = map_sysmem(loadaddr, sizeof(gzip_hdr) +
+					  2 * (STORED_BLK_HDR_LEN +
+					       STORED_BLK_LEN) + 8);
+	unsigned char *decmap = map_sysmem(decaddr, rawsize);
+	struct blk_desc *mmc_dev_desc;
+	const u16 len = STORED_BLK_LEN;
+	const u16 nlen = ~STORED_BLK_LEN & 0xffff;
+	size_t gzlen, cnt;
+	u8 *p = gzmap;
+	u32 crc;
+	int i;
+
+	ut_assertok(bind_mmc9(uts));
+
+	for (i = 0; i < rawsize; i++)
+		raw[i] = (i * 251) & 0xff;
+	crc = crc32(0, raw, rawsize);
+
+	memcpy(p, gzip_hdr, sizeof(gzip_hdr));
+	p += sizeof(gzip_hdr);
+	for (i = 0; i < 2; i++) {
+		*p++ = (i == 1) ? 0x01 : 0x00;	/* BFINAL on last block */
+		*p++ = len & 0xff;		/* LEN */
+		*p++ = len >> 8;
+		*p++ = nlen & 0xff;		/* NLEN */
+		*p++ = nlen >> 8;
+		memcpy(p, raw + i * STORED_BLK_LEN, STORED_BLK_LEN);
+		p += STORED_BLK_LEN;
+	}
+	*p++ = crc & 0xff;			/* CRC32, little endian */
+	*p++ = (crc >> 8) & 0xff;
+	*p++ = (crc >> 16) & 0xff;
+	*p++ = (crc >> 24) & 0xff;
+	*p++ = rawsize & 0xff;			/* ISIZE, little endian */
+	*p++ = (rawsize >> 8) & 0xff;
+	*p++ = (rawsize >> 16) & 0xff;
+	*p++ = (rawsize >> 24) & 0xff;
+	gzlen = p - gzmap;
+
+	ut_assertok(run_commandf("gzwrite mmc 9 %lx %zx %x", loadaddr,
+				 gzlen, STORED_BLK_LEN));
+	ut_assert_skip_to_line("\t%zu bytes, crc 0x%08x", rawsize, crc);
+
+	ut_asserteq(9, blk_get_device_by_str("mmc", "9", &mmc_dev_desc));
+	cnt = rawsize / mmc_dev_desc->blksz;
+	ut_assertok(run_commandf("mmc dev 9"));
+	ut_assert_nextline("switch to partitions #0, OK");
+	ut_assert_nextline("mmc9 is current device");
+
+	ut_assertok(run_commandf("mmc read %lx 0 %zx", decaddr, cnt));
+	ut_assert_nextline("MMC read: dev # 9, block # 0, count %zu ... %zu blocks read: OK",
+			   cnt, cnt);
+
+	ut_asserteq_mem(raw, decmap, rawsize);
+
+	ut_assert_console_end();
+
+	unmap_sysmem(gzmap);
+	unmap_sysmem(decmap);
+
+	return 0;
+}
+
+static int dm_test_cmd_gzwrite_chunk_boundary(struct unit_test_state *uts)
+{
+	int ret;
+
+	/* Input chunk: exactly one stored block header plus its payload */
+	ut_assertok(env_set_ulong("gzwrite_chunk",
+				  STORED_BLK_HDR_LEN + STORED_BLK_LEN));
+	ret = gzwrite_chunk_boundary(uts);
+	ut_assertok(env_set("gzwrite_chunk", NULL));
+
+	return ret;
+}
+DM_TEST(dm_test_cmd_gzwrite_chunk_boundary, UTF_CONSOLE);
-- 
2.43.0

