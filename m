Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9A0C7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 21:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A6182D34;
	Sat, 21 Jun 2025 23:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dE6g2Arj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A342180C93; Sat, 21 Jun 2025 23:54:59 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177FD82CF4
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 23:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-401c43671ecso1469140b6e.0
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750542896; x=1751147696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmMB8+zUi8WRYz1JXgiHcnwWBu3JUBir9uxJ1zdYpvw=;
 b=dE6g2ArjZfyR/nisSiy2swMxbYBQN2miaAYazBy2yd9Pmg3W+rDJTST06qdEAL2blP
 rXF63UW/X4IhPI3OhbWuQklSnzI/v10DDBalEFqegt6g/O77suihuHCX2x+PHITjfjlo
 8qXAGCF0XirXoKU+awtyYtIWAirB8cW8879yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750542896; x=1751147696;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmMB8+zUi8WRYz1JXgiHcnwWBu3JUBir9uxJ1zdYpvw=;
 b=nwoDIdTEgbqr7AUJXJvtT+eSTe67cBM6cfZHFEXYfdDzrvzcmYblufsF981sB6cT6i
 y6vgpiRmAmL36WoF9iZIpwynKAtCVRAB0Ds+/yDc9kVC8Ml1Id/pEr5kf0Amf5zEduMO
 EEoAarSfMuIqKb+0OdKK8Yni+wS0MVdT70VphqXxCzal31CCndb8/CF2e0bsOpmQgxkz
 myOy8KouT6gq9f06mBlQb+Su70utJtNILYYbYB9jfbd3VMccq//4tevcHfo50oEEPp/I
 HwKk5CULNZRmKJkLBapL7OIvY5e0r9q2NIFBViSDYZiBCCKpSUSi5/TsC28ukCWu+WKP
 W+mQ==
X-Gm-Message-State: AOJu0YwBkGwbIwW/vk4A9LVf5XxVz1aAImDhCtX5lWb/BXUkPniJ5ESt
 O6oYtgTD3UouVzGINbLAwiD7WxlinhiYz8B2a/fFoQoc+cmAAV5Wc/yaqPzxRi3LOz4=
X-Gm-Gg: ASbGncsXS3i/wcWEl+L2AcAO4zE9T8UexQeaqCxNeRTKZGeAQR/twh78vecdYkj95g5
 J8H3LxMoC0zTQvV2LyHulp2IlUhgVHO7Oz4F43vdZLWQa58pSWz7rDPe1asRG3SsnEbM8kPtp+w
 wDNNWoEZDKvRLe4pCcXrdKLd45aOJquJ4/exNS2pwCDZUH3NJvHMFdg4O8C30QDgjAsnXUi6Uxg
 osLk33KNns253aoNeyqEkSXbUEapHQIc0QMi//35593zrn6BLp8JCBjMpQ2reKy+zqf4SrttA2n
 G5+al5aq9EmK6v1YRVJK+bqYY7nczhY3f9bF/xfRdnYE6kepgJXRDcyzjUlMDe6Evm4e4wO1leH
 wV0rm1iEonLeGB/7cVpXd/w==
X-Google-Smtp-Source: AGHT+IGnUi+CyMIUdRq4AMY1itlAwrKIoNeIQ1DccJGt3mnu1QECFuINt6XQcAjmCP7ml69n89rILw==
X-Received: by 2002:a05:6808:2286:b0:40a:729d:82f3 with SMTP id
 5614622812f47-40ac95e2aa9mr5032252b6e.1.1750542895735; 
 Sat, 21 Jun 2025 14:54:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90aee76dsm859664a34.2.2025.06.21.14.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 14:54:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <61b4648f-8a78-4551-a8bd-fd7c4a0638a3@gmx.de>
References: <61b4648f-8a78-4551-a8bd-fd7c4a0638a3@gmx.de>
Subject: Re: Pull request doc-2025-07-rc5
Message-Id: <175054289446.3757745.14802458802401419658.b4-ty@konsulko.com>
Date: Sat, 21 Jun 2025 15:54:54 -0600
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

On Sat, 21 Jun 2025 19:19:42 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 721eecd9cbf2cc59c5230abd37d02d4a02f75cc7:
> 
>    Merge patch series "common/spl fixes" (2025-06-19 11:01:52 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2025-07-rc5
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


