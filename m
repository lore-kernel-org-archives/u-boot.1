Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA21D2E9EB
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 13:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A84A89003;
	Mon, 11 Nov 2024 14:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q3qrm4rH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB0D8904A; Mon, 11 Nov 2024 14:24:52 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2137988EBB
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 14:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3e60fca5350so2595617b6e.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 05:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731331489; x=1731936289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+7GRuScpdC1APNwfIHu+0MFZW0x3AcOmcgL1KD553U=;
 b=q3qrm4rH5qPdk85qlsF4j7fGQEB7WO8+eIOXlj7zyZCxStIlKKWGjszKgGDw2Z7Pm/
 GIK61dCgTmJM+Xwvgig2zb8e2ZYaX4WPFV1QH6bJ4akne9eef7sOXL5zwrg3FWbd9cpZ
 KPzEDAV4tzlw84JIAhJpo8mKOMp+pOcVoPOs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731331489; x=1731936289;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+7GRuScpdC1APNwfIHu+0MFZW0x3AcOmcgL1KD553U=;
 b=BH94JmG4eXXutXt4LoilNG6UuxnpDdsOMmMSRwIUfJYRefwNAMMGOMXv3sls1aJ2SS
 Xyry7haJR23rWerWQawN0iZbV5aSHpbAXlmdMRScysp5IY17PmTkCAQ+XGG3hHBJ8YtT
 R6FwOooLTdrHOH/7PLi3tgy+cdm7Gt22gWcXBkw5CN1vapZAwct9rNrBy4FObCdmBOcj
 5V0m60vbxlpDCxg6O1eWLkLz6AWq3imk+Pf7eO93YYCRumM+vWYZ9XQct9K9dg4Z+EW1
 iFS3+p2dwOUFdi430XJLFFqr6ACWYAaDSlQTlLMMh4riBCgaaSTCnDtETb6B3vsVh0cC
 SNdg==
X-Gm-Message-State: AOJu0YxIlfOvynZm8aP6eg4hJDqQDx9d6YMnfSl7vBEUfSyW3lqJ2fYD
 jnjKf/pAdvl8eEtVPetgLTDZ6WUKzSM4x8rXAjwZXmdf/JRgYKl0fyT7ZVVwpQ4=
X-Google-Smtp-Source: AGHT+IH+jE6Hj6FRHROK4MDGEuIZQPKPe4OtmGC6MzGKZEqBsW+IBNByl9MfxerttWxkTrHuEsOSBQ==
X-Received: by 2002:a05:6808:1701:b0:3e6:3eff:30bb with SMTP id
 5614622812f47-3e79468f7e8mr10888092b6e.9.1731331488880; 
 Mon, 11 Nov 2024 05:24:48 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396630e81sm59512166d6.104.2024.11.11.05.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 05:24:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20241102235754.74661-1-marek.vasut+renesas@mailbox.org>
References: <20241102235754.74661-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] mtd: spi-nor: Fix integer overflow in stacked memories
 support
Message-Id: <173133148676.214395.14221833706182053510.b4-ty@konsulko.com>
Date: Mon, 11 Nov 2024 07:24:46 -0600
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

On Sun, 03 Nov 2024 00:57:31 +0100, Marek Vasut wrote:

> The 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
> adds new SPI bus flags, but also introduces a completely new set of
> SPI bus flags in another location. The existing flags field is type
> u8, while the new separate flags are BIT(8) and higher. Use of those
> new flags triggers integer overflow.
> 
> Drop the newly introduced flags which were never used anywhere in the
> code. Move the one remaining flag which was used in the correct place
> and change it from BIT(8) to BIT(6) so it fits the u8 flags.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


