Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CC5D26D87
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BFC784390;
	Fri,  9 Jan 2026 19:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C/iqabtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE180843AD; Fri,  9 Jan 2026 19:24:25 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A1F8436C
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6598413b604so2825601eaf.0
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767983062; x=1768587862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2BopUkb/PoiKjla3kBG/NI++4pIL6RweUqFAIfmvAY=;
 b=C/iqabtG3j/7EG2Zc6NdWuTVhtD5oAQ7aeqW+cqrn5bAtjzfHpp6tkQLPqm7tjlIdv
 y2TchOC7hX5Ry+14jrS/wGu3miFpWIF9UlHkhpfJ/3C4lzVEkhvIjcqpRpyft41fbpeR
 BtqwAA/d9Jjke5YIlTjCjYlIFrCbyuXiN5Aq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767983062; x=1768587862;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2BopUkb/PoiKjla3kBG/NI++4pIL6RweUqFAIfmvAY=;
 b=vnPHqijtt5FqNbUn7xVrw/usmq5NMGLLOTsVq0AiVHCXzrwh0cNXJb9ZrzlIQ0a4xR
 ZdIDLPTKlOt8wOfu/jPPzLUWMPlcx5QXfrwaBLjf+/kFE1pj6VoQI0NQPAI6SN5buxSg
 C5yBBkP/k/xP58+oYBzqJL75AhEGzQv3QZYWntAZHvOuql6Tx5JAl5Geug0AaPPSKqvb
 DDSI+CeoX8cbJvKGpzYDNl4zVoIfPXZyIQBUCne98kNTNwXYwQl0c9LUmkBgt/G0glis
 HzcqeKc19C5kWJhyv0qytvH+lfWcUJuizeOoPGxw7EACO0NzfEeDdwJs1GU433FS/PU5
 J6UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbeEMrOI2nPUS4MzfOEHvOvpUKykDjr17N5PJ3YFrtx1xTfDD5LdfOtQf/hc89i4TgVi/w12g=@lists.denx.de
X-Gm-Message-State: AOJu0YzYOk9n9ZZN4dSmshRCcsIGrGmAS9aZ9dAsyIcPMSA0CHCKQKtQ
 WTs9SKMaMPvfj0vz1V2dNB/4yVvVhftclcQumYhiE4Cz1nOMTkE+6J9rqLF6DjuK+R8=
X-Gm-Gg: AY/fxX661Hd0zGqyqilz4AFtdwNRvoKGHeYAXR4/MDoT2E4ofSctYhXUe/pNpbB9mrp
 m+WF3L2CSp7X4CGcny9D4Lze6pCC0B10iUc8zO5xSvK1leT5achgxiyvZPsLQ7pBfG4F1ax7cHp
 lOqLhZYIuvDGWYsc2AFYjhMJoVdzBx/vnP9MPj/q9/AGbAdin0reFZCOtoPle9VinvoGARiWf1O
 YMiUbTURYmXgJFc22ykfw5I8Budsjh+jH6070+UX7PDi8Z821+EAqOA/O9Nhrva6tAoLvGg9eLc
 IIHQEls7BUYIOEcBA+cpQdzUMdlq0MNKQu1fbGVkPTUQzt+26XbrdgEF/4tbhqdmEt+fMury3Ra
 bN8CqhBf9tnPjY0BPoiSeS12I26C2D+jbIfiHBbuj2WVRnljNk6b+mIhz3UYD90fOjE7vFhFccU
 yfnCthnS1jCga6GkJoW4hJHR+sqlKKeXcqhonb8XB/vXSmP12wfAbY+TSohc7eq2b7OY/h1ggEs
 hvwcWNGrfelsuqVWLqQajfG1EN7HfFsrBEOK7OBuTpL7oWE
X-Google-Smtp-Source: AGHT+IH0pyUhJ0YJjENuSUrqaJtCv3ZwRpqzWcxkH40x2Sy4BzUAEerUT7UVnJGwp2X0s5JbOBSNqQ==
X-Received: by 2002:a05:6820:1ca7:b0:65d:1ec0:3002 with SMTP id
 006d021491bc7-65f54ef80cdmr5317449eaf.37.1767983061724; 
 Fri, 09 Jan 2026 10:24:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507235fsm7687647fac.13.2026.01.09.10.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 10:24:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de, 
 Bryan Brattlof <bb@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Judith Mendez <jm@ti.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Andrew Davis <afd@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20251226-emmc-boot-fix-v1-1-417959ba4e9a@ti.com>
References: <20251226-emmc-boot-fix-v1-1-417959ba4e9a@ti.com>
Subject: Re: [PATCH] configs: am62[ap]x_evm_r5: enable SUPPORT_EMMC_BOOT
Message-Id: <176798306043.1453020.12217116876680117806.b4-ty@konsulko.com>
Date: Fri, 09 Jan 2026 12:24:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 26 Dec 2025 17:03:26 -0600, Bryan Brattlof wrote:

> When unifying the SD/eMMC boot behavior between the different AM62*
> reference boards we missed enabling SUPPORT_EMMC_BOOT. This causes the
> SPL in tiboot3.bin to look for the tispl.bin in the UDA partition in the
> eMMC and fail.
> 
> Enable SUPPORT_EMMC_BOOT at the tiboot3 stage to load the next boot
> binary from the active boot partition when in RAW MMC boot modes.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: am62[ap]x_evm_r5: enable SUPPORT_EMMC_BOOT
      commit: ce19a4af0ad175f94a1d3dca56f10e1e0f37ee73
-- 
Tom


