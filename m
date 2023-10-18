Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482C8CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 07:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F59A863F3;
	Wed, 18 Oct 2023 09:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mRNlOxxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A5686F37; Wed, 18 Oct 2023 09:46:33 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B062181F54
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40651a72807so59723585e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697615190; x=1698219990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBoXn/+8/BGTauLZ3Q8ZA9tqIJnqJBSZNk80IvPu+Ls=;
 b=mRNlOxxltLTUSb7+JBixkQCYGTsXhoZmido4qycaL7IM1F8zVdmvDW/aia/jr9pcgE
 opDDD8dYTZQ84E05l5wnv+oP0NZCXpnL0XEJRoQLgwazq540lwzhd/QbXqL57qh7Yk2v
 59OnyaXnQOhOkNAZP4qOrUOBRr1T/ISWptl/r4pbcJ+tBvO1HxVMO+J1yZ3ZPTZiuVvH
 9P7uqgG+o0MgofFtxm7hZveQoZXjZwzfmUpX+Px5wzHVnMmX+CIZ2Td3iFyhOjIHs1gK
 hT3IX2toyd3y7SZuSI9EXOb1InJtsUEDkNCy+srzZ1p1YKViLI/ukHqojoKRQVyyRFOe
 tUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697615190; x=1698219990;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBoXn/+8/BGTauLZ3Q8ZA9tqIJnqJBSZNk80IvPu+Ls=;
 b=k+FV6bynWHvPWuq/z1zjqR7FENQQ3ajt1ueEIYl9U57pjlX5X6z7yYSgGPo7gpKD1h
 LOhP6Abjb7yMgTyAUhHfoIp+l282DRnUMGh3gOksDovef9xDuyHqn4B8r5QTj+h615x7
 1RjQXF5Zd4FIrVgI7Xe6B4K/NiS7RS+Pae03F66ihn5nQsh9NfemWxHCY7WW7iLzYqPy
 2yHpVxKl0svqkOte4c+vVfU6QaK7Ke6BPe1k2HIGhCupQkp86jRh1BbCjsExvRr9zL94
 Lf9fx8EOqXdutT3nQt4yniRKmoNX8iJAj8YmBUXDN0GWLjxM//q+3ALNWqBy6548SnLw
 zfIg==
X-Gm-Message-State: AOJu0YzWbwLHu0xPIziFc4ecBv+PGFQurCRy0ZyERBi+LvF0Nup/ZIHE
 I4DHl0BswA0UaM5UXzCdpfzcsA==
X-Google-Smtp-Source: AGHT+IHIuncde/euI1ScFE2pyQcKh3cbNgqemPV3y+QR/993jSZprTgr1BPIAYfS2RjRGvkrVpxFQw==
X-Received: by 2002:a05:600c:a48:b0:3fe:2a98:a24c with SMTP id
 c8-20020a05600c0a4800b003fe2a98a24cmr3336165wmq.26.1697615190070; 
 Wed, 18 Oct 2023 00:46:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a05600c218700b00407efbc4361sm941509wme.9.2023.10.18.00.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 00:46:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 avromanov@salutedevices.com
In-Reply-To: <20231017185725.809524-1-glaroque@baylibre.com>
References: <20231017185725.809524-1-glaroque@baylibre.com>
Subject: Re: [PATCH] phy: meson-g12a-usb2: fix ret check on
 power_domain_get
Message-Id: <169761518944.2954297.16595176249313373535.b4-ty@linaro.org>
Date: Wed, 18 Oct 2023 09:46:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

On Tue, 17 Oct 2023 20:57:25 +0200, Guillaume La Roque wrote:
> Patch which add A1 SoC support create a regression on khadas vim3/vim3l
> boards when we try to use fastboot command:
> 
>   => fastboot usb 0
>   failed to get power domain
>   failed to get power domain
>   No USB device found
>   USB init failed: -19
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] phy: meson-g12a-usb2: fix ret check on power_domain_get
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f699cb1dd5f4c55aa3f593c226ec797730d02f10

-- 
Neil

