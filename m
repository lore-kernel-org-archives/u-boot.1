Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E492C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 19:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A2B80E9A;
	Thu, 26 Jun 2025 21:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B9UnJAqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3041682E17; Thu, 26 Jun 2025 21:32:47 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0341F80C83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 21:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso976577fac.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750966361; x=1751571161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z/MbLPxNqAQcNynrtMBc1cWlWOgyN1/RIFmXfOUCcqo=;
 b=B9UnJAqoEEY5T6wI82ooRIQ/a8YUpbIszJzsZ8qgcButPYpY9FYTTZsdmD9dD17C5c
 NTFqIKDMSJKtBfQhuPS6km76nfR8RzICuNVGJvnex8Idp3Yxh40peVtD1Zcs8MERwrhF
 XHirHcJPz8IvoTnNnleAhRwqIIm/wJ37xiZTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750966361; x=1751571161;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/MbLPxNqAQcNynrtMBc1cWlWOgyN1/RIFmXfOUCcqo=;
 b=hofr+/VLVm5bdwFA5ezp2ISdB5TJj+xZyjOMH91XpcUwKLn+Q78CTZvENcWKXcY+ya
 gVDkoGGQM4vIBp2gy5DcPTljmQdZ3VqgOsrMhewcj6b8Ng5CLwjxE2GlC5ZxOqmOtkwo
 mfIolreoF92JmBhqKuWwzur7pbJsKZTGQcuXk0r0A8+sv0Gu276vjs9pSM7vcgKgcxwO
 iaR3nGAQZvRD66NDDH1eRzAeXBBEWgylAhEV/E0lrqjKjJ8jKrE4bmADVFXu2NU/bwf9
 AmJYh1WL3A5FCEBBy9+HdYDFsLbOOFxb3nqMVSa56/29JUxQL44n/6UoOFe1Ei374x28
 csSg==
X-Gm-Message-State: AOJu0YypVtURgwPp3fZgE0fsudF1B7/sQGyY1z0vCmHEaGFOIGtW2LLa
 g7/5kRIAsJPtoY47h69uyVCPnANlXMZxQFplQqadMxJdqzsx0KTOTdOcO+Q+XbK1FdoRVcLhskT
 6UyEm5m8=
X-Gm-Gg: ASbGncuSSvIszN3/50x+o5TyCslDDnvthvEGFO+z4kRXuM4y6hkh48eOIjQ31bMZErT
 hPv7LDMaapJntIUi2vVfWazM+Uox7b8dnh4hDonrD5B/3r8ByqsUq3JS/IyCAjJhRfJpPoDhDpP
 NlGCkV5R1P40sif55RYlHvtmkTOSjXj8WSDgMIfgnwWASvxuzxGTz35/h2jJH4paTgUQPDicBoD
 Nkk2Qt0yafPdjFhO2NLx1Av7fBT2SZn73sErGc1n48p1G7cuRFGvpPRz7jMOwb+evIHT4DECKA8
 PYnFSyyR7B8CMmQlGfg7QNa7iW9iX4uKUVaK2rG6cRSjG3YlAA7E79GnoUQJVBp4ugUz69PNcbb
 kKSpbIk42u0r8o1vrSqaRqw==
X-Google-Smtp-Source: AGHT+IF9X3k3XQ0LPZmcTlLN2myYAtK70PTOzI15cDnPd19KyEiIm5tV8y85pC29X7hmNiB57qAzaA==
X-Received: by 2002:a05:6871:e7c6:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2efed86efafmr177025fac.30.1750966360645; 
 Thu, 26 Jun 2025 12:32:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eab4e3sm511958fac.4.2025.06.26.12.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 12:32:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marius Dinu <m95d+git@psihoexpert.ro>
In-Reply-To: <20250611130211.24352-2-m95d+git@psihoexpert.ro>
References: <20250611130211.24352-2-m95d+git@psihoexpert.ro>
Subject: Re: [PATCH] cmd: add "config" command dependency on gzip
Message-Id: <175096635996.1890320.4420039022149869265.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 13:32:39 -0600
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

On Wed, 11 Jun 2025 13:02:12 +0000, Marius Dinu wrote:

> gunzip is used in cmd/config.c
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: add "config" command dependency on gzip
      commit: 661bafa182eae5cc666a0233d17e4d88aec679f8
-- 
Tom


