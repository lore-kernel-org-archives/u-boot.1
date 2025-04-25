Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F181C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A8082114;
	Fri, 25 Apr 2025 15:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q4xHpz2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A7DF81F4D; Fri, 25 Apr 2025 15:42:50 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C8882103
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3f7f7b70aebso1485108b6e.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745588567; x=1746193367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymLapFPtEY5hkxOb0Udf9fSIF1c9wfzYVYzJ9kfU+G4=;
 b=Q4xHpz2tKu33V36iDKhNTKRtlaXQLUWnpiZbPTtwGWsuZAsM7VMJFLdWDfDDtIjEXg
 jrqTicx9fi0oeCtaK+ypFd12Ca3jms/YO30p1uBSk3Gz92vLwUuFNa7pGvJcsjdB3Mv6
 x6AC65uR0YrJFlnxHzS7ck1J0AzFyrDx4qjhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745588567; x=1746193367;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymLapFPtEY5hkxOb0Udf9fSIF1c9wfzYVYzJ9kfU+G4=;
 b=xOq5cDGIU4gaFr8C3x6zdoxMlitZCwOD1ZAvrA6XreikhBKmrPPhrVtglZEWpVfKu9
 FKwfcNn6QyMZypVgyPcgI7F+TEqYEEEuPzj2vgqvqpCNuuIzWXqA2cwi1fHSKfp9wPt8
 d4KALq3c/Q4QfWn71BAWYWuWXvxJXXHo8NlmWkMj/Uz3FYCqMqEgqdEdYcT1DPu61cJ0
 3an6rYnJXvCesreDMmO4ADHlUWcmvgkTSEOc3qgbUg9CBBULl83xkOYnuIO403266s5p
 Kenr66TGsRzynU6/XKQ3DEq0w/kw9trRw5cSdAJJHVp6+DjXbP/GCymMXEawA8KRNcXc
 a9Aw==
X-Gm-Message-State: AOJu0Yy1c27zeTL8V/isOi/rMvIv2rPr1Rnhbf7PZLiGnupDf97Fln5o
 lYRCD3BkcWA0LLpPCp/oSYd5jmDM+ovBmvWQQgjr31kyj4TizeA8DNPZnaDVaEc=
X-Gm-Gg: ASbGncvPNqGF9hvWhKbMbOnMdmxPMVBTVoTyw79khQkT2wOzhnWU5A0wXo4LN2RfEXQ
 fOQPVot+eff672z1QSb098d4AnTdTjFHLH+rdctAYOCr/OPvMAcmg//8wzOiKrpzF9BB/UQVTV0
 979sBlZTyXyOSDI7XxrmOOwZKgNr1xpdPP4n3hOf53iD0tzV3zV/RKpb67p1AAjtL6WknVx43VG
 Px/ULtkTlS2oFZaZXq2oaaHLFaY/wSioT+LAFc4tE61Jc9brvSAamd4tSgX1GDchsKRp7cCKCGw
 oKELTh5lNw6ocRm/mCp6rg2rrdiVYQckxQEIx6+3SGL5H9k90Rg2voQXDX+CV9Dgn97TI0+POFV
 z
X-Google-Smtp-Source: AGHT+IGkn2F8Y8YXtETC9rWg9onEbUHzh5HKOUuRkuzJ+NutHDqvhYIpRk7PthD+AFcyrEM/PwEwPw==
X-Received: by 2002:a05:6808:2f16:b0:3f8:3489:d93d with SMTP id
 5614622812f47-401f28ca5fdmr1359441b6e.25.1745588567263; 
 Fri, 25 Apr 2025 06:42:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f1a3267sm680272a34.22.2025.04.25.06.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 06:42:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
References: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
Subject: Re: [PATCH v2] tools/make_pip: Use venv when invoking pip
Message-Id: <174558856663.695028.17601016454376414717.b4-ty@konsulko.com>
Date: Fri, 25 Apr 2025 07:42:46 -0600
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

On Wed, 16 Apr 2025 14:36:28 +0200, Mattijs Korpershoek wrote:

> Recent Ubuntu versions (24.04+) disallow pip by default when
> installing packages. The recommended approach is to use a virtual
> environment (venv) instead.
> Because of this, "make pip" is failing on such versions.
> 
> To prepare CI container migration to Ubuntu 24.04, use a venv in the
> make_pip script.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools/make_pip: Use venv when invoking pip
      commit: 9d3f1ebaf8751f0287b5d02158cc706435f8fb19
-- 
Tom


