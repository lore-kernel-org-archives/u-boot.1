Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A0DC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 23:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2A088453;
	Sat, 29 Jun 2024 01:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qkvmZzlP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75A38851E; Sat, 29 Jun 2024 01:29:10 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B0588258
 for <u-boot@lists.denx.de>; Sat, 29 Jun 2024 01:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-25d8ab4f279so610894fac.3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 16:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719617347; x=1720222147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IOihu+hwmGe3M2TeDX14LkreTh6/1yAtkSH+28HMHk=;
 b=qkvmZzlPZFzf9oEUY5A7QeoGq6OEqUdQZWtMqEczyClY46OKI6wcx4pLzNtlU/wTcW
 97gVpE54aeWRI0cXLMRL4nwI8ASBCnxEmwlcR2pmegRdI425WCL4u4ib/A9zamU7ZVUh
 WKJwiide35GDs/QrqKN5RDi6rNLrUxZpfWSnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719617347; x=1720222147;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IOihu+hwmGe3M2TeDX14LkreTh6/1yAtkSH+28HMHk=;
 b=ik0FN0Zvmk1o0el80wHzXAuLxb3r+nGYvTEo6j0gAdlsdE8B67RSlRcEtXfi58Mnlq
 Y43fM0moEDLzTPUN4Qjs47dMKP7SiSTly7B81bwrAGxOslXWuJt8Mkbxz8ZZtbXjG0Ge
 jC11KgIL6OyAebPImk0yXQWc9nEhkFZSdu3y79WCTpM+UJtQq7p7Il5T6o0SAu6+goEY
 nTwayxLVA7diI7w1wwklXkA16PPsy9+dkAczdL2jGeWIJEjOuolYb0DAwvO43QG+lQkM
 K4oRaToqITN3U9JccbLmbFDjrx6lAYtngtb/xP3eYOF55vVfM4ZX1zVBR2nRmLp7OWyl
 jVAQ==
X-Gm-Message-State: AOJu0YzsxB7fX1kstjxYSyLGlYmABgAdheM1oig8lInu93WEsIhOnMKJ
 gQC/7sSN8O+06jIXfm6NSs+6dbnkYq7F8Ehv6MsRZPvGX53UyOAa+4m1kEbyaUo=
X-Google-Smtp-Source: AGHT+IE/8SofwDZn8+VgWCHc76WJ8y5OGtYQXatXqIg5TpexLU3DhlkHzWC57IjU9LcW2fxTxE4iQQ==
X-Received: by 2002:a05:6870:c088:b0:254:9a96:96a4 with SMTP id
 586e51a60fabf-25cfcf9e9f2mr18935627fac.49.1719617347290; 
 Fri, 28 Jun 2024 16:29:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e1f04b7sm650418fac.18.2024.06.28.16.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 16:29:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <l.majewski@samsung.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
Subject: Re: [PATCH v6 0/8] Bug-fixes for a few boards (reduced series)
Message-Id: <171961734627.3626318.8177706462255672318.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 17:29:06 -0600
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

On Thu, 27 Jun 2024 09:29:41 +0100, Simon Glass wrote:

> This series includes fixes to get some rockchip and nvidia boards
> working again. It also drops the broken Beaglebone Black config and
> provides a devicetree fix for coral (x86).
> 
> Note that since this series fixes bugs, it is targeted at -master
> 
> Note that this series does not include:
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


