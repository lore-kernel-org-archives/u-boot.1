Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA933C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 19:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13718833B3;
	Fri, 23 May 2025 21:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LJW0Iaj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69FD8833CA; Fri, 23 May 2025 21:08:13 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 520238334D
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2d9b61e02d1so108206fac.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748027290; x=1748632090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rk8IQAigDhVp5a1F4uje9dv4y2Iz5PjPYxJ2Flv0DD0=;
 b=LJW0Iaj/8MHF/0bqHuXEUjxL+F2+H3anGmu554GSJ9kc/vFVYBqhzDEbGnxP5R72cq
 K/KW0ribtZ9W+Jiqlatrwjxw4IRJ+2yhebaEYi8kfZTYOBzFFozZlG9O2WwmWFIxrJIn
 dyftcQJSbUlZay14Wf99JlgSbBpqfGEsvn0r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748027290; x=1748632090;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rk8IQAigDhVp5a1F4uje9dv4y2Iz5PjPYxJ2Flv0DD0=;
 b=N3023/6mHq0W9ip/JG38qtJg8NbwI9AEaHTL24lpM2BMPIOEaDZklk9iDrUz7DwmvK
 HeQt8oa+sEeqWKoFJ7BK7/iFnAGvY4ccZ4Ereqe09VLwPPP0wREFnPQUDvzxKi7rlLEy
 CFObsuhmicygkb1dUCz9rCnM+0NN2MF+HTJYpSqekM8v23cl42Judds2pmnbIpuhVA1q
 Hsd8RtcERRWsJdsswQVby9k7dxpv2mqzhbTVuupfx+SdHnTvVz/Ns3drkyXiBJnHnlKh
 pIQaSdJlGrJR31KBCctF/+WfPx/hQNs9gfkkUoiqYBqjZx3wG8z6s6OLvuKX4ThjJAqy
 hscA==
X-Gm-Message-State: AOJu0YxyFmFx5XW5oBYi9endMaAPMqYjOFt0plPzsLMoBHoA+/623BrF
 W50cs/b/o+SGphJxNLL6tgoTofU8BYMn/Qz9LDictb8adNN8X7MHgICYLfMeO5hnLxk=
X-Gm-Gg: ASbGncsfkg0rOPfi41pceylzU0jZ7S0hkldLx06Qlyj6Ou+Z4hTHhPjz4B5F3Y4Rf/m
 wy9WdVt20GsatqZ8HANAhH1oPtKFnhWrgwsEHAjmVccAJvA5sjKNT0w4Wrei+75JqnnY0UBcxjv
 X6QvHQF+VPhudsneP4r6Fs7qz+jF//IuxLABhD5OOSUsYZ4Hye27UYY8deEEQKXpBEjUVG7X2lQ
 UcAySlGXogmEO40jV98YM88KPZSqr1CRaxEQ+s/0INoBzwd4KXUAuHyEcIwXzjgAzuC9P04uRqL
 sF/ld5ckdP0MXZ3RgZDwxYcGWgTjvgXqyvpsRWnXK7nGBTe6vRhi8T6bQIisOepvMkHd3aHC/Ix
 qVN2F2GMGGGQ=
X-Google-Smtp-Source: AGHT+IFinmKRG+qsHUHoYiFJG0WRgm+9V4IOFDimOTh8mw/DVTUmCEW5TaKQjUy5jBL7op+u1J0RPA==
X-Received: by 2002:a05:6870:6f17:b0:2d5:230f:b34d with SMTP id
 586e51a60fabf-2e861d42f02mr309134fac.1.1748027289914; 
 Fri, 23 May 2025 12:08:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b6062csm2966004a34.64.2025.05.23.12.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 12:08:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>
In-Reply-To: <20250520234925.26339-2-mibodhi@gmail.com>
References: <20250520234925.26339-1-mibodhi@gmail.com>
 <20250520234925.26339-2-mibodhi@gmail.com>
Subject: Re: [PATCH 1/1] fs: fs_devread should log error when read outside
 partition
Message-Id: <174802728909.2324752.9622167736052239404.b4-ty@konsulko.com>
Date: Fri, 23 May 2025 13:08:09 -0600
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

On Tue, 20 May 2025 16:49:24 -0700, Tony Dinh wrote:

> Log the error if fs_devread() fails when trying to reading outside
> partition. This will make bug reporting easier.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fs: fs_devread should log error when read outside partition
      commit: ec3ce603cd9840492d60230f164533ad4574489f
-- 
Tom


