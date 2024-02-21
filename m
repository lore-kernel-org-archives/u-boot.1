Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E27EC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 12:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 986E58800B;
	Wed, 21 Feb 2024 13:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HT+NrFCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE9087E3A; Wed, 21 Feb 2024 13:51:04 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 306B88800B
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 13:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dccb1421bdeso6305826276.1
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 04:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708519857; x=1709124657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MmVvWeO+jtLcmBmhvsYUKJ2oYFPsW9tILRjhcf/hGg=;
 b=HT+NrFCzWQZMJrgvUpRaaf/SMVIbP+k1Kv6HXfd+XY4nJBRgX76gZMa11QtVo7EiIE
 QzW8RYMZNMpJq+gu/T6Xo+Du2Iji7fctpdyEXy6R2WzdOGqkMZhAHPuuNOm6G22+SfdY
 iATGORBkD08iL/vNuTstt4zrEiBUL8zChRua8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708519857; x=1709124657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MmVvWeO+jtLcmBmhvsYUKJ2oYFPsW9tILRjhcf/hGg=;
 b=vkZJO4xMQnKASNM/UYOO33KCLhg0NPGy6/jgmvOCqsLOYLqGkB78YnP5gPiBOJ7l06
 Tb/lb8drk1bMg07AaAJRHNCRxwyoylpAw3cD7cELidyTMZz1s0/UvbAU7s+1O5LerU7S
 DBz/gf0mtApXzY9k5LAaJ3JrEQnPSO1gZFC9Haq2uFszpuL5jF0T4ouql4ZIIujzdyh9
 smWRI1Co5xXva0nOQ9S3MELtT3TvZk1Zy1uStXlydVqmtM4fmOS9ukxQVFeIoi8X0TGS
 cZuaxApF58rWC421bcboG6qWy5vMkWVvqOMVdz/h+CJjL3ckzMSElDB5j993l0EkeGu4
 ZE7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK9ZY6EmskFQsK9kCTiS8r5NlWus/aWupLgl4Ehjz+OiJsVON3f60IvalviiuPobUZgToD3GFZwG7r8fx0QbSwb7NFgw==
X-Gm-Message-State: AOJu0YxGGidd99znIckYLmX277IZcqt41+2kqJk/LXzNw8oiu2IYyh+O
 XjmZM8wQVX/c/jWz4CByNFAoLdUHqPa0rVyjqEXXxOga8OXP67La5Dvuh78FCzI=
X-Google-Smtp-Source: AGHT+IFxdFibTREo34GKL2GyEpvZ/svOW6vjIDUydU/q7tUX/TFFlAPtRq+Uf41OptWXPrxreaXTzw==
X-Received: by 2002:a25:ce82:0:b0:dcd:23ad:4ef1 with SMTP id
 x124-20020a25ce82000000b00dcd23ad4ef1mr16196023ybe.31.1708519856913; 
 Wed, 21 Feb 2024 04:50:56 -0800 (PST)
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a25eb02000000b00dc62edd58dasm2285435ybs.40.2024.02.21.04.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 04:50:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 u-boot@lists.denx.de, Jon Humphreys <j-humphreys@ti.com>
In-Reply-To: <20240212194726.1093771-1-nm@ti.com>
References: <20240212194726.1093771-1-nm@ti.com>
Subject: Re: [PATCH 00/11] board/ti: k3 boards: Stop using findfdt
Message-Id: <170851985589.1581946.6729814732666417907.b4-ty@konsulko.com>
Date: Wed, 21 Feb 2024 07:50:55 -0500
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

On Mon, 12 Feb 2024 13:47:15 -0600, Nishanth Menon wrote:

> Hopefully the last time. Apologies on the screw ups. Ran CI loop[1] to be
> doubly sure that I have'nt yet again fat fingered something.
> 
> This is a wide cleanup to switch to setting fdtfile using env_set
> instead of scripted magic. 'fdtfile' is expected to be set by default.
> This allows the stdboot triggered efi loaders to find the correct OS
> device tree file even if regular boot process is interrupted by user
> intervention.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


