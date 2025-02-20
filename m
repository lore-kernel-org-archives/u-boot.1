Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F73DC021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A87280FB9;
	Thu, 20 Feb 2025 22:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UQbXTSTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4EA58001F; Thu, 20 Feb 2025 22:03:29 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695AD80F95
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-221206dbd7eso27898665ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740085406; x=1740690206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbTkUOeCLuvCjT2LgqEY+/JDSsOWqnt1j994UC8Q+K0=;
 b=UQbXTSTfhnaAfds+im43W6B3Btl5s/J0wq2lFGUAKC7E04/ICfW0ZLl6QS8T2EYN7B
 pSQv7opvV8u608fEFeuPSiYSa+3tP6oqfQu95wxK+l2bwcGeRxucYpdjAjy8pEDQWoOp
 jcJnxpi4C/SHmsn/wtf8Ec0GMbF9+tYJmXFjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085406; x=1740690206;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbTkUOeCLuvCjT2LgqEY+/JDSsOWqnt1j994UC8Q+K0=;
 b=nnbstb3Ilqh1EJOmo8NKVCQEb/JsTs6zjF1VDZOyH4erbzf5gSZCcqEcXn339OsT9h
 oICy5zbIxdPEIymNgoLCfnmCaBkrVxZdFxRhX5KAPdEAolebVE5/K2FFPEO8Cmeh8uAY
 8g034ZILvta+46xKq6zkvP48hTKMSTFZFxzBeFjXxlS8IJ6DWz4t6/zN+0jY669f8dB5
 JSoVPHNCHBFfxPJ+Olw+2ogzvIbnz7xCooK5oy1lZ6L493u1z1ultyd+1p9ZVKGQyDF/
 4iFJ4/oHeFJjWJFqXKmyUqCgPTmmB4bmW3shGcVKhKBOk8ESktDpuTuVtNp0SOR0OVL4
 nyUA==
X-Gm-Message-State: AOJu0YyT0YCVMZlMTHu7FQjW1XFWFeuZMKkiq3QapV6jULUvh2e84HoB
 hOptsOo79/37nqqKB1IZcO/m061VGMzJ2ncD93P99iVxnawsZntBY8kalX9JmT8=
X-Gm-Gg: ASbGncuD/DQxhCR9U60nus8zbNo7l0JfuDOzNZvUX82Eq0pVAcDgIijF7OaBtV5dGyD
 mQo5sQqNjioSGOaK+EC7ZF628UALM1DKzXNkcVq7fy0g1Fliv65ptWJArTxXU6lqgr/op/gL7HZ
 jEM1enT/14CU+y/0LA8Nr4xy1hgJEWxkfD4WBi30YsSouNNRRTpWk1X3YxeZT8ZUHBO1cpj8Mqy
 hPeXjtSWKFhsGvbvWg3vC9EXtiSIQ4vh8vQ2i1Lf5ia8iwDr9a+8nV7rntcbEznwY8J1mOvVLaO
 iCmWYYe4uY2t
X-Google-Smtp-Source: AGHT+IEFvISoFOxN+9t/DDxdnBUvSBPF8g/Tt4dKul6R2rIU4xaS3g9uTMP4QI4Xv4rGTO/oI+PhRw==
X-Received: by 2002:a17:903:2282:b0:21f:f29:a421 with SMTP id
 d9443c01a7336-2219ff30bb0mr9287215ad.10.1740085405961; 
 Thu, 20 Feb 2025 13:03:25 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5364676sm126190505ad.82.2025.02.20.13.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 13:03:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Maks Mishin <maks.mishinFZ@gmail.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <Vincent.Stehle@arm.com>
In-Reply-To: <7e6c0c78-22f5-4088-8a6b-a7d179da67f5@canonical.com>
References: <7e6c0c78-22f5-4088-8a6b-a7d179da67f5@canonical.com>
Subject: Re: Pull request efi-2025-04-rc3
Message-Id: <174008540467.2952449.6250775601135927674.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 15:03:24 -0600
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

On Thu, 20 Feb 2025 17:51:52 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 7a45cb4ffeff034304789954bb222ddd7d02104a:
> 
>    fs/erofs: fix an integer overflow in symlink resolution (2025-02-18
> 12:32:07 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-04-rc3
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


