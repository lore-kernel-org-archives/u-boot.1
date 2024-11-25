Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49BFD59D73
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 21:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5E288C9C;
	Mon, 25 Nov 2024 22:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lRLYAuBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE6D896C3; Mon, 25 Nov 2024 22:28:45 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04602890A8
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b1474b1377so375019785a.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 13:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732570122; x=1733174922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qYd//irFcvUm3dU3DY/eiENHprft+J8Q93egBxI55dY=;
 b=lRLYAuBZjw534Ku1FtiJBlwIyzIa9exfVftCBfSFRiKUQvvkAMbT7je6SgPtyYbnxf
 isx0rHoU/R6I0Ods8wAkThin39h2JENZGMgjG/xRE6Yn8Woe0yrXddPjekG6GZ1hjXqb
 5hGiId4Sa8ZIHJ+zMqczLGl4vfTgJaKd0HH+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732570122; x=1733174922;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYd//irFcvUm3dU3DY/eiENHprft+J8Q93egBxI55dY=;
 b=M8BiSDblu7WvnYH4nWb3NKfoT5Bc0HWUAPoGXgH7QhwCfr1f5Kv52Ue2XJR7njbaGW
 JAi2+6S9PqEbA4pX88qTHSPNtKesYAn0L36bHe93Q3LRpynsBHAgfK3W5i5vhBxSQcYR
 iWkMHCWqY++DbD82iOZ8j8rha0hlYcIgJIvRQg5nMgdVUVGSXvhxHoQdABd0LMQZdtT3
 lNZD+jE9pUYpOXFlW2ZhrJBzqmXF6G8NmVOKQO9EyrHsxi4chA+POO4eef0EdEpQ0G+U
 ZyIfqSKdGKJvxZmPKDF3nTA9VfcRPYsfLxtLKPQYBEZ0ugGjkjubpBieDVpIZCd5sR/9
 6qjg==
X-Gm-Message-State: AOJu0YyD5BcVfLIMhqKMA2JbX6BmgH1Ch4+6X4nQfDg3EMYvQRHT+tf2
 /Wn/BJ32EnkMlssr/50FWB53qDZNDgAVC+vezNFwx/OUQY+rQTA25SH0p0sedAtZiQGDp45BbRk
 r294=
X-Gm-Gg: ASbGncvrmZQ3I2aRjYlZTy8o1A0ZTttpT7mhdijv27zpC4gNmWf/eiQRyHUyWtF+wzr
 cm75HdcZrixQoSTVaN/Yve5q0O+8Ado5e6s5HOWy43gBAR2XIfcWMoF6KwkJh0UR24bJ/n2jGNu
 +iVHUvY92YsPIdO4jO3tfqmefw1X9Z6WcCLyoWN3XuykBIczPkWckYVdgiWWpIT8pw3h2uXlcUp
 TfoJx6HqSRpUEtipv6NoymRgOdCme8IVEyg/MjloZjllY1+
X-Google-Smtp-Source: AGHT+IH/T9RNilov8rLfImjZK5bjWf1gIEwJOmQDXroxv+R9mbBsqdXKC6U95Bhj92GN0MqLPD7Gyw==
X-Received: by 2002:a05:620a:1912:b0:7b6:668a:5a5 with SMTP id
 af79cd13be357-7b6668a07a5mr742277285a.50.1732570121257; 
 Mon, 25 Nov 2024 13:28:41 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b66003e909sm223082185a.69.2024.11.25.13.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 13:28:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241021142040.2981390-1-andriy.shevchenko@linux.intel.com>
References: <20241021142040.2981390-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] mtd: Drop superfluous const qualifier
Message-Id: <173257011976.3962364.990881836798624153.b4-ty@konsulko.com>
Date: Mon, 25 Nov 2024 15:28:39 -0600
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

On Mon, 21 Oct 2024 17:20:40 +0300, Andy Shevchenko wrote:

> The compiler will ignore it anyway:
> 
>   include/linux/mtd/mtd.h:342:15: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


