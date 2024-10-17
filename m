Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8668D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0D48911E;
	Fri, 18 Oct 2024 01:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C+pwsrad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61B5890C1; Fri, 18 Oct 2024 01:11:46 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FECB8910B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cc250bbc9eso9417366d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206702; x=1729811502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qU0izWqtNwqELxv1BTmxHlV/fT5YT9JlBGFA6aOK7iA=;
 b=C+pwsrad4r1VeboUtCrs7ELanoDifXQQemmoWgbCQ6ftjxYyqgBFLQq0/Qbk6nhwPw
 r3mK/5cfB0AUn3NS6wZdEJLyov+FeKyk753L2K+zhlibnEmUDESZql2gbAdXVwCR4Mb8
 VZqGByZuIkuO00r4dNsKitOz+by2t/bscNMJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206702; x=1729811502;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qU0izWqtNwqELxv1BTmxHlV/fT5YT9JlBGFA6aOK7iA=;
 b=uqBUVQwb26irB/hyq+aG3VrmbwhLbqles1GZSOu7msNi/iFKWa3qfNgnKTANCclh0Q
 PRG+Lf8dq9Ldot/FqfS+pwTdtdONlivhINGWlhH3e4iPIIu27oV9DtiDoCITuTNQGcOI
 Szh9NE36rBiw96lu87pmOnXU5b4BIQJZLvuxNASq08HUiXIryD8+UeWPxtNKwGdkMzqe
 T/UInFRfIJiIhDyFmbKay9t91Kj9pjvSImu9lE8/YIxuk5fPywzl3wbT8MY6xVaCeJ9C
 AtWp2Vo/HkTDJnw4kyGZE9AW0VnM9+STRkFkEikStgUScqVjC1fwE08nQWjmd+t4xAK0
 i4ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeCLMKoLnA23OOXBZ2Te+qfhDo4bOTQFDU15E5YLFX1ZY0KlrkZSfO1VAD4dHXoXJL/8Fme1U=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq+54weMgxBaT4ZwkEJ5Aa5x7LGstbkmPQZhYRico2hkPsBVYe
 rXHrt6RqanTcVS73El99VbZyDsNxyym8xQVL6fBFDhHMCeHFdAFbSxUAdCSHJ4aaCFvKdAPqS9t
 M4umHmPQUgi76vLw6Y+URlDK6LoUXDKak9dbJ
X-Google-Smtp-Source: AGHT+IHqQjePZDLFLHC/V84G1LL70ghtCj5O6tPxE4ZjCY/c/LC/OealQJF8X1ye8HEkwoCQn7RoY/nNFGcWVMKCGd4=
X-Received: by 2002:a05:6214:3110:b0:6cb:5d17:62df with SMTP id
 6a1803df08f44-6cde152e3b0mr6801136d6.26.1729206702091; Thu, 17 Oct 2024
 16:11:42 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:41 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-5-sjg@chromium.org>
References: <20241014223212.2212442-5-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:41 -0700
X-Google-Sender-Auth: 8Vmx-YGmhCBQsQ7oDZDhwQA-kIA
Message-ID: <CAFLszTgp9_4WcCMUNHSYw=bt_Dk_QgPNY-qeYoMpgFHR5HWEew@mail.gmail.com>
Subject: Re: [PATCH v3 04/20] expo: Set the initial next_id to 1
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

If expo_set_dynamic_start() is never called, the first scene created
will have an ID of 0, which is invalid. Correct this by setting a
default value.

Add a test to check this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c      |  1 +
 test/boot/expo.c | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
