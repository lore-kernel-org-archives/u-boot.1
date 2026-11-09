Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8A606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ep1/jKh2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifzwJ3ku
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE96040703;
	Mon,  9 Nov 2026 13:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GudlMyImt1Pl; Mon,  9 Nov 2026 13:28:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26421406EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794230919;
	b=jpLNVtqphtwoVMwp5ddJflsRQocXZquqcxJ7XKY2HCGbEJKzPsuNHOiVoHXJhiaN+JME
	 2itxXWdNJje/zlGjNa64ZSe5eHiXb1bDLNl882pmXlVxK27rZ1GWeSdqxWdNRXrK3lec/
	 yXjjEC7oOME9dxk+APZj+WNU1H33rS77RhrrRJZqD8zFUdDUTWg+vHjiKeYdFDLtH03Fo
	 ixMF8d9dxJ6JSz8Wg2cCqZS6UTYs8GhreUWJNrUeZuOf7dSrEW72ibO9js72349Nqtg3f
	 q7leVnnBg9/sEAlH+LdADII6ybcBOL91Slj9DA1RMsXKxvTtT18JzifB+A7eijTccpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794230919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=MyVLJajpGp0jVIJ5goc/MYORG2RWL3pWqyhqVdV4shI=;
	b=bM9ik57rpft6Z2he/SkIKon8YjQ6U1vvA0hFgtQxaew4ycwiu8NKQker3p0aXtw24J6Q
	 fcfyyoo2Uv9IA7xcvN11jsU7cLwP62WrFqTrNP1i5fus6LRk0mymGukWrpzzDe0oKFjBa
	 ZV+f4QfDZCo2VawulMqVdU9U/1/+BdmTzz2djZofka5LDCI+r/AbMfa6jAF9blSMv51l1
	 /MzorpJDEtV/MfdbohnfZa9dDTeFcaNgd77Vrfpsb0pmeaFLeZ3FpRMHrMbYJnb1HHH8g
	 aGl1bDnOVN6qyKkN2jnmNNyCX9XSOKWBn0OhpQn0FriDZH0y3utBZ0welwnTrtLTu4Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794230919;
	bh=MyVLJajpGp0jVIJ5goc/MYORG2RWL3pWqyhqVdV4shI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ep1/jKh20pHnSGIxYJIyd4Ug70scy4JhpSYHosoWiWWexAQ8tY4S0oiAP+QDMEnd6
	 WYdXsJJyEERN2BQK7VInoj+2aijyrNY7q6TDi4ftV4RkGBSpQMiApLh+FoTWZPI5aQ
	 ym0PNfe2gpyRdehxsd28ZCl09FnvmD7Nk6dT/PfIc4Y6X+RH1meEbBDGcThB4Ri+Zr
	 CYV9qp67W74j6O8TQ1FFew/1BYMCaNSL5P6sxO5g1pxq8J+fqVwKoVcRHxxUSS2hvc
	 0cceWkApl2ZplEKhERzXD/U0aZ0Bqv4OJASqZQsxZBg6s+gz47mu3npXn1hc7iToiH
	 DZni/tP1fHYnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26421406EB;
	Mon,  9 Nov 2026 13:28:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1259E361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03AE380ED9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vyDFf3htUARL for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 09:39:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17DA480E11
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+takahiro.kuwano.infineon.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ifzwJ3ku
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17DA480E11
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A560462FED;
 Mon,  9 Nov 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9CF241F0089F;
 Mon,  9 Nov 2026 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794217196;
 bh=MyVLJajpGp0jVIJ5goc/MYORG2RWL3pWqyhqVdV4shI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ifzwJ3kuXWrVvDXsJm3HnnHjPw7YRUVcP+0XruJlJLJZ4wHNq2DkeMQWCNyvUq5oN
 xeA+i0HRpvx7zjq/jvlw5QOlnWl+BTAKQ81O9Qof4COTMYYa9/cAVwJXWUCdsbKfcW
 xleLzaiEOJ+bT7kRz+BU1jfGXMGzjbXfC7c2ecomOG10/OI21lWOekH2wN2YZHNGv/
 MPX3XoywWliMXXgc8OeyIx8HUQxduti7VIb017Qg2kFQbX1hDrEnEVjfcfRH0ieBYA
 CHCRGr2sfvGTbu1h+onNm2HuSH/jM5qRttbg7lgnSsvaNOWXJgMijE2Sn6070cY5Vd
 wKEaaUGydZLig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1A62C483BD;
 Mon,  9 Nov 2026 09:39:54 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Date: Mon, 09 Nov 2026 18:39:45 +0900
Subject: [PATCH v4 5/5] mtd: spi-nor: remove page_size from struct flash_info
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-split-sfdp-id-v3-v4-5-7270c9d82fd3@infineon.com>
References: <20261109-split-sfdp-id-v3-v4-0-7270c9d82fd3@infineon.com>
In-Reply-To: <20261109-split-sfdp-id-v3-v4-0-7270c9d82fd3@infineon.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, 
 Fabio Estevam <festevam@nabladev.com>, Eugen Hristev <ehristev@kernel.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794217192; l=3445;
 i=takahiro.kuwano@infineon.com; s=20261016-2; h=from:subject:message-id;
 bh=IIHKxqpy6yT05/P0HQsi21XK0QtpGpDcGMPAREI3WT8=;
 b=tnbmMqviWbpDwtz5HZVNuqOpL3MxxYUUgkf1zsQIYAYfm8lJZ1B2VenTmoax7INbgRJqF7yCU
 RIL0+nSj/H/AE2erIKzWWqJLm6DLYUx+WfYRcmBDTUoTReDOtBJ9vvr
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=pp4mpJAHIqhV2MvdSGbIzKRk3ujhk+tSlGjyTursr4E=
X-Endpoint-Received: by B4 Relay for
 takahiro.kuwano@infineon.com/20261016-2 with auth_id=1202
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 13:28:36 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: takahiro.kuwano@infineon.com
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Takahiro Kuwano <takahiro.kuwano@infineon.com>

All devices described by the INFO() or INFO6() macros use a 256-byte
page size, so page_size is not needed as a per-device field in
struct flash_info. Replacing it with a constant reduces the size of
the device ID database.

Fujitsu FRAM is the exception: it needs a late_init fixup to set
params->page_size to the chip size.

Signed-off-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
---
 drivers/mtd/spi/fujitsu.c      | 22 +++++++++++++++++++++-
 drivers/mtd/spi/sf_internal.h  |  5 ++---
 drivers/mtd/spi/spi-nor-core.c |  2 +-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi/fujitsu.c b/drivers/mtd/spi/fujitsu.c
index 3d5328b1815..6758d0c9d16 100644
--- a/drivers/mtd/spi/fujitsu.c
+++ b/drivers/mtd/spi/fujitsu.c
@@ -15,13 +15,33 @@ static const struct flash_info fujitsu_nor_parts[] = {
 		.id_len = 3,
 		.sector_size = 32 * 1024,
 		.n_sectors = 1,
-		.page_size = 32 * 1024, /* Whole chip can be written at once */
 		.flags = SPI_NOR_NO_ERASE,
 		.addr_width = 2,
 	},
 };
 
+#if !CONFIG_IS_ENABLED(SPI_FLASH_TINY)
+static void fujitsu_late_init(struct spi_nor *nor,
+			      struct spi_nor_flash_parameter *params)
+{
+	/* Whole chip can be written at once */
+	params->page_size = params->size;
+}
+
+static struct spi_nor_fixups fujitsu_fixups = {
+	.late_init = fujitsu_late_init,
+};
+
+static void fujitsu_set_fixups(struct spi_nor *nor)
+{
+	nor->fixups = &fujitsu_fixups;
+}
+#endif /* !CONFIG_IS_ENABLED(SPI_FLASH_TINY) */
+
 const struct spi_nor_manufacturer spi_nor_fujitsu = {
 	.parts = fujitsu_nor_parts,
 	.nparts = ARRAY_SIZE(fujitsu_nor_parts),
+#if !CONFIG_IS_ENABLED(SPI_FLASH_TINY)
+	.set_fixups = fujitsu_set_fixups,
+#endif
 };
diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 2be206b2651..ef163122e61 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -18,6 +18,8 @@
 #define SPI_NOR_MAX_ID_LEN	6
 #define SPI_NOR_MAX_ADDR_WIDTH	4
 
+#define SPI_NOR_DEFAULT_PAGE_SIZE 256
+
 /**
  * struct spi_nor_fixups - SPI NOR fixup hooks
  * @post_bfpt: called after the BFPT table has been parsed
@@ -61,7 +63,6 @@ struct flash_info {
 	unsigned int	sector_size;
 	u16		n_sectors;
 
-	u16		page_size;
 	u16		addr_width;
 
 	u32		flags;
@@ -117,7 +118,6 @@ struct flash_info {
 		.id_len = (!(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0))),	\
 		.sector_size = (_sector_size),				\
 		.n_sectors = (_n_sectors),				\
-		.page_size = 256,					\
 		.flags = (_flags),
 
 #define INFO6(_name, _jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
@@ -133,7 +133,6 @@ struct flash_info {
 		.id_len = 6,						\
 		.sector_size = (_sector_size),				\
 		.n_sectors = (_n_sectors),				\
-		.page_size = 256,					\
 		.flags = (_flags),
 
 /**
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8943ef529a2..c6e5ba4bceb 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -2018,7 +2018,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	/* Set SPI NOR sizes. */
 	params->writesize = 1;
 	params->size = info->sector_size * info->n_sectors;
-	params->page_size = info->page_size;
+	params->page_size = SPI_NOR_DEFAULT_PAGE_SIZE;
 
 	if (!(info->flags & SPI_NOR_NO_FR)) {
 		/* Default to Fast Read for DT and non-DT platform devices. */

-- 
2.53.0


