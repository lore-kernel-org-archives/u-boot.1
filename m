Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2560FC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 08:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572188798C;
	Tue, 30 Jan 2024 09:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ROaYzTqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E771287C5B; Tue, 30 Jan 2024 09:36:21 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99BF98796E
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 09:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40eebe7767cso29300175e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 00:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706603779; x=1707208579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2G/9gPb36hARfgLfZlAOvqoJL4XCWUO1fPWYyKzP6T4=;
 b=ROaYzTqyprimsFt1au8B8ZskZtlhGEqni31tcR2hEkHQ5CX2QRcZkALVcMjactNIWY
 d9a6FRnpFN8GlcvQcjZM+bCQeq8FPlLChnhtrbYdu668lcAXqiz0dnn5NjTmNm2gL0er
 WvkHHGGOrwE+3A7dXR6Ib+b9HDtZEeaDWrKQFzNnjIAE6pfRoy/ndRf2jUY5ZS/7lS6c
 paPCJZOFtAN1varxZZduMJihEhRDvNo6MCHti1VJMVVILovvkhPGj65meZ5TiZiovhkZ
 JcpxCjwA9N1ekX9dPi57Kf9wXneNwh/CD9rCkxK0/6mGIA5ydcYAD2lHB6cQztKqHIKw
 ysdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706603779; x=1707208579;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2G/9gPb36hARfgLfZlAOvqoJL4XCWUO1fPWYyKzP6T4=;
 b=Ra/CVBCEmzwWGQmM24nlyp+nqBAr9gvqeHPHUbOUe7M7pJr81QPO/ibpnWwRzZMSo8
 CTcV3cGh0hSHbOeG3SpxwoxOMJ9y1+RhTP4SFZSTqhDBWhWNhsonRUk9T+7roPIYCgeg
 DRSoAHnsz72BbkeXfmB9/wCmJLH4TcCPkD0qXuo2ETLE+o7pnzVZZE9DvjWYN72fM2jZ
 C9HpLsi7J2pbyb9xi330qfb4ATNuSwePuy0KADoZfwc4qwMf1E+7OuhEKmvCC4Kias+Z
 7qm0CGHyj03ExF1KY9eelEPJwReoAX6a4be6iWv190ggHhfJI+1UMViaFtDa4uQ6hDDy
 h30w==
X-Gm-Message-State: AOJu0YwmbEntDViADxJk+UKlVzFsAZNC8nJZ1YWih83pWWNmRiP0Mk8l
 babqTJlkKYDsaeM8EbsPf68vaZThCAUQRjJOgpStOO3oikEfKJINYNzua+j5Gbk=
X-Google-Smtp-Source: AGHT+IGQPLEkUgtTIP7g1JTl6y4HMUQvAZiT3N1VkbXGjaTX9FWk/JeI8GqdbTmD6LOJ+GW8Q053tA==
X-Received: by 2002:a05:600c:35d1:b0:40e:6238:e9e8 with SMTP id
 r17-20020a05600c35d100b0040e6238e9e8mr7307095wmq.1.1706603778910; 
 Tue, 30 Jan 2024 00:36:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 o34-20020a05600c512200b0040ef6aa8870sm5564733wms.24.2024.01.30.00.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 00:36:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240124-u-boot-model-print-fix-v1-1-484960069623@linaro.org>
References: <20240124-u-boot-model-print-fix-v1-1-484960069623@linaro.org>
Subject: Re: [PATCH] ARM: meson: stop printing board model after sysinfo update
Message-Id: <170660377823.1669123.4283726180918846122.b4-ty@linaro.org>
Date: Tue, 30 Jan 2024 09:36:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

Hi,

On Wed, 24 Jan 2024 13:47:25 +0100, Neil Armstrong wrote:
> After the sysinfo update, Model is printed twice, remove
> the now duplicate Model print from mach-meson/board-info.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] ARM: meson: stop printing board model after sysinfo update
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/076529725f16f07a5cb2d5feba25d62b5f5a5872

-- 
Neil

