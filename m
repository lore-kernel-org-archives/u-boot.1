Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0D7C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 19:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9423483457;
	Thu, 17 Jul 2025 21:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r6yxjwEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2FDD83496; Thu, 17 Jul 2025 21:02:06 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F20E83445
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 21:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-61593d51267so581748eaf.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752778923; x=1753383723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKG/2uQrpLDD9oIFAlJzFIDSZI8ugY3dq6OXp72ZPFU=;
 b=r6yxjwExqduWTSckS/5DGO9893B/7zElEWA0eBYElHBux+NldSpWoi1y728jDgcsT5
 pAHJBqgdQFBEIZzjn0SOZNnQTokogYKn7yab7++KFTs8r9tqrzlt2DIaEURX00/K4g2a
 7bSlU5XzSEykDfmwO63lkIcQFVcUCunldC3JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752778923; x=1753383723;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKG/2uQrpLDD9oIFAlJzFIDSZI8ugY3dq6OXp72ZPFU=;
 b=GiSArtOtPEbfBn3acVg7L/8EasWFqN412iF4OiC6D5SSrbXzfi0OpBRmdH3gfi7OvU
 c8QLbDX8RimhVEOhR2DMO+ZGA5VGTMu1nXD2TNK6mk82f3FPM0+PKFb45ovlEfr61qG8
 zmMGsptamqeTpAQN3qTNNts+kOHRRmBi8MmGUVk8yByqXSkFxg0U92nYtq8jKWgFOBMn
 bsTa46Pn2v8v8B1WEqpK46/KINM9yJIbR5GAZfFY/tafg4PAX8F1gj9Dhol2jz/8Fw97
 N75hwTwuh02ilMHfAsvHHrpb6cq7uztpluK7jdZEkZQvNn3aJ/Cd8QPwOahadldmYboA
 //ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe2AC0FQPK1/w58/aw2zvvA9kj4T5ymga2nm3V4d+WSUOMcpUXewjNBunkaJSfES/4LbqXPUY=@lists.denx.de
X-Gm-Message-State: AOJu0YyZjXtFhtbwODAr8rQAAJ1SFpH9GPLDnh+yc9KxkcoRr0wwDjrJ
 jvlBXuoF0MqqQXr2Tl3+tGAKMWoZUGcMCrP13NYcfGIp3Bv68x2MtSj4EhvqUzvvGwoRC3kOnTJ
 szf74QxI=
X-Gm-Gg: ASbGncs+w/lRywxU7Wyai9ZVB4pRmhh1HsW9ZKRWgdI0YK7e91HXv+jN94jrB5z3k8W
 EehPzmh0qcJbksGBVj9IzEI+KQkE9EKzUivkF1QsCfyXtHmPB1b/av6VRmk1WzQK+df3iA3+UIB
 LQAsakL1V6ff+aMa5M/EKrBMqLDe9hmM63+Nh60zTD/tbnkigjc67R/rG1TlEZG8KBDxoRMHy3M
 LGq384M8ihwALauz/Kdnu3rPaSDoRUBEjkmjuKb7e5FyD6KHWGKStGB5Gw9jk118d6pwDGo2zwY
 LYyVvX0i80TKAX5siKSDhXWZNL3yUYn8md5jGozX+VPE/GnXGFIeioH9dpnZeNrZi3h17HxCEO2
 usb8lA9dQ6/iYDQdqPHJedCc0nY5eCa8jek0BGdsGyjViHnYS06RhMCI=
X-Google-Smtp-Source: AGHT+IFdcfM8Fnyq6hawCgmEGn/la+8AqFVxSS0ERUs0RZmmXdXxPXwGWJuodVbQbFNWtDu86wbhhw==
X-Received: by 2002:a05:6820:3087:b0:613:bd19:54fb with SMTP id
 006d021491bc7-615a1ed6487mr5810899eaf.2.1752778922387; 
 Thu, 17 Jul 2025 12:02:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615aa9a8af5sm801670eaf.2.2025.07.17.12.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 12:02:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: rick@andestech.com, u-boot@lists.denx.de
In-Reply-To: <aHigIDCHNSqEt2e3@swlinux02>
References: <aHigIDCHNSqEt2e3@swlinux02>
Subject: Re: [PULL] u-boot-riscv/master
Message-Id: <175277892035.107181.11779009345211565717.b4-ty@konsulko.com>
Date: Thu, 17 Jul 2025 13:02:00 -0600
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

On Thu, 17 Jul 2025 15:02:56 +0800, Leo Liang wrote:

> The following changes since commit 3b4604a40b9fd61b87e9d059fc56f04d36f1a380:
> 
>   board: vexpress_ca9x4: Enable D-cache and MMU (2025-07-16 10:56:28 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


