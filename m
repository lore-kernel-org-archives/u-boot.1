Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8F5EEAA54
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A707686852;
	Thu, 14 Sep 2023 18:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oy3qwGyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD34B86918; Thu, 14 Sep 2023 18:05:29 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8681A86537
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fbd5cd0ceso921063b3a.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694707525; x=1695312325; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PO2mjXJJQnKf/KQ0C8y8LPTWI7SvlM4gqub/vgPkvSE=;
 b=oy3qwGyTOxJPzUqnF7XvPTgUP/if0f5rNmPLqBUY4khK0vxE9bhaJDSSES2eEQV76B
 bQCMj6dulnDLRWiCJyBG0JUxSHWdPshKbU+Qxjd1bLmVDsspPqgNldp4XcioRPMq1ZqL
 ak3SaZiVVAS2pmVwpYjvDEn2GHLbBB/n64Lo0RXhXBUoZq+2P7fv/VduL2jGVSP1pWKl
 m62gnZHP3DRIt11c7U0HId1nYNdPC/atm077tk/ENDxhxxWfx+76418tiSf80jolsFQp
 04i7GIXVtfaQGyBmVj4ZwXF/t5Yvb7SjuaX86qu+FsA79PeRoD+a4b54cppw3/S6ACzN
 pSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694707525; x=1695312325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PO2mjXJJQnKf/KQ0C8y8LPTWI7SvlM4gqub/vgPkvSE=;
 b=f8TVZ8x0Az1OETYjS1nmrSVUhcp3eXLdp9TXNwfO4NKQJoLYdqAyiOlI61gfa/4YE8
 wznYrMuOPzc7Q10C2bWhdhXi1oHWtON5JrYQsmk+0k58omvM7QKAjhu9T+7dKsUsOTBw
 apWLgg2PpMdY+2aaEVRFuVHZbfoOID98+OoQfjgYoy/wuzKXrvRCTnDGiIx6Cgynh+3I
 T/5L+94gJtjGYrOh7Jz3nfLPWiOb+jlLY3y6tg5attyF0Ruj33NL4WS8JK7pIy9NEz27
 9QJ2879hhpVLKrS3MuONolHhvLx/At8d8eKEqDCsBhyN6SbxGqx56OC1NRdSHKLsARMw
 PLJw==
X-Gm-Message-State: AOJu0YwkxGkH+Dom8AslPo3OLiBWD6R9m2I/EyoA9ZEYxG91wDyaL1S9
 fLQlMbM+iAmxSHtO4dPheKrVQ6Nka8zK6KFS13kK1Q==
X-Google-Smtp-Source: AGHT+IGKWNGxqV6NXx0KCms+HuAxC3QIimNDRre5YX1UI/WXtqegq4oUORZUsU5gYBa8IXCo+WExxQ==
X-Received: by 2002:a05:6300:808c:b0:14c:def1:e728 with SMTP id
 ap12-20020a056300808c00b0014cdef1e728mr5056150pzc.60.1694707525260; 
 Thu, 14 Sep 2023 09:05:25 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 x47-20020a056a000bef00b0068a538cc7adsm1518998pfu.52.2023.09.14.09.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:05:24 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v1] fs: Fix SPL build if FS_LOADER is enabled
Date: Thu, 14 Sep 2023 21:35:15 +0530
Message-Id: <20230914160515.1121668-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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

If FS_LOADER is enabled for the SPL then the build fails with the error:

fs/fs.o:(.data.rel.fstypes+0x128):
undefined reference to `smh_fs_set_blk_dev'
fs/fs.o:(.data.rel.fstypes+0x140):
undefined reference to `smh_fs_size'
fs/fs.o:(.data.rel.fstypes+0x148):
undefined reference to `smh_fs_read'
fs/fs.o:(.data.rel.fstypes+0x150):
undefined reference to `smh_fs_write'

Fix the error by populating the semihosting entry in the fs_types array
only for non-SPL builds.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 fs/fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs.c b/fs/fs.c
index 2b815b1db0..074db4b20f 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -256,6 +256,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 	},
 #endif
+#ifndef CONFIG_SPL_BUILD
 #ifdef CONFIG_SEMIHOSTING
 	{
 		.fstype = FS_TYPE_SEMIHOSTING,
@@ -275,6 +276,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 	},
 #endif
+#endif
 #ifndef CONFIG_SPL_BUILD
 #ifdef CONFIG_CMD_UBIFS
 	{
-- 
2.34.1

