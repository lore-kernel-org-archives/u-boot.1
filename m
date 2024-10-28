Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1243D13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 08:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 247CF89082;
	Mon, 28 Oct 2024 09:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="A7l6u/Sr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7978907B; Mon, 28 Oct 2024 09:09:17 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC3988F6B
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 09:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so494879466b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1730102941; x=1730707741; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NgXV1XiIotzzZ/tGBFT4iczfJGVItBK3vxD8bbHZRkI=;
 b=A7l6u/SrSQXD4I4R7S5/jDplnHge3elxX/Xy1tWMCYz1c9mX+tI/iG59TL/kjLrgzf
 zFtvT3/FJMY0mWT5Xb0+AdROYCb6t2/qyyt84zLMLRwiwsO6I8Ny1lujd72moIDLQUgj
 HZmitmM+Z03yQG6UGsCh9gYwkM6B567k9C3Jfuypo1WbnKoxDhHvFvDCI3dpoFueBqO1
 /UEsBKKzlJbeBkWAJe92LwUu7TCpeorAwhCbxbu0eQZam+su9ZHYNxzHSkZIYRP+zeWu
 XRhZuFV6ohEf5Xf+6GdrSr8FFKj6KwnTYYNYr13HyRa/tOEQwxL37h7ReJZuNXCNNEya
 tqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730102941; x=1730707741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NgXV1XiIotzzZ/tGBFT4iczfJGVItBK3vxD8bbHZRkI=;
 b=OMoWI2m6IsKtevAK44P3yQb6t0uypq4h9IpIcRWE1O8PtvFlR8EpE4tUA5IZcOSXd4
 OBHn0PnopD7JiGSP/5HSoSs3U9f2GRh1pqeWDjgx5hOx2UZrnpkgDM141YZPFGX0sRoI
 D51FSN639ZyrcDOX0dV/X6pWDYUrtLyB7BWZ36wO7O/WRDflmyg50MMbUPYCIZCREnRc
 ky46ur7iIhQ5JsSaUV60/QVJEmAzyA34lZJk8GLd0zRCZaHGMHW+qmROIkH4tWvT7Eq2
 jT1WIp7X+9oDIT/Zn2T574Orr01pQG/L82JX498yUGDW0Cm4xtmjQkWYJrLJxp+07zS9
 G7Jw==
X-Gm-Message-State: AOJu0Yyt3+L+upD8ah1ZmRj4uOmJItMXdnlCOXt5j0bKjQHmCah0NnVb
 LDfvqNUlrxJ92IUqWA0FJU1xCBL6OO0vsS82otbusCYIfpXNNQhXqH2yWOZ/CtPXM23yl9Sycj7
 y
X-Google-Smtp-Source: AGHT+IFdjCGm/SWrIapr50iZ7qiW7YZUqY6vouYbfE8Yokha4KzKaTNyCo1UMA7pX3KluoFo8fsm0Q==
X-Received: by 2002:a17:906:7949:b0:a9a:80cc:d7b0 with SMTP id
 a640c23a62f3a-a9de6157a62mr552581766b.44.1730102940491; 
 Mon, 28 Oct 2024 01:09:00 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm351725266b.156.2024.10.28.01.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 01:09:00 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] acpi_table: Fix coverity defect in acpi_write_spcr
Date: Mon, 28 Oct 2024 09:08:35 +0100
Message-ID: <20241028080837.1590247-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
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

Fix "Integer handling issues  (SIGN_EXTENSION)" in newly added code:
Cast serial_info.reg_offset to u64 to prevent an integer overflow when
shifted too many bits to the left. Currently this never happens as the
shift is supposed to be less than 4.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 lib/acpi/acpi_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 6473d95c10..b9e12228fd 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -420,7 +420,7 @@ int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
 static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
 	struct serial_device_info serial_info = {0};
-	ulong serial_address, serial_offset;
+	u64 serial_address, serial_offset;
 	struct acpi_table_header *header;
 	struct acpi_spcr *spcr;
 	struct udevice *dev;
@@ -473,7 +473,7 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry
 	}
 
 	serial_width = serial_info.reg_width * 8;
-	serial_offset = serial_info.reg_offset << serial_info.reg_shift;
+	serial_offset = ((u64)serial_info.reg_offset) << serial_info.reg_shift;
 	serial_address = serial_info.addr + serial_offset;
 
 	/* Encode register access size */
-- 
2.46.2

