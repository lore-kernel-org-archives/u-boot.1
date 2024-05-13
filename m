Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DF4C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 07:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E35A48815E;
	Mon, 13 May 2024 09:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E8ItlQOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D083B88228; Mon, 13 May 2024 09:48:14 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B035287F13
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 09:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52192578b95so4528698e87.2
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 00:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715586492; x=1716191292; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Hvs6bTCOP4LjUewv+XdrOVIRYrapj/FzPjlsptVLHU0=;
 b=E8ItlQOeFemWF1JeonX2tq9QFRUWyYMKeE31GZUjceZdHpvM4eHGtN6OCOHgyiKnhU
 yBRsuWPS2Pu9hF+hYCrHXlILyNNM12YlJ2PkOnARkt8IkOHqSrCXMWEYbNl8CGFYGQ12
 AmliXqc+i++xu0OcPX+eZE2eqHaXPf7YUgxRHQ3zvSpWQMjjzJk/cvatGghYh5zoURJL
 3nCOpXNEk4Z7i41QZ2k3nCrqlA5lEeZ5o055GlI/9tmKxttM7BkURzuDunD1rUDWDDoq
 x/ho3knenDhj5vMrOj+HDqdr0ukitpY3ePWkEaTxUtyFJgCDDkqNvUdVvHugkyi3iOb1
 +AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586492; x=1716191292;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hvs6bTCOP4LjUewv+XdrOVIRYrapj/FzPjlsptVLHU0=;
 b=RLg9yRr0Dv8U0ZKSw1qlY6o3Uda2gqHqxB761aWeiKQU2FUeHzzwagC4d5sa0uSFf6
 lRx2v+zGQV8aGldgq41movihhJABTUL2NymiCp+gBzYEQa0KBBvPbM79fbW9KtXZ0F9N
 Mn0E4rK9BrebNhx7aXmj4cw39prIq5Lvyvpau85YwUxyBPgp0hIb+TM98rIYZyT8B5xS
 /QtDbR/XhX3R04xb1R2YXfFY4DGIr5tS5uxqt1cA6DeXJK7oMn2yKp52808hvjozCt+y
 WETnLeI0BV9UGsMWV59HByHys//BH6pOTMou/7qUC0/devlz2Te7yioAvWs+otyRur+l
 yXEA==
X-Gm-Message-State: AOJu0YzJd5I24Oa5LBs0M9431scVsHCv1vFEtivcqjWkagJ18fR+J+yh
 C5fLBcAMv9Yeidm4wGMxYvP30w0epkKLrhQu6bosmnTb6YeJylr8jjgvwDTytooyrl8itoFGXCN
 vdF5B2JjaMvUn/Pz3LTw8vQJ2ox1lPaHVuro=
X-Google-Smtp-Source: AGHT+IFgwMRin/OWPhSXzv6eOByA5WbNWAcu6Mw5HxfJ9yeBRsSQ41lwrcqKyKtpOhC7CTOwZw5klx/tCFh9MEbw21I=
X-Received: by 2002:ac2:4ace:0:b0:521:92f6:3089 with SMTP id
 2adb3069b0e04-5220ff73877mr5326897e87.60.1715586491693; Mon, 13 May 2024
 00:48:11 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 13 May 2024 08:48:00 +0100
Message-ID: <CALeDE9OF_4eTtiPJ+bwsRphD6cGNhTdm_XW1XRyGpgNX1QY=GA@mail.gmail.com>
Subject: Pull request: rpi-2024.07 rc3
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Tom,

Please pull the updates for the Raspberry Pi:

Updates for RPi for 2024.07:
- Switch to OF_HAS_PRIOR_STAGE by default

The following changes since commit 52835266d3e933656a217233eaf672dd9ccd7352:

  Prepare v2024.07-rc2 (2024-05-06 13:54:17 -0600)

are available in the Git repository at:

https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2024.07-rc3
