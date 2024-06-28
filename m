Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AFEC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492C088591;
	Fri, 28 Jun 2024 21:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rxtSabtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F5188590; Fri, 28 Jun 2024 21:49:26 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1421A88168
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d55e963db5so553559b6e.2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604163; x=1720208963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8rGKA7OD+k8g+s89jcSGBIuTnFoufDvSlDyb/L2E2ZE=;
 b=rxtSabtWApCXCHReCHh+Z+9bV+B4zkUK3KMKJgIW7yy9nbA+UK2Cqo5moKC6upa4Uc
 g54BMBRDl2dyaUTICWV7YAM9FMRv6+kwkBxJBcCzJEePj38JvoZCkXkTsqoSHazs83qW
 CY1ooYFEx7jINHMhoofZrfY3oVkkidxvQAOPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604163; x=1720208963;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rGKA7OD+k8g+s89jcSGBIuTnFoufDvSlDyb/L2E2ZE=;
 b=J3F7FCaHqBzIqF1zTQsUly9m5x1bvu7FJ8QUb72U+bMe0a6kmhkRRutp6jkljVttwY
 CgjS7v64qDTA0NsLcxOJx6npnLGodTo1DbfKk+qfcGvnwpysTglLovHeq9p19YfTXQOG
 E5nrQJRbAOpxyEz9vD3tD5R3HMzxtaHh1EArfc/074QVqN0dFratQPzqW9Jsu+4Ign+6
 lf8CGUTpxdbLEhqoi8h22llOnLgoqyfSbC9rnB1G6vb9Ge+tTe8rR2gmdzG7X1SEVbu+
 EW42nmOj0Xrteh8n3h4DtOE3QJPWpcXHZBDAiHy2GBDkIk8HrOFCCvvv/82xWAmtq4sP
 pHNA==
X-Gm-Message-State: AOJu0YyymXrqi8+60ZGbu/e+IZFrH2tfQPz9KQKqj9jL7iLWg+qbACuv
 2lT/zJjSsz2jRxuumAimmy1buZP7aBXzBltPzdkEoeeyndap1go2A3R5tVtl1AHZO4pK+ka2bcD
 oJGicVQ==
X-Google-Smtp-Source: AGHT+IEnYnEsi2c5vZxd2FunN8OdvyNgAcJ5MMO7bel3jDC1eSGrRoQ34UoYnyI0+SZd+AJKoMFPvg==
X-Received: by 2002:a05:6808:1241:b0:3d2:1759:7db0 with SMTP id
 5614622812f47-3d543b1459dmr20244637b6e.35.1719604162770; 
 Fri, 28 Jun 2024 12:49:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240618141851.3303112-1-trini@konsulko.com>
References: <20240618141851.3303112-1-trini@konsulko.com>
Subject: Re: [PATCH 1/5] Azure: Correct comment about the strategy in the
 world matrix build
Message-Id: <171960416129.3614069.12906246097408733254.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 18 Jun 2024 08:18:47 -0600, Tom Rini wrote:

> At this point noting that we have a split in our job similar to TravisCI
> (which we have not used in years) isn't helpful, and is also not true
> anymore either. Instead, explain that we split the world up in to 10
> jobs as that's the maximum we can have going in parallel on the free
> tier of Azure.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


