Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p5aPCWEi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNKcQZOC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73FAE60780;
	Wed, 28 Oct 2026 05:51:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NzUbXBBTv1YL; Wed, 28 Oct 2026 05:51:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8EBA56073C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166710;
	b=mFzxUX2WXLe58uu1sYZIvYQ1FbXQmHMJO5Zc/+doS/b1xziwfKkM4IjBRnnVcUO2IJoA
	 tU2PazLWiabpF/a8dQm1OUDE8e4Qi7ve4TY1u+DRIARP7+dp5LaW+5vOK/3kvPnAQT9dJ
	 6frh5ahkNamYf2c0bBnhIDcAoo7+dkRHuH/ZeKbOTA2B5NWDQIq9Rg2eGXnR3eJRyTsqh
	 bWIy1tfQ5aMSlHDXUDg9ifAaRmYIDQfj5eMCt0r5uzIfB+NgqJ1s/N4sXCybxHCly9YU1
	 TjKv8206AGdNFshMDQxZWwjUyQ14WgQH0f/FzdL90nm7vqbPRolZYiEysZeb07m15rQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bSpPbcJszOo8ok1JhORSxVwhS+IaxOmBC5Gg+HOl9IU=;
	b=eCGNg3ru7jEE2v/Y74x6uuiUUopkTNMVrwntzvBYVKITZ9ADdYfbP2s8xcGKYTWIoj24
	 OZMapbGtQJBQQAjU7r5axnJTY0twRESjudoOdWHqcDCqPpSMYQL3RCKgSxxsikFaB6Kkc
	 fU3xWPWluH5h0svE17qze5cJ/lEsu+P1wqj+CcBAYuUq8GAZtKdAaFDx16nEOecdHIIMF
	 PxwTJf/vOZKl0CyeVCIPcyN4icEbtpLU8fZY5q2Yul1+3MMPnXh4X/jDNYG5jL7z660CG
	 /JOd5MxeEgN/DSkkViFaiFJjBQq+JvOZOhpwY7YgL339SNkd3vY3oGwVscweV4sS3xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166710;
	bh=bSpPbcJszOo8ok1JhORSxVwhS+IaxOmBC5Gg+HOl9IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p5aPCWEiysrCgAI1Tg/tnHr+t7AWC4g1XpIw+FO4U8BsLqk0ttNgKtmT6HsCx4vnp
	 mcB46wV9ymm8rvL64w6tqOFkLOOxfuamY4CSSPYne+T1U/FBnHfRgxKOpK92VQVBhF
	 J8pL21Oetui75yYwmattoG0GoGoexM06cN+htyUg53vhp+PaviRvBARpcX8+peBTuZ
	 Jv5s+5tLKcy9H/X7JfJzB8wtshY2Wc+ySWHG5ZWJgVomzCxdDgg25Cp+sT+dj8NQLO
	 Dg5Hk2JZ2nTQh3wY/dUHnFBD2eDH6ccXpVzUElzcasihlUIwkr+QUJ4P1Yw8wfxM7X
	 l3E38LCh16ytA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EBA56073C;
	Wed, 28 Oct 2026 05:51:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 873472E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7810680FB4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kg7R9RWet-LN for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6949580DB3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166708;
 b=I27xjyjIP2Sz2KgZdelN0zY5gSZDzU3FpxYOZea2PZ8fjhw6nd6Pt3xRPW109xvinYy0
 3ZcbJHerpsotbKI+GPjVHzfuBLh2VHgj3DhS3B46vHdS7RaC3ODIL2dOz0CPixJN2wzbQ
 ATtKpuYhTuN0+n3b9pL1qRzXNH59vcv5kfyL5JJWFS+ZFGZiX9zp0hrBzK9LllF3ylFHG
 eA8/lOAl2O94oSR3pcAFcomLnNDbhyP0/jOfagIHzMpP9WcEbG9A4NDNfX2Wo7jazvj1w
 2Xbu+WllELfoBedkKL7Dd9L2vB/vntS0SD8pqDIusV4voLA3A9t/NVzozQz4sWfVVjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166708;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=bSpPbcJszOo8ok1JhORSxVwhS+IaxOmBC5Gg+HOl9IU=;
 b=cOK6WH82kj6uEI7p56zUdLcv9uTKAsXCDyg8n18s83yG0qhn8vlkCWtCvO8aXglaSEfK
 JWy4412w8AxcwHc9My6QVO/ZZH/nLN2N8G9QE9yEy4zjDlQoNaPrkk3gTVIF/yobT4fwr
 /OoBkRIScZaBzXidBYvrXDnJ3uQrnAQgyqczSMitClGl+giehQ6s8FIYz+cXwCKrIsCU+
 zQws62WxTNoNy/q75aykNIulHMmJ3I9VO1NcsMrMaHo4dqj1oMGQssuzkS0uJ6K2SNhLO
 M+FXLt51ZqFdHpzKV2l1wWHRIyG3t9H3AIZasUGTJOOFfifWezDckr/goTi83Gglvkg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kNKcQZOC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=kNKcQZOC
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6949580DB3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:48 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so4820725e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166706; x=1793771506;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bSpPbcJszOo8ok1JhORSxVwhS+IaxOmBC5Gg+HOl9IU=;
 b=kNKcQZOCFX4B5CV4m2ladJQqXnNnNEJuaJN7EcopsoIwgl9jC56drG9GLZ/phsZAVI
 QO6Oy4YwCxCv1NwQH1VE7xZvDDBP643VKLjRZR3DP9Dff6HhhK42eNQ02IaOai+23m6G
 FmTjynXucbThl0ZRebA8hYbfg5JUWKO76ZQ7z2BuPqxycjLlVjTgYpqBWug7lOzKZiLt
 dFggExMP5jeyQ2l3ei7OhJBrkFggpTlWYzQeqtBgR/1/FTj3p1Oz6irEkGvuFZEeyza7
 8qFrWhAESg+s67ALjDQSm0QgbN2LoIbikPA8gQFZJlcuAY3w03HgcreA5xG+udwIT4yD
 GbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166706; x=1793771506;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bSpPbcJszOo8ok1JhORSxVwhS+IaxOmBC5Gg+HOl9IU=;
 b=gAjyOKFyii3klW5QMIDGv2bJboI/xhMe7G9SIaaZyveH95l9f4X1pZEomkByjndB9B
 8HAmUjLp25Ygj2tDHuPWUXszLrTmlGZukdm/ekOqRXDamqYiDLbJAIYpKR3BM5QUxtLZ
 uMw1LbcBOOx/V0sJc9Ets4XvXdrTIyizRq120KlecN1dupxroH2IYPk5L/jcw1s90dn3
 mFP+6LUDJv7/0f8XUBY0HX0fucxiyx2FlBn3HnfIoVxm40oJHPPi6rpnKYiJvVaPTwQb
 M9BlKe4TszQ/Q/6ci4VfrnV2/AywMWWLiDWmeHwgMIfH6fyR+TDwAEUcSefdqDzOUqib
 ZFnw==
X-Gm-Message-State: AFq9FYLSCOOebOFKN6e8+P3mHQS2BPAnK637JAIgBRBce7mG8Sq4KDNd
 a+Fu7PmtWzXkr/8r89PisJQsP/7c5/DutyebZ7zUkcRAz0iJ+CMPbk3JJnS9kfWX1XQ=
X-Gm-Gg: AYBFou079klD+E0THERS0hrN9HmJJeK6uHO+4AxdIvFwgQuVrrHuL7hoW0XZkTWG11E
 hag0dhQX3b2NaGDWc8lGGNOni5s1V1sSz8yuzQrSGrWzOokuwmW5vIn/2mvjpHf0yqEo54aboGP
 Se+JqUAz4m44gv0zWmZ/JYgSpdAKtwKM7m9XGn/IQpEVmFJWKjP5GXH0otsx6+Lhw0RlMBjYYfx
 wBVuH1oZPWpQLrmhO8lVkmeA7kCB6szhr0QgN4vo65Gg44CY3zCnCSCWDK39qOLQpM+4Sn/S/e+
 q+ptqCWSp3AFe/NHu0NovmHPvsqTYLWBPPY/RiTN6X2bpQaod/Ya3aBs7O/zvfBClB2Xle9l8bA
 jiucVUL/E11lJVyw6kgVq759yURlhYmTvH7Xxh9lwsItTYF0El6wkd0hVcRuBbuW5WxRkKrfFId
 9E/FcXiGNOYKfevS+4M2IPTFkNIuVtuF98sL+VHNu3zpe23faRfzq4dAPL/pZr8hPNJRIbg1Ve9
 eXQZFaDQVuEurUBDoBE1wZMXLj4tGherPSPrTAHc+QdTB8KQTm+1MLyPGshLCdCc50bTLmGvxV3
 WGqz24kiMDik5pZ9A+xD6D4bveJ4VqE=
X-Received: by 2002:a05:600c:1d1a:b0:4a1:f90d:6f4c with SMTP id
 5b1f17b1804b1-4a966c41c98mr22109635e9.7.1793166706244; 
 Tue, 27 Oct 2026 22:51:46 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a976010ca7sm20521375e9.1.2026.10.27.22.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:45 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 08/12] block: Refuse a device with an unsupported block size
Date: Wed, 28 Oct 2026 05:51:44 +0000
Message-ID: <3a36c968-146d-4471-84c0-6673337aa4a2@gmail.com>
In-Reply-To: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

blk_post_probe() scans a block device for partitions with the block size
its driver set from what the device reports, and nothing checks it in
between. The USB storage, SCSI, IDE, NVMe and virtio block drivers and the
host command now check it where they read it, but other drivers do not,
such as the Xen PV block driver, and the partition and filesystem code
relies on it, as the patch adding blk_valid_blksz() describes.

Refuse to probe a block device whose block size blk_valid_blksz()
rejects, or whose log2blksz does not match its blksz, before its
partitions are scanned. This covers every block driver in one place
when its device is probed.

The check does not depend on PARTITIONS, since the filesystem code and
raw reads rely on the block size too. It is left out of SPL and TPL,
though: there it adds some 180 bytes, which takes the SPL of imx28_btt3
and popmetal-rk3288 over their size limits, and its message needs a
putc() that the SPL of evb-rk3036 does not have. In SPL the USB storage,
SCSI, IDE, NVMe and virtio block drivers still check the block size
where they read it.

A device with neither a size nor a block size, which is how the SCSI
code leaves a removable drive without a medium, is still probed, but
outside SPL and TPL its partitions are no longer scanned: part_test_dos()
could otherwise parse 512 bytes of a zero-sized buffer.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- Split out of v1 patch 1 and moved after the driver patches, so that
  each step is bisectable (Simon)
- Leave the check out of SPL and TPL, and say why in the commit message,
  along with why it is outside the PARTITIONS condition (Simon). On the
  code size: in SPL the v1 check and its message added 184 bytes to
  imx28_btt3, taking it over its SPL size limit, and 176 bytes to
  popmetal-rk3288, over its limit too, and the SPL of evb-rk3036 no
  longer linked (its tiny printf has no putc()). With the check left
  out, the SPL of these boards is the same size as without the series

 drivers/block/blk-uclass.c | 15 ++++++++++++++
 test/dm/blk.c              | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 37d87be3a57..0c45a57f75f 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -828,6 +828,21 @@ static int part_create_block_devices(struct udevice *blk_dev)
 
 static int blk_post_probe(struct udevice *dev)
 {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		struct blk_desc *desc = dev_get_uclass_plat(dev);
+
+		/* A removable device without a medium has no size yet */
+		if (!desc->blksz && !desc->lba)
+			return 0;
+
+		if (!blk_valid_blksz(desc->blksz) ||
+		    desc->log2blksz != LOG2(desc->blksz)) {
+			log_err("%s: unsupported block size %lu (log2 %d)\n",
+				dev->name, desc->blksz, desc->log2blksz);
+			return -EINVAL;
+		}
+	}
+
 	if (CONFIG_IS_ENABLED(PARTITIONS) && blk_enabled()) {
 		struct blk_desc *desc = dev_get_uclass_plat(dev);
 
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
