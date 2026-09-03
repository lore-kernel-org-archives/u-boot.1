Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C0FC624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 12:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6EF860B8C;
	Thu,  3 Sep 2026 12:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDq3inRec3pO; Thu,  3 Sep 2026 12:51:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D47F760B6D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788439866;
	b=grXrLoNzzInTw0ja981wDN8o4ibSuoeXUnRcnA9XM5ybndotxBeL5K7CkMCLLM0cuch6
	 SQ7nXDcODWe2D9Hx7rPhH0QCQMTZoE7jj5qBAopN2yallJa2KGXSzPX109Tf8QAbxnBRk
	 IOhAPS8T/78iKAJz+U2KiBsGGCQtJL8Wi4c3MHLbeU7XmNCjJ8+In9BIAvqMjblxRSmOr
	 7z6uq26kBZCdMNAnVv7SKi9+I332U73XCsKEc+TGM8SX8QkStvan/oTk1lrmScydVTw7a
	 u//FtMwhXp76KHIvPizhKVWV3HcrbKWDxBTeSHxn+KayzBprVjNIeiYtAem7bpvy7Nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788439866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=+x/5KrQl5jxvCd2ASBog1LO7lMPGYgbUMfAq0b5f1A8=;
	b=KmUKpLbYW8p6VktkOzS2LXkJWsQYaKSBPBbr2aPdBYIF+zphP8Q86aMezk3QO9VgSUUP
	 QNz5MRzIh2O7TA3F1dxroBkxYCP+pm6v8+TQ6v4HKyXvzcJvVZcdSMtqv6XVQgpCUUHU4
	 mxj8vPLxjWp9qJynU61tx4L/S/u4qnKvXNZyAYhKsIGrkd+DXKrLBtP94Z+LVOP4kDKlT
	 833nZUB/8Z65loJ4wXz45e8nUo/IOhvW4QRM9OtZKe97EjucpanzjJt+w8qmyWsuDUYj0
	 XjhNSzNEYqUnC+kbrvQxN2jofKlSOUPXkXfNEGwdwD7hs2A6aLviZUF/uu1AMrNdXOQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788439866;
	bh=+x/5KrQl5jxvCd2ASBog1LO7lMPGYgbUMfAq0b5f1A8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=cfBCcbSQ4cm0EcZ+L6E+H/PjuZN9+b4XwrU+l4Cmd+bZ//kHV/xPkc5iL40btqc6N
	 OQkFTBcz0YzZ05atm9O/T1MW3F9bGmA2i0LvD0iUR8z+OasbAkPBov7zRBWZ8MGdqV
	 UDVzXAkDvYxT+BGz9SEP1blYPxSKqrZR4pwwrXTtLhiWHojJKzbB08J6U6zECmk5DT
	 tzP4UfI+OyeYIISjsLyXakLAdOg4+N7WCKLAzyy1BVrS2KryLAMxsyxPRfGFf2M1nD
	 8D2tSrx4el9ceX/qZwHRG53Vjhly974YJtw/zl0DD3yF8nMyIYO5JtWNkNPAk60VIN
	 zDwusqbbNMvgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D47F760B6D;
	Thu,  3 Sep 2026 12:51:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF3D6D5C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9474F80FF4
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Ypch0biiv9r for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 07:20:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A81E380F23
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788420046;
 b=IR5CwPbtzW4O3KDJBBFs2fNWQkfEX+rQu65egeO0NU7W+qnIrZgJ91urfb82WeiJiGPq
 A1n7opyamkdcKI5FTSMN14D0mq0fZxRISfMDARdeGWV+u0/UfirT7nGEwjL1k+Q3vV/zo
 HkNfm4q9YoRcxTp3t5IvxnMIJHCL33HbzOLnhYiwsPBbyNGfLrNkj4ixMXL0QfhiJPUlz
 UgEKTytnOAcki7VnseZHvOb88Lwm0ZmNKmWDF3jXN5wNEaDzNdiI64s17vgLefphH6eCX
 NpeYbYDqwpoL+9nnKNWuUdOEX2Zfh4bWyO7m1IYhzXJDSL6lXjE4/CwdYWJQ6FogkEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788420046;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=+x/5KrQl5jxvCd2ASBog1LO7lMPGYgbUMfAq0b5f1A8=;
 b=ZrL10wiq5rIVnSPkp2sROp8YPopFuKk2FBGnJTTcAYJh4xWwEtXOsVbEzW3IHZj+aWBl
 CkjjFQqwWWbbV2cCAQr4o9wHssL8B7Bw3dPurZj6TbmapTf5q94sMfEr3mluaqF4cXfW1
 D3z+yIpaYH3NgbO4eiArSCYrWTw+/Z9+kI3HxOIGPVwIVWkRKDqwNdWsDzWKuFKy6yXzA
 +USrsZSBgUOUkmyAEW5qVFGxs5hnpwyInH65NRCFhczSVLKmnBHQE2zEpybXvQhaXwyMP
 7m0OkFUoZoX6xbMXqSFUehOobmAh/M98lXswUbUwkrA1bnwQbeS3x2o3dQjCDVvQQEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cnCWdMR0; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+torsten.rupp.8tronix.de@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cnCWdMR0
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A81E380F23
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:20:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AC4B0600C8;
 Thu,  3 Sep 2026 07:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6018FC2BCF5;
 Thu,  3 Sep 2026 07:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788420044;
 bh=iAtNBWtbcG6PbzFzu+d2iX1muysdP5DkwBnw4FsepBI=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=cnCWdMR0lon0msk6cDzVy6OdyaD4QiMKQdwFF+2pgW9NiftjFdoeeLk1D+6JeZUwy
 BiG5BRBgKWjzMkgRyeVvGKNJYIPMcJhHnJ5M6nnOyjNf9w94zW1pkiyboQXSgNebo6
 8w5scqdp8jiQBtxT5/C8FZ8xV6RYPiIzMzM18oGVn4uyvmoJ9JdmfoQc0Gtw9ym2I/
 SlATMZwejgT5DUOIMc14OPoPzWMtF4u3Bv3iAKB35N2u2ieqGcAHNjOvmf8yvRbI8Z
 7LIz2KAQwfb+TuiaellBfkzVTwlLb/h+jJxKn1lr6Q4B7WEyQuu8zrsVrcBFZEXLHk
 BR3AUjJ09gAnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0AC624A4;
 Thu,  3 Sep 2026 07:20:44 +0000 (UTC)
From: Torsten Rupp via B4 Relay <devnull+torsten.rupp.8tronix.de@kernel.org>
Date: Thu, 03 Sep 2026 09:20:42 +0200
Subject: [PATCH] fix 32bit silent truncation of 64bit offset in
 mmc_get_env_addr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-mmc-fixes-v1-1-946242839347@8tronix.de>
X-B4-Tracking: v=1; b=H4sIAMofmWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwNj3dzcZN20zIrUYl2LxMQkIxNTS1NLSwsloPqColSwBFB5dGxtLQA
 XpJDyWwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788420043; l=5217;
 i=torsten.rupp@8tronix.de; s=20260903; h=from:subject:message-id;
 bh=N6Oa9ovFnWj46mDS7TgLCycBPoyr0wpKaQ0+dg6Tbb8=;
 b=9GcuB7eAl6+f15bU5Nub2g0oBza1JWytDfG8bTlinAESI3LtVAoWSxcF+WGMhtK0d5y4kWdZy
 O36R2EacfsgD7/mqvBVyoeNFdy3lNr32ikSL9CD+o/7eJdYUFZPxJUT
X-Developer-Key: i=torsten.rupp@8tronix.de; a=ed25519;
 pk=DFK2o6nuApZFiFHnUsWwIP/HTQZwoFI2698xwMNi5rw=
X-Endpoint-Received: by B4 Relay for torsten.rupp@8tronix.de/20260903 with
 auth_id=999
X-Original-From: Torsten Rupp <torsten.rupp@8tronix.de>
X-Mailman-Approved-At: Thu, 03 Sep 2026 12:50:58 +0000
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

Signed-off-by: Torsten Rupp <torsten.rupp@8tronix.de>
---
The function mmc_get_env_addr() return the address (offset) of the
enviroment variables. Internally it calculates a 64bit value, but
the value is silently truncated by the provided 32bit return value.
For offsets greater than 4GB the environment is read from and written
to the wrong place in e. g. the flash memory and may override
arbitrary data.
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


