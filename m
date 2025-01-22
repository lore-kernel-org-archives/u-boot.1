Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E50C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 21:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435B280711;
	Wed, 22 Jan 2025 22:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zs49xc4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A457080762; Wed, 22 Jan 2025 22:00:58 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C1CA801B0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46785fbb949so1982881cf.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737579655; x=1738184455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZkUZ2qpqH22seev7eX4kh2rADAF5QmHSRIO6nYujpg=;
 b=Zs49xc4DWeK1ZFa4qk8m408wVh3oybIX/Gztjt7zZuZ1HbztDAd8xDFp52CKjO2iLC
 ddcBHflq/3l7gX3UuBtQGF157Zns3xnpMq7pQwtPbx8FYz3/FQ63pUznExcB3jibdROE
 yu/GD9wqZXbSwHupUGSHgjCI5otoLgf+otNek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737579655; x=1738184455;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZkUZ2qpqH22seev7eX4kh2rADAF5QmHSRIO6nYujpg=;
 b=TAk31mfnY3Z84bHsa6uGmhmDSK9RESrAsCGolKUs289sgSHZ3MCjKtROcM4tpVn8DJ
 W0/JFb59Ct+qEQjHdqb5a4of5lBi9UuKf+ZmXP1w7u7ro+c8ql2it6pDcJVz6Zif6OTg
 WoQwzhUf04qWoWNNboSuWZZWrjmYZ8Cg3iKFai0XLsFFpW0UJ2FBVaf0Xak/0OfsGAu3
 0yrPkvFfJLFqm/DxnF6a1tbj6YXBloHaUAf8gy/SjeQYo3gphjV+zVXvzm7kgUfsCpID
 d3PY5a6WhNhvNCM7EAeKp4jk7Ihq+zBWMQX0gv8krPuKSW+qtdk1lpbCILSA3IzqkR4P
 WmCw==
X-Gm-Message-State: AOJu0YxJ9l6ocwG2pB/BXZxhpd5/L30XWF9fdEmCueeJp6t0K+yL7x18
 L6+BAx2Z/eQZVJrHsCKm6gRrM3YCD61achWEO8D1bYbDIXUjtwJiNiATRXky3zw=
X-Gm-Gg: ASbGncuiqFpHHSAr5FLRAAmJou1gfgKnvMzGz2Zv6N5XC/ceB4TsJjhbUpVxk0J2BvO
 cgQJ3JObXxBxuqCVTDolHByJVG5U7+za6YKQ3II9AyA0G0lK9YOp5enNz8ntcMdh3qjq1ucfXG1
 po59/VK33VDx9VbPckMYudCqxZKpv2Cs0JWJy7E7MyU8+tkFsJSSKoNAh2Q+sX0zOZazNV8d9oy
 NDfa3wBrQFW6agKbscF8/hByPkrl9RSQTr/gatU2Sc3yK+SJGpzNH+tXShToi569Q0B
X-Google-Smtp-Source: AGHT+IG8cyvWrHqJwjg+xSvhuzE6U32f+Q7uahea2kCoJ8a+B2bZkcEFoLYhffEkaogsJZkHKFitow==
X-Received: by 2002:ac8:58cb:0:b0:467:8836:e003 with SMTP id
 d75a77b69052e-46e12b7bf14mr387261381cf.41.1737579655403; 
 Wed, 22 Jan 2025 13:00:55 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e10305328sm67560021cf.32.2025.01.22.13.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 13:00:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: David Feng <fenghua@phytium.com.cn>, 
 Linus Walleij <linus.walleij@linaro.org>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Chanho Park <parkch98@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <3d64bf095ad00a79e185ad034c0a8accdb9f2a15.1736954361.git.parkch98@gmail.com>
References: <3d64bf095ad00a79e185ad034c0a8accdb9f2a15.1736954361.git.parkch98@gmail.com>
Subject: Re: [PATCH] vexpress64: Fix bootargs when building without NET
Message-Id: <173757965320.68186.11930401495370320222.b4-ty@konsulko.com>
Date: Wed, 22 Jan 2025 15:00:53 -0600
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

On Thu, 16 Jan 2025 00:31:48 +0900, Chanho Park wrote:

> When building without DHCP/PXE configurations (NET disabled),
> compilation errors may occur due to mismatched bootargs.
> Ensure bootargs related to DHCP/PXE are not enabled if the
> corresponding commands are disabled.
> 
> include/config_distro_bootcmd.h:443:9: error: expected ‘}’ before
> ‘BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_DHCP_or_PXE’
>   443 |         BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_DHCP_or_PXE
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


