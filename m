Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE34C369B1
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 14:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A14F82AC1;
	Sun, 13 Apr 2025 16:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RpD3DgzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C54882AC4; Sun, 13 Apr 2025 16:09:33 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E949582849
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 16:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2c759bf1b2eso1904242fac.1
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744553370; x=1745158170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hK+uxfsA0dpJg8UQGe/fh/WYXpKHyAJTmJPKnIonHVU=;
 b=RpD3DgzYXqp5pthwG+hyEWGRUrqkOOBGTFeQJAuFjjS/Lp+00frQuYb2BkCvT+HANL
 xTLMQj1ecX9f+8/fiRBNITK0qyLvaJIIKOKAjizqwZJUgR0yPuYlqjHV4k5auXnyJeLW
 URxBsr9w/NLobmcUX2gv6Kp7l3G2Dk8/OtlbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744553370; x=1745158170;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hK+uxfsA0dpJg8UQGe/fh/WYXpKHyAJTmJPKnIonHVU=;
 b=nsWaydSe1/PBFpldULVU3dvGPHsFe9GoUwncxbMeWq0L0bsZcY7l7uKAwRrJjBfV+W
 v802n0SmHtIyhfKRxLNSCYOQ/S7Skwfa0/l//Nrdd/G70ZJGecdT4WsXlOBtm0QiIDGH
 sQkq3bJJDCZBuu4/GaGWzQKIt7Z1rGxPaHhQIDfTGBBvVbd8QXR87LToU2XM41Co4k2Y
 jMBqTVZxJ48ssb+vQ97h1JEUbitWgC85XIcurq7qRe94RwaVNzg97s2Zzo3o0bx43+BP
 QfDXMYvq/cJzvhpMyErJLA/zjcbgZYptxQh3nhZxI3tM198HLxhbEVeFCM2cCOUVcYJK
 o4XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqeI86N8WdM98dGiD40U6JjwENibGwOQ1vGg3hQ+AQK8yEqpwkpx7rC6T75R2DzkovCnMFqa0=@lists.denx.de
X-Gm-Message-State: AOJu0YyroJ4jEUAs8zh/Dw8XDymacbo6GqeQB98BPTVvStBffqbS6cFu
 Kmj1wKTcjiZwqCaCrsUVtcgXyrhxAh24QWPbmWGXFrZRSmqv0GTswVK4z70h2Fu6f/I5yVFSRiY
 M
X-Gm-Gg: ASbGncv5UE2houlFZ5OZApgu/A1+zz4mah4UZrGEybuArEXEo5NWYym62y0AKW93q7g
 YMh04BiI7jFr7kYcDyOn4jTATYqKlOjQWZ0tcPTcW8IZwWwxtvXdVtO/Vsp78otRcdbbN4DXDNS
 Pj8RO2dXO1QZI4iXBnYrTuya43B+DkRqGANWv4gFiM2GXWJJdKZLpy2eFnH18/xnsDI9tlWHyXD
 d0q9yjfOj12DyvBv7FxI6JLYU0QTj9EhYztEwCMD9AXc65EdQSrdT3FOzqNn2gGiILtfpZ0CXO8
 ZszK5MHUFaPbI1xqzttDMG/x5vCyfnpDLmr52A4oCdiiNlhvs8tPXXWdOuG89O1bFBcvIUehTQu
 9
X-Google-Smtp-Source: AGHT+IEYYyony1hfXLkvv7LjyyAUvx+i8/hCEVGhCCYAa0vJTf1W24s+S03re1od7e5snIxP5XamjQ==
X-Received: by 2002:a05:6870:cd85:b0:2bd:455e:c22e with SMTP id
 586e51a60fabf-2d0d5d0afdfmr5453127fac.19.1744553369632; 
 Sun, 13 Apr 2025 07:09:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096406702sm1989557fac.0.2025.04.13.07.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 07:09:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Adriano Cordova <adrianox@gmail.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250413113427.3126132-1-ilias.apalodimas@linaro.org>
References: <20250413113427.3126132-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi_loader: Moved the generated ESL file to objtree
Message-Id: <174455336756.362516.12829354668573194035.b4-ty@konsulko.com>
Date: Sun, 13 Apr 2025 08:09:27 -0600
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

On Sun, 13 Apr 2025 14:34:26 +0300, Ilias Apalodimas wrote:

> Tom reports that generating the ESL file we need for authenticated
> capsule updates fails to work on azure which expects a RO git tree.
> 
> Move it to $(objtree)
> 
> 

Applied to u-boot/master, thanks!

[1/1] efi_loader: Moved the generated ESL file to objtree
      commit: 739ad58dbee874a3ad3bddd116e995212a254e07
-- 
Tom


