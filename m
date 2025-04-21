Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED8CC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E002482054;
	Mon, 21 Apr 2025 18:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vWmqkCqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDEF82027; Mon, 21 Apr 2025 18:26:29 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F4781F45
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 19FDE41A10
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252786;
 bh=cPviyKqqIOyQBXsrknCT452UWV+Ui7fneYH4L4kSM+4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=vWmqkCqR73YXu+Qk3ULTrRwXZoIERhzSBBTuAq2V2CLPEwaesdkzT6Ryj82stkuOz
 V9KSclV4eFyByCnRFewaohGbJ1BIVr+oaYk54YnBUAbbbWSJl9jm6M9w46vZQBcCKR
 bV+ukLHHXbwr8E4Lnr6pO1PZ85dr8FuDwJK5sbZLfyPCC+GRVq0OGsrpVtKCCTet2V
 6u7BdZ5KFuD7qRWByYrZ5Z0Z0FK7RN4FdrBKT5O/dMRg1mnO+HSJAvYCR9joXBx0Tn
 UJP4GQ4hrKBs9gPi223SJ296JleA3QS03mwinwIahphSypGE+DCKg/8H/7nNeZp3hJ
 yVTc0iZhwI4Dg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so17495945e9.3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252784; x=1745857584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPviyKqqIOyQBXsrknCT452UWV+Ui7fneYH4L4kSM+4=;
 b=t61tXnV5EtTdI9wO6J+lL7Oexbqii13UmkxhpZMkMuxutm0GvxboxrufAxr60+rTfI
 viVZJktLherc/Xp/oNZ3yUxdMFFmL9GsyPYI7IFEp8fm1kD+nN5OaXMRBs/ONYHQQt8t
 m+iAXJUOf19/Xw9whRkbzogM8nZFPpZNBQJD+BHLAqo11RoXYT+hCNDZHZHmS4WW7N2V
 uD+lYTOZIzoGo0HlFWPo4YD2AjcRLrjKDVDM1OUk5+vVZXeKpGLUYCLKeOrjDZ8C8evj
 C6LBpHihfvtEO0TXR/FlAtuNUryHOQLX39Udqdk/GyoQgA8yOkoJgUIaPSvrrnIuOD83
 EcKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXui6T7vUg4FtQzPCnptJmfzF3Q5KPyI8ZQYVETx17spEhBzxtBLMIZ596ESRJIjrsJLPEqgC4=@lists.denx.de
X-Gm-Message-State: AOJu0YxjvLekFF8zY5WyYu1QW/vJAxuImDWch4buqAnto13MloY5GL8b
 fT674LAGSZmpoYHU+jMajey0IufokRsAqVTRfwfbpldRL3CGHKocWKYABSJTqwVfc94j2/vKqWw
 oZkeNBf59hgtYXDPCXVnbq9/lmRC6EgnglKJ1wZ4CdookNjOe0tQ5PWJi+upFI5xzpRM=
X-Gm-Gg: ASbGnct8bEwr+DqbZhppPIIf7i5qREw3XyWkUfI2eaMYhULdVWI9AURdiiPGOwPvhlQ
 pzGzQiMaq8oSLOK28z8wCX9fQcvTnmJU4XfNuZLexAbcTd7m5MdN+RKZmw+gYry7kebArMnjP+Y
 FTGu5E8dOfQAushqWpMYlkkx8yax2tbipOkNaH8rVzsJv1QqHdx9ofSnIkq4dx4a4UTewqf6kgX
 XuuByL6eV1JR9GyCKM1ELY2J902nTdgrKjbWjlVGOr1vUmUXeCcjVBLwWMRunMPtoAztrDkGP3v
 /c9FGgkvyHehMei5jWbR4xkZW0arAXGKhQrK3iaBaoQhMw/VzLY+IQz1kNAmVxPsk6R22yPRpMg
 1NGhJY8Cc/8btxA==
X-Received: by 2002:a05:600c:54c1:b0:43b:b756:f0a9 with SMTP id
 5b1f17b1804b1-440711cce0emr65282815e9.11.1745252784414; 
 Mon, 21 Apr 2025 09:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuBt60clrz7enpxvrpoPPx1looQ8fcgRabDmylzFKBKlRv/h7Y61XTM1vEnnbgpAWgGjdtxw==
X-Received: by 2002:a05:600c:54c1:b0:43b:b756:f0a9 with SMTP id
 5b1f17b1804b1-440711cce0emr65282675e9.11.1745252784105; 
 Mon, 21 Apr 2025 09:26:24 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:22 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 6/8] boot: make EFI boot manager bootmeth non-global
Date: Mon, 21 Apr 2025 18:25:53 +0200
Message-ID: <20250421162555.1200687-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

Global bootmeths are called before all device specific bootmeths.

To move the EFI boot manager after the block devices it must be non-global.

As sorting will be controlled boot device priority remove the digit 3 from
the name that was only used for sorting reasons.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootmeth_efi_mgr.c | 3 +--
 test/boot/bootflow.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 1669cbed5bd..8f1d247c942 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -82,7 +82,6 @@ static int bootmeth_efi_mgr_bind(struct udevice *dev)
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->desc = "EFI bootmgr flow";
-	plat->flags = BOOTMETHF_GLOBAL;
 
 	return 0;
 }
@@ -99,7 +98,7 @@ static const struct udevice_id efi_mgr_bootmeth_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(bootmeth_3efi_mgr) = {
+U_BOOT_DRIVER(bootmeth_efi_mgr) = {
 	.name		= "bootmeth_efi_mgr",
 	.id		= UCLASS_BOOTMETH,
 	.of_match	= efi_mgr_bootmeth_ids,
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 5f9c037ff53..db35dad10d3 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -395,7 +395,7 @@ static int bootflow_system(struct unit_test_state *uts)
 	if (!IS_ENABLED(CONFIG_EFI_BOOTMGR))
 		return -EAGAIN;
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
-	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_3efi_mgr),
+	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_efi_mgr),
 				"efi_mgr", 0, ofnode_null(), &dev));
 	ut_assertok(device_probe(dev));
 	sandbox_set_fake_efi_mgr_dev(dev, true);
-- 
2.48.1

