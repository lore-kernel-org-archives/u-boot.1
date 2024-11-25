Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08FBD59D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 21:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6732389390;
	Mon, 25 Nov 2024 22:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OL7qrDf/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9008937F; Mon, 25 Nov 2024 22:28:46 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BCB896A7
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d41f721047so37048016d6.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 13:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732570123; x=1733174923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zj/kaGpvco9kfNjaa9Gb7Fn3isQ9rvDPqgLu/HuUajA=;
 b=OL7qrDf/iPGBVRdM5dauXh/R6S9sc2WaZ6cADgKOD9fJyUDEibKl0HSkzQOgtQyQ05
 uRMgMnpD27zpeXXOJ9uf2a0Vg5LALZHhqaiNp7wqUTm3wcHs3ueYhgYNzoKrJFlYEHIj
 eu5crb/PpIhryTi7PcsoFwKsB1lUF0G8UA7Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732570123; x=1733174923;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zj/kaGpvco9kfNjaa9Gb7Fn3isQ9rvDPqgLu/HuUajA=;
 b=rhYnvwWX256IwqLI2ToxvdbLlDEkMsymvEC/hQb/LgrIV7sAzWOeNLi+iF7/l0b5vr
 maOeAlOS53E9m6NLdZiTStP2oEX4/YwjAX1BqpP/WsND7X8VYkm8ILCJv7x9XUToFuI7
 98ZsJFh9lNPoAA3EeL9eHkxuvngw/ala/4GsDdyn6Te+xzuSDIUVV1jo0IPfarOoHbU7
 1na1pCwURSnAFYAmTafi6uKqVQjmQ0IkhMt97prAgDp9ac3L+UsOAakm4xC6nLMq0fFM
 aLwxym3R6ZXpcOnAwZAWgrtPsQrRWDJp1QV9CkgTHqJxw2SJZb9MPgTYt/AQjJmSmKem
 sBng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/9+Vcjdos1gOnf3TZ3iTFHQm1p7BS7AAHmkb4QHIpcQfK4VOEzzCAccQzkFX3g08wcpP/WQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwEJkCqO4Ju9ZYGzNHzjU0EFGJe0y+KZCQvD+06fTB2uFAuxnSx
 6xTCeVGVT6d4zObGcmbAbQ085Ybp1fY6kqrt86DogXdu6XNZ9+9VghSdXbwfLgUG0yBE8qqBE+Q
 vGdA=
X-Gm-Gg: ASbGncuokVXdUTf90h8NIEDBKvn20/WVVIKL3ziy8EkuyBTA3t5NhMa/27O4OakGG5S
 BU9zS6ToGhxfBMqrjGxbll4+n/ruE4PtdxfuMkBcp3ikQ+InwfKMB6Dlso8OJyoUfavf6k1zjWx
 fQvet8cbcvSx+klZqBjL7kf5DXgMbf4GeTGfsbtlGQtH+9tFg99BiWY8uJeYmOBNnDfR+n8tjXH
 +XbPs7M22SlPAnZz3FB4rLX9l5U4KcjK502iSQWtth1MTTj
X-Google-Smtp-Source: AGHT+IF5fJMWnhCC1nBr7KVLfMU+z3zOAh7fnayMjPgRj4H3iVguPfaQBQP6zH+0LI0m2ZM9VSRjFw==
X-Received: by 2002:ad4:5fca:0:b0:6d4:2910:7f13 with SMTP id
 6a1803df08f44-6d4513446f3mr205386386d6.32.1732570123166; 
 Mon, 25 Nov 2024 13:28:43 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b66003e909sm223082185a.69.2024.11.25.13.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 13:28:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Cc: BMC-SW@aspeedtech.com, u-boot@lists.denx.de
In-Reply-To: <20241118021257.4615-1-joel@jms.id.au>
References: <20241118021257.4615-1-joel@jms.id.au>
Subject: Re: [PATCH] ast2600: spl: Use readl for reading mmio
Message-Id: <173257012140.3962364.17578389439455011476.b4-ty@konsulko.com>
Date: Mon, 25 Nov 2024 15:28:41 -0600
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

On Mon, 18 Nov 2024 12:42:56 +1030, Joel Stanley wrote:

> u-boot was crashing in qemu as the modeled hardware enforced overly
> strict memory reads.
> 
> While this code will work on existing hardware, fix to avoid future issues.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


