Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E162CC54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 16:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E59E83111;
	Thu, 22 May 2025 18:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pkNwiK/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C7AC83121; Thu, 22 May 2025 18:18:59 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE838310F
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 18:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c40235c34so2569554a34.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747930735; x=1748535535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHL+8fdrWT37OoRZU39hBmyeCfWON9V7W3ZeK/f4zqQ=;
 b=pkNwiK/rJokg8n7xqwHbLhC4wIHnTdzih8wG9G9B61mz7z8euNJeSNfGfkrjk0EkNa
 757n3DTF5+j3SdEqmi/Y2choufdC3DOY+BCL44eOHnQGnD2LtDDSlP6VSP2ugVrutFu5
 G460ItWMkPGVqHhk3OKtD9wLxmToTnjBNMh0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747930735; x=1748535535;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHL+8fdrWT37OoRZU39hBmyeCfWON9V7W3ZeK/f4zqQ=;
 b=ADsf2UihujLm1MKjc7c9dzEeQtbGrDF2WgaNYBQVgpwg2AOD4yGaA5aRPe582dnkjb
 fKYQ+rTFk41L/RtwBik3ZYwDUxj1+e59Ifz1tcYVsWJG/sezzKk0XCNRqoIV+0xCdLSX
 u0brR4yo8IR6qSS9+mhSE0/6MxUtrSNqVJY8wlnYBHncQRYWyrUH78819TamSWjr+7k2
 DN2PIk7Gj8MG20lmIfyH9vfSgRIV9N4rFkGqpx3mkl3wb5/vWXnjOEsSqaBwom1lnITL
 EHOFGuEQp+m/2YypcUNjpIb3hCyla0CqvZho5GomaXPCcOw4exFX3k/F51fWkTcenD4D
 ue+g==
X-Gm-Message-State: AOJu0YzTg24V2eVfFuJOfTRiT/z5Xi9VF2S3zR6ZWrSDbbu0yQtZl2E9
 8Y7GUe9RvgXAZqhwdIOqiszt4IhtXXc6PHk47EGe7SZEDzfD/Vp4y1jm/tDNxxUACHKEJvT177z
 StFf6d8A=
X-Gm-Gg: ASbGncvfKSs5se4kQCzQhh4LVxl53FBYYjKb1snz+FibbOGjFZCYHO+bX2qj4Z+//iF
 ya07I1dCVTTXJdkm82kSyitu7/gik0mpPX3ISqHjw1w75LmcQo4xfnkL5ixprkfo+3YGRBsTb+6
 9eDeqS+NRvlfc//vV9J9UZLo++KK/PXME5CGt8QHSWC/Hd7McT4w287EhiK8olB8s48QhYMiOKT
 vO7r4743aH9fSLdLvJmWnN8a8j++tKBt1afC/O9Fj352pyY8r8iZb/Jjur4NhCYrbuzfgbBLPAr
 AV3J7FEZPXTCQW9T96r+LiSs6WMAeMrKV1JPlNIsZHSDdBwIiyg8enrOuevJwsk5ewE1fb30XkP
 QfpRRHWvvIEU=
X-Google-Smtp-Source: AGHT+IHxr9e607EZkmaJhwYxFxlKhzBcaVTpaD93FqyVFnVGZmLoFIRT5G5nj0QuiWhOV5zpOZlJUQ==
X-Received: by 2002:a05:6808:6b8d:b0:3fc:11a6:7433 with SMTP id
 5614622812f47-404da81e310mr13925874b6e.36.1747930735333; 
 Thu, 22 May 2025 09:18:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d97d6136sm2538177b6e.10.2025.05.22.09.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 09:18:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250522130319.1863383-1-festevam@gmail.com>
References: <20250522130319.1863383-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250522
Message-Id: <174793073393.2175795.16449373877334566854.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 10:18:53 -0600
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

On Thu, 22 May 2025 10:03:19 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit a3e09b24ffd4429909604f1b28455b44306edbaa:
> 
>   Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2025-05-20 08:35:31 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


