Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF05CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 17:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6C1849ED;
	Wed,  6 May 2026 19:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z7MYOyKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03187849E5; Wed,  6 May 2026 19:17:36 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E754849EA
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 19:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4be94eeacso7380277a34.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778087850; x=1778692650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z4BqFYVxCRZbFRrJ/G+qw+AImEqM6vP9MDgfyY1TPRM=;
 b=Z7MYOyKtfKSdY0sYEWqO472uVmaPIahYh7kylc44JJ5nLrh+7bDL+jqqEX+2fU4t93
 M0Bdxm1TKQIxc3boxanwZ19MA4Eh/s7cuDnqWmNPcy+dmuC2kduxIuOlhdfHsyXcX3+2
 XUjNIPm/J8YE3ZeElsQDYRkMLtnzn1oJPAxNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087850; x=1778692650;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z4BqFYVxCRZbFRrJ/G+qw+AImEqM6vP9MDgfyY1TPRM=;
 b=o1oMWVBjG8KY+a3bIaLStwpuxuzmGTb92zWtC6EeMUWAgXmRaMB1w3eOKBvtSJCI8e
 imujCUjzt1zZcgWjoXc3CHq8XaB/iqwl83ROgzJykX5VA37zCUmkHXUn8/ArjUR9cMul
 HDZLzb3DpBu+QocS8DHT0KrM7j5L8Hji/e0hk7WoKQXiRIGoUqZYWnquxJMVEUiMXK9C
 Lb7BPxXTT9HYp6Mm0V4jUtYKV1TJ7IhmsVX05UrwBjk0PSvDK8ocg3oHf647M4fk9jYb
 S9Qx0FiCjj55GALOg5uziL3DrHHVdhJxVf7x0MbLOWJnrnt53M+Xq6DdQ+tWKASSdds8
 Migg==
X-Gm-Message-State: AOJu0Yyxrdyrl3RyAJVm3BNJfch41rtSJBFCnJ9EiZVnrWh5Gy3iwt3t
 zzWNa9xKHJKCL6Soh0WWF05S8geJdAm8ukhPWQ65xd38MRBJ3UOG/Z7TYRa3US2pnws=
X-Gm-Gg: AeBDieuJTUrWnCDJgYjpypDXk5EIE+BTu5vlF0BxhtDFkEn6hRSkfmm0izKX3ENjVi5
 cjY7Qi5kIQlQFlC9NV+WPefvOIqYK+tnMvAHFUF4jykz+mP+napRrCuQ6EUDLm7vX46O43oQ4CK
 srprQE4nDGyB0sO+otiAHaQykHG2jV/ks3r9chfwcSwJjKwQU1jryGewBOc1wQtwUc90RB1a3w4
 SZukfsWp2MY0Y6d1CvgfaGfX3/oW4Nnd9B6UbBkb6fYu+z0fkl7md4IkZa5q8vh7orqcuU8OOcn
 rmHdoFz1TAlJQoXpk1oSDuNNxNEpiboAwkl9J/zVlh3eQerDtnLvwshE0EZCYP4pFYrD2kRRt25
 ci4urC7o102s8b2GDyo5e03FjGFc1bT8EdT0dVG01WU9wmsWe7i94UyMZcJ5I0OF7q/v6nkdm06
 Zd/QUaW5qsnf5Sul6JRjBTNML3I7O4vyYufbzSaVQGix/ffruUFzi3A9pliyGdRX8sQ/kkNtj0K
 uJZx1iCZqT5KmlldvoHt3c+XOKlgQDZq7WoD379SwWVCye8aFsQX5G2mxHrMj7Js/Pjm/s=
X-Received: by 2002:a05:6830:6401:b0:7dc:e45a:ade2 with SMTP id
 46e09a7af769-7e1dee81554mr2312384a34.5.1778087849899; 
 Wed, 06 May 2026 10:17:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca80d5b7sm12380327a34.9.2026.05.06.10.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:17:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20260506144730.168827-1-daniel.schwierzeck@gmail.com>
References: <20260506144730.168827-1-daniel.schwierzeck@gmail.com>
Subject: Re: [PULL] u-boot-mips fixes for v2026.07
Message-Id: <177808784931.2488.331036678158907036.b4-ty@konsulko.com>
Date: Wed, 06 May 2026 11:17:29 -0600
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

On Wed, 6 May 2026 16:47:30 +0200, Daniel Schwierzeck wrote:

> please pull one bugfix for MIPS, thanks.
> 
> The following changes since commit ae8987f4e690f397f507c4b1efabd68b3ed08db6:
> 
>   Merge patch series "binman: Fix preload signing with encrypted FIT" (2026-05-05 10:37:16 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


