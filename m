Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD7AC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E4380FEB;
	Fri, 21 Feb 2025 18:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RbS0MZV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A668807C4; Fri, 21 Feb 2025 18:38:24 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EFD080FDD
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220bff984a0so48608475ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159499; x=1740764299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJ6R5joZsv9qRvCn2nEa7oua6XKKxnw1qKFNNHi85Pg=;
 b=RbS0MZV/DYeRTw9Wco1nR1cf94lCBbv59ijSZAwYDFBqZGWu4WmUh3EzBjXTAYJHbT
 JmrIR78bhlDFBDkgWV7Fp3bBtotewmIwAilBXU4xBQRYgx5v8xyGJ6sAtkSqr5y1vYUm
 Zu7DOy+47xjUmxrpuxD7WtiBb0f2bH09eyGlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159499; x=1740764299;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJ6R5joZsv9qRvCn2nEa7oua6XKKxnw1qKFNNHi85Pg=;
 b=w27RYr1v1gKRTRJGphsIbvkVlaLcYvlKi94mK3Y3DQZeVFW90t9M1ax/dyVQG/ucN7
 UsvepBBsGA1kymymDOp76GfkC+XwaVj4I6mhEHaLlNnkLG/SEoTLRSPSBmJJnOu2WYoH
 tDqY+dJuf3Fn9JGuzvmm4d7Ni12Ociw0rgzyulWOL2rR/RjMXaT5Sj82KJqLfkhli4P7
 ng5ptSEhobnpeZxH6nkiFIX29nN9GVIgJH2k7pM8d3Q5qAyxSKtvQtb1vv/taj3u4c/y
 rENSu14ljUZW0F/3vMulxbeal7V8PActhKXF8nwYIBfNUbzc4yicny25wW/AL+FLxcaf
 Zcnw==
X-Gm-Message-State: AOJu0YzbZI5ly4tajZpUrzAt6uE46bu6uz1uwQTQasEtbX6Tz0mOom8I
 n4xjNizU/CYrfgxE0cDYGHoFEHanF0/Nal5a0Nob5+rmIs252h4PDS8v9GDAQllPAxOzKlh2gxo
 9Km4=
X-Gm-Gg: ASbGncsnBeSRWXvDSx4zdtRiDgANp8Jx0QYjZnUUPmJLTMwZ1ojJb4xXbqiubo042J/
 n3QFc/IasgJw+DdokjhD2zmHCVKFUYjQOTcyqVqK97dkdJgPQ51V7XRO5rsgq92q/kYC3K37dFq
 R4UDsScqyh4vNW5uv/jQqDIwaSzOUsQXlSXLH+lVAXrj2B+VMNQdgnivotyIRy8aMr0vOzpmT55
 VSZ9khtM+SskegIL+hM8Js46Soy1QL9FPBAL009puBXKEUKMV72zRUB75GEQ0bVAh3fnk/BWIYk
 R4if6OArq3/7cBNfsRG8tgE=
X-Google-Smtp-Source: AGHT+IH8YBrVc3afXSlAX9tqubplZ1ldt4ErYddVBU3RoWf+8lWCRWwfvvvedvT55Gjy0WCWhrd79Q==
X-Received: by 2002:a05:6a21:618f:b0:1ee:d6ff:5abb with SMTP id
 adf61e73a8af0-1eef3c71f87mr6789500637.9.1740159499023; 
 Fri, 21 Feb 2025 09:38:19 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org
In-Reply-To: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
Subject: Re: [PATCH 0/6] Add preload_check_sign tool
Message-Id: <174015949809.3526942.13114735137909191703.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:18 -0600
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

On Wed, 12 Feb 2025 10:31:20 +0100, Paul HENRYS wrote:

> This serie of patches adds a new tool to authenticate files signed
> with a preload header.
> This tool is also used in the tests to actually verify the
> authenticity of the file signed with such a preload header.
> 
> Paul HENRYS (6):
>   rsa: Add rsa_verify_openssl() to use openssl for host builds
>   image: Add an inline declaration of unmap_sysmem()
>   boot: Add support of the pre-load signature for host tools
>   tools: Add preload_check_sign to authenticate images with a pre-load
>   configs: Enable the pre-load signature in tools-only_defconfig
>   binman: Authenticate the image when testing the preload signature
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


