Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B511C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6516E88ADB;
	Fri, 16 Aug 2024 05:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bqdseyD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D6D88AE8; Fri, 16 Aug 2024 05:47:28 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C49AD88A82
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d608060241so1006055eaf.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780045; x=1724384845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5Bggn8+q63NM9ps9KF4kdF5bESnhntsNGw0y0XLm1M=;
 b=bqdseyD00yQwhLWac6O08aK16OhTSFmQc9WhvEWaZyWGEPq8BnywJCe5Bk1+LGaj6o
 sJMEsUHknIXUpysoVT3R7XQpb4OgPsLccievkOP0nvEeEGE3vpcC4wM3GC9JcHWKoS2v
 uEBWRERMEtqivoS6dLiKJIOKmv7WenJxRTRNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780045; x=1724384845;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5Bggn8+q63NM9ps9KF4kdF5bESnhntsNGw0y0XLm1M=;
 b=PWGFwWSEr/jneigNEjDApxVAIowpvNpIhbIi2O9iSAqhhDVo5N/SwXF1Cogi5FWxuy
 Iq3dqIV5VMtB9WlDsSR1Y2Rf+qq7YO+CY4qbe8tM1P6PkMHJTG+0EwVXYCnL27mwb/Oy
 3a9bUZ+HdvlxCS7G1N5vH/GhqO6BA1SCnj/NCGXS1HuKwcHiH6+VgabU5XHF73qQ+jeA
 5o/ZoV0zo0KMj0xjkQwGEQ3rUdBNEcC8ThZVPNvGOG49w2efD/QlBFYODmOL2AkgXXom
 GD0MciiEY9sfrNc7ME5OiBtSSNdxGbOkmD1zGlmdPHIYWdfMtK12u7ROMzZnXl9YKb4V
 ihOg==
X-Gm-Message-State: AOJu0YyHE3gS5UsulB3VJsjDe7ZzPb58jeWsIDyF2srBXLlrpumEUUUf
 ucuwhM5kALBRChS8AgpeXIdzUbMwkf0iRIh6LNCIw/X6ZeiyGvJRuaWQOQ63XQw=
X-Google-Smtp-Source: AGHT+IGgmkNan8+lePTQNh6KvM7UPAdJOx3T4bS+vlW0AOKYsHoJD7Xuwfz6Qd5+l1i3yLAJRw9L6Q==
X-Received: by 2002:a05:6820:1b94:b0:5c4:68b8:e27f with SMTP id
 006d021491bc7-5da980237cdmr1716851eaf.6.1723780045394; 
 Thu, 15 Aug 2024 20:47:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cd69811sm541522eaf.4.2024.08.15.20.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:47:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Richard Weinberger <richard@nod.at>
Cc: upstream+uboot@sigma-star.at, patrick.delaunay@foss.st.com, 
 marek.vasut+renesas@mailbox.org, yangshiji66@outlook.com, 
 xypron.glpk@gmx.de, eugeneuriev@gmail.com, raymond.mao@linaro.org, 
 devarsht@ti.com, bmeng.cn@gmail.com, sjg@chromium.org
In-Reply-To: <20240731160754.16263-1-richard@nod.at>
References: <20240731160754.16263-1-richard@nod.at>
Subject: Re: [PATCH v2] bootstage: Fix out-of-bounds read in reloc_bootstage()
Message-Id: <172378004438.3540666.6475523333948141460.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 21:47:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 31 Jul 2024 18:07:54 +0200, Richard Weinberger wrote:

> bootstage_get_size() returns the total size of the data structure
> including associated records.
> When copying from gd->bootstage, only the allocation size of gd->bootstage
> must be used. Otherwise too much memory is copied.
> 
> This bug caused no harm so far because gd->new_bootstage is always
> large enough and reading beyond the allocation length of gd->bootstage
> caused no problem due to the U-Boot memory layout.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


