Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16C8FA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402E888D7D;
	Fri, 13 Sep 2024 11:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DAJOhlLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D4E988D7B; Fri, 13 Sep 2024 11:57:24 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE31888CD1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d4979b843so262834366b.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221435; x=1726826235;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVL7EGugm4I6U3aHVcRzLaFABjeS2e0n8QBMoPvCjac=;
 b=DAJOhlLNBTNGqukCJSp01I3J87K+I8rFF4mzWqBBrnHduIYXjqmavPu5T0FAQT5BIj
 fYA3bcv3KP0aYb68hlf2kLCjwtf0YcqssnkDMtzhZzYWTI92L9LZuFZ37P6fNWZII1Td
 e017fPTytgehrM62ZPNOwA7G9GSYNxMX3wsTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221435; x=1726826235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVL7EGugm4I6U3aHVcRzLaFABjeS2e0n8QBMoPvCjac=;
 b=xTEhPaWD4j8EUzdSXcferwBvJp0/CQKoIVefoUjsi9HAkE7rGQQvPFeSrAXLwuA/dQ
 U6nXo6Fpd0SY9TITHk2nmf26+RdxLbEwZ/EKiYh43C1ZbIEJA/8ELI09dqf4LRL4kTQ8
 PYmiJ28RVrDNJEzgu12cbMFV/E49jvpEtGJdEHciV23132EmDfQLc12bl+CYpy//PDJp
 1onaHc/QUzwFp/rPVnMUIpfJIKV9zK4mcUEbAWZykkxPxtdPdqzywClno2l+hiDqO1jX
 um6NYNlGMfCUmOz+LL7Fjwrgjlll0aDSSCRqV1uga5v6vyYF0nAAjGmH4PBO4e+tzVdt
 DGYQ==
X-Gm-Message-State: AOJu0YyhkqpfqysCYal51HMgKdYPrdt+Rp8de4QsrYce93ZT3wTmw0an
 WfbZbPsnvNv+roTRP/XIDPEhQbm6ex4CYJDGHALb84IkT/ujQ6c4iI5vsi08lO+yAh4lhzbknno
 kEmk=
X-Google-Smtp-Source: AGHT+IGpsrjksA7Eqoeq4QD3Q7B94kixy2kx2D/Pbwky96qACG823qs7ULhNg4Iu2rbXR0WJo0CZ9w==
X-Received: by 2002:a17:907:3daa:b0:a90:34bf:844 with SMTP id
 a640c23a62f3a-a9034bf08efmr433220366b.59.1726221434834; 
 Fri, 13 Sep 2024 02:57:14 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:14 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/26] video: Enable DM_UC_FLAG_SEQ_ALIAS for display and
 bridge
Date: Fri, 13 Sep 2024 11:55:55 +0200
Message-ID: <20240913095622.72377-14-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

To support multiple display or bridge devices, enable the flag,
so we can assign the req seq via DTB alias

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/bridge/video-bridge-uclass.c | 1 +
 drivers/video/display-uclass.c             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/video/bridge/video-bridge-uclass.c
index 7432107238cc..5e2b76851fed 100644
--- a/drivers/video/bridge/video-bridge-uclass.c
+++ b/drivers/video/bridge/video-bridge-uclass.c
@@ -145,6 +145,7 @@ int video_bridge_set_active(struct udevice *dev, bool active)
 UCLASS_DRIVER(video_bridge) = {
 	.id		= UCLASS_VIDEO_BRIDGE,
 	.name		= "video_bridge",
+	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 	.per_device_auto	= sizeof(struct video_bridge_priv),
 	.pre_probe	= video_bridge_pre_probe,
 };
diff --git a/drivers/video/display-uclass.c b/drivers/video/display-uclass.c
index 61a73e1bc2a6..07f05be7dd17 100644
--- a/drivers/video/display-uclass.c
+++ b/drivers/video/display-uclass.c
@@ -80,5 +80,6 @@ bool display_in_use(struct udevice *dev)
 UCLASS_DRIVER(display) = {
 	.id		= UCLASS_DISPLAY,
 	.name		= "display",
+	.flags          = DM_UC_FLAG_SEQ_ALIAS,
 	.per_device_plat_auto	= sizeof(struct display_plat),
 };
-- 
2.43.0

