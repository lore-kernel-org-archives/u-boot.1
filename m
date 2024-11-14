Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61FAD6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6458965D;
	Thu, 14 Nov 2024 19:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QZUu/bF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3158188D90; Thu, 14 Nov 2024 19:14:01 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D60889655
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cf7567f369so1245366a12.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608039; x=1732212839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf4cukfEOWmw73N+gLPIPKd+CU1xKRPtHK0DCTHIswg=;
 b=QZUu/bF8/56QRCiApVVOeydh2yk2R/dMitUQnOT9KjbQSYPBaBedUYYilcGstHuod4
 dAXGoqqp/WzGKvVI5rzPKVnaQtFwGbv6AuTYOsQPLzRjYIdZ+92Xv+p8gxiOIvZ6vmS5
 VcMR55hgetDwOL9RhmCk9g/J5BwFH413QijFiGdx+LYitukf3y17dcAj6PON09EOkzuL
 1CmEgRe/QwXAgZLFS6eUY1uh3I9GSNW45mJki+o7kxnL/ZQEAJXeCTtHRjMfUXzcH9B8
 xzSnZEj6R2ZGFun/KR2qu2PaqVkPkWxBjWIkZzugxmoOsUGyKemfjVsOhX8+RuTJC7l0
 lHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608039; x=1732212839;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sf4cukfEOWmw73N+gLPIPKd+CU1xKRPtHK0DCTHIswg=;
 b=b21NUK03LEnSgS1VQwLD0I20aHoggAqsLbfrNg0O1IMhA5yXuw+YRUCsOVQ4qSIMJa
 4J1zruLwMgcyxw2m2cI27n096V2Xa0AcCXtyIFdIw4lp34ye7lC6UoW4+iN/bfolfc43
 qD5oi6WygN8f5pMNQauL/OH62RpB1o/s/pTfarVIXf0FIqL4dRwfyencTC3PiVF1JA7D
 WugqSCkPYwZ4nunNY2XrGIprEdYQX0ahzJ/Etxxv4no1h5DFyd2cXYwCPl698S3S0ruz
 LXWURmTZBhcSZqXaaM0/IjOAHNI5jV/1BX5ZPULNn7jXRY3D+NbJlmSpx1Z+XyIWuTj6
 S8fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd5gdD9/0e6ic1ReyLVHQAwnoLZWr+u3nuhKpxqE5iBOMuiBTKXTxMg5BRCXUUTEEjRrkVs+w=@lists.denx.de
X-Gm-Message-State: AOJu0Yyglsq6imI1etEnicDAi1je9qiQ1fCUMkLx+CfSSxvnYzOH/s+Y
 JYYSsUalmBsENTbk2jr42K1MHPr3WOWnxAHb3SkaZQ8fypR8wCF+cegyEGQssCI=
X-Google-Smtp-Source: AGHT+IGP+t3HlUts/dB6rXmTee9dKrz2jFpoufpMNAdtiPS4zpJ7l7Mt2tqXi6EaTD8URf1i/2Xi8A==
X-Received: by 2002:a05:6402:2709:b0:5cf:728c:69dc with SMTP id
 4fb4d7f45d1cf-5cf728c6c90mr4175468a12.10.1731608038592; 
 Thu, 14 Nov 2024 10:13:58 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79c0ad25sm785479a12.61.2024.11.14.10.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:57 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20241113050431.1848951-1-caleb.connolly@linaro.org>
References: <20241113050431.1848951-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: configure logging
Message-Id: <173160803620.3344980.3117333989715830299.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 13 Nov 2024 06:04:17 +0100, Caleb Connolly wrote:
> Set LOG_CATEGORY and pr_fmt. Also fix the time.h include.
> 
> 

Applied, thanks!

[1/1] mach-snapdragon: configure logging
      commit: f6e628afef415cac48c907533d130ef61fa1fe4a

Best regards,
-- 
// Caleb (they/them)


