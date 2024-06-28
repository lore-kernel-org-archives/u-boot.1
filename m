Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64D8C30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE73885A0;
	Fri, 28 Jun 2024 21:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AT1W0NdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36022885C4; Fri, 28 Jun 2024 21:49:33 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBEB3885C7
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3d5654d5f4fso597774b6e.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604169; x=1720208969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHhKmXJ0qfBvcUutV1GoQtGvq78c35eYmbCCjUsLD08=;
 b=AT1W0NdXamqUngPsG2td0B5Up4aRf2j2NI1YlOGfSXggN61fEGe2Dyk1iEIDGbI4gd
 V0T8BffJE288IVUfx5nmHxAvmlTfEOdOTA7saLj0FIgot5T+5KGgq1KUR0ihMMlEEGvw
 FXXUrmwcjwT9j6dAjCZAHEqXIcELKTVgMIFCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604169; x=1720208969;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHhKmXJ0qfBvcUutV1GoQtGvq78c35eYmbCCjUsLD08=;
 b=RjiFt6yByPEoMawrlxaTsuN9BCTnGoL/5t5cN4WbQDtcknigt7Jenq9YqgV9MQCw6T
 pW0++l6wJOFrxmnToPlalaswZGXXioOyn156DzQPK657G/SRh+sMCMwsX42oGBVGFxft
 M8ctg/JILd4AbCjUFqWbifh2Cz1YEdt59QDmDCVyGaMk+v6RE458N1sSFq4e7kbsutEL
 hcnYLSMbq9Au63N1dOOagV2Pg0hE4MqqwDunYJaXJ3SD1c0r6M8EiZm33hppPkuR7EYc
 a3do4vJEttcuWbseB42lw1FhGNEOsUshzfaTo4twiY9uNY5RkuCU0DSWWDIPVpl18ZMZ
 US0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5GLEDFGIEwmkAJFphHtYId9WPHfIXKGlKU1ScU9FiY2mDRYvBPBUg0gC41P1Wgmyf4vHK0wvZW4bRmjVGVOzHIWt8Ig==
X-Gm-Message-State: AOJu0YxRCzEMHdc2Keag8DkDVoJPf3HA82wQ1cAzdiO5b9YZGrjSv/WK
 ifsolmw0H/BIdju7LkQwrzWfUtpDuPReTXORugFZnBSpq/o2H59icH0R5MOf3IN9CPb/PnBJT9h
 8HuPHRA==
X-Google-Smtp-Source: AGHT+IE/mD8U4LtTbk/SdJdDmoTVODUbRZco6ciD9cCt1SBzW+PJoNnubIccpLbM0pOsCTx7f15GzQ==
X-Received: by 2002:a05:6808:17a2:b0:3d5:600b:eddb with SMTP id
 5614622812f47-3d5600bf467mr12301331b6e.20.1719604169512; 
 Fri, 28 Jun 2024 12:49:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240619-fdtgrep-some-ram-spl-remove-v1-1-7d4a3df7f280@cherry.de>
References: <20240619-fdtgrep-some-ram-spl-remove-v1-1-7d4a3df7f280@cherry.de>
Subject: Re: [PATCH] scripts/Makefile.lib: remove bootph-some-ram property
 from VPL/TPL/SPL
Message-Id: <171960416892.3614069.10971250161661134057.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:28 -0600
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

On Wed, 19 Jun 2024 13:33:28 +0200, Quentin Schulz wrote:

> The property isn't useful in VPL/SPL/TPL as it is only for U-Boot proper
> pre-reloc, which has its own DTB.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


