Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95031C02192
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA70827A6;
	Fri, 31 Jan 2025 23:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L3n+k+VX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B0A80FC9; Fri, 31 Jan 2025 23:07:05 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E216180F95
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dcd4f1aaccso32245676d6.2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361222; x=1738966022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPs6HojH6FQ6mGpakgNmswK9Q4IGnnankJepyrVJvlY=;
 b=L3n+k+VXGvmKsH8Tg7na8EdO8AnQzANvPpY2pfNQxgUQTbVJOX+1QFxkkhIJXoAKDQ
 qKsSt6FJVvzloVLHZcE4YEKWAGjFqbFn+NPkmImgngoiUVrwEBZJ19ylwGZGLkh0iPev
 zXH5VJri8qT3Rw+gWH83VFyTD8dJ07fo40pSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361222; x=1738966022;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPs6HojH6FQ6mGpakgNmswK9Q4IGnnankJepyrVJvlY=;
 b=C9AHAuko4pwlS96ewYrvvWLCuCLDtNjpXNmotE7RgoKXrxg8xhN2AFwCm01y0GNebF
 HObkWsUk8cH21kIuz89H2KH/bdijPSedindXh4iB9piv1byuMSozys6xldKMZr0ua1o5
 c8ysS0AHrfnKkY1Mvql4cSP8iVZjQAyQbMfjr/esFfGq6Tq+OBBD7L99gmQzWdK0q9PN
 2a9AiIAWX1zierBUnUj1AiFK0BjhCEzsBeb49ydTgHWB7R007P9qwFMUJxHr/IH7EV50
 JFMlAdNIzFiDtEhWWnCEtvSiY5lh8MfJa8yCtiqQB/bYJI8xQG2LzreJ1rWd+qhoLMpN
 SLfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKkVTUqDg6nyydMpDwpAHSiWEVbmDlLOYSDWEXmF0X4nH8Bh4O+yaeXDpmECYtP1YtAQ27Xd4=@lists.denx.de
X-Gm-Message-State: AOJu0YyOfEBSQ1Xlzh9dsC296tWqNKRWKOQsdVheOPJiqAjStCQuKwpL
 vFkrWZ7mR8VHF0oC1SkXe8xJ9fQ+RxlKaPjXeR5OpG3ts/MLf/B9C08gifuiua8=
X-Gm-Gg: ASbGncseRbhbdmaLa1GDvZlyTKEMrWpI7gaVggVbArrcvw2qAIF9UkFg7w4kbbJkJwG
 hGqaLWHyoHQzDJw5G1ieuKpH1CfP9lglo+k6+zZzaUCJLQmZyx9BV4cp1eVE8ljSivvx/Kd1pLx
 9QpqyO9xEZMcLJ7ffKb+MvuezQvH58BQjfnvEHx8mNWMw3B4P0e5B9CWrlFTPVqTodkBm733qi8
 q4pCAmI26MznxNOhP4FgsmW56MGfuvXHC+jRaR+xX3pbRS8ajULAhpYTsuft5qGSAZP6lx6/vvJ
 YbHcJPnTvKhumg==
X-Google-Smtp-Source: AGHT+IFKtVA0/6YKsY3iI9EFbrvlUYrLa9R/hSU/1OiDSsOZinjnzF6t3AUb+jScVNE9Fe1GSRrjOg==
X-Received: by 2002:a05:6214:2348:b0:6d8:9ef6:5b10 with SMTP id
 6a1803df08f44-6e243bfb0d4mr225903276d6.23.1738361221845; 
 Fri, 31 Jan 2025 14:07:01 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819a57sm22141986d6.45.2025.01.31.14.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:07:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: d-gole@ti.com, upstream@lists.phytec.de, y.moog@phytec.de
In-Reply-To: <20250123144350.846527-1-d.schultz@phytec.de>
References: <20250123144350.846527-1-d.schultz@phytec.de>
Subject: Re: [PATCH v3 1/2] board: phytec: common: Add product information
 to FTD
Message-Id: <173836122056.3060818.15562099504818433404.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 16:07:00 -0600
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

On Thu, 23 Jan 2025 06:43:49 -0800, Daniel Schultz wrote:

> ft_board_setup inside the board code allows to alter
> device-tree during the boot process.
> 
> Introduce a new function for the PHYTEC SOM detection
> to read the product name and part number from the EEPROM
> content and include both into the device-tree as
> * phytec,som-part-number
> * phytec,som-product-name
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


