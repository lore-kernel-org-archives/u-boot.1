Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1ECC3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9D982027;
	Mon, 31 Mar 2025 15:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uU9yVXGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A190B81EBB; Mon, 31 Mar 2025 15:46:24 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C2B81F0B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72bd828f18dso1317634a34.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428779; x=1744033579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcBIattyJKaMBFw4lr4P0Ty/fiq+vg2YVXyvJZ4wKr0=;
 b=uU9yVXGN9iXKoNXQ/W9DBY7r8/lar1yk+4NGdfKbwIiIJf5l9iU0X1l4E5f4HFXl7u
 rWy5BFNdH5vejoWoe9bYxaFOPn0kYW8Dgitgm8BnW9pSqIYNIZweIU6h1jXtis6YfAcG
 QQW4IJQhcEl+unjUQx1uBH55AFz5ZNA9sDdoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428779; x=1744033579;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcBIattyJKaMBFw4lr4P0Ty/fiq+vg2YVXyvJZ4wKr0=;
 b=hwBDoiqXs8Lz6nmLdHVug4W6Z5q1XGzjb37pnmFM67XMMMxLg1iON5B0W79t05pL6O
 hvE3eZbPK6P45XXUCCvdaX7RtEeZzEn7OWJMONrrbTCv156BDxf0Zq+0iLao7Tv7/chR
 QFsq6nJ/xhW8FkPWtPGXSm8Uz0PIkLHoFHnSU+JLwGA5sB1+HvFXSlXtL8Lcd8kHEi/w
 fLOaVLtNppR54PJrH2eNIICpiAFjqAVoLR2MFL+sbVJ77aL0igXmQl5f5tA4fVrKpRcv
 h8NKOQSmo17oIt1drGEW2h61+IElLvm2GgR36SKUBdoEubP1680l+JWPAMRUFJAlll2d
 yi2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcoWWDotGB6w38PJK6U5bciNjddfc5zR0YQuiwofwGRx8XSZpvlOx/sZJ+Xv25KSh3zOUWcrA=@lists.denx.de
X-Gm-Message-State: AOJu0YyVb7fZ5IaABuAaoesrm/2BLndzC8SYeoZcu/e5u62m1ZNRIeWU
 bNFXJOJwLn4iBT4cukmgvr3rAEceCYICoy5BQhs7GJDpNDYe/IEXQ8fuItlKD7c=
X-Gm-Gg: ASbGncurOJaC3n82Lp90H9+NgpHQFmnNl+rhSNjsn+q6MpVh3M3vGD+ynQv4tvNl2qJ
 CZgsnf6EWDWWZ5qen6n/SAn9bcjmZfC9A6d31UGFVvSb9CR2ApSh7ikuRtujoEyQ6B1/Z+UhDxL
 bP2N+4eyYJF5G0T1TYJmRnb/BsU2wWg5pxd0NZvzygbJ9OywK4/5L14xdM1cA0AAZwqQ8jqg5VD
 Xe4msOaNl8WIbEIZcbcJyJt6bhyAt4s7KVL27U9/pZd+0oB8s/lg93ctvgok9OmPWYijwahatox
 KbWKHJKrUS7aVKt3Dt3KVV5FcuaGf8BCC5KwQgJnr6xB2VqKbVHVT+zdFsZZw9Xq7NnsHglxQrv
 jbfOa
X-Google-Smtp-Source: AGHT+IE4sd0UDG6Mvbmpo7NIk+IIXi4RjqU2x5UyoyFT8txmfMPb5/2xsQ4v12Ee4VPy0kHBEDhjjw==
X-Received: by 2002:a05:6830:b90:b0:727:3f3e:53bb with SMTP id
 46e09a7af769-72c638337e8mr5569381a34.24.1743428779394; 
 Mon, 31 Mar 2025 06:46:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae78sm1456331a34.60.2025.03.31.06.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:46:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, j-humphreys@ti.com, jm@ti.com, n-francis@ti.com, 
 seanga2@gmail.com, afd@ti.com, sjg@chromium.org, rogerq@kernel.org, 
 danishanwar@ti.com, Hrushikesh Salunke <h-salunke@ti.com>
Cc: srk@ti.com, s-vadapalli@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250310120856.603150-1-h-salunke@ti.com>
References: <20250310120856.603150-1-h-salunke@ti.com>
Subject: Re: [PATCH] configs: am64x_evm_a53_defconfig: Enable support for UMS
Message-Id: <174342877793.1318045.3095904471448367106.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 07:46:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 10 Mar 2025 17:38:56 +0530, Hrushikesh Salunke wrote:

> Enable support for USB mass storage class (UMS) via USB0 instance of
> USB on AM64x SoC. UMS allows USB host to access U-Boot block device
> and enable file transfer.
> 
> Example usage of UMS command :
> 	=> mmc list
> 	mmc@fa10000: 0 (eMMC)
> 	mmc@fa00000: 1
> 	=> ums 0 mmc 1
> 	UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3b72400
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] configs: am64x_evm_a53_defconfig: Enable support for UMS
      commit: c5db8973d7df0573d5e72fa5b9154d3c0856ec3e
-- 
Tom


