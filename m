Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iWJ5e7Ll;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iw85/x1l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 468E360AB8;
	Sat, 24 Oct 2026 12:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yOSypzROo6ff; Sat, 24 Oct 2026 12:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B88260AA6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844227;
	b=ggAYlCl8D162ZMql5mxmhk5qV1G5+rRN9nDtOgrc+K2DW//vWqmz44MB4qSLT0VqzG7u
	 y3VXnOj8jAti0SgWq1raWps0BJ+wH5K0O093cphSF35U+9ruB4tHxXkoKVDgwJfI6mx8M
	 DoHgpwguOd0V7bAugukF5Q2H5r5TFDYRogM8iMKHnXNgTgh+AOdV5tS6uKlDptd4W4kzA
	 yziy1e6EeFCC/4pCUIKZRV4qTAnu3lct5FeszWWLxcza5osmBUsWD8r+jAHGAGE7kO9lq
	 GJXIupQpMlr4Y4ScJBj3q/EFMaKS63MwFs0NTlr834cFGZfnYhxgZGhi0osVP6VSKSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GBQQFIUaz74J99pw4qURDx2InHmKQZjyDhDfHiC2fVM=;
	b=EAj4s8INTOgaybvAKmZHeLjFUOCfMkRKvbNTyWhRkAM8LmvNflv80qBDnSIk/SMqjv8k
	 ZNmwE1on92Cp5IJ3WoQBvsHlP84FpR0L7LvKuIg7JTrDQM76vufkYWFpUYj8NAWjmq1tm
	 E7JEpcL6v3j4Ut7+mVP30HF/DQqNXM+2QyH6foVMOyF2gmCv0semuxmrqrrQLDQKoxH9j
	 OOeEKkijEgXS6fKIUCIfpu4RrPgkfWYILmB+jDorXjAYYZQjARSJnvwd5uLbEBOdxR7k6
	 Pri7TOQd2krBq/Az9skXGwQOWsi82NieYRuwi7n2GQC0uMmz47iPx//xeZ3iC0hCPnA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844227;
	bh=GBQQFIUaz74J99pw4qURDx2InHmKQZjyDhDfHiC2fVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iWJ5e7Llb2qrGNGXaFlIBQP89nX/4bGqJ2oTvweQDbM2pUElHm38sByK9OKEGeVP6
	 OQ2fsR3H/tUYA1cNVv5USLHCT/cLdw6x4iSHnMAHAgb3nfNc3jQpJVQTNqpbDVDCod
	 wERFXT1GzDm/gWO06MMbo3HVLLfXlgOxlK2tUnQ6x2WoyyThFYQ4YZtwNWrgflQQfy
	 uAXqm6kcL/9F+8oikE0PpdEFRBUtweQDDov9upqQXibV27ZoOfQH3XdeYH2kXa1sHd
	 trRvblTH4sE4v+K3Ian/VjDUXqBMI2yY2DkE6+ks9USufteAYMVyn6/GrTKuz8ThTG
	 SAqMZaPeGgBxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B88260AA6;
	Sat, 24 Oct 2026 12:17:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3A3C765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B526740A84
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1RCKoANoQSs for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA0A940A04
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844225;
 b=fRlHDZP3qEEoyUbq6CMpWb0s0MiWmYJ8nBtbDkOeIRrOP+g6jJszbL/TdE3T8dODxEnc
 4NWPI/sjhTDojI092jsQmE8oY/wGiOp3XJAXiwq4DvAClV5QfEMynvsm7sBbqqWxOZbwt
 GYiB8gvPMwC54cqOBEhv8SpHTG0HLZkt9bgQ5/lP30gdqey5sIHWQlLaCAhbEFd7/DBiB
 i80H5YL4+D8jHDEVAreurJUZlbrOxe7o8D8Jq0JMygX1q5sTSvRRotzfIELOa9RZ7whLk
 JhbU/L4MciBv9mf02YEi7SUGEdqrSfZTBYv1p9OEg7+yLa4HxjaNRLtbRi6FCLA9tEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844225;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=GBQQFIUaz74J99pw4qURDx2InHmKQZjyDhDfHiC2fVM=;
 b=d178x/NelQIaRpUZv1kt2c2w70Ifwn5FGvDIu5aoDBqsw8dAC14EivRAkBXzlj6Pdf8Z
 NGl0SXTMsUo4IXmihJMfO/MM1t8m4i3Yy5y6sd2GsBrKwsUW/FmpDIS3cbgOXPsPKvHnI
 281F9Sagsj2bIo0PMXysNqutJRVpc7LRDfkxxPuH6lW/fNw0CsclyybsiDDiVIeCVogyZ
 45rFBxHXYw5hhEoDwrtTiqVHavQ/7DKdmrYSmS96dtSmXEYrnH0N+BtxejSnyTweK7Zz+
 PlOs+PQGOSO5qr+n/CF442ldRGWz7H/j7iCLcrRut2qpHqprgnopgdI0QiInH4FJTLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="iw85/x1l"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iw85/x1l
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA0A940A04
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:04 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so11536715e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844222; x=1793449022;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GBQQFIUaz74J99pw4qURDx2InHmKQZjyDhDfHiC2fVM=;
 b=iw85/x1lId1GZ2W6/mZ1H1OJZF+w4OtOiIc2CRcCE1+tew2SQWy3ISYE5OaHkPOqOb
 ykNDKmtVawobgc3UWbocawXT2ZMmeGWzu9X6fvttYl9UOYyF8DpskjSA17EfQe/iQGFz
 WcJFAJllOoSmEitxh6apv2NKnra7Q1IQ1SF4Tmj6++LhEXI7EYW8NOpfXxqXt53nolyW
 EBdxuQn/IuRlqIToY9MD6ahioVSXQ+RlEEfvHrA38TmDnNhY6B2v7GIhryj6/WBelP5u
 ZtRIEEqjbtq+nHt71HIDQmi0puHW73dOGEuaVRv+F4yYf3lBPl/aEvm4+WatLIm+JY9M
 d7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844222; x=1793449022;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GBQQFIUaz74J99pw4qURDx2InHmKQZjyDhDfHiC2fVM=;
 b=VzWkSzZPcu0aHXjn9abvpO90XYT6RS/FXaxHYVFoy4tlTZuIhTe969xIeuVHdpqNyi
 dxEgpZ+A+tOpM/QMoVHvCkJ0TTBY+9QelvPPLxWwoi8BNmXQkB4tTtfXkB5Ubz8eZqZu
 WJIHnUcOOyUL7W7gwgzaTZzoECBYGRU5KbCVfbeir8EU+GfzFId//1h9azNkDSjM00K6
 0f3pmMkAFLvgzRYSrRib7n4RB0imnNQ8YeviyZWaxEuJMumJkFx15kOPRoSK73lSPf9A
 UaPQ+wCOuhL36I/t07gtOf5a/dEoZoB1vll3wUOmYAMsVUmfSxsqv5xnB1X+2Dkj4gO5
 0PLQ==
X-Gm-Message-State: AFq9FYI9pdZXAxLN8au7o61FvKUzkVz2GNdP/q06X/rph33ivRKVTW7A
 Hzm2YNybn+bMuZEoNGA9cQC9DZePmJWKmYTUsIVdbff1pIzYaqM9foTl2yUKhB6b
X-Gm-Gg: AYBFou1QT6k2Bug1S1RRr7XQIrFGHp+tmEPTaJ0rx7L9RNspq7CV1B9JvRHltHq9m4Z
 5GyuZuOWQTw4M+ZD4w7ISCBjTwgk1iJJuZUKXLH0kUoAjd9h3N9xE3dTcyqXNChWZ7UZ8oNlgJq
 r0NlsFGQX+xivkYFSwhae6Wv0DMRBESKKieD+EQxeHnQx14aFWi7litLNgeR9b6H5klsgNEvq6A
 erxJYqlNoYZwoJlXvJ4AiBkLw1i44I6RSKJlAQ9P8KWDNVffWtP4K4uSiIdd7Aj7s09aobnprBa
 zm91QEUTC34Pu8fRVgZCCRlQVtjplmXhIblqmV/Y3EHO2Ij+cD57LIEg61Suf21EcVZA9dgsFgH
 Bb7vvNgeGzGVYruxMEXjihp/B7b4sLltVeTLn8p8TeF8esVyhv7R4eenNSYM3/td4pRNnYnmEbR
 NSYoFYtHDxUBXawvSUEjHzmAwqGzqELkDC/AiggrCBHuNF70v5QznJp8wM6m51Wau3ZGFgVrYNX
 ayik1EZ7R1Hz80XLSthgdJXMykMpxq5SAqV+WiC4T3vhZ8TSuUHM9HMyA==
X-Received: by 2002:a05:600c:4e87:b0:4a1:dfd4:9429 with SMTP id
 5b1f17b1804b1-4a35acb1151mr33146645e9.31.1792844222296; 
 Sat, 24 Oct 2026 05:17:02 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm40615515e9.1.2026.10.24.05.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:17:01 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 5/9] nvme: Skip a namespace with an unsupported LBA
 data size
Date: Sat, 24 Oct 2026 12:16:59 +0000
Message-ID: <2b8522f0-65b4-41ae-8bf1-adf794c7920a@gmail.com>
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
---
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
