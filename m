Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896E606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZWFQqNDI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r4qvwb9P
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B42A816FA;
	Sat, 24 Oct 2026 12:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ltIJ8J2xpGwc; Sat, 24 Oct 2026 12:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 849508169A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844205;
	b=ix9VqEwozoCjm+i5rsmvDVOVZUOlMS/FQN1VpW0A/Eaz0eHv9MCSPQTuBJ0QN+X9qAag
	 85FYZP4CYs8SfxYsh2LEE60aTBVcM3FHf3pw5lVcgQ2GvUCFCrfoEAxfGNPvbteXoKNkq
	 pfCclek9IuZ/Q7SHS+ynH23N0DjNLpyoxSXGuiTmNIXhKzZiQuVK2iiNYr20GwhXrNnTn
	 FUjblQSEOvNq1qZdGL1VNo8FB++tdBpKLewH7fjgnMMNI0Jf4tJQKJawLuvFLcTHXhDjA
	 PcH3d4f0Mqho3n1jemEMEez/a+IoEAQu+RvglnM8XIngvsJ6y2n6roMf23Jqocs/hpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NYtKSVVgMVHYoKmAF9Ec96noqSieCtoElItZ0lpuFdQ=;
	b=YQPIjtPnY2DhD/w6wzLvmGnEB3nvAtzPOP7DIm4xZ0MFz6qjyWCkvTIjKLpXo+JIGmd0
	 uJ03KRBRbt/uao+9kXsY2b4sU2eCdf+iQSAjrTSwUzRx/4+yn2B1TiEgcRHjsVpqruFNF
	 DrUO8BXhGGLtalG8FKqvy6Me2EC6qCCD/iywh/reaYBgdKuWIbjhufBWC6o98zRicO8yH
	 iVkLy9/vUYyBevBJaNLw/0u1E5b9Ly3lzrXCc4c1zu2ePyNKBXWniY278BmTQ2GDCq1ou
	 DNiwjehQpeJgMjHbOztlGaZW5w/7PQCI/YEBecMhq4wki8EWXFlVD+Qm3163p4TNROQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r4qvwb9P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844205;
	bh=NYtKSVVgMVHYoKmAF9Ec96noqSieCtoElItZ0lpuFdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWFQqNDI1mRIr1f2LU0c57tjVel7qAjQuhGJIJyDa2+Sa/NmgbJO26EOE4QXA3Ofu
	 znDLQsfJwpa+jog5KAIHckI5fBSGFgp0wVN+ABje4/BMYUE98QfHpiZpF8o1nJC5R4
	 Jkdd9tNoGKEX7dK7aykdNltlBCUEhcewSy5603EkaB0yh5mdunfsKtrHcwu7/W8GWT
	 phQ8o3QzZydwQTPUUDLPAIt5y9Kw6LoOpUmMde4XhqzMminvqOXbUby/ELMOTwwT+m
	 l2uApPhnlEtgMcYvHnRhY0+BLN3FL5kyolYRYtTPXpVIllFn3IRKaiWUF0sT53kbZP
	 SCjmlhjVZP7CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 849508169A;
	Sat, 24 Oct 2026 12:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C949543
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB1778169A
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aca7q3c2Voc4 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:16:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E95881699
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844204;
 b=Oe7WJzMNkEe0ZPZqGht6inGqNB9GUlB/6/mChy86HaAjdvucK2QTGRvOSVF4ZzfYnaWY
 7Q9EzqZtErX3jjpSn+/wXdd9pCkibchCI4b9pYepQwa+GQJXrJ+7A1HGqw13d5+GjIK5+
 gZu4vszVBnDjnAmslps3DEEtn+cXlOldcK6ynhT5ovmOGmf/FM2urEe0wh9XpXExM3UQI
 LKqIcFuMnLFGA7BMfjTwBdmsAQmMUV6So9QTHjCuo3Vj4pd9OIONUDqobZJmIzAi3U0gG
 F6rWhv+njqLP3c+4s4hleeMs94m7OX99K53ekEqRGMiEIfC/gHc+4FVS6BSSJdNz7kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844204;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=NYtKSVVgMVHYoKmAF9Ec96noqSieCtoElItZ0lpuFdQ=;
 b=gMJmn7OqjEoj22A0aG/0r22nrS3mmqsixqVgx3C642FfvzIyaJ+QWuhODdI/UKDZ06f9
 2CM/LJHkLI2zrvNTwhtivRjovvv56mj3Also4x5+G0rm/G5wRauwyumSq5fiRyq8FanV4
 W+SskTRLOWfJHEmYTbNLo74Lc2rS2LkcK0uONSM6IzCtA+ehy5k1LLMGvlMr2u15BHVAg
 oJLc+mwmU3GoaEiF+ExjjXBoje9Ol9Totkx33MGGBS3plJYWKb4GLaFO+Oj7NIQjMA4T5
 xUGHyWI0XOj+mdHUXab51RIoOrpsgNiG+70zBP3WdGYcs+9VRtsAwttYbIfpvjNB7xg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=r4qvwb9P; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=r4qvwb9P
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E95881699
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:42 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so1423273f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844201; x=1793449001;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NYtKSVVgMVHYoKmAF9Ec96noqSieCtoElItZ0lpuFdQ=;
 b=r4qvwb9PvjcYWYHD7GLt8qKsF3T/UmNnK2eeYIe5rZqm638R+USw3ARbcS7Z/+d1fV
 UzGH5jrKPvMNpnQpz6FRexpx4kRaSpCP4sVfvwCz1eDXgwsT+GmoWCMluhIHbNUCgesF
 Kpk6Np8y1MZxPaROiacDOjFyEIZyMpieNFYjfdu+pYjwDSun009gnv2+uUWl/0Usk+Qi
 1UyWPOyvrLMZ5Hs7tC8jODfvt/WVONCQ0VD2ubUtYC7PVgA6r+JcODpsBNMC1EpwVt+7
 eMsIMqe8YMAYrOZt7jGVhhUyNXP7IdbduE86JPib7DlhHtjn9JspDPNq2bDzVnr5G5Z3
 hb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844201; x=1793449001;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NYtKSVVgMVHYoKmAF9Ec96noqSieCtoElItZ0lpuFdQ=;
 b=f86DqZFf7pv6AYrKIyxwI1cbhMg3Tij0hYJaukw1GJn8XY5QfkL9+tGOcI99fDMvtE
 ur7TF0nixins6H7yF3OWg/iFtWhemqFFEQj1Osx6wesXpQ1OHJ0/7nAa3N8BidN9Bh2A
 2O7wW5VRKlR1hkwxg8+WhsgB+wo9qJQ66ljCZIjrWWBMp/h5AebO7OM2CDPAvnQBjJ2o
 olfMAcVjhcTURKWOY2v817HqWb2ySbXJvRGEqPq+k6p2ZkN5FsLPqugaOOYsZOpZPPGj
 PmsovaAkjvqOHnBjWb4ArGHEUcd22hYSwFwMZbQaylP/wiiLc81DTizQonEyGIk+pBaf
 s0FA==
X-Gm-Message-State: AFq9FYKLJ94q8OlwM8wTtQAv1vy38YTF+6h3+w6c/v2/lIC8y6VF612G
 5TP0Idhf+50vHCJoUdyXY2aiE8YgoYkSV7NXfD5xz3eAwnQREYPukYZhEK4c8x0o
X-Gm-Gg: AYBFou2KulKKeFx3ckOukTUOjUTmPw+0YoPlt9sFWpwvJgYbukLnI2pjwVfi08EBQgJ
 XzzRxTEn/6GpQIbMdtUNmkqTjtVPd2dlLh5IvXBAZQt7SLMcAsBNQ2UDa9OQnMuhuXCqfePmKKm
 y2aBji79Qf5tXaVs4g+Tcte404H6kfqgwb8P44O8prtdCojsOpNzJEJM+WsDIDqZWThztN5AFKS
 tsZla4oxxlbjKoGFQosA2TmRGL82PbxZ1x8UbxpUGm9Ahl4hlZKyNkhRne3xvkq5cACyUJLbydo
 dHdwNLxIadmglCAS5a5RQyQm6XYbs7oeTkmGIWz3x7MZTv6btuMq976T1VzGU3Ba4FS9+ZJmLVM
 /AUVTsa57fV7KMjF2B37kIEX+kwpEK3Xnjo7pMdzYLtFDNyABXXKt3q4sSfYpD96uHy7pLNrWc7
 +gkWV/D3IoNGlRczOaUDGa+y76x87XzKAKRb6HzZgBBC0xZEBoRU0V5dTpcqJ45Xz0O0TCKKZMP
 F99xF0Rml8h8uUwVWVU1GcRb1Y+mhkzS/q19WN+wEPPo8PCF6fPBZM4PCtkldgMbhDcyKX9zeVq
 keM=
X-Received: by 2002:a05:6000:12cc:b0:48d:f02e:f7cc with SMTP id
 ffacd0b85a97d-48e3eb82c62mr1893407f8f.24.1792844200573; 
 Sat, 24 Oct 2026 05:16:40 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f37csm3301212f8f.8.2026.10.24.05.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:16:40 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 1/9] block: Refuse a device with an unsupported block
 size
Date: Sat, 24 Oct 2026 12:16:39 +0000
Message-ID: <26508a97-8a4b-4802-97e6-1df74a56ce3f@gmail.com>
In-Reply-To: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

A block driver sets blksz and log2blksz from what the device reports: the
READ CAPACITY reply of a USB stick or a SCSI disk, the LBA format of an
NVMe namespace, the sector size of a Xen backend. Apart from the virtio
block driver and the host command, nothing checks the value before
blk_post_probe() scans the device for partitions, yet the partition and
filesystem code relies on it:

- part_get_info_extended() and print_partition_extended() read one block
  into a buffer of blksz bytes and parse the partition table at offset
  0x1be, past the end of a block smaller than 512 bytes
- fs_devread() converts bytes to blocks with shifts by log2blksz, masks
  by blksz - 1 and divisions by blksz, which only agree when blksz is a
  power of two; with any other value it reads more bytes into the
  caller's buffer than the caller asked for
- buffers of blksz bytes go on the stack, so a block size in the
  gigabytes overruns it

Add blk_valid_blksz(), which accepts a power of two from 512 bytes up to
BLK_MAX_BLKSZ (64KiB, the largest logical block size Linux accepts), and
refuse to probe a block device whose block size it rejects, or whose
log2blksz does not match its blksz, before its partitions are scanned.
This covers every block driver in one place.

A device with neither a size nor a block size, which is how the SCSI
code leaves a removable drive without a medium, is still probed, but its
partitions are no longer scanned: part_test_dos() would otherwise parse
512 bytes of a zero-sized buffer.

Use the helper in the virtio block driver and the host command too, so
that they also refuse a block size above 64KiB.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 cmd/host.c                  |  6 +++---
 drivers/block/blk-uclass.c  | 15 ++++++++++++--
 drivers/virtio/virtio_blk.c |  3 +--
 include/blk.h               | 20 ++++++++++++++++++
 test/dm/blk.c               | 41 +++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/cmd/host.c b/cmd/host.c
index 51f2b1e3f6e..6a715bed39d 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -13,7 +13,6 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 #include <linux/errno.h>
-#include <linux/log2.h>
 
 static int do_host_load(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
@@ -67,8 +66,9 @@ static int do_host_bind(struct cmd_tbl *cmdtp, int flag, int argc,
 	file = argv[1];
 	if (argc > 2) {
 		blksz = dectoul(argv[2], NULL);
-		if (blksz < DEFAULT_BLKSZ || !is_power_of_2(blksz)) {
-			printf("blksz must be >= 512 and power of 2\n");
+		if (!blk_valid_blksz(blksz)) {
+			printf("blksz must be a power of 2 from %d to %d\n",
+			       DEFAULT_BLKSZ, BLK_MAX_BLKSZ);
 			return CMD_RET_FAILURE;
 		}
 	}
diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 6d2161cfc7b..d7b946f2dbc 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -828,9 +828,20 @@ static int part_create_block_devices(struct udevice *blk_dev)
 
 static int blk_post_probe(struct udevice *dev)
 {
-	if (CONFIG_IS_ENABLED(PARTITIONS) && blk_enabled()) {
-		struct blk_desc *desc = dev_get_uclass_plat(dev);
+	struct blk_desc *desc = dev_get_uclass_plat(dev);
+
+	/* A removable device without a medium has no size yet */
+	if (!desc->blksz && !desc->lba)
+		return 0;
+
+	if (!blk_valid_blksz(desc->blksz) ||
+	    desc->log2blksz != LOG2(desc->blksz)) {
+		log_err("%s: unsupported block size %lu (log2 %d)\n",
+			dev->name, desc->blksz, desc->log2blksz);
+		return -EINVAL;
+	}
 
+	if (CONFIG_IS_ENABLED(PARTITIONS) && blk_enabled()) {
 		part_init(desc);
 
 		if (desc->part_type != PART_TYPE_UNKNOWN &&
diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 404d9140cb2..98bfc8369cc 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -12,7 +12,6 @@
 #include <virtio_types.h>
 #include <virtio.h>
 #include <virtio_ring.h>
-#include <linux/log2.h>
 #include <linux/err.h>
 #include "virtio_blk.h"
 #include <malloc.h>
@@ -263,7 +262,7 @@ static int virtio_blk_probe(struct udevice *dev)
 	if (virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
 		virtio_cread(dev, struct virtio_blk_config, blk_size, &blk_size);
 		desc->blksz = blk_size;
-		if (!is_power_of_2(blk_size) || desc->blksz < 512)
+		if (!blk_valid_blksz(blk_size))
 			return -EIO;
 	} else {
 		desc->blksz = 512;
diff --git a/include/blk.h b/include/blk.h
index 2cb9cb31ac2..d7efb6012ee 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -10,6 +10,7 @@
 #include <bouncebuf.h>
 #include <dm/uclass-id.h>
 #include <efi.h>
+#include <linux/sizes.h>
 
 #ifdef CONFIG_SYS_64BIT_LBA
 typedef uint64_t lbaint_t;
@@ -22,9 +23,28 @@ typedef ulong lbaint_t;
 #define LBAFU "%" LBAFlength "u"
 
 #define DEFAULT_BLKSZ		512
+/* Largest block size supported, as in Linux */
+#define BLK_MAX_BLKSZ		SZ_64K
 
 struct udevice;
 
+/**
+ * blk_valid_blksz() - Check that a block size is supported
+ *
+ * The block, partition and filesystem code size buffers by the block size,
+ * expect a block to hold at least a 512-byte boot sector and convert between
+ * bytes and blocks with log2(block size), so a device is only usable with a
+ * block size that is a power of two from DEFAULT_BLKSZ to BLK_MAX_BLKSZ.
+ *
+ * @blksz: Block size in bytes
+ * Return: true if @blksz is supported, false if not
+ */
+static inline bool blk_valid_blksz(unsigned long blksz)
+{
+	return blksz >= DEFAULT_BLKSZ && blksz <= BLK_MAX_BLKSZ &&
+	       !(blksz & (blksz - 1));
+}
+
 static inline bool blk_enabled(void)
 {
 	return CONFIG_IS_ENABLED(BLK) || IS_ENABLED(CONFIG_SPL_LEGACY_BLOCK);
diff --git a/test/dm/blk.c b/test/dm/blk.c
index f67869107da..80441f723c7 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -9,6 +9,7 @@
 #include <sandbox_host.h>
 #include <usb.h>
 #include <asm/state.h>
+#include <dm/device-internal.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -113,6 +114,46 @@ static int dm_test_blk_find(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_blk_find, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test that a block device with an unsupported block size is refused */
+static int dm_test_blk_blksz(struct unit_test_state *uts)
+{
+	static const ulong good[] = { DEFAULT_BLKSZ, SZ_4K, BLK_MAX_BLKSZ };
+	static const ulong bad[] = { 256, 520, 3 * DEFAULT_BLKSZ,
+				     2 * BLK_MAX_BLKSZ };
+	struct udevice *blk, *dev;
+	struct blk_desc *desc;
+	char label[10];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(good); i++) {
+		snprintf(label, sizeof(label), "good%d", i);
+		ut_assertok(host_create_device(label, false, good[i], &dev));
+		ut_assertok(blk_get_from_parent(dev, &blk));
+		desc = dev_get_uclass_plat(blk);
+		ut_asserteq(good[i], desc->blksz);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(bad); i++) {
+		snprintf(label, sizeof(label), "bad%d", i);
+		ut_assertok(host_create_device(label, false, bad[i], &dev));
+		ut_asserteq(-EINVAL, blk_get_from_parent(dev, &blk));
+	}
+
+	/* A device without a medium has no block size yet */
+	ut_assertok(host_create_device("none", false, 0, &dev));
+	ut_assertok(blk_get_from_parent(dev, &blk));
+
+	/* The block size and its log2 must agree */
+	ut_assertok(host_create_device("log2", false, DEFAULT_BLKSZ, &dev));
+	ut_assertok(blk_find_from_parent(dev, &blk));
+	desc = dev_get_uclass_plat(blk);
+	desc->log2blksz = 10;
+	ut_asserteq(-EINVAL, device_probe(blk));
+
+	return 0;
+}
+DM_TEST(dm_test_blk_blksz, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* Test that block device numbering works as expected */
 static int dm_test_blk_devnum(struct unit_test_state *uts)
 {
