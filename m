Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BF606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=okYmH/nY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L/9sfUMN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29E02607DE;
	Sun,  1 Nov 2026 07:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ng2uIUwN8pRT; Sun,  1 Nov 2026 07:02:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54A47607EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516547;
	b=RSTpnc0L2x5zenOTNRILshwCMfpexXDn3lApJz1wTr/4MCecJ8L2uCtvWu8+EZZ4Q8JY
	 Wqr4YvnvUIq94FHyPm9zg2hb8v0z9VS4/VFwaQpxf/pIXpbCSL5KlJ/oO6gBXK62n2qvM
	 o+lVCvJdt74hyJXjCldB+qY/hVm0g4IwqTY70KTwC0XO/KlDNvwjptOkWUZ08sDK6RBx/
	 LZRakp3GIVh+rpAjTsx3noCh4U8jaaiVECjqNZRPieaG6HDRldXnOT3cwCsmgtQ2AJlyV
	 ZMGKaRxBjfehsZDjKrDYpFsQDZd0ytqQ/MBDcKxF2JoCB5Y3J8PsYWpyrO8JeHNLMKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
	b=qCBz23g+o1q0QfCkFuVGY2XFopzhJs3qoejySNLxWKuBbmCOGWe6CfXeowkRISQeq8c/
	 d8RXv68XwhGKcFZ2QBxIZDreupawY7hdjpTLmCSoF0+8RymgGib+0BoPwFk7nah2Vx/w0
	 OTRIiCheqPP7QYuU/RtneLXoUbKXcDK75+tDl4zsCNpF1BQryE4yLr8wmTY6+K4kJZ4cH
	 58u6+qT49tYh41VraP6eakdWmZln+FUsSsTUUPZcCuhk6q/zB1QsnjHobpDDbzNtzw7X7
	 T8zQaZqhf/sixWk6qI55QD5WKeKN9mFDAiI1Fc12frxqh1STuEny4D/adX3Tf+4nZTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L/9sfUMN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516547;
	bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=okYmH/nYYnRKnqw3fz0XKBPuKeTmH5wacIjMMQXd7pzWe88Xjt3VWq6o3mt0Zgj1X
	 NIwYtFoTxc3D+AlTwzF19kh+f1UhxAiiFKYCp1ehpevvNrfthpuulIiOTKiCjyiJo5
	 AexeOw9quLajSpbPYFRnSbDIJgpsmr+j170gM25RscThbI2bNsbzag++cme304Y4vY
	 f99jlfq7mNz8rlH+9TBIHkJFRqX5ANikorsjYTwgg89Zgqe/IkEnJhugmGPI3vMhVK
	 7SVO5VKXjIVUbsMfER6C2ZO+sNkc776Ige+nlaHYnoJZ3QWFuPuE9rxeOBJbyTIFGm
	 +QNQEfCoedpyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54A47607EA;
	Sun,  1 Nov 2026 07:02:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB8C1411
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D563607EA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJSKSfGs6Dgp for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:02:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A1C0D607E8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516545;
 b=Qcp1tGYbUmMZo/86OvzEp5xnaSWALCpNSYbXfm+x0ShkzR3Ff0gG0Swy2q9ZLnUY72ZT
 ZEywgamfmN4CJUx2nqCLkMdU9aFNAwhsrnNFI2VpM5PMbnfY6KP3HYyeqgIlnqABcuYl3
 0/xnw2GtZTZ5zPjiXHK3y5fMxpYn/fNIFw8eLNOjXdO+VYpFIpa1fKWVnb6y66RMnyehF
 685NZXl5KMTgKYwVIFqqw+KBoZn1h+rbB/KybIy8nEk/pUd9gYOeijEoWusb2OuWANJe2
 M8B1vqxDKVYFVPTIXuOi68aF23f4eHE5HwjLbon6LXuUbHDzYdxkMghaNuryES4ZYWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516545;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=pdcF5U0KllDjwhxrjNCwi0KIygyIxIXY6xuoAqsb4ZYRN3ofMqQyXEkfADoL0MY8+EeO
 PqJJnUQRFBwr67Hzz3oOxT01c+zy2bdOQM2zmGeXxVdM9r9hxvO3EKKyutwRMRYeSeUKv
 MkbJ4yTypf8WqohEZgO2US9tx4Obb326ulQKnLXjdzFYR8JQK/Ih3e2QUz5tBCQDW1K9U
 R3ruBztp0ofl9BFzr5GGvOCi+b0xA8cQs+igG8m7E94qzuTCyStIcAdkukGWoAzfW8FFf
 ZDCIhH+pY4frWIso5gA+D0D20pDfQvi1zvRys2qjE1RAdBh47HHogIuEC8H1LZmpDkg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="L/9sfUMN"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=L/9sfUMN
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1C0D607E8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:24 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so12370595e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516542; x=1794121342;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=L/9sfUMNRxQBQ9gNgswjZUV/2QxDlw+k6zgMj7aOMoXjVpUcuQVnNAJdRuyrhZQJXw
 5gZHSv/nBZz6kna7vjV0mZRHbvP4Blnp8ecmOpSsuefgQAqltrZ/8v/nb0IRHph/f3R7
 Fn2pML3MLhQ5vB0wtTObBIBD3A0iC78r3Fa8NaUPwGkUgtJS919Xycb+Up2RZNZQMrwP
 ZKYzJ9ouhOKsaI+C9z4eeoTjxfGGPelABNwzCKhAbu9xu07Nf/nbjCPsq3TnO10mlB4o
 bWBqkUnwfC3YSAuV8whwtSljBwi9GYVaruDBgIXri6G0PfUC+UpyRdK1zaQOCqR7eVYP
 qtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516542; x=1794121342;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=KUTRHnuU5mMEc4ytikcrLNuh1QvX2U+Vdxbj2iU3w4qGGJemMVI76TvZbFua99+3DQ
 wiNM3urTKrrABycbZ362EiPEB1KEe2+SkJItGqOfsyeQeClbRRedgJifmdlU8hu/mBNr
 1WkD8DW0pziiMwhLf1EFu2YTlyueB13wGE0eyK2d7DwwHH2C01W3inZhCTo39IVjtdT6
 kRmOFTxLczRMu0G6GMHni2TAmAxP5+Ddtm1PGVnRGpyfwaiDnFEPmzhpJUiNBxCSIKaU
 vOzgHJNHoKyRyQkf+HKApjPd6D7ecqIeHedOMb4g8ZAbeDboNKXGKHfJwinjQjnayod9
 y3JQ==
X-Gm-Message-State: AFq9FYKR2ozGzGtJ91bp7ZVE88qWJOCnisgbZGF+KgKlgUeobCefjDoC
 ihOvTMlAVkxBDKfWKRPJ7WgepecLMsbyt7y3WDhfn5XmbPZnbWBtf+os
X-Gm-Gg: AYBFou3ZZzdeM3jnNl1mm5tqK4I/oybrly8Em+m+/WHRuzhW5EIk7c5T+q4zOq+EpDh
 qKd0YKxn33AgNADE3uDVDk/lMKLMhGXYYkAj60QsjZhwaHc0PLn8bwHgN8qA/Bl6sesCXtP7OJ/
 e3fqDc+/4546XImTupilqBMbmDEK3ZUxiJFQfBgfduYcwUVFdRjIbMDB6+AOGQ0GJxwDsm04kbW
 PuOraW95uGq1jAI2w2EHigNKBBl8OOwGeRw7YO0QPDMVWIENW5e6y6Znk8JDPGxy9SuC6NkH8P4
 zWAZloIJUI9N6ErGRry02Dj4k/WyiG9K/V1OZr7Go89qvz34MzkdIcAi30Q02u/1FKh0/K2dyXb
 ucMZMtAGynWybC8BS98EkGKnZLgDnzfJQcDEVLznlruxBg2+bG+/XbTmqQh/CGtvQyXaO2fIJqf
 xKNh7e2j6KqlwcVHlDliJpMiBhW5ZCJ625WvSNv73qfrn8ZxNUt8vsnihrmUl/yXMlbPHEmghlB
 sDBljRP1p4OxTDuEkt9TzxPjODgI90c77+7Xuafcp6vAHMdXKE5Ps7EVW0drX6WXowXybeOpWE/
 +dSt1zXxiud4u8gtical8KiOcWtZEQyiSdz5ieznCYrDz8ff6abl
X-Received: by 2002:a05:600c:8b63:b0:4a1:f688:a5d5 with SMTP id
 5b1f17b1804b1-4ac187a7655mr142923805e9.23.1793516542226; 
 Sun, 01 Nov 2026 00:02:22 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a66caefsm143723655e9.5.2026.11.01.00.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:02:21 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 07/14] nvme: Skip a namespace with an unsupported LBA data
 size
Date: Sun, 01 Nov 2026 07:02:20 +0000
Message-ID: <b1ae2652-6fcf-416d-8953-071c02dc96c3@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

nvme_blk_probe() takes the LBA data size (log2 of the block size) of the
namespace's current LBA format as the device reports it, and shifts by
it: 1 << ns->lba_shift is undefined for a value of 31 or more, and
nvme_blk_rw() sizes each transfer with
1 << (dev->max_transfer_shift - ns->lba_shift), a negative shift for a
block larger than the maximum transfer size of the controller.

Check it, through a new nvme_lba_shift(), against the block sizes
blk_valid_blksz() accepts and the maximum transfer size. nvme_init()
skips a namespace with an unsupported LBA data size, as it skips an
inactive one, rather than create a block device for it that then fails
to probe, failing nvme_init() and leaving the namespaces it has already
probed on a controller that failed to probe. nvme_blk_probe() checks the
value it uses again.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

 drivers/nvme/nvme.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index c815a967137..3df9b531bfd 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -15,6 +15,7 @@
 #include <time.h>
 #include <dm/device-internal.h>
 #include <linux/compat.h>
+#include <linux/log2.h>
 #include "nvme.h"
 
 #define NVME_Q_DEPTH		2
@@ -701,6 +702,26 @@ int nvme_scan_namespace(void)
 	return 0;
 }
 
+/**
+ * nvme_lba_shift() - Get the LBA data size of a namespace
+ *
+ * @dev: NVMe controller
+ * @id: Identify Namespace data of the namespace
+ * Return: log2 of its block size, or -EINVAL if that size is not supported
+ */
+static int nvme_lba_shift(struct nvme_dev *dev, struct nvme_id_ns *id)
+{
+	u8 ds = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
+
+	if (ds < ilog2(DEFAULT_BLKSZ) || ds > ilog2(BLK_MAX_BLKSZ) ||
+	    ds > dev->max_transfer_shift) {
+		log_err("Unsupported LBA data size 2^%d\n", ds);
+		return -EINVAL;
+	}
+
+	return ds;
+}
+
 static int nvme_blk_probe(struct udevice *udev)
 {
 	struct nvme_dev *ndev = dev_get_priv(udev->parent);
@@ -708,6 +729,7 @@ static int nvme_blk_probe(struct udevice *udev)
 	struct nvme_ns *ns = dev_get_priv(udev);
 	u8 flbas;
 	struct nvme_id_ns *id;
+	int ret;
 
 	id = memalign(ndev->page_size, sizeof(struct nvme_id_ns));
 	if (!id)
@@ -724,7 +746,12 @@ static int nvme_blk_probe(struct udevice *udev)
 	memcpy(&ns->eui64, &id->eui64, sizeof(id->eui64));
 	flbas = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	ns->flbas = flbas;
-	ns->lba_shift = id->lbaf[flbas].ds;
+	ret = nvme_lba_shift(ndev, id);
+	if (ret < 0) {
+		free(id);
+		return ret;
+	}
+	ns->lba_shift = ret;
 	list_add(&ns->list, &ndev->namespaces);
 
 	desc->lba = le64_to_cpu(id->nsze);
@@ -899,6 +926,10 @@ int nvme_init(struct udevice *udev)
 		if (!id->nsze)
 			continue;
 
+		/* skip a namespace whose block size is not supported */
+		if (nvme_lba_shift(ndev, id) < 0)
+			continue;
+
 		/*
 		 * Encode the namespace id to the device name so that
 		 * we can extract it when doing the probe.
