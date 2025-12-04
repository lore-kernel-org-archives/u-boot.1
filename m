Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90325D2CDE4
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FFE8419E;
	Fri,  5 Dec 2025 00:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jtwrvSKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3CFE8419E; Fri,  5 Dec 2025 00:10:38 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD29384129
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so1225827a34.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889835; x=1765494635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gdy4Xr8W0cWBgJ6rc769qfNzHJb5yU/o0XZGuzrFqY=;
 b=jtwrvSKomUyCWpg9ZqBVmYM4HF33MYN18njzQ8BvLKIf4IbkQxyigeF4d3DWjfdRB2
 KqQFjCqdIptq4I9mWTttcYHKJjG4UesXqdgSiwagIPoK/Zg/R7Kob/o1JxEvJISDFwSd
 MhGzSehb090ZUF/I/TNQVmydiG9/QAuZRSqtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889835; x=1765494635;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6gdy4Xr8W0cWBgJ6rc769qfNzHJb5yU/o0XZGuzrFqY=;
 b=Zw5Mu3dFn8RpoYh1IHrVo5K0ty6KDcIj3pNNKgOZsmiqlt60s+RnDEqticiKsCdsnw
 9wBudrpT2HXcxoa5uowK4lssbJErfDf5vYZv1osdK1vtB/P/Yr5AHg0e3pc0DI0CnChc
 VfQdhDld4g2JauqZPsoquYRnYxR4Yf2YM+5Rk6Z/YwFqYSSur8+HcpF9p5QudohNhj1q
 N6VR7WkY3rZ7Y+rB8vTNZgjUpTzsIEeL5ce2LU6TDO7ThQUpGEKNZZXLkm6X1j6Wk1Jc
 DIgO8ikD/x2zL8UN8754ysYkzKtMCQmZxqeIp2pzLaD4yI9f+yc2H5m+JaeqbBpuXW3a
 vLyw==
X-Gm-Message-State: AOJu0Ywhc4R0cWqHvxHGkkIm4PGtwfVBrTKzPA4W58iJ+qwcj54HpcnK
 HEgozKGMO+HRI5jawASj2r+8O71nCKG3ehXlqBzcjo2LnnC9cSycyuTEVAIvn2hsOn3D45Yrhv/
 R1UGTox8=
X-Gm-Gg: ASbGncshxqgAHT1ryKnwt4NNMmPavgrSjyzEN4FZ65mOZj4HXeSR+jd3rAEK6DHfJfb
 l5Dw9XJCgc4QkxR5wUGm6E/BvEjtrOzZ/eYUNaipWEHM9IbAX2DnOTniFN1xgZKdceq1Me4q0BE
 QkkEUDvoxSvRp2Kg+E9ViczTMypcewI+rq9ehS52jI79bXq7oX2uRi+HhXaQlx/KTo+zehoM6Ud
 GW4a1DwNBQjrc7Yu+TLgHe+2KqJyXlpPuCqb0Y5WpD8R02oVqtd4KwyWiorCexXEHv5H9cbyuUo
 CAiRCnmyCLJ5MoD9o1IVKyKirQ5PmdyAXnSKFQBMRbnSN428kcD89T+B9H4ERamH/+ieAhsHdNF
 6m2pkCnFHngNqlmLjHowN+R6xuz0q34a2ImSZufBKZDUV82aUOux0JX+xZ5BFlsHLJSW2pMR2Nt
 DQCz8mDzjxcxA3gruPgH6ugoE8VcHwpAdQZ8zdW1Hhmc6yz0Mr
X-Google-Smtp-Source: AGHT+IFERcjG3MmYoAYj7Dusu/yUVyQfGbP7CmhuziLI9+zT0BYAtSHKHlixW56TaOcBi6B+yjUraQ==
X-Received: by 2002:a05:6830:44a5:b0:7c7:18e:914b with SMTP id
 46e09a7af769-7c94db18874mr7440678a34.17.1764889835575; 
 Thu, 04 Dec 2025 15:10:35 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
In-Reply-To: <20251119145525.843250-1-trini@konsulko.com>
References: <20251119145525.843250-1-trini@konsulko.com>
Subject: Re: [PATCH] hikey: Stop disabling device tree relocation
Message-Id: <176488983500.2091996.14833006353247428852.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:35 -0600
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

On Wed, 19 Nov 2025 08:55:25 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] hikey: Stop disabling device tree relocation
      commit: c404db942c8e5ecce50bef24b8715f891128f3c0
-- 
Tom


