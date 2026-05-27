Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ACDCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC72848BD;
	Wed, 27 May 2026 18:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QySFFQte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A29848A5; Wed, 27 May 2026 18:11:30 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B9B848B0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de44ed7a11so10769680a34.1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898287; x=1780503087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+NvwlUpcpgO7DpKlH06Y8IX3uMLdwhpCU9HjJtrKp4=;
 b=QySFFQteEr2ibRM8FHzAD+RVxXoExObXNDVIydC/HVQHDccxZzkN0yjt6FAHDukNpw
 FP7CMV4bQXAWfgy8nziBaXwC3c3Z9jNR2Q16Zb3aqmAVcE3hBIHOcwgIhNZ5GrdLuyxg
 LCvIj2Wfy2CU+Z9+4VfNOiHMNmp7rGFsdwsZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898287; x=1780503087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+NvwlUpcpgO7DpKlH06Y8IX3uMLdwhpCU9HjJtrKp4=;
 b=cYBpZfuNNWBbUaPiBep75cpl18Qn1SyykY1ALGfzpaxCaUsk7jRHue/pVO4a40t3Pe
 ibGgkUDZLsghBv+2sTpII4Vd0PAeHHtGA30aMpp+AeVVOc1lLTGPfPWErPiPRvHeb9FZ
 21DTUFzZtNPEx9MDJMunYIGdg0AQMmkWhnHfTkRDwiXAw86m+juf+UH1fxnKjV7mCy9Q
 BCfUm/FAwZzEye+KUbQ0zrrqXgZAtr906BgGIwC4qxnUT4n8SiPizg2nWrfco7jMsQ5v
 6xdNyryIZPrIiMKWtdiyYwU1KYEVX0mIiBGOB/5FAoYC9pmYF6o4hgS+SgN/AF95tcnl
 Bvyg==
X-Gm-Message-State: AOJu0YwO/Oyttt2bSNuuqZ+mwF2E06b6B3PrEw+M2Ct7mNm6NjYyBcT1
 IKVMX4RQL0yzMB3geBkEJftZnLzuvn6bubh/JMqhamwAGQzoEtj407hPD1ZroMX6bPGU+Hf1dBC
 4fTyP3k4GBeU9JA==
X-Gm-Gg: Acq92OE9bgx6HgTJakUTwagxa6DaLkpQkYNuMs5eT8RPhrEIUSeSgGv6yo4cCrcCS6n
 olGmkFPJFcMEgMNyFhz/atJgpuveNgzNmVfAIDZkl1vK1tS9rqyes935weXx/fNO6O5n4BKjYG+
 1AWt06TkzD8Bsht6nHTochSbpBNgULrGJrTSfPbLkZCR/60K9ZUImUmeLxIwLvQf6p7up34bOYj
 YWdPO75j/+4LXmwmhLrBaVI3ZKiAh/aBXLgsqhKQBGy5OtffvhM325YrvuEbbJkDkqEsqU2ZXeD
 ZwnpCbyP8nx6W1uZmJ3QQNOJjx/OnZ0Om/sg+hSzjYClexJxGfGr1MrY9YjS+Igkua/Yx2tY2Jw
 1SeTkUBK5D47f0A0g0tRmJuSoHN/G+0bejaZphYRmBrOJpOz79X0T0nNgD2Ne49bHIirJLbeTNq
 EiMtCay74Kz6sfT1fR+YKnZO3pzJ1e+urZ9+JqST8=
X-Received: by 2002:a05:6830:4126:b0:7de:5bad:ace1 with SMTP id
 46e09a7af769-7e5fef5b201mr16973568a34.12.1779898286703; 
 Wed, 27 May 2026 09:11:26 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/13] virtio: emul_blk: Free disk data on remove
Date: Wed, 27 May 2026 10:10:21 -0600
Message-ID: <20260527161033.3273795-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The probe function allocates 1MB for the emulated disk contents but
there is no corresponding free on remove, so the memory leaks every
time the device is torn down. This shows up as a 1MB leak per test in
several bootstd tests.

Add a remove method to free the buffer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/virtio/emul_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/virtio/emul_blk.c b/drivers/virtio/emul_blk.c
index 62ee125cf3c..ec5e715a460 100644
--- a/drivers/virtio/emul_blk.c
+++ b/drivers/virtio/emul_blk.c
@@ -154,6 +154,15 @@ static int virtio_blk_emul_probe(struct udevice *dev)
 	return 0;
 }
 
+static int virtio_blk_emul_remove(struct udevice *dev)
+{
+	struct virtio_blk_emul_priv *priv = dev_get_priv(dev);
+
+	free(priv->disk_data);
+
+	return 0;
+}
+
 static struct virtio_emul_ops blk_emul_ops = {
 	.process_request = blk_emul_process_req,
 	.get_config = blk_emul_get_config,
@@ -171,6 +180,7 @@ U_BOOT_DRIVER(virtio_blk_emul) = {
 	.id	= UCLASS_VIRTIO_EMUL,
 	.of_match = virtio_blk_emul_ids,
 	.probe	= virtio_blk_emul_probe,
+	.remove	= virtio_blk_emul_remove,
 	.ops	= &blk_emul_ops,
 	.priv_auto	= sizeof(struct virtio_blk_emul_priv),
 };
-- 
2.43.0

