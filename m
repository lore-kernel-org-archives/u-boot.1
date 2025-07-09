Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67917C83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 23:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDEC835B6;
	Thu, 10 Jul 2025 01:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uv3oJb4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41490835AE; Thu, 10 Jul 2025 01:19:00 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C6E4835B6
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73a43d327d6so208778a34.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752103137; x=1752707937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I9L8DUdGupFb01HqTMtTHxmDnTSWCAYifi2Z9Ak9LfU=;
 b=uv3oJb4ASsitV9GVStXV11OrOP7v3KbQTap5kJDRrdERL4whWM68ngKYoC4E6MOvXD
 hVb7YHA+rOrIFvUturnpWOrP6XcFPsk6sp9Ww3T8hJoMDWJ9oZlCb+TUu5UjxLQf+Wft
 i5kbRKwOJRWw+vYnq5LT+eTgYks3pwXFbDeW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752103137; x=1752707937;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9L8DUdGupFb01HqTMtTHxmDnTSWCAYifi2Z9Ak9LfU=;
 b=b6UUYoYr1rPBZuiftFLnu8ckYVFn9yrPBRNv2BmvGq/DkMoH9yKXxajVXY7cP57+VO
 GcYoUwBgGULfq2edRtHaofzKKZLHOmaC9iNCCkQNr1MmHbRTbnhqN2KNiQqwO5jz8Ktb
 R5kSKaLoqac38FbvfaDxjJfvhORAwrR6M8koONYqzxBRlKqTnoL1gKfhgHRVtP+G2hKj
 v15hAZ4i9eepHkC2ycN5iMZ7Yiwhbsqo+WLCsjqzap6uPePfmqo7pcZVMEcQG2+FDsBo
 b6ruqdU8qLNI9GmZDzhfjgDupR+gG9CXpg5xAArQRIcX7sUW9ZIvH9fsR1OcqwkwrY5v
 /XSw==
X-Gm-Message-State: AOJu0Yym39npkchk3yeaYT7S0DKxS6vjnVbx/ZIwBCwyhtRoAtFtRyrq
 ZKWBflrRiJyhY4Vgn7GWTRi+ny+1Nn0d04wY6WhDriAzIbhpoeKfA4SqMrqe1uKZ3URq7Vxpt+A
 goLRiIu0=
X-Gm-Gg: ASbGncsIx+UYCGQB5mzRhAigjqwWIyvXp81Tl89FpLj0+gdI38yJ2+UeHmIWGM8U8Am
 EXZUhjtMDsBsysmxYlbYHj0sMQzsN7Fc/ym3gGOF3eEXus4AuHgIfKX6y307dZE+qm9dzXKZDEA
 l7C1m3ZowSzI93VH953+51kYELH6bflzZ/nkkBzskajs7GTlakSbVAfEiwysTE+AGddHIs3lcYh
 AJWRbk5zjN5qw28TNIQ+AH96SVeRQl3IuUTbo+pxuxrHzM1QIfYAhIioJkR9mryPbP1PO8b/RDV
 0ZDIuniloe7uH6oDTZSyst+3J5UQtkMwCGXYG4eFLqY8VWm3cHXC7ylPSMbPLYeAPwb8uJh2JA0
 zt7LvTf4ObYEEO2B86Ik=
X-Google-Smtp-Source: AGHT+IHwH1J7pC1S6hx8eBbg0EgDTVg4rviK1cMZcMnmyCpQTe4iuNc8x0RsGbgQcu/NIGt5OZDi3A==
X-Received: by 2002:a9d:6a8e:0:b0:73c:c494:a033 with SMTP id
 46e09a7af769-73cf067e7c9mr272838a34.23.1752103136885; 
 Wed, 09 Jul 2025 16:18:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf127258dsm33211a34.34.2025.07.09.16.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 16:18:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250701184228.3191384-1-trini@konsulko.com>
References: <20250701184228.3191384-1-trini@konsulko.com>
Subject: Re: [PATCH] gpio: Remove tca642x support
Message-Id: <175210313610.1870480.13204276505035371612.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 17:18:56 -0600
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

On Tue, 01 Jul 2025 12:42:28 -0600, Tom Rini wrote:

> This driver has no users after we removed the last supported platform in
> 2023.
> 
> 

Applied to u-boot/master, thanks!

[1/1] gpio: Remove tca642x support
      commit: e6d7477103bc94a58460bbf2f12290f4f327fbc8
-- 
Tom


