Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FE3C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E657783340;
	Fri, 23 May 2025 15:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hpOFvk7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0E0830B4; Fri, 23 May 2025 15:18:58 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B2283330
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad53a96baf9so1199959466b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006336; x=1748611136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/2j3BXsyfZ4mzzm+RWXXQxrFlYmv3UvR17+0YS9ckgk=;
 b=hpOFvk7KUUZreqqNCZ3Osd35Upzba4WSSn3cB8gBgDFr6JCMlZJzO0eMI8B7WgbHhM
 nQkdCVSC7xCR4KaocbRdkhYKG/eP3UPV+g1ksaOcNVtOiwz5I0vL/kzfeq35Im2E5NYA
 TrGrVKMDWGmW6pH9NtLQFo8nUw7MESIAd8Z6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006336; x=1748611136;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2j3BXsyfZ4mzzm+RWXXQxrFlYmv3UvR17+0YS9ckgk=;
 b=kX7kxvXqaLrXifWaLK79GnWVZ0ZFdcx1+n1OCqOHQ9IXfkz5AlBFdZunz5TMtVSHQD
 t+LgmHCTo6rAqGCDM3AeGGQZWeanr1oOPEcMcQxeMTB2rJXekKkvCrdX4+FTVEaqVso5
 mCVTtMoHIy+zLilBSzC9ri64KJKHtYzmVjqWTTpW30jmhZkLu5wuqIHXwTxp3K8U1hGu
 F5JFbKlOlJf6y8ZgPVpcBzKjmwa1Gso++slZFiMMSDfN6iOgY8FjEDL0HxhJlYUV0a88
 63MucNLb/aask9A4CWCCDgVm50rfoOvPuOVnyocrMWbdm8WYCLTAkfIFXK8nVBYRN8Tz
 panQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXoz8A21JoPL1ANvJ2YcqqXjQL7dzfutR2GKuzTVbUDXyh08cfc3aGUOnSFP97Rk/qRb8OlI8=@lists.denx.de
X-Gm-Message-State: AOJu0YwIhKLnqUvykxD0aC7KdLdpzNiDe1MQiwltzevsOf8Rb4XpmX64
 QmmCAjWPeqRWakL7TJEGe2xivv8ebOU52IrsFWtIjDaGvKWIdVoAXnY+vQoeVR1GC44QZr2AcYx
 GAhBc5xoK1UWWq1IaZoN4VulEgVm+N5zIz0xzg9NfQiBRxfjs6Pk/DWwW
X-Gm-Gg: ASbGncuzVUwL58qDipefRqm8/QkFc1cHL6pEpYiektTnaIpFIXI5enurYPlVdLk6yMi
 h7HZisaoh4QrUBpgkJXIG1lHqpN2fs4UP1DqV5I7aw+dNLc6nzTPxO+PZslsdk5qYC5nnX24yks
 FHl6edUE4TwLVSQA1OUIIiMLG8dfKam1Gaig==
X-Google-Smtp-Source: AGHT+IFvqStiZIv1dhWQBLZcmZI1yQKjU16bp4ivm+CxIdZcja5QCNA41eBrJwS8485872K2w54QWTPxr/jSw2A06CE=
X-Received: by 2002:a17:907:1b0c:b0:aca:c49a:aec5 with SMTP id
 a640c23a62f3a-ad52d4302d5mr2557019566b.8.1748006336367; Fri, 23 May 2025
 06:18:56 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:54 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:54 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-15-sjg@chromium.org>
References: <20250504132356.2317305-15-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:54 -0500
X-Google-Sender-Auth: HYdG5KTqMeguaOp-tvW8f6dQuhM
X-Gm-Features: AX0GCFvdejr-iFTZ6T8CXtPfuZ2a-17PNFjjrUOvfJgijLGHNl3B6KJ5LfeEpdY
Message-ID: <CAFLszThptVQpasr4dHjstQ4xkq=91Mk6F3RZPH-Dx547PtQ=gg@mail.gmail.com>
Subject: Re: [PATCH v2 14/30] patman: Move code for sending into its own module
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The control module includes much of the implementation of patman's
'send' feature. As a first step to separating this out, move the sending
code into its own file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/__main__.py  |   2 +-
 tools/patman/control.py   | 161 +---------------------------------
 tools/patman/func_test.py |   7 +-
 tools/patman/send.py      | 179 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 161 deletions(-)
 create mode 100644 tools/patman/send.py

Applied to sjg/master, thanks!
