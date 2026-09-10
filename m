Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33AAC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C932D608AA;
	Thu, 10 Sep 2026 12:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yJ0eE9evhxoq; Thu, 10 Sep 2026 12:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AC53C607FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789042444;
	b=Wt0A8TgJe2g+3OIwWCfHxnvNw4XVLnX8E4KsVi4XStS23FJ3Ew8sBi3nI5AGE73UEXZz
	 45N93jvorjuElSWlo/6S8ogQen6WRNSoJhQOsisRJdKLCKJ41MWRTQ4fM2NKNKQDOHO48
	 pNFfSiy6iGoW7DI7RwHshehfyBcgXbBGRAA6974XG1//+yUVXCHra4+H3xWt0YJJWoncW
	 GIc9dUBmRizmmjOlRjUi5+7ZiQXVfmT7frjKfNY3+pxnn/+9qdzPfgjC8gqB0pyNno2Ps
	 zaEJGt7ohcEIbU9OtVpZp11P1WUkYn3c8PKQe8e3PcWlLVVQqFZteiThKmBmYYL1wiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789042444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=GCxeFvvQ7EhBmtt3P3RIS60pP5ZHeDhliLJ0Y80yD+o=;
	b=qA5Ca12vehcLYyrGMlGO3PiIS2jjRXra1/DIEbVa6prcPqwOX6ohqFtp7Qad/WZQy5bI
	 6OKUXVci7d1e0gxchbGa12pCkz+l8GcNHybpb+wqn73CWV6SPow/fxR/D1CCm9Kk5zFiO
	 Am9bGMRl02iynLB90WYnE5PJ9Mj5ERB3k6fJa/cYDn1jpwZ61SPhDD6OUSvTUzWDhPk3i
	 dWYw2PL6qDBc+8YOTkmNR0IHyL9u3nqC6N7PyyvreH4JIJaMBP8c0XlZMgV/z13i9oQ8K
	 tBykbh6RqYOfceujt8RSp5wWijyNkS9SN1l+4h0ohlJ5SsucD516v0KybCopKqdBy3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b="NK6/+tOM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789042444;
	bh=GCxeFvvQ7EhBmtt3P3RIS60pP5ZHeDhliLJ0Y80yD+o=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Scz6eFcE6rHBpb2BjGWxhVBno+3A1/Ck4E4kJlnqVfGD4qgtfgUYs6uy62u3j2SY1
	 QWvhEjKVZaVO9V8Rh5IZjdVsX1aDtrREz3MUej1yfAUHEqVDo3UPEWtzzaxNVyERx4
	 T9AlV1H6XJ5vJAxo7A8lT+xhNAXiBS3Vl/JzrDddWDRb4OtXbK9kCyUlM23DPK54xs
	 g+2A2cFvVxLCVotPLjOH+CaBLEzhw6NrgwyJ06KSSuQMm+XG24pxIy52n61gve8q73
	 CSgHj3MHJowjE4Vg1ekvJAfUr7p2zoFUY63P85bNSDgEmBmw+I71ilNcvyeIfxvusr
	 K74hMGDBJMwKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC53C607FC;
	Thu, 10 Sep 2026 12:14:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B79602E3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A989060791
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cVxLFOc-5rHX for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9C79760736
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789022575;
 b=KwbrX3MvJKKZU7QQhpj4n18PbkIiRMlUbgkkUDyBZ62CDpGQNAv0CMymI5NcgYtPMEcj
 s5eJay9x3yWFr6G9HMQwUA5x6cQuycLWYBOUxz8AkkSOI47DEXo0m2L3LPBu0b6sjwIvK
 6nCE4QFbAGIS/SiEXl+x2zp2i/4Ln84/jngIHS4OD1yVgKFuhma5GtltfuxxnclgGU7rw
 Tj80EvDscwCMdsajlON4rQ1wub7daCH5tJ2QlokSiem1Gpj9Oy1PuxhEmZRapp40zSewm
 1Bin5GB45x2dM+bqQHqWBydo2XoBrDdaFPcOS0C0wHWIQY9mkgO7JYLmKDgDoCh9tlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789022575;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=GCxeFvvQ7EhBmtt3P3RIS60pP5ZHeDhliLJ0Y80yD+o=;
 b=esZ3yJUYGQVfxJ3FImREy/85gp3uaGhIQgf6cTfSn9f3etaVX2haHLVPcSft1LXss+VM
 EuhNX23YOGeM4cxvfEYiWFmh2u1/aD7PiIFI04h5YC5C97t07y1Q7Dm8+JJfG9V6SqKvs
 lOJCTlrP1l0NfzPEBfAJkQI/FJ/wmpSb7WQ5sCWasdC4NjwIeUHmZi3FfuQaGdSe6zEJV
 Y8iDRZlmVckuz4dtXD4pxuIQhPxbo0hv8UsMJg1eeg67gwnBuqCfH3wRd7xcRYu14vxpD
 IjxdS5P95ajt0hGpew4GJMCqqPMm0A30J3MLHTLULI8BTViPI1uVqjRGrJTXH0nXTvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b="NK6/+tOM"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+torsten.rupp.8tronix.de@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NK6/+tOM
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C79760736
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:42:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 299BD43A7E;
 Thu, 10 Sep 2026 06:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07D7CC2BCC7;
 Thu, 10 Sep 2026 06:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789022574;
 bh=xN3+OcZiGOH5cMph1T5DaGDlT1XxOLIxX232BRkRlz8=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=NK6/+tOMQbIdqOScCeUmBuVm2zhoHBToJZEMQ65KeJzq6nl2D7pE8lkRML4nWQ2fA
 /Cu/30iyTEl9v9IdwDIA3En8xHEmlIA0zxDLJrf/H09DSAco8Z/o1ocG/jwcNY3RzW
 P45OxjKhlASmUiAAzpGtTmPgd+uFo2/0LykrBr9gu9Ao5hdmr/egskxecIhOc91RWT
 zoqhlsgmjUFFLAvsI0+1FQMwpUepoXqBvr6godEMvnJVjEU+bUf/M9YI8k5TKPQt/+
 SIhiyryNgfWZ4Xp59BO4X8Fy+0UHh1tECHjVZPfZIjTl2qzR4+5VrlbAsdiW0SXW+/
 hWUEMJas2Xz4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D6418C79FB9;
 Thu, 10 Sep 2026 06:42:53 +0000 (UTC)
From: Torsten Rupp via B4 Relay <devnull+torsten.rupp.8tronix.de@kernel.org>
Date: Thu, 10 Sep 2026 08:42:48 +0200
Subject: [PATCH v2] fix 32bit silent truncation of 64bit offset in
 mmc_get_env_addr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-mmc-fixes-v2-1-d13ecacd6688@8tronix.de>
X-B4-Tracking: v=1; b=H4sIAGdRomoC/22Myw6CMBBFf4XM2pq+wI4r/8OwqDDKLGhNSwiG9
 N+trF2ee0/ODpkSU4Zrs0OilTPHUEGfGhgmH14keKwMWupOojRingfx5I2ycN4/tG2xRXRQ/Xe
 i46j6va88cV5i+hzpVf3Wf5VVCSXQdtpqZ9DYy80tKQbeziNBX0r5AvjvU1mjAAAA
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Eric Chung <eric.chung@riscstar.com>, Han Xu <han.xu@nxp.com>, 
 Torsten Rupp <torsten.rupp@8tronix.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789022572; l=5369;
 i=torsten.rupp@8tronix.de; s=20260903; h=from:subject:message-id;
 bh=aUJRvuZJd4fEAFqypKvw8jgJ5Wfj7Mv/m32QlHBsqAI=;
 b=/Vp2mE1Tg3eXpMKjeMqQrO+kAX7jNj33PHFN/+3fxrfLvH3X88zHa4hfkA2AeDuvJkZLMOvas
 AINnhx+wgoVCfYyccp+Xxz/tAEx66fsIpA58ZmAAVEl5+634qQk6UCe
X-Developer-Key: i=torsten.rupp@8tronix.de; a=ed25519;
 pk=DFK2o6nuApZFiFHnUsWwIP/HTQZwoFI2698xwMNi5rw=
X-Endpoint-Received: by B4 Relay for torsten.rupp@8tronix.de/20260903 with
 auth_id=999
X-Original-From: Torsten Rupp <torsten.rupp@8tronix.de>
X-Mailman-Approved-At: Thu, 10 Sep 2026 12:14:04 +0000
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
Reply-To: torsten.rupp@8tronix.de
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Torsten Rupp <torsten.rupp@8tronix.de>

The function mmc_get_env_addr() return the address (offset) of the
enviroment variables. Internally it calculates a 64bit value, but
the value is silently truncated by the provided 32bit return value.
For offsets greater than 4GB the environment is read from and written
to the wrong place in e. g. the flash memory and may override
arbitrary data.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Torsten Rupp <torsten.rupp@8tronix.de>
---
The function mmc_get_env_addr() return the address (offset) of the
enviroment variables. Internally it calculates a 64bit value, but
the value is silently truncated by the provided 32bit return value.
For offsets greater than 4GB the environment is read from and written
to the wrong place in e. g. the flash memory and may override
arbitrary data.
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20260903-mmc-fixes-v1-1-946242839347@8tronix.de
---
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c |  2 +-
 board/kontron/osm-s-mx93/osm-s-mx93.c   |  2 +-
 board/kontron/sl-mx8mm/sl-mx8mm.c       |  2 +-
 board/nxp/common/sdhc_boot.c            |  2 +-
 env/mmc.c                               | 10 +++++-----
 include/mmc.h                           |  2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c b/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
index 739a78d2c8b..aaf73a2bbb2 100644
--- a/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
+++ b/board/kontron/osm-s-mx8mp/osm-s-mx8mp.c
@@ -132,7 +132,7 @@ uint mmc_get_env_part(struct mmc *mmc)
 	}
 }
 
-int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
+int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr)
 {
 	/* use normal offset for SD card */
 	if (IS_SD(mmc)) {
diff --git a/board/kontron/osm-s-mx93/osm-s-mx93.c b/board/kontron/osm-s-mx93/osm-s-mx93.c
index 02bee34ac66..23e33bddc53 100644
--- a/board/kontron/osm-s-mx93/osm-s-mx93.c
+++ b/board/kontron/osm-s-mx93/osm-s-mx93.c
@@ -120,7 +120,7 @@ uint mmc_get_env_part(struct mmc *mmc)
 	}
 }
 
-int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
+int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr)
 {
 	/* use normal offset for SD card */
 	if (IS_SD(mmc)) {
diff --git a/board/kontron/sl-mx8mm/sl-mx8mm.c b/board/kontron/sl-mx8mm/sl-mx8mm.c
index d24d5286e45..0138c5921a2 100644
--- a/board/kontron/sl-mx8mm/sl-mx8mm.c
+++ b/board/kontron/sl-mx8mm/sl-mx8mm.c
@@ -256,7 +256,7 @@ uint mmc_get_env_part(struct mmc *mmc)
 	}
 }
 
-int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
+int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr)
 {
 	/* use normal offset for SD card */
 	if (IS_SD(mmc)) {
diff --git a/board/nxp/common/sdhc_boot.c b/board/nxp/common/sdhc_boot.c
index 5ee730cefd0..0c2532a8595 100644
--- a/board/nxp/common/sdhc_boot.c
+++ b/board/nxp/common/sdhc_boot.c
@@ -16,7 +16,7 @@
 
 #define ESDHC_DEFAULT_ENVADDR	0x400
 
-int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
+int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr)
 {
 	u8 *tmp_buf;
 	u32 blklen, code_offset, code_len, n;
diff --git a/env/mmc.c b/env/mmc.c
index 1eddba3b0f8..4b5f8e2dcee 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -230,7 +230,7 @@ static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
 	return mmc_offset(mmc, 0) == mmc_offset(mmc, 1);
 }
 
-__weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
+__weak int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr)
 {
 	s64 offset = mmc_offset(mmc, copy);
 
@@ -331,7 +331,7 @@ static int env_mmc_save(void)
 	ALLOC_CACHE_ALIGN_BUFFER(env_t, env_new, 1);
 	int dev = mmc_get_env_dev();
 	struct mmc *mmc = find_mmc_device(dev);
-	u32	offset;
+	u64	offset;
 	int	ret, copy = 0;
 	const char *errmsg;
 
@@ -402,7 +402,7 @@ static int env_mmc_erase(void)
 	int dev = mmc_get_env_dev();
 	struct mmc *mmc = find_mmc_device(dev);
 	int	ret, copy = 0;
-	u32	offset;
+	u64	offset;
 	const char *errmsg;
 
 	errmsg = init_mmc_for_env(mmc);
@@ -459,7 +459,7 @@ static inline int read_env(struct mmc *mmc, unsigned long size,
 static int env_mmc_load_redundant(void)
 {
 	struct mmc *mmc;
-	u32 offset1, offset2;
+	u64 offset1, offset2;
 	int read1_fail = 0, read2_fail = 0;
 	int ret;
 	int dev = mmc_get_env_dev();
@@ -517,7 +517,7 @@ static int env_mmc_load_singular(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf, CONFIG_ENV_SIZE);
 	struct mmc *mmc;
-	u32 offset;
+	u64 offset;
 	int ret;
 	int dev = mmc_get_env_dev();
 	const char *errmsg;
diff --git a/include/mmc.h b/include/mmc.h
index 4bda44ea220..9a796e0655f 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -1002,7 +1002,7 @@ void mmc_set_preinit(struct mmc *mmc, int preinit);
 void board_mmc_power_init(void);
 int board_mmc_init(struct bd_info *bis);
 int cpu_mmc_init(struct bd_info *bis);
-int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr);
+int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr);
 # ifdef CONFIG_ENV_MMC_EMMC_HW_PARTITION
 extern uint mmc_get_env_part(struct mmc *mmc);
 # endif

---
base-commit: cc8c034e78eba6b2a3845783889b80753bb1af1e
change-id: 20260903-mmc-fixes-8aab24595998

Best regards,
-- 
Torsten Rupp <torsten.rupp@8tronix.de>


