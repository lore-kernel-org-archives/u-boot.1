Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C869CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EF6A84886;
	Wed, 27 May 2026 18:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KTk+6yWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A83F84843; Wed, 27 May 2026 17:06:56 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7321D844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 17:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0AFB63F976
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779894414;
 bh=rNqcydxIamOI/N5mEhrWa3/TQcmYvEsXDKgOibqvM2U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KTk+6yWxGuKVzS4/aAmqCejIAbcSMB8SBoDOrL2Ry2jg16gGUDJDfxdp7Aiuq4zxE
 917RN0tLbypYNGTwp8WpmMNA8YTXWSPhk8WVmogZqFA+XtWnqqC1D8TZgcTKBkidUo
 5/Rb/NBzKGfgXAJXq+Tb4124uTXm6BBmk2BphDoiTH0NzmUJbBlG4CMWiP14hmu6NJ
 BwO/xXDwhyVE5V8Xk868/mv6iRiB3cikTQvAqWwrjoO0VSHupxZSg+QvpOiuM8nlF6
 RbDRGyqjnaQsbcC1ilp7iv2LVm4YVF3pL+zefNqn9At9uwpRtSJsU1IOlnsqgNP9F2
 t2HDhpg/I8FG89CZQy69n1ZrTuY3Nn8+y0rGUb42Zs7gnPbKVaE5fTLEqKqXvS6enD
 X6GWQaOjkxKMNTnrCnhOraYFU9aNzQb5D4WIZTKI5kQEyZ6ibyhBfNk9q9sUGoeHeX
 Xb/qSvVO0cEUfjFQwxgXoVLAmsHuxfo6rSeiyT7aK4wHdo2ThJlz3a/kiy4IwUA8bt
 SZ9wQedvzotnpP+6z84i48dEnxJH/1QtbggJD6hI90JHhwGC+ZMfjpBrS9Z8tifTub
 pM/SmWNmWUnZJPY+BO3ywi/nXqvUGcM+Ph/8H/m/N+7e4dE5pU7FMExTF2rwEwc12o
 C86diXRofHsjDF4eZdu/Z+6U=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3663d5e9bf4so12049891a91.1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 08:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779894412; x=1780499212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rNqcydxIamOI/N5mEhrWa3/TQcmYvEsXDKgOibqvM2U=;
 b=Aj2ejF3X1fdDqBPJmFHI60bKutiUyMIzI+SON7v/sTBVBPXUM0xLDrm+oUazMS7ek/
 b/AH2QjGvXRt3JLcP8sq4aRVmabt8kkf0hHZEU8SmXwHYtGRD1NfBBYKVuHT5+fTixuY
 z8wYP4VREQm9QhSw3M+ExRUvGo/7amh5x1thPLg+jsdKLlDRhQT7iHuvPJ8q5CPgyKlb
 kXlx9fRvh0IeiW7VYY50uYCCnqf9ASGQ9ko2Pj41VLtYdfZzpwgSTN3MlRxqTMkmQn3s
 FkUybx47tcWHhyc8EP4CBOn9anTUKL9LZAaQP60Tqxo0eeblezoueua/aTCHxaupA1OZ
 XUrw==
X-Gm-Message-State: AOJu0YxtgrN80K/om+BZgsCEusl0/jdvKOHATrJVhEB47yq9DJ8Wh+OW
 F0dy7/+qmS3jTmupdvNjdMqRK9MuBxvzaXI+RLmsoQXAj/FlRKNgugx7ikrHVx7iQ/MBMjBjBUq
 mUvBnSASKBypw8GhAkOkrT+AxgDmvWG85na9kL8xvFxmW7Ld5jGN/+XQreNsF3En2epszaCgyvs
 yWZXoEvA==
X-Gm-Gg: Acq92OH2FcZpnTpvSTUusa9FUuKXsgzyU49EdhFDkvQQceL5mJ8PAUQXj3s0LES45jH
 Vy8ZAjU8t46SX5fgxJn4Klli3YvLdk/6eSIsAgD3CPK+xu3yKUL+Iq2C5C9Gh7cXDq1d9ajxGmo
 qWcHKyk6T5Wv+Y2k4FNFvw1YEEqqmbubUReZi1PVJJgP5/3PvOIW+Ob/XaDEc1iNZbwwj8Pnuxz
 hQp42WgEAoeIkpnOitQaFp4FkMqOLRpK56j2+E3x0rIyR6OeMU7QmqrLZdrYJcjb2KiKVCoh09+
 JcI+Xo47jMvQc13BpfAnBSwCj9zEokPqOWLOSJFaGDpTGjG5eT8FW2q+d0YfVJgjoYAOrtBgdgf
 o24GJdeqsbciEQ1Ug68VyL70iIm0cpIEEQ70W1HJDHZ4aV9yShpy1uNTpakIqrG5BfAnpWjVR
X-Received: by 2002:a17:90b:37cc:b0:36a:aa9:eea0 with SMTP id
 98e67ed59e1d1-36a6749e856mr21960791a91.4.1779894412510; 
 Wed, 27 May 2026 08:06:52 -0700 (PDT)
X-Received: by 2002:a17:90b:37cc:b0:36a:aa9:eea0 with SMTP id
 98e67ed59e1d1-36a6749e856mr21960766a91.4.1779894412098; 
 Wed, 27 May 2026 08:06:52 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b73ce986dsm282702a91.6.2026.05.27.08.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:06:51 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH v2 1/3] bootm: fix overflow of the noload kernel decompression
 buffer
Date: Wed, 27 May 2026 15:04:33 +0000
Message-ID: <20260527150637.2850104-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527150637.2850104-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 18:27:25 +0200
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

For a compressed kernel_noload image, bootm_load_os() allocates a
decompression buffer sized to ALIGN(image_len * 4, SZ_1M), assuming the
kernel compresses by no more than a factor of four. It then passes
CONFIG_SYS_BOOTM_LEN, rather than the size of that buffer, to
image_decomp() as the output limit. The decompressors honour the limit
they are given, so a kernel that decompresses to more than four times
its compressed size is written past the end of the allocated buffer and
corrupts adjacent memory.

Pass the allocation size to image_decomp() and handle_decomp_error() so
decompression stops at the buffer boundary and fails cleanly when the
image is too large, instead of overflowing. The regular non-noload
paths are unchanged and continue to use CONFIG_SYS_BOOTM_LEN. When the
failure is triggered by the smaller per-image buffer, print a note so
that handle_decomp_error()'s generic advice to increase
CONFIG_SYS_BOOTM_LEN does not mislead the reader.

Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4836d6b2d41..f9b81bbf794 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -610,6 +610,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	ulong blob_end = os.end;
 	ulong image_start = os.image_start;
 	ulong image_len = os.image_len;
+	ulong decomp_len = CONFIG_SYS_BOOTM_LEN;
 	ulong flush_start = ALIGN_DOWN(load, ARCH_DMA_MINALIGN);
 	bool no_overlap;
 	void *load_buf, *image_buf;
@@ -623,11 +624,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	 * Use an alignment of 2MB since this might help arm64
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
-		ulong req_size = ALIGN(image_len * 4, SZ_1M);
 		phys_addr_t addr;
 
+		decomp_len = ALIGN(image_len * 4, SZ_1M);
 		err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
-				    req_size, LMB_NONE);
+				    decomp_len, LMB_NONE);
 		if (err)
 			return 1;
 
@@ -635,17 +636,20 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		images->os.load = (ulong)addr;
 		images->ep = (ulong)addr;
 		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
-		      req_size, load, image_len);
+		      decomp_len, load, image_len);
 	}
 
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
 			   load_buf, image_buf, image_len,
-			   CONFIG_SYS_BOOTM_LEN, &load_end);
+			   decomp_len, &load_end);
 	if (err) {
 		err = handle_decomp_error(os.comp, load_end - load,
-					  CONFIG_SYS_BOOTM_LEN, err);
+					  decomp_len, err);
+		if (decomp_len != CONFIG_SYS_BOOTM_LEN)
+			printf("Note: noload decompression buffer is %#lx bytes (not CONFIG_SYS_BOOTM_LEN)\n",
+			       decomp_len);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
 	}
-- 
2.43.0

