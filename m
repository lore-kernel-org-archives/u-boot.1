Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF1CC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EAAA81159;
	Tue, 18 Aug 2026 13:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qwiy7KT7QJjM; Tue, 18 Aug 2026 13:50:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44F3C81148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061053;
	bh=nJqQz1GzEKlMdybzI8Cp4UA24IJeHbSU1l6N4GE2NT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F7ERBcJqxacWYGGXIvr06dxjjvcoHhMbx73IKYqRLI3TsgykXVXGWxtXwhAE1CPh0
	 QmB9lekltdKaMNkJeaB55SUEfy9MJLLXX3dhFLJckg6JPvk9VDzYRiu3QqT/F7AC8t
	 5aJlY0b+1y2bD9O5EjyF4Q1jO8KhlEnWvpLFoqm4VGdYNS7ZkOi89LaRafk17uqrtq
	 TeOfwgqE5tiTTMGlNEPOyY7G9IhXJslOWJCorajiXumGe63boYb+jbJzWpWQAa3sJS
	 GNzkHfgut6Be4/QKJYN7p7CVH6nxouXl1hHlDHrZ7TtXEy2yh65KLoaiS2DJh94fDL
	 i9uz0psTIIiuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44F3C81148;
	Tue, 18 Aug 2026 13:50:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D7F922EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA7FA608A1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8bJ7XV3fNp6 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:24:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C806F605DB
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C806F605DB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=sDUGgp5x
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C806F605DB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:01 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 440A53F8AE
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059440;
 bh=nJqQz1GzEKlMdybzI8Cp4UA24IJeHbSU1l6N4GE2NT8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sDUGgp5xrS8/IQYghi9hV8luhyDtSMTqK4bvsTrx8pwNdGY36+sWo6I/eSENFelqd
 LagZe5g8pyx4P1GWQwyjF7/tIpRyea1dpVSwv1zgA3DiW0gKC5ERg1zCM/KPx6/QtG
 rtqyMBNXcoXUFbSKZXM7+qDuw+mtaPqr9o57P1mjHGXJ3g5CxGSyvnhOtjzy+WPwsJ
 RUidKbKG5rEuyg1pnvAODVEz/EFkh0AF+/DfDgjtm9JMNKMigefYDpqk4FtUuqbn3J
 HzzgTMExxkut59vWRvsth+/OfcNi3WetmETv+M11/M9Uo5oAbt/yspxqNssdHu5ilB
 v5mNyvfMQvThSPHFwYpuqJuAwdiGVCoth8RaLV9fDsQLP5J28nFxGT/SMvFH2lKwia
 0rBCmlkmvJS5N2RvRnOoSl6PGCUyE7/2E88mu62kcHtkNzkOUk4zeY9lau6M8lprxJ
 Dfo+fakUvm44djVaLol5UpPo3MDUQjXvPRsT2DErAnUo6a01LqiRHEpYF8AJI7eHIY
 26Ab51diiYPEAi6TR65SK/5hsewpDh5gfVIHmEsU31L1H1IJAlhiMO+yGmine/qq7e
 1vf85FjrPRcjcOZ9ODRgJmDnX6yVMAZJnHJpm5mTcSlN4XjyyLFb7Cvsv/v3f/ZebT
 cJ2/LSV1Np9Q+99bzWC+ZjZw=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848d21bbb55so7358165b3a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059439; x=1787664239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nJqQz1GzEKlMdybzI8Cp4UA24IJeHbSU1l6N4GE2NT8=;
 b=lRqSIJUuJalab4x1oS8xIW22p/wpu2/noFIG/UUh4BEhgWaHW9BRolOxDgnKv0/8yF
 t2ejJx9zoMHyoREQB/pmochtKY2uXX5sO1kBHGxShYf0L35kJRff4ej5TaQzhDD7VtEb
 LLDTL4jIYNqNG3xsWLfg94LCN0wPDq0Cr4agC0B4ZBJzrUzat9Of+Z8zprpapCkUNdJN
 YniAi6hhunpJwtPfHVBlmXyggUwzLArJZMgLCEkyL55mmqzGGXGp5PHrHtm4QlDcDe6e
 QXQwp0oXz8hhFkjPkJVtkbDK2LI7PjnVsqZGCnkmNqYu507BlD5bx+6pHpcm2u47VNQ/
 piSA==
X-Gm-Message-State: AOJu0YzUgNBDiXkwBwjpm5RmcZhU0vii8PD/KI9HxNoZY2Lm0otvrCDd
 dJuSLeEIiwjUiibacNSIrcW6GrNu6ciqmUlG15ZoXkmUw2nHJeVbdnTc9f9qPPmNBahdCF2MTNt
 9GcszzCbEIx1761iWzygGPNmekMKgRXBcHfTpd+WFYI0uaBlbnLlgWNNoMPtIsas0T+f8kWqyh4
 IpONEOwJPZSyQEVrpA3Q==
X-Gm-Gg: AR+sD12HbWmV1U4zhp25txgE4lT1ooO2wtWC22oOEdfibh+HjpwN6yStTce07HeFCTC
 YxHeQ1l1zeFloiAGYFtVengCUhfTddv+ucK/g7xiYzzvBFl8Znb2iKR+BfOWnhoTLM7CX1O4vTp
 lYmFkInCVmYV0wt3m/Ai60ukkljby8/5MU3FnOHaW4fTMIE32ttrXdJUuaDuseGjqg0kCpB0D06
 Z/Jp8HTR+QQVRj0lWiPxW4NIUprpBOdwrs0uwMJ60KXEdFPKQzOPf5GRb9Yk/BGu1dwWY25i6OY
 WgU/7ogdbZOWqAYhUFl43H87SpjTXDn4OdEelydgmjvqt8QM0nQkeE3JJoltjkaTy2Cbg8Msru6
 JUQZ9doH26vnr37FyM6Q9II5sMiGzbm6ZZ1GS4nMB9YNpouI1
X-Received: by 2002:a05:6a00:ac8a:b0:848:3f07:c5a2 with SMTP id
 d2e1a72fcca58-851b8742117mr12143054b3a.4.1787059438683; 
 Tue, 18 Aug 2026 06:23:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac8a:b0:848:3f07:c5a2 with SMTP id
 d2e1a72fcca58-851b8742117mr12142967b3a.4.1787059438200; 
 Tue, 18 Aug 2026 06:23:58 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:23:57 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/8] bootm: size the noload lz4 decompression buffer from
 Content_Size
Date: Tue, 18 Aug 2026 13:23:19 +0000
Message-ID: <20260818132332.324173-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818132332.324173-1-aristo.chen@canonical.com>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260818132332.324173-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:50:44 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a small static helper bootm_lz4_uncompressed_size() that parses
the lz4 frame header and returns Content_Size when the FLG bit is
set, and wire it into bootm_load_os() alongside gzip and zstd.

The header parse mirrors ulz4fn()'s validation (magic, version==1,
reserved bits, independent-block flag) so the helper does not accept
a frame the decoder itself would reject. Only Content_Size is
extracted; the full validation still runs inside ulz4fn() during the
actual decompression call.

The lz4 command needs the --content-size option to set the FLG bit
that carries the size; frames produced without it fall back to the
existing 8x heuristic.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index e4284fe9844..c5bdc909053 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -658,6 +658,36 @@ static ulong bootm_gzip_uncompressed_size(const void *src, ulong len)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(LZ4)
+/*
+ * Return the lz4 frame's Content_Size, or 0 if the buffer is not an
+ * lz4 frame or the frame does not carry the size. The header parse
+ * mirrors ulz4fn()'s validation so we do not accept a stream the
+ * decoder itself would refuse.
+ */
+static ulong bootm_lz4_uncompressed_size(const void *src, ulong len)
+{
+	const u8 *b = src;
+	u8 flg, version, indep_blocks, has_content_size, bd;
+	u64 cs;
+
+	if (len < 4 + 2 || get_unaligned_le32(b) != LZ4F_MAGIC)
+		return 0;
+	flg = b[4];
+	bd = b[5];
+	version = (flg >> 6) & 3;
+	indep_blocks = (flg >> 5) & 1;
+	has_content_size = (flg >> 3) & 1;
+	if (version != 1 || !indep_blocks || (flg & 3) || (bd & 0x8f) ||
+	    !has_content_size)
+		return 0;
+	if (len < 4 + 2 + 8)
+		return 0;
+	cs = get_unaligned_le64(b + 6);
+	return cs > ULONG_MAX ? 0 : (ulong)cs;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(ZSTD)
 /*
  * Return the zstd frame's Frame_Content_Size, or 0 if the header does
@@ -722,6 +752,12 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 								image_len);
 			break;
 #endif
+#if CONFIG_IS_ENABLED(LZ4)
+		case IH_COMP_LZ4:
+			hdr_size = bootm_lz4_uncompressed_size(image_buf,
+							       image_len);
+			break;
+#endif
 #if CONFIG_IS_ENABLED(ZSTD)
 		case IH_COMP_ZSTD:
 			hdr_size = bootm_zstd_uncompressed_size(image_buf,
-- 
2.43.0

