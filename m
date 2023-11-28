Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3D3C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 16:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6159C86F02;
	Tue, 28 Nov 2023 17:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kY912Z0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63198754D; Tue, 28 Nov 2023 17:28:32 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C8983414
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso5026245276.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701188909; x=1701793709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIrTMmQ25p2tHSsG1tUi8eZwnzKr+YrvuuzGLEXWeTQ=;
 b=kY912Z0Cbc7dek9UpqE9bmlYyCm82vEJJB052u2B4Gktr9JBXgSJ+JFpufb02cl0FJ
 IkCUU+kZj6ogAPp5eGbmSDjbQL1VMButMKs/j5UJ5ftJV3k1eW/VnWPolETe0aJwJxu9
 573MhWdfx/u/9vzBBB1LtVYCgXnQkgX5zUMzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701188909; x=1701793709;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIrTMmQ25p2tHSsG1tUi8eZwnzKr+YrvuuzGLEXWeTQ=;
 b=HhcfoJZaNhNHNcMDL9xTYES7jyUNLucN3A6XI/eQFNqhwbdES5InhH9aUO9Gvi53IY
 hxhCuYuYdI/31m3jnYxwS2K60OFQAcVOf0RUlC90ou8ic8FrtYcAnViIJWDIjxhOvCLh
 mlobyrbJULOXjYS5NelFQpQxGoDsHKB72nW8JOouE6Pfq2Z2roudp3qc79TWBZoKJmKV
 WUeeSyVtvZofIpZQwxztYiVdz4itGOV9V4ZsjsCIWxuGan+djLcLiWKxOLgO5x57moNi
 +iEjFRNfdMATkvLO5MjR9+0f8R7aqdaZvs/M2t/khquWd8Cf7OHvyxMKt92EwzcEDdun
 3CFg==
X-Gm-Message-State: AOJu0YwbZIZP3kRdQriVi2QpUfgLuZT+ROKyEUXdIOy9E/ylc68hfKhZ
 QA3ikyf8YhQcsoA9Oy3JpoLxfg==
X-Google-Smtp-Source: AGHT+IGNHQOPR5LqAqSTQ3L/8VRRh8emmHxg27GeLPwqAFSkKRAO5TTis9Bm9sB/kFzIpe9GTJvxwQ==
X-Received: by 2002:a25:f303:0:b0:db4:72de:ba0a with SMTP id
 c3-20020a25f303000000b00db472deba0amr12176678ybs.36.1701188909126; 
 Tue, 28 Nov 2023 08:28:29 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 e141-20020a256993000000b00da02a2ef6afsm3718500ybc.30.2023.11.28.08.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 08:28:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
In-Reply-To: <20231031184650.9141-1-clamor95@gmail.com>
References: <20231031184650.9141-1-clamor95@gmail.com>
Subject: Re: [PATCH v1 0/1] Step up as co-maintainer of Tegra SOC platform
Message-Id: <170118890678.214688.8025659614444974028.b4-ty@konsulko.com>
Date: Tue, 28 Nov 2023 11:28:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Tue, 31 Oct 2023 20:46:49 +0200, Svyatoslav Ryhel wrote:

> I would like to volunteer as Tegra SOC co-maintainer.
> 
> Svyatoslav Ryhel (1):
>   MAINTAINERS: Step up as co-maintainer of Tegra SOC platform
> 
> MAINTAINERS | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


