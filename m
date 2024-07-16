Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8425C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7CF88981;
	Tue, 16 Jul 2024 09:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZC9Z4FGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A688875B; Tue, 16 Jul 2024 09:04:31 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1A38875B
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so30088555e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113469; x=1721718269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/NsVyx5udmw0Sfxo+AwV+CvodjJzyA79kaP/vNX22M=;
 b=ZC9Z4FGtmAmS+GXPydoFjUwBbbBSQQF6p+fQGk3SNK7BandbWm3f3udqAElQMBAbCH
 RExJqJUr3cpPOVqZLby4g3QpxzTykfcIR3643xFAjVsW4Y1j1FPyFXXMwpUzPU1DGyxo
 ODraoCL0pHzmemYKLQuSMSVOnxOg3liIvXnn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113469; x=1721718269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/NsVyx5udmw0Sfxo+AwV+CvodjJzyA79kaP/vNX22M=;
 b=B8ePH/pzwUMeTvdFoXlMphEOQN9J6Ec1kruBIB2NoBAU/NkDqrqWA7h9vliAxFtVg3
 8a/GonsHBwApfPs5Sq565CCUwnQ9fBbtNTDb4QkBVAc0/+kscgPo2fArtBFdSvj6rhJP
 AseV3HVpgrDx6V5jKY3zTRxkK2wFsUe+uUmFl+P4r1s722xElUyjfZF7RtLAag6fpkNQ
 HlubQNsuQOU/T4e0pOUyZLX0XM4xD4Z8W4K2Dwx7n5zdDgvaIm68AHX5DTh3CqsR6vLm
 3QI1koyAdg+yAkuYMHV/EaAHF7I8O0fJEUj5LDQzKdcS33RR6VawjerwmQT3PKY5NoJz
 VbfQ==
X-Gm-Message-State: AOJu0YyDDyATpOSr7EwS00JK4Q/XV+mE8aiVoUPZTXQ6zNI/JAYdyLhw
 c75ETXFTIYQMDoWCr5NKYM/Tu6vwI5S6Gr6dZC4feNI8CLY/booQbXSV3puZz6/efBljYL2w9O8
 =
X-Google-Smtp-Source: AGHT+IEfHWP9TCREGAm6KSUfZ2hYtj0zygOwpx/yrQ4ohUdTxr+TTH3erKmMVTJuHOUW1vh1O/nT+w==
X-Received: by 2002:a05:600c:3b2a:b0:426:67fa:f7 with SMTP id
 5b1f17b1804b1-427bb6be561mr7068595e9.9.1721113469281; 
 Tue, 16 Jul 2024 00:04:29 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/14] doc: Mention automatic binding of bootmeths
Date: Tue, 16 Jul 2024 08:04:08 +0100
Message-Id: <20240716070419.1897560-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
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

Add a note about how bootmeth drivers are instantiated.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v2:
- Add new patch to mention automatic binding of bootmeths

 doc/develop/bootstd/overview.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 761f61a573b..d5051e986bb 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -419,6 +419,9 @@ Bootmeth drivers are provided for:
    - VBE
    - EFI boot using boot manager
 
+Each driver is controlled by a Kconfig option. If no bootmeth driver is
+selected by a compatible string in the devicetree, all available bootmeth
+drivers are bound automatically.
 
 Command interface
 -----------------
-- 
2.34.1

