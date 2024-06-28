Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8610AC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D9B885C5;
	Fri, 28 Jun 2024 21:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F0v19GmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB817885D7; Fri, 28 Jun 2024 21:49:33 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC38D881EC
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d62cd28645so291079b6e.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604170; x=1720208970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXxszSt+05rdSz10vHaUONIHdTtEfBpT13Y7Qp3iwSE=;
 b=F0v19GmJsEtIYZVZtQ7W1bxl9jVPGUHV10hx134EY5dbm74LFtiCI32F10WNRbm1O4
 GnuhgTQPvom1yR4TcBacUKI2ysBOtHNmnG6yCJVjhCTbQTPv32spL+OStmUvtZWAGshz
 YT6IbDy0YOWBgwcYpplO7SUFCxMetIFYdxYUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604170; x=1720208970;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXxszSt+05rdSz10vHaUONIHdTtEfBpT13Y7Qp3iwSE=;
 b=iOSDFoUfkUM6MPp50eq2rYEq3MzU2QKm704W9G59kddypNr/wujUUEArELjXviON67
 N4s8WYY0ZZQvX93rDkltLsaxWjC9qoJQ8ls+hCO1J5bmWB6fXFe8+f/i2dZU4s+oljHw
 UFiP3rKywR8VmAm0LxIOkZmuOF8mO/wcQK++VihrlgS0oQ5vZ/dLAKlqUjo31R6NaBxT
 b6UB435E1L8jTadu7c21azb/HWNx8xnEx92qOYSuMb2/UgBnKCufZ4ECsYgwx7PGDh1D
 4XzPO72vXEaa2Q8JfY8aY47RvJi1a8g4hR8PbgauOtJAvdcp84auStUB/pgQ07yaRNWW
 WhdQ==
X-Gm-Message-State: AOJu0YwOCc8pplxQhK7ImvAdUr/QffhmXgRl7cRhKkIAjl11t9uBT9JX
 flLtJBkrxmbRD9UdNsuNKb32tKFKR1UeRzFsU9SJeoFeJwqgtNGUSQC4p5OQ7b0=
X-Google-Smtp-Source: AGHT+IGlPq5y2U0ObQbcTOBr+wS4U+6CU+zk23YPksuWbfoB3KUerAl+6Lg9wglKXUM0EAX3M7Mw4g==
X-Received: by 2002:a05:6808:16a7:b0:3d2:4fe3:50f0 with SMTP id
 5614622812f47-3d545a7c537mr20579674b6e.41.1719604170536; 
 Fri, 28 Jun 2024 12:49:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20240619160944.3429449-1-trini@konsulko.com>
References: <20240619160944.3429449-1-trini@konsulko.com>
Subject: Re: [v2] cmd: Make use of U_BOOT_LONGHELP when missing
Message-Id: <171960416970.3614069.11280120037927642872.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:29 -0600
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

On Wed, 19 Jun 2024 10:09:44 -0600, Tom Rini wrote:

> After adding the U_BOOT_LONGHELP macro some new commands came in still
> that were not making use if it. Switch these cases over and in a few
> places add missing newlines as well.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


