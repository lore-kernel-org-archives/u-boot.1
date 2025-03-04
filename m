Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21D5C282C6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 04:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFDC812BB;
	Tue,  4 Mar 2025 05:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LiwBKSBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DCB88129F; Tue,  4 Mar 2025 05:41:55 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FEF81249
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 05:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f47ed1f40dso39904917b3.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 20:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741063312; x=1741668112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/Lsx1YFBmt18/EYVCV66pgU4S+LxPi8EF+R3c2mOII=;
 b=LiwBKSBVCvK+fMabfEsRLDPi3hpW2kodszyOe7J3I0d87fEEeeNM7wHWhXf1gimtEo
 luvzgTWTbNH3BmUKDHQk2JhfuhX9symN1TK/Lfg5DF0E4EzY7nDRbJb/PSpmAGmS/dIy
 HYmWkANlsyghSarLKzYqsVRQtVPQtPby9N8rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741063312; x=1741668112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/Lsx1YFBmt18/EYVCV66pgU4S+LxPi8EF+R3c2mOII=;
 b=eDep4OswatTEkJ2Umnim2lr3omuKOf18fSDWmoK/9iksOyG5236EFsLw+Slpl7saTk
 aakGMEJQl69w1VQx0oBCY+P19++jFvQOTg+XmJ4sBxgUKc9qt2kkQ6s3q1H+eztjqs13
 GoV+H4BJnHJA4Zb3TOb5hNhT21HlP7/ga++jFaTfgtxRR1zuP9Q53CXMrgGiMQYQFGxk
 nowgptPxSn3WnIx3Y+CJ9GyGzymFv+3h+5JmGl0r0a6r0k0NZI3i670oMIm2EyZaNK5C
 SXc4ZDmFXTOXSey8HDyalDFf4JR+O6T0wUdn6jgCCOdMKwX1hyPdiHsylCwJlUqsCeiz
 lrhQ==
X-Gm-Message-State: AOJu0YwFoTgbZBqrmMryl1G4dXTtYXxU898PZFrRXLhSbTNx97fJ+LCI
 6VSNMnACKF7XnM8gchljvlLtyIPPJytV0ChlXrTMyUVym+/1ZLopBSnkvjIcH5w=
X-Gm-Gg: ASbGncukdytLuo2Foy/sEy53tTYXXTzu1Avol10CA/G7NhwDNUYRTKVo2CdIKPPBrCx
 Fm3SAgyPcKFROjiKRrFmAaKmzcYMdbm0HRdrJDt94UKN0gunYajk9O2ppNDtGzANbD1Wn94WO8L
 jr1EC2TRF9jOh2Lu+p4mHXnq1AHlDuAgUWfT6ioVlLYjv71W8amyMtQHwrp3euWcnunMW7m0eEB
 iLP44Z8Uy/W08IBMRbhWim8SgIKS2en1nTTE6q1QUU1bYASWFTuWce6PRPFYNKAFw3VkT5Ql5lK
 l09ZFRDWH2uY/kTZS6K+IK1EwASkVMc6SKUMYWuKrw==
X-Google-Smtp-Source: AGHT+IENZmJzpZ9+/stxFweK4ybsPeIN5Lidurc9ZwHRz/Im6YOM2mbohqJst4Cq/++QXznvmMSKDA==
X-Received: by 2002:a05:690c:6186:b0:6f9:ad48:a3d7 with SMTP id
 00721157ae682-6fd4a01fbd1mr211250837b3.1.1741063311782; 
 Mon, 03 Mar 2025 20:41:51 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca60d57sm23182697b3.51.2025.03.03.20.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 20:41:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, j-choudhary@ti.com, n-francis@ti.com, 
 m-chawdhry@ti.com, jm@ti.com, j-humphreys@ti.com, u-kumar1@ti.com, 
 seanga2@gmail.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20250218094950.2542006-1-s-vadapalli@ti.com>
References: <20250218094950.2542006-1-s-vadapalli@ti.com>
Subject: Re: [PATCH 0/2] J784S4: Enable USB DFU boot, DFU flash and UMS configs
Message-Id: <174106330950.1753567.1830660648278585801.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 22:41:49 -0600
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

On Tue, 18 Feb 2025 15:19:43 +0530, Siddharth Vadapalli wrote:

> This series enables configs for USB DFU boot, USB DFU flash and USB Mass
> Storage command for J784S4. The device-tree changes required for enabling
> these features will be posted as patches to Linux device-tree mailing lists
> and will eventually make it to U-Boot via DT Sync.
> 
> Series is based on commit
> 5c33fb0288 u_boot_pylib: Move gitutil into the library
> of the next branch of U-Boot.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


