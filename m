Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCC1C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 09:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 986F586B4E;
	Mon, 13 Nov 2023 10:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z2qJREti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDAC86B4E; Mon, 13 Nov 2023 10:08:08 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ABF2870E2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso29609775e9.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699866484; x=1700471284;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aaj0ZL5yHRLyOO1visOwlOvCZ9ES+mw1s1GzoAKIoE=;
 b=z2qJREtiA7f5WEBlqqpvg7zyrOF+dOi4NZZ3TApGITLrEeg/XqplXq6nEZZnIy7jz1
 Z8347Cn4CP0dMc4KBY39jciPsADv93ecP4QQsdcipgEiCK4PntBDQ1KJBay3EKjkUm2Z
 ZRHpCw/p1ygYksVkbyU9a36ZQABjvFIF0277pUELZsiex7mYFF8ipetSTCrmwsbjvCfl
 yhKEtbNsuay8qqiZRJ09n+7xToWvVioKe7AWjwoZhZWCRepLP8MIljrgZlmOoGEq4H0D
 OAmoFhAsCgAM6HLbqIKHEqzM47CdXTG8iGy32ZSrp9H1/Lz0LcH4B577SsL2DplzZqRU
 LDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699866484; x=1700471284;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5aaj0ZL5yHRLyOO1visOwlOvCZ9ES+mw1s1GzoAKIoE=;
 b=r002xJxuHDhkYFfasI6KRRJaGFG783hz6hXmUNd+DFzb/EAOVlCbSb7aYeGICwnPJ4
 rgyIKwcNaICkDN3kj3kqjLIaD3aF7k0ufJttd0AnflyuwhTDzkP4/ChVhsmeLWN2S1Mz
 Tf5no/MsU5o32f8BDfjydF5bB8GY1kS31jLijHQxvzqc+LuhmK+0HNfD1t3C149UZd53
 fE2KFXWLHQELmaOY3q321Xbafe0AvAu3cb/gSpUiy9t60IGBVkR1vtwvKY0HQutDhYc1
 w0/tmF/mAgEi8bZwcn+B76I70iUG2BehcrciPO1QsI4RsPOIL6CHERUQqlmAPABpopyQ
 xhhA==
X-Gm-Message-State: AOJu0YzxioLFgKEN9EhYHTfSzV85JWJ+GQ2yT9ZZ+NZYiyUI3CeFOEsJ
 tExGcu1HElBCQ3Bpn1kFTOKNQvCL0RJQsxZUtKg=
X-Google-Smtp-Source: AGHT+IHve8X8QHV7DjBURX7bmdjjGhdq5PvCSJ5aI8pmfUwtTqS/4uwhFUQQ+P4ZpgoQGfinmcYtlA==
X-Received: by 2002:a05:600c:4d1e:b0:408:33ba:569a with SMTP id
 u30-20020a05600c4d1e00b0040833ba569amr9139386wmp.8.1699866484227; 
 Mon, 13 Nov 2023 01:08:04 -0800 (PST)
Received: from [192.168.1.26] ([2a01:cb19:85e2:8300:253d:7bb2:1f5f:7eaa])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a05600c4e4a00b004063ea92492sm7434919wmq.22.2023.11.13.01.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 01:08:03 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>
In-Reply-To: <20231107001018.55640-1-marex@denx.de>
References: <20231107001018.55640-1-marex@denx.de>
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Stop ums on START-STOP
 UNIT SCSI command
Message-Id: <169986648347.273064.7806748758640900099.b4-ty@baylibre.com>
Date: Mon, 13 Nov 2023 10:08:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4-dev-6aa5d
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

Hi,

On Tue, 07 Nov 2023 01:09:59 +0100, Marek Vasut wrote:
> Exit the UMS handler loop in case START-STOP UNIT SCSI command is
> received. This is sent e.g. by the util-linux eject(1) command and
> indicates to the device that it is supposed to spin down the media
> and enter low power state.
> 
> This effectively adds support for exitting the 'ums' command from
> host using 'eject /dev/sdN' that is on par with 'dfu-util -e' .
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: gadget: f_mass_storage: Stop ums on START-STOP UNIT SCSI command
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/957e96e9fcccf26a2fe4101adbd6681578346460

--
Mattijs
