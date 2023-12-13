Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22435C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB555878FE;
	Wed, 13 Dec 2023 21:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ixWWW1pK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF0A7878F0; Wed, 13 Dec 2023 21:39:33 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7C7878C6
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50bf7bc38c0so8413838e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499971; x=1703104771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bg/QsZq09plPZkgOW0IhbaC2WIloLXz9d0swyWVBi0o=;
 b=ixWWW1pK4YtvE0xGR6SD0cqF7BVLCpbAisevwGCokDGBuuOgPjaS00k5W0ItHysgT+
 frlYsENWA2ZJ8CSh51qSdrgPrhjIKbaqMZgc6AdnZHF6nMA9z2V3wfZ5tAJbjwTfuRV9
 zM6cW2i9k0QkzgANv8BUvK6gKWdCWqE043MQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499971; x=1703104771;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bg/QsZq09plPZkgOW0IhbaC2WIloLXz9d0swyWVBi0o=;
 b=R/wc8CQIMjda36VgM43RGk9Kt7XzsjHxyOSV25TL+BW3whYa3AW+kr6rqBMHUrBww5
 Isru/lQErMNgnkBe/AO3EgCE8oVdezj3cY+ImUwNb/4xX0YSlmE6uUAfIMv4QRAqKYW1
 fhsW0iwNlQVeb4Z/zX9eyRmhJB9lxShBuvwhQvNb1O+PNnNqYUnl2fRJPtmfT0i5b391
 FPoxVk/Xcjkr+ObOJ9ZBXR6jTAOXnQVlefqLctDj5MpWrTHnRID0hHw/YdY+AdBV9yVG
 ILICBhua2qfk9+jXlawdbOgQkvropZfluwsjSC90OureycZ58iOJUNe5OOWa3AB01Ihn
 vhNA==
X-Gm-Message-State: AOJu0Yxy0m2S9/cVukq0eybaE2mlYUrvjVkSNwxs/EH7vvd3/ZWW2w5Z
 ZggrYfTvzpAoercldd3kGlW/ZULdGKQ+kIwaIN/CJw==
X-Google-Smtp-Source: AGHT+IEZoxKNx9v/nXKWZIHL91GLKPTD96m9VujpiN7PUw7Ol8VtQiNtHuSE+AY72ejZg7oEpbr29uOww9wxWNxK7p4=
X-Received: by 2002:a05:6512:718:b0:50b:debb:845e with SMTP id
 b24-20020a056512071800b0050bdebb845emr4210820lfs.122.1702499970982; Wed, 13
 Dec 2023 12:39:30 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:29 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-16-sjg@chromium.org>
References: <20231002011553.463514-16-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:29 -0800
X-Google-Sender-Auth: QX3Q3WJJpJ0ck8os6_KbVw6jpb8
Message-ID: <CAPnjgZ0JJKczBJxbarCht-_Kmmy89PSrZ1e9FcsW+XFBKZO6NQ@mail.gmail.com>
Subject: Re: [PATCH 15/34] bootstd: Add a menu option to bootflow scan
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Allow showing a menu and automatically booting, with 'bootflow scan'.
This is more convenient than using a script.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bootflow.c             | 27 +++++++++++--
 doc/usage/cmd/bootflow.rst |  5 +++
 test/boot/bootflow.c       | 82 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 4 deletions(-)

Applied to u-boot-dm/next, thanks!
