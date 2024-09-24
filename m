Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0AACF9C69
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 23:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F7288B0C;
	Wed, 25 Sep 2024 01:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OVrg4uhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1547F88B27; Wed, 25 Sep 2024 01:40:59 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C238E88B08
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 01:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-45aeed46f5eso28044131cf.3
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727221247; x=1727826047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mj0vULGjYhoIDbRs+uhq3eYtU6XPXlGe6p2ckJ0dHlE=;
 b=OVrg4uhyRpbfNbVf8GP/1ktNK4IEzT7DGSCUU6H7MLP2JcTTzhfvB3DzZmwEx/80Vk
 N/urx4B9c2hyX4NdKqwwg7NBe9sZ02hhdXX7AHfIaBQUoKb5LeO1agHtSRPH13LXBPXk
 WZ7NyGaJDXg9U7tZqKm/4F0Mnnb9ATyFOZJDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727221247; x=1727826047;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mj0vULGjYhoIDbRs+uhq3eYtU6XPXlGe6p2ckJ0dHlE=;
 b=pNxQU1xobSVGAZDWzJg5YiIhXsMTUVxlAXmuEPY8QsZ5GcGCBAiVLAX0WX5sNi1Juf
 45rmaN2dqA74KvYAMYYAsaPrs0hsxIWF6NDDM5ULSQ+wyRHgxRO2B2sRT581z6zjfvK5
 yOlR+ZUymeKqzKMUJ9xRqSv6YY9u9g3On2j62UWlf3tpqWtBLKXOacfbFEMO+k22fPaP
 mQPnZV4QQV8lRR7nwoK1bPYFU4yKfLsMAThy/EWwlicP9C+pkHj6AMIoe/SEe8l4tz1n
 B1V09GoIRVLv3WJzuMShscwQCGiLkaygVrIOpDUgJ90HVjnS5MQxoCorqThcaIsWDMKK
 fBcg==
X-Gm-Message-State: AOJu0YywCtgjM6sKuX8Iyr6FpHhGSLsV92LGkDG1a4FBP8jKHF2A4W9G
 5nuciXBarQqfi/hJ+OKRJ3beBBHxh/7X1c47TxnVP+ZpUhWP1FEoV//6KP/WMlA=
X-Google-Smtp-Source: AGHT+IGm8yzZ9WvPhKwjpurxCQOHw11YUGmr3RfjAh3+nDtB2tFZU7aButTFwuLcd8CBLVALW5zjhQ==
X-Received: by 2002:ac8:5907:0:b0:458:4d55:fdf7 with SMTP id
 d75a77b69052e-45b5e094c58mr15247371cf.40.1727221246603; 
 Tue, 24 Sep 2024 16:40:46 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b5257698esm11147141cf.26.2024.09.24.16.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 16:40:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
Subject: Re: [PATCH v4 00/15] Miscellaneous fixes
Message-Id: <172722124471.127252.14134886326972056668.b4-ty@konsulko.com>
Date: Tue, 24 Sep 2024 17:40:44 -0600
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

On Wed, 11 Sep 2024 11:58:13 +0200, Jerome Forissier wrote:

> Miscellaneous fixes made when developing the lwIP series [1]. They are
> posted separately since they make sense on their own. Subsequent
> versions of the lwIP series will contain a squashed version of this one.
> 
> [1] http://patchwork.ozlabs.org/project/uboot/list/?series=420712&state=%2A&archive=both
> 
> Changes in v4:
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


