Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8786CC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 17:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DDC82E8E;
	Thu, 26 Jun 2025 19:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IeGmjDKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A0982E27; Thu, 26 Jun 2025 19:56:59 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA3E82E08
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 19:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c27166ab3so857308a34.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750960608; x=1751565408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRcDDu6EezcGMzaabqdVT41uuKKAveQu1+bcjMhGve0=;
 b=IeGmjDKMyqr+xI1TCY/vPrXyIiXQa9bbZ/znYb6ZO+/DoujelQBRo03zaf4n4jdZdO
 GeNc1Mtfcd/2w5SLOXvHuBKyAOfMD/fKyRNnxXJ6wrJWi5vekKreGTvW1wF/vQQvG4Zf
 qFOWr/pupRVZK/m8OasOlY4dbu5eqURj9yMdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750960608; x=1751565408;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRcDDu6EezcGMzaabqdVT41uuKKAveQu1+bcjMhGve0=;
 b=naPybZAiyIAvN0zRwsTb5wy2FvYds71J4RCphkVtHWk3vYZXTwsY0XjboD8R15jJQa
 GYRauWpmOhZNQSnNDkYZMrBNyBtUDWPqmsEauuttLNvhhw3OB4xWSrBvuXgbmjFjiAW9
 0fxcQJ11GeMjId3v61CW3gsbMtzGW+gKYk7Kkbt6hVYQlkWR2LD1adjIQb4bDa6rAoF/
 Gp0lsIqp2l83wXbzyABVaMD0bdVtwyl/e+Z6Ezpm2YC+EzzWY58KxefKvfXoUcWmJYeC
 hUVnZQFA0KDj64y/GeOaPsSIJveIL/32xZ3+bh8Hi68CU4U+S3zQW4O/otq3ELAJRr7Q
 Bo8A==
X-Gm-Message-State: AOJu0YzThxJDy0tDJYc0gVeE5JYeLox3Ovt5NIVeuEWbNk9FEGc9qYRG
 2pgY35K4RChuwUhnKcCw0aa4MO9wTUA8OYQUQvhBuBCym0JktE9isjn+wqlU9hX3RUs38cCqiZL
 tlwZhiDg=
X-Gm-Gg: ASbGnctKWHs7o3rVSAk3CeKXMO5/Mnfv9For+zKiB1bOt2AJtSHNOgjgqKw2MC1elhS
 Ur8AyRbQpI0ApSNpXwXmGkEstDvhEcY/sS6Gd8qKOu4wQIrmGZc4qfbIipmqQwW/nt8exrVRq0w
 dtv2vUyNMWXDeBT/ty17vh0Xn9AlRTiXhk88zWuBjuhSww2HqK1hodn0pPwjCCevtawPcQH3GWJ
 N1/FLlZqJS2CEVFygJDwUedyzxC/MT61HP60qE9zrja86i4VOkC6v/JXNcxFgK7gBUTc3rtVF3K
 BbIRd0Ip0JfOZDRImzCdAdVlnlSwzVuBg8pet5LXtFYHNYEplneVH9q/nAPbvDQR2OD55bK9l1+
 dw1hz2VkeyDx8lkxQYF/5n5fzZ63W+/Nl
X-Google-Smtp-Source: AGHT+IHK93Q0aCRZBIyvV1XSJyoOd9tYsetHJSYCWlmQz/urdCv8SHFOx5faqqaJCluxBk8G7zTyrA==
X-Received: by 2002:a05:6830:6c85:b0:72b:a009:db44 with SMTP id
 46e09a7af769-73afc39c6afmr54052a34.1.1750960607930; 
 Thu, 26 Jun 2025 10:56:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb008936sm63877a34.24.2025.06.26.10.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 10:56:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Moteen Shah <m-shah@ti.com>
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, quentin.schulz@cherry.de, 
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com
In-Reply-To: <20250516114148.3862114-1-m-shah@ti.com>
References: <20250516114148.3862114-1-m-shah@ti.com>
Subject: Re: [PATCH 0/2 v2] Propagate bootph-all and bootph-some-ram
 property to all supernodes
Message-Id: <175096060683.1879961.7350351827780463493.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 11:56:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 16 May 2025 17:11:46 +0530, Moteen Shah wrote:

> In the U-Boot pre-relocation stage, if the parent node lacks
> bootph-all/bootph-some-ram property and the driver lacks a pre-reloc
> flag, all of its subsequent subnodes gets skipped over from driver
> binding—even if they have a bootph* property.
> 
> This series addresses the issue by scanning through all the nodes during
> build time and propagating the applicable  property to all of its supernode.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] tools: binman: control.py: Propagate bootph-all/bootph-some-ram properties to supernodes
      commit: d85d15fdfebd040e58bdf80e40ef09d67a8ac808
[2/2] tools: binman: ftest.py: Add testcase for bootph-* propagation
      commit: 1b5e41964c34ee062fe9932ef5f9ccc747c50ea1
-- 
Tom


