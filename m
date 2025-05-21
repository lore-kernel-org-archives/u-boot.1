Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11662C54E71
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 18:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3003382E26;
	Wed, 21 May 2025 20:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IAECQ977";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C2D82E52; Wed, 21 May 2025 20:39:54 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BC982E08
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 20:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7353779b10dso433611a34.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747852790; x=1748457590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duo9P783j4V9vqy+2Jr4o99B7CGo32RaQ0dal1BDjuc=;
 b=IAECQ977iGchQczhTuJRO7Mn3BFue1CrJb4y3dArwO7gVp4c7eX27liX37br2FLf1r
 0LxjLGBNkEEm+m7que2N/IZeNTKykB3kFzwZLNwzLFlQyVMqPT+yy1i1Sdo4+TB1Ea3P
 THNSQEhkNKO6vsam+N8GpOWh9rkFMZ+r4FTfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747852790; x=1748457590;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duo9P783j4V9vqy+2Jr4o99B7CGo32RaQ0dal1BDjuc=;
 b=PNrKpxqoYYYyGCheZUQ7LUtbEo+efv5xXwxMJFFRgMBDnqPTHzMGibPUNBDJBZU3ip
 IHOoKTOYFAhTlMzuStQ2uC19nFSTyTE4HiSOi9sTp1N1qIdZ8pHDwJsX1G5yGky2Napv
 FVLcfPwMyPapUY6V4Dt9Q01wwnsHUkuYwgNuaf2hitgRWaada20rWhCQbTN71niImFV9
 eqdio4xnQ9RnS85aC4ZrmyHLI5t1LR4n6uXp0FNZM59tRUrj25TTSnjRQgyVcBO2v5gZ
 8DbMGbY2QJpokKwZoihkT0jywoQk4SAcZxUovODKVjaULzxFOD5FutcPr7cvnZYFvnSJ
 effA==
X-Gm-Message-State: AOJu0YxZSHX0/kbqI8yHvCbEksdMkxykK6fuW0OleMrz5EjDUGNa8KAB
 /dI9OqmpgnSdE65R7z9d4SOxLCsXI5WpDHdo6LNn6m+TIJx2Wz3tNY+w7cVBGjPrVeMqZ7WvKaz
 6Rdu/Tfg=
X-Gm-Gg: ASbGnctqoKX2TQrY7NRPgKf3qRcMfLCaaroxOMeLut8cXvBotahrwU8iNrWRWwnWmFA
 f3h/KJqx3AFAoOXuSq1Ab+V2sq3oaSKfAKISIMa3QcoiGvKOo85m5xaANJXCr8Ce/Rz9Zv/D02D
 dYi7783I4axUF2ZI2Ez5mfjMpscoiBOaZeoFGJxumIv0GMz1smBg8b1Mwx/vTICjzj++X261FCi
 0T6dg9sLOCU6HvIel1Fa9wNO2XbOpW3Ds8Z8BHMT0a8Y/l163rIQTvPxn/CzwJiCuTgtP+d+zgO
 lykmHo7zCyGtk2nzpdF0o2RRsGgcYNo7OtF/BLxk/j8D5pisgKxk5JBrTJZpp5rs1/7epn9Dt1/
 52R68F3PcuG0=
X-Google-Smtp-Source: AGHT+IHPEGeZLBBikr4EA41EEvBT8WGv9Dda9bAGHM43iQIQSCuMAuXBW97LgYPx+1VoUgipXmrUtQ==
X-Received: by 2002:a05:6830:3909:b0:72b:8889:8222 with SMTP id
 46e09a7af769-734f6ad688dmr17915832a34.8.1747852790515; 
 Wed, 21 May 2025 11:39:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b5f5e7sm2233454a34.65.2025.05.21.11.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 11:39:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <4ec1ca88-d52d-48a7-a883-acb84add4f1b@linaro.org>
References: <4ec1ca88-d52d-48a7-a883-acb84add4f1b@linaro.org>
Subject: Re: Please pull net-20250520
Message-Id: <174785278958.2062062.16736727009925246942.b4-ty@konsulko.com>
Date: Wed, 21 May 2025 12:39:49 -0600
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

On Wed, 21 May 2025 11:08:24 +0200, Jerome Forissier wrote:

> The following changes since commit eeb5ff1a468b2303efa9deb2483b5edbebb568c6:
> 
>   Merge tag 'efi-2025-07-rc3-2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-05-18 08:06:56 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250520
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


