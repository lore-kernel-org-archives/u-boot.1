Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF884C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 16:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F24A780F0E;
	Sat, 29 Mar 2025 17:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mTPmavmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF2C81DCD; Sat, 29 Mar 2025 17:37:02 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182E3805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 17:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c173211feso1118985a34.1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743266219; x=1743871019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1LwFm2CpROIJ0P2/9d1YxEFvAZEP/SeXhErzu8/8S8=;
 b=mTPmavmxnH8IXFrTTQENl8sXZMRwZxc4zlBZJZ0ziDXnpfCxm/9eSEue0uJJ48pZTi
 +n1/mu3N8KH53MqYgL0iJOIlbuB8M2A/xD4hw4vq/XWQi3n07mTEnmzCYMwTvKsW5oCX
 ejKWUP73MvyeUfhPDom4Gu41lVSuewWpPpEaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743266219; x=1743871019;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1LwFm2CpROIJ0P2/9d1YxEFvAZEP/SeXhErzu8/8S8=;
 b=Jl/oZrR1LmOnQdQMwXN8iS3aoYS60hfPMpnv+Bh6CzIV3SVyIK58LFFN0Vw+YYRxth
 P81BcCXUCrEfLERkSFX3iIws4m7yz74ybItEOaNyP9Z71QIb2X1V8mfkt5KnD38PUsOm
 CZUxng9wyoxC9e87Z2vuXtQoJEgk6RyM/ltBjHWQgYWq7VRINa1XXHRZrABX2/ZSTz+J
 hFW2wz8MTUZT/fnhVMjTvmClYfc/0GwJY0V4sLNM19hLuB/bjgPHzeBbdeH3bC1l0DvQ
 6tCNHn54Dq+sYJg2U7A8Z9pSD0+5g5ZVtH9PnNLky34iEjqKMfUedzNCsDVdTqePvrlR
 kJ8w==
X-Gm-Message-State: AOJu0Yymt2Hen6l2AkAGWiKDBlG6Z7oxkG9asgEdAWTrFI48WAZPJsZm
 xJ4hxrkhJNPwMa7+ivmKh8vm0ADHQmUFeKhQDT7lC8zYrSiLTwUPkut2JHKSm3c=
X-Gm-Gg: ASbGncuUFGjoDAE98nl5p6Gd65okevYPzFDI8ldUuIhYskT+KI+fxGS1vbA+fkgNmun
 igNvCwX+O5by3+n9opVzWcHGRX7HWvtEwCbHJkabRnK0It35WmYcA6gcICZM5Lnbz/JtFLqjc8X
 OWzJax2wHc0RgmOHjwMldivsJwuuRsnskDibf6rajPK/yQnTab0FDdfJY5zyCxuPrXnF02N2K3I
 ETU9IHFagE+5wCT1qzqjqXj2X8dm123hPBRzGRGGHjxMw59q4gqQ7oACP4w/NtRpjCd7aikivUa
 qnq35DhB5a7zoGoTr79TCyYUllY6OR5RgpeOH+446PZdA270HO0Sv9qBr72aSCn0HCPErIBVy4F
 d7qm1
X-Google-Smtp-Source: AGHT+IGjnHyte+zWUfxi1QcSyOdBVWqFt81JFIaRlHkzzPH0gL6PaqASMysag4kl8HA6+2tVQWfRtA==
X-Received: by 2002:a05:6830:4903:b0:72b:9de0:891 with SMTP id
 46e09a7af769-72c637c49d1mr2391182a34.13.1743266218788; 
 Sat, 29 Mar 2025 09:36:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a91391esm925094fac.46.2025.03.29.09.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 09:36:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, thomas.petazzoni@bootlin.com, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250327103113.417015-1-kory.maincent@bootlin.com>
References: <20250327103113.417015-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] board: ti: am335x: Fix selection of BeagleBone Green
Message-Id: <174326621704.1009412.12296748919725068750.b4-ty@konsulko.com>
Date: Sat, 29 Mar 2025 10:36:57 -0600
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

On Thu, 27 Mar 2025 11:31:12 +0100, Kory Maincent wrote:

> The BeagleBone Green board is a revision of the BoneBlack board.
> Having BeagleBone Black devicetree listed before BeagleBone Green will
> select always the BeagleBone Black devicetree following the functioning of
> board_fit_config_name_match().
> 
> Fix it by changing the test condition and selecting BoneBlack board only
> if it is not a revision of this board.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: am335x: Fix selection of BeagleBone Green
      commit: f364ea8c2571540c10ecc9fab456760936eb7fc6
-- 
Tom


