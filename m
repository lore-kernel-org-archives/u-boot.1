Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30910FF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF99383E36;
	Fri,  1 May 2026 00:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tvZAKFk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D107D843B6; Fri,  1 May 2026 00:56:48 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5DF83A91
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1242522fac.0
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 15:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777589805; x=1778194605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKrzlCNo8szSn7Y75nGQlpqY5c/gtFQiY7HacihuaWk=;
 b=tvZAKFk2Bxab7UrafKfVdWpNQX6s8aDVdj0Rz//i4zstWuPWi1j8YrZNOqDbwtSAFn
 L+327gJ25VspIECfZy3QS4chLQ04uebLwxLF8F2t1Rn8/G8m4fwOYDGfBMoQiTJYnPe3
 v5eum+LNIrrMIGGf0VlBlnlEVInxp4rWBvh5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777589805; x=1778194605;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sKrzlCNo8szSn7Y75nGQlpqY5c/gtFQiY7HacihuaWk=;
 b=r8eoBF5oxDMtWy545D3mlAh3wWX0glZt2UwKfzo++fuw9vfV0E9W0Jh1iCBRc6Wy9f
 Acd6b5XsWdWCS8l5WYiPfrh2VIdUK1bZx1rRuFqBbunZSI5j1fI6+u0PM7EMUyU/L/WZ
 IaD3BpWR4kYPQWo66a77Ij5AlbJDkpwN+UbFmQe0/u9eexFRWe0n13xFkB9irFNqbYgX
 vo3MSLWOCwHF+JzIKev/2JbQr7aRVHsshlJb/DYAjRcD5q/qdEHEu5v33hFu3wDu7T6E
 ZDTxWp02adxL4JQkf4BZlSyyLCTWD4EYJE8cqvplpzsIEif1V9RTKqnkcNYARAe3V0FH
 MYpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8leupxucd6r6Lj0vqAao5MFkYRZnbRrCKvAaTWIhZ6fg6sEEtwo1HRlHwW7mjgL8bzTvPIAVI=@lists.denx.de
X-Gm-Message-State: AOJu0YybJ+UJDd9JP6NQcm1LU7446eq/lt5XzQgSGyu9Eq8Gwyk79opk
 50U7yb3e/ws+sjLU4Cgj6l/pYsOyJgbAsQWK/GwwJqWDziYIY91wYGU3d2cpiba0qmuRIOC/NZ6
 Fg4KqIn1rm918
X-Gm-Gg: AeBDieuV69HelvRV2ErwIFk6nbr5kJfVJJv+r5QtnTP9QLS1g5sxsySChBXS8bMciSt
 XY/wfwhmeKifrWqCl5jUxdsvm385GbCgEqXKh3HKLNeilH8cmfg1fPtKKm1MtFAiiY83PL59DsT
 b4cb1tPHZZJGtG2TPfdjIFBlbPLIQJlMeo9xz9krOg7kl0+yyLtFj1OWgUR9FAL6al7t0iC9Mqo
 aehDMK/GYwIHQxCuF1uocetzV+BFSCdL+SYfcCEUA9nd2Zy4OLmd7uabigCjJnYSFox2Ys8K9fx
 E96uRl7TLFvbOrBxg6QYSR28gPt2vdXChX4foyivGt949FGAsnZmROiW6Hkp3cw53E+dr0dSwep
 XWboHdtndV8DGMD/L7BF4kXaOAS3H5ur44bh0D4t/q9G8xytzvSFklAcAfIR00GYtvkXwo9Wnf6
 DrtzSI0XSwm9zO3Ch0PUk8rPJp9aW2cRgyzCntBP4a95gGiS0tHRoX2+bKtFsEjDLJsuby3ly/E
 vEJWRK+9rsAV7GijpHkgyAGqd6ojkyNPeSFs84lyu1AltxuGmCaC+BUe65W
X-Received: by 2002:a05:6871:b29:b0:433:cb0d:7702 with SMTP id
 586e51a60fabf-43438ad0772mr1973647fac.13.1777589805544; 
 Thu, 30 Apr 2026 15:56:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454966f3csm919444fac.8.2026.04.30.15.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 15:56:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20260424084546.260786-1-francesco@dolcini.it>
References: <20260424084546.260786-1-francesco@dolcini.it>
Subject: Re: [PATCH] rtc: ds1307: Remove legacy non-DM code
Message-Id: <177758980496.1739800.15658738727683378992.b4-ty@konsulko.com>
Date: Thu, 30 Apr 2026 16:56:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 24 Apr 2026 10:45:44 +0200, Francesco Dolcini wrote:

> The DS1307 driver depends on DM_RTC since commit d425d6056e01 ("rtc: Add
> DM support to ds1307"), remove the related obsolete code.
> 
> 

Applied to u-boot/master, thanks!

[1/1] rtc: ds1307: Remove legacy non-DM code
      commit: b5633dddbd9d3d17e36e4129cd37b05beedc325a
-- 
Tom


