Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053F7C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F34E8393D;
	Thu, 24 Jul 2025 23:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NrowSskA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646918391E; Thu, 24 Jul 2025 23:30:39 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D42838F0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3004ade907bso607607fac.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753392636; x=1753997436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9EpQl5ewSq2DdHYWrpYtqYkwCFgdlQqyXPY608RLgo=;
 b=NrowSskAYaxpskp/gFxNXxFzx9RaqAVt0xjg88aR2Sgt/LYz6sYsRhVqlseTqybNNr
 Ou9EGKEviL4auYdwY3qQDMYYbT37gc6fI87JISgAsK1mhniemg4gyH826Hk2w1fWbBEC
 s+SnkoIuowU235yGj0v6LSROC9jVz0qiVBwSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753392636; x=1753997436;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9EpQl5ewSq2DdHYWrpYtqYkwCFgdlQqyXPY608RLgo=;
 b=pxK/lPOgpUPqzv6UH6pG/y5ZPh2wzFv9vF1FT8K3i/cd6+/PO+eeBkQ4YOQT9krrfS
 dSwAmfF28jZ4+3Um/igI+2pLdobs+vLExdBEjEGXXIxS1IcYOaU5OtcJ5tiBrQt0Z5G+
 DKf8/QQA9t4pHQ1YuyINWv7qK4cf3LFJwrwr1DAGGrhDLgDamMwDM1FjYJJH3uP29X+t
 ckaA98fvuZNGCl0XX5bvig39s2UBTof/Vq25toVBntXIrGNwfxv7cFNdTn2hxD+/XpUD
 Nu1WfntK6sqzS3pXpJ24cD/IAmixrcBBRbHydt3p4X3M0HmsY3bm+bYVMubbL5Vmu60h
 joQA==
X-Gm-Message-State: AOJu0YyCc2HAJGZT+L/rmlMqPMI3UU922P8JUNBBrQo2L/nNOzks7L3O
 nqzgxomctnHV6mS0RVwAHi8e64AnKeZhWbi6Ivs96vyecqb5VTO8NO3sJaJwxCq0ppE=
X-Gm-Gg: ASbGncvqUW5ldN+eQnOzrRomF9/araQ9TWVMtSWqb1DduLjmRte/IoB0w+kuValTJ0b
 dthVSAuoZahFknwpT7mw9uRAHnebs2eYfhNiKYkrBWFFxbQSx8ugq2zKyjZ2kC0JlMhMsq0KScT
 jVJWQ7BNVraOTi7Bdro7C1HoeNjMa7WDaFaDMmrhI1pU8Cv5Uz4zXhLjSnCGAUI1Wm/FjjFb/uV
 m/aeixpXYakPeZHOAGCufjRjAgKjpVdhpRDaJ39TG9DMIMkgGsS+lrYd4LqEqLMWevu7GKH++xk
 8umDm+eXozKqildednvXDFU28jkFQwJfKyti+msTikNsndDDyntRo3v+y2FF2kMUX3IV9APxGyI
 bbmA+w9SXYsWw8nEPD9HwxYi6PLvyTA2zTeJZ3httcd6jjBvI3wWjhYw=
X-Google-Smtp-Source: AGHT+IEwGm9ffWjJ19KTKCs0uwJy/zW/1QUyHY98CEAchv4skerOLfZTNCHEMfNl31WtVe9jXzTyAA==
X-Received: by 2002:a05:6870:3642:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-306c7357310mr5811261fac.36.1753392635710; 
 Thu, 24 Jul 2025 14:30:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f8a7adsm660520fac.42.2025.07.24.14.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 14:30:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>
In-Reply-To: <20250717-dt-cleanup-v2-1-bbbd41cb0d81@ti.com>
References: <20250717-dt-cleanup-v2-1-bbbd41cb0d81@ti.com>
Subject: Re: [PATCH v2] arm: dts: k3: use SPL_TEXT_BASE for R5 SPL load address
Message-Id: <175339263483.1899261.4561569065383103070.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 15:30:34 -0600
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

On Thu, 17 Jul 2025 13:48:22 -0500, Bryan Brattlof wrote:

> The load address for the R5's SPL is defined in Kconfig by
> SPL_TEXT_BASE. Rather than hard coding the load address which could
> lead to hard to debug issues if this value is changed, just use the
> SPL_TEXT_BASE value.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: dts: k3: use SPL_TEXT_BASE for R5 SPL load address
      commit: 6d68ac9730c63197bcdf68748dc7990efea167a7
-- 
Tom


