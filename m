Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA73C5AD68
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 05:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 207DF6070B;
	Sun,  9 Aug 2026 05:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24qsIV82sj3j; Sun,  9 Aug 2026 05:15:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17872606C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786252539;
	bh=S+cSX7Pl+L+o3oxqdY5VHkUddxkiAbmjlHOFqt3MqXY=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gI00ZMIYFWTBvYkIOY/pnnZfj7jFmFTYaR3PwU0KWAVQIX5YEBOJCqSYpwJIz72FE
	 a4OCJiEGxQAoJ+oUIinOuj9u6wZxapcJjx32x2E1AfIIO5t4/nxjOhrIIw/QQd1rFi
	 1BOM2nyDk3DXhxuhq/q8dL8Yk7hRd3qUrW10548KlkF7ZUByz3BMkULA5AlF9M/eu/
	 2zQ3TEKaE4fqw/HR9w9G+EqiCP9Jqj8h7mr1wXWhI/CVIJ2PaLWQZ/ie+HB8nmhLs2
	 TbnE57+SawyaaiOmbL8cnolIqyMu7cbdJ6CyOXocRFjj2oIAe26prWq0F+bAzp/kpm
	 IQYMoLHOF4NNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17872606C6;
	Sun,  9 Aug 2026 05:15:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2B54296
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C01CD60678
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vh5zXEGjHeI for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 04:27:30 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1321E605DB
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1321E605DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1321E605DB
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5EEB33FBBB
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:24:01 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso967218b3a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 21:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786249440; x=1786854240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+cSX7Pl+L+o3oxqdY5VHkUddxkiAbmjlHOFqt3MqXY=;
 b=NOxJ59lFvzNMfr1bEm/OfUu188VF6rf7FL4W7QNlfBlBOcs955IG12TUWUA+hrpkmf
 K/Atvj0Yt5hSZIM9tit5OiV/QCeFOXhIKgVcK9oVNvRgq6Ek1xvtKF7iLEblvbSIEg7b
 /21TRyTXnlgVwfTBx901Uk2Qx5648Fw6sxIXPr6DoS9MV+mLLWTxs8Lgt5XfovBvD19l
 V1nnWZZD1kwIjJ6fmbpzhKLKgdXiiN9yTCO0QJhnFr5Ky5+hlJ+970WlVBzTxPwYKI3y
 9/ra50l3ZRzl8eWnhk1k+ZlibYbZCfZgXzVqnx6d/njEYnjUWSwms6VJS0DN3HSZ2zj2
 RPFw==
X-Gm-Message-State: AOJu0YxnAUiLFASsGZXueYUlqth758addJlrHFknCUkinZs+cLpqhM64
 K0QRhMr19ogri8eE80A5B4nPkBq3YtIsAQLlLbROpCawfmrj9Eh3coKkevdhxiHz7O/V1LOwbk0
 b32/qoW7XLx1KoZebQFXLGsA56+wOFA7972C3L7hCxBliQQy8hAU1Sb/JgOpQvOhc+JBVvf5J2a
 U8pWqxgXzewWBBV2PQHA==
X-Gm-Gg: AR+sD13U0mGEp+2UHTIbFMByFqB4Lc101vm8lpgo1ovyXEufD/zRojp7/fUkvAdBBPi
 mtS9ADgkURMnyBl45x/wnGw95jlIm/IZ6Tgu0fDJ7RgX8SZJbfDIkffj8G5RXx1YRYZsg5Fjc8t
 7MDfONZCSXOQGxj1e2smixXz2GYRqDDwgsM5S9l+Zg8NssvXZhovgtCqkxGI3OWDCZgL5WXAtUP
 xQ6fsTM91z2/FX8Ht0WoRLjoBs6ZKsqgP/0X0u5o5B2pTCn9neolKS9nywFytavacWUswj2i5ds
 o0HzSBo/4BACTqTxni7O5UKCUQy44gM1jtOPSRQ2X3b25JXy5s6PHiJPznmaGAjF24qs09xtQz/
 Go6ZsJZIOKsu7m++c+tnLTRih2IKLLn96TZZxZhdfox52Nt8pqJpx1X5HlB+n0SNwXXNwFw==
X-Received: by 2002:a05:6a00:1388:b0:848:30c3:45dd with SMTP id
 d2e1a72fcca58-84f4fdbf18amr20570148b3a.11.1786249439765; 
 Sat, 08 Aug 2026 21:23:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:1388:b0:848:30c3:45dd with SMTP id
 d2e1a72fcca58-84f4fdbf18amr20570118b3a.11.1786249439255; 
 Sat, 08 Aug 2026 21:23:59 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f35bc75sm2314583a12.19.2026.08.08.21.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 21:23:57 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] test: lib: cover image_decomp_get_uncompressed_size() for
 lzma streams
Date: Sun,  9 Aug 2026 04:23:29 +0000
Message-ID: <20260809042338.63397-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809042338.63397-1-aristo.chen@canonical.com>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Aug 2026 05:15:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786249441;
 bh=S+cSX7Pl+L+o3oxqdY5VHkUddxkiAbmjlHOFqt3MqXY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qpX/SFqMue3oBnyRDfy4FYJy/WuL3YrBE6EwMVVaoEFyWEEfOdCzCFAypIkOw7ml1
 74ggccgrW4ZnAlft16xYt3tRRAyuo0M/DmYhC3FqNvuJg6CWceIhRmOfrSjUd6UaFl
 dl0UjcqpQ9uiOqlB0JJ9Z+DAQn38KU+pF7ajVXor6LAeu5KUJ6mfem+aFcr/z9U11m
 Lbj5rbiy8Bd6Og23fsT+rT/lEwsBzbVoICsOcoc6+qMi+WdwSPX+2PkEwLgQ5p91cg
 vZTHfp20D696Pg1OgDfkcWnCv09BsBb8O9xhFJUtuK0SuaWFeDiraSQLZkbJGdPI0R
 /Ly0YN/15/GJs3Mm/u9Xg6p8cZGmeDuYh0BP6GSq/5NKTm0FRof8DeBTmmAlWeynAY
 vVXIpMieF4+/XkBPTo8GgFBPHkxoQpPer+AGsM8uSQwegpdx513e4UMFev+tUh5Wcj
 5nw2gPGtRThueDZuONuroHXOc3d3Pw6dZ1ljQPqjT1pidK/PEACfn7f9ls02Pu1hxB
 2wpBpMwO73vCICYvMwx7lcqadxeWoUkcee++fUjsVfnqVSc4LREZciC4N70ik9BdCI
 oe5yUELvtoDe2FDHndcuPP8NBWN+tdox4kMZy3XOrxDUQvvfxrrtiE6CtPE/T5xPHB
 6x+Lk40FZyP6uEBrJdW+hIJ8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=pass
 smtp.mailfrom=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=qpX/SFqM
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

The gzip, lz4, and zstd branches of image_decomp_get_uncompressed_size()
are exercised end-to-end by test/py/tests/test_fit.py's
kernel_noload_decomp_*_hdr_sized cases. The lzma branch cannot be
reached that way: standard Ubuntu ships xz-utils' lzma shim (as does
Python's lzma.FORMAT_ALONE), and both always write the header's 8-byte
uncompressed-size field as the "unknown" marker 0xff..ff, so a
runtime-generated stream would only ever exercise the -EOPNOTSUPP
fallback path.

Add a hand-crafted lzma_with_size_compressed blob built with the
standalone lzma-alone tool (whose header carries the real size) and a
new unit test compression_test_image_decomp_lzma that asserts:

  - the existing lzma_compressed blob (unknown-size marker) returns
    -EOPNOTSUPP so bootm falls back to its 8x heuristic;
  - the new lzma_with_size_compressed blob returns strlen(plain) so
    bootm can pre-size the noload decompression buffer.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/lib/compression.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/test/lib/compression.c b/test/lib/compression.c
index 31b6e5b1eb4..930cd542294 100644
--- a/test/lib/compression.c
+++ b/test/lib/compression.c
@@ -74,6 +74,31 @@ static const char lzma_compressed[] =
 	"\xfd\xf5\x50\x8d\xca";
 static const unsigned long lzma_compressed_size = sizeof(lzma_compressed) - 1;
 
+/*
+ * lzma -kf plain.txt (standalone lzma-alone tool, not the xz-utils shim)
+ * The 8-byte uncompressed-size field at offset 5 holds strlen(plain) rather
+ * than the 0xff..ff "unknown" marker written by xz-utils and Python's
+ * lzma.FORMAT_ALONE. Used to exercise the size-parsing branch of
+ * image_decomp_get_uncompressed_size() for lzma streams.
+ */
+static const char lzma_with_size_compressed[] =
+	"\x5d\x00\x00\x80\x00\x5e\x01\x00\x00\x00\x00\x00\x00\x00\x24\x88"
+	"\x08\x26\xd8\x41\xff\x99\xc8\xcf\x66\x3d\x80\xac\xba\x17\xf1\xc8"
+	"\xb9\xdf\x49\x37\xb1\x68\xa0\x2a\xdd\x63\xd1\xa7\xa3\x66\xf8\x15"
+	"\xef\xa6\x67\x8a\x14\x18\x80\xcb\xc7\xb1\xcb\x84\x6a\xb2\x51\x16"
+	"\xa1\x45\xa0\xd6\x3e\x55\x44\x8a\x5c\xa0\x7c\xe5\xa8\xbd\x04\x57"
+	"\x8f\x24\xfd\xb9\x34\x50\x83\x2f\xf3\x46\x3e\xb9\xb0\x00\x1a\xf5"
+	"\xd3\x86\x7e\x8f\x77\xd1\x5d\x0e\x7c\xe1\xac\xde\xf8\x65\x1f\x4d"
+	"\xce\x7f\xa7\x3d\xaa\xcf\x26\xa7\x58\x69\x1e\x4c\xea\x68\x8a\xe5"
+	"\x89\xd1\xdc\x4d\xc7\xe0\x07\x42\xbf\x0c\x9d\x06\xd7\x51\xa2\x0b"
+	"\x7c\x83\x35\xe1\x85\xdf\xee\xfb\xa3\xee\x2f\x47\x5f\x8b\x70\x2b"
+	"\xe1\x37\xf3\x16\xf6\x27\x54\x8a\x33\x72\x49\xea\x53\x7d\x60\x0b"
+	"\x21\x90\x66\xe7\x9e\x56\x61\x5d\xd8\xdc\x59\xf0\xac\x2f\xd6\x49"
+	"\x6b\x85\x40\x08\x1f\xdf\x26\x25\x3b\x72\x44\xb0\xb8\x21\x2f\xb3"
+	"\xd7\x9b\x24\x30\x78\x26\x44\x07\xc3\x33\xd1\x4c\xe1\x05\x55\x6d";
+static const unsigned long lzma_with_size_compressed_size =
+	sizeof(lzma_with_size_compressed) - 1;
+
 /* lzop -c /tmp/plain.txt > /tmp/plain.lzo */
 static const char lzo_compressed[] =
 	"\x89\x4c\x5a\x4f\x00\x0d\x0a\x1a\x0a\x10\x30\x20\x60\x09\x40\x01"
@@ -606,3 +631,44 @@ static int compression_test_bootm_none(struct unit_test_state *uts)
 	return run_bootm_test(uts, IH_COMP_NONE, compress_using_none);
 }
 LIB_TEST(compression_test_bootm_none, 0);
+
+/*
+ * image_decomp_get_uncompressed_size() has a dedicated code path per
+ * format. gzip, lz4 with --content-size, and zstd are covered end-to-end
+ * by test/py/tests/test_fit.py's kernel_noload_decomp_*_hdr_sized cases.
+ * The lzma path is exercised here instead: standard Ubuntu ships xz-utils'
+ * lzma shim (as does Python's lzma.FORMAT_ALONE), and both always write
+ * the header size as "unknown" (0xff..ff), so a runtime-generated stream
+ * cannot reach the size-parsing branch. A hand-crafted static blob is the
+ * only portable way to cover it.
+ */
+static int compression_test_image_decomp_lzma(struct unit_test_state *uts)
+{
+	ulong sz;
+
+	/*
+	 * The existing lzma_compressed blob was made with the xz-utils
+	 * shim and carries the 0xff..ff "unknown" size marker. Bootm must
+	 * decline to size the buffer from that.
+	 */
+	ut_asserteq(-EOPNOTSUPP,
+		    image_decomp_get_uncompressed_size(IH_COMP_LZMA,
+						       lzma_compressed,
+						       lzma_compressed_size,
+						       &sz));
+
+	/*
+	 * The lzma_with_size_compressed blob was made with the standalone
+	 * lzma-alone tool and carries the real size in the header. Bootm
+	 * must return that size so the noload path can pre-size its buffer.
+	 */
+	sz = 0;
+	ut_assertok(image_decomp_get_uncompressed_size(IH_COMP_LZMA,
+						       lzma_with_size_compressed,
+						       lzma_with_size_compressed_size,
+						       &sz));
+	ut_asserteq(strlen(plain), sz);
+
+	return 0;
+}
+LIB_TEST(compression_test_image_decomp_lzma, 0);
-- 
2.43.0

