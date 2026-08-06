Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B84C5AC7C
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B577C80E7C;
	Thu,  6 Aug 2026 11:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e5emzF54-D5u; Thu,  6 Aug 2026 11:00:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D15D80E69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014055;
	bh=CqK5ClNAx5AgA8Z+fVnfVvBfeKWBaS1p9r5hrE9tnUU=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZvRMlN/OkBm2/IIN3eC1qBa2Q9xOj4iphi6X7eCSzftf3WS5J76N8hUhugFrD9lcO
	 R9biKgmU+CX/T9lYAPtmsbbCetHUHUVRs3QtIFfkIf4CcMGoJjXzZpRIPKoBioZEIT
	 ilfvapqvvsX9I+I8yWtC233uR+1US4AICI/tWUPhLgt/Z1x2z1mgGzltW3y1UYphpj
	 JBh0kl16tac1m/PDHXC4HFLggq6Wk+zYtCR+cFkVkabVLxGBaBJSqQ21QeuxVntSOi
	 C/pMFIzTlvI06bYFcsOmgyzkX/YwYuS5wL9YaO+FQwN2Vhm+NDzHBHemD98LrUKqOb
	 j/dzsfB5axl4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D15D80E69;
	Thu,  6 Aug 2026 11:00:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 604FB194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DF8980D5E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_NxiEAk1E1N for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 10:37:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 58EA080D5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58EA080D5B
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58EA080D5B
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:47 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7DD093F63E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:45 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d04908139bso37283915ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 03:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786012664; x=1786617464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CqK5ClNAx5AgA8Z+fVnfVvBfeKWBaS1p9r5hrE9tnUU=;
 b=U1JOAAP/FLqIJseyYT3EbWOXw7M0ysu5MyZG3QfHNN0X464XVZ7JXsfXA97/jY+Kqt
 bv7t3SI+bQC9S1Myskbm7PPlzOid5zGaFwCf6MnJxjjXRyMjfkg7Q8OCGc80O6M3ieaF
 Oqj+saynYVDsSOa/4MBuxAi/2XPBEcLHSrXZ7RDzLuMyvIA2RzQFTLUx8GqHmVGMjfMu
 QIFIXuXM1Wjb7sNgn8eZvUdT/iobLQEySa0k93Te0MxnXYTUoiatwhcabJcbw/albU/j
 yNcTMnMbQMSQlNiKsCWUDb5fL7jyibyrtyYRvPpPCG6BnRn7r9YwlC3bV1r2qcqFHqFP
 ayjQ==
X-Gm-Message-State: AOJu0YwilCiXV3EA9LcDKbS6EBa/wTcopbeTb15ljQSUzGgtAHtlh6z/
 CaiOyGFwq49GT91OUY6DVbqzTf1UxuBAinxd40E3Pf3qKmgAC8gqUmt5adBJ31O7NptOwhRUWZt
 3nG4GhpmGnH+o8K6d1mbfn+Aeu0MX9v9sti/3cmnRdCHgKo5yxrFxNnOxAZsaR3SMZpptJGFYlp
 3yyvao0Z7Tzzv6Z292mQ==
X-Gm-Gg: AR+sD10Z+v39pXGEl7y7mUPtZHNz/ZNFy42Ft6jXBjuWhmBeDYbqKbUY88ulCUCjR27
 jn8ytX7uP+IFRYne7Pa0tuJzcWUC7Z9ny6UKIQ7x0zUA7mNNnB9p54Kk7xOzm5pb13qdYBR7HmY
 e/NpLaJSY0dx4F/4nO6/QvgC9bfYNoy05AF5PbxyQeLX8ao1rzfBlzF1zASEZc2+YuTDCoxM3At
 aKKbKuJFt4m8bnBZliGwf7+F7/ZEGCITvbRu53GpG3saW/kfyEyENeNnlM+laHGXXxglBfwHwEF
 3xmCwEhRH0yuqaHNz5im+DJkfLhsjP09QymSqZMbnW2q5ETC6iM7MCd65k07MuwtyCRqbLQ1g2f
 s4m9Zzfk3y3ytIuMPBI0+Z5hvjvM0AwtylJAY/p+KZnMfFrHD
X-Received: by 2002:a17:902:e945:b0:2ca:d151:383a with SMTP id
 d9443c01a7336-2d0ca98f97dmr163031305ad.20.1786012663917; 
 Thu, 06 Aug 2026 03:37:43 -0700 (PDT)
X-Received: by 2002:a17:902:e945:b0:2ca:d151:383a with SMTP id
 d9443c01a7336-2d0ca98f97dmr163030275ad.20.1786012663012; 
 Thu, 06 Aug 2026 03:37:43 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9fd3949sm29640545ad.18.2026.08.06.03.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:37:42 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] test: cmd: Add gzwrite chunk boundary regression test
Date: Thu,  6 Aug 2026 10:37:00 +0000
Message-ID: <20260806103720.1026454-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806103720.1026454-1-aristo.chen@canonical.com>
References: <20260806103720.1026454-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786012665;
 bh=CqK5ClNAx5AgA8Z+fVnfVvBfeKWBaS1p9r5hrE9tnUU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=P+8AKl1O0xwojF4okF6LqeA5mzZYrrop9IFOy1ouRbP/h0oKe6Gp7O6byw4gFh2w6
 mp4nhDJayVKmzbcbTpIwWUMJ2IZ7MqwAVJLhnfKdwr7xll76n2IIckZrf/KEBeM6+G
 6dCGkxlfqpJBZzRwjSZk9dyqytua4JnAHOWmCZVMNEMAyt50FwcIxDJUrSiMw6BRbA
 Dgm1lA0/dlUjJo6brGk3N/55uhNg5qGaxVdwczkA6C/V3u9xeaINk65jvLB1p8E0Y0
 WLMBWqTp0Mu4Ya6562ZcrAubrOf18GUdH4qFV74djc/INUUt52ndeJo4VlDX2NU87/
 vA9ZkRQYNBuuH1oQjc4SqG9WoGadWTV/jhnivB/pfX/IKFMeq9SCwoF9GdGWFO7/Hq
 /fmb1xjnpzBge7XATPUum//IlDWX0WpRk3ts5jqjBqNXA/rYEVmb1twKZMdZEQ6wWe
 dcWt8XDuBRP4Zpdrj6+7jKGk9zdGhPzbCXNLQNYdiwhS/Tfs0odRToadcYA8U7tioO
 ssGHDf5mF2p/UZAHJRX0hJdMl4RVX8US21tSsDq+AIK8MkDLWhX74GNRmE8CEObTab
 6/lGlP1i+hDjZGY25nEJhA6MQ+spPvI0k9NM+GqWd6wu6SRGPxwI4wVtV5U5MoT9Gu
 OmXfeVpXLswbRtb5tdqm0CJc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=P+8AKl1O
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
 test/cmd/unzip.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
index 623a2785884..f0664d1a8f3 100644
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
@@ -132,3 +140,94 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
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
+static int dm_test_cmd_gzwrite_chunk_boundary(struct unit_test_state *uts)
+{
+	static const u8 gzip_hdr[10] = {
+		0x1f, 0x8b,		/* magic */
+		0x08,			/* deflate */
+		0x00,			/* no flags */
+		0x00, 0x00, 0x00, 0x00,	/* mtime */
+		0x00,			/* extra flags */
+		0x03,			/* OS: unix */
+	};
+	const size_t blk = SZ_1K;
+	const size_t rawsize = 2 * blk;
+	unsigned long loadaddr = env_get_ulong("loadaddr", 16, 0);
+	unsigned long decaddr = loadaddr + SZ_1M;
+	unsigned char *gzmap = map_sysmem(loadaddr, sizeof(gzip_hdr) +
+					  2 * (5 + blk) + 8);
+	unsigned char *decmap = map_sysmem(decaddr, rawsize);
+	struct blk_desc *mmc_dev_desc;
+	u8 raw[2 * SZ_1K];
+	size_t gzlen;
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
+		*p++ = blk & 0xff;		/* LEN */
+		*p++ = blk >> 8;
+		*p++ = ~blk & 0xff;		/* NLEN */
+		*p++ = (~blk >> 8) & 0xff;
+		memcpy(p, raw + i * blk, blk);
+		p += blk;
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
+	/* Input chunk: exactly one stored block header plus its payload */
+	env_set_ulong("gzwrite_chunk", 5 + blk);
+	ut_assertok(run_commandf("gzwrite mmc 9 %lx %zx %zx", loadaddr,
+				 gzlen, blk));
+	ut_assert_skip_to_line("\t%zu bytes, crc 0x%08x", rawsize, crc);
+	env_set("gzwrite_chunk", NULL);
+
+	ut_asserteq(9, blk_get_device_by_str("mmc", "9", &mmc_dev_desc));
+	ut_assertok(run_commandf("mmc dev 9"));
+	ut_assert_nextline("switch to partitions #0, OK");
+	ut_assert_nextline("mmc9 is current device");
+
+	ut_assertok(run_commandf("mmc read %lx 0 %zx", decaddr,
+				 rawsize / 512));
+	ut_assert_nextline("MMC read: dev # 9, block # 0, count %zu ... %zu blocks read: OK",
+			   rawsize / 512, rawsize / 512);
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
+DM_TEST(dm_test_cmd_gzwrite_chunk_boundary, UTF_CONSOLE);
-- 
2.43.0

