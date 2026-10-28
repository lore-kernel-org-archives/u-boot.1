Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EE606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zFaFhWNU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dly2RsKh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C420660770;
	Wed, 28 Oct 2026 05:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zuxiC9IiyJyL; Wed, 28 Oct 2026 05:51:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07BAA60780
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166693;
	b=fiQElVZK123/ujs7Q8e+GYv7wX9iU0rSv8pGgmRGd6Az+WpYqRxmoNEs1irw9rh5d1uE
	 8UxYyialwOOuOur064HcFEGQWjYwhm8UuIFAfT0YDdGFEIYxjKbtMRAkhvydpvJclgRSL
	 9WvcCVWJGC11dIc1qr3GONmC2XotND7wLTOZ058oRM0c17ggG/kP8wklbZtnN3wXOIeFW
	 b7FauBLuiFP6XetMtmSrSNpVB03KXlFVBQ7c+SklgBNiiHFadoQqISkY6y/lepRgsKzRQ
	 7EHebkDuhmK/99AhmOHD5WWlsVOgyCrwOqNkyZjy2qkT74Zg1dtcoeXwDiRHqrbwuug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Kf9XcCSwunCmnaeK+Ksz+ENpRslBewBwq6NWwAIQnFQ=;
	b=RDX9CpAqrcH4sNDQzR5bjsKn6hQQW6K8FnsUAAnEwaOXDiTHAlGEPHvjTNKj8DHeXjjA
	 sujqm7owSoMngk9qky78hiOAcjZ/Fm/t11fvhDAFhQBqMGTJsbfi6UnKAyrVnNjjCHmir
	 II6ZiwfSkJjHpvpY6xsEimjmmk7eKQFitf/xIsEr8GeqgNVQubPJ0DNT2aONRFa1S+mp9
	 xzGBDXl4ii08adKcUptCFWa446d1U8JQRccFQVYCGlPSNal67gBH3osWjqs2Pw/2bM7X9
	 o+8R8Qshm+LgcSEaiSazHsktIck5ol+lGsZD+ZFMUsGPO+/Ufd33/pExTef47ejgjfw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166693;
	bh=Kf9XcCSwunCmnaeK+Ksz+ENpRslBewBwq6NWwAIQnFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zFaFhWNUc/WafX1HICZqACV4/G3191R2X/+3hFDNCkR+2j13//tHbJyERkXlrakUe
	 uM4m3vKq+Du7M04HMT9s1IK1kDWSmXOGLkw8tOoqWV3LL/y0+d4yGX7MEBQ87LQoGL
	 OFK/b7Qs6N9ZuI10Pto66/Jeh8/mEDbZ8L+Gd85mlg/aWJjIIkce2chqMZfxN7US2f
	 MYEigC3kMYnq72Qma5nAM5oZJNJfthOBv6NYLdPwf0I1pHvlu94pn2hxvoXqtt3zwz
	 b0rhP1mwjUfVxMUihap/yHTGQWyCN4AUosdbRgpsk41/tupaw6oMIjM2G/r7RM5E4j
	 Ay8lWSOpt1r+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07BAA60780;
	Wed, 28 Oct 2026 05:51:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF962473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95D674006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9yKeZN7vP8d7 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 92C164016B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166690;
 b=bOzbBXRJam499fngO7waay3nMPGF/j6NW5sCAa8PD8vQ98aDTqWyjhiqKN/Moy9KrDCP
 IJR7tOMaBdGyjPr7suyfrhabwgVLGg1Cq5KAmuMIVhPrVM3w6SHjqWGAk6eLJlUE8t2do
 NoyGbghrpFiPbQmrqgrMKk78Xk1kTh9P4qslgyEx/iUqkiKVkwKiI7T0PpEU3VGK24K7O
 qiULAstQ61GHdSjd6CVMm+kM0XHFUhX63tR1fY4JsStheNh/1nJJ2wIat8foTIcT3D+vQ
 TYq4PvQGvP0330G/3liwyMwYdJc27tANDWnqtnxOJLe6QTRJYKH1lhgOlubT8MRA5hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166690;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=Kf9XcCSwunCmnaeK+Ksz+ENpRslBewBwq6NWwAIQnFQ=;
 b=dFSy7Rjok2bwWxO7jdzy91yleqy2BJTm3TklW9JElmrEHRPUSVcaf2+FL9AmdKTvPLS2
 aSdT0sU4nc20+8tgP0PAHAzIFKkvcHYER7Tx3y2ChnBItZnX/8NDr8PMe8oFtWPp67rog
 geFX9UaEYjLI5otzKnbSytvuvIy1Ofw9+xejlhiIUtA/HuLdhAPxuAC/jTFFeiRn9dciS
 ehs57G1DAzwXlkDYBdI0BVOkS3MjwNeKqGw0Z7TPJyXaNrpWHfzMKH9ubvP4fGYwJGrFa
 qJqd/x7oYHPYglZRmLMOjXC3f7nYVrLm6A+ljWyVb+UxbnDuFdD8LoCGppZLPyXcZTQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Dly2RsKh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Dly2RsKh
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92C164016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:29 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so4240695e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166687; x=1793771487;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Kf9XcCSwunCmnaeK+Ksz+ENpRslBewBwq6NWwAIQnFQ=;
 b=Dly2RsKhtx0fSkmg2CO6+Vk3Ha7dOWiZA+DoQ+gm/oNCxy1BIRCZj9/G1MJZWQnQbF
 bHT/Lq9f0nWvjNmWat4bAGKL1Y4wQrfbP0o0BQZqRqKgKJ9Ev6M1JSCUePl5j7thxxjR
 XOqHX1kdKuKK2kdw6mJUZzErbQtFJZxK9GgVtwycgFYTG/wZVR6zaTo3xK5whbNYZsjt
 w3+zxSmY2mVhvlfL0ooV9hKu9beAChGg8pDSnpK022aePjMPwEzK9KZsABqx5mlBdTIl
 JmDmLjUYJP8EPKjzbL9SXAgOHl1DGSjQqRPy/Km4NQLEie9RYUmJUgKpfi1KWw6ARLWc
 /BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166687; x=1793771487;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kf9XcCSwunCmnaeK+Ksz+ENpRslBewBwq6NWwAIQnFQ=;
 b=wHd7eZNSkTxIf5jNM2BHQ7U/R6xQrNkiCCrvEA5KIQS+5SPuBfCRzkAKk8Ce5/E/At
 H3o/W+gnL/lMjCVOGs9G58PcLGSd1JK+hWpeZ4gWZHPQZDSeeP232BewSEMSlr1yzaA4
 aNmetyae5ZKa7lVkkEOjHYNW61wb1Efv86DlgzStrCa1SXI/oS8DvYDTE8W0/Fx6a82f
 A/b0bDndhgmlom2LrpRPN9g18x/zrcdEr9xGT3eKUfbZXNNvFyDRccTpRnFIm2c8vDHo
 1Cl2yGxU/H8t2ms/DMRbanjigXqAFS8na/PwaH1Fhrusb0yHUdHVn77fNB/7h81IkNtW
 ofuw==
X-Gm-Message-State: AFq9FYLV0M422W7tfIiVFGzgzlUUHWNaUq1fN+h9v75AprSQlY4F8GXc
 mQT/ZzXNMX07sRWpHaralk5ibogLHTBjNzNWJmFt1ve/eZVm0Nd6OTnZ
X-Gm-Gg: AYBFou0JLXvyfoUJgN8+i+KhmGwsJvHimHT6w2OixWu7IYG3qrGFrn374GQUyamLsdY
 7qVOIVSNgspcdQlTNWldltLdi/TxHR9cKdV6VMaSGlbjlyOKSCOgJE7dhEaYwTYyUp4mCLVqpqY
 nyQE4t8VcrPUARmzd8oar5TUs5hMSUeQxpi1+WhiqVkxLVW/XHUgvKUrYsCTxHm9NHLT56vRC7b
 XwvNwiD7C+E4PiTCr1s1B+8NY4p5jMpq8f9rV32rDwGo0KfcYAsSsOVtn5AgpiUsHWiBjoo4tYA
 PoGBebjWfuYNPOS/RXhNhoWRkIFpcKJlvvBnC+uoHVT4UD9zxszWeQnW7JLUR7cCEYWmyikkkH6
 UIQv6SBQvXdFlkATFI0L5SuYpKxwAhjjAimvS+SCMcY4ILtoIECBV0RUgzE8G2a1Rvgs9tqumf/
 Mm30ceWBM4GCsIZPDXwWQOHW26DRKysIwOoaFWWzeqE9EJOGGqfd1LKFjm+0IosGczpm50LJxlM
 1N6MmxnKw0dENlqHYUuuZrFCn8448EvjoOvf3cSbbtfh/BddhAFI6wd/aqdhLTI3s963Nzgscv0
 8IiNkzGmJHe1+51kWpi463vOABWaqtw=
X-Received: by 2002:a05:600c:3115:b0:4a2:1a:a128 with SMTP id
 5b1f17b1804b1-4a966774f69mr22342535e9.19.1793166687375; 
 Tue, 27 Oct 2026 22:51:27 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c9f150fsm17713115e9.10.2026.10.27.22.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:26 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 05/12] scsi: Refuse a block size the block layer cannot use
Date: Wed, 28 Oct 2026 05:51:25 +0000
Message-ID: <36f00691-4368-4420-bec3-379c4bcb5d6a@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
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
