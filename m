Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3150AC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 22:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5AE84694;
	Fri,  8 Aug 2025 00:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jA5Lpcpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D275C83C93; Fri,  8 Aug 2025 00:34:37 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BA883CD2
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 00:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7416d362e7aso1190797a34.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754606064; x=1755210864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVycdekezdeUClznHQ670TwNNA8AmgqXjIRzaChUsGs=;
 b=jA5LpcpxGjd3PMgRXeGNLJWF/4HO6v3vwcOm1x6RGAkqGVi+m1nFxSDMPEHG/zKRHw
 jybe2TCW3U1PGnfV3fkNnLfjuSby/tStODKHlzLJScFppa88fqXUXhK+e3G3eHmVySjr
 F8QYACn/fiAghruq3dHhdG+xwcsp7QgpqnsSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754606064; x=1755210864;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVycdekezdeUClznHQ670TwNNA8AmgqXjIRzaChUsGs=;
 b=l3z2dKCrPgbXQhj/AIVf2l7qYrUcq393lNwqvBGlhzOxtu/a4iESY+B1YeNRW70DHo
 yPmBV7aVz0/45B7djmhXpKxieQPz1D7BWJ9xtsWm3JyZsWe5C6T2TgX7zLzGKoOR7x7f
 91s7QU64gQkjYPIZK0a9BR6cIuERK4DdVgmJohJ+Vn6PtJOjGg2uPNlEevAvmK+UkMtq
 vV6DPfqYsTRQMr2ls7gKMYCLyodiSiRxNpL8osVT0ryEResnVoJctFIYH3I4QzDNqtt9
 AV+rLctseYVmG903TlzGsAvK0hoS+zLb2DccVb7L01dW0bSSfS4vH3J3ERzDwAh/NptH
 FbOg==
X-Gm-Message-State: AOJu0Yxv3E7VvGtca4qKYBdpA0rXGcWXpFcCZ1DE38CH7IG62Oge0Jof
 o8IgGzi/bVKN6jc6/oZ9Awptg4ivhUc5PYorsPyzTWvqcG3AnjApoz7Skp/fiG2YHUFgP63KORn
 EqCZ86dc=
X-Gm-Gg: ASbGncuK2NhX+puRFWJQU7aJPTfbJY+ydkBLDwgUd2NzK21PIPkPGY8kV+jJ1BFotYk
 DDUHs7K+AHR2GpUwvuWoLfZmGfM0dJe3PqFUJ+5KIXC50ZhkSI5CMDzAQfqaw7CGMQh/Ogo9f0M
 yiCxw+Nj0DZblLppo95MAZdVhKoEGz29ywGCtjNDmDkOgiWK3du/YIi4F+x50brK7gDVakSnjtp
 zgArcaAWnpfmnnSvdVtOMw7iF56Pv+KZBlKARgO+Nshf37pUpUDxuii6kJ3i3XvPVEI6Mx/ID6k
 855kagOqM1e65/3wmBvtfUgf52zpDW3JCcLiJzTW7NOSLQEQVBgELjGXWcSPD4bliKfazwbxQt4
 6lizkTHpP6+AQaNBWp1p80cae7XlPgEDKiaOFOo33BYliPfKac8yDhCv+4GcIQaw+nQ==
X-Google-Smtp-Source: AGHT+IEgsaRQSUNtiP9Uq1JE94d2ETHVBq7Pqn3/6eRzm6kW28GNbfe3NolKaIaNKr2VAbt0vHUaBg==
X-Received: by 2002:a05:6830:4392:b0:742:6d79:ed03 with SMTP id
 46e09a7af769-7432c990966mr438416a34.24.1754606063678; 
 Thu, 07 Aug 2025 15:34:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b7c6eaf6csm73309eaf.0.2025.08.07.15.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 15:34:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>
In-Reply-To: <20250725151821.2067853-1-trini@konsulko.com>
References: <20250725151821.2067853-1-trini@konsulko.com>
Subject: Re: [PATCH] pylibfdt: setup.py: Drop license_files
Message-Id: <175460606278.3039738.13955347194843336068.b4-ty@konsulko.com>
Date: Thu, 07 Aug 2025 16:34:22 -0600
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

On Fri, 25 Jul 2025 09:18:21 -0600, Tom Rini wrote:

> On more recent versions of setuptools the warning about not being able
> to find the files specified in license_files has re-appeared. This is
> because as best I can tell, it can't and won't look in $(srctree) but
> rather only subdirectories of scripts/dtc/pylibfdt. Since we already
> provide both SPDX tags and a license field with the SPDX contents, let
> us just drop license_files as it's not mandatory.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pylibfdt: setup.py: Drop license_files
      commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
-- 
Tom


