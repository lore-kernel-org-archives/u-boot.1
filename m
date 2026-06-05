Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CF2CD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EC588499D;
	Fri,  5 Jun 2026 19:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="k6ZDtfZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3579084957; Fri,  5 Jun 2026 17:43:27 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F32284946
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 17:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C14F3F97E
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780674204;
 bh=06E2vOv6LZpU6dhCvWbWvHV6ocUeDQGk7u6GeK+SdZs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=k6ZDtfZgLhAcGWMOMih+kZHc9nRItQuhBn2sOwNzEqflvtkfmglovIpxnVmzoikpx
 E7QIwP4xYPPcONUqZA+PTlCUkFtp/ezjZuUZ3ppZAvWPutXcH5mKMlQj8zi07+HyEs
 gJEeANr/PWdUEZjZm9skhjOEct+xKPvJNRUYvMrBl7K3Xx6L7UNqeUxc4YOsAirhn8
 ulNaAOqp9JTsLtCBnVSTwgdYrZ9HdZ7pe7aMs/6afTKZP48QxVnWl7N+/Ng4ePviMt
 dCj2UFb/6DdiY0Acz/Rcn6ywYkgxYmcLYb19BtEMvA9VnznJcBQuCIXvaJ4AL5ptcl
 6UZgUWdz1AwNQJ5/YNqoMuUC2bD3rhFU8FV8kXXYyQeDW7md6yMyv6lSMHaHtL2oIF
 M3Z6XHba5I+NRf9qrtNwcyq0aLQXbg4itQ/gIef4bBZdZJmBGDuzXXefuom0HzuBfV
 hGOoPIAr4cH0zbIFlHupQ1B+ZHQKOJdKPHlyMu2Ho+8LfxOubEXyxGuou9Wnsmbtxx
 eTmU/uW7UiYYeAfLRKhw6tm8icg1Mhsx/64efzyRbhwt0cDsk/CucfLVjVqi8eGgJs
 1B4wP3aPfulDGqzHHENEjOXf3cvkpXrVnV9oFJ4ouefTBFs0Kgt5Yh1BWQG+Yc+dmY
 8MSqhy6wIHYQH5Nf3aTiHNSk=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf08c2a24bso20731165ad.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674202; x=1781279002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=06E2vOv6LZpU6dhCvWbWvHV6ocUeDQGk7u6GeK+SdZs=;
 b=rFturXpfrSjy5D2azBDVYUVM8l5OXE1xFhTbzsyk3RP/bzchz98uGGSCdFllF5nizb
 JMmukU30dcsHQTB5ZyYHRTggMyt4z9+guGQUftXCoR9MtsE++WaWjk/tg+IDgKOIw6ME
 xxez+Emnv5Ysp4xF+fPQ51ryLlf/QskoCwoU+PZMtY0hwj48ucbgskdGQp2rU7QBWcy2
 Oue80iuTu5pgeVdL5xK/iZ6b50MteYOPJvtqXf78bzAUAKlia7Q71Sumxd5IxfvKcxO8
 Wfzbl57KQyOOkDiz+zle1YEu8+m8w0FgpB2ni3KGW4UPOUAyznm0tHkZsJpE6WyIF/U2
 r7hQ==
X-Gm-Message-State: AOJu0Yx0mJgks5JVws8nGULz2mRQ4xM8mdfhW5XcWCXR9GbHcVV9fSb5
 FKadNlklivdHOEC7jV5zoGnlpcoY5dhhJL4QHIYjEzC+6tsoVQ8bgJWaIwaXRYXqunqgDoJxsXS
 EvAdmjTjOBo/eSp7gvnMUZL4R68I+OUD5zjQgsYgAcskhl2jkxGAMgAZdvxGD0iQDsriT9P0v/k
 zuMj8=
X-Gm-Gg: Acq92OFX6DMcg44mZOBU/AZgEYQrN25KM1wPn/v3V4d8rUkbCqQSKNTFmmk6G3ENT08
 vwns+ijRVhZl7gsRy6Xf9ZsNy5cbH3/iqlf0VtARnO80ZYsb4mzZ41bIjOF0deurIUa3dlzIhA0
 ORWvZEH2YB7cu1fbemK2MkF7qyIXBEMc95iwkzK25bO2wtTriodjnEEC0knP2WTnqAkDSp+5VBd
 n7Pw+CQR/hcFeBP3ODRxB3/MkQwSk1yVbyfaHi+QtG/44Vw2oM/FnnnHq2lHb4sTIFVS3lEx/LQ
 LOlzuDneXNQz8wBfKbhlVay3sBeW+sfq1lho6krpwI+Cpre/OlvTm7zSs+Bw+uLaXUmBH/myBah
 9t1dbVZcJAeLFwx47Rfp9n7cvq64X82kAvwWGjsp4e6WF6o6A4AGp0r8/Fwmy84dkVLAD/F/sPU
 YXdJ0O
X-Received: by 2002:a17:90b:5281:b0:36d:689a:cb27 with SMTP id
 98e67ed59e1d1-370f1910a02mr4331596a91.24.1780674202592; 
 Fri, 05 Jun 2026 08:43:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5281:b0:36d:689a:cb27 with SMTP id
 98e67ed59e1d1-370f1910a02mr4331575a91.24.1780674202230; 
 Fri, 05 Jun 2026 08:43:22 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm7233531a91.9.2026.06.05.08.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:43:21 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH v3 2/3] bootm: increase kernel_noload decompression headroom
 from 4x to 8x
Date: Fri,  5 Jun 2026 15:42:50 +0000
Message-ID: <20260605154255.833334-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605154255.833334-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260605154255.833334-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Jun 2026 19:15:17 +0200
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

For a compressed kernel_noload image, bootm_load_os() allocates a buffer
of ALIGN(image_len * 4, SZ_1M). The 4x factor is at the edge of what
modern compressors (zstd, xz) achieve on real kernels, so a
well-compressed vendor kernel can fail to boot at runtime with no
intervening warning.

Bump the headroom to 8x. The buffer is still bounded by the compressed
image size, and the SZ_1M alignment keeps the overhead below 1 MiB on
small kernels.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index b55c41f30b7..4eee35d7e62 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -619,14 +619,14 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	/*
 	 * For a "noload" compressed kernel we need to allocate a buffer large
 	 * enough to decompress in to and use that as the load address now.
-	 * Assume that the kernel compression is at most a factor of 4 since
-	 * zstd almost achieves that.
+	 * Allow up to 8x compression: this comfortably covers what zstd and xz
+	 * achieve on real kernels, with headroom for well-compressed payloads.
 	 * Use an alignment of 2MB since this might help arm64
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
 		phys_addr_t addr;
 
-		decomp_len = ALIGN(image_len * 4, SZ_1M);
+		decomp_len = ALIGN(image_len * 8, SZ_1M);
 		err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
 				    decomp_len, LMB_NONE);
 		if (err)
-- 
2.43.0

