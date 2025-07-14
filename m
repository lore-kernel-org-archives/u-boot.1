Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2762AC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B00830F6;
	Tue, 15 Jul 2025 01:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fJDvrVsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CFCB82F8E; Tue, 15 Jul 2025 01:12:11 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EB283092
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c47631b4cso3298321a34.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534727; x=1753139527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIPlekRFSgpVeG3o7cTsKZYfizkw2rJnUflVczLALGk=;
 b=fJDvrVsrZ777Awv8xhU184J4LXthNVu4UIvdMaSPMJNrZLAa3FUFKxQcYtssnAoyrB
 jTyfhZ0S86IU7KbCsP2PJ0zKBpnn6HuG2dfNy4mP+V3Cr3UvanlJDgqveOo754mzv7vJ
 R6UMbRUvtREupiSQ60oqKCBjayJovSqBo/HyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534727; x=1753139527;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIPlekRFSgpVeG3o7cTsKZYfizkw2rJnUflVczLALGk=;
 b=WoSJJTgZkdexlFUURfQAjD3683xqY9U4Aay3DU87PTDdSJxTAolx/EfQE9qPMa8aFv
 5on419uypgZ/42EoifOQcZzTQiTu7y3L70OHgWy3P4AxFpGX+rEpfkldJXU8K/mljM80
 D7H1bfwQt15uHtvCc/7hWgp0SyxsNx1Bdft6a2pZjUYTadi99yaDlexbSRkGp4itwiO9
 2vEwxT5Eem25w10YpU+hLDzQujWiz+E8guUEQe3DYhcmNj3n4bqyrd36sUm5ISoWiho1
 tU54jt+do/a26uC6kWWHBSMdtbZbrfM1Ae9x4mk1D1GoFI8lwI8QPvkO4Jfb+B6Uxdsi
 t2mQ==
X-Gm-Message-State: AOJu0Yz9e2EmMgVMSpmU/WocoYVtDjfWpP+HKHhhm88pd0orayBq2XBb
 /TKhhm0Ho0gjPTMZEvldujw113Ohu83BQIIDWsopaeAY+q1rCPoH1j94F7C/kYSR7jw=
X-Gm-Gg: ASbGnctHBU9HSnSKZ6NKkqRsvHvL+YulAvZuH9GxMkeAxL2RuBvlGs+IexeHHYDh5xv
 LgjkwzzS69eOo+zUvZJjVOtKcf9IO2dp2zbxopceQ24dfAuL+i7lFzVKnSi8g7PQMeb5gqrqmwB
 AkUcSIhfhfR8Omz1Xu4jKFwG4cgXODoQ99VQyNhqqfDBWLsj7qlDLJfNjwmUVgbrY2OoDubo5Fg
 XhOsC/w/cfAF0gsewfAJoOFjyKyW+Q/p9607Dq+/xNK6zgtiCtmpLuA1cOo1zsqb8ua/L8w987X
 vjwnago78ebmV5L1GuIeliUDov6ro1YWzp1AHVwmOsQqZOKgzg3yr/eVqtRAIfNo6IyT8K6nMFy
 QvXo4Gg7gEWX72LQsyOv/zBJn4pkyPS+AfO6jg7U/neE2hb0hlLAXs7k=
X-Google-Smtp-Source: AGHT+IG8AOr6dq/sMNDCme9OjyF1ASOlgx0gWF2TdzErNaUtHpftSxphl1qLYyRXuZVhpGiHDvImSg==
X-Received: by 2002:a05:6808:4706:b0:407:a501:19cd with SMTP id
 5614622812f47-41539d959d6mr10298142b6e.29.1752534727555; 
 Mon, 14 Jul 2025 16:12:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Lucas Dietrich <ld.adecy@gmail.com>
Cc: mr.nuke.me@gmail.com, Lucas Dietrich <lucas.dietrich.git@proton.me>
In-Reply-To: <20250707155550.310829-1-lucas.dietrich.git@proton.me>
References: <20250707155550.310829-1-lucas.dietrich.git@proton.me>
Subject: Re: [PATCH] ecdsa: fix segfault in mkimage when "-r" option is not set
Message-Id: <175253472676.280771.7110453198844449481.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:06 -0600
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

On Mon, 07 Jul 2025 17:55:50 +0200, Lucas Dietrich wrote:

> Fix a segmentation fault in the ECDSA signing logic of `mkimage`
> that occurs when the "-r" option is not specified.
> 
> This reproduces the logic in `lib/rsa/rsa-sign.c` by checking if
> `info->require_keys` is non-null before passing it to
> `fdt_setprop_string()`.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] ecdsa: fix segfault in mkimage when "-r" option is not set
      commit: 6a269b7fdefe3edc60a6218f1402f17206644628
-- 
Tom


