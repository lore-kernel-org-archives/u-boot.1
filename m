Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4AAC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 17:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2877807D9;
	Tue, 21 Jan 2025 18:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IsIJr4fa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA63801F5; Tue, 21 Jan 2025 18:34:20 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E97D680283
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 18:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6f0afda3fso652510385a.2
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737480857; x=1738085657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kzII9oXeVRvVfzdq5S8BlFXEwsmSUC+TQq4Wf/0/wbM=;
 b=IsIJr4faCzIOe7ycI+4s60BUWYCpFCrrGcVZv95Qk/imBOTg9wUGp8XvutLs/3cTkN
 AeVQl5vSiVh/zJ6MxH46HGmkFAOkxegoF15oTNBoACuBEC1/DEzIQ6AwHFuKCbBs0pQb
 2WQs1RTc87F0KGM9fH1B5YuL+xufSZzVgEpsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737480857; x=1738085657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzII9oXeVRvVfzdq5S8BlFXEwsmSUC+TQq4Wf/0/wbM=;
 b=tIA7gEjsKwXFeZ2J6T2UM48eey8UzNp6GbLacwIa9OurVdX++KBar38+giSjHyCIDa
 PXTPzuP7egamGXDOOqRlB8JILgdZj+tZhD0uKLhBUFa0QomuRs+kaaBeNlBqkzIvdfUC
 rkEggBUmRLRy4Z+E0rsgorbWD5O2v9YptlCQ59cvkcE8pwfabVssHrcoG44z9N9d2bY1
 9MdOXtQ+oAXJNgWRYBIYX3XdHw2Lo9dQELT/Itf/VJ/7klnyto8aPQfGzRO2mnVkZWhI
 oLYVIOUGB22BQRTh/EDUINn3aaCxqgAZYakK1gdeuJMDATMvVzfEQCaWXPiKOfNvOWiK
 DoJA==
X-Gm-Message-State: AOJu0YxlpUyZ7L8GLbbxZlDro2V64JXYtSyKCgqr6wkrVy1rTU9e6Qhr
 i0BhK6JTp6LOkkO5ixJAYjpbhawOYJjXA5qK8Be+YKb0iBQz435WgdFGce4t1kk=
X-Gm-Gg: ASbGncuS/HAI8Y4J8wyJfwrkThMKNY8gPAPeoOvOTGpxtgOP4NAdTkUmN8DEBY/Trud
 eE/RNCVAFybx+kWGJzW54gbt8ykZg6YFTzDjzMowqzT3JIKvV3zWUGvmPrns19ELnQ/brDEcIac
 GhHyvn9QwqMg4QKqKP+6bZH/S/qh/Yv/1/JxaLw6vyYXRVCSWMR2DNq7XLnns7BAPzTsZ3YXxBM
 fsK8JmYKNP3Uir9O/m/RpGU5darsmw+YMXN3fpJ1nXEUm35v+hoH9Air9aCNSLrTg==
X-Google-Smtp-Source: AGHT+IG7FCVzJ9FmOy5Dt6Xlp6laYtAaANrCdzgu95rj1f4lEkgcgzT6/EiV+NvC61X2lO7vbi5n1A==
X-Received: by 2002:a05:620a:40c8:b0:7b6:7850:21d4 with SMTP id
 af79cd13be357-7be6325bdf0mr2759926485a.52.1737480856834; 
 Tue, 21 Jan 2025 09:34:16 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614746f7sm578462085a.9.2025.01.21.09.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 09:34:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com, 
 david regan <dregan@broadcom.com>
In-Reply-To: <20250114045425.148801-1-dregan@broadcom.com>
References: <20250114045425.148801-1-dregan@broadcom.com>
Subject: Re: [PATCH v2 0/3] Broadcom bcmbca dts updates
Message-Id: <173748085446.2982616.4454492798202797539.b4-ty@konsulko.com>
Date: Tue, 21 Jan 2025 11:34:14 -0600
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

On Mon, 13 Jan 2025 20:54:22 -0800, david regan wrote:

> Updates for Broadcom bcmbca devices,
> make use of OF_UPSTREAM which uses Linux dts,
> update bcmbca dts to current nand node naming convention,
> enable basic nand functionality for bcmbca devices.
> 
> Changes in v2:
> - Removed addition of nand-on-flash-bbt parameter
> - Moved enabling of nand functionality to a new patch added to the
>   series
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


