Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58EDC36008
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 02:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A290D81B4B;
	Thu, 27 Mar 2025 03:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YjmuzIDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E44806D8; Thu, 27 Mar 2025 03:24:33 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6B0807D7
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 03:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72b82c8230aso162238a34.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743042269; x=1743647069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZzQ/LEteFw2IRwyCI8E9hmRGidONuO75e6e93lU6RI=;
 b=YjmuzIDB1VA9URUsTdPdFG1uWSixzLct77ijdwrxlnhg6ZbaLTgKUef2k9FaYbS74e
 ykHy8pWDlgXIEzZcka8lxZxM/a3/rSNewCJuvHvwhbf8bAGuBr4OCrGGs11c61gySXQC
 rmAHJJd1hg+OJOUrZKssNN3LxvFxZAZksTHIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743042269; x=1743647069;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZzQ/LEteFw2IRwyCI8E9hmRGidONuO75e6e93lU6RI=;
 b=fX//Le+f6iNmEoifGKLZDbO9yRl0ysDYvgp+pjlYrGlgQR6D5DUzdZt3Cq+NTsdE/Z
 H9eq7YaBg2zWHlYTqOlC4RSdNTK8lVqkFeyAeQj8lEepFQmxt7S6Am0zqmwMw3l3H1+B
 5xRNmU858dqwagGoZfPYK/36aa9RCig+fTXQZaW9KRMjWORZJgKbEc7B+0q83UYPrH7D
 N6zlc3sk1GuX1VusnEmvfWIlG9bd8X4DslO2GZ5+5P5bKIbDuN+iaOX3Cr1dJx7EhnXg
 TGoOgtChwK+69p8wx+GpcYeaAwwxN6EWIT1gal1fzpjwv3ooBf9q3IM4pNXQh2WMTX2q
 ovpw==
X-Gm-Message-State: AOJu0YxUj3hF7RtHVu4CnDn35QlwLtqfKkibbHFrbtNru9cl6Ti7qe7B
 8hSb8uAg+8jk+NE5XsvK9Z48PvTwbtRYndfU/qafGwU0GIMsC7UXfzxqCrQH3lFm9ziaGMQZ6RI
 D
X-Gm-Gg: ASbGncvUB81S+g1Y8k7DRjfznushWUd39tU/PrPxVforRzNuW3if3SePUQyPkO8dRlW
 d4Du6LsSQNXuUYpo2lUvGjRNKiA+7+D/HqnpvymgzBu6VJ7A/xT42RW2Qns5cNafitTR3U5Dj9G
 RgDaCjYZ72uLCp7NZBdRmJLSOn7Ypew7IovjGlWeKiPQRyogKyQzZxJTXOQm0oMbDNE2Is8jPST
 m+38DlL8AgMJ7zXm3bskb2ViINyxQyYpv4Ik7OR8qGq0dq3O9PhHy49Ziqqg6zNg0h+/xxBTYGe
 ZAqC+T1Vimrxd+jWs908T8upwI2ml1i8TkfJKX1WmUyc7XcitXyj4RqhSD59eJydZ9TrZ93YOLk
 H9ugF
X-Google-Smtp-Source: AGHT+IHOtyycNLEWyQ6XEqtrQo/4nbi47tL5tCKgiX/0sGDnP/riXPyeQVYptQcOVbZoitePPGXp7A==
X-Received: by 2002:a05:6830:620a:b0:72b:9180:cc7e with SMTP id
 46e09a7af769-72c4c9447ebmr1197896a34.4.1743042269313; 
 Wed, 26 Mar 2025 19:24:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c0abba258sm2558974a34.23.2025.03.26.19.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 19:24:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250326170937.95794-1-clamor95@gmail.com>
References: <20250326170937.95794-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <174304226794.589015.17489774619792956427.b4-ty@konsulko.com>
Date: Wed, 26 Mar 2025 20:24:27 -0600
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

On Wed, 26 Mar 2025 19:09:37 +0200, Svyatoslav Ryhel wrote:

> The following changes since commit eeefcacb851f7f0bccabc3089a725f5ce86f5c70:
> 
>   Merge tag 'u-boot-stm32-20250312' of https://source.denx.de/u-boot/custodians/u-boot-stm into next (2025-03-12 21:36:52 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


