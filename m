Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4B1D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 20:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC91883DAE;
	Mon,  1 Dec 2025 21:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pfkupPrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C4A83CAA; Mon,  1 Dec 2025 21:08:31 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D728483D92
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 21:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c6da5e3353so2756621a34.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764619707; x=1765224507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIrc2gAY/IFyVDWLPjnEv3PYAZnvgxNFqxQZd10speQ=;
 b=pfkupPrSsmdUHUGi4Q0OyZYydSEaOQpNP4Ry7xZ9dL7JxqcyPlp03zkHxqUtQ/03n1
 8OAov3cVtHQShW1OSOemT0QV7t+nvQPhh/4LgmNzw6cZmRoGTyZoNHW11x6PLc79W9tF
 E4O0PCNcCexAA7idnbvAYw4+Oz9X6s6pNEzh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764619707; x=1765224507;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SIrc2gAY/IFyVDWLPjnEv3PYAZnvgxNFqxQZd10speQ=;
 b=wkRYiphj3erk5r5Z5qXAxGfk9H4Xi1N6pQYhgx8+e/9H5ctkiZ0uVCMmqIKACymRJi
 W1hZLrpyq+BcQ4cLCZBoDW0AWY5HbPw1aV3OiX/s+1SFq2dPLQRkM6NOMS3qt1IXJzgt
 QRMu8vqmA4lHlUUyf6nAXGTVXY7NQ3kmbLGqkyRs20Ysg/GlcnFDvtZpf0SX0GlJVqhC
 Zh8ypiggCLtIkzKCFg3Hf5C8Fx1lwCfBm0ecQGd4lVzrke2XnpvrwkLKyS/YuDYR2Pdt
 SQ4GHmC4uMfT5wfwxw6rCpNYG7SwDbFHlA2+Aiw3uU5bYm9UTbUCbAztMSwg8rQpL+c1
 XV2Q==
X-Gm-Message-State: AOJu0YxlY3LOOxssWOoVlYZAyutpbYRjgg6JfyWLZYeDWUN6NN1efvoI
 IL88HsHIhiOmtQEMHMhnfKay9CxGqgMsKog818XQ8GBj6JfFo+OAW/Wmb3UIWtyDYVI=
X-Gm-Gg: ASbGncs4nbo3YcQLRhBXX/vtA47rPDRrfjmLAU0Qa4DfjqhtLDb9XcUhXLmmMGPkbc4
 iDIk9ksil14iH+YodM66Q0J8xhpMUUgmMAx1pCc4x+8/9bTkY7Bledc24NaP51T9whHEhRybwJN
 +hUbNduzAIKHsWUN2wBmhtqZ7YJaxSJmKbTdeU6xGXGMPOxDRB5HOt+Uy212wQoHHQ8kUcSDLQq
 HVv8P+HADFxILcaVmC9LezfNtKcrxRfvf2+PUBgr2fVhVK7YAaFnLSsFIF+pJloD4HLhyW4d7R5
 ORK/hr6BbbSiG0sTD53KgkZZgxAveSPdOkIY5HffmhUQD6ammZ8Eti3zkKgygITiTJBjXbruc6a
 +M1xpP/62KOr8pEj47FCV4AF58Z0s5HXvtaBX54TCsJtoMNd3UopbFOCvI6zAN+uXIekCTxgvL9
 NnVRkOrRJAlhtVntgpczugKv9fpzLKq3IavR1ZwEE9NhcTtK0p
X-Google-Smtp-Source: AGHT+IGTIGhcp1j+1g0Jicsit694j6xne5d3fmWOiJ7ZOSucLM1Et6IXV8cTIlIgnIXrzZk//jJYww==
X-Received: by 2002:a05:6830:6e8d:b0:7c7:6752:2d8 with SMTP id
 46e09a7af769-7c7c4422b5emr13944082a34.32.1764619707576; 
 Mon, 01 Dec 2025 12:08:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fde226csm5103402a34.19.2025.12.01.12.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 12:08:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <d84da9bc-2aa9-4222-9fe7-73095eb11e9a@linaro.org>
References: <d84da9bc-2aa9-4222-9fe7-73095eb11e9a@linaro.org>
Subject: Re: Please pull net-20251201
Message-Id: <176461970674.2272036.4658685563690701193.b4-ty@konsulko.com>
Date: Mon, 01 Dec 2025 14:08:26 -0600
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

On Mon, 01 Dec 2025 11:21:51 +0100, Jerome Forissier wrote:

> The following changes since commit 31bf4a1c308773895a8e7ea047b3cea037e4c922:
> 
>   Merge tag 'rpi-2026.01-rc3' of https://source.denx.de/u-boot/custodians/u-boot-raspberrypi (2025-11-28 08:26:44 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20251201
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


