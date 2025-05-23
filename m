Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D4DC3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 05:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E74B8310F;
	Fri, 23 May 2025 07:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJ0hbBWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F9C583164; Fri, 23 May 2025 07:02:20 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5745C83108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-605f7d3215cso4526365eaf.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747976537; x=1748581337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MeDFlRmZGx/RhQkJ3zZCIcEjjD6NCW+r9w/1Xbh57Pw=;
 b=mJ0hbBWUnSpez04v4n7VWRwelIOZq6ilP2qpxkIV+E3awOg5KeD9GXH5XEaameptg/
 0ypvsaxqPBeVS32p8uoKSGTrFp+4l7afnc5a0ZbwzQLHPl3zTyxyLFhfJ3ZlkiZ3NRrX
 HCrXUgbW2uPVNS/ts4HcUUOv61gnqZZD2sBU7G0lSA9E0X+s8Pcl/49KCTeLkfyanv/X
 lyLHj3D4uF0Pvv78uomemc0nb8zVHLWOSHFt4c0NpsDdj7qGrUDB9kqWzJiQNDnGOaSY
 T34aZQjgt1w4SjsLFMovolrPvEAC4IPseseY3ffvISW4OApBjP1cBhb7gTH2vp5k1LR2
 GZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747976537; x=1748581337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MeDFlRmZGx/RhQkJ3zZCIcEjjD6NCW+r9w/1Xbh57Pw=;
 b=jjIQnTKELOOAoSar4eZIlsF7re9r6zSQHCE4743dLI4Z1P8IbKBw8AThTYLy2HXoMG
 Bmo/ayuOYjqhmABPAkSUOtuUxF5y9ZMCRZPiTQNQVi6SfTKGVllq+6jNv+H+JoBqskEq
 z6/Ln/DnoJKn/YBrpYnD9dLhf7Vwa+VVuknCAvvp0h/VCqAweg5rO3N9GfURgwqcAmFJ
 W6RRknaIXiIeKW9cjjaNkaiN/mgz0kyzLIAG67QF7H7ozYMnHGRGkFAR6VkO9IAX/lwR
 HwIL5VtR1xDnIEifUfX5Ldx4AiI4OAbmsmS0EixFxnFEbA/g356hj9imY76BspA+6Guy
 P+Cg==
X-Gm-Message-State: AOJu0YwizBUn9ToR8UXYf40ppMeeO+Lh6Kz+2aCjF9gyHEM8sT9QM1sf
 0yhMaKIid6meMUCicH3d3QjMo352VR6oCJd3IMHA/bGltjK705g8gE7h
X-Gm-Gg: ASbGnctjt6yNvmfGJFDeFATC7k+HmvBRteXPgBdkxWdoYtjCdEuPj7HtVGruHKN203a
 yLGDaBz0e4lAYytzsMRZb914Yk+phrZZIKSpKpdp7AGJlOdkCBZgtSpie/6rMpyMClXeN+1xeDN
 XiupYHQk6/8QiVtai2bOhd3U1Ix6QtpzL0UWo6gyP12M6ziqml4nA6lCORZbV7Q8dCKGnVlPwcm
 FNmTZ3CdwNHIEMIpByyqHTINBV69LFXOlqerVL1e9QIOW0c6Hcg9/Q+XAR6+C6KTY8BIYjdl1Ci
 VUvlu9CSuF5RS/qmPXlfhGvbh6LmvdjAeK0AFKQsVSCV/Cc5x5oNfbdJbza5Ru+qrpt21Ja5tDV
 nGsbnQYnj6/GmREioQ2L9S7KOECMPwKdaijS7MMI=
X-Google-Smtp-Source: AGHT+IEDBRocoxHfeGD3P3nITNpMflbNxd4FiClXTmAmnO2YD04UuRQFyhTI7Dx30FxKtUQwpLi0EA==
X-Received: by 2002:a05:6870:ae8a:b0:2c1:9897:dd24 with SMTP id
 586e51a60fabf-2e3c1f92f9cmr18986040fac.35.1747976536912; 
 Thu, 22 May 2025 22:02:16 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0aa0f61sm3421419fac.31.2025.05.22.22.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 22:02:15 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] ext4fs: Fix: Read outside partition error
Date: Thu, 22 May 2025 22:02:01 -0700
Message-Id: <20250523050201.22442-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Use lbaint_t for blknr to avoid overflow in ext4fs_read_file().

Background:

blknr (block number) used in ext4fs_read_file() could be increased to a
very large value and causes a wrap around at 32 bit signed integer max,
thus becomes negative. This results in an out-of-normal range for sector
number (during the assignment delayed_start = blknr) where delayed_start
sector is typed uint64 lbaint_t. This causes the "Read outside partition"
error.

This patch was tested on the Synology DS116 (Armada 385) board, and a
4TB Seagate HDD.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 fs/ext4/ext4fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 1727da2dc6d..f10c622e62c 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -101,7 +101,7 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 	blockcnt = lldiv(((len + pos) + blocksize - 1), blocksize);
 
 	for (i = lldiv(pos, blocksize); i < blockcnt; i++) {
-		long int blknr;
+		lbaint_t blknr;
 		int blockoff = pos - (blocksize * i);
 		int blockend = blocksize;
 		int skipfirst = 0;
-- 
2.39.5

base-commit: 421d4844591e967435fe0fcfa048ad45c3a48377
branch: master
