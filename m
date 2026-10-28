Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E652606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hDUA/Y7d;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ziKBiuky
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37B1680F8D;
	Wed, 28 Oct 2026 05:51:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ngzDFVrFFIFR; Wed, 28 Oct 2026 05:51:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1DEB580EC7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166705;
	b=YpTuh9SCkfb6uuhHp/JgFj/hXOomOscX540bnYeIWqSpMHkNpkgpjGOVhwxBKMymj80t
	 4VnE+AZ6zYdFC54mTXdrjBebY6oZDx2Q/bEaHWbdCzX1n1owMEkGauVe9XRuZZOkix/zs
	 es8wQm87JG+TDhgnVLa/oerCp+k26Vhd17ml512+cWCbBJyDo0D7xBGcXFpRNa+OQ/GK9
	 S77r1TcTOyc3CEpEgX+T+pykFAwsd4jLt+eKLBD4oCU4zdgRWHAK9t+ADuPSrpW42IOXW
	 75YzteMW6lbZXaXX7WebNV8RUnPz7qJRFsRZPATqPBKZh6vDc8CcteVaJ73ggwm5Emg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
	b=qREu2xhVjQ1VbVCirxU1jbEKdvo4Kd7cBsCK4dI2jFMs39hBcQkeF6y86gZBiGNdhjCV
	 OTTui/tOxaMRgvWf9Y9aRsfClJ9CVUUXY/FlSH69Pq1ms1Vw8TRZ8sILvf5CEfzlMw317
	 oTCv8ivp+SspDqqIY3gNVBWvvD6sHP/WKHQQML1iehSWb1TL911ARRtWZPaXyaPV73+My
	 PAsFYeWm7lLx7ygX/s+70agT7MQQgZz+XRDtJkvuCrY1uQekBAboJUtIrYJfTvrWfixAn
	 zRaIMoL2/7AdUK6wgwKIaP/HKYs1ROZTjHLdAbnx96ivJZImvPftI4HjpAXbUCOdvcA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166705;
	bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hDUA/Y7deJbBJgULMAzwPf909QhUFZcuB/1ISpzO5WPjdKZu4xNO8dAGK3Qh0L86h
	 mO609c6ELDZeO2eBFcoGaASOJKJjwMzAcdXEurU111OJNvERvm9lp5pBXDEo6sA/w+
	 B/B5RH0aMRL5YGvqEsYV626dTYQDPVbmsf2ARNhjSthZ1e8d/6BgN2I92Y6jO9zy2p
	 lyGXpJg/JcZ++5/ng5SN7+uGTDpetSw7nSHfMLxtBsjNcopBH1kYR35TYXa05Va2RU
	 +IoDSn3vjmo4NsQHbfuTcVHWF7WHJOBL0c6jMhgzf3urfvo9tBre7OhtH9obJfsKfu
	 ykyTi0mMkXmrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DEB580EC7;
	Wed, 28 Oct 2026 05:51:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D633473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32FB6401BE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0sywcmAFhd0 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4B0AE4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166702;
 b=T82uc4IAgXyJmHsCsdbf6M9En1s4cqfSbSF/a8kTQ1YGPmwyqvDQ+gdT/wxaxDfCkLCA
 TZyTCkhS/k3kLxtuPgRYn4pqsVYJgGIGUDhpmtRGPBEVz+1w8X2nm9rHAKsHw1k31+cZx
 vw30DbGmU3em/vG/cFotrucd3RTdhNGFoVer8g7ZGTtQyG/L9TfH7+iH5ZI2qCQjTiDrz
 p9kOXB1Xf6id78YdAPO4RqUepLXmimNuAG1xI/aXxJ24GxR0pwVZhcFiXSXykzjTFC7/n
 5xYkTWjhYQ/34uzJbpbV/8f3lVKZWN1cnyuQQ3jebQDIPNYFL7O0nXXDN0KR7+E9Ukg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166702;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=jGAvRusr5bhYNKPu3l9ICGFEuhThzPy9EPClMv/49+HqFrgcwAnqIeYrz70g7D1up9WQ
 w9ObKXejiCLjx1KHApQMNhy57NF0qHvOKPYTci3ZLM4IxViRmqSIA1Je7t46mKVwlDwjM
 sF6jaYHd0UPHSgAA4lQRVZCoDJRKb8ZC0QMPmqMgDb2MHBlA5Uo1w6BH0v8USaNNxA3Ea
 zmWYuos++PAKcIHp8Olrg544wuSu/lQnZ4RFXM97fNzc4PFg4L64NKSD/ECIJtJYZSgOv
 n8GM5CH2Z9yscjU86EWMLF7cyuk3U/FAI3dkI2y3y9TkVAgzoUaUCAAR3W+ePNsZNlg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ziKBiuky; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ziKBiuky
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B0AE4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:41 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso3443115e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166700; x=1793771500;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=ziKBiuky7NgAtu0tnBGgtk+F3a/7aIaHeplikCjTjoDtjixxw9cuH+xNcld2tkZZBC
 SwehJYemtZboycIJz30YmMCLRPxjG77QKaYLNyH1h6gMyVD/dgQDUZG0lJKfBX5AD0RN
 Wh/IR2foCeXoIud3rLk2TJjAzqBbWra4zF9dVEaYZ/k9ayHCPfKhl0rP05C7J8i6iz6F
 TMZI4MkHxMhFRyZ/MbhvNoCMBwt7bTlmDYPERePIBjZOv8G0XgqsQmmb+Co8WqaAbd41
 3pru0Bnw4b1u6iftrTnshpbOQfox1l5TdC/9RAg5I0nFIH5kAp/jJtidhk1Xjvhfqa1g
 0DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166700; x=1793771500;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=RWKu67giIE59tuRSOLIOdGG3Q2cvHAH4H6zPYYz8tL4SEUmeVKfb3BjIx9BHVSjmGl
 Sp5f+N3l3sigWlAHWGdGMsW29Sw9A2QufBlO3MuXtxhh1BSe8/S3QzbnN4/EUOt9zR6M
 abFRZZejBmcd1LyKUherhnwCifCqd2DpB2UflcuKI1Qbjq+amrAxatafDcOieFW7x5bC
 IS1K5f3f8+7f+m3DCGyTCvW/ovmasLbs14k2ix21dfpZBXcHdu8RpjVqtfdFn0OODuZl
 AV9XCSVFZWsu1/xEswbdVHAyyJE3P+px/CufmURaGUgREExOceSSFqQ05s294nKiceck
 wWWQ==
X-Gm-Message-State: AFq9FYJ6We4bNU4VYvaIsL2PBK4Zn2oeQjADtKD38fdqlWcdpiFv8YUh
 cIWIYViHjvIREYkHaLScDBACwlv6bFb5qKUZvqeE1dJA7o2TIqOL40A0
X-Gm-Gg: AYBFou3LL6C7vaaPr3NeYbmDpBVHZ2PvofGsIzmH/9b/tVMUXyfLJ3wTY0puAkNQ5zs
 BWaFts0HXWZdJZFbxhjiygNfUWvkagYHR0DwPjrQm7BurieCvSsc/PScbi0dzv+u39QEEz3NmyK
 U4hoWlMWvuvL40+yPZXMOEhMLCdhP67yb6JB6BdSqjxhTSNCZZ3wtW2ccJTXQpGSFuVRlbF7ViZ
 cUy+DTXSTGrIwlz86dXeivXUFzgMjpbUTW3uFuBolGVS770LGOGq3L01D/gq+Ef5rJnJVlk5YIO
 5f0Nk6q+JT3TNB4m6qbjgihciVNBWtZ0Dg+8A3S47vmadrtPWejBQRZHbj0a5DHwMURyl4ccHGu
 9S/yBdbPQAZ842e5ApFuLCB5pvwAwf2QTBVx+POW3Pk++nYL5gU8Po/qwmzYP2V2svNlqEhElM4
 AgKYLSW/3PMahtwcjQleyNeyZSkYT5oUgThBeUtDu8uCE+ut7PgQR2giTapMpwBTbTRBQzKjqi2
 HciwxfFu/w2xad0S5P99adE+PZgYpHUNYziSmqp3dNSxLXYnl5EPRwEBAiif6UMl5T9Flf+Z2UP
 xBjnpCUEWFiq3jMMNwm80V5/sr0g9a4=
X-Received: by 2002:a05:600c:811b:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4a967e8c045mr21393305e9.33.1793166700031; 
 Tue, 27 Oct 2026 22:51:40 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a977edc20csm16882035e9.3.2026.10.27.22.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:39 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 07/12] nvme: Skip a namespace with an unsupported LBA data
 size
Date: Wed, 28 Oct 2026 05:51:37 +0000
Message-ID: <5bdc9bbe-e232-49c1-a1cb-d79d952ad6c8@gmail.com>
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
