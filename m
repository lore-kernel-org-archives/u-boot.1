Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735E3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE52087613;
	Tue, 31 Oct 2023 14:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HvreiJAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6D08760C; Tue, 31 Oct 2023 14:44:20 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DCB386F6F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40859c466efso43974405e9.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698759858; x=1699364658;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ucD9m4W2OaY8kUpn50QfRHu20CdLKMJZUNjUPahKgX0=;
 b=HvreiJAcaKoqth6eXqcXy7wbzmkj/h1moiqQ45Zh1KCtmYxV0/o1ePmIKNOYCkraJB
 vxCIyx4cQsX40IyL+eal+ZcYUKgdE86G4KiXq8d+QzU/BE7JpKYIbofYtnVg5j4jE0YQ
 sxSXYGof1rUghjGsJz9yh6/SnsNahnzMpvHFqP9BhltGHCTuY9YCiGSj4hZbAY3FyPe8
 Rx4KHhsQXRbrwlHobbSkwRbIUG/lm3JfJr2HI1RMF9Hslr5HgMPghno1lN3o0iewky6c
 RpVayXbovJlOAG+9McENmuAcjgeGBwApzAGsHJIjv0waECgbwckDsWEbJJiQEz4Pqw/M
 uhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698759858; x=1699364658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucD9m4W2OaY8kUpn50QfRHu20CdLKMJZUNjUPahKgX0=;
 b=kLh49Y74jwJRHSLZlIUicRx7ss2EcvNpF+NZ07+jRgXFKNwT0R2HItb+FmhAGTZy+7
 K7RMGqLUxeX2wXdHMXINftWd9faU30CFnC2lFb+3wORFUoXz7+jnHOzzP4DpPSGjGBNt
 9AD2sClI6hDDlpwnhxqFhwrM+aPV0wS/AvMwazpVql9S+Dz61O0X4RI4FqEjOc+XMvhd
 uzt0XN28hqY4YlSQvcLN6u+9EhITK6zOsJwUcl/bzf4Ls/m13VOModWQwcBdtlKxJkF1
 43+6WHWhYbSQXiiZCN7UJMzE2dPzuTZkEYXixlrVoJb9ZLVqZ759FvlSf3/GDqkt09y+
 FKUw==
X-Gm-Message-State: AOJu0YyonoZ2l909eIBLLkkf5JJVvEIpjWJ5VICgTb7T99UoouE6le95
 OhMtcBWwEC6UNW2dpLpvMHfnczpSKdkRoi4rDy8=
X-Google-Smtp-Source: AGHT+IEV4vaUADKEdMtTLnhf6DfLOWMpsXVJOs088ICC9FDK9Yo6YD5GLu/0p9JFIqYV6SJL9lnOLA==
X-Received: by 2002:a05:600c:1ca9:b0:403:9b7:a720 with SMTP id
 k41-20020a05600c1ca900b0040309b7a720mr11313714wms.1.1698759857584; 
 Tue, 31 Oct 2023 06:44:17 -0700 (PDT)
Received: from [192.168.2.51] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c358c00b004060f0a0fd5sm1839737wmq.13.2023.10.31.06.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:44:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Wojciech Nizinski <niziak@spox.org>
In-Reply-To: <20230925103714.4153612-1-niziak@spox.org>
References: <20230925103714.4153612-1-niziak@spox.org>
Subject: Re: [PATCH] fastboot: fix CRC32 chunk size checking
Message-Id: <169875985703.23715.12855995127246102526.b4-ty@baylibre.com>
Date: Tue, 31 Oct 2023 14:44:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4-dev-6aa5d
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

Hi,

On Mon, 25 Sep 2023 12:37:15 +0200, Wojciech Nizinski wrote:
> genimage create android-sparse file with CRC32 chunk at end. When
> U-Boot's fastboot receives this chunk it returns error message:
> `Fail Bogus chunk size for chunk type Dont Care`
> 
> According to reference implementation of Android's sparse file format:
> 
> <https://android.googlesource.com/platform/system/core/+/refs/heads/main/
> libsparse/output_file.cpp#513>
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] fastboot: fix CRC32 chunk size checking
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/355aab94d1f675ec1118906e1f88dfdf6a3582eb

-- 
Mattijs
