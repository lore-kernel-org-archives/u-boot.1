Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5F6C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B3EA60BBA;
	Fri, 31 Jul 2026 12:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7sFAwzS9Mqw3; Fri, 31 Jul 2026 12:40:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5D3160B9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785501648;
	bh=t8e6uICo1gYANlUHzZfyFg4zGETgBqrWuVdLeYOrffM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bM1sKKjx/nASY9g0dcZUF5jbRx+7FhiS5R8JMawH8GF2rSRwr+jz8tnf+K3OuyYL3
	 hLhaRKrevjkx1Ss6vtYOGTvKBL0IyZz9aKT458zp/SBUnUDysD0qPS2QJjHmogwdUs
	 OHw+Vr7k419uKOlrgKNdMrP/9jkEq3yCVnnzbf6+9gsJRk26lbxsAQQWlbfvzGyJPb
	 3wir33XZmIYMFLllhE196+dacxVGTsGmwllxzKkYBsWSDvXGOEGu+nT8IYVHd8TMpn
	 I+QKsLB5NiWZc+fUvfytdfTldaTD5rvKDucFq6PKR6UAaBUQB+Y26EjfELy22g4mS2
	 IOwc4+9aGkZfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5D3160B9B;
	Fri, 31 Jul 2026 12:40:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE1A069
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3CD781332
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmnmfSrG_NkL for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:40:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BF32581325
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF32581325
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF32581325
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:45 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso590475f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 05:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501644; x=1786106444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t8e6uICo1gYANlUHzZfyFg4zGETgBqrWuVdLeYOrffM=;
 b=WmXEhFO+uXb22tGy79k6jklKpIEVCCZmYIaU47IgDrpX9GhH64Bt9X1Pre+4H6xk7I
 x0uD3WimV2LAeyTkdxyoaQ4kqwMVus8c7B3uKy87ifiMj34cOcyNQrraqYKLiiI9DEE1
 xh0QECqu6k6ZGLqFtArwUXxLugrZ+S85oIx5ohWoru6IbgbkH2hSCf+X7MIMpX9dx/IL
 uOxQMuHa5GBVSUx1OIDIMtADLYZwBGWqFRKaxtUK1V0ea1ZrdEOiioiWseuH1E3H94uA
 mKB7/CgZoj0hAAny3oke1hZ2ZGU5Mdhg90WYd97CzQlPv1J26gyNQBsNNdBc2HUbHZdX
 iFkA==
X-Gm-Message-State: AOJu0YzLLUBGfIdNBO/MDsFSqW+RXqfvqY+4zFggRWMDq+cEiYQ4BB8b
 C4hCcgfoqRTU+MFroa6F41zGvDvdDJ2CgdEHMHDt03Yruv8LMkOFrDZi6D3UmR8B/LM=
X-Gm-Gg: AR+sD137SYL9kiq75RbWpVFgXHeu+CCAFgEDR32WXLUAs+lijBJNCsJmh46WNVjn5Sf
 kYMidIIV6Ohamr53sFCrnk6oF5Xi76raiGhKBR8K17CE10OjtZHiNVbUqp9qYePATfNMKu4YjvO
 rKPrh+7cWsMmwOdSsVtwk9Y394ufFpjWCXmRO/Zr7gaM3ocQZvcOX4T0zcFz6CZCm0i0yw90yF0
 RDhNd2s0IHmE52E24Hxm2KVV3rI2JJxR39h++wsR/cgsw7MjvVfdW4tbUzwMepDN7zOzxA+F/8i
 pfaBFj1qjRsHPUvpyk8kfSaKDMM0juPL6JLAX8MJOI+i+6ndk+6EgZzQQXGBVnYqOTT3Qa3oKh1
 2d8h/wV21CaBVWLMPD/IZ+TJQyHzXwouHn+i44CddLEIc/YbxW6UruIGpsbGFG1/y5TX8p609yt
 NswdPhwgQ1KzcypJ7PT1Sdy31Vy79w97wpfvnCgAszJi4yXhQb9wKD1zhK93a+T9M7vsaGUnRkQ
 tpS3zdy50LhrEA/CFr4YpZhi4HfVbJ+yb5NnwVIhg==
X-Received: by 2002:a05:6000:240a:b0:47f:8b9e:f44e with SMTP id
 ffacd0b85a97d-47fd2ab8b7emr4542716f8f.12.1785501643566; 
 Fri, 31 Jul 2026 05:40:43 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm4493682f8f.12.2026.07.31.05.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:40:43 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 16:40:02 +0400
Subject: [PATCH 3/6] disk: part_mac: Fix stack corruption on devices with
 large blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=alchark@flipper.net;
 h=from:subject:message-id; bh=bONJGmwssmvug9c40knriPAVM3crB7e5QFzr+B14Z40=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlTN/1m2nXxVmWRz5dKu+VjIvdktz579zq9Y0n3k/sf
 zH335Jnnh0TWRjEuBgsxRRZ5n5bYjvViG/WLg+PrzBzWJlAhkiLNDAAAQsDX25iXqmRjpGeqbah
 nqGRjrGOEQMXpwBMtfQzRoans/e7CsVk2yZImK+vefl2i0H84mUHp1of3ZOgm9ewSmErw//U09x
 cvd0SrGpRGtNPXFR+mJVXoZ4ZNyk/IqLi+uvKaD4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785501644; x=1786106444;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t8e6uICo1gYANlUHzZfyFg4zGETgBqrWuVdLeYOrffM=;
 b=Yxvk3L8P4SXj8ZMuylpw4JdszskvhGfuU7emnytvYd2zKpX94E+p9TTGI0lb3tktcj
 /0KudVe8YR45JSQTQTE/AxcyN62MMM64pLnZVEeOcHmLXA5MYYcsTMgYH0kFUOVO8skl
 zfLbmb8fsJ/RdVP1fgin96SCj86msR0YY0j3US3c3mFyKiYgg0Foui7OmBWkUb2+UTGt
 NLw+Qhemcx6l6xDIIpREMb5t0E16pEf7m3PJFiMZWHFRXGbNcPii0yFceqXcI+RVAfwM
 ouprCu9QfgKL878/qmpyVfEZrVm7Zb7UbkIaWIZKdWBxzzTTJk0guU1BvUZ6/a3eC9jn
 JTOg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Yxvk3L8P
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

part_test_mac(), part_print_mac() and part_get_info_mac() each declare a
single-block buffer sized after the descriptor struct:

	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);

Both structs are 512 bytes, but every blk_dread() below them asks for one
block, which transfers desc->blksz bytes. On a device with 4096-byte
logical blocks that writes 4096 bytes into a 512-byte on-stack buffer and
corrupts the stack.

part_test_mac() runs on every block device during partition probing, so on
sandbox with CONFIG_MAC_PARTITION=y this crashes on any access at all to a
device with large blocks, for instance:

	host bind 0 disk.img 4096
	part list host 0

Pad the buffers out to the block size with ALLOC_CACHE_ALIGN_BUFFER_PAD(),
which is what part_efi.c already does for its own block buffers.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 disk/part_mac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/disk/part_mac.c b/disk/part_mac.c
index dd3ce0be832b..f0afab65d755 100644
--- a/disk/part_mac.c
+++ b/disk/part_mac.c
@@ -37,8 +37,8 @@ static int part_mac_read_pdb(struct blk_desc *desc, int part,
  */
 static int part_test_mac(struct blk_desc *desc)
 {
-	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
-	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
 	ulong i, n;
 
 	if (part_mac_read_ddb(desc, ddesc)) {
@@ -64,8 +64,8 @@ static int part_test_mac(struct blk_desc *desc)
 static void part_print_mac(struct blk_desc *desc)
 {
 	ulong i, n;
-	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
-	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
 	ldiv_t mb, gb;
 
 	if (part_mac_read_ddb(desc, ddesc)) {
@@ -208,8 +208,8 @@ static int part_mac_read_pdb(struct blk_desc *desc, int part,
 static int part_get_info_mac(struct blk_desc *desc, int part,
 			     struct disk_partition *info)
 {
-	ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
-	ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
 
 	if (part_mac_read_ddb(desc, ddesc))
 		return -1;

-- 
2.54.0

