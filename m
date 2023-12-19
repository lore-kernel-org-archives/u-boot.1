Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B19C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F798756F;
	Tue, 19 Dec 2023 15:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JfxvzGkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3C287561; Tue, 19 Dec 2023 15:55:17 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D4F87508
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e78d94855fso8093197b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702997713; x=1703602513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pt122wT612bKd52zknx8v5n/y/jtYBU6/JqopYMChh0=;
 b=JfxvzGkLVNvuHMhWxSnnmxZVsNyZUC4JPgaOIHprIxrOQ6/v+9EFktk5M2ulzI+tTS
 uMm2cnyCliep2KzH10N5+s2gnHpsnJCAawNzkYP8ugEL09vdDozV/imy1PTApqHgiZT9
 Utgg9xES9H1VR890I9PM9ner4RQ9bU5aiTjH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702997713; x=1703602513;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pt122wT612bKd52zknx8v5n/y/jtYBU6/JqopYMChh0=;
 b=e2wl/jf4UKjpzkpGkLQqzaGMZSAbIBWpmsYgsxPz7Vh1E1nuXZM1jfDX1Vx149GPhW
 dWXjktK/UPPLsz47RiPbmG6dS/RAPw2PhRxm9rHsEiqjiO6CvJ2FA5RDjXycj7PgIa1A
 Mb++KmKcXMrs0u+3fEGQlAP2DvizAqh8zdPbJTdOFDCeMkM7ShP1OVoliuVFSMcfPnCp
 /izFFotFZRmFcSKJDEr6OKG8zFgGGGW/E6X/EVZRTyloG2slP5t9H7ObJT+DlU89rR58
 PDaJsBDEbdJuPU4bxsSD/ZjOsS/kZ3uXawO29u1M90uAIXB2kscbZi/6F8fiKK8KqFXt
 GIJQ==
X-Gm-Message-State: AOJu0YxBdztLwHCVsuu5Nuk09IwvIuH4UujsvjeFGWVj4G7XsayPXXC3
 FKmkzwvBAp/zKlmjEGRdBKsqOw==
X-Google-Smtp-Source: AGHT+IEdEGiUyWcFhq9DTUYRUrBJWALbn3N3nOx/bitAwU0hxq3VbpNWtUBeUAGcLbOW7lLmAHgKRA==
X-Received: by 2002:a81:a105:0:b0:5e7:da7a:8dd with SMTP id
 y5-20020a81a105000000b005e7da7a08ddmr521806ywg.72.1702997713252; 
 Tue, 19 Dec 2023 06:55:13 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a0df504000000b005d746ac7f6bsm9657580ywf.69.2023.12.19.06.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 06:55:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Baruch Siach <baruch@tkos.co.il>
Cc: u-boot@lists.denx.de
In-Reply-To: <e418d8cdf88c8ecf8cf1b9d50ae53aacfe884f94.1702885073.git.baruch@tkos.co.il>
References: <e418d8cdf88c8ecf8cf1b9d50ae53aacfe884f94.1702885073.git.baruch@tkos.co.il>
Subject: Re: [PATCH] net: fix NetConsole documentation reference
Message-Id: <170299771147.2342388.15339758346670295528.b4-ty@konsulko.com>
Date: Tue, 19 Dec 2023 09:55:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Mon, 18 Dec 2023 09:37:53 +0200, Baruch Siach wrote:

> 


Applied to u-boot/master, thanks!

-- 
Tom


