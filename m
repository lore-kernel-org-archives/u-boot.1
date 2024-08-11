Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AA1C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5E27888AA;
	Sun, 11 Aug 2024 16:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YwSWbPCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8CFA88898; Sun, 11 Aug 2024 16:53:07 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7061088C16
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39834949e42so13585535ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387979; x=1723992779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=In7yWFGRG7By2lbqiAb68SxAW7P6Ev/u7xa2rSM6srk=;
 b=YwSWbPCHtM+ZdxwHDs5zFxUFU4OjNrxhnDzNxfwHF5BfNR/JA7AqExvBEpDyJ1uSj4
 9JAZlsS6547DPd53n3/kXBc4XqQYtqBrxnHQpELeFdw1jwgfDHEKXrAJi6Uh8zSY7ww5
 RYLuj4+5X/OPGpFUTVoT/TKi9s7c6fzBIBKz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387979; x=1723992779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=In7yWFGRG7By2lbqiAb68SxAW7P6Ev/u7xa2rSM6srk=;
 b=MYTWhsXD1Obm8GjHfyp97XUrr1ru0sObOhksRgaZjLGulxzAJ7pvSXrTtlXKVd8fYT
 mqA34j3+C2HxNVtagYSB+wVZ+V5aVyZLuKVadYf2iXyym4it/ucgN1dlpayEexNV1W22
 aLRi3aiQoW2RdXs75DWVC4Qykn2AcMN1SX8pASWEQi7dAXvka1X9NgqRCYzvly79YH8v
 4PKnZgX+dpvd5vu+/YNeKIHxU2arQN3juaA8/VfT59dQZ0Gt6kSXBXFfEO0rp51jkAYz
 IOgFCHrmRIYDvitPEPDXm7CJ+icnl9TYscocyaUxA8/jC3Ggg7J5BYBM6AazBD1kdqpP
 eb8A==
X-Gm-Message-State: AOJu0YwoLD7BCsgQ0U2ARnQa/thZBcq27JZQJxEDPpEQAe60OAPG63S6
 +7EGP4zb2m0snckb+nRoPDFBenYh44QqgdWuNotP8WzRK4ElKWe0ob8lHTmYB7rd7iA3DnKxBYw
 =
X-Google-Smtp-Source: AGHT+IG7J96BJns6JlSR9pDrbGV1rvQogz5s2FicFxK3N55X4sHTpFP8maZQMXcs9brTor83cQlEow==
X-Received: by 2002:a05:6e02:1a6d:b0:39b:64b9:a4b6 with SMTP id
 e9e14a558f8ab-39b7a467abbmr91498275ab.18.1723387979149; 
 Sun, 11 Aug 2024 07:52:59 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 38/40] efi: Avoid using sandbox virtio devices
Date: Sun, 11 Aug 2024 08:52:07 -0600
Message-Id: <20240811145209.4191404-39-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

