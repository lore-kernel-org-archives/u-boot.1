Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D7CD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F5C89185;
	Fri, 18 Oct 2024 01:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bzOQvy6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0613389160; Fri, 18 Oct 2024 01:12:20 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE44789121
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbceb48613so8769366d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206737; x=1729811537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yv2YzTPMWG1LI3FjAusM+MIycI8jf8ukBpngvHqgUxQ=;
 b=bzOQvy6HuvnudMCkL2eE7VUM4FAgFdPGYIOMmnnkL2LwRf3L6Zh7KxLU/nE42NWOld
 owWWv5W7CSPqe3ttd5hjRUFAgv7vK8obpoEP8h8/OhljRb7fMepIvoOUnq466fJMl9dt
 GNhu78TGm7D+QOXeZ5BC5p/36/j9n4hGxI+BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206737; x=1729811537;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yv2YzTPMWG1LI3FjAusM+MIycI8jf8ukBpngvHqgUxQ=;
 b=Sc2afcreRU6fdHTg+yQCIHZf4L01ohKSmi+0IbilXy0VJNuodkNNKiGley5Igq23na
 D7BmUfkSGwcR75Dg/57qG1tPbFMalUN35Jqaik/QHUJEUrdKuGv8dYAICOeL2Dll64gk
 A5/1d/hCupbtrUboQbsxd362FQexk++kVlLTgNpD9gc0nqfXyGgqTUxXegq54R/oQgp6
 JBam7k92R4vT9u4ChBteR/1ze2Mkzftu2SM0wxtKziC5m3SpDOrIhdt2SYClqW6hk8vv
 Q/tnM/SxmDgXRfaT9eeaHdW0iktlI/Uea8yzUkc1OffXsM5N768UXFriOUw53IrA3mui
 RmWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX82fKfesn25VGSxJoPhVR+urO8v3TaUbUE2Uk034JBbI9TY1g4V229eUaX5c8zkl11gT4Ea4=@lists.denx.de
X-Gm-Message-State: AOJu0Yykx74hd8IAaOSOpxt5lU2m8yKqNmEfuRJ6HtTnuDBirUl/pzEj
 kp83Whxjc4QdQryuBX0AUs2HewX8uaeqyVKta0ckMBn+MEncs81jh7pZTW9hCb0MeWXsvTmpHnK
 emrxfJs+fgYe13sGYt5JXE9H+HbQn+Elv0rgs
X-Google-Smtp-Source: AGHT+IFsT9Wiw97O0XfHf0i85VckLWlvvOo9ARl1sBNFLBn55ZC3MOmhf7LiE29Z15dN9YbLPQQwIb/dwwLRB/CgkCo=
X-Received: by 2002:a05:6214:328e:b0:6cb:f561:2a83 with SMTP id
 6a1803df08f44-6cde1632fd2mr6054586d6.43.1729206736890; Thu, 17 Oct 2024
 16:12:16 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:16 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828014429.3320011-4-sjg@chromium.org>
References: <20240828014429.3320011-4-sjg@chromium.org>
 <20240828014429.3320011-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:16 -0700
X-Google-Sender-Auth: _-5sOhI9DAAqntuht7VXGPbRwqc
Message-ID: <CAFLszTg_UWt3Gs6SL89Jbmynz3xPXBwPaUr57hF3YfQ2Q0WkNQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86: Avoid timer-clock overflow
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

When the clock speed is above about 4GHz, e.g. on modern PC hardware,
the timer overflows, resulting in a much lower frequency than expected.
Deal with this by capping the clock speed.

It would be possible to move to a 64-bit value for the clock, but that
is a pain to deal with. A better approach might be to express the clock
in MHz but that is left for later consideration.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/timer/tsc_timer.c | 1 +
 1 file changed, 1 insertion(+)

Applied to u-boot-dm, thanks!
