Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5EDC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4397E86F5C;
	Fri, 17 Nov 2023 14:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AdhzPbGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC09F8708C; Fri, 17 Nov 2023 14:41:10 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B3286FF7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-67089696545so10266076d6.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228457; x=1700833257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IChSdide7K2Q1nk2avw8oCkBzuNwAJUQsyyr5wSeFKM=;
 b=AdhzPbGnC0hevi/RqONd9b/s88CZZpJo5goxyxSNv41vw83KZPJiVU8mvVX7VkGycI
 cp8S1vQCY+mdqSBS17wr6/tJOYZ/FgYmSBTYl6tzU2zWAofcfVVyIxFoyJdtOrzjsVBV
 KBhXQjuH28FpwbyqE+2RJ1jCg/W0+vbJKRaAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228457; x=1700833257;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IChSdide7K2Q1nk2avw8oCkBzuNwAJUQsyyr5wSeFKM=;
 b=P9+ln/dqcWbtknl8+FpkPxDZG8zKUxb6L2MEqcbTbE4DIITUz+aADKL2HBx7a3MA89
 ndWjlvveVK9v8elM5nfL8sF3iR+/pXPI5Dniw2gLNHXt7sVDQ5K8W6NB2/jz+6G/5R+0
 4SDyalHXZsJ1nPomYoSATv2kYA8HmTZcLJ4nQT77hUTPQQReAIjiwbgxmj5q2+n70aCH
 aJcSM2AA5elAdwdjasbLqPxpD+Ed/ZYQq/pD2GXYB730ihKuKq5qJefpSzlT0yJF65+T
 7bNTqMMPYwe7EhZHiV+E9tSizRpzo9FcehGFmu9A0es0O5Wl4k/+7bqkzod1ZGjYwY8Y
 jjbg==
X-Gm-Message-State: AOJu0YzbrhzYoZbvdqSBdLYgBwczcvAv/xBK0pqyxwShGjFwnd/8BtIM
 hrZVaG0xiEau0MRvOC4TAf3p7A==
X-Google-Smtp-Source: AGHT+IHGuCOZGquYVXRJyQMNv6zd0R/Gg18KfaKsQQbADN3hzGtf3+jgG5HKkSFKnGP0WcbDMRqgzQ==
X-Received: by 2002:a05:6214:b12:b0:672:aecf:581a with SMTP id
 u18-20020a0562140b1200b00672aecf581amr10837941qvj.47.1700228457199; 
 Fri, 17 Nov 2023 05:40:57 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 lw23-20020a05621457d700b00670f8570a24sm633820qvb.23.2023.11.17.05.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:40:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, Vignesh R <vigneshr@ti.com>, 
 uboot-imx@nxp.com, =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
Subject: Re: [PATCH v7 00/26] spl: Use common function for loading/parsing
 images
Message-Id: <170022845600.752997.13086584149067725801.b4-ty@konsulko.com>
Date: Fri, 17 Nov 2023 08:40:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
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

On Wed, 08 Nov 2023 11:48:32 -0500, Sean Anderson wrote:

> This series adds support for loading all image types (Legacy (with and without
> LZMA), FIT (with and without LOAD_FIT_FULL), and i.MX) to the MMC, SPI, NOR,
> NET, FAT, EXT, NVMe, and semihosting load methods. It does this by introducing a
> helper function which handles the minutiae of invoking the proper parsing
> function, and reading the rest of the image.
> 
> Hopefully, this will make it easier for load methods to support all image types
> that U-Boot supports, without having undocumented unsupported image types. I
> applied this to several loaders which were invoking spl_load_simple_fit and/or
> spl_parse_image_header, but I did not use it with others (e.g. DFU/RAM) which
> had complications in the mix.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


