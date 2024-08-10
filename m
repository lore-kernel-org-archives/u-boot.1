Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D029C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 18:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9D48870B;
	Sat, 10 Aug 2024 20:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hEJa2bF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3142588755; Sat, 10 Aug 2024 20:25:44 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141AF88709
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 20:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-709345dd01dso1883554a34.0
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723314340; x=1723919140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnyea/X+jK64pXckNi+hVyyOIjZlAYuX/XtWJWSGrzo=;
 b=hEJa2bF6zHRu580E3HEoiQf1r1YTn3iHrErVQn98Jjotlt8op4/SMEJz4gT9YDtheb
 x4geel7cekWP0mb8eSwn2OdA3WqzVmEmZI3de/udwC4WuaUb3B+t5LqerEOA9DE4I5DB
 K6g6WHZnMXmtaBXj0MI/JsCV6kdDhNr3NIqFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723314340; x=1723919140;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnyea/X+jK64pXckNi+hVyyOIjZlAYuX/XtWJWSGrzo=;
 b=whaxst0dod4s2q+PM76ZaTe5CH1A91ubhqGbfbdSIRIoqf0XPP35Mrdlyxt52OKIxN
 H4IG+w1kxLEOnzGsUFjqSLmr1+IbL8hjPd+IgZi8JoefAdOPBhT/o16hGg+qGSYcHUZr
 v7OK0I83ixziRC0jvQ0WTrDSsuUF+TNZGdN3IqhhBcTYRgMeztPBObHCaG3fTrcrqPpC
 e+01v42mRDbf9RLgHvVZFkbzyiB2pUMlJWZFPY7B3NBkGnIPH5tMpXkEppJmVntgjnV1
 cMp3J1+bono3qr1ki0/1T6f1nhb+mxeszwAUxO1nuKAYPRzukiEYxfAwtPVsIQf7VM6w
 jDaQ==
X-Gm-Message-State: AOJu0YwhJfZYG6T66vnFd9KSpWULZbsN6v2WllWEX69deeUqi+N6uV0Q
 EsVS1J7K3B8gKXafiIPcyA6wl61jSV0pWEAO0Ssbh8+TutlDw2W5UP9Eeqe/Br6FjM8pk9gu31B
 Fxz8=
X-Google-Smtp-Source: AGHT+IF8QEbrLtf1BvQ9Tub60g0oWWSWRaoGnzR1/YzPmaw7J2pX8NhrZ+8cVfyxiM7CaZJZTqEebQ==
X-Received: by 2002:a05:6830:369a:b0:703:6dba:afc7 with SMTP id
 46e09a7af769-70b50ae0a67mr4055075a34.8.1723314340657; 
 Sat, 10 Aug 2024 11:25:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b88ff2dsm663268a34.67.2024.08.10.11.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 11:25:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
Subject: Re: [PATCH v4 00/21] Universal Payload initial series
Message-Id: <172331433904.2030825.13281690460193478199.b4-ty@konsulko.com>
Date: Sat, 10 Aug 2024 12:25:39 -0600
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

On Wed, 07 Aug 2024 16:47:18 -0600, Simon Glass wrote:

> Universal Payload (UPL) is an Industry Standard for firmware
> components[1]. UPL is designed to improve interoperability within the
> firmware industry, allowing mixing and matching of projects with less
> friction and fewer project-specific implementations. UPL is
> cross-platform, supporting ARM, x86 and RISC-V initially.
> 
> This series provides some initial support for this, targeting 0.9.1 and
> sandbox only.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


