Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA87C3ABBF
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA56682A0A;
	Tue,  6 May 2025 01:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K91NjokD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5366C828B3; Tue,  6 May 2025 01:35:33 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D4BD82169
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-601b6146b9cso2502298eaf.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488130; x=1747092930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hoZI4yueAVyi4rtUeCklodprpHvfBzlNoFJKjt35mrI=;
 b=K91NjokDyd388+AlIYGDrveGvwOlZGpjSItQiPLdT82n/dfcwe5bwc4X5j4fvXsqE3
 yR2KAi15psaWr9qh021a8P2fXf1JEfxhu9fzGe8mNbsGKWk37Oi5p0eZr22AUmPKH09G
 hOtXxIXAQrhv5/gAtoFC2/0S5JvInTHwnmmzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488130; x=1747092930;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoZI4yueAVyi4rtUeCklodprpHvfBzlNoFJKjt35mrI=;
 b=FZHKw/JSIjkrHTm9agMQYGVPfuW3jA/YTVTwxayQoGRkVJDz51Enrz2k1ANt4NKBV/
 Ztrn5qVaUL5GgyXVAlpbtnZCJOSwVtLB51BSJqz1t4e1QovoE8u4T8S7oAt9eb3WGQSC
 GSsXOqiiGZH81DjQR8mw5HSFteZODqE3yn1/KDS5B6aoCIu7YccgdIVKs4ELAu367nkw
 4HZNuxB+Fh+QuQqHevtOXDZr33W9rT5f4kAttDMSxquAuctX3p4Q67KqU0Rn0Zjz5gWo
 6NIY0lK6STRvGlq1biGwrffz9VN0UD/zwpzFoGb91drzKCPI2CqLDtV4SaKKqU2bV64t
 VSTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMj82/jM7tHNsGywBVsTqRzQH6xqk/za4dEUlWvVuU8HocH6LGoNTjQnhKxx7IB+ChdlE5RmI=@lists.denx.de
X-Gm-Message-State: AOJu0YwV5m4hSHjPmbN9YScXc2wCyV/QDTNWK7kJioa44knsRkTYHr9Y
 3KkASSiCoyM/xMHD1DuPaLxd+f3XHNYi9TTo1u0j9Jq6LO/+lWZtGV/KrOy8nBc=
X-Gm-Gg: ASbGnctVd8vatp9uw5Qpcanh43TNz8uN6feFv3aNNw4pvD8uQdYRCWty9jwbfM3/ko4
 ICmzRihRu2GDNLnwY5s2l0OQEM1nO7AjnV9qVZEtSCoaT+oHMT1RsPFANDVknL+AntohSeCJSDe
 Twwy9ZBMCr9FrnFC/L0bAPxoL3YuwfNfI1x46S+Wfn5GvvLyMFh62FGuEtMJfzQB2fvubEqsXSE
 smkgDVhHw3URLof6xYjcdKOmLaFsyMn0MD4QnmjJbE9ozqyOvcmv6dm8ni7y1WH0GjogxDrtvkQ
 t+YvQkHqoT1P2f2VDuyhWh0rkD3IewowGCjaUcPkh5VzVIqodnJxb85HNsayD319OVQl/WW+t1v
 n
X-Google-Smtp-Source: AGHT+IELCOfoC1brY4YIYB+ZcnwXzjs2ePcOmmD6FDiVvDr+xhSB/Qth9ui5e/Q0iHswYe+CakhGAg==
X-Received: by 2002:a4a:edcd:0:b0:606:8bce:32a0 with SMTP id
 006d021491bc7-6081e6feecamr565568eaf.7.1746488129873; 
 Mon, 05 May 2025 16:35:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250407185958.15479-1-ansuelsmth@gmail.com>
References: <20250407185958.15479-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] env: Introduce support for MTD
Message-Id: <174648812879.69658.11965464603323907277.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:28 -0600
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

On Mon, 07 Apr 2025 20:59:51 +0200, Christian Marangi wrote:

> Introduce support for env in generic MTD. Currently we only support SPI
> flash based on the lagacy sf cmd that assume SPI flash are always NOR.
> This is not the case as to SPI controller also NAND can be attached.
> 
> To support also these flash scenario, add support for storing and
> reading ENV from generic MTD device by adding an env driver that
> base entirely on the MTD api.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] env: Introduce support for MTD
      commit: 03fb08d4aef8c342b583e148d1b5c4d289c5572f
-- 
Tom


