Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE76CA101E
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A2A88B16;
	Mon,  2 Sep 2024 03:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AsqcJ5l6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D6988AFA; Mon,  2 Sep 2024 03:18:52 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18DC588717
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-82a205810ccso180142839f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239928; x=1725844728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mM6b4jc/DjEMKb2cpq/CA++G4MiJbaCRd5TdG+s076s=;
 b=AsqcJ5l6vjqTJPkzwsWJcIDqYfGjScoREAqQj2ZYInyy0bFPv07kcViXK33lr7qSg0
 y2y+j9qVonwX60y8fPi9pBbgKxiIrqzL0JxZxfBtyQKP94zZs5XJsooEUrSAVpagl/tD
 NTT2hV7LMX8m1UqzBKQ4V2I/JbXZ17kzcKqCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239928; x=1725844728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mM6b4jc/DjEMKb2cpq/CA++G4MiJbaCRd5TdG+s076s=;
 b=T1Pa7JZVbH60WEtL0jPRvQFM3T00/zzGzbmFXMHp36CQ0qz3D2t724SSfi4wrG/cQO
 LlLSD87OYci+X8oDhtwE6HJNSy2qAcc/O+UTW5I38CIN/bf2ZXpLD0UDjLR1sQl3I0jj
 Ttq0DqK+npuyEVgxzJxGrtOaWAWii3dUM2dkZIp9PSIK/mMDGYCa4z2D8x9TP6hdFV5l
 8oNzg5WEYQayiNwnHQrJ7eCl8uJ19F7pG05odiNh1csDxB1vcpPU7KSc8FqId0ZLce+b
 pi67g70KafIYAreUrssiRlNH6X14tilQDtUEDselkaiyIuL25iYB1xr2AmqIOyWGHGMl
 z5hw==
X-Gm-Message-State: AOJu0YxzEp7l7pB1j4NnEUY2oD/lZ9+79VZm+dc4vf70sqscd2nAj2gS
 PRqpqfmsadR5iSZMgkWxdXXGr9IODcm/SBdYGzimEZTuP98OEjqbSvKrUFOOVJwtPfun26jZpRE
 =
X-Google-Smtp-Source: AGHT+IHz19+aga6s4Q9YDIYkRxVHsrKjyhLtWoG6NZpxyK8eZX4JYIiZalFoHgdii6n+O84Q1B3LPg==
X-Received: by 2002:a92:cd83:0:b0:39a:eb4d:4335 with SMTP id
 e9e14a558f8ab-39f4f5169c3mr72289985ab.4.1725239928276; 
 Sun, 01 Sep 2024 18:18:48 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 12/14] efi_loader: Avoid using sandbox virtio devices
Date: Sun,  1 Sep 2024 19:18:23 -0600
Message-Id: <20240902011825.746421-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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

While sandbox supports virtio it cannot support actually using the block
devices to read files, since there is nothing on the other end of the
'virtqueue'.

A recent change makes EFI probe all block devices, whether used or not.
This is apparently required by EFI, although it violates U-Boot's
lazy-init principle.

We cannot just drop the virtio devices as they are used in sandbox tests.

So for now just add a special case to work around this.

The eventual fix is likely adding an implementation of
virtio_sandbox_notify() to actually do the block read. That is tracked
in [1].

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are probed")
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
[1] https://source.denx.de/u-boot/u-boot/-/issues/37
---

(no changes since v3)

Changes in v3:
- Add a Fixes tag
- Mention the issue created for this problem

 lib/efi_loader/efi_disk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 93a9a5ac025..2e1d37848fc 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
 efi_status_t efi_disks_register(void)
 {
 	struct udevice *dev;
+	struct uclass *uc;
 
-	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
+	uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
+		/*
+		 * The virtio block-device hangs on sandbox when accessed since
+		 * there is nothing listening to the mailbox
+		 */
+		if (IS_ENABLED(CONFIG_SANDBOX)) {
+			struct blk_desc *desc = dev_get_uclass_plat(dev);
+
+			if (desc->uclass_id == UCLASS_VIRTIO)
+				continue;
+		}
+		device_probe(dev);
 	}
 
 	return EFI_SUCCESS;
-- 
2.34.1

