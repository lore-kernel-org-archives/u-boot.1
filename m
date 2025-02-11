Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACDBC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F0E80C83;
	Tue, 11 Feb 2025 15:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C9Dn2Hj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D97280C77; Tue, 11 Feb 2025 15:18:07 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3264A80A55
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f92258aa6so60675195ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739283484; x=1739888284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CNBbK6Gde8tI5Dn7Ac4HoZT6HgDOhKwZZArNYxkdoWI=;
 b=C9Dn2Hj16Aq1Pi2666GAUfKpkWK+dkxjMSXjHVCqiBwaNhzumBaB8PBRafKOxyHo8q
 tQ1jwLaXEIcgmJcRShQlcb5TaOgMOS8V01SRlG1oDviZwyFuCmY8pUFYBlRKnNs9sCkZ
 9xk/oPnHvJNhNSZVrNmccWVUoSagGGLPM3yCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739283484; x=1739888284;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNBbK6Gde8tI5Dn7Ac4HoZT6HgDOhKwZZArNYxkdoWI=;
 b=m22yvxYeJuBEq0hTTKzidq+y+pIU9ukrXTaRag24lEWaCGtYwuaUkrGZrKUehs6NIc
 n3YCTxjPSMKQOdmkllhrOgQeDMhhAchKTXM41ibPe1uNoDYhNbgjnYMPQQauoXalU5Z3
 h6Ku2gYQArRXzoxQ79pf0GPvBvoYIenZz1Mk1QvsjvjQNqruPTrWntxo+kb8IucVkX6X
 Kyfpa0xIxlAXf3vXNkKnhyY3bWIOTwu3sc8LEbckDOTqI3wDlKssTCT0Yh5U6H2RfMer
 djr/3MdYyuOdJ4DtcRCBxFxKLsyMvWmkB2Gj7Xab43ipqVTGxbP4Oj+1n4xLEejzBiUu
 wHTA==
X-Gm-Message-State: AOJu0Yy6kwRvrTsLUUu5pgq33W3zitXfGYhn72KI4QY0122+E3zENtl4
 wvTLuuR7fs44HatUi8ndM6k26IkC50s/rg+49vYdX5H5bazZHFxWwURsbyL91nKvoVimvEgnH7E
 GeUgNDw==
X-Gm-Gg: ASbGnctS+3UnIr8ISPdtstGKxtb1rbLIEo1vThK2UNgqKqmwSslejcEM+D0tRmjZ1S4
 4RWR2a+d0Rd7WZrutf5QOodNlRZOK7QMU/kDTdIjc2KND8aJpUv6hPx/bJFUc8tVcfWLvPQ4QtG
 +8+gBxQC548qQKYrqAF37AuNYz0blZZE1UrsUDf2LJoduKy4MPfge/ZTIRkIrKCQJfH7dgvvXU0
 v1la/3HFpBGb/eLv+SQ6n8jlY1KbeVGYMpt1J9I2uWwadmcg06kmqthSm4ecb+kCsV9SfPxJbGg
 h4bGsTVZOJ/CFA==
X-Google-Smtp-Source: AGHT+IE/2+m1MuP3fgevUVqJdMvxmr5TGDe+IfCO9mIab1e2+ChR0keeEzE6GEdu6UqH9/On/cQfYw==
X-Received: by 2002:a17:902:f60a:b0:21e:feac:8b99 with SMTP id
 d9443c01a7336-21f4e10da1bmr303143785ad.0.1739283483752; 
 Tue, 11 Feb 2025 06:18:03 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653cac5sm96957545ad.76.2025.02.11.06.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:18:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anton Moryakov <ant.v.moryakov@gmail.com>
In-Reply-To: <20250206220123.355626-1-ant.v.moryakov@gmail.com>
References: <20250206220123.355626-1-ant.v.moryakov@gmail.com>
Subject: Re: [PATCH] common: fix: add NULL checks for xrealloc in make_string
Message-Id: <173928348297.3071479.16814464029383795262.b4-ty@konsulko.com>
Date: Tue, 11 Feb 2025 08:18:02 -0600
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

On Fri, 07 Feb 2025 01:01:23 +0300, Anton Moryakov wrote:

> - Check return value of xrealloc for NULL.
> - Free allocated memory and return NULL if xrealloc fails.
> - Prevent NULL pointer dereference in strlen and strcat.
> 
> Triggers found by static analyzer Svace.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


