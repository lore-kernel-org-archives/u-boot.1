Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD64C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 12:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63950880AD;
	Thu, 21 Mar 2024 13:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dmvKBRYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A642087D83; Thu, 21 Mar 2024 13:15:13 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9886F87BAF
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-690b24973beso17583946d6.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711023310; x=1711628110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLWz9XUuIgoEsnf/dqbcRenET2yZFBT4EWuesCQwDq4=;
 b=dmvKBRYbEkuZ2QLIRSN6WkPp78snMCQO5YPoAbpY5YHq5jngCqg5cm9gy2MdRxXRom
 lWPKPBxKyAroQbnnSR84kgb1b8EvjAjfcEkGojRld3Zkw9FFtqg5ffDbaAc0luwpz3D7
 V6cRIxt3UnzBuAfhhW2nHwydzut/fQ40P8USQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023310; x=1711628110;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLWz9XUuIgoEsnf/dqbcRenET2yZFBT4EWuesCQwDq4=;
 b=GZMyXJyUM2m3ayx/fP/baN7vgTITjQzkbzl0Ec6MgeZYeWx/fCICBFfbuz7VNQhA+2
 ZJwdwfBsASfOKE+jowj8ePpQZG0Agke0KPzQE5keFk1zLY9xnD+HmuC3M4WDMfT2vPSa
 UHvjiaVRTX9hwCZgvjspDqhw1SGbXuL7PTnFOl7Nf4zr7c161V3tlyxqhxlhDtii4R0g
 mgOzWKg/lxytlT1JecVoCY7BspVtsmetm9iGcXYb4B8rE/hZmXPZlQcrmRo4WunQm8ZR
 0PRnHGzf7d/2XRbLsiWaZPsxoV3r7uDhOif0vECEUAob8pqheQHAHWnd9CYxyjFKuzER
 6WzQ==
X-Gm-Message-State: AOJu0Yx5wJZCmysbjdY95mjefJrogvScAUCg/zRuzewDg8ihYXXq6ZPB
 KUUZA7j5mTpBJ/K1DP44eD7RJNX9Mu5zQ4SPyETlr/YJEyT5GYIV/nePgnlMXByk9nGfE/JDLro
 h
X-Google-Smtp-Source: AGHT+IFM/apX/8iCFrpfTlJ6zFjwpLmjrohlpqQfdo+CjSitCwd47/2MzCJYwCcCyeaWG0Y83Zs4Mg==
X-Received: by 2002:a05:6214:2686:b0:696:44b9:1c71 with SMTP id
 gm6-20020a056214268600b0069644b91c71mr4139138qvb.22.1711023310570; 
 Thu, 21 Mar 2024 05:15:10 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 kj25-20020a056214529900b00690df461ecbsm8990690qvb.10.2024.03.21.05.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 05:15:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
In-Reply-To: <20240318150318.8292-1-marek.vasut+renesas@mailbox.org>
References: <20240318150318.8292-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] Makefile: Add missing OF_UPSTREAM Makefile for 32bit ARM
Message-Id: <171102330961.1913497.7402328675082932276.b4-ty@konsulko.com>
Date: Thu, 21 Mar 2024 08:15:09 -0400
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

On Mon, 18 Mar 2024 16:03:14 +0100, Marek Vasut wrote:

> Copy dts/upstream/src/arm64/Makefile into dts/upstream/src/arm/Makefile
> and create a commit. This makes 32bit ARM buildable with OF_UPSTREAM .
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


