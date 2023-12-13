Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF92C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2999587927;
	Wed, 13 Dec 2023 21:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dJBcUPH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388B2878EC; Wed, 13 Dec 2023 21:39:44 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E1187910
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso75741225e9.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499979; x=1703104779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jzI2uVFwLWhtytZn3hSsYgqsXLnRqufeCBISwt5xQkk=;
 b=dJBcUPH3oOZLC8fuM97D+XqS6UVrZr1D3rS8F9CyjxxPSRS4g+X0tKVnttj6s0tUHk
 s3LJrjzhc65egeV4ywCaLaTTaeUBZDpIVflt/XdEwcNwha8rHXwG7tCUUEPQ/G5MIzBi
 SJndQ61L7TPjfKD8DNfmA7dt5EmV/r97Yy1us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499979; x=1703104779;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzI2uVFwLWhtytZn3hSsYgqsXLnRqufeCBISwt5xQkk=;
 b=VGGtYIM8kl/iQLtqhCYWOBC0FDg+GaaZVTqoj6e/c6GY+eJ6VATxDsvuQFifxhQK+X
 /MDvoJKQ4rbJc9++twKdqWSZHFXqkA/X04+7yB1R0ob+greRoHMrV2rjCD9bUsJkeq82
 /MOsaW7zhZUFSXmvGBiajmI+4pS64Sv5pfdc3dVe/Pl+MiIB/x0r/oZhNxOs6xysB1xH
 Edl2F6T3hrszA4Ejwn/W5AWQWcOyYun1wEzFjnLyDJZcox8IMpbD4cagbSUSDEVEAWQo
 QHpEQ/DFf/qKcikL/DJsfuNPZ95q0bJZmKvULAPW458j+dvjhr7swaXmO3Sk0g/8S5Me
 oHPw==
X-Gm-Message-State: AOJu0YxfoKBKBwvtD+2qVSZALTKQbDW4q/PfAAPSCq9Lh+OzqGPDUYHm
 a4qVzZW4+rQUrc7ULHNKeSrIMtD5RIIbxy7mvESmqg==
X-Google-Smtp-Source: AGHT+IFPKr4uDUrrSENJIigyjAc1xhjjqdIvb+LC48QOfSHjSrJHmdo0fRszw0b6YpvijepbkmfPOl+l3qXxAXLwgLI=
X-Received: by 2002:a05:600c:3107:b0:40c:32fa:4f41 with SMTP id
 g7-20020a05600c310700b0040c32fa4f41mr4540111wmo.142.1702499979301; Wed, 13
 Dec 2023 12:39:39 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:38 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-7-sjg@chromium.org>
References: <20231002011553.463514-7-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:38 -0800
X-Google-Sender-Auth: jF8MBeCPCeHZePqO_bRVbTNEKqI
Message-ID: <CAPnjgZ3DM1LOifQKgOeWFF9T1oj=-g1G+hFYaKL6C=7mShCuxA@mail.gmail.com>
Subject: Re: [PATCH 06/34] test: Handle use of stack pointer in bdinfo
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nikhil M Jain <n-jain1@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This test assumes that the stack pointer is the same across two calls
to lmb_init_and_reserve() but this is not the case on x86, for example.

Add a special case to handle this, along with a detailed comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/bdinfo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

Applied to u-boot-dm/next, thanks!
