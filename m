Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF75CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 17:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B813683A25;
	Sat, 11 Oct 2025 19:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T9oYZ355";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1695783A26; Sat, 11 Oct 2025 19:07:31 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F1183927
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 19:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-43f88d33872so1312038b6e.0
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760202448; x=1760807248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1sewUogXUBnDJvPiALneqIfL2LHDUXX8dI9/02LfXTU=;
 b=T9oYZ355kPnPfSzMi8Wza94E6jAcn42QMTYPw+6e991A8PyFafe+56HU7mkURGaiNs
 hx3uvJFxmuZ29/LLUxsSLdk8X925HNqERkvzFU1p3YHSZM86hEc7z5Ifw0K7cFIZc98o
 yXw3/wUoZ8g7OxZgIzJwpqGpDnQDEWlJa2SPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760202448; x=1760807248;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1sewUogXUBnDJvPiALneqIfL2LHDUXX8dI9/02LfXTU=;
 b=O9rH/r4b0AlVl671UnIiiPfTIniJGhuzTVlE9oscydZ6cZAxMgmhok1Xx6OeJ8P59a
 yHhZ4auA2FlXq4O/f2y2j0tZm1uA7AAcfw4o2Oljh6Jmhzcq4rZdrzRIPbKiKs+H/BgS
 sdHVp2ghJDbHQPmTupWjJ3qpHo2i9OtBQQ95zHZf+gRqpa8hpxJZP0vUwDVOKnXFoZF/
 tI1jPF2+UZ6S55NfyIz3x/I/yrA6lxT2QKoz+Wc1AXQOAy/eSGT0vBMeKJIIwlshBfNK
 d/7fnndzIUDS5kxWA6SnfTmiVqfhKzYdvklWytJOlLgC/LwEA+VfmOe2TNtMp6lYYU5c
 fRIQ==
X-Gm-Message-State: AOJu0YzjG0vRHtboS+s49GS6Uiet8dCf3+k3gtEs0D4yhxHBTA2uowjU
 qlMrSJTSWO9beXToO9DYdUVFWwalG89X6kMV2pBZElH7hb2DRHHuBj7pDrhRqamOyOtYuC8b9KF
 Nqd8pdWo=
X-Gm-Gg: ASbGncsMvYcxNW7QmwpKRyoJsF3EvgpU/apdwiV1QMh997HKjgbr9MUjBcqqk94insu
 gBa37JC3rHGy1T+EmOZkb2aR6/meADp9HdD0llwrpoF3ZbL8ZBvdlWcYbPfBCPYncBngR7/3Ebl
 T0TrWWK4aLQsEQDxw8UdPSdhWzdqSaoACpk1V3LB2Nt/wco5ZzMX3A4BXQqMbwHx63u5j8kk9tn
 4EQ4lWTP6PeSnhJ758WmhiwZqYXEC9borR+lG/GhzzH088KqFTvjSF13/vArK6CPOKQtUQFcvwl
 5MR5/OxDjn+FusSfkAlvo1EgvqohR63qFPvnJf2+l32nkBs1RiYE8dNwg9pF3f9gpUHK/8qZor4
 hqeS+UjRdVBEwUGjL6pUL0ZbSEQJb7Uvw5Kp2R4wDcRkRLUVCcdgsorvYT2uOVN5Jg6QNszrKKf
 dHiVg=
X-Google-Smtp-Source: AGHT+IH3wG5EICmvx5lZe2UrOzl9e7z/hnGCbulIOKw1cz74J28mOJjtjd7w4HmIgjOnV/4lLx9w0w==
X-Received: by 2002:a05:6808:bd6:b0:441:8f74:fba with SMTP id
 5614622812f47-4418f74209emr4739393b6e.55.1760202447785; 
 Sat, 11 Oct 2025 10:07:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8adcdfesm1970991fac.1.2025.10.11.10.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 10:07:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251001203103.2828593-1-trini@konsulko.com>
References: <20251001203103.2828593-1-trini@konsulko.com>
Subject: Re: [PATCH] fs: Rework filesystem guards for xPL phases
Message-Id: <176020244704.1312138.12681833543749662123.b4-ty@konsulko.com>
Date: Sat, 11 Oct 2025 11:07:27 -0600
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

On Wed, 01 Oct 2025 14:31:03 -0600, Tom Rini wrote:

> When adding filesystems to the table in fs/fs.c we need to use
> CONFIG_IS_ENABLED(FS_xxx) so that we only include references to a given
> filesystem when CONFIG_FS_xxx or CONFIG_SPL_FS_xxx or similar are
> enabled. Update the filesystems which weren't doing this to follow that
> pattern.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fs: Rework filesystem guards for xPL phases
      commit: 42b353412517ecfc9ba93dcd7f31e0e3557af413
-- 
Tom


