Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21570C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 01:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D54886A7;
	Fri, 19 Apr 2024 03:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lH4CwVNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA52388692; Fri, 19 Apr 2024 03:57:58 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D837E8866E
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 03:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-69b514d3cf4so12455116d6.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713491876; x=1714096676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKBwm6auo4sUKeeS1feIz6BdL0xV84J/maCIGWbpnts=;
 b=lH4CwVNrio/OwfxTD/GoeIH08sscJvEmLkG3KmQX1ngEVCFAmvhAc57DwibFoxXjee
 jOIEvA5aBYmuNMSJPneLpEj8hIyeIcAPv6uNIwxwskp8te28Jmjs5fyyFiZihkfpYIsD
 HTB/FNKw/I05kD9ytAWVHQUJqwkpXSLqr9CII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491876; x=1714096676;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKBwm6auo4sUKeeS1feIz6BdL0xV84J/maCIGWbpnts=;
 b=SwDl+StkWJ33DVQUOMWXGczty3rvKUHYft56FGexoCRstL6uH9X+jUlF3NEJ/h4YLU
 hErTZi1teVtYtM8x4xlcesyiD0SbgtxfvRx7mIjUOC0e0VUeRa2ZpMi+lmiQWRZnhXrs
 7hdwcnYfuspZ5812F7bSDaJXXrU62MbOu08/K10rB7fjtgPh8AQn28kl+Txr227No2Ja
 DMYkBeHsSkeBfsPUXR7XN5GfPqg6K5rtzLMtF5f9XBhsovfHnPueV5cAwvmPYYSWSi1P
 x4hPoUlmsYoU3hCjASAZ70FcIe+u1M7/ejAgW6DLBakuDMrv2rDox9VEQ/4n7LJxFAst
 k6jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGH3rnboUPN1a5HseW9+xoofUwPcccRdy8qdhi8PTrT97MAJ6+sQABEATIiqGo917K2SBUIezvhL3xUvBztPSflT64qw==
X-Gm-Message-State: AOJu0Yyqax4lLOyeVWR4fdpuoMDM0DebgN4Yb1acX2OBFI+9T4oic5je
 pFG6PCRlX6JdcMpRT8ZwTYUQyQ3Umtipy6GOzcmVj/8y5F5QoCJp8+zez/EUFlk=
X-Google-Smtp-Source: AGHT+IEFZs8zjLjTy6bHd6FifloGS+64upFhOYQx15zoFtCjQNakF05isqQ1kJ8c2yhLxeFN/3FmSA==
X-Received: by 2002:a0c:d84b:0:b0:698:f82b:a6e4 with SMTP id
 i11-20020a0cd84b000000b00698f82ba6e4mr750592qvj.40.1713491875830; 
 Thu, 18 Apr 2024 18:57:55 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 18:57:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Nandor Han <nandor.han@vaisala.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20240409184422.45023-1-heinrich.schuchardt@canonical.com>
References: <20240409184422.45023-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] reboot-mode: must depend on CONFIG_DM_RTC
Message-Id: <171349187481.1524174.14997790802619215741.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:57:54 -0600
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

On Tue, 09 Apr 2024 20:44:22 +0200, Heinrich Schuchardt wrote:

> Reading the boot mode from RTC memory requires a real time clock.
> Add the missing Kconfig dependency.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


