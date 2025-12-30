Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D7DEE49B4
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 23:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A55183FDB;
	Wed, 31 Dec 2025 00:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="crDefRFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C954083FDE; Wed, 31 Dec 2025 00:19:44 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E8A83FD9
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 00:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3f0d1a39cabso6745962fac.3
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767136781; x=1767741581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jOqRcXHsfIFu0NEplW950+DBvqN4iBBmWV9ldwWZBrc=;
 b=crDefRFOfg+fNNtXtel6j1jqHUTp4nQErQmx9EzLor1ULQfyuSnQNd2caEkQkxWgS9
 sftgabS4C2vjF7eGBDcI4LPVXyRPudc1SozuOgwszW4Zw5EWY1335B3xv1JxLvuPtnsK
 vRM4iR0/p35WeaA/HRsXXMiyKhLpecCTn6v1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767136781; x=1767741581;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jOqRcXHsfIFu0NEplW950+DBvqN4iBBmWV9ldwWZBrc=;
 b=MIWK7JqJFkNma2g/lRxPj/GLqGzcsEIE5WxRCnqIlRviVrLnczYqYhRSAlh0mpMqDV
 NufzQ/v71oV5h8z9rnwKzawfg3lfvQW0J+iyHElOUgzrg8Q/91rI12Lz12FXVIhf27VD
 MraN0CbRw4NnIpscXxAmN+7fls+PrIw+XLNd3Zaer9YLn9dNUx+aFyi2HVe268FBWgeU
 RwiygfmCHbdYKQdg4hmKTIDze6LeMDtO11vo8IUatSeILCCfi1Hze2G+YGU8kRKDfMaA
 DdwrZyuOWdr+1neGBNId+aVOPiL/sStcECdYgGM+kYoGcGjpJpoVBQx1a89naWLDEP02
 AfRQ==
X-Gm-Message-State: AOJu0YwMorfqN0M59lHoui6Kq7UXQeIQRTCRnYFP5s8OKoH1QZItO5Ar
 4OVdeKfX7NUGbt/IXhmXPMMces2cJSA+yxq/bo96IVNCD1WwikF5sbzqmRDzA8wDe9rKkT4v4+n
 mPG7bNRc=
X-Gm-Gg: AY/fxX74i3k3WXuL9k/3jlf9E13fAaI2FEI/hldYeDF5gX1omocRy8wTvVjY6mP0uc6
 Z83M3rORQEVY+qUz+Y5ItZnp4JCU08F/AHxKhzK3QDLMJhRED+ST2aLd7+rbJUQ8IvOETuKBtwc
 IAZrJOPIh4g+LbmjTqzW/qRDmv7C3RCh/iNnV3WPBl1VGAarbEy1v2UDBZtUwXjKfq5+YewHAE0
 a08UvjkhiKZQ7HCBlfiTicbvnbd/Tb3B6+RR3n0iCH1aa6yacVvKCM4spcLgxo5a2S9TIxmFHaI
 WcGhi7BJ4OvZEMNyZcP9HcK3K7TKXrbBO8wgUlC8BKOoMk2l7lfIe7ww9zVdH9StTiYXHoIDtCJ
 tiBhOLKOeBkmvZD3fav2y0OSsKv9wzOd2BXgfeIBQo6/AB+pu2Ko/0qSbmGSc7TI3DMFpqLcAd+
 H8FzLfC1yP1CLzWWu6HzrbCopCnXuvy+N2csppY2wEu9B38UYz7FR5TxoDJS7ooYSyeN1bwv4VP
 Z2HdwSFN1tP8qRp3j1mwNsUF35FCE9pZQwMGw==
X-Google-Smtp-Source: AGHT+IE1HBtiX8bfgLx7ibzQVbkmZVhgwtE0IoIZH4c/0Q0TkznUR+Sd5kq1mOW1AaRQekYfWkWneg==
X-Received: by 2002:a05:6870:5486:b0:3ec:5852:45a with SMTP id
 586e51a60fabf-3fda546d46fmr17751675fac.51.1767136780943; 
 Tue, 30 Dec 2025 15:19:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d4521sm21172083fac.4.2025.12.30.15.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 15:19:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010518.19203-1-trini@konsulko.com>
References: <20250702010518.19203-1-trini@konsulko.com>
Subject: Re: [PATCH] common/splash_source.c: Change bmp_load_addr to ulong
 from u32
Message-Id: <176713677994.315706.11286713973274913756.b4-ty@konsulko.com>
Date: Tue, 30 Dec 2025 17:19:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 01 Jul 2025 19:05:18 -0600, Tom Rini wrote:

> The variable bmp_load_addr is used to hold the address in memory of
> where to put the splash image (as a bmp). For 32/64bit correctness, this
> needs to be a ulong and not u32 today.
> 
> 

Applied to u-boot/next, thanks!

[1/1] common/splash_source.c: Change bmp_load_addr to ulong from u32
      commit: b3afb1946ecc6c815aacded3628acf5df87f97db
-- 
Tom


