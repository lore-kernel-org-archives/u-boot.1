Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C187C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C28880DB;
	Wed, 27 Mar 2024 12:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JSCrtswz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1499888058; Wed, 27 Mar 2024 09:11:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E9E8805B
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wefu@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711527081;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sPc5nIhOyJRZk8bXxj9IIZ+OkxKJMNiI9c4dTZ22cs=;
 b=JSCrtswzG29298fvbe3mfOsMAurUk0l47CTs/nuwhet6G19h+NbBMTaZd/TfDs12CVJ9b9
 reKSxnb8MLkL+8BUIoMqvPM/WZwoPW3mz8fK+CE4bT2v/P3b8Ju5PHVorlGg1ZWpydqvku
 zU0Yyp56/dO62XKHViQjInzqCFSySYM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-y1ltTz7MNwWzxTHlaw9xFQ-1; Wed, 27 Mar 2024 04:11:19 -0400
X-MC-Unique: y1ltTz7MNwWzxTHlaw9xFQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1e0ac20241aso24574425ad.2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 01:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711527078; x=1712131878;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/sPc5nIhOyJRZk8bXxj9IIZ+OkxKJMNiI9c4dTZ22cs=;
 b=bOKIPuTjtRv6rh+7G9O/Y3QmhznSN1kx2W5/wYEkIv7Yb8H9WDi4G8kaOxs4t0AbLK
 gSe1feDbNX87Ymn0BqDDLyABYNlHStYNVy6J7nZ93MDnE/fSx7OKnnNe5dd+9gZNM5B0
 91fgTuiStqyYkOPs9+RH+j2iCX0VvRkPsIU01WZhB9cKoOG1eKRERb35zXx2xSU2UPDS
 r+rnlaI+BJmOZCOUOLiePjs7XzAJTh/Bcs/8czEW92c162y7MSoiHqSDUKQPEHJNpZp/
 fbrFkOBZdpyxyC9Q6YNTbiLA1yR9oBN+4bvpJOdFTuBZDN8SjdelENrFFmtu28k7t6IQ
 cS7Q==
X-Gm-Message-State: AOJu0YxVomJGl6A1EQGOvypdLCirWF7hzopRfUl7milO9eN+OYjc44Cg
 8r0HQA6vxIUSzp7Bu21GqcBvk/au6DqVEBq8mW6RJZXWDiGx9xBj60DSJoTivn7zPYLxfRg46/K
 lUo+/pjtRmzRwDytLlfmvg3ELFyVIVtL6t82OES0ThyMMFXzTk507+FWILaQyB1DAmsTGP6BdDr
 zEhsOzW2BGBEHFpNeE0mA+pMaEV913hAdy6/0=
X-Received: by 2002:a17:902:ce86:b0:1e0:e2b1:7395 with SMTP id
 f6-20020a170902ce8600b001e0e2b17395mr2627076plg.14.1711527078098; 
 Wed, 27 Mar 2024 01:11:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW8BzkNqEOp+46jG289EUMDBeGiIb24uolatyICnRefM2AUgakOJeX6RfnzAa+sMVxwbm81Q==
X-Received: by 2002:a17:902:ce86:b0:1e0:e2b1:7395 with SMTP id
 f6-20020a170902ce8600b001e0e2b17395mr2627038plg.14.1711527077715; 
 Wed, 27 Mar 2024 01:11:17 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm8293709plc.104.2024.03.27.01.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 01:11:17 -0700 (PDT)
From: wefu@redhat.com
To: u-boot@lists.denx.de, bmeng@tinylab.org, rick@andestech.com,
 trini@konsulko.com, wefu@redhat.com, dlan@gentoo.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, ypron.glpk@gmx.de,
 michal.simek@amd.com, randolph@andestech.com, seashell11234455@gmail.com,
 peterlin@andestech.com, samuel@sholland.org, wiagn233@outlook.com,
 jonas@kwiboo.se, seanga2@gmail.com, baruch@tkos.co.il,
 kever.yang@rock-chips.com, sjg@chromium.org, gilbsgilbert@gmail.com,
 ycliang@andestech.com
Cc: tekkamanninja@gmail.com,
	tekkamanninja@163.com
Subject: [PATCH 5/6] config/th1520_lpi4a_defconfig:enable designware ethernet
 & realtek phy
Date: Wed, 27 Mar 2024 16:07:26 +0800
Message-ID: <20240327080817.44501-6-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327080817.44501-1-wefu@redhat.com>
References: <20240327080817.44501-1-wefu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 27 Mar 2024 12:14:56 +0100
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
Reply-To: wefu@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Wei Fu <wefu@redhat.com>

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-authored-by: Yixun Lan <dlan@gentoo.org>
---
 configs/th1520_lpi4a_defconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 49ff92f6de..b7d049b9d2 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -58,16 +58,20 @@ CONFIG_CMD_BOOTMENU=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
 # CONFIG_BLOCK_CACHE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
 # CONFIG_DM_MMC is not set
 # CONFIG_MTD is not set
+CONFIG_PHY_REALTEK=y
+CONFIG_RTL8211X_PHY_FORCE_MASTER=y
+CONFIG_RTL8211F_PHY_FORCE_EEE_RXC_ON=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_DW_ALTDESCRIPTOR=y
 # CONFIG_POWER is not set
 CONFIG_SYS_NS16550=y
-CONFIG_RISCV_TIMER=y
+# CONFIG_REGEX is not set
 CONFIG_AES=y
 CONFIG_BLAKE2=y
 CONFIG_SHA512=y
-- 
2.44.0

