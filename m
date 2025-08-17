Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FF8CA0EDC
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 15:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B3B1830B3;
	Sun, 17 Aug 2025 17:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gwal9A8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A448399D; Sun, 17 Aug 2025 17:24:48 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51CE182B07
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-435de937578so1762458b6e.0
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755444285; x=1756049085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l45YEzYbLM2RqZrkgvFnCGmvC3LkusN8CY1PStKW7HE=;
 b=gwal9A8DZCz2cfNKHbgYhXNHz3ofCr10n80/DeqL16jdusVGgmva6N3YZnwC6BlTJF
 8vtaJo63SGjmchQAZMTzDgagpo6JADqp2AJfEEkiX/OhWX9iapdA+MURxibW6wKpvw8S
 JxT/gFvvyI3dMP5v9nPdBkePgCwo9ydT+wpfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755444285; x=1756049085;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l45YEzYbLM2RqZrkgvFnCGmvC3LkusN8CY1PStKW7HE=;
 b=TjVjk7YeIfWnhPuWoLylTq+Eye3bbC7QPGkI2Wct9Y6IbM4NpbAsAmdKSxJ+Jgc8FW
 M0L/FP5G08tGYylodWGAzY2KVzSU6ZyfDNAcW1XToDLfgDE7rKwScqt3em5oVVkd7X0S
 fi7QgmZ3GYPvFmkxiYOT73HMnJarq0+7O0THrjuundvYiU7I5J1OyUuYPZxq8WkkD5gB
 B02ejjInWW2ytDul2BgQ6g83b0HFjRvTeRZRD+CEhad5Te/pVfnh1AHxtKB7oWkjSMjr
 y/A1U4XbS7eZuvBiksI/kJvuuEs7bgqkZXdS+CKkrZbjVKyvt8JHDfhY0hIrrBbqeFJ2
 VTKA==
X-Gm-Message-State: AOJu0YxliPYqWWYhXyEY/NdgOupzBWqyaFZlsFiJvbAHrnpLtKhRBMWb
 XFSTyP3WLSytvWNJfNmmUPH5kdCwXC4qIXTDsrWJnZTQBjgrFxwCqteuubNNoLTx19t6Bu8PKaj
 EKQQF6+0=
X-Gm-Gg: ASbGncudt4tH+13OE6WwIiZafUHlZa/fxTEWaR1X94RJqmf976tR4SPqYtM46WmI0yu
 r7pb3AU2lxj01cpX48UzNFLqZzJPfDVm86wKIH3qrunb5k8AawNL0kI5V3Q/AgjHntycL0xJpNU
 gc2rHisG5vxoxCTAGLF504gB6G8AHii88e/0Gnx/QvMuSLflkz3tDqTfKifASNPXufEFIaufxMZ
 ML20Ckpwd1wNvEC0V6jR+26J+8ODFmMRk8yEcf9wkdyL9AF+/oaW/X/ohHN2+XQA6PcBje9qKKv
 0Tyj2C7Lgy7S2Bthv0Q3c8lLMNh9D1qiO7G3dVkR8eWbqoLnIaDosWWkdKBgPHhY9LDW0BSL1tr
 Y85lkacLTaUImrInhPJae1vvCp6vqji3y2yFAtsmSgSM1dJnNCJ9ghqw=
X-Google-Smtp-Source: AGHT+IEjowzlT3O5sj9NfiCe/4CEGTnWtXaM2QPxslqy0deGbomC3Y+qwe0Jh5pvyz/GS2OPJpxeCA==
X-Received: by 2002:a05:6808:1910:b0:435:80b6:d27e with SMTP id
 5614622812f47-435ec3b14b7mr4897355b6e.10.1755444284973; 
 Sun, 17 Aug 2025 08:24:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab878a4esm1998472fac.3.2025.08.17.08.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:24:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250805-net_cortina-v1-1-5a3faca0ad2a@linaro.org>
References: <20250805-net_cortina-v1-1-5a3faca0ad2a@linaro.org>
Subject: Re: [PATCH] net: phy: cortina: Ensure memory allocated is freed
Message-Id: <175544428297.372553.9413269894681708125.b4-ty@konsulko.com>
Date: Sun, 17 Aug 2025 09:24:42 -0600
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

On Tue, 05 Aug 2025 17:10:26 +0100, Andrew Goodbody wrote:

> In cs4340_upload_firmware a buffer is allocated with malloc but this is
> never freed. The pointer to this buffer, addr, is not even kept
> unchanged. But in some cases addr is not a buffer allocated by malloc.
> Introduce the use of another pointer to keep track of the buffer and to
> know if it needs to be freed.
> 
> This issue was found by Smatch.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] net: phy: cortina: Ensure memory allocated is freed
      commit: 145a6f447e47f679218f8886c06622b19f4e22a6
-- 
Tom


