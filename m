Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7278AD10374
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 20:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1EF88D61;
	Thu, 24 Oct 2024 22:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VhKGPjU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C48F588D61; Thu, 24 Oct 2024 22:43:27 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A70C87D1A
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 22:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b158542592so88921185a.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729802578; x=1730407378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QyXa0vi8yH28U0+IE/InWLJkEhB1xhQxuzD9b+vwFGE=;
 b=VhKGPjU3ocIxIbDkqMROLu3eCC/EdEgql/IIY+4PQ54qVPBANUb4DN98qcAWcHJF25
 PI7Si9sul0jAFLdfKP+9xOxbmOLANOPLBXNt776sNNwax3m9u2p48EDsRHdWx7wwKwoA
 gFvaBmaa6YM3uX0Qxl1Wt2ddPBx28YyJVqCCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729802578; x=1730407378;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyXa0vi8yH28U0+IE/InWLJkEhB1xhQxuzD9b+vwFGE=;
 b=OgkB8qkx95uh7HF9Do0l8cyBl/wvOjej1ELQpDVztkgN1WG7oe26AxooobwDstVYbo
 PFlhbVmxF/LljAEBfeRyko42i5CFTavmkLYjTsvGc2pCjIx6Ukb+drS4jrEaz5VY9PJA
 aX5NzGJfl2YjgxrbnLaywi1CXXUC0ILhW6Alj4BID9Ma/b0lOeqJekotHyoeURuIr1R4
 IZZo0JnYXqa+pFclDv6tiXUIs5L/U1QKar8yttaCcUmre2vTpX1O/iimt73pex1gs0CG
 3W0blyQboztFWHf1Qijw90KyLdYpA5aCJwEOpHMIWvFBatl4c9qC7fVLcyH4CUd0yawY
 AM8g==
X-Gm-Message-State: AOJu0Ywj8uXXJiOO/owsI3FMBA5z52Hi+TbKk5xOq1bz0eYhZrFG7v+d
 kcJPL1b2vp7yaR3PEwiaeqISO3saLE3tG4s12d9DU7F6OcIAIvGIOeIuRltf9Nlo+tiIoG4gNYj
 YayPRSQ==
X-Google-Smtp-Source: AGHT+IF0RtHKnNDAOc1F7w0M6UI4RP0kwfSm1uCHwL4lpkAAMaS3YFOIiK+apB5LR0dLG2/G+urbpw==
X-Received: by 2002:a05:620a:4043:b0:7b1:561d:6ff2 with SMTP id
 af79cd13be357-7b17e57a8f5mr918130485a.37.1729802578189; 
 Thu, 24 Oct 2024 13:42:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659c0361sm521428985a.19.2024.10.24.13.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 13:42:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241021135633.2958463-1-andriy.shevchenko@linux.intel.com>
References: <20241021135633.2958463-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] cmd: nvedit: Mark a few functions static
Message-Id: <172980257750.160410.2954170747240821285.b4-ty@konsulko.com>
Date: Thu, 24 Oct 2024 14:42:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 21 Oct 2024 16:56:33 +0300, Andy Shevchenko wrote:

> Some functions are not used anywhere except the same file
> where they are defined. Mark them static. This helps avoiding
> the compiler warnings:
> 
>   cmd/nvedit.c:201:5: warning: no previous prototype for ‘do_env_ask’ [-Wmissing-prototypes]
>   cmd/nvedit.c:315:5: warning: no previous prototype for ‘do_env_callback’ [-Wmissing-prototypes]
>   cmd/nvedit.c:384:5: warning: no previous prototype for ‘do_env_flags’ [-Wmissing-prototype ]
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


