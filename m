Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03EAC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 05:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4765A80F0B;
	Thu, 10 Sep 2026 05:49:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y12CA4E2CKMJ; Thu, 10 Sep 2026 05:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4BC4B80EF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789019378;
	b=KVC6kVWUYqWYJ81NUMe1KWfFYZ8M/eQ6nM0swvxMesFkmTuahh0R+LR9pw8xdU2INuKe
	 9vsLEYInknYhwndO2tTHHc4h25cM/l8hz1PTQOXkGfzsgOcWUuk7cyTEqTlR4NWYBgPRI
	 Qqeq5ph9CrbOlj+MHT/o/iPz1ChEC9FRZ0c5kYpxVH8jAjFaMRgyjikl0uyiY1Fm3LPEt
	 JcIbEotwJfhm1qrhrwROtn1EqSq6RJDBpSVEuNFB0b5kzlao+JycHFU+swWysaShQ8FQA
	 uwet0j7BatwKJU6Eu/8Lrd7bxArnzSb0CtYYkXrs5ilkPX98eyzBosOF713Vvcky/Pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789019378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=e+54JXWXnIXXzSkesYyen9l+TabgWXXs0B5aUQ9V7ck=;
	b=aHE1BrskM8xrxZnesSh/YV19k0rJEQv1G+0UwSc6pspAP75IYP9J2zhapXvlC/068FAY
	 PWyMmVrqKTPU2D3QPX2+PTdphOnhwaIXkcA9YOIE3TjuVw9isytT+Ooo/jmTzpPW5ga/K
	 4qofC8sMIlbKshGyokvJQocz2vo623xYHDGKMCitF1qFsrjzdp/G2L/+LWOJzY15bbMfM
	 IQfujTBRuPH3ZvNW1qT/688NpwAdhpnXRLg4gpR7p4JxiPjkozR2SmP8qwF1v9W89IuFl
	 jXxRRGcfzh3JaLsFrEk4a48rc/BRiQomCaU8NvzXlPhmVVia4SnxSnGX51E324ZNEXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Juwx8Xcw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789019378;
	bh=e+54JXWXnIXXzSkesYyen9l+TabgWXXs0B5aUQ9V7ck=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d+HVtHMbKQH38nYEqdRh+1+h8bdl3DaISFA440Ngxahzcz0xVvtnF0Bp01Vqqyuhp
	 wzKMKybbYBmEaEdBOTnJaSrkbp1adMxkNpMPlT0YNwxQQHBVRQLz62lkjZTlaF7wSS
	 1cBPhoa8fOMpoJDRnctWPc4iAuw8LqRTeWlJXtdfAQKQXTqr8OXQro/GZzHw9IOMfO
	 MtIL37y7l3ZL4AoN4SMl9vXspqe95ai+YRCpLKIC4D3aNh0RazyWYc7ypyTH5PGjGd
	 JpH/epyoRX7mdx5ClIplrgYfZz/BVyw8IYpasdm2ToLwiMNmWF0E/YErlxEBmnc04Y
	 TeR+rxvouemuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BC4B80EF7;
	Thu, 10 Sep 2026 05:49:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F25AF43F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D790B80EF7
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UaDeWjePhUhG for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 05:49:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DDFA880E5C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789019376;
 b=UZoVN7np5fqZ1iGBpWR8pkNxntCxNdkeR8WPXUGEiLmZo2iIM8+LV7h4DDhG5XxjK2um
 olu6br36AMUNWCRgHPwzMRSwJVLXOu2L7iIOio3rKNOsqETVr+VYpoXt91wcE6ErerILh
 9jmegPG4yr4/Hm/md3LUa4rYSN7eNAn9e+4KsaE/8yG03Bsfe0i74IxICSUfMdrlyiUcx
 SHMssorl0A+P9ouwkWYbZkVTt4oQ3YkZFD5HhuNjJeTUvnpwr4xUf9e9QlSD8HAngx1yU
 t+xVOxSqA4lGai9DXGUwWVQ5vWuJiyDPyTbhWU3is/flyLRz7golKvA59r/khIPW9JQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789019376;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=e+54JXWXnIXXzSkesYyen9l+TabgWXXs0B5aUQ9V7ck=;
 b=Aq5z3CaEyl38DZuJaSs1g64Ca4mBc5nSzLHcC8Jo8lEOYEQokKyh3//sCNwiCBamRVC5
 I5jEcZmqzomytsK3oketr2iNI9DqWCDAe4d6RgupsWwbBu27mUSGi/KbpnMTJfTMUP0Eh
 TnAyj3qZ0Dv+Bxc0cPPrKkDWvkS1XQPJYyA69HltEdYytGYam++Vwo9iqtj+cD/veSJ+S
 qeO51UFuCLxeXvG07sva56Qv8C3jWzV2XojvbRa8dHA7fz9m58JHXi8+FqDa2hRkQmQ7g
 LwHY9nVuwLRdvIDCGxuj1Bkk+lpPdN7usBKJXK0h+BsvoM5fC9u1qsSd3WNJh3hNOnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Juwx8Xcw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Juwx8Xcw
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDFA880E5C
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:49:33 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so6158407f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789019371; x=1789624171;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e+54JXWXnIXXzSkesYyen9l+TabgWXXs0B5aUQ9V7ck=;
 b=Juwx8XcwmsZnegGstUoIIGXcoSRcEV1Quzedir4HWfgrYQOLE442vxwpICGPQXCPLh
 HOxt893lha4PInTlxOeocolOp7Z06fSmieFSe+l0Xai7T5cTl7v1qY1Wct/3YfsXXfxM
 fO1Kxln+rBK4Q5UPF6kQFaml8CzYSaK7fu51D7kWMwXVQWPLiX0mx9zZGWh3n4Yxd0rC
 S8sEkBdboMv9vIQzoqeQeAR8ZVY7tEKZQE+8JackxT7Gyp+bN3MYiQrO2uFcaXOIlo9G
 L1oeTowGGA25nIb2iW8xpyVTIBtpuAdk0K/eP9hLarsHadnuYmbw9XR/8zOx0nmkwgAR
 g9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789019371; x=1789624171;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e+54JXWXnIXXzSkesYyen9l+TabgWXXs0B5aUQ9V7ck=;
 b=g7CBBpBZueuBdXJap4p52X1oQ+14KdoE8kmmRXWlYOXjO1Zz/LzKIcMtVVqI5ygLnB
 G9wOvHgiSYo0KoG4V8uGBQJFxnX0jMresvoKJ7ZmpRSQn7SfV5WmQ/00NQF90OkxReYu
 VDk/dbRc5iW8NSUURXWpAlXdYXm5UKwsmCuVyESVZkrNXNzcH6ccpE2IrMzAbFW9xDlB
 QdYSBuZwMbOIzQ1pUO8k65YxB2zi9NuICTHLpZCCo3WhioUw+8x1BapXuFuXlCKFm6f6
 QcN5dWBzgGBXazpTMjeJgrg1+xANgEtSQrSUF+v0EfjXYC0AngW70iyH0fNUK1miBmor
 Q9DQ==
X-Gm-Message-State: AFuF++keEGPpLcbrIwLIAP0vImWFX4SKmWcBVegryLpeVmseBJ3RyP8Y
 8pqPIpcRI1zWGK1uY6xKknV9k5z+vtyAkVMc9Z0vjhYZkfQnkgRBcWNQXgzXJpmmeLc=
X-Gm-Gg: AYBFou15UNHYOBSX5WRya+IGaOKGCEu52+pjWpnjFF21PFZ4vR/y1HI69Jwx9gQXYEY
 Rrb80SOSQZMWRl6+JqCBGQy0MywFlVcQ2TC9RoODvJVYJlMqEdjqJ7driMBixNlyQ7d53Zh//CK
 3PWk9I/kxttt7TqZ1V3l8yyLIroJA03gn1Vrt45fZE0Y6FrttNOHTfelW7HYFCK5kmIwKndeIKL
 PvQ82TFyR1ZkTtxsXZmh3K0+icz+tDvO7ffCFHZEJANi6eeTqrjtW+Qk8fpFBi2XKyIbRQGwHt2
 /tqidONHsxqOz/tyNJIK1/kd+QPlO4dA9Cic+2XW6esPrjUWkTN9+vgEywHBnxY47VoZI3Oz6ZH
 Szr23mcU9H+eiJEjwRGdM0vSinl1lvowHLgJeG4kj7YGkIVq2DWrb8IdamL+Pu/btvRluVcsw24
 CB4+Ez1oFjm1NvuiM42PVmDUPg8dgN7TLDQSNRMu0lQPWOwuI5PuHaeZtJhZAJjtHgZbr7ro6CU
 ImMCeNgvDoVBAvTW0n4c4Qh5qqa7vwq0nZGOyPXCSd/A1DSdz4Xqm3esi2zH5Kz6VoNRDcIpqor
 G7GHHOzECXIJ/7oO
X-Received: by 2002:a05:6000:4812:b0:485:8c16:5ee9 with SMTP id
 ffacd0b85a97d-4858c1661f7mr37697538f8f.35.1789019371470; 
 Wed, 09 Sep 2026 22:49:31 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883959f0sm51852519f8f.10.2026.09.09.22.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:49:30 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 10 Sep 2026 07:49:29 +0200
Subject: [PATCH] spl: mmc: support board-selected raw partitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ccaione-upstream-part-dynamic-v1-1-381414ad9a34@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAxA0V8ZeTbQlTGovyI+tGnUCKsl6UQZ+
 3erPh643A2MVdjgOGyg/BSTR+kYDwPQLZYro+Ru8M7PLriARLEnjGu1phwXrFEb5neJixBONAb
 PPk8pzdAfVfkir9//dP7b1nRnat8p7PsHVKvvI4EAAAA=
X-Change-ID: 20260909-ccaione-upstream-part-dynamic-4c192e2d4bb6
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Boards may need to select the boot partition using on-device metadata,
such as A/B slot state. The existing partition hook runs before MMC
initialization, so it cannot read that metadata.

A separate dynamic-partition mode makes this policy explicit while
preserving fixed-partition selection and explicit requests to load other
firmware.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/Kconfig   |  9 +++++++
 common/spl/spl_mmc.c | 67 +++++++++++++++++++++++++++++++++++++---------------
 include/part.h       |  3 ++-
 include/spl.h        | 21 ++++++++++++++++
 4 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c941..f5904af3ed2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -574,6 +574,15 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 	  raw mode. U-Boot will be loaded from the first partition of this
 	  type to be found.
 
+config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
+	bool "MMC raw mode: by board-selected partition"
+	select SPL_LOAD_BLOCK
+	depends on SPL_PARTITIONS
+	help
+	  Use a partition selected by the board at runtime for loading
+	  U-Boot when using MMC/SD in raw mode.
+	  Override spl_mmc_get_uboot_raw_partition() to select the partition.
+
 endchoice
 
 config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index cc16709dc9b..bd5b6371611 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -107,7 +107,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 }
 
 #if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) || \
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC)
 static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 					struct spl_boot_device *bootdev,
 					struct mmc *mmc, int partition,
@@ -307,6 +308,11 @@ int __weak spl_mmc_boot_partition(const u32 boot_device)
 }
 #endif
 
+int __weak spl_mmc_get_uboot_raw_partition(struct mmc *mmc)
+{
+	return -ENOSYS;
+}
+
 unsigned long __weak arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						       unsigned long raw_sect)
 {
@@ -366,11 +372,10 @@ void spl_mmc_clear_cache(void)
 	mmc = NULL;
 }
 
-int spl_mmc_load(struct spl_image_info *spl_image,
-		 struct spl_boot_device *bootdev,
-		 const char *filename,
-		 int raw_part,
-		 unsigned long raw_sect)
+static int __spl_mmc_load(struct spl_image_info *spl_image,
+			  struct spl_boot_device *bootdev,
+			  const char *filename, int raw_part,
+			  unsigned long raw_sect, bool select_partition)
 {
 	u32 boot_mode;
 	int ret = 0;
@@ -430,12 +435,23 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 		if (!ret)
 			return 0;
 #elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-      defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
-		ret = mmc_load_image_raw_partition(spl_image, bootdev,
-						   mmc, raw_part,
-						   raw_sect);
-		if (!ret)
-			return 0;
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) || \
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC)
+		ret = 0;
+		if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC) &&
+		    select_partition) {
+			raw_part = spl_mmc_get_uboot_raw_partition(mmc);
+			if (raw_part <= 0)
+				ret = raw_part ? raw_part : -EINVAL;
+		}
+
+		if (!ret) {
+			ret = mmc_load_image_raw_partition(spl_image, bootdev,
+							   mmc, raw_part,
+							   raw_sect);
+			if (!ret)
+				return 0;
+		}
 #endif
 		/* If RAW mode fails, try FS mode. */
 		fallthrough;
@@ -456,25 +472,38 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 	return ret;
 }
 
+int spl_mmc_load(struct spl_image_info *spl_image,
+		 struct spl_boot_device *bootdev,
+		 const char *filename, int raw_part,
+		 unsigned long raw_sect)
+{
+	return __spl_mmc_load(spl_image, bootdev, filename, raw_part,
+			      raw_sect, false);
+}
+
 int spl_mmc_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev)
 {
-	return spl_mmc_load(spl_image, bootdev,
+	bool select_partition =
+		IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC);
+
+	return __spl_mmc_load(spl_image, bootdev,
 #ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
-			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
+			      CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
 #else
-			    NULL,
+			      NULL,
 #endif
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
-			    spl_mmc_boot_partition(bootdev->boot_device),
+			      spl_mmc_boot_partition(bootdev->boot_device),
 #else
-			    0,
+			      0,
 #endif
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
-			    CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR);
+			      CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR,
 #else
-			    0);
+			      0,
 #endif
+			      select_partition);
 }
 
 SPL_LOAD_IMAGE_METHOD("MMC1", 0, BOOT_DEVICE_MMC1, spl_mmc_load_image);
diff --git a/include/part.h b/include/part.h
index 15daacd7faa..8282f31e2a3 100644
--- a/include/part.h
+++ b/include/part.h
@@ -463,7 +463,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
 	defined(CONFIG_SPL_FS_SQUASHFS) || \
 	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) || \
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC)
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL
diff --git a/include/spl.h b/include/spl.h
index 5078d7525ab..1839dd2e343 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -607,6 +607,23 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device);
 int spl_mmc_boot_partition(const u32 boot_device);
 
 struct mmc;
+
+/**
+ * spl_mmc_get_uboot_raw_partition() - Select the raw U-Boot partition
+ * @mmc: Initialized MMC device
+ *
+ * Used by spl_mmc_load_image() when
+ * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC is enabled,
+ * after hardware partition selection. Direct spl_mmc_load() calls bypass it.
+ *
+ * Preserve the hardware partition selection. This hook may run repeatedly
+ * during one boot; guard any once-per-boot metadata updates accordingly.
+ *
+ * Return: Partition number >= 1, or a negative error to skip the raw load
+ * and allow normal boot fallback. The weak default returns -ENOSYS.
+ */
+int spl_mmc_get_uboot_raw_partition(struct mmc *mmc);
+
 /**
  * default_spl_mmc_emmc_boot_partition() - eMMC boot partition to load U-Boot from.
  * mmc:			Pointer for the mmc device structure
@@ -975,6 +992,10 @@ int spl_mmc_load_image(struct spl_image_info *spl_image,
  * @param raw_part	Partition to load from (in RAW mode)
  * @param raw_sect	Sector to load from (in RAW mode)
  *
+ * Explicit partition requests bypass spl_mmc_get_uboot_raw_partition(), even
+ * when board-selected partition mode is enabled. Use spl_mmc_load_image() to
+ * load the next boot phase using that configured selection policy.
+ *
  * Return: 0 on success, otherwise error code
  */
 int spl_mmc_load(struct spl_image_info *spl_image,

---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260909-ccaione-upstream-part-dynamic-4c192e2d4bb6

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

