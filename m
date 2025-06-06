Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E931EC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2680582ADA;
	Fri,  6 Jun 2025 18:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TTSfKZFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B9B382ADA; Fri,  6 Jun 2025 18:47:01 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F21B81FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 18:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40656384d30so1389467b6e.0
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749228418; x=1749833218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wEoDsqirKwIdgHy6SmkGoUyOvK7fjJq9E9qn12a1Ea4=;
 b=TTSfKZFYFJvudtAsPZJt9oXNkRjZBJ0DeEeyQ99h6QdxuA9kDq/SfuGB0y3C6Bdq0W
 lWzINZ0CPF8Fy10SCHlHJo555rg56yamSQUr+pBX+E18165scmzgFYJGFi28qlBXgI4H
 crcBeUfsmqs+ayjbJxI0FsoMBLfxfqFp5jrt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228418; x=1749833218;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wEoDsqirKwIdgHy6SmkGoUyOvK7fjJq9E9qn12a1Ea4=;
 b=WkI5g1Zq73wzAO35luIUHrWTLoBE2sPX1uNS5AYUWv/dKImMUnO/poAFHkFZWrElLy
 QAG58xiWwsEX35gx5k/y5/e8pLMv997+w+w1QyvdAcnvwp8IgP8Iz+pkuGq7wrwfxi1o
 dbRrTtsbn0cQzm+yMWb6LT1MDprh8b4wByKsTXdi/n/iD2TLU828PsZtcGjngNWHHKHW
 IanVtbmk+BvsEPN6rJk4WWRflgC5eUd5Pe74VNbMpnXMOybIeHFGKGc7g6BGQCIZpPCz
 UuxsaV3dBepNxBX86cFAtmymMMLm9XKL6kY6N29EL+RmZHjZ7ikbvQov8XoUdi3CMW+i
 MwPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl/YQqLiCQhIVJbcutjamNCSVuImgf91PpGOe9gi50ZfSa+vk6jXUL3L0YufGdk7HobjrOqJY=@lists.denx.de
X-Gm-Message-State: AOJu0YwAuFZCF0dODPJzRpo4NKqwqRYZu12McCftKI1X5IJ2pKqBf6ac
 x70OUffJ9TvChqnli7NKH/y5kO9BoitgHw2FB4c56csWkv4BI7368YQ63mR3xA0gsnQ=
X-Gm-Gg: ASbGncs7MH6IotmAw89kD2VU8SCCxue6GSohRmF+Rer1Nhj8g73QTaGMrM//GGCTF8A
 fj2FU9/KXeiPDS3qFIJJ+hciUzcsT3yu1Ten35KoWtkuI0slxu9khaIlI7mjvhynumG/gRGgokd
 J1sOzV5wW8dqve0jE0FyDTSDoRJa0MAZnEhtJXfM7sZYb2gzmZt+9r8EeWXhc9JzLxe1Xqe4n78
 ktXkmoqRPE2e2iOGKaIoMOFfGAWNXLRJksEOk2wkIh9LqJIM2mPCmfeXffzej2dXcEm2mcRROJD
 2/ME4jo2ANb0OgJpABCrgayL82lS7ASY6gkhVXugrZmYyzyrIWlLBWe7AaqqjGme8wrwx2aai2c
 kFPX279NyUUE=
X-Google-Smtp-Source: AGHT+IHwUs7wD8FM6fVUOQo8LsFf48c2gTeCtlMHOa+J83VHYA3DuTCYN1pC4VhliJUYRqERFak8Ow==
X-Received: by 2002:a05:6808:6a83:b0:406:6d79:49d2 with SMTP id
 5614622812f47-409052456b8mr3177321b6e.26.1749228418074; 
 Fri, 06 Jun 2025 09:46:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069418a9sm377808b6e.11.2025.06.06.09.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 09:46:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250525134407.3760-1-ansuelsmth@gmail.com>
References: <20250525134407.3760-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2] cmd: bootmenu: permit to select bootmenu entry with
 a shortcut
Message-Id: <174922841665.3195369.597691323240823912.b4-ty@konsulko.com>
Date: Fri, 06 Jun 2025 10:46:56 -0600
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

On Sun, 25 May 2025 15:43:58 +0200, Christian Marangi wrote:

> Permit to select a bootmenu entry with a key shortcut. This is
> especially useful in production or testing scenario to automate flashing
> procedure or testing procedure.
> 
> The boot entry are changed to append the shortcut key to it.
> 
> Example:
>       1. Run default boot command.
>       2. Boot system via TFTP.
>       3. Boot production system from NAND.
>       4. Boot recovery system from NAND.
>       5. Load production system via TFTP then write to NAND.
>       6. Load recovery system via TFTP then write to NAND.
>       7. Load BL31+U-Boot FIP via TFTP then write to NAND.
>       8. Load BL2 preloader via TFTP then write to NAND.
>       9. Reboot.
>       a. Reset all settings to factory defaults.
>       0. Exit
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] cmd: bootmenu: permit to select bootmenu entry with a shortcut
      commit: 8c986521c3c961338dc86a279757e67e8e23513f
-- 
Tom


