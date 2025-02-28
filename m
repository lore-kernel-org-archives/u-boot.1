Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A482C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 20:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6583E810F4;
	Fri, 28 Feb 2025 21:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z6qTCBUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD84810FE; Fri, 28 Feb 2025 21:23:31 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2C1809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 21:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so50971645ad.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740774208; x=1741379008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=atCS9iSCylxAIx6WENTkrHEypP33YS5KfaFNdOuxGg0=;
 b=Z6qTCBUKK2CQzRNsMnuy6MQihf6F7z1vUSGa+mT0JoCkODloMgcRwz31+9GVfKT18h
 +JVuWIRVtiV/sPDbLhmRB90D/77ApFB/rfpUwQcPSlXLu2kKGCASn1a2HeIkkCM7K8Jj
 XPCeUzVg5SevoeikzLUAg5+j5LPaHQl9jDKfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740774208; x=1741379008;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atCS9iSCylxAIx6WENTkrHEypP33YS5KfaFNdOuxGg0=;
 b=dDme9iAu6ssC4c9fP8/+/FrzzaCrf+ZZygUcyF6HyDjXo5zgiogLrkDUuazm4IQADp
 jRLsH+vZoSI4Zlg2LIfARVF8I3tlzyCTD7DuAzU3uDXaQUMCUNnbHsAEFtszYUIr/Jj4
 onQrXT+/8FrrX6MIwoVZ7NAKiwdut8f6lTXXadIsZ1k8TpQi0q9cUkHVYKbkZit1uS9R
 K1OJ3ih5duzYUfUIjHY6fm0nIj8dnQ8Jv32ugKISKJVZe42rW9MIBdxe2ZiFZbKr1dMH
 Uge4wVSg+85RBhrgsgQQKZ0Oy9sftQW8lN4ZBArX5o6kBRxUU7icmNtAuxuuAWNRkZwo
 X+BA==
X-Gm-Message-State: AOJu0YwZb2kQVqS2d1J79KKidmLgIWHxlElTW0+vXYpdaKtIOd5ofGnX
 UbYBe2Ac5HD/HlFjALBlo79olyiaVHEPAaxCB7J5HC2xFSwWuzQWJXvlWIg67IA=
X-Gm-Gg: ASbGnctoqCZY1mUoOdCOXLunSQYBOpnghO59QPfKX+qCEeikKbvqgKw/5ywGmHRReFx
 yWgj4JWF4FE+CmEdfSkqiqaBzORM0vdo3SWV6NAgyHNcUE85Iej5eXuylXuJjcHCHUYpffpviXJ
 CkAd4oYXv4djIdbCwkVzXiktw8SXXdJ1v0YEa5aeTDE46//QItgSwp3WsSc4d9Cts+4ypavnady
 nxzM5UVVBPe0mZ/e4RH7ctQP+UBso60ltOTIqmKoQMstKeO06zbBzRyPPJWIKDmIlcJ5L64tKkq
 MsLdJGTdxR/KYu7b43iTDKYbbyTvtZ3xJEKhaBEJ0w==
X-Google-Smtp-Source: AGHT+IEjX58tq12DAZoUJeOSI5V6uXN1qy4Ni+B8AO0s3Oep6CBnbF4rbkLMosw/o3P/MyBlAsOmBg==
X-Received: by 2002:aa7:8895:0:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-734ac350451mr9066275b3a.8.1740774207784; 
 Fri, 28 Feb 2025 12:23:27 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a003dd19sm4288337b3a.131.2025.02.28.12.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 12:23:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250221184732.202336-1-marex@denx.de>
References: <20250221184732.202336-1-marex@denx.de>
Subject: Re: [PATCH v3 1/2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
Message-Id: <174077420623.1188562.11110331716328590227.b4-ty@konsulko.com>
Date: Fri, 28 Feb 2025 14:23:26 -0600
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

On Fri, 21 Feb 2025 19:47:23 +0100, Marek Vasut wrote:

> Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
> which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
> almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
> did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
> 
> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
> in the last conditional, which does not do plain macro compare
> (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND), but instead does
> mmc_offset(mmc, 0) == mmc_offset(mmc, 1). If OF_CONTROL is not
> in use, this gets optimized back to original macro compare, but
> if OF_CONTROL is in use, this also takes into account the DT
> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


