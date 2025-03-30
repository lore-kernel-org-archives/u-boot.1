Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE22EC36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B95C81879;
	Sun, 30 Mar 2025 16:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e9cT8j1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFFA81879; Sun, 30 Mar 2025 16:16:46 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32C281879
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2c2bb447e5eso2124701fac.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743344202; x=1743949002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRsx220E39E7Vfgfhi1Bw3YhJepNrtYGqGKq3eCUk2M=;
 b=e9cT8j1m0cnD5A3fYYR8kHXm0JWP35TF2gc+qtKLRTSblr5Ki7Ll2qBn109kJsvgZQ
 lQsrDYuaKviRclQ3EHybfcRq6Yxw4ilKCFAojWhCSMa1TLAJ2ilVsrwTRFjL8n1JRGLz
 lr7rYza5E8SDPdefHb193WT3jQbO95hWvu2vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743344202; x=1743949002;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRsx220E39E7Vfgfhi1Bw3YhJepNrtYGqGKq3eCUk2M=;
 b=FvIb9nRV9sXCMuX1cpaN8v5bGBEQ5TUnRMwR5Llzit3uUcZk/QoYna1k0/wAdrmdvu
 ODRmpS1BNcROuLBiNI3BvehaYX3v60ISBajUT1H5wZsAPlNuxhNHFP6PDjdRy+ECHO44
 1+2oiLjrLso9FpU8Uh4ef3rPjdA9YjyawfbBwrupyoR6Hlm+V5Rogmx7JxKvQBnp7+kV
 jB/xsgcNc1ceM3FfuUpGh0bP54V4d1KteSSYHgjQbpomfzHwehu7bnp4s8b0xB5H8LxQ
 PZr7aib+YA6tX6mDR2YhVMDnbFBxDedHlvlMvnqdgy7LC7AUzZMMR57HTAxeax3/vvwo
 5ARA==
X-Gm-Message-State: AOJu0YydH2mx0ww5Rf9MfitiiIn50vsdYnwgWxGkf3cNUg2+vdkEdUqW
 Byq3jVWar1Etadl+r41rdjUgkRuTf4ZOKLgPKMzCLeNi0EV7S5i7BpCtJL3vvQk=
X-Gm-Gg: ASbGnctLnJun+FVVFfaWmJZ4jXzlc5iL6WkOh5gW2+LlpBLZt8Wmre/g3kOpeLWvGA1
 u4IF+d4jexbaxfjain5XwIdDbh5KTn3BcEplnP5nVejBABlCMtS5yxLXuvWObz1B9HM8qrFrl4k
 gBgchsciSHBf7FTpEryi/khso64fgXg8gTnLW+H0JhwnF1ivhLIS0ZhQr5pFvAfMuxoN+SenXKP
 NJ6bhPHe58xeEWDQZU0wsARClg535Iv1bA2mDt5aIhOyR94wIe4gQ7inFFiUDI6RIV4k/Sv0zny
 a4VKE3dKGOmWaQCHUU7Fh0uvFqACrxDg8gBHIdKN9Qbg2mtW5SqDKxIcIjdzLMei4T6wQVJs5GW
 U72Iw
X-Google-Smtp-Source: AGHT+IEuEJSe23i+QkIpPw5fVKwP3rJA+goNYGaBqHO/nw/z2c+aphLrj+Q/pmVJdcE3wwYaGZ3uwg==
X-Received: by 2002:a05:6871:4e95:b0:2c2:5369:f3b with SMTP id
 586e51a60fabf-2cbcf5152edmr3773842fac.14.1743344202432; 
 Sun, 30 Mar 2025 07:16:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5809260dsm1150216a34.14.2025.03.30.07.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:16:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250330090920.9021-1-clamor95@gmail.com>
References: <20250330090920.9021-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra fixes
Message-Id: <174334420118.1157922.14303871853192520307.b4-ty@konsulko.com>
Date: Sun, 30 Mar 2025 08:16:41 -0600
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

On Sun, 30 Mar 2025 12:09:19 +0300, Svyatoslav Ryhel wrote:

> The following changes since commit 02d95aaee01a2faf53bba8f1417b55cd02b6a743:
> 
>   Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-sunxi into next (2025-03-27 08:10:06 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git fixes
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


