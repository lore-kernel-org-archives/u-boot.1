Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DFDC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E350C88A9F;
	Thu, 15 Aug 2024 22:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lb0Biez5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D55388AF8; Thu, 15 Aug 2024 22:24:49 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BC288AD4
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so87958939f.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753478; x=1724358278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XqkbqGb3v30A3r892OR+SCMn8Z61Z8YGPd7KLyPob0=;
 b=lb0Biez5otuIKJbgrcwcPBrILQcnSUeR94nwjGZYMFz06mG7bkjdjTu6VFQZ7StX3p
 ypGrnvqRFcFYENUOowAgAkiG7ywtDfTp2nlAQ2lgpgXcwMVRJ8YTeekQEv3MYIrbErWl
 mVCe6ZeK7rf/ENTkAfSS9gBISwm24i8s3/ikM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753478; x=1724358278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XqkbqGb3v30A3r892OR+SCMn8Z61Z8YGPd7KLyPob0=;
 b=L6dcYrwft1vNQd3VTsg+wT3t+6A+Luz8snZ4a7AsDumVDc4ECvg21CS8MqXLShAG2P
 5k7WcopB9sH850vmxt/sC/tTQTAOUwAn6MI2qNG6K3+m8oorHHQ9ImmTuM2p/g0h1tdo
 HhIXXnPHl+QCIP+lBegOqUNpAkxrsbzQr7T3pqge91ezar4dLJ09aKiFOdpvUovtmK0N
 ANNabiXstObk/huQ1RlKlFAeV0XFDPeFJ5E7bTbKBiZzO6U9xVbEh9+fBbUeC/j7/jYa
 QpARSTxmYPUqWqNe1jSacdbigy1XXagfD12cBuiBsamMB9yIoHkwPg2uwXtwieFluz2n
 7egg==
X-Gm-Message-State: AOJu0YyiZHg8elDKl/QdanKYsaulOFvj9EWEvRxP4kpB+wcGgbtOi2Cr
 PgMNLRZHj8a2SAVmNs5Zw9/lvr8TPE64JN+Q9GOjXsOyWOlajMU2htHNaZtrArxntnLn36n97KS
 arg==
X-Google-Smtp-Source: AGHT+IEq3GKfAL8pwmnP8bHo4kzjRggu84p9uSHqcIP60tkSVkrFIXbLQm82QEoAIS2HH+TWN+/F5g==
X-Received: by 2002:a05:6e02:1989:b0:398:39f:8b4d with SMTP id
 e9e14a558f8ab-39d26cdec89mr14639915ab.5.1723753477682; 
 Thu, 15 Aug 2024 13:24:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 12/14] efi_loader: Avoid using sandbox virtio devices
Date: Thu, 15 Aug 2024 14:24:22 -0600
Message-Id: <20240815202424.766778-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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

