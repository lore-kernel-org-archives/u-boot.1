Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD61D3F061
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9097D83EC9;
	Wed, 28 Jan 2026 15:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LZs5XQ8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B6F83F2E; Wed, 28 Jan 2026 15:02:35 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1D583EB3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40866608701so1602682fac.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769608951; x=1770213751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0K2ZVmYF64yWl/cvd4j6VzqwZL5KriEc2G0aKyqhvqY=;
 b=LZs5XQ8LvxXrs3vUub9MZ4u53tCtqkIs13w0X9bYmNpnnjeyEC5OwGdxL0FJ1Moc6u
 bUpLNr2OBSbLiMq6yw+fihGGkke7VlZbeV5WcX6zNHTja23Zo2YY20b1BwbvujqvMCnp
 i8KIWCzBd86CWNK10SVqMhAc3nTPY4OpsPcjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608951; x=1770213751;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0K2ZVmYF64yWl/cvd4j6VzqwZL5KriEc2G0aKyqhvqY=;
 b=bP/50u8aPYYEg3FrcBIqb9Xi3kqRI0c80mEpuymtzsDIQ/t5BlYc3KNqftjovEwzUe
 oOF4opZIj74bR8BfocATY0DOWyqL69Zv4PPKZLrCuBX5bmkyOP7neoJ3Qo/U3F8DM+Da
 7QSM28XAENK5+Lc0YchWkv5scQrYud4Lc5lbidZPdxmBE0mU+V5mL44XfpS/fQmoNgak
 ShhpriJBzH9HrbldyZCk8CFLJsky79zpbwgWxNghO/ezBfGb+4Z+FBVxjNmBET3b5lzr
 c02SyhJgi8K6ZuNmp5Nyscne4NDm/d7gqyQrUUyGscn7+JDIIq69EpAzePwxZGnHX6AB
 OZ9A==
X-Gm-Message-State: AOJu0Ywf8/c2NoHZoeRuVYlFRXPbhlkC5e3gItEKwSjG6CVA8vQhoEAo
 GvAw6bE4+Is/79ETbG6mb/8iUsp0qdBX6jKohDtyLmikhjoA475CAbXtGQnZrcs5BeVhTjkZO6o
 zOqtSt9I=
X-Gm-Gg: AZuq6aJgCdeyQC3Ol2+EJp7KLSZsNxlOKsb8RTsXdSLa4RPNDtrgnLU4e4ZanVgCksw
 Hw1fUTeZE1S6KYz2SeSmnhnFPdEnohl6f+2BhESeFkiuI3BEEyJVl8AdwrIw5706thILFI997bi
 Z7bM/HX0kiMVHns1/7PYhhed1VLNtgJaCcIn3XRrTzTeJOD3rWIFs5zyTkN2AvOg3sxtWt2Q/UA
 zuXVrjgLiaQBLHZFfx4bgiW91wwr9KwLZeYGhL04fd25ZssJVPJZhklM2WafnUzclnpdl+Nea/l
 bv2w7o58b/wNMK6gmDHajR0J2SEkcFQEiP8j0KCzOejkARdckaSHC3myrrP9QZUubZ+lGLqtWyr
 HnQZRMbvBphhHx0IzFqZE7MrzigmS3IsYU40bCRtKwO8k9e8UZrgBaZk86cm+gJKT65HouNIpfx
 3L3f28MIHvF5kAN2hgvnBN51Tr/5rQSCgehSST2MXFyHJ2+vMV9BqVYJ48XxfJVvu/JLodV19c2
 Zl3rnDy8wwxjFqOyVoHSvv1ux6X5VSO2JsfOg==
X-Received: by 2002:a05:6871:692:b0:3ec:a4ed:cf48 with SMTP id
 586e51a60fabf-4093fd6ee54mr3199922fac.25.1769608950742; 
 Wed, 28 Jan 2026 06:02:30 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095749f332sm1751438fac.11.2026.01.28.06.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:02:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260118195610.81287-1-trini@konsulko.com>
References: <20260118195610.81287-1-trini@konsulko.com>
Subject: Re: [PATCH] fit: Rework SPL_LOAD_FIT_ADDRESS slightly
Message-Id: <176960895012.1640006.17323368155731573462.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 08:02:30 -0600
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

On Sun, 18 Jan 2026 13:56:10 -0600, Tom Rini wrote:

> Options which deal with memory locations and have a default value of 0x0
> are dangerous, as that is often not a valid memory location. Rework
> SPL_LOAD_FIT_ADDRESS as follows:
> - Add SPL_HAS_LOAD_FIT_ADDRESS to guard prompting the question as the
>   case of loading a FIT image does not strictly require setting an
>   address and allows for a malloc()'d area to be used.
> - For SPL_RAM_SUPPORT, select the new guard symbol if SPL_LOAD_FIT is
>   enabled because in that case an address must be provided.
> - Update defconfigs for these new changes. Largely this means some
>   defconfigs need to enable SPL_HAS_LOAD_FIT_ADDRESS to maintain their
>   current status. In the case of sandbox, we also need to set
>   SPL_LOAD_FIT_ADDRESS to 0x0.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fit: Rework SPL_LOAD_FIT_ADDRESS slightly
      commit: 272b8784faf33b0eded27ba78ad4251151ef357b
-- 
Tom


