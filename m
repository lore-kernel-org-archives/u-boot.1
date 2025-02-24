Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25ABC021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 19:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 151BB805C3;
	Mon, 24 Feb 2025 20:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RiUxEUV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A2680F3F; Mon, 24 Feb 2025 20:55:36 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB41880017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 20:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso3652667f8f.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 11:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740426933; x=1741031733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsjwVIyW0RklY+BkHj7XeSOdzz3X+VS3AebK9Z13sXg=;
 b=RiUxEUV2xBVy4jTPa+LU2wLBX6xPwh7CWPxiB6BhnU4MBzJuWU5VKCj7QGXQrxS0iy
 eizUWf4NbS9NXFheRX5BPJpub/7zJ+aQoeS2zV8dE3kpg84RPlysnnSN8R2+ORI2IjDn
 ZSP5SxKpo2cMlJg7CaFnLWW15pkaeAfGNMzyT/GpCDLW1+u0Ydp6Dj4rhqT8bM61RTO9
 rSU7BI6GEIrcANEAFT3rH/XeS1sWUabkVHl9HLrSoh4bvsjsSCzn1RFWvSESi5pc4IRK
 axCvXKb6zU9fdW5rgAQ99WoJ7UhmKBi3aNs1pR91YOdUcYKIoXSyXrOXeUpQIxqGW3cO
 mbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740426933; x=1741031733;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gsjwVIyW0RklY+BkHj7XeSOdzz3X+VS3AebK9Z13sXg=;
 b=KyExJlfdy70p63SK6Ur1d8UwRoKPP4loQS/Ducmpy1XJMnjecyXXrrCaZsZNF08hKG
 VExXp1+Ly4f7KLsNismkX8+fDe8dohlFf1IXQA8L6vIA10aW0ooA11RoqlXdEmNlhcmd
 yxGFnj1wQQl4vNdjvNGQGaaPTKrqZy/b8oxdOi95ZzJzfC2bnsbpKdH6yYrv5LavH1e5
 A1nBwAzQN69tKGHR0s6Hl+bznSYMKqUW1sOq6SvjePkyzpO0kV81XWDQFHcyIngfpl47
 AP9bbQK2HZHqTyid3/EuQb1Qql9Ispyp0M44sf6WZJ6QBGaZ+ztGSKE7UxORMoV1S1FZ
 yzCA==
X-Gm-Message-State: AOJu0YyH6j7QZKJ8An/oiv6IL/gRHS0dxOy9S5bOffCOb6FspXRhZgut
 SbZhr1+N0UWNqyBsiiviOhmb1/1esukHjHesD0/XF2HMBzvhwWGU+RP0rUBqH3M=
X-Gm-Gg: ASbGnctk0R5tbpvvN+YTSFX62hu1WV83w20FVf3xqCHw5iCmhd/QYwXNw8TMaN3nb3A
 26s8QkeNSG8YyqmsVkZUzLiKQuJ+MRwbgR3ZQ3UFjElaqU5CjYSw3cwif//Q0h0SNaSFzszN3eN
 RvoyM7DkW9SO8EyCu+MKuCfpGirbtIsaJoFUJcyCOdpeWXJdOIT33v7x19h83ZVPl7iEuUuXA1F
 256NR5AaWrgFcB++c5jWiCVd565VlFx2nmxcIPiwqVxESbfmB6ymcHs9c/Vgv136yzqtKBwZNc0
 +08JP589NloGCFaQWwroCqgWkps/qZUvDEPZ1ZfwH4P51dc=
X-Google-Smtp-Source: AGHT+IH8369Zb5qEoDqgPCff4afkwCWfcJRTJMmuYFh8yKBMnpemj8ycrWRgOb4bYT5bmEApqzZJ2A==
X-Received: by 2002:a05:6000:1f87:b0:38f:3224:660b with SMTP id
 ffacd0b85a97d-38f7079aae3mr10337419f8f.22.1740426933176; 
 Mon, 24 Feb 2025 11:55:33 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d58f3sm32417836f8f.73.2025.02.24.11.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:55:32 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Baltaz=C3=A1r_Radics?= <baltazar.radics@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
In-Reply-To: <20250110111335.9221-1-baltazar.radics@gmail.com>
References: <20250110111335.9221-1-baltazar.radics@gmail.com>
Subject: Re: [PATCH v2] board: odroid-n2: Update docs for signing
Message-Id: <174042693241.751150.12654581157570837012.b4-ty@linaro.org>
Date: Mon, 24 Feb 2025 20:55:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi,

On Fri, 10 Jan 2025 12:11:24 +0100, Baltazár Radics wrote:
> The previous instructions resulted in a bootloader that wouldn't fit in
> an MBR gap. I have updated the docs based on upstream's build process.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] board: odroid-n2: Update docs for signing
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a2f995ec5c0cfa4876ad98fefb8603b24d96efad

-- 
Neil

