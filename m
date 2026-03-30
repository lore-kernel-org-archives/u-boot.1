Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898451061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABB9840ED;
	Tue, 31 Mar 2026 01:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lxvqBzRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B96A380433; Tue, 31 Mar 2026 01:00:24 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5C084020
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-46808125c65so1739643b6e.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911612; x=1775516412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mA1USwcmuLlLItDqukcrwurpQfYzvSpCeZeDfzblxxk=;
 b=lxvqBzRc7eW0u5g3QeO/VB6vWIntI1uuWe/fNe/U6a9ACAiCPv9UHmSatCcNnFuG/G
 D5GRyA+IrNxLncn5gYk9JXLDNcgAP7jOnjlZj1b/4/vpPtaPO4556BNtgTjfatDcLmNs
 OHtkDmoeThSMXWEvtdwLawTfm/7GIB+lbDsOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911612; x=1775516412;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mA1USwcmuLlLItDqukcrwurpQfYzvSpCeZeDfzblxxk=;
 b=LJ1fNLUVAB5TXkzzoNDp1TETxdVFD2q5THEBnlsQfQNC9qEQCO4h/7vO0W6X/XhPQ8
 Ir/bHJcuD5dE5fkMJ70yMTjkPRYAU1qjQ3W6hgKbwiPtoa3Hcn5gOfs14tJRVE6JaKQG
 tATXp7K/id6LZbGTTkDUCT2mGMd5+Wz4nmLi1V9APP9MSEs/d7u608i+kDIvKRCiS8UI
 PXCg1FEIqYlcU4dbkDpjHDO5v4Z8g1un3hicTv6hcfzjF15Wrx3Zcc5sZIxW8TVQTSBC
 /HhDTvofFF3O0civL+WR6ODEXfsoJV+Xf23QPT9C+bB9a4NVHD5ANS9IgCYdTyJya6ai
 Cv4g==
X-Gm-Message-State: AOJu0YzOMfvkXlMe/G5Sb8YDnr5wlBpasB4L9XELGaiZJfUg+igisSzw
 T40UdqT3CFtvitHWTkyNVPMsoya5Smfjw3LwyAeMDXaFUeP3qr7fsnco0l9ZI0+pROchrfWGe72
 +dRDbZ/s=
X-Gm-Gg: ATEYQzwLlRQg7JKq/xbmJK3s6HuF84Cqq8SXEnOstOV3DYuxshcjFn8ECo4B2242Oiu
 Fl49Yk5v3VlEK6X605DbwWF4+BYpHF3Ihgz4NB5w0ODoqE5gyfVcf/rOEqbTngF3e48zgmaKOb2
 3S6UblvZUAj/RdyOe8HlzTnI0iQxcIFqp7aiycMkS1fovraXNawxKFaAQ6eMQsx8KlH53vBb9c0
 q5J8Kp/t5uAu7L7wuHsz0INgKnzGCFouEbYUeHw+uLFd6wB8VPKIYh+ZoDWjwfduEc5XepeTWJz
 eoYMC36GGLJaYsFNySbcvjKlLeEPEZx1RlD5ccE4hvwz+UlcG40lR8aYX5YjdWM3R7W8YFSC+vK
 jhVj7SoO08TIqz1yQ0s38yQhmQ/cIN343Z/74CLvwKpvmtb3orhYM1BnUXPILUdKNXod5ZpeuxJ
 SzGzfihkDPpEQUcjMamFtw8S1ukwSsW1SpwpemWRZ6Vjqhxgw+E9a5ySVhvIxcZn91VNa0hbqDv
 9nyLPYPZAwdgAClM4naDFfG0ixqriLUZJwYCPo+C6MnrrU=
X-Received: by 2002:a05:6808:d4b:b0:467:e80b:d5ea with SMTP id
 5614622812f47-46a8a605776mr7019843b6e.49.1774911612277; 
 Mon, 30 Mar 2026 16:00:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012429.4162492-1-trini@konsulko.com>
References: <20260317012429.4162492-1-trini@konsulko.com>
Subject: Re: [PATCH] boot: Update dependencies for some UPL options
Message-Id: <177491161143.1028292.10615615543067728736.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:11 -0600
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

On Mon, 16 Mar 2026 19:24:29 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue around SPL_UPL. This
> depends on SPL_LIBGENERIC_SUPPORT indirectly. In turn, SPL_UPL_OUT needs
> to next depend on SPL_UPL.
> 
> 

Applied to u-boot/next, thanks!

[1/1] boot: Update dependencies for some UPL options
      commit: 7938048594d0edf6b1012e787fd0efda8b214aa8
-- 
Tom


