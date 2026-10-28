Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nq0A/FKx;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a4/6cQRB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E07A606E3;
	Wed, 28 Oct 2026 05:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Piwtkbs-8lc; Wed, 28 Oct 2026 05:51:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A8316073C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166688;
	b=Tl/zWJZ3C6gS3q6lDxHttvpYXdY7d+Ue3sKRApS3mARjD9fBVh9+GVUV42AK/Lo/gw3g
	 Wx2YgYWonr7QR0e42hSym7TuwjMq/bM8rwM8G4gmjswWQT5aB41MfceMNxAAY93G1syJb
	 +XoPc+h2w6LHbmWr3DUKPZ8B+t2caPX/m/j5RzY3HKZQ68KpLhEGeP+pD/F2V+0QUcDud
	 Z5QZFeEuY8qBeU6Wr0B7U9WPYzBDyNSI3LMq+98cfeV7the4y2kdZ5ieT5VQ+pW4VXbPa
	 O1nv9vfU6Psakqh7s527efpR7WzhXyz3MWpQbq74MzYuKQm/vedeeRf9zdKF3j/7eCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CLqDoJETTCsFbH97C4T8gg34GorZNHo3nOXwJg+EXfY=;
	b=hL/cj2UZTa1g844a70/b2O9oQU/j5tuMKa0xmue+tFcLmj9YsLZndIyLX1x4iLBD458c
	 A+W0Xn2peZBtKsmSLf+f44BWPjVtGfdve+diBud8LP8qpnS/FWTU7CAQkoKW4ErOzNBBk
	 agspbQ/C/Fj6lwrMfSvN33qak1qcusAYURfftRGagBDzA6Lm4NGSLLL1UUzHyL/Ukeib0
	 1ixQbzL+E/GoSvBWBGyY/39+iCuIO+ZC0uxOFcxeffx/ZNeCMtSmqDWuJzJkQ5sTM424A
	 83sglXOvI1iUPLCl9TAWbHZ2qrsoSIXxCCwLIfwliRcd/Z8y99xHqG8FD+C6dFXT5JQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166688;
	bh=CLqDoJETTCsFbH97C4T8gg34GorZNHo3nOXwJg+EXfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nq0A/FKx/b8NjFNBML+9oZrYrh1M8nnpDwddM1gPsnCAmCbnK/aNq5u7hCcagOF+8
	 ISJ5wVwafQzQvFsawpaskAfZUKQEteocYxkHA/EJOEvAxORwipC1aa/fsIsitb8+++
	 lLrDd+7gaxg6BSHu4eGPL2wZhYpr0Q/cV+OjZ36pc5b0oPO2OcOFS+8HYIHnWtLX6d
	 ErwRSAnLjKwJh0z9bI5wYBmv0RDHMIH2/RyOTagGQBLNgvdi2RrJJdfmqfUQb8bqiT
	 NiVkbxCAOcVl/+JfWxm7c+MuH6F3HAMDXdHIGEQiAhc1PluCm3p/GIGQvJAISjbvIO
	 t0IdlDa2AafVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A8316073C;
	Wed, 28 Oct 2026 05:51:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E59BD1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8ED6080EBE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4uJFNyirIkA for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8AE7F80F0C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166683;
 b=hGDrQuQMSxfevYZCqJZInzhjM1Srr9vI5yB9uHEOARjKqIWOq9l8RJISKZjaKQg1W1WH
 WK/KTFFX5qOq4g7dr7CRY9SZ+vMi/PzYIKcIseVZCwDqf7qC0xuOi3AzRCmqPXAVDSWop
 7YCMYICFsIgx8jQi2BNGEoKZglaeddfhsZ280GyQz/mlCsckBN0N2HosEATwavjxLJnAM
 ALbSr5eqWHm/4H/zZzJJGGVkqP/IzexbX2qDAgo/UHD+ICQpq0mt2GBAWNGN9tQ0Y0y1F
 hJgV8La96D7qWSRrqClA103QpZVvaN4n/cAxXZ3/uVBdcdnfMCq1/rr+x3RcvI/X3nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166683;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=CLqDoJETTCsFbH97C4T8gg34GorZNHo3nOXwJg+EXfY=;
 b=tJJNfs9pBHBcbX34G25PFbEkb3d703WF3SNofLI7MUxK1efQ6M89ACziuABwsOWpzYc2
 z2nI3DYEexEEPC1gzNhRabucnZFCxCw1lA4FHAKRzupMEDgb90CdyeHqmgvYJ3gH+3ONw
 NWBiXMfyaG4MazrCWnG3/4lQncd5LmijlDoQmNAkwQpgA44XP7aZ4+kzXYYgyZtDyVAcV
 V4bFQq4dOtw595II8jj17suIBx7YZle7m3nS81Wu49H3z5IcPdg1/DwbIaPIEFyqSBnnx
 0eK+V4uz+Vk4ZRs3GJolY7G/qS6rPyHwlKmjpQ72Tptne7GPxREpv7Jb1btvd8c8VZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="a4/6cQRB"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=a4/6cQRB
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AE7F80F0C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:23 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so311075f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166681; x=1793771481;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CLqDoJETTCsFbH97C4T8gg34GorZNHo3nOXwJg+EXfY=;
 b=a4/6cQRBgOOtOjjvhAATSBeBfJo9dfh720mghgiy5LFB77pMHcYAcLTgFlx/kl1cQ+
 M3Sl6xsLuNqFI+MHksMd3Cps+2l+iHhz/opesu+0Wj8klv6NAZMhlXugeynpd5+F8Loz
 SDjOZY1+CuPAkU+Q3Qvr0C6Zj5IbAwMWmmXXb7SMn3J5AVlDo6sZoxrPWVQzfi/46Rvj
 CfocB3sztzJH9nd2NACSJPckcZS0qaOchWzvxg82Y3Pmb6Wq9TMfikjg980DoQT0A3fZ
 pnd8evajbhYn7wlgF4emETZibuEfWWGNjj77NOlNJ9HMIt5MApMWH1UD3+FxcRr/+FWE
 WFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166681; x=1793771481;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CLqDoJETTCsFbH97C4T8gg34GorZNHo3nOXwJg+EXfY=;
 b=g4RvURU1iPwbEzr7650/GdfP/ZgPFhDh6uIDHk6+Y2oFk1LIkvEPmnneQzQPDULlwQ
 cjGUkspugoPifnsXJYR/sV/sJQAm9tadpSl5BZ0XZswYi8htwA//zl6f13I9m8rfjKzn
 p7sTKS/z22Gf291FGNJH0qUB9zfMLsGo46VmD7s4t6vOFFl4YrM/rMb/IlgqN9NCGOEu
 qEr45gzKpx783kRQSYbUitMwYlOo1o9RUZucG27FucCYd56OJxOZmq7PcxfQk60vIeBR
 jeaQYgGcwZEnFmloQwfw+Ojux/fsvy6s40scV6vZD38ZPOU0GEhkRTHLm/4xCO4uSrav
 h4lA==
X-Gm-Message-State: AFq9FYKrNnuyu6Rnk/MlqGODAtAPdczhI+h+vXCWiZoGJ63hag2ZSLOk
 Y7hkjGI8OtGLTGRctqm7I6zPQh9IvzUn3cZb67QoSH56/IxFCyKe52E2
X-Gm-Gg: AYBFou0WOtwiRh5sYs5jiambX+/2Q7nFHouaR4e3yP7NdivKm3PS6W06Q/5OnUapMre
 LiO0zmmoWE520AfKAkGvGb8T1fV5VcuhAtqt2hQ7ZXe5bHamyBXH1bZXpy1FLGyUuTM701cqh5Y
 C78CfuQm8iQEqW5vBHFIU/exJn+F23tLJ16JPp+Nn/CPxv6zJpG7th7X8Z7nyyKnpoL8LQveuhn
 9z6uWrMzYX/EKGIRDqh7qZrVVa76INJh7ixF/tGaC8n+TqMEZ/RxU7sUQOodxB0e3xdNFmIv/hN
 O7vjq3GmHDqxIjDedDH+/OWWIwFGrZ5O+maZGxwFem5IpQ19Mi3xyg1djy4W0D9bX1t50xR6iTn
 aPidx9YhKscqXXFPOe6eWjIOa0J0obRKIf4hEo6AqFvlrdAKNUW7ZpI5aRLqfyN8bBNhu51J1Mm
 Bm2gCKLFrKdsFPPjbFgJsmEQNHVARQ/FyNfTLLKJvtR86zobuRnZa+2YzUeIQ50d9KIjNo63zAE
 n9+Q/kGHfkSRJVOVFj+RX6gyoVbLiswxiPBmpjWqF0RoDqHC6ewiuSoDw9f3sGSOu9HdLnox2kM
 YQxNbT9D+ipaWkOykFO9dEJec5L9K2s=
X-Received: by 2002:a05:6000:2d09:b0:48e:d88:55f5 with SMTP id
 ffacd0b85a97d-48e5d5c8a9bmr2384483f8f.30.1793166681304; 
 Tue, 27 Oct 2026 22:51:21 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39a8sm27523681f8f.11.2026.10.27.22.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:20 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 04/12] usb: storage: Refuse a block size the block layer
 cannot use
Date: Wed, 28 Oct 2026 05:51:19 +0000
Message-ID: <7f6c3461-f084-4682-8638-212ab29c69b9@gmail.com>
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
---
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
