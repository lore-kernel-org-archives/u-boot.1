Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD30C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 20:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 423F781B42;
	Tue, 25 Mar 2025 21:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t+kvK3iE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61A18186D; Tue, 25 Mar 2025 21:18:05 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8515C8186D
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 21:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so115918625ad.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742933882; x=1743538682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ikh7mYFWTDpVy9jfksfq/vGsKO1eUEml0Iq6JfrCIB0=;
 b=t+kvK3iEsZmoC4GbeoaAJHlwE7EiHR4+DyCzc335TWdtwJm0ela3D7OqQphlX6Qm9W
 /Ah3SNKAolj+W0Tw1AJnvwQLsKla48xOocXRB8H2fy0uyeMX56gVT+uf3csHzSL1RTjD
 Md9FdLJOmWCBx7pN8gXeEOZpuHZnJX++WABy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742933882; x=1743538682;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ikh7mYFWTDpVy9jfksfq/vGsKO1eUEml0Iq6JfrCIB0=;
 b=s2fuK6yW3I9DKwMvMjP1djJ4Yc21H6orPaW4AiUHcJK81ZIqj/8hQLpfJJcqbMSRAE
 V+P8D1Aa5hYZGpGoKemrKgmXpjSFZiryNXSF+55GJSj4ukYnZjz7m8ENC3iVy2kYYgJr
 g0E+Z4iRc1LdJhZAeLGVNtNw0UhL6fbLPuHVywk4qRlB3K8Jt9VoS5JuLd8pWEAaiMUj
 Z0q3QWyH9Uo73aRlJHF4mnY7kErov6nXYWokzgQgcOpo/x6+kDWGMqkKROjJ2SZ8BQZc
 x6XwpdrISXtmdX6eD1NsWPSVxeM2lKwsJnn5u9RYjknzt3nJSbjE3jxtkJHmBVeaiVKX
 BR5w==
X-Gm-Message-State: AOJu0YxyVCbn0gYtN3PbJ5ZQG4h2Ehu61wfevt/w/zzv8EYD2Gu0qxf4
 b1/zDRSXbDMuwjA7wd771I/RKb+CxPEflUnVrzFaLNc8JiMKQ2t0NuKbqwdXOuHsEwo0u9w4lXn
 bA2M=
X-Gm-Gg: ASbGnctzxIOaiTYXg5iKsbQ+yNJcpP0Q6FnrPTN+qcqm3N368EMyzSLrhGH2fAEBQgt
 TIj1i9z6urjehyy/8NV4xAmMAITjB3HN4Qqmk+UfEBwmihZSND8fMTmKhRJOo75krs6r9pgBVa1
 4rDzKx++Rs3f9IiYp7paMpyraRHgGjCfq7ydrYlStGM1cAguMWnLXL7Vf/G+cB8IuOgRtX1wVVH
 bOjENx/WqgcwGKfz/UbgcRA+K9W9Mbw5QXXV0EKqygu0GBl1RY4ONtgArwJVN+WZH0cQCBuZl0N
 CoetTI028cVV9T+56A5Q1njQ16WoNa4hokN9V/cT3A==
X-Google-Smtp-Source: AGHT+IG3Xr1H3sQMrJKq2Lrgqo2MNph31FxONf4tx62MU3IYufxGVjpUu8GoHOfs1nhaZKRSD+6Oyw==
X-Received: by 2002:a17:902:ecd2:b0:225:ac99:ae0f with SMTP id
 d9443c01a7336-22780c54e46mr277309515ad.1.1742933881908; 
 Tue, 25 Mar 2025 13:18:01 -0700 (PDT)
Received: from [127.0.1.1] ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f6fbcsm94947975ad.239.2025.03.25.13.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 13:18:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250325125126.612733-1-festevam@gmail.com>
References: <20250325125126.612733-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250325
Message-Id: <174293388104.370169.13835398336237376018.b4-ty@konsulko.com>
Date: Tue, 25 Mar 2025 14:18:01 -0600
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

On Tue, 25 Mar 2025 09:51:26 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit cc9dcba9cce185d8bca2dc5c4b55b21f4505cbe8:
> 
>   configs: Remove duplicated bootcmd 'mmc dev ${mmcdev}' (2025-03-20 08:18:35 -0300)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


