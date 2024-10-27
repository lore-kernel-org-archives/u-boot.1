Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292D3D1358A
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 23:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CBE88EE3;
	Mon, 28 Oct 2024 00:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DoIPl9ET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3F88862E; Mon, 28 Oct 2024 00:11:26 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EECA88F4F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 00:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6ce3fc4e58bso22779216d6.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730070674; x=1730675474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xll5TON1WDPbAvprPaTw+VjTnceF9rVHrImr3SnYjxI=;
 b=DoIPl9ETJgDB7Q4zFMtXFjiNIpyo/80wRk1B6OGfKSNqjKlIUMnp6tLDrhWOLYwVqW
 JWoA2040xBI4/eYUI3KII21nRKV6QSgxqITdHQy+WYNF2CUQeaJADLm2icqOB8LoCKm4
 fa1uKGoYiqCwkcDmSGap1Np7LO8M+SBkNKYds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730070674; x=1730675474;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xll5TON1WDPbAvprPaTw+VjTnceF9rVHrImr3SnYjxI=;
 b=WdK31MWq4kMk7916fw6ZE10rMvzQZ+P6jF65wg5muASBLgUrnBet5QPZYWQ7KP7fb7
 WC42hLm/siQ3ty50D2uljP8ym0uup0ssBqfHPTM3FiJMgOOCqJNTDF1zVSMn2F5t++mv
 UvRyyZuHxI4av4MtpdWeUhRsGM41UJSch7L0nzJXRt9Br4GisdMxXg7u8RJ/8l+XHvSc
 11GiwuiQJeePC6cmXO7ydCRt8OUNZv7Bvlz5/6YbQ2yqzA0+ytM6dFYCTOi/Xh/60Gv8
 dgJAuEr/fqr0OvnJAeMMaOou7DdqwWQn4id2KWhb6lyD8ibphmpT1YmmDZWyhuq73swk
 uP2Q==
X-Gm-Message-State: AOJu0YwLu4AFxyN5J0cUMebIVTwaD422pZLGXkfiMlJMqCy0ButtjLyh
 eiyRrOW7ta8PHWLGOyboxDuA9Y4xRgCEB3MEE2Nd7uRcKlw7BK3BiiNStyHmt5w=
X-Google-Smtp-Source: AGHT+IE7whgwWzRIhKK/zWfEDNQpyOocprh28gUPzW/s8Tw7xQsMHI5STkDOKkyk3LJgh/8H4tP0aw==
X-Received: by 2002:a05:6214:4588:b0:6d1:8261:174f with SMTP id
 6a1803df08f44-6d185816d6fmr107501936d6.36.1730070674220; 
 Sun, 27 Oct 2024 16:11:14 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17972f622sm27464976d6.9.2024.10.27.16.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 16:11:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Maxim Uvarov <maxim.uvarov@linaro.org>
In-Reply-To: <20241009094208.1212555-1-jerome.forissier@linaro.org>
References: <20241009094208.1212555-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v2] net: recv(): return -EAGAIN instead of 0 when no
 cleanup is expected
Message-Id: <173007067229.2057421.17116036505712665875.b4-ty@konsulko.com>
Date: Sun, 27 Oct 2024 17:11:12 -0600
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

On Wed, 09 Oct 2024 11:42:08 +0200, Jerome Forissier wrote:

> Some drivers do not behave properly when free_pkt() is called with a
> length of zero. It is an issue I observed when developing the lwIP
> series [1] (see "QEMU CI tests for r2dplus_i82557c, r2dplus_rtl8139"
> in the change log) and which I fixed incorrectly by not calling
> free_pkt() when recv() returns 0. That turned out to be wrong for two
> reasons:
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


