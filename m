Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA890C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3458881FC8;
	Mon, 31 Mar 2025 15:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wLKo1mY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B83481F6B; Mon, 31 Mar 2025 15:34:51 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DE381E06
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so31100425e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743428089; x=1744032889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTdqelaSKdiA4GY3y+wpT4GfGeZhD8VHlLUlnrYwjws=;
 b=wLKo1mY5UrU3C+txTXkQPdPw6OlW25VRhW4yt1Fj3H1AJ34KZ0onmv1t/FRm3J5Kjk
 SRofDCbqF5vuoiZAE9TXdKLt9qqEX7vxKH49GjfplptYOfVTMk5vyea8bmZGz7OXytiB
 tGQnVyf2iEXyZuDeyzXYdacF2eiQto2D0u8+8g+N9EDazf1RvUk+vvbmMfnkOnIjnR7U
 Ry2BMkgqBco6OsnwBO6Knpq3pnC7hmZBMXV/Cq0pvT+9ULAWIN5d5W4Bq3Waj5qNXSkl
 RaHHu83K5iEH0qaSYLO0QfEnBauoD+GNvnfTJRE1Ryv2vIADq4yWXmHiZw/Pdoy4ZVTN
 mh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428089; x=1744032889;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTdqelaSKdiA4GY3y+wpT4GfGeZhD8VHlLUlnrYwjws=;
 b=diHhJDamc/QOUhUIayJJYp7ZRoLGNEXD0qZgNttAhsAQUmEdUOxs3Z3uF33s+SlDM9
 Cx0aYcYAKxBrVviCQUJKa6bkfB8mGdtKSOPvqC664AsVCfeD61jqutOsfnwtX9Z5oH8+
 JA35c8oMxU6XAHZnmvvkMOBAXgqjLtuKMHlE6L4BbaGBQ5M5hO9Tmq8iG8hB7DQdjgWQ
 7aySPvOYUc4lFrESn4QgTj17TTNsuT/ohUzP93LrlgvbPDQEyc+i+RZ0JROJTIkmYgiT
 EJlzAiQ69hrt6FQKyh0HO6OUvBKK1LWkD7b84RPILxgD6MER8SM1LO9jcYe5qowWgQ5p
 R8Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3ekxdKIi6th9L7LWORTuaY67RaM80hrt45OgoPCsAyorb834g7IdP/w1v5iHhw+/4L+TNY9Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwIlS/oOIY24ZareQn/1t62Br7aEOfuOgbQs0uLAl55XF3diw9q
 TrB7Hgh85ZViEcLXe1N9ty31LQ7JCjSBD6ECttWlt2Ff4gfW4Zx7jxp6yo6W7xk=
X-Gm-Gg: ASbGncsrtItWf0WCfbrDcoiMqy9Fl6N7b+2qWcPyzzDXrF0SiO9kDRo1ou1osB6BU3O
 7V/K0rmQBfkv8VX7HNYM6j6sYSbwcska2cal+qRqxB7muBOW87DaD6sBtIEitujrmrW2vIgXjGE
 5N+58S6emH0E8fteexPAq8GyYRQcHcqrDm3PHUUfJEmoiAdXKCtQkGVKTWv7Xc3KItPLk6ynMdU
 0FPPNQTal/AQmGYEKYL0fe/wWJrQmCllTw7v0Pj4+iy5WehNXdyJ490zGnCRra2qOSJyXhY15z2
 Zeuay2dwfcpj+xoIpJqULcrllqXepwv9SVkjANkkb27Ysy4MpAsKZYHba2XizODy58EMGzGkNQE
 AWZ8Xjjc3qFWy
X-Google-Smtp-Source: AGHT+IFnHTz0NqtNEKgmzbhKsUw6q3aHCX5ynVYNMKx/D3mL+QEozDCC8R5wU5lmIkZMp/LGuxkJUQ==
X-Received: by 2002:a05:600c:3103:b0:43b:c857:e9c8 with SMTP id
 5b1f17b1804b1-43db62bd2dcmr70829575e9.31.1743428088753; 
 Mon, 31 Mar 2025 06:34:48 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm164266095e9.19.2025.03.31.06.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:34:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250227094911.497219-1-rui.silva@linaro.org>
References: <20250227094911.497219-1-rui.silva@linaro.org>
Subject: Re: [PATCH 0/2] power: regulator: add qcom usb vbus
Message-Id: <174342808718.411395.13828973418824866219.b4-ty@linaro.org>
Date: Mon, 31 Mar 2025 15:34:47 +0200
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


On Thu, 27 Feb 2025 09:45:48 +0000, Rui Miguel Silva wrote:
> Add PMIC USB vbus regulator driver (bindings already present);
> and fix related with property overwriting found out during
> testing of host setup.
> 
> Cheers;
>     Rui
> 
> [...]

Applied, thanks!

[1/2] mach-snapdragon: of_fixup: fix property length at writing
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/039754208ee5
[2/2] power: regulator: add qcom-usb-vbus
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/763a8b467d7d

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

