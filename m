Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579E4C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 12:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E8887FC2;
	Fri, 15 Mar 2024 13:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="im+AhyEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC8B87FE3; Fri, 15 Mar 2024 13:19:18 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE4787FC1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-789e3f17a6eso45319985a.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710505155; x=1711109955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TSB7ot8Qo/Wtp0z35KcvLYg8XiYiFxglIzIowF/c8LQ=;
 b=im+AhyEZCBgRsY6CapAdVBN3YYlXMX6ncAG8VFdMivynZ+rTtfH9dCetI2X14G9YQU
 o8FSMx6FAyYsvktaJLQK9d0I38Cm9n5djaeA9rMqge7BrMfT7psmCP5SDOvziPyhAQub
 ocFFiUzwWqI65icCl3AYr2oX6ZqQ+jIUvyhzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710505155; x=1711109955;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSB7ot8Qo/Wtp0z35KcvLYg8XiYiFxglIzIowF/c8LQ=;
 b=hIQxyEDd7U94V/FvkU2HP/C0bd2/eOGnw/tZpAnDWuux86/nvFUqm3SZ1+uk7JwIiv
 +nRU5oYNiPpQ3qZemDsPIPdRUkf3go/s+ORNnzXQ+j0uSzgJ8i/WLTKP55m8/0pkCg6a
 hmUTBBBc4GY8VR5daT5o5KVLhxxdhW4ELwIBPxjY7MO83FvK4aPDkyy06kxnYuE3CvsK
 jVt0c4xMlT9wio4iDiEd9zI7GhOvadLtqDfYfRkBQy58E7dayH+TcDsdnJKoKROCB4js
 kVXra/HKdi7alLyQ5flF8/eCkuSJJBvIf++QUrPN0Pxylg0rGz8500xvMpCE/Z+qcLps
 KzrQ==
X-Gm-Message-State: AOJu0YzofYT4C7EGRpGrTESem1yB0qv6fgLm10ZlF308QOEFzMOc0SRg
 JGWrf4qTX52g9jqRMx1cdSLmVq2qeoaJV0hh/R3be/Eb3uFGC+RSvnE7xZE8M0Tpwe16Vno5VoJ
 d
X-Google-Smtp-Source: AGHT+IE5KGemNgBW5fRnuRSCgTJwqBS1bEVPK3U8VFv0Di7u7406eBsZ986mDF42JqvS4aOjW2ueYw==
X-Received: by 2002:a05:620a:a9b:b0:789:e7ac:f56d with SMTP id
 v27-20020a05620a0a9b00b00789e7acf56dmr805639qkg.47.1710505154854; 
 Fri, 15 Mar 2024 05:19:14 -0700 (PDT)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 vu24-20020a05620a561800b0078874565b40sm2009011qkn.30.2024.03.15.05.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 05:19:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240315023643.728195-1-trini@konsulko.com>
References: <20240315023643.728195-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Move to latest container image
Message-Id: <171050515404.774434.13243120217405012524.b4-ty@konsulko.com>
Date: Fri, 15 Mar 2024 08:19:14 -0400
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

On Thu, 14 Mar 2024 22:36:43 -0400, Tom Rini wrote:

> This moves us to our latest container image, which is now based on the
> current "Jammy" tag.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


