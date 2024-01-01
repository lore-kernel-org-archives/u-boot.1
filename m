Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B279C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E22E878B0;
	Mon,  1 Jan 2024 17:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cUtm6yZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F958785D; Mon,  1 Jan 2024 17:49:36 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC8187867
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f7bd86cafso79435596d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127771; x=1704732571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HloyThePJZQlyWlsXoivzZ8nZokVkV882A5V/Lp0QlY=;
 b=cUtm6yZ0XbfhOlWS/kVb8PD+IkH4zZiopvDB7dsHWI8pSMwnp9vFkHSymMsev5ebXN
 6eAfFsuhapdKNMeXrPTd5l0XGdG6CzlUSjjVwCZ9wXX6+HIRflZinKl4Khd98hGKLGG4
 yKMUBlXZ9iWSAdJAinH5R2f588/sewTViXUl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127771; x=1704732571;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HloyThePJZQlyWlsXoivzZ8nZokVkV882A5V/Lp0QlY=;
 b=bxQ+AGA0RmHpnS+N7FzF2/i9bCFPk0M49zX7BXSEubTSD5eH224z3UfBxLACoZJPk0
 qBBEdCGdltya9wgsazjPhJ5r/6kxQwBZRvaoCbt7UaQWyX54aIROQOt88Ji9pG0jhFLU
 tyKzZC0iOWP5kQsn7j2gZcS9h2NCh4BtgxEAFRyVf8hYmBvNPNgwfmZrJrZ12ZSuWcy/
 0eG1lUQf4FgZgrA7ijsSa1Kf0U+19SA8JeWvfwCjNrrhnEWo+tYE82jL0J2Eoq7KZETw
 c4Y1GWxPiu+W9aomKrYdjP3BQ6N7t/JX1BK2UHrKi/5LGRWNG+EBuPREpcLGwMWEPleM
 Zd0Q==
X-Gm-Message-State: AOJu0Yzu/pjNUB/y+6QeNblC+ngobLW7GIdflT1nfg7m03TpBVSZ2AIH
 E9JF0U1dIwZro8xjBi1kUQitxUW8eXClr8qGwlns4wELAoWFYlh/zD1srAnMDw==
X-Google-Smtp-Source: AGHT+IFZpgPk21ZKS00/X8a1Cco1i3H4WS91zDYPeXSfPjDUFJkjqwUGaS6uj24A3xIApQz+YvttlYJe/Lm1rt19KSI=
X-Received: by 2002:a05:6214:b64:b0:67a:94ae:7d06 with SMTP id
 ey4-20020a0562140b6400b0067a94ae7d06mr26973422qvb.19.1704127771411; Mon, 01
 Jan 2024 08:49:31 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:31 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-2-sjg@chromium.org>
References: <20231217163627.2339802-2-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:31 -0500
X-Google-Sender-Auth: JhIKmsVwMbhMrr13IMdiSMvJIuo
Message-ID: <CAFLszTixU5dNyM_uH7ZxU09uKt2qDdtrggRA9aM64fRQ=6Y08A@mail.gmail.com>
Subject: Re: [PATCH 01/10] x86: coral: Align bootph SPI-flash subnodes with
 parent
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
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

The subnode has different tags from the parents, which is not correct.
Fix the subnode.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/dts/chromebook_coral.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Applied to u-boot-dm/next, thanks!
