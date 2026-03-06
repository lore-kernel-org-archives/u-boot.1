Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7816BFCB61E
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 16:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B92838FA;
	Fri,  6 Mar 2026 17:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jAviu7e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C97839A8; Fri,  6 Mar 2026 17:17:20 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844B18382A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 17:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso11090343a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 08:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772813836; x=1773418636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QspLKATHx05YzsPhU6YHusOnI3ZpZ0Gkvg6mHCx6E4=;
 b=jAviu7e665oEFW39UbJyWv5PU84eirAShTRm3bmCldkphabFBW8qK8nd9TNGjItP6o
 0JkhYCk9ePl/bHy87gzbB06VFsC5whtUvK6pR0Jye1xEhYxC4N4QMzqGVAm7PFDBkBO+
 +1gpl26MlK1Kqd3cVFX239CqFy/YAhxKOxyj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813836; x=1773418636;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9QspLKATHx05YzsPhU6YHusOnI3ZpZ0Gkvg6mHCx6E4=;
 b=tGWQ4p9059DT0ESk7AJTTnroRHIvS/g55cjHaSAheGn3RfMqgTFDEXsW7gb+7lRnJx
 quZ/EZtURGW7oNbEYPC9BJnvxwxbXs2jawfHgynhyAcNwVxCIh/ZMCaF/ha5SqbhJxF5
 2hpSsm16iQwJQOJbg3WKnQkQB9tW4JXE/xDFaw1qSyqikmzOaX93hgHSpd+OVk3dIi/h
 agsSZgwVKgESBze+IQKuedJqAqpKVg4bNUAsW/EEPU8J73t7NUobIud3s3/wBS3YACeg
 +zLd/h9tbTrtqpH5DOr0yw0JFM0kVlhJ47UgIRxS4sopVJppCpzbhRX/NFRayjjfax/F
 QHvg==
X-Gm-Message-State: AOJu0YyzOq9agqJ4ETj1aNJg3gkNoWJoP5oJIWzVSHIFKew5Vsl1n72V
 IXCIBCkOTTLAeDzHa3Dxgx7t/ORbAGALPvJRJ/zZyJC2EPQLjyoPkUIsglFS11ZXhxI=
X-Gm-Gg: ATEYQzyjk7oykJYIPrS0ixRzXSdSoTdXdJKaOWvaemLkzLDn7pI77Xwlgd9mUI+csC1
 uDJJX9g3fgqfp3FJgORuCVa3Qu/KFBo5K9bv4j+qr5wkk/TpvbYLER//g4xroZ3gFHLkPD7UFRn
 9TUhqvTFB2M7xCgHbDHUud4gi3zyfR9OZb497oQQ4/Hl9Gsc0tNGb1aBg8vuj1G0AeEyWWjJVak
 fLvROjxnPHgDWe3UaYYgMWKRSflSuj8/eufYdJIfgNfcyzx3ZxYeKjZkZBGZw7iCzlzUt/+QXGP
 cVsM8nrngFYQ8xjI3OoFbtIIHx3QH3WBUFFLHpXRFkdEk8yqtE2N+ODHeaVGcS63m3BUTT55Aki
 JtV9tDsfz3buc+rCSs1oCfTjAQf61M3xcVgcte8dYXOYwOkDB+Mm3P9yPQ9sEhsGgfjpeizCvo/
 IsJ5mq6x9mOb3Ij/n0n/rH6ciugnSm+Z4qDZp7H+cCkB9HRzG94Oo7JUx0ToLeeuYu6JzEU++AD
 N+qBFJ6M893HKw1gWegdWeW7EI8gwKepVMWD0mwB4swYWKwfQ==
X-Received: by 2002:a05:6820:4513:b0:679:a484:fae0 with SMTP id
 006d021491bc7-67b9bca2000mr1173942eaf.28.1772813836213; 
 Fri, 06 Mar 2026 08:17:16 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e65f73e5sm1694902fac.9.2026.03.06.08.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:17:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>
In-Reply-To: <871pi0u59e.fsf@kernel.org>
References: <871pi0u59e.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20260303 into next
Message-Id: <177281383551.1132884.1544198296697113592.b4-ty@konsulko.com>
Date: Fri, 06 Mar 2026 10:17:15 -0600
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

On Tue, 03 Mar 2026 19:39:25 +0100, Mattijs Korpershoek wrote:

> Here is a PR for next
> 
> Fastboot:
> * mmc: make boot partition offset configurable for bootloader offsets
> * arch: imx8qxp: Override weak fb_mmc_get_boot_offset
> 
> CI:
> * https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/29417
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


