Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D3BCD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF948490D;
	Wed,  6 May 2026 16:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d4l5ndlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494E8849AE; Wed,  6 May 2026 16:55:43 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B48684903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-899a5db525cso42465656d6.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778079340; x=1778684140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eoacouk3iom2IEKgbzobFSH9GCGRowQLGxFmSSxHn3M=;
 b=d4l5ndlMuCGltcPuPnspOPGTUksR/GErHaEACNTafQMqcNCQ15wWYL/TYh7Ul7D0dS
 poEwnMJjy57U5W/xBRXO8CKFUx/oIEC0+DkrDCT4wU1IgbfzNouNcDxl/W5mszpfNJcF
 c6KjKadPhhvuWUefiBm2umMFnG4W9jsOr0tXHaVvnibLkMgHEOcEKWOlQ3E1fU/LcEVd
 5/CVJ2EUDvwWjYnS6y/9CdaqCYkxug5vCRHGLENm4AM8zgCGxmLAFMIMLselsH/NmDtc
 3hsfi+idZmAjMS+pBJJ6Ctl+xglZscwXsJUvTZwhmw5Qt5TMMZ2YZxbmuNTACQ9RjMMq
 kPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778079340; x=1778684140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoacouk3iom2IEKgbzobFSH9GCGRowQLGxFmSSxHn3M=;
 b=d/E9ZW9PgdqKyNBh3o/ttceZegBElsaZzBRx20A+M7IVBADnwHCPN68z3D408W3RxX
 N4kWeZXN6Plep9w/lmAWtFVnEQbRMy3SoJm0sm64EiJDcpideRLRejRIkpRysBFohwvU
 XMqHK155ZX3uFGe+OKp0iYDkgY1LaXIHpiNP+Gmq03F2L5rJQSQwYdf2JXNTyh4byxTM
 AScDqkOUJz5DZ6z28bEaRncJ9pcTzN6YIyzR5JEvGInDVo2YmxzqbCjs+krKOBfcIAKq
 TvUzK8gbJ3W4Sv67XXce2W1s0vLOnkRjU5Mqe85uUL9L2FdFbRIC4Bm0GJ1xFYp4jKuI
 1mfw==
X-Gm-Message-State: AOJu0Yz5flDYUFgsArqfgFezqmApSDtEUhsCJySgdHSpgwA4k4GBVewP
 mq8sk6NPipBb5ZkzRwBX/RDAHzwZ3080T+d435qoHFB2b2QXFoAMYcAOkCEoFNj3
X-Gm-Gg: AeBDieu5UBs2CIpmI9meQKkDMMtKg56Cg2k2yFjlAQSBTkCFeCBuga29FkxTVs/y7LY
 qiK7ZxD+5gVvFCUfZRg281oxMipE4SowePXMFx0BcnQIIGx0wRpyeoXKPkA/oxrsv9TCwiJxsu3
 Inkh+xE+dWkKg4zqZMDvVYmC1Ia8MN90tyQc9AFUQQAOpsFGHytTRofWucrK3m5Fq/a5uqxlPHW
 R0eSP8NqoU4RbbfcLbO1TBXOYcvImQL4L39DhbFYthY02TDyffGwDNtvvEyg7EB4tMStVUIb++J
 zyjS6a+vA5/9D61vguUh0Dp+5+6BrXf2qvxux5QSDYCuBDDyf43a2N9vJmeyP7AjceNTSNy8xzt
 2vayzvrRUydSpRPXoxnO9fFAsWj1qOUxga7IKk/EL1xkyl8g/KMBmpct3Jfr7o1CdamRs8Vcfvd
 0d07S1lwJGzvNNIMh3aDWgy8X/5yOYFq7peKtc2bVtEPAlafCLhbSq0VmldVim8se4wtkHKITKE
 grJkCl2+Xn56b0xpvpK6rjaEnsCr1a5
X-Received: by 2002:a05:6214:c42:b0:8a0:d08c:a721 with SMTP id
 6a1803df08f44-8bc68437fc0mr47744006d6.22.1778079339705; 
 Wed, 06 May 2026 07:55:39 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b534ac8ef3sm189314176d6.0.2026.05.06.07.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:55:39 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Michal Simek <michal.simek@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v3] lib: fdtdec: validate bloblist FDT before consuming libfdt
 size
Date: Wed,  6 May 2026 10:55:33 -0400
Message-Id: <20260506145535.1679611-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Raymond Mao <raymond.mao@riscstar.com>

Coverity Scan defects are observed in fdtdec_apply_bloblist_dtos(),
since the live FDT taken from the bloblist is passed to libfdt helpers
which consume header size/offset fields:
- fdt_open_into()
- fdt_pack()

Validate the bloblist FDT with fdt_check_full() before calling
fdt_open_into() and again after applying overlays before calling
fdt_pack(). This makes the libfdt consumers operate on a checked FDT
blob while keeping the existing flow unchanged.

Also normalize libfdt return codes from this path to errno values,
including the overlay callback path through bloblist_apply_blobs().

Fixes: b70cbbfbf94f ("fdtdec: apply DT overlays from bloblist")
Addresses-Coverity-ID: CID 645837: (TAINTED_SCALAR)
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
changes in v2:
- Rebased on master.
changes in v3:
- replace the local helper fdtdec_get_valid_fdt_size() with
  fdt_check_full().
- remove the check after fdt_pack().
- add helper to map FDT_ERR to errno, and normalize return codes of
  fdtdec_apply_dto_blob() and fdtdec_apply_bloblist_dtos().

 lib/fdtdec.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 2d66860f6ed..c67b6e8c133 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1729,19 +1729,38 @@ static int fdtdec_match_dto_compatible(const void *base, const void *dto)
 	return 0;
 }
 
+static inline int fdtdec_ret_to_errno(int ret)
+{
+	switch (ret) {
+	case -FDT_ERR_NOTFOUND:
+		return -ENOENT;
+	case -FDT_ERR_EXISTS:
+		return -EEXIST;
+	case -FDT_ERR_NOSPACE:
+	case -FDT_ERR_NOPHANDLES:
+		return -ENOSPC;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int fdtdec_apply_dto_blob(void **blob, __maybe_unused int size)
 {
 	int ret;
 
 	ret = fdt_check_header(*blob);
 	if (ret)
-		return ret;
+		return fdtdec_ret_to_errno(ret);
 
 	ret = fdtdec_match_dto_compatible(gd->fdt_blob, *blob);
 	if (ret)
 		return ret;
 
-	return fdt_overlay_apply_verbose((void *)gd->fdt_blob, *blob);
+	ret = fdt_overlay_apply_verbose((void *)gd->fdt_blob, *blob);
+	if (ret)
+		return fdtdec_ret_to_errno(ret);
+
+	return 0;
 }
 
 static int fdtdec_apply_bloblist_dtos(void)
@@ -1760,6 +1779,10 @@ static int fdtdec_apply_bloblist_dtos(void)
 	if (live_fdt != gd->fdt_blob)
 		return -ENOENT;
 
+	ret = fdt_check_full(live_fdt, blob_size);
+	if (ret)
+		return fdtdec_ret_to_errno(ret);
+
 	/* Calculate the allowed padded size */
 	padded_size = fdt_totalsize(live_fdt) + CONFIG_SYS_FDT_PAD;
 	max_size = bloblist_get_total_size() - bloblist_get_size() + blob_size;
@@ -1772,20 +1795,25 @@ static int fdtdec_apply_bloblist_dtos(void)
 		if (ret)
 			return ret;
 
+		blob_size = padded_size;
 		ret = fdt_open_into(live_fdt, live_fdt, padded_size);
 		if (ret)
-			return ret;
+			return fdtdec_ret_to_errno(ret);
 	}
 
 	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY, fdtdec_apply_dto_blob);
 	if (ret)
 		return ret;
 
-	/* Shrink the blob to the actual FDT size */
+	ret = fdt_check_full(live_fdt, blob_size);
+	if (ret)
+		return fdtdec_ret_to_errno(ret);
+
 	ret = fdt_pack(live_fdt);
 	if (ret)
-		return ret;
+		return fdtdec_ret_to_errno(ret);
 
+	/* Shrink the blob to the actual FDT size */
 	return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_fdt));
 }
 
-- 
2.25.1

