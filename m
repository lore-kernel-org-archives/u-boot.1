Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FA3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8ED889B2;
	Tue, 30 Apr 2024 01:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HQf3A2RP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9716D889AF; Tue, 30 Apr 2024 01:04:04 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1D788966
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78f04924a96so420780685a.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431841; x=1715036641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GysYMFArqYTNxGoAj6nVswfx5lIPzUoJ3vW3ZeaXQiA=;
 b=HQf3A2RP35oa7G2MNiYL8sfPWp09cH0XLNjUd3sA3wR0zQ9huNWa7kvngdZ3N4XVI4
 llwYC0rs+R6mK/1aXU7uXBRCVxCeg4JIJIS4dW7UjF/8K0BNWGiloeYLOsXQN53mh0uT
 qcRHlQtMspBo/eP8gPa7BHuMiRE5KiMGrpFMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431841; x=1715036641;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GysYMFArqYTNxGoAj6nVswfx5lIPzUoJ3vW3ZeaXQiA=;
 b=hFsYFob/eWTLGG67LDDrMQ0HwSQQIb8FdoBQDhlkjLxTv+6iKzI+wIq6Vlg9Fw/Lg8
 X7kYBO36FNIhbhnvJ4HEqrfjYpfJ87Jsyx6gYRkFbd0y8kk4hwICuxPteFg7j6BgFY9o
 DWDR/jNO9WFcC0K5Vhfh8jpNu39yaDLLAmocHnAOZYHW9vi/0ZQ+9Iq9rg2izK0FukCy
 egl8AJxlv6j8Sm9IOQS1SLN20myx8uYjqPN6LpBkp+lQKXrV3GoKo0gcV0REzvX9An8V
 eOjVVvn5tpExO5xlbmGsIfN5unmAtxRdVlPIRYxelQNEt+QrDUAjTSOHhhQOci168S2L
 hSOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYv13Xg7eiIxFjj1G1Kg9qw9wxMuHOMLQmr+0SUMoKACPsebOB1LisWmNGiAGYBvliNVIcmu4L3I+HLbd/4XEnAlakJg==
X-Gm-Message-State: AOJu0YwkAsdVIb4I1AMKpOlBbxVEg+62tXw42I8j/ueH/+z9cWbpk2Wh
 u1rUn4GUyb5QbbPxYGhPIDUEQE4dOkhWMs7VuMzXEt2aEtMHm2C/PmI7+UCoDqs=
X-Google-Smtp-Source: AGHT+IHAp3S5tGnK5gYkQRd+nPPoSUaD1dMoxvak9zk5IJoNv1b/0WeWCYXDtL8JEvyzf6MvEVs1HQ==
X-Received: by 2002:a05:620a:1033:b0:790:fa2c:6352 with SMTP id
 a19-20020a05620a103300b00790fa2c6352mr3343430qkk.77.1714431841061; 
 Mon, 29 Apr 2024 16:04:01 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Judith Mendez <jm@ti.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20240416162115.2743405-1-jm@ti.com>
References: <20240416162115.2743405-1-jm@ti.com>
Subject: Re: [PATCH v2] configs: am62px_evm_a53_defconfig: Enable MMC UHS
 config option
Message-Id: <171443183988.1749944.3594631559891599519.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:03:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 16 Apr 2024 11:21:15 -0500, Judith Mendez wrote:

> Enable MMC UHS support for to allow to enter the UHS
> modes for MMC1.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


