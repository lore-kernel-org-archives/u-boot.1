Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12C9C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 20:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 237CD83CEA;
	Thu, 10 Apr 2025 22:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UzASDW/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE7F83AE9; Thu, 10 Apr 2025 22:14:21 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C9B83A8E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 22:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7272f9b4132so907011a34.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744316058; x=1744920858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9TpbjBnnnmE5DI7QxCJ02CRb9s+uhRrzuMZ81gppuA=;
 b=UzASDW/eW3IMquQmpgap4sbPUzmD5f/i6mVFLjbExLciL1KMf7SvLuef4YJqx8ipHT
 V0jipHPAF8Q9VxQrszoUxRRc7eHo+VQgQkM6veHr+4DACKVO1yi+R4omAg8wxS4537YU
 Bl2hZcnRmQhgRYS48TfUHj5bn6RKWW28KIGfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744316058; x=1744920858;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9TpbjBnnnmE5DI7QxCJ02CRb9s+uhRrzuMZ81gppuA=;
 b=dBFx4h8aXbfffiw0JHXqstS1DIuDqll30yc0GIAjxdbxDZ0hNWYMF4iqI9JE4ShFdr
 Pwh0VzywUPx83QAF6rwF4RrgoXtGsrveTrOb1D1RzrPyXUNCjz+IgA50EtjNEMlJDyyW
 EC1xZeT+fSQXvDfHSgSuPb6WGXSewmJXHnjXZsG+9ohgxbLYyFcOLI8oWGHgoT2klTZz
 +51pgv53U1qq/653FwjfE47MktRdt8pGNUWkEpAcyzTQ/4H4mXuLOo2+k2FF2U/V6G34
 m6tuGCgqrh8cD/RHNFjU1CwyCrVZesiFoGtt4WMld77kMTpFQSDhAzbU5euqE3/iL4W5
 CESQ==
X-Gm-Message-State: AOJu0YwAEH6xiiqHfjqYYP3fPcfppUhjT0sw8a4NoqjKfR3tqc9kCa5P
 n6mfNfSlWdE+HdqbRk0I5gwlVG+MNP/Y34mGZs87UPW+eQc1YnA2FjIeaGNd+x8GEO7uNdkHC7X
 gE2o=
X-Gm-Gg: ASbGncv2ck1rvPxzGXwCgPm3rlS02dbTY7ym3P77vCRpbYP+EjdGgVdiR9GaSJoB4Xo
 Um1Upf3yEhjysA2naaruZgrhIIQFKkv6LTBM4PA332gW5eDk/nQ1L6iigusa3sm5QQmJi+moh5F
 N2IhA0uLtVEp6kYI70LIvTV2T1mRIyT1RKEtp+RbJtdHLPEdb/N3hdbXozdXDLcAZ+FQ8Tjqmdc
 AuzCX4YqYFGAFwY8vfAb7zWGupdJmGhVYDtq4fnEbYdt6xBKXsjdI2ZProck61AkM/pt/i+F5Tt
 GfA6zue7ilDVZo/plrvwShy4JQkiPc60n9Ul9/EDHHF5W6tCEX6LtzMfQQ6vkNaRG8nOKqzSo2L
 c
X-Google-Smtp-Source: AGHT+IF2ERvv6xpSa45SmEbCESTDH0C6DXEk7n7eTuqbIIVZ0Bzzmm1Szhoh3v5cdVwSJeKWF/aAbw==
X-Received: by 2002:a05:6830:3896:b0:72b:940a:a7c9 with SMTP id
 46e09a7af769-72e863c333cmr220768a34.27.1744316058596; 
 Thu, 10 Apr 2025 13:14:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8fcaasm685741a34.38.2025.04.10.13.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 13:14:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Brian Norris <computersforpeace@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250328130225.2607974-1-sjg@chromium.org>
References: <20250328130225.2607974-1-sjg@chromium.org>
Subject: Re: [PATCH] patman: Show base commit on each patch when no cover
 letter
Message-Id: <174431605763.2981499.4572154335304263894.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 14:14:17 -0600
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

On Fri, 28 Mar 2025 07:02:20 -0600, Simon Glass wrote:

> If a series is sent without a cover letter, there is no indication of
> the base commit. Add support for this, since single patches of small
> series may not always have a cover letter.
> 
> 

Applied to u-boot/master, thanks!

[1/1] patman: Show base commit on each patch when no cover letter
      commit: 60218f07f357aeae34b524f0cdf2e512bda44645
-- 
Tom


