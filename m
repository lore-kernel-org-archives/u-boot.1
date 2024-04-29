Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F62C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA934889D7;
	Tue, 30 Apr 2024 01:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y8zOA1Sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BBB889A9; Tue, 30 Apr 2024 01:04:16 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B1E889A9
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-79100a90868so70497685a.2
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431853; x=1715036653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxSWE83bM22cnmMIsvaNGFSV/vvj8bErf65xVwOvqNE=;
 b=Y8zOA1Sf6afU3hcLqFy4eJ0cQTKo3f6I8HXxDXyMiT3hf8zCL8hGcqzGY5r9hHo8pN
 feWKLd6mofZ5qN/ODqJvB+a51Cu9EMJwhDEOKAKTvmW0FQQ3U01WaWTIo4nei9mpv6i+
 npYDZ+OGyvlU2BMiCL3DdSJ6WQAs+XS70SUPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431853; x=1715036653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxSWE83bM22cnmMIsvaNGFSV/vvj8bErf65xVwOvqNE=;
 b=PNOjYY4yFTEthiFJ3vgeiYnyzJ9Lec7caGnynVfWpXQXFjhFjR/1Stgx0yyh4jSfBM
 CDrpTOAbIlM6lMnYuZc6JHwUwbA+dGV0wqNPP2yME5BoXZ0ms0XJ5qeG/IvKw/pMebEG
 YBOFm3lTLUIY0DSi8f/hDdk2F70STz9cEEklLR3cMaK0K/D4nTscngiPNEqawYhnY6df
 izafHvHjqYEWWAWIO23+uY5XqKhwJamqW5XWxL5ehdQ216ieqWGu//sL7Jy4A4SVISJ1
 5QvxGBpMkm4TIaOYxmxmqQuQr5Zvo2d/fxOQhDknoAzkeTMOSYTqrEa/1NcifYZJdr6P
 F2Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAD4A/VFOjuHQfkkkGzjdIiqFB4dkj5RZ+4i0eqse/ZJKSaTH0aYv1zcCbepn9oCDroUcN7xco8/MuL8aiNxdfayxJPw==
X-Gm-Message-State: AOJu0YyCI1Sy27WRErBUic0GBQdQ3vuLkhfR3J4/zDS4gNpZQ0RYnlGW
 0FahquYf9pHbPYVWCzZhX5erz07U2WL40r7dpU7SGv4jEBuyHm09cnI/4PEoyxzfHojWkFMS6pV
 Ua0SkGA==
X-Google-Smtp-Source: AGHT+IHXSb0X/hVGWcuQUYFwT41vSvEEl4coAYCvGCI6nNXgshG43Olye5F0gHvNe8IBEm0i16QCrw==
X-Received: by 2002:a05:620a:468d:b0:790:ce54:ec46 with SMTP id
 bq13-20020a05620a468d00b00790ce54ec46mr10348087qkb.22.1714431853218; 
 Mon, 29 Apr 2024 16:04:13 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, u-boot@lists.denx.de, 
 Robert Marko <robert.marko@sartura.hr>
Cc: j.beck@linefinity.com
In-Reply-To: <20240423110557.80296-1-robert.marko@sartura.hr>
References: <20240423110557.80296-1-robert.marko@sartura.hr>
Subject: Re: [PATCH] .gitignore: add LTO generated file
Message-Id: <171443185227.1749944.17841947547964437814.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:12 -0600
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

On Tue, 23 Apr 2024 13:05:40 +0200, Robert Marko wrote:

> Currently, keep-syms-lto.c is being generated if LTO is enabled but unlike
> keep-syms-lto.o it is not being ignored, so lets add keep-syms-lto.* to
> .gitignore.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


