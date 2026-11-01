Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A31606A326
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0zAP9v13;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJWS+fNo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBA0F6080B;
	Sun,  1 Nov 2026 07:02:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IolnpNBxN6z2; Sun,  1 Nov 2026 07:02:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1905607EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516533;
	b=m7fe3pSJ/hDFvDdnJbetICZ4bRkazgUx5oxN2Mu2DEMoabfV13lqi4fE3TkgzpuFVu2d
	 yKpW9oyUF70xznuadT2hwEwRi36NYuZezT6NFWvLbxivDYloPX0OEcLVpWl+/wzqCV7cg
	 /nJz5iV/8Vwd/qnDRzhIjWFpgfLGMjnn5V1raLWZrQf2p0FzsNyD1wrBnpeNGzm538BAT
	 3ucnED1IIJadmEt/EJtR8hEr9ZLIczzXy5MOSAS3UMtXc5s5ALxm2fIHNS/MKvny4K9V7
	 jhH62LEzQCdOZJUK1yaqH4jlZa8k+2doqUJtfd4XG9BAdl1v03h8b0fOInJqWQtwnaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
	b=ToCz0uCK76VV9p3maTALP8bDr12EJJTvVRvft7EU3/kj/M6j6ZeypZXBc8Il8LJV/ka4
	 7/QtNEmqB3bHMQsSc+tJKamm+PMA7WirrIHAUDMxO/0KpuSew8U9ukLHolWEeDhyC5uKi
	 iww6aMph+7F309zBFpttKP9CwQmVMC7bLZrrEcPN7cfhRBC72lHKg+L2fxGF/Khdt+LtJ
	 7Zez7KBwWv7xwlH/yec92RCiWmdCDGFiYnCQnVOCrWaYyxvdUKV0pCM2J4t62A/FW5644
	 GxQgwuDDW3O+pOo8N7j/lxYrJRiXNMCCUJ9bNwzjCqBUlqIrkt+IBf8eKgMgbHqCrng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516533;
	bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0zAP9v1389iv2a0Z8/gDLksV3Oos6DtAA7+mtY1SlIz+HC4PVizBs7ygfIsLkXLcX
	 0iW2PRu0/UMKfgNxy2CLTI8k6qiH6etdB/XyqWJeLhG5VAf1w/LZgIkOZNyZdvCWBb
	 66huzaHMzQA0UiQoAw1i7uAlXgIDWkkfPvJFU0esDjUxAU+Ba5qyAS9VDcPYK63W7F
	 OhT/72h/ue6TvInCkFSAACgMIDCrJD1nJq4jyygagayJvM6PemVaLQYHHvy2WclafM
	 9/8kItLrqvZoMNPLhf1Ayb2FDogCBCDlyJl/oXCPoih0QK5y4vNRUYIveW4fLjY9tt
	 a3NRmTuJi/urg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1905607EB;
	Sun,  1 Nov 2026 07:02:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C9D31D3A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6E75407CF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McaM_a2XRF2f for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:02:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0660407C7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516531;
 b=jEY9jhjwho1p1wqkg57KPZijUeuSqEwq1Z8udtUeXouFwpkjwsb3jEb5SNsyIgx81DfO
 2bmcVB0Qr6OgpSoKAKpdQoFpor1pXw5P28+jFy8/F/GUmIc0HmyISwmVdpz7ETNb5q85M
 UmbDdjcBexl1Cee9aEowPuFn1XBcLrQrVNve8bI3Lt2ETsMKdx1yiKJjk4l0FcQnqUiG3
 6TntkzkoqLe0AeNvtDJnrdIy6Qjw5x6ZsUu15MdjyNMJSPXQVepFfcXfLTAfIRgLv9ImU
 DyzqtU/7Nhap/Yg6bzYyjj9mAhtGyufEXvEXG2C1MXGqiXB+FriiYHC9CFfKecKgR8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516531;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
 b=k9ROraVp3SYdaXWB5djbMVexhMUxGWHRAMYwuJhC+UIWAd6npG8RSEJpu+y4oYGstbHn
 9Xs1+MYFRSsAwkOl/6pWsxF5Oje0ESluDfnavWhlB6dtkp1eIiT0nvPEu+9EAvp6QFHRC
 e6WRm3HOlZS4TINvykwoPvAFEh68IA99PxCCP1tomcUg/4JMu6MQmActnXpx2oZq+l05G
 DmcxuNm96Ymf0pLMaT2Lnhs6RdOZf5pS5kI9N02F+SpXyaWs7NlpOdbHZ94hjP4LEtLfl
 MPpurfpTWO5Wq0DbA0+MuDuu6l86Jhd6EAS6f+myLF3QCT8DUadRAsPn7zJ3Abpztyg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iJWS+fNo; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iJWS+fNo
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0660407C7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:10 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso12583075e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516528; x=1794121328;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
 b=iJWS+fNoPFNmO0cSGes7HVb5gqHRAarz2BA+o6w9uAQNf41UTuqdWgNIgZ8dtgBNNP
 TzqJM1mBWy5u1WRAgMRXM+da0N/pe3JRGsVWH/C5ZXxSv/2dkQJI3VzekOSwLbJgHbBz
 JRLImw5R4Nah55kLWcLIKgatYBb6IMT7EaDNFb+wcwbRIHg0DTiC+XJf/eXadBoihyNI
 BotLK6f+3f5lGXniBKk5uYH3+V7BVVcABv/yXSmDEXifjl0ihqlcS6OyDqb+AI/lbIKF
 A6htkrAi/69IgudZrnavRU7A2Ue/doUzgp72odLy0+/vSPJwsla4UTV+HIZnAOnj1eKg
 up/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516528; x=1794121328;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tos/wUGnEmaO69uikOAeefLhUz+PHlwlvFDBgmwFMdU=;
 b=fKEKltj7wxCUleA57rE/5h0d8NYHDc4ibDs5Ta1XFCH62noLfdzfWtqdmbWv3K0LeV
 2YImCpGzOLvPtMYfSxyRx53wYbEawyFdm8ZNDp9DoucOEG8pk2GLx4q3d1hTS6zp4Tqg
 leSkWYph5rLgFepgXVMEUgwN9Hj5UqdNviyvX6qg/ut+l57z1r0EFcqB3Ds9mO40yESv
 75p5hx7MaB/VPTGNaREXhFjkPRaNRmacX7onJSWLtk1okbGe9j5wrEvvJGzQqr7+wmKa
 uZ10haiIQU8mRbJ67F5Oauj0uflyIn909H0rb7TbgOTN25LzVW7cQ9lslvQ/KtyVz70r
 +kBA==
X-Gm-Message-State: AFq9FYI4GX0LEwDAIwGTEHhd+C2hD67tl5ElwQPuYc0UraWV9cJ5OIRp
 f7nGNMoMt9IhgxabUSLxMxifigtNbCtDdM8RqviQhoIKh7BXEzBLKjfM
X-Gm-Gg: AYBFou2wjiwNrWUevyDyvTbW8cG8CE/OXSp0IMzjWCLoqyJthbbQvBodwRHkfoGVs6D
 fBJAeM/zus2FvLkYgFWXf6vzzP0y4W6zzp/1rCQ2izHf0iextQZvnYqy+0DBPbQqtNH4jIXs1bJ
 b4hpp+lrlnzHKdmP0zKWYwtemku8sZs/6Cb11nFPFIHmJpTETKdJVag0Ud5MjQnhuaXgLAq/Cc2
 74YLw84T1GHwGnOqODK1hHNEAwViMUGoABnutu9bQHSErOIF4JQUWiuoNnkWDttZHljpzNETMAt
 Un692vAODbR/bP763ifg+66JuTDHGzxiSnn5im7jfNvJDu/hQRDOkRZywg72bRl8nQEVH/VAr+m
 v3oE4kUplGJA5Ml2EDXU4iSIcIHRITcI0PicNZkav66TViUsUMZA8PhMIMF6v+jGWypXQVFkWJ3
 7O5nFjPPQ2GhuKYXKoZ9xM3G5S1e/7ayN9qJ8ItLPYnUEZ1Dz//fYzkBXuk/gN4EN21+etHqp4L
 SLOg4NN9nUhGz9jH1+Rloo16gIPfgeKADPPywp6L72WUskfazHegDreZ9OrB90TOPwFVXwn+tZW
 hRo1RbsJnTfRb7TYlFofKLXgYqsFVEY=
X-Received: by 2002:a05:600c:848c:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4ac17471091mr165800865e9.6.1793516528152; 
 Sun, 01 Nov 2026 00:02:08 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm190450245e9.10.2026.11.01.00.02.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:02:06 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 05/14] scsi: Refuse a block size the block layer cannot use
Date: Sun, 01 Nov 2026 07:02:05 +0000
Message-ID: <e0e90dc4-5eb0-4b61-aa40-b8b487b5e121@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

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
index 736dccfcbff..55d68cc701a 100644
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
