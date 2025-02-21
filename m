Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEA0C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD5280F7B;
	Fri, 21 Feb 2025 18:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LNCb4WIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2041807C4; Fri, 21 Feb 2025 18:38:13 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852CB80EC0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220c8f38febso52506185ad.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159490; x=1740764290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UDqphUSMbRFPzBxEJo+VMDj0c8rmYUoYxsoPwnHISY=;
 b=LNCb4WIVLuCFdb0vJ3C+GPPzOd4z0edhLvOV+Rc4qhCLoYQQvl90R5lz8vRaxUek6T
 8VtdPg4WV0VliTZKC1L7iUou/Ui5nacuR6xa/S4Xke2mOyNDq05VfDPm4Nt6Fwbjp6Mx
 XYSi5CGPgrKMKPV92WJhubjLgNxu2fRSqoH0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159490; x=1740764290;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UDqphUSMbRFPzBxEJo+VMDj0c8rmYUoYxsoPwnHISY=;
 b=uo1d0aNqGaMrsRxp82+q21xz8FPzXlQxbSzFTeKpWcZp+l5EcPjbUGTC3g6XswvYcx
 Mm91ahYia52GlXr8GJ9yioKPp5C2rC9k/SsZvpM9kv6BVOcLlUixA7SXl+9QMW0NopdV
 PsZI40teTzrxEAnvFz+R4pEyk4I3fXJSoEY0WX6n2BwlVauBLduwuouGw0QcE6OuONQg
 VPEV7Tg5uscYIBk390ZfSV0MoPg+qnp39T4OINhaV8Ea63TyQ20+zQCsTJIXP7bChLKQ
 47zrvR5as/BugJbswy2fGu6Ed351LvdbP5Vmp6k7B1rCa85GPIqjVwOLwDYa9RptDNRG
 y6pw==
X-Gm-Message-State: AOJu0Yy6rnqBlYRSm6vLgb/f9AYEZBO287QYuhb0MOznQy06PK1/ldtK
 TPOZBUIEIYTQobMcpEz0aiqzqN6GU1kt5kn1mNKWHY4vtpjqkIHbpoJrDNvLQV6CGFsWP96+DY3
 glu8=
X-Gm-Gg: ASbGnct9vFPCcd4SkiIMKrr85UITcX4N/MrvkJKooXFq/kRErbNTssKsX6cxs6Vadm3
 BW49CxTTC5mltniFnZe7HGtiNrn3TuJtK8YPq908vP0qpJdTFbiFPdYe4k7m8ROubv7jgPTf3f4
 JUSbrFoOIbRLBlpU273Mn7to62uiMyaxfv0ffEdKJSHeBKJb6iSwKTjxV94C04Rd+R98F8ma7zi
 5kYzCxRX2l04XesWRMpDN2aioWdiQbS+2m+3ry4gEUbL+Ng3jhG2fob9uc2sT+SrXhT3eoliLDZ
 GP127bBd4HP2KYB88f1nL2A=
X-Google-Smtp-Source: AGHT+IHTeDn2rF1Gc8VbvklsYqSjOxWd0+zrwSLWSwUezYC93KhaOrwl7v62uWK7NOnvJkNVNJqNNQ==
X-Received: by 2002:a05:6a21:497:b0:1ee:e145:835d with SMTP id
 adf61e73a8af0-1eef3c521c6mr6667037637.5.1740159490082; 
 Fri, 21 Feb 2025 09:38:10 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Stephen Warren <swarren@nvidia.com>
In-Reply-To: <20250212222400.684553-1-trini@konsulko.com>
References: <20250212222400.684553-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py: Rework how test_ums.py handles (not) having
 write enabled
Message-Id: <174015948920.3526942.8480848938487379965.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:09 -0600
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

On Wed, 12 Feb 2025 16:24:00 -0600, Tom Rini wrote:

> With a newer pylint version we get a warning about how mounted_test_fn
> could be used before assignment. Evaluating the code, this can't happen
> because we check for "not have_writable_fs_partition" and return before
> moving to the part of the tests which use mounted_test_fn. However, we
> should instead have this written so that we only try this part of the
> test if have_writable_fs_partition is set, and this also fixes the
> warning. As part of this we also move test_f and mounted_test_fn to the
> section of code that already only does this if
> have_writable_fs_partition is set.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


