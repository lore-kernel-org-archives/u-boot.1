Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476D4C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5A382F8A;
	Wed, 16 Apr 2025 16:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r+8IuT+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F4582F7D; Wed, 16 Apr 2025 16:11:06 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9905A82F46
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso4364211fac.2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812658; x=1745417458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vQ9h60Ia16JXFuWrKMW73sacaB7DvRb9XHtqVxFxdqA=;
 b=r+8IuT+8/JQ9gETx3tYHVhjaPjsGkFmIEElFFntqLCi2bHkJMPwwSheg/m6CF1IRIz
 F/5WrOd1UNjFBWu5ll45RWadZ36ysgMCGPhlip7yKBOKPn+feqARFY5gSAW2hgVh8i+b
 B3OSkiIPDFBmARwV5CgTonjlyEKf7rijYbOiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812658; x=1745417458;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQ9h60Ia16JXFuWrKMW73sacaB7DvRb9XHtqVxFxdqA=;
 b=qaKge5BpyhyTfP1C8Vn/RAZpPsABEP4jQc4bZs0gdZK368X2snzTZwOFmib83XDKWg
 LbVSIafeahC38avrcEcVnBj1nX93Bw/bUJzpyI8ItuuOR4HNgIND2HAIIOHGThSGa8P/
 wth2Hva3DY+t+NpGgN/RJuNr+XFsM2zUiLUQfiIjCviTmCvBzAEJW/Z5Bbg/UAN/xXnw
 FbshCOrUhcPuxopY4IqcYxCSLwK+JI8ESOiMYm6Kbb8UKXjJFxnvNGiLne0A+k0qrJMY
 Fv8ZFPeXaVBFZ2jB2t/1kd24BYtmqD/audtBsRPCXLJa6IUlryx++VOyr5q0x1BntaeN
 gGRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL7uzlok0udKhGCw3bXXAMMUpE/nCdYETIvIIOPkTRF0naU5pF+SxDoy9YlKc0yYo7t2OIdH4=@lists.denx.de
X-Gm-Message-State: AOJu0YzVyYJYoHMctxOGH76ixFHxPYxwX5EWvjzGMnJB96WNlJeI20AB
 YxHalx/Ina5j2n2qAw8x8F2/fQo9E0mGL1RczMD0FVs1YWRDEgRTLOYpfaT3BWVc5IkKDOswXvg
 O
X-Gm-Gg: ASbGncsq+wQVYMCGzQZyeLnVBBLuwmNs37TZ+oV1lubZk3j60qVdd11VkFNWRnWcU0l
 KCSbHa6pFWQ/MEIu/SnstXI4bn3fQq+Tg+bmPW5jaOXdfHFC4aD1mX86dSlBgVKbLvWKpsFXUVW
 PzdDxWDakyFANwr9XcGafvFlhli2Y/slpVhbbDNnsbY2F0IMDRQde93sbDpF3OP2z56ULhOk2P8
 tbmoaxCRN2+gGJJO7e0jkuhQrvZBC0PQisIjN9/aIMpTbAqV6PZKqp4dzSHHlqec2ojHKVKjGwz
 /kIjRlMghaccQUJGeChZ26Odkk4hW1lRwzVYhZ0D20yb2Pa9lJt2eqHFTxkZ+821/xy+MQbsWj8
 j
X-Google-Smtp-Source: AGHT+IFQu3tlaNiE1UvByvrYmdvAeFke4XMi2qfRu4OIkxHhB7ZIvog89oZadz+xJS5l1duV22AlwA==
X-Received: by 2002:a05:6870:9195:b0:2c8:33ab:e80e with SMTP id
 586e51a60fabf-2d4d2b77936mr1130911fac.19.1744812658345; 
 Wed, 16 Apr 2025 07:10:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:10:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>, 
 Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, u-boot@lists.denx.de, 
 upstream@lists.phytec.de, Primoz Fiser <primoz.fiser@norik.com>
In-Reply-To: <20250408071710.3618157-1-primoz.fiser@norik.com>
References: <20250408071710.3618157-1-primoz.fiser@norik.com>
Subject: Re: [PATCH] board: phytec: common: Fix phytec_get_product_name()
Message-Id: <174481265747.2150978.158282723366642489.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:10:57 -0600
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

On Tue, 08 Apr 2025 09:17:10 +0200, Primoz Fiser wrote:

> Currently, phytec_get_product_name() function only takes care of PCM
> SoM type, however in case of PCL, KSM or KSP SoM type it will return
> error:
> 
>   phytec_get_product_name: Invalid SOM type
> 
> Add support for other SoM types as defined in phytec_som_type_str enum
> (see phytec_som_detection.h) to get rid of the error.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: phytec: common: Fix phytec_get_product_name()
      commit: 4c0d377858e3ffccd803e4e4177f93347a400436
-- 
Tom


