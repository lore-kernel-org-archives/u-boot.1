Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69098E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F204896A5;
	Tue,  3 Dec 2024 20:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MFsIaNIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2972888E7B; Tue,  3 Dec 2024 20:39:42 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFB688E7B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53de579f775so8473193e87.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254779; x=1733859579; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vEG5KxfnnD0ILQSp/f7ZDQ2aB/ehUVMC6VzfcVT0Wog=;
 b=MFsIaNIJvD/Cpamp8g8rUPES4nC1FLBDpMJ34f+uODI4B1+iQQbqeiDlFEy5M7oeb6
 43OCcA2jMpPaY9d1+Vsc8rEeCXz1B2EQGRhY0Gr3aAIpQYoe7cdC6Dgd9P5UtL9b6r3Q
 PWT5clqp63lKI53NHZTnVwMmDlfCPyD09s6TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254779; x=1733859579;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEG5KxfnnD0ILQSp/f7ZDQ2aB/ehUVMC6VzfcVT0Wog=;
 b=mi9SbcukPKzBH8MVDCMrqPYGSceisYHU0XXCUVKpwW8THcYsS0s+RTXd6HbUdPNCfW
 YREpys8CSUYT2li4BFtLmAPEjdBuCzJ4bGDmJ6sy8M7eg7vNBR6TPp7j+mPNL3GVzAzt
 JeTT90E2mTIWJieQO2BP2+KKX1tSMiMAvcAXynz1HVQ3N90VA64LIYUXGgdsraekRLRF
 MQXL+x2+wz6BYxRg7bourMi9g62AHZId/tW8r1qTJmK5u4vG+4lJY6FaNV+xGzwPZOmB
 ppXWL6avBseaP4wRwg7XTJTQ+Pwp47Yfil4xTXwInUi1pF6l5yojzOqdkbqWGeLD5g28
 v6zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6NEMxSBXEXFhodQBbutnMDyRAczyMZb/qsDRFBorQmh8rYjRiHKzum+k+XZ9Pj+7qdlzX1RY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9MajxagLQCqaB0D+VVvc9Ptwq20cRHggIS0NuZj/F4e/aRiJP
 SC1ixRDjpPhB71vmSJftM3cLmX4Ml9boOE1d/qnFKEa0/yFO+EisHUqbeRBY23hrgViN4MLpVPj
 DBDMgWls00d7WRONNMuDY3FvdSKAbUCjP8mAH
X-Gm-Gg: ASbGncvg9fZ+JdIVT2YgPMP5GCqy6g5xzZB9XyP6Fn919G5iAGne9lkLFn6i4PK4zsA
 M1/YdeCUr1IYY3e3MqyQeHD5gNESI/G9n
X-Google-Smtp-Source: AGHT+IFQY/OfEYWAobqnl0ruTfe49A5jgES0UwcSgQ0z3ebJag15wSCd7Koj/pauYNALu/CW95wQ++cWf0vkvbqAdgQ=
X-Received: by 2002:a05:6512:3993:b0:53d:f09e:9a1d with SMTP id
 2adb3069b0e04-53e12a06c96mr3120314e87.31.1733254779507; Tue, 03 Dec 2024
 11:39:39 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:38 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-17-sjg@chromium.org>
References: <20241103003322.626036-17-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:38 +0000
X-Google-Sender-Auth: XJ3o4LnVKwITZRC1NLpHHqV-FDo
Message-ID: <CAFLszTi95fL4z+7KaCPXf_2efA483vNMJvLwvh0RDYy8Cnp6Hg@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] powerpc: Drop status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Andy Fleming <afleming@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Mario Six <mario.six@gdsys.cc>, 
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/powerpc/lib/interrupts.c | 6 ------
 1 file changed, 6 deletions(-)

Applied to ci/master, thanks!
