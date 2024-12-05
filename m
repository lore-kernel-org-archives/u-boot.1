Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C75E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B671389570;
	Thu,  5 Dec 2024 20:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AXbzuZ4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A01E8955D; Thu,  5 Dec 2024 20:55:36 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9495089566
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa55da18f89so186675366b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428534; x=1734033334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6VJxkjmUISxMrXZkxFztVpXPJjuvwH416REzXRl4WEw=;
 b=AXbzuZ4zEMWrEZHtJ2Bd0rMEBpttYKtxV/Z3FtGnLLI2k+auljXL4nQRxnE/54sLp+
 ykXy/7LkSbfV9fdI75grMcj2a3RhEnItMhIRMu/PSOv+XRFCcvigs0w+2ZWnKKFQh2Kz
 5iG5p0TdiHat/qtBQpTTq8eA5bNft6BHuOI4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428534; x=1734033334;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6VJxkjmUISxMrXZkxFztVpXPJjuvwH416REzXRl4WEw=;
 b=aqJ7BTtsdsVneGK5EbIXz6QYKpDTxgdarpOG63kbQquOiTwxOsL/5BSE+p1OO8dGJB
 MWFI+JxtTyFOYBd0V0EgRUqry9f+im6eWe3i9BAbhGas/Q5976kPqgiTlvzWceWSFQQN
 LN6Cn7fHU8pVUTuwov1ibJceBCoCY7kqqWK6pSJduVdJYYGSrRJbJn2TnJqApm1jFfMB
 Ks1ebt3aQRpldLK3QzapnwmfyKbvzRAu6W48F4mXYoTb5n1aU1zRFxlr7C47R84ub7o4
 aSda6XOOk86EQl6ZMuzku+hLyq+Jxxr+TqmWrSIVxnEyFddAxqzKa+CqLdK7BBh4YW8v
 jcSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVECB+himne7cpCg0SVtdafM/ZJLGyNeDyfbQkx89941nM5cHkPr09d0byO4DkluVVOZwGAIOA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz57pgEM6YcY0o0gsfKLcTPn3CRpdKyTC8Jy62lWtHGD0pUMkKa
 x2XIwQXaTX5p1Ftf7h7IzwrJp2jS+cWymNft5hWhm7U7Hhh7qZrqEF/MZGOvSKzeit8HPNh/1BN
 l0AmdwHbhS0H35IAogiz9hBs5z5f0lmbG62Uo
X-Gm-Gg: ASbGnct5NX3d4DkTGlM42n29P0wZE8lfm2kXaDNc1CZNOaO5UGJU8cd2lPJzhSFcUJC
 1tOfQgZ30H7GpcyI0fEucjDHvTM5h3j2d
X-Google-Smtp-Source: AGHT+IGI0uNQhvs09swzy2D1nep1PxED2RSnYtNIpD0oLTFkSKQXqk9ds0WfWCINO3ud69RwdJvGGqZ7FbVK15hEiy8=
X-Received: by 2002:a17:906:d514:b0:aa5:451c:ce1f with SMTP id
 a640c23a62f3a-aa63a252139mr6226866b.59.1733428534107; Thu, 05 Dec 2024
 11:55:34 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:32 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-18-sjg@chromium.org>
References: <20241115231926.211999-18-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:32 -0600
X-Google-Sender-Auth: G4041-UZ8_g0ayR2Y_4rRkXX4sE
Message-ID: <CAFLszTgGKqW=pxFX4Wuy_=DYO_kTJkjca97U+J3Az8iKh6+SRw@mail.gmail.com>
Subject: Re: [PATCH v4 17/19] bootstd: Export bootdev_get_from_blk()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nam Cao <namcao@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Export this function so it can be used from other files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to export bootdev_get_from_blk()

 boot/bootdev-uclass.c | 2 +-
 include/bootdev.h     | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

Applied to ci/master, thanks!
