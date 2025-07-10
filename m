Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35F5C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C9883741;
	Fri, 11 Jul 2025 00:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="URKMFLoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4278362C; Fri, 11 Jul 2025 00:42:04 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE43836D3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2eacb421554so617680fac.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187318; x=1752792118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p1HBPi9uS8706zjQi90Bax03qq+W8sd2VxoCoKy6rOQ=;
 b=URKMFLoS+uvPP9j8Di8ke5Svjw9LnKRO2R6N1TZSmqA2+4C+cy03w8LEAYsbsJ+S8l
 HAjMdEzLkJttOFnhY6ZfwtduWqaf8q6PuHBrCPSvCDsivUXDLJOqJvVvAWc9wZlOAWUF
 LP+P4wayBYG/HAuXsZk6qFj9rPAqVpon5CJp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187318; x=1752792118;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1HBPi9uS8706zjQi90Bax03qq+W8sd2VxoCoKy6rOQ=;
 b=HPRvU+lVjukncKCBQ+POK8PIe786Zrm8HO+B3SPVaZfCi8CBpgeda/8pDfexMtIodC
 nwxUJpYrHQ//ofKmZP39LsohcGbhH/BmWtQ6A6yp4sTp+O3kBv21W39ZzBvSyfTNrgTd
 0oEMTnV6fPAOFyhjldBU++9RGRjbL7natWCRi3dz4vOmoO/uCosSre72P9RZAzngA2z9
 yie8bB72nR73FVp2+NRV3gZWv+BDHegcwEZZ5O+U9VconMrKW3tgev4TyPWQzvcLXL1I
 H/Vs1qZeBj6mV4TE6e3v5MOTmDJDbNzLnF5UnBugZ/8/U+fpEoE4l3W3hVcLJDFlQ6LT
 W0mQ==
X-Gm-Message-State: AOJu0Yw2vFFFWIW3t5n11DnhxDf0rGgIc50TnmLXWqk4FMFhWYhK0u0r
 rSKk76Sr/a1wk4oUpd8SJLbMsAiL4qPECleUdrAxksDNcGtqesfNVEjwv+J6zUKUuqMwK3ZeQAh
 4KWVJ6jQ=
X-Gm-Gg: ASbGncslq1+fxyc2u/j8gukRESI82FMuLL2nnICIfQshYilW9GG2tlF0PL/9dT3kMvX
 SCZMiux3bBiyBCJQPZgMBXiY1RP58a2EpDOvFoOz4ObYSXZh/2hBg3cYzsn05DowwPaMJJEmJDJ
 2tdlpLUea8lujUwbkJz9ewFVVfIgBJUGSe7dzoG+X4PSPl9fzQtFJnqAf88G32UM6JZyvYssnKE
 sWOo/u+3LKYYAxRNXAFJ2rZPI21yRjvtF6qBg1Z15HKAB+iX6QFgZ7twmgqs9F0HfcfqjOHFE/+
 G028bdERS2yy3+FctIVt40m827CTYCGbNsQFkP0tHpM+LS4L0SKBm1OdkJO/P8o6WI+YU2UX7Hi
 C0TYoy/ONkCAABEvqHs4FCLxqBLgLhEvyOXz/FQ6xpmfMHNwx2UCTAuU=
X-Google-Smtp-Source: AGHT+IEr/sl/rYg0Ax3FAB2Qyn5c+rsRHVrBcov9iTdiDl/2cAf1GacVcD9Ageh/tCTs4Rfq1YkF6Q==
X-Received: by 2002:a05:6870:c195:b0:2d5:230f:b34a with SMTP id
 586e51a60fabf-2ff26894d00mr735875fac.9.1752187318371; 
 Thu, 10 Jul 2025 15:41:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:41:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010402.18769-1-trini@konsulko.com>
References: <20250702010402.18769-1-trini@konsulko.com>
Subject: Re: [PATCH] gpio: Tighten some gpio driver dependencies
Message-Id: <175218731759.2073260.5412951867067913817.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:41:57 -0600
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

On Tue, 01 Jul 2025 19:04:02 -0600, Tom Rini wrote:

> A large number of gpio drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] gpio: Tighten some gpio driver dependencies
      commit: 8a31f18269e28b3201630e96e4d2821dbba0eb70
-- 
Tom


