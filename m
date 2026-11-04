Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E15606D811
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RMtizx2u;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZaumjUsR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53F844072B;
	Wed,  4 Nov 2026 12:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CzV5rwmVUWkC; Wed,  4 Nov 2026 12:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79DAB405F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796654;
	b=iJdLHbD6aR4gxwj4dHAGHBlf0XRp5fplfOSuaH2cl/ihKfySbZEgbJGC/r+ffQ4dfJo8
	 kw8aRA9ahokr/NQOW9mvjjBxCPgcI+Nj61IcZRmzM2knqslq6q0heUa5Wfg7jq8rEyjpy
	 jzMMdhHaGC84syTb1RO/QFPmbFxpScwpl1MYO7hS798D+XKXlTw6TTNv+6Hd1KLgHXLrv
	 CRnRB0TXjm3lMiLEAEzBy3aOKXYIxyz3jsCQ2BRptJLKorxUWJn5XE/dwTa6PbRsX50zR
	 lL63mLVe3JQpAthgcUz8F1Sg3eQ7q3V2GYHzbfoNaS+rOi29jucM5IATWoh3eCAoqnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
	b=iVffP2uhvNss2oNxbsUTGYJh4+E6D3LfzEuysiTmPLpepfRoVhqsPg+BuSC0QI7t1Xc1
	 L8uiM/IOmFKCv05R0RRDWF6lwn11gft2bDcgO/ccU2c5HMOmASrmz333jCgCmVdZhdnVT
	 wnxZumldwIz+8F02+tdAp+AHvTsc6lZnAYXeQGrQJ0zrmJfHS0lk3lWwE2Moujv5vmpo5
	 7ZiiyMEE/i6O3W/eX5405wSUTCtl13Z+5SxQVpZoXFExl4Y7r9uQIQjH8PcBPooQ+sAEc
	 99j2Gk0Mf7Ap6mZ/QprohhA+2UiEl2qqqhxK+Fe44ErPMsac+DQ7ozgqikMNQG75NcQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZaumjUsR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796654;
	bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RMtizx2usDfJshXFuaSQy/YV5G/yhfjoN9GixYWuZxIeMYQx7ljmsc2d7BdXjtI2D
	 4X9f88yAf+mC7AZdgRyIn1UFZ1MWzTE7iwboWtBTBRI4JdR+4sALNNy2YsBpMr2IIT
	 fggW/c+2oPawrjOMNLpsUdG0a1isKLYH4vGuJiloec8JF/wJDixwhY77M+mICzdXvi
	 qpXT0qMDz+EQ4s7jSLFQbu/Kfck6O/FhP6xdWgV+5zIeS1z5YAUhLr1xxo+qg9yYcz
	 sPvIF8TIfem72D42Yt1jPrIgw8NroClhqCN64n4QX2xxn5M2zy68mmKDdZkU6oZaZy
	 4wxN5LyOCC7Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79DAB405F4;
	Wed,  4 Nov 2026 12:50:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B69634D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CD1E405F4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 68OHaYHd4_2s for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 28098405C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796652;
 b=dqXzQXDb+OlzQMEWzAUBwGqPjVLtQQxaxc0Fr9qDeVAAG/RwaVKIkL0WuAXcXuWmIVo7
 e9DWoxNcemtDnqMyvtvOOpvPciEnveRdPVnS7cl8hsrHvCSzlZy247BJE6PANrkRIh58O
 AtWPdVGSW7xrQ4EK+Xf1ZVYSsGhyc5Og0ozdzM5v3/yWH8vrYIA+SUhP+siKpap99Aha+
 cyMkeOqXr+FMFaD48qFtrnTLs4oNMtAwYCXy9c7gGYE6GDJli4dDBjziCLsll/WItUnqc
 EK1hCHzZ9th5Vary3OXPVwtgVO0ouVUred+kUFCfBORUE7+pzDZrsbG/ZpxT67JZB6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796652;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
 b=J+TRNRT0MdfgqZa4RdoIPt5ZWNarctfGDFr/7DKUTGSGMHA0kjGjQ4DzJ6Pui2AVcVaE
 4vg6pNPxODInDQh40q8N9itRYJ9qZC61ZPdnfemEEKt5aABB05ozA6+9DAM6E9kZ9tX/b
 8Pp+kNiKrxWtM3iq4KY/dOCAbHS86jMuw/uFWRar5li+OqD2RsWrbsnIfq7mNFCdBKECG
 YuzGSwaDxv+s2EG6Be7m8g/oFAgrxZ1kbExFZcQcPYN1tP8vV6mMFQ7A8Ch/4DVYe9ROP
 foJqZRTHZlsQEt9Zl5yAa2AStM7bQZUSGV1BObGRMZRjWaiA0wjL4qdvjVkLYn8w2PA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ZaumjUsR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ZaumjUsR
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28098405C9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:51 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so343923066b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796650; x=1794401450;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
 b=ZaumjUsR6G0QTeX9wALPyuzKoOGtrrlPsYPgopd07n+yZrzQSUcVUES1/gwvy3G3RE
 KYThdkRXPxARt4ZiuTKi7Urre+TUBHlexuZGI76WUrxccM/esw/dmzMld8NVU9gf0FPz
 LFQLtCVuVLD6yQthvsiEQ9wHDW9NCK5xHETfa19O7UQ7DGObtPBvA75Z+Mq/WB4PiYno
 Oe15v8IUDTN/pohWVmhufAQ5w8eWBZDje0MhzZTwxJDJ/hKsO8FdTnfz0SbTtLyBp0tI
 uBUWINxkKP0PKa/JfcCB++oadGy4Msed/8GPyf3avu/sLsdNs3j7QC5GFGoEWBzCHzhX
 S02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796650; x=1794401450;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Q64LJxhd6d8Nqm+xp5UxY8S6DMN+N75zY8poqEbpOg=;
 b=vu1BwXN7pyyPQN2LFKZEbCVaLof0dzAEFONkT9o/qei0RetIaADLmmEo0FcWUiXr/u
 W0f0cMX94k6AmeX90Tfv/pIxE+DL+T8bZN8dYp2kGz9Mo95e/XgwmYE99PxCC0rLnV1L
 YiTozL1uR6hpBD+2/8VJjZDwAEjkoRUV1WRZmscnkgMm4HGTy4xSrAaXYZAbWMC2lv6k
 Hi/Sap9j0rWb9ZgGTfKNT8/bV/9IYQ0A0COU1VYc7OKjUp+oBTqBpuavO8Ncvw5BJ0HB
 zwig5LWh8Uxg63zhPgW2qh9EFcUP8aG8nnaWzlBusTW+ejk/WAM5GWrvD7iRtY+wrdqb
 w/hw==
X-Gm-Message-State: APuU4Z/6botKlcNqMe6B1AspFTamLfSgxD8dPxxeet0X9Gfbyltrf6f2
 1vjX2AKwsNUd3pZglijn/269bXXFdSoJycrA8iByAYlaTkcTvsov8sXr
X-Gm-Gg: AYBFou2Vp9Vqb15DYts7jx0mPNHBF7HMTfXW99e7wh/dKLX3Ger6+98CPPU/owhrjMF
 WImOheRLHGlFOLKWNCC+GlLUxJlbflyRj36399KYK9jBdLHsnZkL/499dpSUV6Uvvv/znc/K5Rw
 pfbWQU8lKwUIYqiyg52O2+yajpR3hpHp9B/JOetAJ3dVCQPHSdnXpYSkotqeiOi/Z+fPdX/4hAU
 /9OBFabhsXJ0kMsOqaRyfXgy/qs7Fs0LmsxNz9mo+4vcfmEcT5SYZvVLeY7JvuD3CJM+fud/mnN
 hd1ef0xSiALe884lPSW4IKnPRbskBiA76pAguX95Z/SCabajWDf8FcsPE44p5E33C+Jd3XN/Ppk
 dXc5c4lZXqEmPN0kGkfzpmGyFYyP6kMjQAHbX7KJZHg/l6IAAaHKiMcHxWdZUfO4S8n+uDmHkH8
 Xeo0oBTpxKiKnNkSNev/3VkqK7aN3+mtqabbYlqopQaB2M1NLj33agAa/9WgJGzPt+fYe6FK+rb
 CIU+2P14n2njRWwo/iwuKXLlRVcMa9bfn6n10rQkTAhOuNnZFuPAYFspyOJ2SPz4rRrCb+1c+YN
 RX8SMcjU4aKmPEVHV337xe2DKsMOCsE=
X-Received: by 2002:a17:907:2d8e:b0:c45:219c:7fec with SMTP id
 a640c23a62f3a-c49d14bc1e1mr1733992566b.27.1793796649653; 
 Wed, 04 Nov 2026 04:50:49 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e48b93dsm66566066b.64.2026.11.04.04.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:50:49 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 04/14] usb: storage: Refuse a block size the block layer
 cannot use
Date: Wed, 04 Nov 2026 12:50:48 +0000
Message-ID: <b1d94013-7054-4366-99c2-f2c5e2b8fa22@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
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

usb_stor_get_info() takes the block size from the READ CAPACITY reply of
the device as it is. Once blk_post_probe() refuses a block size that
blk_valid_blksz() rejects, at the end of this series, such a device would
fail to probe there, and usb_stor_probe_device() would stop, skipping the
other LUNs of the device.

Check the block size where it is read, and treat a LUN reporting one
that blk_valid_blksz() rejects as unusable, as for a LUN that is not
ready, saying which LUN is skipped. This also covers the legacy (non-BLK)
path, which calls part_init() itself.

Add a test where the sandbox flash stick reports an unsupported block
size.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- Move the READ CAPACITY fallback fix to a patch of its own (Simon)
- Name the LUN in the message (Simon)
- Check for that message in the test, with UTF_CONSOLE (Simon)

 arch/sandbox/include/asm/test.h  | 10 +++++++
 common/usb_storage.c             |  5 ++++
 drivers/usb/emul/sandbox_flash.c |  8 +++++
 test/dm/usb.c                    | 51 ++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 0438790028b..e5590d01a92 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -123,6 +123,16 @@ long sandbox_i2c_rtc_get_set_base_time(struct udevice *dev, long base_time);
 
 int sandbox_usb_keyb_add_string(struct udevice *dev, const char *str);
 
+/**
+ * sandbox_flash_set_block_size() - Set the block size a flash stick reports
+ *
+ * @dev:	USB flash-stick emulator
+ * @block_size:	Block size in bytes
+ *
+ * The host reads it when it next probes the stick's mass-storage device.
+ */
+void sandbox_flash_set_block_size(struct udevice *dev, int block_size);
+
 /**
  * sandbox_osd_get_mem() - get the internal memory of a sandbox OSD
  *
diff --git a/common/usb_storage.c b/common/usb_storage.c
index f7c96195b59..6bada2b309b 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -1513,6 +1513,11 @@ int usb_stor_get_info(struct usb_device *dev, struct us_data *ss,
 	blksz = be32_to_cpu(cap[1]);
 
 	debug("Capacity = 0x%08x, blocksz = 0x%08x\n", capacity, blksz);
+	if (!blk_valid_blksz(blksz)) {
+		printf("LUN %d: unsupported block size %u, skipping\n",
+		       dev_desc->lun, blksz);
+		return 0;
+	}
 	dev_desc->lba = capacity;
 	dev_desc->blksz = blksz;
 	dev_desc->log2blksz = LOG2(dev_desc->blksz);
diff --git a/drivers/usb/emul/sandbox_flash.c b/drivers/usb/emul/sandbox_flash.c
index b5176bb30ce..02e0901050f 100644
--- a/drivers/usb/emul/sandbox_flash.c
+++ b/drivers/usb/emul/sandbox_flash.c
@@ -13,6 +13,7 @@
 #include <scsi.h>
 #include <scsi_emul.h>
 #include <usb.h>
+#include <asm/test.h>
 
 /*
  * This driver emulates a flash stick using the UFI command specification and
@@ -357,6 +358,13 @@ static int sandbox_flash_probe(struct udevice *dev)
 	return 0;
 }
 
+void sandbox_flash_set_block_size(struct udevice *dev, int block_size)
+{
+	struct sandbox_flash_priv *priv = dev_get_priv(dev);
+
+	priv->eminfo.block_size = block_size;
+}
+
 static int sandbox_flash_remove(struct udevice *dev)
 {
 	struct sandbox_flash_priv *priv = dev_get_priv(dev);
diff --git a/test/dm/usb.c b/test/dm/usb.c
index fa894c1096e..79a85b11910 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -84,6 +84,57 @@ static int dm_test_usb_flash(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_usb_flash, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test that a flash stick reporting an unsupported block size is refused */
+static int dm_test_usb_flash_blksz(struct unit_test_state *uts)
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
+	struct udevice *dev, *emul, *blk;
+	struct blk_desc *desc;
+	int i, ret;
+
+	state_set_skip_delays(true);
+	ut_assertok(usb_init());
+	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 0, &dev));
+	ut_assertok(uclass_get_device_by_name(UCLASS_USB_EMUL, "flash-stick@0",
+					      &emul));
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		/* Probe the stick again, so that it reads the block size */
+		console_record_reset();
+		sandbox_flash_set_block_size(emul, cases[i].blksz);
+		ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+		ut_assertok(device_chld_unbind(dev, NULL));
+		ut_assertok(device_probe(dev));
+
+		ret = device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk);
+		if (!cases[i].ok) {
+			/* usb_stor_get_info() refuses the LUN */
+			ut_assert_nextline("LUN 0: unsupported block size %d, skipping",
+					   cases[i].blksz);
+			ut_assert_console_end();
+			ut_asserteq(-ENODEV, ret);
+			continue;
+		}
+		ut_assert_console_end();
+		ut_assertok(ret);
+		desc = dev_get_uclass_plat(blk);
+		ut_asserteq(cases[i].blksz, desc->blksz);
+	}
+
+	ut_assertok(usb_stop());
+
+	return 0;
+}
+DM_TEST(dm_test_usb_flash_blksz, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
+
 /* test that we can handle multiple storage devices */
 static int dm_test_usb_multi(struct unit_test_state *uts)
 {
