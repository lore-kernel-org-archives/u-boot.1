Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65B606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DlGGbOvx;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=fxNXP+4o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 852BC4066D;
	Thu, 26 Nov 2026 05:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PX_j594EfG2J; Thu, 26 Nov 2026 05:59:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9285A40565
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795672776;
	b=NahnSMrD2QiWfgpf3wFe+e5cAdfb/+6WwGsPGBID/GigQDE2y4n1/mik7tVPMEhfNwvR
	 73kreioWCRmcd8vOwlUtnBvaTG1r3wYmP5kbVtr5n7waKdt+6Wg86yK8GQPQ79TJCXHMZ
	 jXMWvZEa7L0ROx035I0qroJXVoMURjmGdrcaiX4wcUuC+SEZMJ22VFdNoOkY3SeFJ7V50
	 sn3xf5a09ZZ1lGnWjlG3UG7vi6SnY4E2MZ2Lx+uQkBjRxHebuun42+NACttalEFsUZuZl
	 vXOB3E159zYQZJwJl88PUZ6LfSAHdMl7hxXCCt3+IW4QWwbgvV7pjTvmOlLjdKL5hbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795672776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kIty5qoft80mXJvdLObcDES78VA4CDGa56juoDzoWxo=;
	b=E7pL8RSZyKJUJ/VttBC73ZbRMw5KvFfAGIRQN5XlBS90vMlKleP9oeV9JOl4ED5U+37L
	 oI2KNuSjJxy5goEMb+ZikHbK3tqn0nKsiivuq8gIXRjYc9gwobmO8ea+lqiJiXCywXYpd
	 7ran2xZah+6BFBtlYFv5ZEFQQe4aG6i2hVM6mzlYmFP3lyl+x5Si3wpP7amLVyj7VX5rZ
	 AA8pjLFcARunEgp6udxw58kdjqsowhQwRaEjDiUoyrQ/cqPW/x1PpIrC3pl16pswfkshw
	 jHogAWU05CcPHylKgN28xscFsLFuWleYA8tOpJ8hxcah14gjeHN3YeyKcvrVzHvwe5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795672776;
	bh=kIty5qoft80mXJvdLObcDES78VA4CDGa56juoDzoWxo=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DlGGbOvxy90VCj5cYV7tPGhBdKXfnKr0yjtsvXDoKe6Jkw7ZUl84ePPabnww+f4YA
	 Q/Z4hmAIO/aeiyFfMP5U7hH2J+LeYJbNDlkJkl/C4I+Y5IocB/FItuu6KUnHLAhLFj
	 6z2eIyVEm2rcKfxMKPTXw34xhYeIA+Ich3uUOXz6MqsuOKlWx6ryrY6BD+aT06MX4d
	 d09nv1K3CIdatxkvhQErnfRzgYdbxBLM1uYmlInviUVgaurUomI1cCq9wIRE2ezKXx
	 Gj71wwwlFPilppg70nz+C616vvX9V6IAjgmhJuwWQ8WQUBota+DOZIVlZOYpqv+KyS
	 SE7ZUWVO8vnUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9285A40565;
	Thu, 26 Nov 2026 05:59:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AEEF371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 111CD6069A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7w7V9SESvZf for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 05:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F64660671
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=67.231.145.42
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.145.42;
 helo=mx0a-00082601.pphosted.com; envelope-from=prvs=97907298e0=cyan@meta.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256
 header.s=pps82601-s2048-2026-q3 header.b=fxNXP+4o
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F64660671
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:59:33 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ49HhH1709349; Wed, 25 Nov 2026 21:59:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=kIty5qoft
 80mXJvdLObcDES78VA4CDGa56juoDzoWxo=; b=fxNXP+4oOIr9n1mZYvquyONvT
 AKG6xLCmPzbwTgXbjhG4uyzi3vtdTTO9bu+r8SYduZjXeQS2kC0LNKpL0bfbyZia
 VjlptkTE46DQWNjsaiwBZshA7RF0Ziq6orVCe6BASFT50V6lG1evPoLsRWKIx97V
 Gc9eU6FODJoZX6kjMeyrh1dauY11xi3qXoRNPjY9WjCOB333Zw0wX+h8JrMnFICX
 iyjsnhA3xQfvYvYqAIDCODPaeX8oDDLiq/T9m3DV9iThyVhaI8xeBvNv7TwY4Izo
 5rNW0o3Gb1wW2rsUpesJ4YHBHQTO/Y3EFjzmiQniSq0K6W9fwCUZksbO07I3A==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j5k9fs3t4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 Nov 2026 21:59:32 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 26 Nov
 2026 05:59:31 +0000
From: Yann Collet <cyan@meta.com>
To: <u-boot@lists.u-boot-project.org>
CC: Yann Collet <cyan@meta.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] lib: lz4: Support linked blocks
Date: Wed, 25 Nov 2026 21:59:17 -0800
Message-ID: <20261126055917.1615670-1-cyan@meta.com>
X-Mailer: git-send-email 2.53.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I9nw19gg c=1 sm=1 tr=0 ts=6b07cac4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VabnemYjAAAA:8 a=2-_0HB8lIwZkmBGruWQA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: XYFl54l6xaI5TM7iem4trueYtNImDNfa
X-Proofpoint-ORIG-GUID: XYFl54l6xaI5TM7iem4trueYtNImDNfa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMiBTYWx0ZWRfX2B8c4cQJwA1b
 6QUGB7KcOWWUuX9Rml37af8VIF7fG8jqT1l6Tk9rBSydhY8ZRVOVvFeNOOAWRU54o16P8LWdiTc
 ZMuDJKFQy0UkZJH6bVCM7xtYFBOc2Xc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMiBTYWx0ZWRfXy6WGz5eoafeZ
 z7Z4zKzRN3bTluqLnDRWwztKTuBEnRk4fXBrgIxKKc3PMmp25zxNogHyTsmvyB9rMXuJO2RPwbI
 4QRiYQxrjilo25ObWscz6I2pTCOsqR/4TbenlvFY+qONQ812rojfPrvVwZktuPCYp7sXYCfbW7d
 rxUTKyiuw6ziIdlH9IpCSQ4c1iF0TcWQKVSENhxGiUhdoSCx0W4ViO5CKYzTFfqUI0UyrjxTyRS
 X2bkRC3S1/CZw0CsXEUQKjT9bmDL+lZA7bMLtFlORjerzJioWDj45cdU4WRkNOLJy5vT17BESsC
 P9ftJth+ykt9N8Xie7G/EYvV3o9ZlRDDKH1JEPV0Yf1uISlULGZn//jXoyadQ+7UvxpndG22jf1
 Xg/4facmrz06ujRzYq2Y39HqSu9EUhgJukOTureC2vDcR7NWZOBOf7Qbb8Bzuk6QN/7pt8xIHyF
 dLDlBojclXzps6lsq4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ulz4fn() rejects LZ4 frames with linked blocks, where a block can refer
to data of the previous blocks. Linked blocks are part of the LZ4 frame
format, and the default of the frame API of liblz4 (LZ4F_blockLinked),
so U-Boot rejects valid frames today. lz4 is also considering linked
blocks by default for its command line tool.

ulz4fn() decompresses the whole frame into one contiguous buffer, so the
previous blocks are already in place: let references reach back to the
start of the output, instead of the start of the block.

This applies to all frames: like the checksums, which ulz4fn() does not
verify, the independence of blocks is not checked. References still
cannot reach outside of the output buffer.

Add a test with a frame of linked blocks.

Signed-off-by: Yann Collet <cyan@meta.com>
---
 include/u-boot/lz4.h   |  2 +-
 lib/lz4_wrapper.c      |  9 ++++----
 test/lib/compression.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/include/u-boot/lz4.h b/include/u-boot/lz4.h
index 655adbfcd..73586120b 100644
--- a/include/u-boot/lz4.h
+++ b/include/u-boot/lz4.h
@@ -14,7 +14,7 @@
  * @dst: Destination for uncompressed data
  * @dstn: Returns length of uncompressed data
  * Return: 0 if OK, -EPROTONOSUPPORT if the magic number or version number are
- *	not recognised or independent blocks are used, -EINVAL if the reserved
+ *	not recognised, -EINVAL if the reserved
  *	fields are non-zero, or input is overrun, -EENOBUFS if the destination
  *	buffer is overrun, -EEPROTO if the compressed data causes an error in
  *	the decompression algorithm
diff --git a/lib/lz4_wrapper.c b/lib/lz4_wrapper.c
index b12045111..d9e0095c1 100644
--- a/lib/lz4_wrapper.c
+++ b/lib/lz4_wrapper.c
@@ -26,7 +26,7 @@ __rcode int ulz4fn(const void *src, size_t srcn, void *dst, size_t *dstn)
 
 	{ /* With in-place decompression the header may become invalid later. */
 		u32 magic;
-		u8 flags, version, independent_blocks, has_content_size;
+		u8 flags, version, has_content_size;
 		u8 block_desc;
 
 		if (srcn < sizeof(u32) + 3*sizeof(u8))
@@ -40,7 +40,6 @@ __rcode int ulz4fn(const void *src, size_t srcn, void *dst, size_t *dstn)
 		in += sizeof(u8);
 
 		version = (flags >> 6) & 0x3;
-		independent_blocks = (flags >> 5) & 0x1;
 		has_block_checksum = (flags >> 4) & 0x1;
 		has_content_size = (flags >> 3) & 0x1;
 
@@ -49,8 +48,6 @@ __rcode int ulz4fn(const void *src, size_t srcn, void *dst, size_t *dstn)
 			return -EPROTONOSUPPORT;	/* unknown format */
 		if ((flags & 0x03) || (block_desc & 0x8f))
 			return -EINVAL;	/* reserved bits must be zero */
-		if (!independent_blocks)
-			return -EPROTONOSUPPORT; /* we can't support this yet */
 
 		if (has_content_size) {
 			if (srcn < sizeof(u32) + 3*sizeof(u8) + sizeof(u64))
@@ -90,7 +87,9 @@ __rcode int ulz4fn(const void *src, size_t srcn, void *dst, size_t *dstn)
 			/* constant folding essential, do not touch params! */
 			ret = LZ4_decompress_generic(in, out, block_size,
 					end - out, endOnInputSize,
-					decode_full_block, noDict, out, NULL, 0);
+					decode_full_block, noDict,
+					/* linked blocks refer to previous blocks */
+					dst, NULL, 0);
 			if (ret < 0) {
 				ret = -EPROTO;	/* decompression error */
 				break;
diff --git a/test/lib/compression.c b/test/lib/compression.c
index 31b6e5b1e..8094a4826 100644
--- a/test/lib/compression.c
+++ b/test/lib/compression.c
@@ -121,6 +121,30 @@ static const char lz4_compressed[] =
 	"\x9d\x12\x8c\x9d";
 static const unsigned long lz4_compressed_size = sizeof(lz4_compressed) - 1;
 
+/* lz4 -BD -B128 /tmp/plain.txt /tmp/plain_linked.lz4 (linked blocks) */
+static const char lz4_linked_compressed[] =
+	"\x04\x22\x4d\x18\x44\x40\x5e\x36\x00\x00\x00\xff\x19\x49\x20\x61"
+	"\x6d\x20\x61\x20\x68\x69\x67\x68\x6c\x79\x20\x63\x6f\x6d\x70\x72"
+	"\x65\x73\x73\x61\x62\x6c\x65\x20\x62\x69\x74\x20\x6f\x66\x20\x74"
+	"\x65\x78\x74\x2e\x0a\x28\x00\x3d\x80\x54\x68\x65\x72\x65\x20\x61"
+	"\x72\x7e\x00\x00\x00\xf4\x4e\x65\x20\x6d\x61\x6e\x79\x20\x6c\x69"
+	"\x6b\x65\x20\x6d\x65\x2c\x20\x62\x75\x74\x20\x74\x68\x69\x73\x20"
+	"\x6f\x6e\x65\x20\x69\x73\x20\x6d\x69\x6e\x65\x2e\x0a\x49\x66\x20"
+	"\x49\x20\x77\x65\x72\x65\x20\x61\x6e\x79\x20\x73\x68\x6f\x72\x74"
+	"\x65\x72\x2c\x20\x74\x68\x65\x72\x65\x20\x77\x6f\x75\x6c\x64\x6e"
+	"\x27\x74\x20\x62\x65\x20\x6d\x75\x63\x68\x20\x73\x65\x6e\x73\x65"
+	"\x20\x69\x6e\x0a\xcf\x00\xf0\x0c\x69\x6e\x67\x20\x6d\x65\x20\x69"
+	"\x6e\x20\x74\x68\x65\x20\x66\x69\x72\x73\x74\x20\x70\x6c\x61\x63"
+	"\x65\x2e\x20\x55\x00\x00\x00\xf5\x2a\x41\x74\x20\x6c\x65\x61\x73"
+	"\x74\x20\x77\x69\x74\x68\x20\x6c\x7a\x6f\x2c\x20\x61\x6e\x79\x77"
+	"\x61\x79\x2c\x0a\x77\x68\x69\x63\x68\x20\x61\x70\x70\x65\x61\x72"
+	"\x73\x20\x74\x6f\x20\x62\x65\x68\x61\x76\x65\x20\x70\x6f\x6f\x72"
+	"\x6c\x79\x4e\x00\x62\x61\x63\x65\x20\x6f\x66\x95\x00\x01\x2d\x01"
+	"\xb0\x0a\x6d\x65\x73\x73\x61\x67\x65\x73\x2e\x0a\x00\x00\x00\x00"
+	"\x9d\x12\x8c\x9d";
+static const unsigned long lz4_linked_compressed_size =
+	sizeof(lz4_linked_compressed) - 1;
+
 /* zstd -19 -c /tmp/plain.txt > /tmp/plain.zst */
 static const char zstd_compressed[] =
 	"\x28\xb5\x2f\xfd\x64\x5e\x00\xbd\x05\x00\x02\x0e\x26\x1a\x70\x17"
@@ -296,6 +320,25 @@ static int compress_using_lz4(struct unit_test_state *uts,
 	return 0;
 }
 
+static int compress_using_lz4_linked(struct unit_test_state *uts,
+				     void *in, unsigned long in_size,
+				     void *out, unsigned long out_max,
+				     unsigned long *out_size)
+{
+	/* There is no lz4 compression in u-boot, so fake it. */
+	ut_asserteq(in_size,  strlen(plain));
+	ut_asserteq_mem(plain, in, in_size);
+
+	if (lz4_linked_compressed_size > out_max)
+		return -1;
+
+	memcpy(out, lz4_linked_compressed, lz4_linked_compressed_size);
+	if (out_size)
+		*out_size = lz4_linked_compressed_size;
+
+	return 0;
+}
+
 static int uncompress_using_lz4(struct unit_test_state *uts,
 				void *in, unsigned long in_size,
 				void *out, unsigned long out_max,
@@ -498,6 +541,13 @@ static int compression_test_lz4(struct unit_test_state *uts)
 }
 LIB_TEST(compression_test_lz4, 0);
 
+static int compression_test_lz4_linked(struct unit_test_state *uts)
+{
+	return run_test(uts, "lz4 linked blocks", compress_using_lz4_linked,
+			uncompress_using_lz4);
+}
+LIB_TEST(compression_test_lz4_linked, 0);
+
 static int compression_test_zstd(struct unit_test_state *uts)
 {
 	return run_test(uts, "zstd", compress_using_zstd,
-- 
2.53.1-Meta

