Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDA606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F4ZmYuXa;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yx5fm/xL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF44B60AA8;
	Sat, 24 Oct 2026 12:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mse9wF4ICJo; Sat, 24 Oct 2026 12:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D5AA60A98
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844222;
	b=ALYlOllTcogAicC+i49Y2K2Js/46LtloYPUlHpZm5A8/1nAkUiA/mKCsYQaKxUfbzDvX
	 GsB3pqK5Ev9NyFx1KpqHEWuj/CcX84RLx2+qJp6Eok4TpTSbBmQA4eMjKjNAFiPuwi1/B
	 vYDajaqf0ZD/bG4uIKaciV/DKMQ6J1yX2jApo/wBPqkbxHf3MhrYl3MHEXTg0pHvP46KW
	 GU+EUel5uYzAVEalGOMYMfFaqICvInaLPOdtaoPOtMg6Tx4FQhGO9EajHtYGsB0m8nFPE
	 Gy/utLeGQE1AGAsMe3vpJ8QcEpgAp2zjZaVQkqZtjY18b3joG3yhBpHhxpsz8+91Z4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844222;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iTx/LhkTmAvw90ee29M8kBg8Gc3+0j8nsWg/jr0HTYk=;
	b=htIpHN7SQxhMT+vr0GYZVuAXgiGHZtPssFa7BMkORaZt/aN+6sVsiRktxb0NHZvXvMt+
	 Gnk3V1DaHKCi1rN5u+Gl1SWOyLC8vXQJd4wlVhij348FB5zUJXWT+fgnPbxdMAeutT6uu
	 ED9OqSWEDhPPOt5RCOmhQ21AIInTRXKVeerOimTDvMvIQ5Kz/mD+CmLq02c03zO9Ac9/S
	 ElqtkdMq4FzoLsQvn4/PRWVpZh6gw97gwmlcpwNE36yObirDirCUIPEgFQKZuULeDUkDY
	 NEtea8oEZ6zqiBnzzRNxd7ohpOI5LnepRgneeDr7Io1bRweOVk4mVxZNrEpCQwtQsmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Yx5fm/xL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844222;
	bh=iTx/LhkTmAvw90ee29M8kBg8Gc3+0j8nsWg/jr0HTYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F4ZmYuXa6UGPY+hfe+o1X4kHCyXFU4ElSsfdpmc0iz/jJphS1hLXE4HoeqcuT2nUV
	 J91ThyfjgRw3N/6HxH32JE09xg5X3HxYg0IV1AEFA73jO+Pw9k7yfRWOPziDIbVo14
	 KZxh1KnEb3rbpHFD27+bw2D1RNkMw/cvm9sE2HjLGpvzqFgMiT+L9Ip78nK6XmB12J
	 cwv1PJWFHt3qPGWeey+M57vP32QwfQAIu6M5RV35M7WOmRNj2UjqLccZAotelXbZoh
	 WBgPyTWVJ/khICJQedbW7c71Y9gshFZ2OFw5Mj58rtdchgehVpghQ5eZzXFFnao36K
	 MuA0DhbLd3dFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D5AA60A98;
	Sat, 24 Oct 2026 12:17:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FE5B765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F77060AB0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2NY40FGA7QAt for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 473C86073E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844218;
 b=k09xaITz1sgKIDdDi1iYwSBAkBo8i5PsLPF3a5RvVvFsk3YE5ftAv7TsU7FAdzpNj/SU
 KGL3L1ad0s2WwxEu6RF5/ME19QSrNBXACnNxK2KokAwaE0rgzLu0g1WS8+uEvXhVRyFKq
 t/MGJpA7Wo1bDcdhTvXfoeHHzWMs9b4lMSLdIyd5xLZXRiU+EhVNdpI6yaNhXUmAEg2qS
 4nQBa6PR1FJq0cGHrckGXjO8lb2vRdq8BxYP9jZlY8+KwypQdfNW6QIrkAJ9LlMFMvxIo
 yx5l/1QhpolG3loov14wOqeAE2iKHIXK5W8NH71PN9/QnQG9mgJThYwrQpQ65lMoO6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844218;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=iTx/LhkTmAvw90ee29M8kBg8Gc3+0j8nsWg/jr0HTYk=;
 b=VSvmM/N0ER1ZpZHTX3+4HpxD9ccS4gn1uV297p2g/cuHHC/7yFt6/0CTNWbnQlSrj+Cd
 6dxZE4qe3Z+SMyycySUmYh5Kue2cUipYk4tcgNKpfL/5Bff8y3OyTEPI0VMy0wdztYkX+
 Xi7e7q9z0AFUm7sfyvROS1eWZOEbMGcziXr4sGYpxX3g9d5O/BxMfMaJlYMZlD0kbPrJi
 eL4/bhU8ohEY1ukwXD3aVXnbNwBKu8uCFOfdCHFy/v2EAYBS9q6vBWFrXwE7JHiyo8yzf
 5pY4B17LvvDTD9gAGMok6yFMefV2jxTH+9D/brI4QQQbU0693CqIlEBaJYldxSpEKiA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Yx5fm/xL"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Yx5fm/xL
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 473C86073E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:16:57 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso1308440f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844216; x=1793449016;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iTx/LhkTmAvw90ee29M8kBg8Gc3+0j8nsWg/jr0HTYk=;
 b=Yx5fm/xLiZHPb4cuSX/GZ47CP+9E1ayo3B6U1w+wNBuSPCyQBaA1lLDV0BIiMBdSPa
 UwFK3dRS5zGoDJDXYn6qDYujrr1aZvMBngwnZ1Fv+cucLsNXHkIxE9/f2iN679shf/K0
 pGo11fpKtrknOAUmGPHP/TGZFpBuPLwdcYddAncSVMJOg4UCLFI8oiZvPLUEDMnKAdIz
 mr2heowCYY+WSRTE9417NyQewk0+aQqipHD6sT3x4cWKokP6Hs3WNfodfTDUsaHvuJlV
 evUByJNIEVhj0hV4IUH3YHj8Max1BRykY6+dkdYk9PdauydnfRcNUilluotP17cFJRH7
 C4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844216; x=1793449016;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTx/LhkTmAvw90ee29M8kBg8Gc3+0j8nsWg/jr0HTYk=;
 b=tNyRiVBOu7kXT+YuQFw88muoAaLunzPgaWL3zztghhsbkLnqpUnLDtmRIoINMfbivQ
 jfJ7eSsx83BZui0E52s9mvyqEcCaql8YuPPKha8PFNlmdtue6SwX26td4CYYvMVHBDrJ
 ICxkBB3rOQHaeZWW43l2p+JAhYofkiDW6K69hNEQiCnoc7t89TEZMI/FRRfN2kqakegz
 nZzcstozjvuYtmwN8EtxBPILJNZ3MAukaXANAbLgDTUNei5JR1aW/upR1JUB+WlOaUYO
 sJu7+IlNRolwNGDMbawr9iJoI9EO+HyW+OZ1wqnatGd67HF8hSuMx+hoOyAAEw9oXSHK
 qMUg==
X-Gm-Message-State: AFq9FYImzh28kdzou6q6SmaOuy31HdnJxmVPzA42ApyUug83ThVLT2uo
 D1vBBdjmswrnpb1f+UYTnlYir40yl8KVFzgJGRPX4vLe6738H2OoDyM5wC549GEf
X-Gm-Gg: AYBFou3kvGB7Ul+ZcoCxON+2HKbUHqfAfsjX+aS4EVOCHbYnpsSaxgloMhyNd7/7J33
 ZSQ4jAKBnxAxBLYeuSQJ7dLwCHJGdLsgp69BYSx2+eLNFdb9Zl1P3IQXgdpJkk7TpncHgIUcGrc
 S/94CZodakyYL5ZraDs7GGuq952EOkASeBfXTlpN+v5yShWxpYfUj2Yt0oW+LB75PBCQqHUvFKS
 1C0rExRud4gKCGTZunC++qdrFQob9WTNGD+Uwbg4foXZ55iV1O5XLrDnRhYrDD71YXTPCGDWTDQ
 MGBF+tlvOz/Axjm+cHowHqMf2OtQ2KvWH2Vcht9Pw75knKjCVLOFura06ubabkpwzOnRlZxbRsq
 JC8WKm/UqMmxB2lmyYGzLMtjBQiKU/TY9BWa+4PfD0MHvUfxenxvhHfFJy7JAZc7xzZ6WcHpDlc
 YgTyKI9YgPrG4eJRNfXgHwPgB2l++ZkjFXgnKV5dFmGEu/VB7lpgO3+FJShcNYPn7O6z+oKbxBc
 qIogRKPwSmCtvkhlZOw0tooz2kUZL1yByDWchsEZAOWY26UK9mWUaxR3A==
X-Received: by 2002:a05:6000:188b:b0:48d:fdc0:65be with SMTP id
 ffacd0b85a97d-48e3eb7bb6bmr2914740f8f.38.1792844215701; 
 Sat, 24 Oct 2026 05:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3da7sm4021465f8f.20.2026.10.24.05.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:16:55 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 3/9] scsi: Refuse a block size the block layer cannot
 use
Date: Sat, 24 Oct 2026 12:16:54 +0000
Message-ID: <a4bf891c-985b-4828-8cbd-9fae1c8bf00c@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

scsi_detect_dev() takes the block size from the READ CAPACITY reply of
the device as it is. do_scsi_scan_one() then hands it to
blk_create_devicef() as an int, which drops the upper bits of the
unsigned long, so the block layer may not even see the value the device
reported.

Check the block size where it is read, so that no block device is
created for a disk reporting one that blk_valid_blksz() rejects.

Add a test where the sandbox SCSI disk reports an unsupported block
size.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 arch/sandbox/include/asm/test.h | 10 +++++++++
 drivers/scsi/sandbox_scsi.c     |  8 +++++++
 drivers/scsi/scsi.c             |  4 ++++
 test/dm/scsi.c                  | 37 +++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index e5590d01a92..76e2f11b059 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -133,6 +133,16 @@ int sandbox_usb_keyb_add_string(struct udevice *dev, const char *str);
  */
 void sandbox_flash_set_block_size(struct udevice *dev, int block_size);
 
+/**
+ * sandbox_scsi_set_block_size() - Set the block size a SCSI disk reports
+ *
+ * @dev:	Sandbox SCSI controller
+ * @block_size:	Block size in bytes
+ *
+ * The host reads it when it next scans the bus.
+ */
+void sandbox_scsi_set_block_size(struct udevice *dev, int block_size);
+
 /**
  * sandbox_osd_get_mem() - get the internal memory of a sandbox OSD
  *
diff --git a/drivers/scsi/sandbox_scsi.c b/drivers/scsi/sandbox_scsi.c
index 5f0b01d86d5..34fc7cda915 100644
--- a/drivers/scsi/sandbox_scsi.c
+++ b/drivers/scsi/sandbox_scsi.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <scsi.h>
 #include <scsi_emul.h>
+#include <asm/test.h>
 
 enum {
 	SANDBOX_SCSI_BLOCK_LEN		= 512,
@@ -118,6 +119,13 @@ static int sandbox_scsi_probe(struct udevice *dev)
 	return 0;
 }
 
+void sandbox_scsi_set_block_size(struct udevice *dev, int block_size)
+{
+	struct sandbox_scsi_priv *priv = dev_get_priv(dev);
+
+	priv->eminfo.block_size = block_size;
+}
+
 static int sandbox_scsi_remove(struct udevice *dev)
 {
 	struct sandbox_scsi_priv *priv = dev_get_priv(dev);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 50e7d749921..a732db726ac 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -543,6 +543,10 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 		scsi_print_error(pccb);
 		return -EINVAL;
 	}
+	if (!blk_valid_blksz(blksz)) {
+		printf("Unsupported block size %lu\n", blksz);
+		return -EINVAL;
+	}
 	dev_desc->lba = capacity;
 	dev_desc->blksz = blksz;
 	dev_desc->log2blksz = LOG2(dev_desc->blksz);
diff --git a/test/dm/scsi.c b/test/dm/scsi.c
index 66859c991df..7617ee54893 100644
--- a/test/dm/scsi.c
+++ b/test/dm/scsi.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <part.h>
 #include <scsi.h>
+#include <asm/test.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -36,3 +37,39 @@ static int dm_test_scsi_base(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_scsi_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test that a disk reporting an unsupported block size is refused */
+static int dm_test_scsi_blksz(struct unit_test_state *uts)
+{
+	static const struct {
+		int blksz;
+		bool ok;
+	} cases[] = {
+		{ 256, false },
+		{ 520, false },
+		{ 2 * BLK_MAX_BLKSZ, false },
+		{ SZ_4K, true },
+	};
+	struct udevice *dev, *blk;
+	struct blk_desc *desc;
+	int i, ret;
+
+	ut_assertok(uclass_first_device_err(UCLASS_SCSI, &dev));
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		sandbox_scsi_set_block_size(dev, cases[i].blksz);
+		ut_assertok(scsi_scan(false));
+
+		ret = device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk);
+		if (!cases[i].ok) {
+			ut_asserteq(-ENODEV, ret);
+			continue;
+		}
+		ut_assertok(ret);
+		desc = dev_get_uclass_plat(blk);
+		ut_asserteq(cases[i].blksz, desc->blksz);
+	}
+
+	return 0;
+}
+DM_TEST(dm_test_scsi_blksz, UTF_SCAN_PDATA | UTF_SCAN_FDT);
