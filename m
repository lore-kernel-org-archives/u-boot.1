Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CEFC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0475888B42;
	Tue,  6 Aug 2024 14:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jAYsVNYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D3288AD7; Tue,  6 Aug 2024 14:59:55 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5ADB88B09
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3992195d08aso2352265ab.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949191; x=1723553991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dV39MO2k/if1C6NtK8zP1drBL/9QnD99z4lv55Oh9ng=;
 b=jAYsVNYf1BaTW7wu7n1AFx1Agw51Tobyk0d5UfX4gG+TfF8+8Ef0X0ulwNrisjohMG
 1i+Ajmzi9ItEJgGGfguZyhtn6AJ8W5RQ40F2fHwoBJCy7103ea2+7IROBmAm8d6YBYvZ
 5/ErsBxts1mC6ULqDld2LHET1J44f7qUMshBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949191; x=1723553991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dV39MO2k/if1C6NtK8zP1drBL/9QnD99z4lv55Oh9ng=;
 b=mX3+FyKAO+6J7PvGi4M4lOBVig8wfR5aIX6E7KWElTrsAvmzJRbehkp3X5ZParggCH
 pP8Jzf9AlyXbVAk5bdgC/0PSy+P+RmoSipZWv0X4jIvJ9NPat/LLoA1aVCToA7h260u2
 32r4orTrhwqgBxA0Xi8vdny35NwqyojXH2yDi7np5xa1sdb5vyCq0OXzbtdZ8djfu3hj
 HuPy2P1FFv80nbvGgWTWmGG3CZxbjYcrcdNAqgEEJ8/c+2CTSGZLAnPhJN53+hKVszKD
 /YUcj6T8LwTv58kJV7JLyWRqIxax9pyGNqQF+NfxyhXai3SKwu0f3eqRA+/FZjqhii65
 6+uw==
X-Gm-Message-State: AOJu0Yw41lUZW2q6D6qAy9sFEzqxiwoZxK8oyjbaLwM57eXUbDLaNYad
 UbEQesuKw+ql8lTAhF7QS9usniNZQSPVlwyCrPl5CgVx6KCWY76ZMc69s2Pjz0L8Cps/ZWqqtgI
 =
X-Google-Smtp-Source: AGHT+IFclAVnZ9Nzv9imW/Kn71PFGYt7sxIIG9ADxwcj09jjkLs25HuW2s3Www1lukkK+eJ6u1edtw==
X-Received: by 2002:a05:6e02:1a89:b0:376:4049:69e5 with SMTP id
 e9e14a558f8ab-39b1fc12bd5mr208916745ab.23.1722949191086; 
 Tue, 06 Aug 2024 05:59:51 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
Date: Tue,  6 Aug 2024 06:58:48 -0600
Message-Id: <20240806125850.2316956-38-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

