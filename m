Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE20CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27293846EC;
	Tue, 19 May 2026 15:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jm763thF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAD3846F9; Tue, 19 May 2026 15:35:15 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C585B846EC
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de44ed7a11so3808140a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197712; x=1779802512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZZZnbrUU99uj4wsJKA9qNCA0rXOwuNGcuYSe7jq5HXc=;
 b=jm763thF4B6mrdOwaciYvdlINPX+Ava//o7QaURKlGaWchs4XVPzoB7+aRK+TZZUd2
 4j5xc5SDL53VOUG8lr21TCaUfscmhlXhl9CgrIACsF61tWorA9ARaGIelSE2fQxip5IQ
 URdn0/U+FW/p89szF/SsRg8BNT62+/ASO2KXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197712; x=1779802512;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZZZnbrUU99uj4wsJKA9qNCA0rXOwuNGcuYSe7jq5HXc=;
 b=bVhO6elgkAAWwV6Wkn4MPFzYlEPvmWTJd6WgkQCpYhPgK8Q3A6J15tV89ytj0UaFtA
 UDrVhxIWv7I0mqeCgM5jxmY5kFDqCTmiM34HQQkfcUndjDTp9+moRDSId8a5x3HSqby6
 qm2GKkj7XYdGB4DoW5nlsyL4WZyXrMKrYekpeex3R4roJast+jeMgywOrQBMGd5BP5JR
 J0avi5+IBmI988EIs5c2MNKaO8jdja+kg/C1N56jM0igtFdSYFRnIZ/cNRMDOygyFyFW
 YZHpqlXHSoIjSg2fJO/R2SSEUW5LtX7x1Nws22DDBCeF6RrfVF22e5wOMkyr2tOeLhZE
 JsNQ==
X-Gm-Message-State: AOJu0YymV6ohuIZX37hqcj+BU6e8rm4xHLofZjujjqsIoXjVarAGLK6K
 JcMWAv7ZFzUeXznO8SHOo/jQWvv0Si8L71rr0+d+B5RO21880hqnqfI+p+sxmOClT6jlPeZAzKH
 K0PHKzfo0/lnv
X-Gm-Gg: Acq92OHxEeO6SQcDCKPxQOaIgP0Bk/kXjXAI1n43suFYhyg+1atbefN3s4ocp8r5xKM
 oL66C/jQ7FmnvtyrL2zNPOupecFPTk/r29PiLmTqsZ52e9mbMqEcJvFozSohm7pMMn+QWuScB8R
 ZPquhsNNOw8vvbUt9ScOGVtv974opHqmqpb17Vrx04h/SfaRZ4lpiewV5VB6Fj+rh0XO8O8awAA
 JgIe5BS5iKHB0TxJXEKDP/rXbyyM7xwTyaf4l9yahHEyX+I8m1uJX+iLQ20br3vqzz6aE/ic2s7
 N8/KfjPbxJRf2O2J71O7ZeOlyYXjj0ZyXF8LgDbGtuVjUiQvLFUweNb5sFjoWAlECLx+yRTJVe+
 ywev7jolweA/vffpuZYUqMuA/unZ+ePkQB5NiC43ta5+NfxkUexT+SXYCudgw2ayJEt/iAWOk3w
 L5CS4jJL35FYvCrynm4d8l+o23C9fAkBCBQlMOekILYefj8P4zLY3GWYJ1ZZvCyLVHu4Whocuch
 dz1iPfCSWhYGGAn8J0MV9H+QyROuS/gdbn5GeLpG3da9n2r2Z2z3gleymnT
X-Received: by 2002:a05:6830:6616:b0:7dc:dd58:50b1 with SMTP id
 46e09a7af769-7e4fa07ca00mr14222649a34.25.1779197712527; 
 Tue, 19 May 2026 06:35:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171621.56812-1-marek.vasut+renesas@mailbox.org>
References: <20260510171621.56812-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] spi: apple: Staticize and constify driver ops
Message-Id: <177919771194.672258.593178791486777883.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:11 -0600
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

On Sun, 10 May 2026 19:16:17 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[1/1] spi: apple: Staticize and constify driver ops
      commit: 05f76ca898b4fa98b9f875013447a3533d627ca3
-- 
Tom


