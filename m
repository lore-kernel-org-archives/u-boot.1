Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8151C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF2980759;
	Mon, 10 Feb 2025 21:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KiDkwVFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B14806FE; Mon, 10 Feb 2025 21:38:44 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BF2803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6efe4324f96so41844067b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219921; x=1739824721; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iouQvIjGfaMN9oIpIU/1jvTCWarOF8LTvbOR1VIbkHE=;
 b=KiDkwVFymezhcdlzLkSesReExn69DYoOSPDUo+MTxzXUDsZfhVlqz+AaApPywsWAXE
 g3ztvqozncLMIOIyoVKI5udWzVhvEOmMTNjsxXsc40EUZmPonqmdtu5hK+VKYHzGgcD3
 4efYJm2dO96r9xzqkIwpsO0qtVAsUayOmSZX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219921; x=1739824721;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iouQvIjGfaMN9oIpIU/1jvTCWarOF8LTvbOR1VIbkHE=;
 b=SbzzRFX0b3lHNZM04bbKI/p9IgKcBUQp/xf+gufpEJcaz9Qm+31eP1dndgj6jYLVFo
 CM7CenA0DZ3KHgj/h8t27TP9OZv4nnQZJVJSyihcZIdMEP7Fo3zqXoDiYfz9Kb0gKYzN
 lzm35hf7Wxp2ngiSCcfImYp3ykuxwUKQfRA1bwWIE78LJANI1sd+UtHbYzZlaKQGglUu
 w7dALGfyCKwIW+paixvlDByM5A0LuFRxwQUkLP0VwPF0632qxPFOM3Bf3m8qhvwYISsC
 C09bIXdzGusn0EAP4T+ix9E0udAmS2HjwFhCwQZPIei+Bejg/HOmgO7KEpqiuuIwf5ak
 7hNA==
X-Gm-Message-State: AOJu0YwXxZO4f13tIOqvel69WeJFQjq/N/YQZxcR5pPmilkzQIxvAQvl
 zMvXkPuZOrWxz38IebOUWs283zIB5oUER1VJTGKTNj5OVxP8mhPBngxZGLl7t/CfJoTK1EYwrhL
 k
X-Gm-Gg: ASbGncvBkfy70/DjITe0b24XuVPdhmlCBjz5rm1+KkeoJquKGaSZlk+YbmHhjIOeVwK
 9KJ0r9YEmnJtub5Nw7zxroTqTM04T0lkIxeByb5ShZbD6iEJjfub3rYcNYiWwt3ECCR2FGkmave
 DyvLdZzeanu86mu03ogrIwBVCOxpih/T2ffpSHLI46Iaf78FCkUrr3LkCgM9tmg8OcSbBEWI5CN
 OtRB6iGvFoQicFnmdJztYEQdErjGXhNW7MlD34DTlHcRXP67QfzP9jgEtSxeEj5egWOymB5CV7Y
 rfafvcbb7NTecw==
X-Google-Smtp-Source: AGHT+IHH5C262mfrshvc2yYKDwTUbvBIJi7CTTzO6FoaLrJDX6sstcXv3emc9HfoNW7WOSD95LI1jw==
X-Received: by 2002:a05:690c:fc2:b0:6f5:3bb1:7b7f with SMTP id
 00721157ae682-6fb0b5f5f4dmr15359097b3.26.1739219921149; 
 Mon, 10 Feb 2025 12:38:41 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250207191250.3173025-1-trini@konsulko.com>
References: <20250207191250.3173025-1-trini@konsulko.com>
Subject: Re: [PATCH] Azure: Add missing "set -e" to docs job
Message-Id: <173921991981.2921783.16965958225120114515.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:39 -0600
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

On Fri, 07 Feb 2025 13:12:50 -0600, Tom Rini wrote:

> Without setting the shell flag to exit immediately when a command exists
> with a non-zero status we can have the situation where the htmldocs
> target fails with an error but the job will succeed due to infodocs
> passing and being the last build target.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


