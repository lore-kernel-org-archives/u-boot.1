Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA636606A31F
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BE9RcGk8;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rkEre3ko
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4178181231;
	Sat, 28 Nov 2026 13:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMA4m1JbRsH9; Sat, 28 Nov 2026 13:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 31F4481158
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871782;
	b=oi6mmbeFt9Fivbw8Vs5cE1QE9tsqwEzJurK7LUnVrGMK96sTS2drFaBLuc+B6bNyWW9b
	 BWVPEvgHWrTDRK3qsUw7FR9L+qlufJGcSU3cAu9gC1eq/m8LZOimaSHz7s2UUHV6/Zyut
	 +E33MeXVB8cL4Ay4pXJIcCH/cJKqgphFbZlz0Z0dJqQtF+9NS877zbq4dd9djeBezS6G9
	 AUXfReTPGd2F8QhSXP28haVHKnuW4+gy93vyvSP4PxMLj9mN114Ak7PaXDnnFcycXjwL9
	 CKwWUF95chvwVRGN5MSVcEmoMD/NZOJU57M/nSvYJDc9wCvLgTpFEj9FWVvcm2MiulA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4tYFzAQZiNOHPYTHMvPV6/5nrx1Q3P/Sn7W36m8/RG0=;
	b=eOc+mjuVHsNo0Cpk1RudfPMq/gvkh0wi8+8FCVqiKyZRTQ7oQHusL96/DkTFvYxkuVFJ
	 /xV2tO3Rr869CmFcZZOM38+skv671APyF8cUAgbTtR7GyoFseSpeB7JrPeQFAGyO32UPZ
	 /Sxhd6o+++OvOgRW+8EUHifTajCFK7k7YQBb7YQPq0UotgAxLZms2utJEBfH0nfdohKOS
	 PzKSNHCYireqEBBcNeT6z5odFnostwNNVG83sAnXKXw8IBWSnW+BAZQX3v0QWaPGOPc36
	 GLNyBu8mCKeVZe4vBYSeD27NwOm67z0uoIV0VU04KQp6zS//zlbVpgq6slDxjbAo7lg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871782;
	bh=4tYFzAQZiNOHPYTHMvPV6/5nrx1Q3P/Sn7W36m8/RG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BE9RcGk8MH/XumHyza+DDUCHRh6Ai7LXQ0TPeO42x9Yitpn0seSjqdX3WtlQoDIVT
	 +IG3AvuCwp/ahHf5EHS9dc4ueGrKHYAx35upGsdQwpfZkliyP7nPG9Av6KggLKzG4P
	 xWkqvNOoz+E3UMdgstvv//skqj/oFymsU9aiTK3dycRq+zc1nF5fibdrtMP0J/XxJT
	 FRMkHgSrCD/ZvRgOFY8K4328ZWzetVlTnRIAeVtLCq0GQZQsiDr8g+du7lWxjhfdx0
	 R9D3AmXu4bo6SzXz870A6KAR7xmW6b51cW2CfVKsPgIMmZA8kIANwjaQ41uwBtR5AG
	 9QtD1bhBnQaRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F4481158;
	Sat, 28 Nov 2026 13:16:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 149CC2BD
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF2766065D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIYy_5lCQ1oh for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 07:48:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B17F605FA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=rkEre3ko
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B17F605FA
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:47 +0000 (UTC)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C74A33FEB0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795852125;
 bh=4tYFzAQZiNOHPYTHMvPV6/5nrx1Q3P/Sn7W36m8/RG0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rkEre3kof+0xQVhTye9k/3+6BN8n7/zgMcn9bvu72TP7qDCHSmQEh7XnRahbugfIb
 3oIKNKr8q+nydmOStUSiySBX/i7ZDwmngkuWq767HbW7R3Hj6YeOYSePX4LtjH1z6q
 Ktgg+8JIEwN4N6RepPI1Vyg2bj1ctmBCH4f4ehRSibQ2wkEFIFSp4FmgUc/lOcImkm
 /X+fKs7MsbXEdBTtUqx5dbFnX5RynFYXbELLb/r/lswsWW77Dc7oBnwr9ihRJy+ibk
 6vuJkV3l5dtEeEWS/1IqyPEDeKDBnKYqr7TlqoA2/VoaQMiCGxU7IDBNPgv/oGr5nK
 W4kHJ0tDf8lVt2hqsfwQ22Jvn3BDYM2ALWG9Nc+YzwsxFwmpORHr/ebByS8tb2gJa+
 uJv+8axVa1JnpsXW4X1LPktD++ikk1Cs6uFSfkoxTTHV6y4AiOMsD04nX1j0VCoBSt
 cLgMLINP3lG0LRbycJhYRs2y8h9utisDAyeRDD5OGINbumgbfOwqEHVP48JWh7EQRu
 5GPgsNg99M7O5C4HR69VSRNPL7m3SGDQn6K29IQPhlQNiGB0hzMQB3Aaowf+rYPrfc
 xhJZOBGDAdaAQds0RPHxw3gVnkHdfNibiUkFQQhskkfRgIWUglazQ929WQAQKV6arF
 3xEQVAN+x6L7wdqsWtYEb/ec=
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdb45b4ed6bso3110768a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795852124; x=1796456924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4tYFzAQZiNOHPYTHMvPV6/5nrx1Q3P/Sn7W36m8/RG0=;
 b=2JzVdk2tTEsTJsySXXIfTxUqYxHid90yWQggoUj6kTkdtOtntYU7E8x4dT7Iz4No30
 FRrEVPbuGdh1foxWpOdJbhwk5UDINeiUHBorgQHUsywriHpjJRtT0Na+H7vzJoVBaqMG
 eSKZNDqhgFM0/vZKQKZ88eCZpku0ijSIau66sICvQSv/nevKlEOJLnO32SDVOvj7AGjh
 kN9AE9nsojp+cZMOhAe3rn1k2+tG8/STHzstQJUrjdv5+dE2JAA3IIFzeA1LQQi8lhNU
 DDjP7BlGfKDamjDJ4lwLT0CaFsfd0cUfHhC14iSRgHDP4x0pj7md5So1cgxSk3aMHQtS
 xUcQ==
X-Gm-Message-State: APuU4Z8ZdksMOMQNLpuB1zGecMwD9Zso5lqoFx0EuNkdzHjSkO3QO4hc
 XOvfOyWYQwKjWdKLJp2/n+zEpiukhBXNL3DjnLxikdw/NDMEZgUdrkbPjFroPUtPBhjJ1snwNxw
 m7JVoeARsOht5Vw+vkECvuSHFtkPUIdcqOd6leEktCJ8Z1XLCXT84t72Ndv2r6/tNl7YQHRG8z9
 eKLdvz4e07axC/JwDDMA==
X-Gm-Gg: AZFdTZdVpmG/pjm4OT0hWkX3RfInM1ZzcJ+fZsXdLH5G7BlECa8KgwNlh52+cPyI9KK
 1GUQyoDWwdx5e/XzCHyb77ZMOmwyHBKvJT3CxXd15rCPIxaoCso6mz+rl2OJohUHruQryQkmavY
 awXj+xtLVIKlNNeP5lBJnmARk04t8ZwtQ1Gd5Pxeqy1AIWcizDdwlyMo2bUa5H09dgWPWT8Yof3
 J4T0KGgNPRNwSFOTGnJY4uYR662b9bKxYR5IkZKOo06+wYSPRnrn0HLTMVFGlkpK0JCHrsVr708
 OizPLjUQS7sKCbe+QaVo0CLA0/ZEyVlRpfoEqGrzOAfQxgQGaipJwSvNn2pnSMIYJUTY1bTMvdP
 SmYF10Mh757YmR5E0VoM4EZD+vLgvqyU3aXO8mypgRKSJOMf34NxOoBgjg7KXz5qk4RfKaUwk4t
 oqHmzAPq74+ruXWzaCPSOPqOty
X-Received: by 2002:a05:6a21:6450:b0:3f0:9b9f:f29a with SMTP id
 adf61e73a8af0-4014a17d314mr24905332637.2.1795852124167; 
 Fri, 27 Nov 2026 23:48:44 -0800 (PST)
X-Received: by 2002:a05:6a21:6450:b0:3f0:9b9f:f29a with SMTP id
 adf61e73a8af0-4014a17d314mr24905323637.2.1795852123695; 
 Fri, 27 Nov 2026 23:48:43 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4af1fsm14086238b3a.28.2026.11.27.23.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 23:48:43 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 3/4] cmd: pstore: decompress the dump records
Date: Sat, 28 Nov 2026 07:47:39 +0000
Message-ID: <20261128074801.11306-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128074801.11306-1-aristo.chen@canonical.com>
References: <20261128074801.11306-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Nov 2026 13:16:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux compresses the dump records by default. For such a record, pstore
display only prints "Compressed buffer, display not available", so it
shows none of the panic and oops messages of a kernel that has its
default configuration. pstore save writes the record compressed, to a
file whose name ends with .enc.z, as Linux does with a record that it
cannot decompress.

Linux 6.6 and later compress these records with deflate, without a zlib
or gzip header, and do not decompress a record into more than 3 times
what its zone can hold. Linux 4.17 to 6.5 use the same format by
default. zunzip() reads this format, so use it to decompress a record
into a buffer of 3 times the zone size. Display the result, or save it
under the name that Linux gives to a record that it has decompressed,
without .enc.z.

Nothing changes when CONFIG_GZIP is disabled. Otherwise, a record that
cannot be decompressed is handled as before, after an error message from
zunzip() or about the memory for the buffer. That is the case of the
records that Linux 4.16 and older compress with zlib, which adds a
header, and of the records of the other algorithms that Linux 6.5 and
older can be set to use. Nothing in a record tells which algorithm it
was compressed with: as in Linux 6.6 and later, a record that inflates
without error is taken for a deflate one.

The buffer is large enough for the deflate records of Linux 4.20 and
later, and of the 4.19 stable kernels that got the same change: their
text is at most 100/45 of what a zone can hold. Linux 4.17 and 4.18,
and 4.19 without that change, size their own buffer from the record
size, or from 1024 bytes if that is more and there is a console zone,
so the text of a record in a smaller dump zone can be up to 1828 bytes.
Such a record is kept compressed as well when its text does not fit.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/pstore.c             | 80 ++++++++++++++++++++++++++++++++++++----
 doc/usage/cmd/pstore.rst | 11 ++++++
 2 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 7468e8824e2..ee2bf66365c 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -8,6 +8,7 @@
 #include <div64.h>
 #include <fdtdec.h>
 #include <fs.h>
+#include <gzip.h>
 #include <log.h>
 #include <mapmem.h>
 #include <memalign.h>
@@ -151,6 +152,48 @@ static u32 pstore_get_buffer(u32 sig, phys_addr_t buffer, u32 size, char *dest)
 	return dest_size;
 }
 
+/**
+ * pstore_unzip() - Decompress the data of a dump record
+ * @src: Compressed data, which follows the header of the record
+ * @size: Length of @src, returns the length of the decompressed data
+ * @zone_size: Size of the dump zones
+ *
+ * Linux 4.17 and later compress the dump records with deflate by default,
+ * without a zlib or gzip header. Since Linux 4.20, the text of such a record
+ * is not larger than 3 times what a zone can hold, so use a buffer of 3 times
+ * the zone size.
+ *
+ * Return: decompressed data, to free() after use, or NULL if @src cannot be
+ * decompressed
+ */
+static char *pstore_unzip(char *src, u32 *size, u32 zone_size)
+{
+	u64 dst_size = (u64)zone_size * 3;
+	unsigned long len = *size;
+	char *dst = NULL;
+
+	if (!IS_ENABLED(CONFIG_GZIP))
+		return NULL;
+
+	/* zunzip() takes the size of its buffer as an int */
+	if (dst_size <= INT_MAX)
+		dst = malloc_cache_aligned(dst_size);
+	if (!dst) {
+		printf("Cannot allocate %llu bytes to decompress a record\n",
+		       dst_size);
+		return NULL;
+	}
+
+	/* On success, len is the length of the data in dst */
+	if (zunzip(dst, dst_size, (unsigned char *)src, &len, 1, 0)) {
+		free(dst);
+		return NULL;
+	}
+	*size = len;
+
+	return dst;
+}
+
 /**
  * pstore_round_size() - Round a zone size down to a power of two
  * @size: Zone size, can be 0
@@ -338,7 +381,7 @@ static int pstore_display(struct cmd_tbl *cmdtp, int flag,  int argc,
 	int type = PSTORE_TYPE_ALL;
 	struct pstore_zones zones;
 	phys_addr_t ptr;
-	char *buffer;
+	char *buffer, *data, *unzipped;
 	u32 size;
 	int header_len = 0;
 	bool compressed;
@@ -399,13 +442,21 @@ static int pstore_display(struct cmd_tbl *cmdtp, int flag,  int argc,
 				continue;
 			}
 
+			data = buffer + header_len;
+			size -= header_len;
+			unzipped = NULL;
 			if (compressed) {
-				printf("Compressed buffer, display not available\n");
-				continue;
+				unzipped = pstore_unzip(data, &size,
+							zones.dump.size);
+				if (!unzipped) {
+					printf("Compressed buffer, display not available\n");
+					continue;
+				}
+				data = unzipped;
 			}
 
-			pstore_print_buffer("Dump", buffer + header_len,
-					    size - header_len);
+			pstore_print_buffer("Dump", data, size);
+			free(unzipped);
 		}
 	}
 
@@ -459,7 +510,7 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 {
 	struct pstore_zones zones;
 	phys_addr_t ptr, ptr_end;
-	char *buffer;
+	char *buffer, *data, *unzipped;
 	char *save_argv[6];
 	char addr[19], length[19];
 	char path[256];
@@ -508,11 +559,24 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 			continue;
 		}
 
-		sprintf(addr, "0x%08lx", (ulong)map_to_sysmem(buffer + header_len));
-		sprintf(length, "0x%X", size - header_len);
+		data = buffer + header_len;
+		size -= header_len;
+		unzipped = NULL;
+		if (compressed) {
+			/* As in Linux, save it compressed if this fails */
+			unzipped = pstore_unzip(data, &size, zones.dump.size);
+			if (unzipped) {
+				data = unzipped;
+				compressed = false;
+			}
+		}
+
+		sprintf(addr, "0x%08lx", (ulong)map_to_sysmem(data));
+		sprintf(length, "0x%X", size);
 		snprintf(path, sizeof(path), "%s/dmesg-ramoops-%u%s", argv[3],
 			 index, compressed ? ".enc.z" : "");
 		do_save(cmdtp, flag, 6, save_argv, FS_TYPE_ANY);
+		free(unzipped);
 	}
 
 	sprintf(addr, "0x%08lx", (ulong)map_to_sysmem(buffer));
diff --git a/doc/usage/cmd/pstore.rst b/doc/usage/cmd/pstore.rst
index b8e2a478421..f8be7ef9fc5 100644
--- a/doc/usage/cmd/pstore.rst
+++ b/doc/usage/cmd/pstore.rst
@@ -94,3 +94,14 @@ Or saved to an existing directory in an Ext2 or Ext4 partition, e.g. on root
 directory of 1st partition of the 2nd MMC::
 
     => pstore save mmc 1:1 /
+
+Linux compresses the dump records by default (Linux config option
+PSTORE_COMPRESS). With CONFIG_GZIP, U-Boot decompresses the records that Linux
+4.17 and later compress with deflate, which is the default algorithm up to
+Linux 6.5 and the only one since Linux 6.6. It does not decompress a record
+into more than 3 times the size of a dump zone, which is enough for these
+records since Linux 4.20.
+
+When U-Boot cannot decompress a record, 'pstore display' does not show it and
+'pstore save' saves it compressed, in a file whose name ends with ``.enc.z`` as
+in /sys/fs/pstore under Linux.
-- 
2.43.0

