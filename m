Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6890ECEB2DA
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 15:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC44283A61;
	Sat, 15 Nov 2025 16:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZUbNkwcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB4EA83A84; Sat, 15 Nov 2025 16:33:18 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7625683A5C
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 16:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-656b0bd47b8so543321eaf.0
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763220795; x=1763825595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1P06xC/MA0jIzZbZMmKMfwEZb+e7H7S/TMlp1BtwCTY=;
 b=ZUbNkwcnHz3ak+OjiVISyPFvd7q1pOcf1I0wEStONSfRf58igRz5ITPRmrRkhAkiKT
 nYNprRCk2DywdaBh3g5zZggYVSrQe7TGm7rdjI8gmKaPqQaGgFF3prIzrtTT7iAC6OaZ
 9kuPGYd6pnLMGmZbfNBhpyiDiFVib+Nwoo020=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763220795; x=1763825595;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1P06xC/MA0jIzZbZMmKMfwEZb+e7H7S/TMlp1BtwCTY=;
 b=ryoJ2fVWVt0HuaCYP/vlpfK26PJGuqw5x5HUMC+N9CalVnqJkASh8t6h+GaLINyS6e
 CpIi+4mLV+7wpBnB2Qjj81X6iwJOh8GjuTPGYay/WWwaGjp5B1rdHbEPOrFbphB64yjK
 ipllrzslT6DtICYIzzmuPoO4LWTjm1MasDeEOiHCvvGlT6luydv89yYKJGpNb2TSMcTH
 Ut70DI29scE3ovO6n28rDlUypN/BsG8qTYg9RqF1/sBEomM9qVsEQFl0793THoFIUN4x
 bbwKxFdouX2fhVnbK3UEnf0L6bNn+6jOWDzr5UFhs0BAlYsNJKOYfGwsg06Fx6JZDsjg
 H/CQ==
X-Gm-Message-State: AOJu0YykU7pMCgEfhWoIcEqj502SqAjEkGkPsaPnfp/+FwKvjpldohPe
 1Tlodf8BGjrIXLrH7Xppr3S8uHXJaqYDqtyimgcqj0m0UD7NOmwF8APvm9ZcMdt73mTfSMqrT97
 QkJvAVQpTvg==
X-Gm-Gg: ASbGncsBUEXaFrDTFE4tmeScyNZLzwEOgjkbenAqMD0eK6BYuc6dXhsbnMVTo976gAo
 yYzQXJawn8dIwiRMKKersub2y/HsPylSo6d4GMO6+MrItGDRTpKciCfGh+LjE8iB4KN/VAacxEA
 1d6OD9jpu94gtpyAMXVqCytUwyiRltG27vTLm6AW+no7EI0RPDjOoBq2uZEWxDEGB//KIofKPIa
 haefHMj5KKUvt6XmkzpKXfsCh/ELiJXreRZadO3IyFnGJBCRPS6SrDbbNihtW4B2Mw2bh5Lkshv
 XKTfqNHPTyu7sTywaueXoNgKd68GC+lok2/AVwpZ8/sjb1/gdFIctf63EGSK7pHumx/IOYxWfSY
 UntT8jZDPIIw9O9Y02HF5Gx0QitvpUKZtD2gWyK5y/maL6IFO7mbmVafbBHHU7HEHTxoap4Am3k
 Tpa8SGQc/FqfW2C/oQzFPdtLaTmBS0fh1C75+XI4psoc4b2qso
X-Google-Smtp-Source: AGHT+IE4sLhqA+80fwhICzvRa/AjhDCqiUUZdUR9455LLHN2CNiaPR2/zCQmiAlm5b/cRehi9k6wPA==
X-Received: by 2002:a05:6820:809:b0:656:b67e:a870 with SMTP id
 006d021491bc7-6573e33440amr1680608eaf.1.1763220795232; 
 Sat, 15 Nov 2025 07:33:15 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724e0055dsm2932739eaf.17.2025.11.15.07.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 07:33:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
In-Reply-To: <b5468640-d599-9964-c01c-5d9bd6fa5474@nabladev.com>
References: <b5468640-d599-9964-c01c-5d9bd6fa5474@nabladev.com>
Subject: Re: Please pull u-boot-i2c master
Message-Id: <176322079413.2593579.3265022381006438.b4-ty@konsulko.com>
Date: Sat, 15 Nov 2025 09:33:14 -0600
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

On Sat, 15 Nov 2025 11:59:49 +0100, Heiko Schocher wrote:

> The following changes since commit 6b27b6886945a9351fcea8c9acf9418844f46670:
> 
>    Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-11-08 09:03:54
> -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-2026.01-rc3
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


