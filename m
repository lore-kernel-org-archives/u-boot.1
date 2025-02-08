Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AAEC02199
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 03:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026B9807F1;
	Sat,  8 Feb 2025 04:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a8Hb0DYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D4F807FB; Sat,  8 Feb 2025 04:05:05 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D5A80756
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 04:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6f95d2eafso302665385a.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 19:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738983902; x=1739588702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AT7yO9GNOLR2yJ3WqKonX1D8QRNBpUYoSJG4JTd9UV8=;
 b=a8Hb0DYK+fIhbha4JFNeGu+t/Fpi2Wj0zlBnpz1pGTIdW4vv2+bYIgDqZnbSwMu37S
 0OpqveMl911j7rVboYOtltU6iUObR9Q/XvxYCAeViVe3+RyS0ERK4S0ieMoLPOdGsB22
 x7JkLevAdWz+vV9ojrVo5Q9qxN2ZlJa8wnIps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738983902; x=1739588702;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AT7yO9GNOLR2yJ3WqKonX1D8QRNBpUYoSJG4JTd9UV8=;
 b=DK4z0WrkNScGmzSWaENxM7hcOo5vdLATWEHzGi5EWlzPyaPyhEYIDE8DUEpzmfRG6R
 rEs3gX8YW4nKmf+XiO6p7D+fhx2Yr/zZQEB/+dlmU5AD4cY6Jo7+khSJk2RNwh7KrWsy
 o+INjQTLyQd4waivWpwdx6t2HI9SorsROh1LtAwvoupAZQvHR/0sCZ9TQSC4p95MaObx
 F/8Mkgm/dqUx2VaQp2FDalJiT61WlLM/9v9WTZ9VBni2dQsPS3ay4m0XyTaTpo6f6z48
 WrcPvG+19vqSZN9vabE5n80zddvwbU/SL/vkWXwQw5jR+XwLPHjRDpawtp5+w+65Rh5U
 P+wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXey23l/mvL0UlnhKyRbReJEB/XgiEzJy5R4or8a2/NR3V+QxnayYURvvGu+th3gQwhqG9lzsQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzkYjnubGFuXnwBbFSJbg27LpZN+y1fzusJeEjFdKG7LsKmCcba
 JVF3O/RUt96XLetnNrW/jtD3dPqsn34vospLjtJilKcqT7yH8ZjBHTCYIbZJymY=
X-Gm-Gg: ASbGncs9CFndHhgUTy57Cc4/l90u7Xdr/wIF/Tv2qgVJbuC2dH0BXVCUlcVqifHk+mi
 r1NjjGhgAIGjV6FPXyaBTH9kjuzQhB17M9Lutfz8tyfuAQI1kY6C/1oSjp5s9Y0kgYodqsFPJhy
 2HBm6P2JGE7RHu9xa2BNvKglEf0hIFkttQErCw+80YpGUfGzlCUtMUVRE4hApvjufUUpj1VWhh1
 1pYa0YMHriVS1CRWF45EbjKc4WIjIuPjXSIcEnvVOoevpQxCCy35bDuLSXo4KPSQVJc9YsD9qYU
 0JMvb+i3Xu5fRA==
X-Google-Smtp-Source: AGHT+IHob8oLIEBzTCITO4OoNpjcHeswjoG/g/57iqkykB1W6OuwfzC51PEMOIPe2qMuNyWVZnrNNg==
X-Received: by 2002:a05:620a:448b:b0:7b6:ecaa:9638 with SMTP id
 af79cd13be357-7c047c460b6mr1009551585a.55.1738983902402; 
 Fri, 07 Feb 2025 19:05:02 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041e9f9cdsm261452985a.66.2025.02.07.19.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 19:05:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Massimiliano Minella <massimiliano.minella@se.com>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
References: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v3 0/4] cmd/setexpr: support concatenation of direct
 strings
Message-Id: <173898390016.2598993.9403161993959860651.b4-ty@konsulko.com>
Date: Fri, 07 Feb 2025 21:05:00 -0600
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

On Mon, 03 Feb 2025 16:10:25 +0100, Heinrich Schuchardt wrote:

> The setexpr.s command allows to concatenate two strings.
> 
> According to the description in doc/usage/cmd/setexpr.rst the parameters
> value1 and value2 can be either direct values or pointers to a
> memory location holding the values.
> 
> Unfortunately `setexpr.s <value1> + <value2>` fails if any of the values
> is a direct value. $? is set to false.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


