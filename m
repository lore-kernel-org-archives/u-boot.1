Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42057C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 19:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DE887B05;
	Mon, 12 Feb 2024 20:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="obyCZhNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9964787E96; Mon, 12 Feb 2024 20:59:16 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 772F1875E9
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 20:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-604b94c0556so27028547b3.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707767936; x=1708372736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzjE5whRoKQwY7KVkEtdMdaZdWs7GSY5k48j1eMg9FI=;
 b=obyCZhNCjr/HLyd+mqGzX4dUpJ1Ng+igt/kLbFTFIsyfeXrVOvK+M5DHUT825+oLxM
 V9jcsrknOuUOYxYr+0nk3KUq0qLUguxdo2JXxK7nS4zM/0UrPRtu9XDLDk0y3ClcySUN
 WOjCLln5SaCrUQ/F20Ad+gdXFCtNYORthbhlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707767936; x=1708372736;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzjE5whRoKQwY7KVkEtdMdaZdWs7GSY5k48j1eMg9FI=;
 b=GyqvUwioYNrMqZ1tjBoHaQrM8JtRXpiZk+xBWTFbCUvs9t9PIsbIR10cSnDGPa8i0j
 bk9uUwNaGd4CJ5NTe2LVis+ezcAryxRkBobOGa7cydwDcsmT1mEf1Sw91tyf26ywFIEl
 Tv07VO8ugjeH3qZMag2Y4QDCxaajFkp0+ifk6x6y5IW4j7fx5w+jN6em0joFu/FnPXve
 lT3cOjI2B4L+6so/qHDMCPJ9bgjwgNObD1BJpNIy0bqbJ5ycjj+L7+3kGtNpG0EB1XGW
 fYVm08+UkRabghtPXGZ0rucaRlmjqYiBJ+MioVpOTs2csGlJBBd4RrTKrarNiqgdSdvv
 X7uA==
X-Gm-Message-State: AOJu0YwPM6+drSfIHRc9++vg1TkHfbjg4Js0w5LJPjSzUNeJZT8O4HL9
 vWpHUIJyhsIJZ3J8fFsyc7vjT5Dpi5INetNildWGp3RyQTrrORG6LT1PFxHjyJU=
X-Google-Smtp-Source: AGHT+IEISJcoAz3csPgfleRVa8qZ7YfGOmJaA5TKu0+c+2NWRTV/2zoVH42EgB/57+TJWGUlVEzoIw==
X-Received: by 2002:a0d:e20c:0:b0:604:6efc:e25a with SMTP id
 l12-20020a0de20c000000b006046efce25amr4943687ywe.40.1707767936676; 
 Mon, 12 Feb 2024 11:58:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXkZ/pI3zM+s0suidULYlPFDHiroZXuFq41LbXjKj8AVbiIY9xBD5KfK+ccAXj9JKZuy7NoUZzepNRxYcSBqqr+V+5Zi+muYt4t9REAGJxmoyzszlTNcwPtIdXEpOisyhT0mXkaCegtxhLJFIL3H3fRevoa4Q==
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
 by smtp.gmail.com with ESMTPSA id
 d133-20020a0ddb8b000000b005ff9264e841sm1328343ywe.6.2024.02.12.11.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 11:58:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Nils Le Roux <gilbsgilbert@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20231202093952.33256-1-gilbsgilbert@gmail.com>
References: <20231202093952.33256-1-gilbsgilbert@gmail.com>
Subject: Re: [PATCH v2] net: designware: Support high memory nodes
Message-Id: <170776793602.3360253.3949157088008477873.b4-ty@konsulko.com>
Date: Mon, 12 Feb 2024 14:58:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sat, 02 Dec 2023 10:39:49 +0100, Nils Le Roux wrote:

> Some platforms (such as the Lichee Pi 4A) have their dwmac device
> addressable only in high memory space. Storing the node's base address
> on 32 bits is not possible in such case.
> 
> Use platform's physical address type to store the base address.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


