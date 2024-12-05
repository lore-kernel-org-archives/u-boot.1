Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB81E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED2B89583;
	Thu,  5 Dec 2024 20:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K9AQUkRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B1489580; Thu,  5 Dec 2024 20:55:47 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4F08919B
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa62f0cb198so112560666b.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428545; x=1734033345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xa3vCC3KueRmw8uNzO4sXAF2rCBfAMkY21aDGa7wBRw=;
 b=K9AQUkRyxxJCpg9S3JCslHTGmWqUT0v+59P0AjQ5W+WOdZENS0NhYhXm1LHzCRfOGO
 yzvl1eCVk8LDdPsT4dy6HTY1irTcFQXSdWkJYB7CW97qm/8P5M0WcEwtQpTIYE3QKa8C
 roAUOGQ3EonpHqMqMeWlO08BXyJovdMaybANc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428545; x=1734033345;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xa3vCC3KueRmw8uNzO4sXAF2rCBfAMkY21aDGa7wBRw=;
 b=WavNlagDYK/oDrDJDso7ToAbbxzutw2Bwp+ZsMByMIe91hWEn3MJtPQXj5lC6IDWkX
 G5BNC2UeOFqj3n6eTJpzONK5ayDfoKvnMcndJfIc9nJpVBwSbJHP6Zm5VFDEwRHR1tp3
 MMntUE7CoXXlE2yQddekAkl3tj9HAS/j/Oz72a9YVaFpdMXYQr3OnLNIv7brW1opI4jG
 GWxibEzglWlxHa4TARYx1eEs9+SRJzvv/1hEtRGclXbfLl2sDJQJH6bbvXcgS7Z27Cj5
 fgEmKGLfCFz/AzenscFNHi+uzCZUQ49CFjLgechOqfrLkfOsQWb0TRRJNFPNudjJwK2M
 bsdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg8FH6AYlLA8chxF+iMNbVWbp4zWE0YAuMaIGirJtIwyrlTWOfc3bQyHbqj6LB6hFQ3Zu4Z7M=@lists.denx.de
X-Gm-Message-State: AOJu0YxsVvB4wiXkYILMll9sf2ELG8PIRrWb1XoTY0OqJzTEXa4VINOH
 DmEkN4zmMZ34Hp1wSZja8cz0QfREwVMheyvS7yoOj2m2icpsIv8R1iBlmdC6WCruX+TjAx9zS7s
 54HTahwB/fI2sstxA2fCbf1j8HN+8jhvkiwiG
X-Gm-Gg: ASbGnct5obURt4AcZYG23tZVzLwoL/NlnR67E4sT4QJ7qDdT3T2+yrhRLNJwuNwf1pQ
 lsJlh4HHW7WSFHomWAYXnVd0RuRURm855
X-Google-Smtp-Source: AGHT+IESYup/gkJxrG7az6qEElekrNzJK4rXeZc5+uMTFTWZE1HqCJH31mNd0P0xEFR0YiXtMMDYGYH9SW+veEnF80w=
X-Received: by 2002:a17:906:18b1:b0:aa5:639d:7cdb with SMTP id
 a640c23a62f3a-aa63a014017mr7290866b.22.1733428545392; Thu, 05 Dec 2024
 11:55:45 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:42 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-14-sjg@chromium.org>
References: <20241115231926.211999-14-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:42 -0600
X-Google-Sender-Auth: COhzrAyj_fKRZm0JX2oVpawb3cQ
Message-ID: <CAFLszTh-8XXrkt+9idZ3_wNpGLsot8D-otMap71=xbkckKJfFQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/19] boot: Update pxe bootmeth to record images
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Record images loaded by this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use the helper function

 boot/bootmeth_pxe.c | 3 +++
 1 file changed, 3 insertions(+)

Applied to ci/master, thanks!
