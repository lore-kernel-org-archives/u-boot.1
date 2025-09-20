Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC33CAC5A5
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 17:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE3D83211;
	Sat, 20 Sep 2025 19:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fECpzOcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D517D83211; Sat, 20 Sep 2025 19:47:28 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9488B8004F
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 19:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30cce8c3afaso2723528fac.1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758390445; x=1758995245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mD6fclQJhJXGsPK0nPz3aTH0mR2WEHN4nfWgms9g4lI=;
 b=fECpzOcUyIQZtQNiISpZwaUEFEzfTXh4FO/m6gU14Fg7Q5Db76nPRhIR0/2R0hsPkX
 th/QjN0yoL/rKt0xIAq7AgYasWP3loMWmSgbDQEhddTJe2I63JCoRCrC4pwlJxYm1jS9
 CP+EZdhQQj87XNuRnx3tVILaOmL7zDCQjt6pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758390445; x=1758995245;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mD6fclQJhJXGsPK0nPz3aTH0mR2WEHN4nfWgms9g4lI=;
 b=DrJ+3L0Ekd2q/cBdDB6ACJHYywWOkXWGsAtFudAiFCzcO8A9plwoBAxGSSAnSndtZE
 OuEmoWzDxIKVhtxIYtKDlecvifESRd/qXO6hAF2MEUO4pxvdluVMpePpeC9Zd7OALX/q
 cUMDv63lhKJjFtqStZlsDQu7Z0L48/b73rBxm2eJz3n1cyGzhDpR9gvjH4O1kGSxQ7YF
 HXxS3kvlJhdO9aM4LOcks79v+lo8b70NA8ZmMdvOnFtqnXGCL/Zu/ZkF3ncs6ohpZ34v
 Kh4/TnkDYJ1Z/EE8Z1Dqp+qzI6ptQocWQKHMpsakW38SX1sxUjL7Oeoen1WCEq0aHt/u
 VdaQ==
X-Gm-Message-State: AOJu0YwE+foIPIAWmgO7af8KwLLExWh6S7UrGJgjluYfJK38wNUCD6hT
 ZE6/m0OQ0rxL3sWyQaNgR7DQPCrZaeJk/SPqLDWCAjrKEgDm9jH/IADLebYBMESq78YPMxVmBhg
 CNqhjq8w=
X-Gm-Gg: ASbGnctGoczOTBMl1oSq9gf0kKzN/s6qvZENzDG57CewTP7iaW1pNe9fQBMKYI/l8P1
 hSu6Lt8JxRSC+K6cDilsf/pS0l5b2dfHwmdQUtMLrgI1TnF9d4YZTm+Pd4gwaOR9TeVxRzh5U9G
 0qWB5YBM6uPowseC3QkxnCm0tW8SSATWtuw2jMgXOPGFujIO7U+bgBVRbXXWkRA4ImDQm9aFgpK
 9noHohFxguURSnqi8jz2d+UIBtDuk4yIC2d1qYkKdy17awqbhC+7+d+PAu4kMVOQgJMrsfoJkXO
 klpLYUZo2m3OW14ChEs+/B9dKSs58PEj2tZdL/XKz3XidfdbHITCtFobmTAqDgfXNYvEQ6ywZ6I
 kEcOhIDCaHi8ySysv9WEVIxr5PG0stn1x2+zv/+flB0JBIBtnjdn9TMg=
X-Google-Smtp-Source: AGHT+IH7UbYASGwJx9DLUOzM6e1WpE2eTX+Y7453RO9PDF8kTCAlk524+o8qBi0IiJTQssgyy0I/wA==
X-Received: by 2002:a05:6871:781a:b0:315:bac0:c47f with SMTP id
 586e51a60fabf-33bb3ee94ffmr4398761fac.29.1758390445250; 
 Sat, 20 Sep 2025 10:47:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e5a2b361sm4889395fac.16.2025.09.20.10.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 10:47:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ggiordano@phytec.com, d.schultz@phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20250909103654.3341398-1-w.egorov@phytec.de>
References: <20250909103654.3341398-1-w.egorov@phytec.de>
Subject: Re: [PATCH 1/2] configs: phycore_am62ax_r5_defconfig: eMMC boot
 from raw offsets
Message-Id: <175839044416.1370912.6510287012684400431.b4-ty@konsulko.com>
Date: Sat, 20 Sep 2025 11:47:24 -0600
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

On Tue, 09 Sep 2025 12:36:53 +0200, Wadim Egorov wrote:

> Enable CONFIG_SPL_SYS_MMCSD_RAW_MODE and set the offset address to
> boot from raw addresses instead of a FAT partition.
> 
> 

Applied to u-boot/next, thanks!

[1/2] configs: phycore_am62ax_r5_defconfig: eMMC boot from raw offsets
      commit: 6f79e80079aae24d2fbcc73185a5a35fdeaed3bb
[2/2] configs: phycore_am62ax_a53_defconfig: eMMC boot from raw offsets
      commit: be5715f9aa93341fb01f870af596bfa37e137b91
-- 
Tom


