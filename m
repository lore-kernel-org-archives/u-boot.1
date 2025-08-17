Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87349CA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 15:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C2F83B1A;
	Sun, 17 Aug 2025 17:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qVzDJDd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3520B82B07; Sun, 17 Aug 2025 17:24:53 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A298349B
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-30cce5da315so1022609fac.0
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755444290; x=1756049090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XhN7to3fWzp7fjYb07GmBD8QzqSQfEu13z2NztrmD7k=;
 b=qVzDJDd4muQhQnchztY+qtfNzDPdd4LYlB4hOZCfBOUesPZ9eHOCjZVGCx70zmabDp
 w64LZtLbz3pdl15mhP4UHTM06EklPsh8+GnrGoODGXMro0HgtFyAUG6OnuZ9sd7GuYHg
 gqoNrIwnGBjdyCZKGgzbRKmsEjxp40k2OPlU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755444290; x=1756049090;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XhN7to3fWzp7fjYb07GmBD8QzqSQfEu13z2NztrmD7k=;
 b=qxb2/l/zBardqMxuBfV7cYn944MNvo90Q3mAAWmIU/Ve2C87rRb6gApEhNIYR0gzED
 EQbTHNaex7mb9jxx6pOF3GAGDXxgSanC2NqQwapiVELvbpYsCEknRvWDIcqFyB1edmXD
 yIgg19im+vn40RzN2cXRsKYxAk1BX9NbC6ZQ2elNbtf8YM87xRuMN1CF/F4PRHZ6FYgC
 s9dXsU46mEUA+UDv+gAGbf/Ls/Ug3VQk9iBE/l9U8mBmMEVtUl2BiuyruaBG8YwB1bhe
 b4/0rdTdqw4AQjcyFOWs6Uivkwyjh+hVK9c94b9P6/ReHav8QZomXpiny8ioX69+zBdY
 5qJA==
X-Gm-Message-State: AOJu0YzDHfmnnjN3P/wdIwvj++PdXPGWpH7N9B+ePHK7uStW7KJr5QHo
 5Oz4SzaQSKBAVV7e76ABjj7rAvA4UWkvNYHE1UgwkaGTPO6gqXxoLIVuUCX/BkyP8wm3g8Yl0KB
 34OaislQ=
X-Gm-Gg: ASbGncuHytfZuutoQYntWOJrxaQZg1bWcy8c/fOfHnIeklTm0BBLR/WeN29OJo9vgd8
 DkJGgYWNe/pOon6rMA7iugyaSarirS8TydGK8aoWe9roz/dzY6oQiXQHhlKlADqMgaLsI6h0y0H
 Lsin6jkU6moDFfrfxvlGphQpiOKAMYS91ewvTiHXvqmAwawaw2lkJ8UBWFxmrkjd8ePCpIx/DqL
 7BJJSskbnSbUEZuyNOxpFYYtxqB7Eb9EB2UFGg7D4VxIsZhgLVWfxNXA+d+h+xbsyTYkrcQI4fw
 4J8bNMkC4IUj6FqdxdTRQ6WGThVaquIU6WNszJDfAg10/oDWYxFf13o4zyQuBGOx6kalTLZV5Po
 TObTuv1dJ1UNlk1VdG6WUIym4UGBf/rKxXwtiyi8LetI0qzaxD8LS9xQ=
X-Google-Smtp-Source: AGHT+IH6obvzELjA4HqCOxNaCbYXDRjNEQMeKeg1dFWLATjted00F3KSk182O1Rs2iTi7+0NwTo8/g==
X-Received: by 2002:a05:6871:29d:b0:2d5:1232:b081 with SMTP id
 586e51a60fabf-310be68376amr3784908fac.29.1755444289884; 
 Sun, 17 Aug 2025 08:24:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab878a4esm1998472fac.3.2025.08.17.08.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:24:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250806145503.1664386-1-trini@konsulko.com>
References: <20250806145503.1664386-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] timer: fttmr010_timer: Remove unused driver
Message-Id: <175544428840.372553.11204598616545018400.b4-ty@konsulko.com>
Date: Sun, 17 Aug 2025 09:24:48 -0600
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

On Wed, 06 Aug 2025 08:55:02 -0600, Tom Rini wrote:

> This driver is unused. Remove it.
> 
> 

Applied to u-boot/next, thanks!

[1/2] timer: fttmr010_timer: Remove unused driver
      commit: cb76b208390d98658fc8e97c28dc0080a65c63bc
[2/2] timer: Tighten some timer driver dependencies
      commit: 3f486367bc8ba415fa0acbe72e57bfbfe3ffaca1
-- 
Tom


