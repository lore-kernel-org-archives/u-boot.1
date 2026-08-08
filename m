Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5781C5AC82
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 02:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 168374081E;
	Sat,  8 Aug 2026 02:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3N64_yhLU3D; Sat,  8 Aug 2026 02:22:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A92D6407FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786155771;
	bh=yY9BGnvgumqv+fZAlKFt4FGcUPjywm7JmLtwmMh9L3M=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Sy26TDbqCJ5A/HhNYpWXu9MgbSLacvixwqqqVnaYvpIosN1Gr4yGfxwzg9ik94Ms7
	 lmyjBCV8C9BYjFRPW1weHdnfNhBWJR8+bXbreI4295yVcORe+N4c9hzJJJJv0VqEg6
	 dyhUKON97B0kjf9eq3njfaJcYtKIa3T3z8GCNeRrwUUli1dPM+E5gTK5/JjtSPQ8cr
	 f4HlZTlDafmLl98lFvmiaRsC57fdXa4AFT/HlwWeSHfXtdpQ05mqd4qmL5FqaPcYbB
	 AtA3+5Y8N/TDNMAZljBHMXbflRxw7c5KPsbBsS0aS+ftRJOp8r5NlVegNAWSuJdGf3
	 OxE3XcQuyZM0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A92D6407FB;
	Sat,  8 Aug 2026 02:22:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4DA32B6
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1A8D4011A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5TdCarFPMxpJ for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 00:45:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DF807400FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF807400FD
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF807400FD
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:06 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ACF753F9C5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:04 +0000 (UTC)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso162222a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 17:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786149903; x=1786754703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yY9BGnvgumqv+fZAlKFt4FGcUPjywm7JmLtwmMh9L3M=;
 b=VlZfFWTVScjfHezlqWJ+z1xjaDoDv4xQrWFQbVEW50BJxPI7gysMIyyPprzfJNo4kq
 YeWIkl/NE1DZWrcPBTy6PgiFq/mLL8XZIA4pUKdisPKv7RdJ4NJ/DwT3Gme5FSAdHiIr
 ZvfwYBw6uuFTG+zZzu4wzWiupaTXBPNUMINvIJnWj6qhHg2urJNCy1qz/hIRv6FueNjS
 JNczyDIwsx9QTzklYd0gRocAaNJMps7K6oC4qcbzow2YEkiTPcbx7x7cY8/r1qi9wApu
 Fqr+GK86uZShUKTyZyWU2846K/khY6eMQY9HQE7evJYTh/eimIoRrFphydHHPhDFYG1q
 04Tg==
X-Gm-Message-State: AOJu0YxOviRryAGcYt0BPNX+XNn0Ed/O/pxo1WLqzjLNbq57pAz/wUm4
 xOj+chcbru9AHR8ZE2kZEMxS3rBncykxvZcZzuF70MuR6ihXKfQiXtQCt8thRAR5Fj3gY5svLCM
 A7cy6BSVsR6tYcKPKiAYWOao7hPQerDWlg0w3Pq3ixu2mBv/BfSrDr9lmlD48XFuJUpPxrjBeQE
 gd3fK6kdAyj6q63slV3Q==
X-Gm-Gg: AR+sD11iHs5r4+KJ6MZLVIRG6/1pQ1R+l87SKoZCgCbK3sQxKoIduMhWJ4RTFDjcvGK
 GWgaGuF455n5vNnTQIj6WLovE6d+ZXmnCFvye9h00xsbj98LLunCsTTSDSrfQ+DE+djWI+hAmUR
 URePzE0xg7HO1SVo6uJlq8eU9esEXSO1miQRNZyRxpF7wbulEAr7Ku6YLP8FGFh7UX7Z2brQMym
 H/GZpVfXeWNBctEOWyqk3J1Z0hC8UR1apW+1OOPJRaLQQEMPZAzFNJCx4chRt2d83xL+5qL4gvn
 FYhvgDM6H1sOkyG55aTC5zt3k2lLrqDAuuE3oivZtPs3UxYdkUmpBLQ9YtCBm5G0Vap0yNQngX0
 aqkH5VaIxv2xrrPZjuNIeoNMPdmLEm57BaPTZq1Tc1x3iqBWSKJVgx2r6YynMt7DD5bV9Eg==
X-Received: by 2002:a17:90a:da83:b0:38e:500:3975 with SMTP id
 98e67ed59e1d1-3903c5d82a3mr25280025a91.18.1786149903145; 
 Fri, 07 Aug 2026 17:45:03 -0700 (PDT)
X-Received: by 2002:a17:90a:da83:b0:38e:500:3975 with SMTP id
 98e67ed59e1d1-3903c5d82a3mr25279995a91.18.1786149902720; 
 Fri, 07 Aug 2026 17:45:02 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925ff912c7sm4316935a91.17.2026.08.07.17.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 17:45:02 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite
 decompression
Date: Sat,  8 Aug 2026 00:44:33 +0000
Message-ID: <20260808004437.4367-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808004437.4367-1-aristo.chen@canonical.com>
References: <20260808004437.4367-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 08 Aug 2026 02:22:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786149904;
 bh=yY9BGnvgumqv+fZAlKFt4FGcUPjywm7JmLtwmMh9L3M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tIW7YqOd3yAYb3PM9aNzxVe/syDVdlO7HjYjW+uOfatMOi6xBUlsDsY7dv7ekuBfI
 zLpU/BkHxHjdGZwPu9ugdFshPG9XoAbkAcRbOYE5cFwc/YnHvsUFEsSfYaMO3vct5u
 NgA+mmNN7IvWvFCwD8uScsHv5ioXs9GjulQQmMwXO57CvxBh6ScHc0Y9yEg+9YE5iO
 UK8tkyMKKVnj5wSDHL/J4hA6+Qgu+rkocsmO1cdVp3PYJBYGAPa0EJz7yrOsgRZVsC
 I1hiYDEncaQVGFouMax9RkkoV9cm73D3aXAbGhtcX3JagmFZ6poXlv2YF5LVWJp4Tx
 dfWWIcM2/yiNKiUmIs4bTFixhxUUgYZRpQUyBVlvhhHUatvOO03t+VsSTDT9/s534F
 l9YSf3Z36T7cK9XvOobtTZQ92cux7bYqMgbY0yrelw3XztI6MlFgbktXtEvPB3J/iJ
 A+KsGCBDDRW7lDY9BOibkFnOM/3QgG0rxguHc8eLwZHLirxlCIIFbFctjnh707AFW0
 n5jINCyU8g12VvkMEOLzJg8y+jEgQXRFCqoFSSNNtCaOzzrUEVGhBH/iVRydrsVD86
 db8vGRh7GhSNHv4QQ5IeWhVCj3xJ8qniPoo24H8xgBp0YVeev9QJ47NKnXQXUF19Kr
 dNTMudZpA2Z/4APlwpKn2CEU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=tIW7YqOd
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

The chunked decompression loop in gzwrite() treats any inflate()
return value other than Z_OK and Z_STREAM_END as a fatal error. When
the current input chunk happens to be exhausted at exactly the same
time as the write buffer fills up, the inner loop calls inflate()
again with avail_in == 0. No forward progress is possible in that
state, so inflate() returns Z_BUF_ERROR and gzwrite() bails out:

  Error: inflate() returned -5

Per the zlib documentation, Z_BUF_ERROR is not fatal and only means
that no progress was possible; the call should be repeated once more
input is available. The reference implementation in zlib
examples/zpipe.c continues in this exact situation.

The failure is data dependent: it needs a stream position where the
consumed input and produced output line up with both the chunk and
the write buffer boundary at once, and the inflate side must have no
buffered output. That is most likely with incompressible input, where
deflate emits stored blocks and inflate holds no lookahead bits. This
is how dm_test_cmd_zip_gzwrite occasionally fails in sandbox64 CI on
random data with gzwrite_chunk = SZ_1M + 1, stopping at a multiple of
the 1 MiB write buffer:

  12582912/16777216
  Error: inflate() returned -5

Detect this case and let the outer loop refill the input chunk
instead of failing.

On sandbox64, the random data dm_test_cmd_zip_gzwrite test failed
17 out of 2000 runs (about 1 percent) without this fix, every time
with the same signature as the CI flake, and passed 2000 out of 2000
runs with it.

Fixes: 58e523fedf48 ("gunzip: Implement chunked decompression")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: no code changes, collected Reviewed-by

 lib/gunzip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/gunzip.c b/lib/gunzip.c
index 20cc14f9688..b30cbfc34ef 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -246,6 +246,16 @@ int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
 				s.next_out = writebuf;
 			}
 			r = inflate(&s, Z_SYNC_FLUSH);
+			if (r == Z_BUF_ERROR && !s.avail_in && payload_size) {
+				/*
+				 * The input chunk was exhausted at exactly
+				 * the same time as the write buffer filled
+				 * up, so no progress was possible. This is
+				 * not fatal, let the outer loop refill the
+				 * input chunk.
+				 */
+				break;
+			}
 			if ((r != Z_OK) &&
 			    (r != Z_STREAM_END)) {
 				printf("Error: inflate() returned %d\n", r);
-- 
2.43.0

