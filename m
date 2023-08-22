Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF05EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6655864DA;
	Tue, 22 Aug 2023 14:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pYU9LBvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F57B864BB; Tue, 22 Aug 2023 14:10:51 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67CD3864DA
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fef56f7222so12844175e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692706248; x=1693311048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+V359K2iLM913Lw8V8G1LrDnORI1pL73fq3dWq4NuRw=;
 b=pYU9LBvMgBhBL1gs6x2x94H0d3YGvvNu+0dwo5VfSDsQf1IIm52sMSkPYj+Et2x18e
 dYbwyys5QmnS1KGFBUviXEnsowohdmUBgeJ4sYzKiRiDlzzyxCnhVywsVc1oq5rxJd0u
 1iy4qG0MUxwsslySxf1FzYc4PH9C/Flef3chsDmDbH8nThOrc/uiGfDoIgMFUDABy6jH
 YVeEbeZHZIbXCt3fnyy0Ni5w7Y8eYfCF3PVA89qdBl/x/O1R3YxplrJX63liQQTUWzMh
 XClXgF5+Z5ie23QchuhgS6KeeP958rYt6AGpV4cr/bg/qplbOmSwuickJpYBToyAtAKZ
 O3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692706248; x=1693311048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+V359K2iLM913Lw8V8G1LrDnORI1pL73fq3dWq4NuRw=;
 b=eelyqbsPIBQGOOZuEngUYdP/0SzfZ2BzRWRPJNTEW5x2IDFwtodfyLc0nwje29oZK7
 aIVHOAWPtgjvigrYncMWRR8EiXNuaSzrs9NY62OtZNIhkoFgvdqqcLjHH0VCSpWV9LDG
 3LQh2vJRAScv/NZwwxXHEL777r2h2/SqTvpMDKg65RoIhFhaO0f7tR/gY7Q5mVvA8lFL
 ikhbC0pk/6RvqgnME5+PBcN5LsJya77ZjU5UHYL2nwuywABSeatr75gBXmKSrCUIQiL6
 IBKp6gtkllEch6rBU37w/TKkUeCvqC5QJcffdqFhKuM/5rlGxmQvYDTYvrJA5Pjjc2zS
 3nEw==
X-Gm-Message-State: AOJu0YybuyAtyYm8XpuF4/lriHBzHl5HymI72HAi4MaZZIuGZJXlZlGY
 0C/g42SC54V8yPpHYXUqvzvle/RLMHg=
X-Google-Smtp-Source: AGHT+IEgHNvBMXNJoBocMoaAO7JbtGDt67oBQzmPgAUzo8GqVt/ZP0RtZV2IdUDJHUIiTfcTVVBTsw==
X-Received: by 2002:a5d:61d0:0:b0:317:f537:748d with SMTP id
 q16-20020a5d61d0000000b00317f537748dmr6246964wrv.64.1692706247802; 
 Tue, 22 Aug 2023 05:10:47 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffac2000000b0031753073abcsm15704611wrs.36.2023.08.22.05.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 05:10:47 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 4/7] qfw: Add flag to allow probing before relocation
Date: Tue, 22 Aug 2023 15:10:22 +0300
Message-Id: <20230822121026.1007105-5-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
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

QEMU firmware config drivers need to be probed to bind the ramfb device.
The ramfb driver needs to be bound before relocation to properly reserve
video memory for it, otherwise it cannot be probed after relocation. Add
the flag to probe QEMU firmware config drivers before relocation so that
ramfb can work as an initial vidconsole.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Alternatively, I guess I could default VIDEO_PCI_DEFAULT_FB_SIZE to a
higher size with "if VIDEO_RAMFB". But it exists because "PCI drivers
cannot be bound before relocation unless they are mentioned in the
devicetree" and qfw is in the QEMU-generated devicetree unlike those, so
I assumed this would be the preferred way.

Changes in v2:
- Add patch "qfw: Add flag to allow probing before relocation"

 drivers/misc/qfw.c         | 1 +
 drivers/misc/qfw_mmio.c    | 1 +
 drivers/misc/qfw_pio.c     | 1 +
 drivers/misc/qfw_sandbox.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
index 4e4260982cce..265f45290011 100644
--- a/drivers/misc/qfw.c
+++ b/drivers/misc/qfw.c
@@ -414,6 +414,7 @@ UCLASS_DRIVER(qfw) = {
 	.name		= "qfw",
 	.post_bind	= qfw_post_bind,
 	.per_device_auto	= sizeof(struct qfw_dev),
+	.flags = DM_FLAG_PRE_RELOC,
 };
 
 struct bootdev_ops qfw_bootdev_ops = {
diff --git a/drivers/misc/qfw_mmio.c b/drivers/misc/qfw_mmio.c
index f397384054a6..a5274982711c 100644
--- a/drivers/misc/qfw_mmio.c
+++ b/drivers/misc/qfw_mmio.c
@@ -116,4 +116,5 @@ U_BOOT_DRIVER(qfw_mmio) = {
 	.of_to_plat	= qfw_mmio_of_to_plat,
 	.probe	= qfw_mmio_probe,
 	.ops	= &qfw_mmio_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/misc/qfw_pio.c b/drivers/misc/qfw_pio.c
index e2f628d33830..dae809bd3fea 100644
--- a/drivers/misc/qfw_pio.c
+++ b/drivers/misc/qfw_pio.c
@@ -66,4 +66,5 @@ U_BOOT_DRIVER(qfw_pio) = {
 	.id	= UCLASS_QFW,
 	.probe	= qfw_pio_probe,
 	.ops	= &qfw_pio_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/misc/qfw_sandbox.c b/drivers/misc/qfw_sandbox.c
index 1002df75339e..0bd36acd1a09 100644
--- a/drivers/misc/qfw_sandbox.c
+++ b/drivers/misc/qfw_sandbox.c
@@ -120,6 +120,7 @@ U_BOOT_DRIVER(qfw_sandbox) = {
 	.plat_auto	= sizeof(struct qfw_sandbox_plat),
 	.probe	= qfw_sandbox_probe,
 	.ops	= &qfw_sandbox_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };
 
 U_BOOT_DRVINFO(qfw_sandbox) = {
-- 
2.40.1

