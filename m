Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8113EC3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 21:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A1988761;
	Thu, 11 Jul 2024 23:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XCP2WDre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E91C88680; Thu, 11 Jul 2024 23:28:00 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F6FD885EC
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 23:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-25e3d8d9f70so768903fac.2
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720733277; x=1721338077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RdKQPut5ZAEK2WRmR+JWt6JlEI99avsfQuKnEw8qre0=;
 b=XCP2WDreznMeX+dayjfZHmzr76q0tmL7iXg0s4mSjE+bMXpAJoqcQOnNYyu2lxQJ4+
 D4MlNBcpKJOzGgQtMvF1627174S7NJOHOt+7vQ4tFxST1Mlk+MmMQlT9eYhTe3EEP3vB
 +qFfdpLqAKCv2QCE1zmzcBACVeB+cwVosks9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733277; x=1721338077;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdKQPut5ZAEK2WRmR+JWt6JlEI99avsfQuKnEw8qre0=;
 b=R9CC8yGhQG9ldLhBi1pIVR2cXAMoZt7YY7nfPYBhIzHVumVdeYehH54mjQ4BkPiuXr
 SSmyzHyPd0nRptatIJS+FUOaHlUaFGbqxTmTQn6dsR0YpsB09YBYoRmjbet0nLhrJmMm
 nMqZ0uM60KjKrPQkAIAYFkW2yk7hP5Y6/730LxILAHnoCLyGh6COW0fKODeTtzaZhD/s
 81Zruy0zdZjlYMRexmqCzSaz4FaFMcvxSk4jQfzT1RnmteGGrMme5gF/a0F4IMAXMVY8
 ScH1TjE0woOUIV+obAafVE4u2OHWARy4W+DCFy5EEUVgcc1MQ4+dKyJ75gdliZDjR5AP
 uSyA==
X-Gm-Message-State: AOJu0YygNaN2eT+FnW/JwSPHgpBIORZypSHgugblrZOwIehhkLkAjhJF
 h8z2EVHG9zsokws4JKrDH/y7w0AlRBGRe/cB/fMjbmU0lLb/OfWt0dkdDcb0p8qpa4vb0vkSVb+
 UoHx3BQ==
X-Google-Smtp-Source: AGHT+IHwlIsK3lx2Pmrtlcmue+UEwJ7sW3v49uf0fuQEfgbmMmdlP1MDgeWmq2Ysm+nxeflJQm5XDw==
X-Received: by 2002:a05:6870:ac20:b0:250:831b:49b1 with SMTP id
 586e51a60fabf-25eaec5545fmr7790758fac.56.1720733277091; 
 Thu, 11 Jul 2024 14:27:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa29478bsm1824155fac.46.2024.07.11.14.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 14:27:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240703211909.1435390-1-trini@konsulko.com>
References: <20240703211909.1435390-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py/tests/test_fpga.py: Correct check for legacy
 image format support
Message-Id: <172073327661.2744109.9747241121342978885.b4-ty@konsulko.com>
Date: Thu, 11 Jul 2024 15:27:56 -0600
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

On Wed, 03 Jul 2024 15:19:09 -0600, Tom Rini wrote:

> The build option to support images of type 'IMAGE_FORMAT_LEGACY' is
> CONFIG_LEGACY_IMAGE_FORMAT so update the pytest to check for the correct
> option.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


