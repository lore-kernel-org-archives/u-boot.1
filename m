Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF80C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1159C8359F;
	Tue, 22 Jul 2025 21:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jRk38Hfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5615F8331F; Tue, 22 Jul 2025 21:46:16 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1F683403
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73e58d50fe2so3277715a34.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753213573; x=1753818373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7gGWGkiSC9+x6VTtai5mGpyWOx2eBexD9fFkcQw3WU=;
 b=jRk38HfrUMDhQsnKSdqimWoVdC6ocemnQoERdIr9LA0QFiKADUsN9gINVDmDnfoAe1
 9zniuaPZ1h9BQVgJ5gwp7c9z4IpBT/+MGcPWK4y8eIfMz0OxvYLBBGLaQu/R7bDemka2
 IfQWSYQUp3c4q9i3kSxkAdB2wlgBROl81/FGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753213573; x=1753818373;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7gGWGkiSC9+x6VTtai5mGpyWOx2eBexD9fFkcQw3WU=;
 b=GSIq4QNWZ7k692DDPy4x6ziZiZe8iRTShvCyt9c7sPhaDysMjfRLiwS736Qivw4as/
 4ebx+g+0OkJkxByxfyUmlSNnxBkvy/PMj5e20jFgX5HrhIe6DAsVFd4m+AGa8IopO81n
 cZQu+yCXHNYXbJARrtvceTE7NCv3vOE/5v/bG3IJpXRzq7pDn+d5TQgjzLAhgt0CnYzQ
 AHcASArbsc2CY/n3nOEZF9qrHTZgvCrAuo+0kq5S/MqLuMCEwotr6ntIJr7nFkcCfc/5
 wadLDUNQraGrIlyRODstKPs0D0XufqYKkxb0f3i0/gtRR97S2DEyn9ijXgIAWU84Lda2
 lVHw==
X-Gm-Message-State: AOJu0YzK+r5MhUmSjX5RSEQkiSgbiCzzuaTKoJ9KZWFu+8RRjCVpy2XG
 Z8lcwrCKgUOO+Zlx98R3tzYX1AgFQC3/JMZj+6jYxDT03NdzEJ9DO9LGnOmFL6f7R4fWrBcSiGw
 dt7yX
X-Gm-Gg: ASbGncv1+leCVmJcSWE6iSxha6N8F6RV7VsPnU4mLIdxL59TvdLPnrni+JipezWMO00
 Df0DLEtlUnU2WJYbpjFzZWDA8PBDKKfRrsS2XTmbcqYVO70O7NQwN3K4JJBiecnxIT0psTKyag0
 VEpfG6jbIzz00nyB7JVCH+q+4kxzdwKBuJoDOJpbbm+/uQltcwH5PtNMCF5k/wbluLtHQKUegLm
 I4g9WmfsHKSdpA8ISo8rzNwG57/hqe+wcv5GGxvPHAjK8USu6BQS9fzkHWLyhZ500XSL3zM8h4b
 yah9qJJ5989q6Rpg/SiuEzWUO8tELkDYiYLki5PGu9Z59lrfaNe9TDBrsVaeusXAJPV7wRyk/6h
 OlKogpEF5FASvjixGnAZf/W9XRW+3UXWVpS8SkYplwFOGT7oBZufvOL8=
X-Google-Smtp-Source: AGHT+IEJ4O6LZflPDW7dnBjL/Pbmhr+1/RnOhBtmFt+VBbUWmnmUOjKp/JMSEwONzizFZw6wzLA1Uw==
X-Received: by 2002:a05:6830:3509:b0:72a:1626:21e9 with SMTP id
 46e09a7af769-7408053eeb4mr360668a34.10.1753213572942; 
 Tue, 22 Jul 2025 12:46:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0c3fbsm3749811a34.30.2025.07.22.12.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:46:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250717-fb_command-v1-1-97695943666b@linaro.org>
References: <20250717-fb_command-v1-1-97695943666b@linaro.org>
Subject: Re: [PATCH] fastboot: Fix off by 1 error
Message-Id: <175321357216.77222.2015120309178322147.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 13:46:12 -0600
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

On Thu, 17 Jul 2025 09:43:29 +0100, Andrew Goodbody wrote:

> strlen only reports length of string not including terminating 0 byte
> but this has to be included in length of receiving buffer on copy so
> adjust length check to be correct.
> 
> This issue found by Smatch.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fastboot: Fix off by 1 error
      commit: 23d2c182d4be9f993a4e4d8f4fc6293e4d5a9ff8
-- 
Tom


