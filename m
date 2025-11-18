Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBA1CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD3483B95;
	Wed, 19 Nov 2025 00:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fsSXiNlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6708839AC; Wed, 19 Nov 2025 00:33:19 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2E283A57
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3d2ea93836bso2777692fac.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763508796; x=1764113596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ini1gMa5TOVqFYS+NJinUCTH/5Nc8caFhuu62UG418k=;
 b=fsSXiNlBx86URlO6vWGQnPLZHmFAYl65eL7xn81LE8voicoLYtnJBPg6N0rkHJDEiI
 GGZ+axmsQBEp9i3F4OsCNsxWJlEYemPezPw90uyE40TLln/hQIcBZ9fEcTPNWIrsympK
 B0pn3mZDgFiskpBRQmwbVf6rFY9ZJ5NNCBeEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508796; x=1764113596;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ini1gMa5TOVqFYS+NJinUCTH/5Nc8caFhuu62UG418k=;
 b=Qg44ldFJkNMeIL+ujWzbsYwEXK29b8hKRGQTydJ8t6TozCzin3gq7Z+clsug4A08No
 aWCYQRZK0AMpexHaimew+b24i+agITsumz19m8Z/fA8K8753FXk9GH4L84VpYStrooC8
 VOFIZqKMK/2BRgd0b1ieoAGQutEIfLKJFiRNfUn2rvPrhp1FNW0n0L+khJHFZLC3LUNz
 E2GSJL/xH9XjUZ60T34Nr0VICK4Je0uczvsf7+KWx8LKbpZPykeZ1Y0SB5X+m3FVciIu
 s4uEMLrHwk/V2t/7MJGgZtqOxvV6zCDKICe9SHLxK6MudCPnnWoFJjpjQkfmmaMJAuh5
 r3+A==
X-Gm-Message-State: AOJu0YzutQT5q59B3G///pB/MTgWVXd+FtTrw+DyR/NfKOD/cURM3qY6
 tehhoWL4zZX5Gh7lQGu8JYhTVHL07lVOloTyye58elUcNCY8AVYqQuB0S6MXb8GkBEudngxAdEa
 aJMBEx0bkgQ==
X-Gm-Gg: ASbGncsjwBkxGiIkqvO06FZWsF/X34rZVFWpJDl5gJIIuci9ZP6C1+ZVKkAPA5ILIld
 sEbMOLFB0WDBbKpE7W1UmBJ1H9h5DyVNZ41bs6R/s1/qS5cnDMwpI5L6Z1W8PBByqM3P6HjFt1I
 v5oRLdIxYrFO7EDI4Q1PT+B+ssVO7aW/9Df6pQP8ctsqw8h4LwdboSyNr81g7tcKwQFmoqqATlp
 zWGDy9MoDU59tUJG+R30veCAFmXjHKyDpOdxSaou6NelqxLJGYr3E3GwhVQ8WHo+PGgmY5Mbc3l
 ToNlR/GRUycYpF1dbBVj6nC0i/HSn9hmAwYIO9jRlY0L/dyiHyiXr8S8rtB9bXSvfHkbBRQoQMg
 pf3mBgiHDdrfiAiFM9emW4tv0sluCdzvyk/csxOmZU9CKX4OhyYK0wy9tQXMCkGbvBKigUUQYTE
 k320XdJCU+DmkrEL5nQ2h0fu1Gs17Q7GO7Wp4Hl9/XUu9IVeRK
X-Google-Smtp-Source: AGHT+IHpyqTd0h7jHd3yQmLnkdY12hihUe3HgxjsDqWE0NyhLOBG4byV4KJoR3wBjx2OFX3XtUhGiA==
X-Received: by 2002:a05:6870:41d5:b0:3d3:b73d:38b7 with SMTP id
 586e51a60fabf-3e868f1a992mr7922984fac.17.1763508796461; 
 Tue, 18 Nov 2025 15:33:16 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e89697fedcsm4075794fac.1.2025.11.18.15.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:33:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251118042325.16659-1-semen.protsenko@linaro.org>
References: <20251118042325.16659-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] mailmap: Add entry for Sam Protsenko
Message-Id: <176350879589.654721.5408244642164322329.b4-ty@konsulko.com>
Date: Tue, 18 Nov 2025 17:33:15 -0600
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

On Mon, 17 Nov 2025 22:23:25 -0600, Sam Protsenko wrote:

> Use 'Sam Protsenko' as my name consistently in git-shortlog. Also map my
> home email address (which I used at some point) to my current work
> email.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mailmap: Add entry for Sam Protsenko
      commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
-- 
Tom


