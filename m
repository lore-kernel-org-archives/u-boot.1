Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB4DE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A279805C8;
	Fri, 20 Dec 2024 05:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kU0l1z2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4A38036F; Fri, 20 Dec 2024 05:06:29 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BA580516
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so2431912a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667586; x=1735272386; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8UZA6bgmd7zRfTNJlqdNZw+yvWExwwouV/S3+VpQG08=;
 b=kU0l1z2KvaCRFS0P02X0YcpMnnBbrIhcTZFTdtW1BZfOuGhSCQIZtJxzkSvLQwM39/
 FaMX8PlhV3isHCXupl4r2iItrXLZNVaYymGeRULMNnlaZA5s4RJX9cRnOs4stGPzWKbd
 k7dl2Wvo51THAe/SsMvXmVXz0EJB+ECkc5SUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667586; x=1735272386;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8UZA6bgmd7zRfTNJlqdNZw+yvWExwwouV/S3+VpQG08=;
 b=AvmVotJFEDT1bu4+QTcvv+GylA07bMbdo2EeoIJpiLKZBdAFxstqSqABmzmmnG6Y/8
 A8o2ebmDroIRyXLTR/dd0dVMIBnmfyRGMFNJzZG7/qCgZM5CRm32urgjC0t9jo3+R8Z7
 rr/y9vcj/OyZiRIp3PheOFfAtma5GARe9BnOqcqfdkPVLkTGCEW5zo8T9Pi83z/3u+y6
 PxwK5vvzSr4l99YybBmGMeoKHZbfEKK2LgVdXsnWzvfFoYRTKFitqEWaT7F1PqfVJBUE
 +HccmaPkkof9qirgimzuXYZYGx8P4eJUcsKLDf51GzLh9WXB5dmkPGdQmDYHK3X04fTQ
 PAeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNk9lFvmAClZ5NvMEHREt0yicL+I/aCqAWWATzy/R+7hgY6IjUi1oNoVIiKAOOKU50OAhBnuo=@lists.denx.de
X-Gm-Message-State: AOJu0YzV/aNfbVC7W9Tb3LnJXaUkmIRMxOM+TJ3aD64Ht5xvcbFtXs9x
 3PXa5RmQBhmaLjdnYQjVbSvvsCPuccUhWDj802tPhgNfFyoQ/mkr1lsITcqOKCnttxd+pVRz/Je
 pi74378nF+shlwGQLw57gXvZDq/PHIeBCoUUs
X-Gm-Gg: ASbGncvi8pC9hbXvePrloKFYtTIo28KiOvxjhoiX+adMdZRozgwjDB7gG4moqSJjdvP
 6WZOltUnq0vTNsBMpNeJfJkUWbVtGafHqKcRP4PU=
X-Google-Smtp-Source: AGHT+IGJiFQH3yrEWfyNC7u+9dKSyPqeZ5GcVbG5Cid11VQtqEXOuL0yGfgRo8OWmQPy2wa7dkUcxwAIzs8ixdsBHOg=
X-Received: by 2002:a17:907:80c:b0:aac:832:9bf7 with SMTP id
 a640c23a62f3a-aac2b84b7aamr83190966b.24.1734667586511; Thu, 19 Dec 2024
 20:06:26 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:06:25 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-15-sjg@chromium.org>
References: <20241206023626.2456858-15-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:06:25 -0800
X-Google-Sender-Auth: F9WnbFfORpXq1QRQclMWnYtfE6Q
Message-ID: <CAFLszThgXSe=+WHGsYFgH+2yYp0tO2KUsaW_L1+RqqRAHvwP5w@mail.gmail.com>
Subject: Re: [PATCH v3 14/46] boot: Convert IMAGE_FORMAT into an enum
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Use an enum so it is clearer that these options are related. Update
genimg_get_format(), tidy up the function comment and move it to the
header file, since it is exported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to convert IMAGE_FORMAT into an enum

 boot/image-board.c | 18 +++---------------
 include/image.h    | 26 +++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 20 deletions(-)

Applied to sjg/master, thanks!
