Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23FBC3271F
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 18:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE988892A;
	Thu,  4 Jul 2024 20:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dOa1dnuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCE788917; Thu,  4 Jul 2024 20:50:50 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45928891A
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 20:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f8d0a00a35so771289a34.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720119046; x=1720723846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y0cuNHebvrctjQQkxwvFx890p7doJUrVpNF2Bf5GQus=;
 b=dOa1dnuQjMoclXCnQZ27reb5IQf45lIrKYyehmT0/ovD1H08XC8D53YJtf1IHCeI7S
 zepiwZx+isklm5MC+d9EGmjNVEfuJj46f9CFfVc8w22b5u4bztqpOnYqIySu+A664aAu
 dMSGEX/LQ2r7IVAEnLwPW/R6jXQac6SKr5Pv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720119046; x=1720723846;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y0cuNHebvrctjQQkxwvFx890p7doJUrVpNF2Bf5GQus=;
 b=io68Qmx+atmLwzLr2ufKZJ1xC9oSkBpWzMOGVrrbPNMuraH51bPjh75dMCSpX33Qgv
 a5dfB7p4T/jjCajXk6rAK8tsA6skby4xdjfDCEekF/AHwM0dNnLgEdPwA4YLQdT3euhX
 H1TO3G9mbc4lt7bptKFcLs3ltiT9qP1g/3MoDWFDZsPOWPc7oKxBEbaO8+81Ht1z6Oci
 cjc5GVBa+MAT8WN9Cfwiz1ulKRQPmqTzbnqXq0qfMPwBeEWvLhEh2QvNpWeoHJLVcBcj
 7ty77MddOr0P3Un6s1jt4tjv/aU2aKfw4YaK36w7mtUuyAMtKyyHf03Z9MzZIjCoUEdM
 WQDQ==
X-Gm-Message-State: AOJu0YxxnDCJ+Mo3RauUREsYKZggwuEMTZUH0sh6NtZiotGiapJKjlQJ
 /wYxtCWEfSw8gbYCLvqS0HwrNacoBAoyL9e9GEULaq7XrgiEj3BXT2dDNUBsURsnXn7T0dJcCOB
 C63s=
X-Google-Smtp-Source: AGHT+IHc9veU1Lfsgn98WQhrdLQdgxevX47AJxMAL7GfzzUxYmQzsaMaryLz0XUOMP31qHxJjip+JQ==
X-Received: by 2002:a05:6830:206:b0:700:cf6e:e261 with SMTP id
 46e09a7af769-7034a80cfbamr2692159a34.31.1720119046445; 
 Thu, 04 Jul 2024 11:50:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ac8dccsm2454997a34.34.2024.07.04.11.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:50:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240627134320.3518272-1-trini@konsulko.com>
References: <20240627134320.3518272-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Make pytest export JUnitXML
Message-Id: <172011904591.1502730.9797560305807570602.b4-ty@konsulko.com>
Date: Thu, 04 Jul 2024 12:50:45 -0600
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

On Thu, 27 Jun 2024 07:43:20 -0600, Tom Rini wrote:

> Both GitLab and Azure (and other CI systems) have native support for
> displaying JUnitXML test report results. The pytest framework that we
> use can generate these reports. Change our CI tests so that they will
> generate these reports and then have the respective CI platform pick
> them up. We write to different locations because of where each CI is
> (and isn't) able to easily pass things along.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


