Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36541CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A8F83DEB;
	Fri,  7 Nov 2025 15:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PTQmtPPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECCF83DDF; Fri,  7 Nov 2025 15:17:11 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643E083DBF
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d2ec149eso452919a34.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762525028; x=1763129828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wo6UZEbj37BySQV0fP8hk5m4Lo8ndGR05gWYAfTrVdk=;
 b=PTQmtPPNVP5ygkjcTh3WHr5Td8i/nUO5fxQra0vFRs36e4K9qzUYlIJ65SPQja9UUZ
 99MJZ+nuqoU9atoROgm7Q8UhUyY/asQcXtgbXom8PRdb6p3W4Tmmq4Y/i9r4tHQx+/kN
 NjvX/GCo4JMgYQMb3GHkmb4DOe6lxSqziwaUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762525028; x=1763129828;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wo6UZEbj37BySQV0fP8hk5m4Lo8ndGR05gWYAfTrVdk=;
 b=reVtTTM3YbhRBSVQsXp7D474YcPca7hpjVuzow+NCSr2E9Wy01sM4YmRu918Pct8Oh
 UysVRw9vcW9NylgIOD5/lanSnyCzdWkJJybwatSpNiHsPnKfnkNtPsrddlHu011ELeKo
 nsbitmscKODzd00hSx6MOHxp019UdV/mtnBnW8SZj5PHNp8gwYxuEYdH3QsB/dYkO0aM
 Znw9x1l3lhYd6gjo8L3J1kTC7uuZAfRSD85kQzeBJNQjUfh0b8RzeOMBaFLC6MIDGSAL
 dGCXFL/D9xNS1ZmqlBnCNJdhW6LsujRfIau8SMVpiQus9YizWkyZvHQqJRarlSmbkb/z
 xzNQ==
X-Gm-Message-State: AOJu0Yw8pEES4wjIIJcYv9xY8cJ3rT2W0b4b6jDjjw0AcNS/wWuoT6Cw
 BHcH58VbWbKpCcGOldpjZ+maA03vCkiTOqDB15n+qDFNqFEwnb7Yw2f6X9BU39Cz2SY=
X-Gm-Gg: ASbGncsavAla1iSNqjDi5M+5pU0FsXm2IAsGl3gjONhlL3HRAaYJRPaFp7RG8kzm51l
 ScvLIMtE6bIOIVxNZR3TiEBDxpL1dw7q2LUHPZf59pkTr9H2T8g786KZwnHrs9dg0G0cKianfKP
 qCCFHGOhyS9uP/lDHBbnXm1PenJLL0A++nL25B0ptd4YtjU5tgeN6W+jABp5SJKE4ZXg8SoNQjV
 1wAndVNlf45SnEIYxhgNmX5C/9TMOzVCuPfEjvvxgLGY5IFnANK+P/LZZqnFwIo5v5SdLNteSwx
 QkAIqj2I+zk34mef/mNjrBXiG/A0fANhEdUTFLxwn1TM+PnOiwcrtVdDGgMkxyGzCKWswxGxi+I
 YWG7pmr73fWsY/PqH8dMeh1sKeiQb+XOIb3gxBjIXBmAg5w4mgta/FllvtY3ovl7Yn7MPn2Aa0x
 8lkh6TZrttqY18DBmz3OC6KP1K9fdxBT/XHplAvg==
X-Google-Smtp-Source: AGHT+IFlVb1ptoQsObackPiEZjoJ5vglewl0PSXKTkAeR5j1nnauZkRV6ql9/mxvOxi1KzCVzP7p8g==
X-Received: by 2002:a05:6830:8495:b0:7c5:3663:ae04 with SMTP id
 46e09a7af769-7c6f5a3bd98mr983783a34.15.1762525028134; 
 Fri, 07 Nov 2025 06:17:08 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb8dsm1479692a34.6.2025.11.07.06.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:17:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Martin Schwan <m.schwan@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251029-sys-bootm-len-typo-v1-1-5f1858d9e80d@cherry.de>
References: <20251029-sys-bootm-len-typo-v1-1-5f1858d9e80d@cherry.de>
Subject: Re: [PATCH] boot: fix typo in SYS_BOOTM_LEN description
Message-Id: <176252502731.3410992.11976114356326232712.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 08:17:07 -0600
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

On Wed, 29 Oct 2025 12:19:14 +0100, Quentin Schulz wrote:

> 


Applied to u-boot/master, thanks!

[1/1] boot: fix typo in SYS_BOOTM_LEN description
      commit: f05576620c54f7465a2dd0ff5c3d8d56744ef31c
-- 
Tom


