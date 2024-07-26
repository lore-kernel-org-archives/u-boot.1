Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689DFC3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55A0885BF;
	Fri, 26 Jul 2024 14:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gDoOawh7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F407A881BA; Fri, 26 Jul 2024 14:58:57 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B03884F9
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-447d6edc6b1so3129901cf.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998734; x=1722603534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uC4GRnkBo0fMk5/wVZTMl5tPJbkZWvvWypn7OnAl64g=;
 b=gDoOawh7Gg2xEzISyYSwUFQC8630AnmlDkX70PB0WaKBX/lKLESHQFufC4b7KAw6TD
 oCvH8sMXIHI/W4eOOUllhQ0PIbA4bZGaUPkUtY2w8AnsaYiXIithYMI0ZsSOkv5d9q2z
 EatMawTGTfWAKn9tXTWeHHHaPYAtGiBKBnhkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998734; x=1722603534;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uC4GRnkBo0fMk5/wVZTMl5tPJbkZWvvWypn7OnAl64g=;
 b=VYpYZXPgn2/oZfgh3TQL74en9Vp22wmze1PpWPaYc/r+ybOUzJJKT2FaYzjTgZq7+4
 CA3amB8d7mGO2020kDyxmVahbf2/DB8iwJ71+wSNc1Vhw+YAU2SQluMxNV47T4SpxYPY
 IeNzMkRmginmklhmlVBCnT/lUharWsCCgVECAUcsGpk30k07Gf39oOJyhnLs/1EmuSB8
 ko5AkZKp47XOWsmXKchhe366uPVBpv8iSmkz/vhosB/YM8p9E4kOxRoVsb7u10XezSdB
 8gcFhElI8Y9ZIa7Xh0c9EZB/XNBW9yZR5p/9awkUvJF/ylaIs0qfN4ICHYDH8AIkpiB2
 cygA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd0FXGYqlP29lS+4ji80o7HbxHmq/0uvuMvA0d9ZtpK2NfA9NrThzlPzR1MYpKOb2g35uEMZ4IwZooA63b4mjaRdKHvw==
X-Gm-Message-State: AOJu0Yz2pvJDKBGBD8CffC4/6wF9MlELawIyTMaPkHjpoxu+0wg8rtST
 T9Q7YZquAeDsWkCg7Zj+nwX2gxJ7btZJ4qEKvmYyBv3dalMp77WuGXXMHeyJ+mcz+auhpeazYHG
 5huI68MUS0Y7Yv49rZ28+OeAjFUiWtOAhtcUx
X-Google-Smtp-Source: AGHT+IGfeU21R44ps+Ov/oqDaAsTZ5L+PrGAS6+em9pQrppV9Rtm0ULYRFx4ye6ZgQ1tf/XKfVzwasZ6V2wtt11kCAU=
X-Received: by 2002:a05:6214:f68:b0:6b5:e377:38a with SMTP id
 6a1803df08f44-6bb3cacc529mr91513686d6.39.1721998734581; Fri, 26 Jul 2024
 05:58:54 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:58:52 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-22-sjg@chromium.org>
References: <20240717155712.2913651-22-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:58:52 -0700
X-Google-Sender-Auth: dUTP-N3xl-59CjFRNpeXjBoEdPI
Message-ID: <CAFLszTj8DTLVm7D55e_RKw7PetsFJm3vdpTVQ38-Jgu6Uefnig@mail.gmail.com>
Subject: Re: [PATCH 21/24] qconfig: Use the Color object in Progress
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Since the Progress class has the required object, use it from there
instead of passing it around.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Applied to u-boot-dm, thanks!
