Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDA4CF58F1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9DE893E0;
	Fri, 20 Sep 2024 11:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y3HGHiMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C0BB89316; Fri, 20 Sep 2024 08:33:12 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DE289105
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso15086605e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726813990; x=1727418790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3cvb7b1JgbavkVlSlJ81hEC6OrfKgf2Ogcz+6xK2Yzw=;
 b=Y3HGHiMiqjQH0xVP71UiVTWKSBolYWDdGSvw/RhsT0hK1p5/r9BV6maKTmXm5zaL9v
 2pELTdPNB0Ks59Kx0DKs57od9tCG3Q0+sUX1T+rsoODtWlPKK+T7iPW0bZa1qQ+KJDT0
 j7CSRIZCTpU+d7tkRBkixzE9ClIZ2Ln5/Bnxv41/FzUVBeoSF8T2WBISzfihvnXS6//O
 nVk3pbz5a6QEgh2P/n3J8s7YfdOk0AdcMguV0bmi5IdGCDuCWX9C7UnqHItvNfcrW8EK
 Cff+AyrBoQpqCODxYTDJH0u44bYygjHVyXVMlihcqGRqiYoSMcDnY5sZnUleq3mSxW9L
 qfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726813990; x=1727418790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cvb7b1JgbavkVlSlJ81hEC6OrfKgf2Ogcz+6xK2Yzw=;
 b=sZV503DW+lxMKx3RlAghIjW9n6kwVEvUzdUVHNb4i5+1Cqhpb/Q6I5X/VCN/JPGkqJ
 qH3rkgtUvvDsLyUN1zfsBRjM7r/zmu7prKhI0RlZm4k2zp32QyczMOo/0IQRDUF6GxmN
 LJK6bHrcpdmb73SMZTC6ie9UCOXTDQoSmpj4WEFwWFPsWK5004/Bnx4O6rVWLSn/FDvC
 Nfwb4XqY5G+cOnBJUbtPwN7IxVi8reg/6URUQjVSW59VB1AaobfawvVzqZOmt5CgC97+
 jiNqfNsd7+tO3PFKhiLmp7JhipRqtXac4Yv7b9N/AvhAwmcQZGA0uufBmf/0zQSlIj5m
 Q9ug==
X-Gm-Message-State: AOJu0Yy8D4HTL0HulcfG8G3tD264MGI9gUX9CgINfcc4wvl95jJBgmsh
 eziZiAdJpBV6ggxIUQMuOm1HR+yCiQbReVRQajyNxii0Z8udA5jEpipVOOU2
X-Google-Smtp-Source: AGHT+IF3hiSMugUBfTNNdJ5qMKg5TegOOcp3mOLtaBgd78vP6KOcwnpTgGYa1Co3TwyoRxGiWo2mMQ==
X-Received: by 2002:a05:600c:34cb:b0:42c:c080:7954 with SMTP id
 5b1f17b1804b1-42e7c1a90ddmr8555595e9.30.1726813989649; 
 Thu, 19 Sep 2024 23:33:09 -0700 (PDT)
Received: from NLOOP11.neuroloop.local ([213.164.76.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754a69a7sm39998075e9.34.2024.09.19.23.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:33:09 -0700 (PDT)
From: Martin Stolpe <martinstolpe@gmail.com>
X-Google-Original-From: Martin Stolpe <martin.stolpe@gmail.com>
To: u-boot@lists.denx.de
Cc: Martin Stolpe <martin.stolpe@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] rpi: Fix compilation when CONFIG_VIDEO is disabled
Date: Fri, 20 Sep 2024 08:32:00 +0200
Message-ID: <20240920063204.1049202-1-martin.stolpe@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Sep 2024 11:15:35 +0200
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


This patch will fix a compilation error if CONFIG_VIDEO is set to disabled.


Martin Stolpe (1):
  rpi: Fix build error when CONFIG_VIDEO is disabled for Raspberry Pi

 board/raspberrypi/rpi/rpi.c | 2 +-
 boot/fdt_simplefb.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

