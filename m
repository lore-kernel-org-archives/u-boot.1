Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E61C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CBE83460;
	Sat, 24 May 2025 06:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uu3lH9c4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C83F83416; Sat, 24 May 2025 06:25:15 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF55B83440
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad56cbc7b07so63141466b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060711; x=1748665511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zHYisqdqxakapPb/tFs/KFC9HLAAb3vGRi+XELzXrYc=;
 b=Uu3lH9c4QWBU3AeO8mD32oQoWF2Si6veCGZCA0WxbAMTqf62Zi+uWhh3DU2XVwkY3r
 /gSLKJssK4SXjwxJ/3PP7y277klIQ6npfcB4fYrWnN45qV5bq6f/xkqYfZgGR13+kXQ5
 OqpPLU1bpB8QB5QoynSLtbR3NXOJEg/pV0IGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060711; x=1748665511;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zHYisqdqxakapPb/tFs/KFC9HLAAb3vGRi+XELzXrYc=;
 b=Wc066mLKUcKads92LidTDxKOUdbwYrwOb2A7lBtOZFVeO0qyMB35GILTaEo+CdZOfY
 mqQUYBkrgFYhEOhA2DyrGunejjTNyXY759BuEsKnMr0zIOVBQmMNIGsCio4gSymdvQ1Q
 fwgWwTTI3VzUn4ha+xPxGg0dBLvVaWV+at32soKfusn7+5jU/KuS8vbXpTHB4MC2A4k2
 /gaLNaIVFcdKtIlDv30KZaSShcU7aNZ9/CXDzMMuY2JWEN8AyuJnp08u5H9khN85zVcM
 eQjG1lRvu46VA0F61QO6Es2VROZZEvl8k9OWOU/bmpxJL8aAGGK4IlPJTQ1ndPIgjRdm
 4iOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoLgtMk86OehjxSG2jmtt0sPBUoi59mxIO8KuLCEodZNJk4NRoZzplQtIp2JUBkR0RITP0M5E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3EfIMLoUUa/ITTYB6SxJxhfmYm2bIhKTmrFoHvT5Cv3TTnp1/
 PcoDr1CtT23GbqmeE97ik8pax56FTyZ97/a2pQHgmgwQSofbwcNXxGcjiUVYB/r5tll50Jsd04V
 hn8dZvXeqI2DpbCOvO27Sho2Y3H84mOFQLRLKDJrI
X-Gm-Gg: ASbGncue45354PBr1GYIa3Xz8ROXLpKxBs9CgpDxLnZEZ3y8yxP8jT6k1k+o+8olwtB
 7NbLd2b1LvAPqjlgkT7UDZzUpCE1SHLsH4bWOIG0Iz5hiP8Ohz73EqheBMsk2eu72oFWVKY6bxa
 OT/le0pSPzx/U9PViUE6fmwGOI3yltCG4=
X-Google-Smtp-Source: AGHT+IFkghL7Tu5WNRf/JjCjDZ13kaVRdZvrjd1w+vXYaRE9Vogj+Os+ZQzp0SIXGXoPXRRiPNHsVGxv2fN1mM9O1sE=
X-Received: by 2002:a17:907:6d0c:b0:ad5:54e0:4c97 with SMTP id
 a640c23a62f3a-ad85b211e8emr116471166b.50.1748060711329; Fri, 23 May 2025
 21:25:11 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:08 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:08 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-18-sjg@chromium.org>
References: <20250508072907.207175-18-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:08 -0500
X-Google-Sender-Auth: M_WEVxg0t7Mrd9ka7qTboMA_0pk
X-Gm-Features: AX0GCFvK4QFWGftTXb01lUUthJtu_7EQsTZPzi6sMHcDfWj5Eryc7kvgtpFiNvY
Message-ID: <CAFLszTg+qHJ8vom5yWF7MnWzoWqC1Y+T6UEHFhdSYv2BYF5HBw@mail.gmail.com>
Subject: Re: [PATCH 17/20] patman: Move arguments for sent into the correct
 parser
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

Most of the arguments for the main parser are actually arguments for the
'send' parser. Move them there, in a separate function.

Fix a pylint warning for -D and the imports while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 124 +++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 52 deletions(-)

Applied to sjg/master, thanks!
