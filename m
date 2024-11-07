Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C037D5D68A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091E888FBB;
	Thu,  7 Nov 2024 22:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Avd7Qy+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4804B88B0A; Thu,  7 Nov 2024 22:32:27 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D843589048
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a6ababa9f7so5943055ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015143; x=1731619943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yAl18TpcL/FIJTPaWjyxbdo5khZJDAvqwQovQ0vqOQ=;
 b=Avd7Qy+iy/7ckmRU8cpgrBh+kWE7udjIgamjnrBgWkFl/bvg/dHoQbto4Aqgbapxvi
 wDP+ZzRjrp6NVbM1jtpozKmw+YEWgeC0KgB4JnkqEvzi/raeFM0TX3eOjP6TUw5Xy3hc
 R2KKDFx7dJbn0S+vfEoeRzF9tZI91w8voGFr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015143; x=1731619943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yAl18TpcL/FIJTPaWjyxbdo5khZJDAvqwQovQ0vqOQ=;
 b=uXrzwFDj3sh9EiiQD4eJQX1pwvn/AiwyhlIA2IPrL4CeAeBJ8x07xwPvRKbY9Q9eTA
 7yzWwoWRyHh/V2oYDfoz1Y0LX5FW6rTeAxvvayaOI+96vfIXgBUDzOA1QfYfEE4UGDwh
 dIhAkjukev+3+qbGhRSBUSzha0yM1DeqWus9L+X9wtaZBS+wthElTM5ydElcC09I16sM
 9ep9D/XZ3kSocVKSpNbSmXRaO8Oyo/fCADTz1MPm6uucINoK9Xu345U86w63u22kMJpR
 LXvq3UJ1yLgOR+BkrdHy2+pFTzh14d9y5sxwlyx3sq8mvIadvqY5aoUS/juZoOBNpbbv
 dJoQ==
X-Gm-Message-State: AOJu0YziST0/JOYWgmJZ5MA1Q3DbaC2OWcWayokoP9tiOTUn5x2OotrH
 3oggYgET0LLGj4Zg+M/TtaodJgR6wyKcdGfpoTGzCOevSu8+2qyklnJJPQ5KdCfNAMNR6BejyC8
 =
X-Google-Smtp-Source: AGHT+IEzY+RhUM05FQEp8n3/vfOLk67Go+nz7Awetnv7ZIStP21udYOnAKQF1cED/XiQ0bukFIVgMA==
X-Received: by 2002:a05:6e02:190e:b0:39b:330b:bb25 with SMTP id
 e9e14a558f8ab-3a6f19e2863mr8732795ab.12.1731015143067; 
 Thu, 07 Nov 2024 13:32:23 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v10 08/10] sandbox: virtio: Disable the sandbox virtio blk
 device
Date: Thu,  7 Nov 2024 14:31:48 -0700
Message-Id: <20241107213150.1711962-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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

This is not implemented so cannot actually be used to read blocks.
Disable it until it is implemented, to avoid causing a hang with EFI,
which probes every available BLK device.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Issue: https://source.denx.de/u-boot/u-boot/-/issues/37
---

(no changes since v6)

Changes in v6:
- Drop the patch to disable sandbox virtio blk with EFI
- Add new patch to disable the sandbox virtio blk device

 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8f1f4667012..c39efb4d0a2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -212,7 +212,8 @@ config SANDBOX
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_SANDBOX
-	imply VIRTIO_BLK
+	# Re-enable this when fully implemented
+	# imply VIRTIO_BLK
 	imply VIRTIO_NET
 	imply DM_SOUND
 	imply PCI_SANDBOX_EP
-- 
2.34.1

