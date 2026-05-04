Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2B1CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 21:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D8884858;
	Mon,  4 May 2026 23:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bo3tgqsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD99784860; Mon,  4 May 2026 23:25:42 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D87808484F
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 23:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-50d876329bbso38631971cf.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777929938; x=1778534738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F/oRancASU9MLde1H5jWJvRyH6ZHWMAfkPEGyf7SUvU=;
 b=Bo3tgqsu63tlqZB6FnfqEwYFnr07csTS1jNByoV3cvPO25SaYW61A34ov5bSHHCUCd
 osQRHxPMF/pDxgy5IL1+aSOQmUOBo2I69IJa6HPMlJyzAwLfR4gt7/nTWAB/Jj/CCCzD
 9iw27+pcUjSQny3pvuqY6X9sSDwLDhEshfkTVypl5bt1JqyjcVtCHcB76uEhwgCg6BJx
 5OpZF2yOXLOecaOl5WzjBHY/Xm9w1SDr3T6KJraT+1MPORFsynA6LwcdtV4xDoULOYzV
 SAJAr5GPkJrHJT5m2Wlout0Nq4cKaUBP7bUAxp+U+GdUL5PEmqsMrquVbC1ntGjLGvx3
 a9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777929938; x=1778534738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/oRancASU9MLde1H5jWJvRyH6ZHWMAfkPEGyf7SUvU=;
 b=hg//E3efq1nIXD8IFRmPYlcDKjin+Gms4Zxrjac5TLxf9W5WB2f6tMptKFK7pJMqMZ
 ld9buGC0TmbHLR0tQ50amJ5XpIKDjHaQOOj9OmkFOlQ+XmL8B8b9h2E97VY4dT0HfJUA
 rD1jSihixVrry0D4WZbe6h6D14r/T8tU9iiyZ0uUCqy9kup/09t5Dg/Ui+f/uGyonUsq
 vU4jS+O/UToujrO9U66CAQ8vkbo7lGHnuapBqALdHK/A5NG7ozlmuJevRO7LW1OKmUUx
 LY257SCknw9Z3LuYkwFVAS9YbgB05IAEP6WgzeRHfnfbZDbj95nlbL2OLxT7JmnBtCzt
 I94w==
X-Gm-Message-State: AOJu0YxtD1psC13BJaBGcJjJ70zNjtTTgRiyOANbuflkblEhm0ITKt9W
 ieu8zBrmAoWl2D6yl8WI48SL5cDyZoDA4A7EkustUbLv7UbhbeAye1OZgiUpFRQTmc4=
X-Gm-Gg: AeBDievuJSsWs7Ptc2kLp18AFOudsNQylEfW2pFSXbvRFeEHet/AkPumI9V8qp2uSKf
 +qAPmACrV38p0CS48IEVjElDLBG8hShqm7QiYoU02Czr8MpDUQuFpcRTh7S0wB2rN4FbIZa2KQJ
 v3k0t6w4HDBLS71+1bALkqegu/Zj+EQv4prguFjBS8/tmyxsUrtVKIEs71B77LdGpFP8Mi3dbjN
 rtAVWJEkFruJAEZPwKOAXrpoIrJDO6ZYcLynm7Cwm9Yv9SN7tKFcRt+zv1J4veclmIK+L8HYFE+
 YGj6p9NnHSBPvzIqYml+CxXLrtnOPosErXjIo7oD4Cc7QxIYJy4C48rtLmm1xhMerzEA54yQY8X
 0u12J8hUklrdQGppgOp3g1UFVqxZ75ujhExkRrNbgOBzZXeagY15RqNJQLWTyt/qv5hEF+Mcf3K
 YOmM2vLTJfm7FVTYmuXSsSF/fQYcfRyrJWK14IijaVY6LfsgyTOggZJJWmH2eqe6b03qt+YNUyG
 61t12U9ZU9e7lSxTDRSNw==
X-Received: by 2002:a05:622a:5c86:b0:50b:4b3c:7554 with SMTP id
 d75a77b69052e-5130698817cmr7085561cf.10.1777929938259; 
 Mon, 04 May 2026 14:25:38 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040ba8b0csm109586721cf.30.2026.05.04.14.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 14:25:37 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>
Subject: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming libfdt
 size
Date: Mon,  4 May 2026 17:25:23 -0400
Message-Id: <20260504212524.1665166-1-raymondmaoca@gmail.com>
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
- bloblist_resize(..., fdt_totalsize(...))

Add a small helper to validate the FDT header and confirm that the
advertised totalsize fits within the currently allocated bloblist
record. Use the sanitized size before calling fdt_open_into(), again
after overlays are applied before calling fdt_pack(), and once more
after packing before shrinking the bloblist record.

This keeps the existing flow unchanged while making the size consumers
operate on validated FDT metadata.

Fixes: b70cbbfbf94f ("fdtdec: apply DT overlays from bloblist")
Addresses-Coverity-ID: CID 645837: (TAINTED_SCALAR)
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
changes in v2:
- Rebased on master.

 lib/fdtdec.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 2d66860f6ed..601f418db6e 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1744,9 +1744,31 @@ static int fdtdec_apply_dto_blob(void **blob, __maybe_unused int size)
 	return fdt_overlay_apply_verbose((void *)gd->fdt_blob, *blob);
 }
 
+static int fdtdec_get_valid_fdt_size(const void *fdt, int alloc_size,
+				     int *fdt_sizep)
+{
+	int ret, fdt_size;
+
+	/*
+	 * Validate the header before libfdt trusts any header offsets/sizes.
+	 * Also make sure the advertised totalsize fits in the bloblist record.
+	 */
+	ret = fdt_check_header(fdt);
+	if (ret)
+		return ret;
+
+	fdt_size = fdt_totalsize(fdt);
+	if (fdt_size > alloc_size)
+		return -FDT_ERR_TRUNCATED;
+
+	*fdt_sizep = fdt_size;
+
+	return 0;
+}
+
 static int fdtdec_apply_bloblist_dtos(void)
 {
-	int ret;
+	int ret, live_fdt_size;
 	struct fdt_header *live_fdt;
 	int blob_size;
 	size_t padded_size, max_size;
@@ -1760,8 +1782,12 @@ static int fdtdec_apply_bloblist_dtos(void)
 	if (live_fdt != gd->fdt_blob)
 		return -ENOENT;
 
+	ret = fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_size);
+	if (ret)
+		return ret;
+
 	/* Calculate the allowed padded size */
-	padded_size = fdt_totalsize(live_fdt) + CONFIG_SYS_FDT_PAD;
+	padded_size = live_fdt_size + CONFIG_SYS_FDT_PAD;
 	max_size = bloblist_get_total_size() - bloblist_get_size() + blob_size;
 	if (padded_size > max_size)
 		padded_size = max_size;
@@ -1772,6 +1798,7 @@ static int fdtdec_apply_bloblist_dtos(void)
 		if (ret)
 			return ret;
 
+		blob_size = padded_size;
 		ret = fdt_open_into(live_fdt, live_fdt, padded_size);
 		if (ret)
 			return ret;
@@ -1781,12 +1808,20 @@ static int fdtdec_apply_bloblist_dtos(void)
 	if (ret)
 		return ret;
 
-	/* Shrink the blob to the actual FDT size */
+	ret = fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_size);
+	if (ret)
+		return ret;
+
 	ret = fdt_pack(live_fdt);
 	if (ret)
 		return ret;
 
-	return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_fdt));
+	ret = fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_size);
+	if (ret)
+		return ret;
+
+	/* Shrink the blob to the actual FDT size */
+	return bloblist_resize(BLOBLISTT_CONTROL_FDT, live_fdt_size);
 }
 
 int fdtdec_setup(void)
-- 
2.25.1

