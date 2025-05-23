Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07BCC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34724833EB;
	Fri, 23 May 2025 15:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jBfnrB+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A2C283236; Fri, 23 May 2025 15:19:30 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8245E830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60119cd50b6so12199525a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006368; x=1748611168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7mrbDx4WjKosEbOimMWghQ/hqJaIB9XOA0YVs3W1GJI=;
 b=jBfnrB+KUZ2T2UHRFFjdTzwxA7YP/1ABAK6EeDySwQCToGfXStRvp6fZOM70SwGx6N
 XtUad40apar5lyKEfCIt7hR66d3Ypj9huj+wMjV3zfy+naZ0rniMmDS03nT6kqWPEqo6
 MaYwQ0WHDoquqQL6w4oT9aNUmtdFVPkf1tiOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006368; x=1748611168;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mrbDx4WjKosEbOimMWghQ/hqJaIB9XOA0YVs3W1GJI=;
 b=Sn07P+6Y5Gf2DLGh1wuwyAxetmlp3NadQC12mLv1jzWCYwKj4Y1UL39IolbxZ+9pK1
 mPHHZvtlPMCqkJ2N6B6Id9+Hac+nUOObdZSdUr1A8Em4tB46BG3HQ0JpPcHWzy6vk/KO
 FCk0Wq5tzCTOdKQYJvZpy5+IOsonuVqIEWd179kwQjQ9Jaf+rUmQTWdzyteewO6pueK9
 +s+/vw+0rTkpqTGsNJM07iXyoXuAHgsS6Yl76uC1qGvMt1zwlulr/+nizpFxoT41c0YR
 f8BfyWeXoCwRzaZAPyTPjpwop9GraFAoqLujXpswt2qolT8CjMQzX8GXTXSVmXJKK7Im
 fokg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgq+oHkRQnVMksVBGnBXi1MKg5jixSHmPZzyXWUCWZGaeMuwYk3u+ywqzUeH8yloxVMN/9hzI=@lists.denx.de
X-Gm-Message-State: AOJu0YwnUi9QGWh0cCOzCZ6fQASVTiz7Muk9n8ewbWXGBGgKYXuG8jQb
 YAwB693jxPdzkgEzHsCituyRV5Rh8okhUrhXjzCJJf46zW2/Y1+qPua4gd00F+fp+VwmoknCc73
 q6aikpOOmeTl7NvMeNd5t39w/3V+91Fyq9SMaMvSb
X-Gm-Gg: ASbGncv5sSiw4af9UGXNA5NhcCjwkqTfpvkbABNvON2vdracDqymPh+eE5sAwoUnFpQ
 cx4QqlK5YTmUNda8w2gxEi2awMbAJn5hGf1i4xJLunf6A52VXzEqu0tvhZa4T+ofzxwuUoW9eT7
 xQXZ64+JBeXKbxHX810rfNUxwqyejcTZq+dA==
X-Google-Smtp-Source: AGHT+IF3gEPDijvHNgiI2mrkA/zWY46T8BbMMANVvwGetAo7axL4VT6MMkQIiGIYP4x4uap8Y5UiFWxMAwVJ3qbfsvM=
X-Received: by 2002:a05:6402:2742:b0:5fc:97e6:ec6a with SMTP id
 4fb4d7f45d1cf-60090068697mr27090495a12.13.1748006367971; Fri, 23 May 2025
 06:19:27 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:24 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:24 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-4-sjg@chromium.org>
References: <20250504132356.2317305-4-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:24 -0500
X-Google-Sender-Auth: Mqk-uIWv93ltMF3qaxtNge9hkRU
X-Gm-Features: AX0GCFvjIYkQkek22BWocVHxT4xwrzeG2-3Z-NFT-947NYT6OqDzdP0B4KH8cso
Message-ID: <CAFLszTh+r+yN-stJZ3LmXkKWezcZgB3Ry-g11HcjYX7feeHb8Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/30] binman: Correct a typo in the toolpath comment
To: Simon Glass <sjg@chromium.org>
Cc: Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Fix the 'ist' typo in the comment for TestFunctional

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
