Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E383C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C24F833FA;
	Sat, 24 May 2025 06:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j3CioRyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD2583560; Sat, 24 May 2025 06:25:50 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69C283303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad51ef2424bso83854266b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060748; x=1748665548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sbryJKW/1kOY1RM0CsyxCL8ZGv6CU2D2Suw7lCMM6IQ=;
 b=j3CioRyZw+gJFNSxZxNLSDA7WBKiGLoHwAjL48AgamSEiG8PEmgQKhkLTMXg8dDcbv
 EEbo5SXNFJBt7LeUSJgv6JBnd7KqArUP7M0SGWLXkY05LH+Gyz8qtyoqYeh1oHri1OWg
 eCHZ0YaRlClOIVNP3sn5FUA3HYK8re15nE2CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060748; x=1748665548;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sbryJKW/1kOY1RM0CsyxCL8ZGv6CU2D2Suw7lCMM6IQ=;
 b=U0qeRM9br3zuB53AoW/qMKXHbUrPhcKzYk2YTVWrktXwSN4bulA0+wb90y5+CsyZ3q
 jEXdiZhBMxSHoUh+hl+3tnsPUos+dxx+n/5xr7LuQREc8bkqHFuNVNl9D/2LN546/h8k
 VMJB6gLjJ02IAM84S3u2qsOV6viwIRq3QkzAFJXAaz5sdebdcPW119K6AwFewG0GPctI
 h/0dmfX2lmSght8hvBS2qmG/n1kbF7gEohOk91XGtrTa632iWoeXnmiIPKnHCPNIbEs2
 eC4SVpOLlAshffUKUAXDDPMQz8jZTq0JZbMa60VEK9TVsw8coxGEl0VMJDDZZ6ey0g6Y
 v7Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/iXK2BPVr4zykG7PbXNNabl9VPXqx5LKbtrcSvyenAAoAa3VDleyxt610HZFICey6vlqu2/c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9xxZLSIA/yzJzKh0MPwV8E47vo6o+tlPCj2O0RHVyZmBPwEGo
 FK1hkDfLbgAQKv5jDgKGIcrZH1uI+Zr4CkauHWVj81am428GOrQ9uAJPwfUOXjZGBsahDeP0IWG
 D5llkOwB28G25qjNqJf15YctZ9VboA5v/F6NY84K0
X-Gm-Gg: ASbGncuMgAIJfb6WspUYZkbK2hsi9Hy/Z3AA22DLgPQWJl75gH/wIQZVgLRitqreESI
 MoeT45qPW1OYxXcmkEHgv3kM+eZAxHvitxHGGwVrn+DObHtXwFuy2WakPBQHW6YhIDD1hYtclng
 IhUj1lbZT5BlPAb55KbHMS7JGeUBWjzSg=
X-Google-Smtp-Source: AGHT+IHL8UWvu8g9LdIbe45nVaOHv3zYmN2oMmNeFDd/9h+44EH7YD5DoWdZmiN+zz8BeXWWIpweQg9Nn9wWPe2Q3l8=
X-Received: by 2002:a17:907:7b8c:b0:ad2:4fa0:88cf with SMTP id
 a640c23a62f3a-ad85b120214mr123197466b.6.1748060748432; Fri, 23 May 2025
 21:25:48 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:46 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:46 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-5-sjg@chromium.org>
References: <20250508072907.207175-5-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 21:25:46 -0700
X-Google-Sender-Auth: DzAWvk-oTue6_h25hUATaeciWu8
X-Gm-Features: AX0GCFtOTzIiZBye7aHnjoHeLvX0KzbZ3tT7WfV88FbGNu6YCbBEevn903P_984
Message-ID: <CAFLszTjcW_3sSh4+NCZdCxf=tmf_y7S2P4o_BiHRKDkjBbPVLA@mail.gmail.com>
Subject: Re: [PATCH 04/20] patman: Add all files to __init__.py
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

Some files are missing from the __all__ list, so add then. Reformat the
list to use more of the width of each line.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__init__.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Applied to sjg/master, thanks!
