Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CA3C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E5388AB9;
	Tue, 27 Aug 2024 20:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A3oe3cyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9AD885A0; Tue, 27 Aug 2024 20:35:52 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3CE788AAC
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70e00cb1ee7so4159902a34.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724783748; x=1725388548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wI+9bW0v3grLXpltpIq7Z8rYdc35NTCUltyyFAEOyhQ=;
 b=A3oe3cyIiDrN/9czSI5Y8hjz7hKvTHLB8xGSEr6a8LCG41hjRWJZntTsHUKb4Z9Gyt
 E7vBSQ8fYcXLspJYdb3pzIr6HV5X/hzGU32j7oUoWcktDVSpXyVgKBfsD30TCfewkMZa
 rgfvTfn7RQGT4LcQdZECU/RnRV2wy1HM3Ux5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724783748; x=1725388548;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wI+9bW0v3grLXpltpIq7Z8rYdc35NTCUltyyFAEOyhQ=;
 b=HJVRYUFAMO+bHdq2rW4XPhf651W21wK84lGvWC3hH6EtjiDLh2drbsM4FImELycU4l
 RtrIK13aUy2V5kxWYUGlblLdAOJm+UxlrWd2NHKSlZ80yeoF9JvjP3XGKiezoozEjlLG
 N9F7HTJnXZc399x/HhxRWILK72BpuX5OtUZLe/1iGFxZxdT0IW+ArRoJ9g6buLa4AomY
 vySAGudFUHpkNLu9Z1xYOlrbEhl9XQA0BCoa05gyR/g58nH5EgSKf57h409iMvt2/g4I
 xoWMp9eneDrVHUKwucCR09voIG8jpQ96g7dy9zcmoImHmVpNiZm2WTZfcA7kwhKVimlt
 5N9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKg2NdfkivUfP01H+xKFtCQL+Yn24mMjHd7n6kljxcCC6RjhWyhLjmctxD4FNBYhUIqWCM/Zk=@lists.denx.de
X-Gm-Message-State: AOJu0YxFfSZACtejT41sFpbV+YZwHNMPCFz3QzBiT/5GF4te4aydJPLL
 skdT4Zvlr7TdsrJsmzYimzanQoeZeHYnosyy5c9Jj6Tvs4f6Nm8ddZx0Fa6ayFo=
X-Google-Smtp-Source: AGHT+IH2qOaw89qtf24iUdpeCIzzm7OB7mLvB5hedgKrpn8RNPk3Kd7sTEdQbBLlM7sMCm/Tjzp2YA==
X-Received: by 2002:a05:6830:410a:b0:70c:a521:7e5c with SMTP id
 46e09a7af769-70e0eaf7c3fmr16016381a34.5.1724783748529; 
 Tue, 27 Aug 2024 11:35:48 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9c9asm54635271cf.89.2024.08.27.11.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:35:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240816023822.647717-1-seanga2@gmail.com>
References: <20240816023822.647717-1-seanga2@gmail.com>
Subject: Re: [PATCH v3] sandbox: Fix pinmux warnings with non-test devicetrees
Message-Id: <172478374762.2927671.15073909266335327950.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 12:35:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 15 Aug 2024 22:38:22 -0400, Sean Anderson wrote:

> The sandbox pinmux driver is used in the non-test devicetree as well as
> the test one. I didn't realize this when I modified the driver for
> tests, and so broke the regular use case (which only resulted in
> warnings). First, making the pinmux and the UART group available
> pre-relocation to avoid ENODEV errors. Then, convert the pin groups and
> functions to the new style, adding onewire group as well.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


