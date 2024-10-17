Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF646D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D9388DD1;
	Fri, 18 Oct 2024 01:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGfAqdC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE8088DA0; Fri, 18 Oct 2024 01:11:34 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F5188DD1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbd550b648so11403126d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206691; x=1729811491; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xFRCnB+zn+tcnGdO87f2SnbcJhhn4Wm1AXJ8h0HRwd8=;
 b=cGfAqdC/7QxlQJqelCDTO42HMBIDo17B70BTr27P7U4YbO7r7O2xpdqfw6DnLEhmZQ
 JJxzSj/pub0O25tyJ8fF4prGFDDjzTF6rQCqZ2jiGdZ3dfQHzws493BFWQW1QY6D168o
 f50dhAmFazR24BdhzWbnfIcmwgqpd9Y8VU8J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206691; x=1729811491;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xFRCnB+zn+tcnGdO87f2SnbcJhhn4Wm1AXJ8h0HRwd8=;
 b=EsjdSuaJwRwzf1No6b+97u9vDPDYgxdY0BFv/0JP6GLcrB0jEd/fm+Jmdr52/kcuof
 WSDWX+NxAPIV3DF/DdlE8SrsEutVhK0Bx533oguGjOOIyFWyDzwlgVhfHf/FmmamC6Z3
 yqkDQ10UuWxi9OOf6Dh5wlDtBSpTH+Ne/vW9yPbrs33BtDqtSio6U+NJW5IHTBJ0A9nc
 lCEWRS4iuorlj0vAoE12vLAYeDlGf2+Zd5EWFAs4WgIl4eKBKm7ljTmmQth71IBuBb+A
 xd7j8aABcYXvKfTSTzubfYx1B02RpTkKaic+CGo/YZ8KBIB2N00Nfoph5AvEtCSLOhMi
 /CWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlavosaKrXjVzOtJY1y3nGgqSmrP5d1BZHkJ4bXJdUYtc7y38+0J6jIeLBsi8DO7wnmWtK+to=@lists.denx.de
X-Gm-Message-State: AOJu0YyfkTyagBv4X1i+/icFwh259h3wZwJjO5Xxw7M7WO3pORIG0AFg
 oNeX5sv+kbWap+WEvtwHnOFLVDBN6kiI5ZZlhVXdhBl8N4yAB5lohzsybE+DlZHt78jHdDkKgaw
 WZ0LEsgDaGFvcNMsimogafrlye+bj9DVnspc8
X-Google-Smtp-Source: AGHT+IGFxS28HuK3GdZXTDE1k0SwEfj5cfxqA3sDeUPiFUbIGIc4sDPmGymp5PTK7FNjraMStvpuFa16brj1UOREt0A=
X-Received: by 2002:a05:6214:5b04:b0:6c5:313d:7cca with SMTP id
 6a1803df08f44-6cde14c0044mr5923986d6.11.1729206691225; Thu, 17 Oct 2024
 16:11:31 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-21-sjg@chromium.org>
References: <20241014223212.2212442-21-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:30 -0700
X-Google-Sender-Auth: kIYoQz89B6dwKCsNnRW_XqrVPwc
Message-ID: <CAFLszThtttskoGfpggMjsxgSi-XE7_V5jUrWNsaWPQ3TgHZPRA@mail.gmail.com>
Subject: Re: [PATCH v3 20/20] x86: Enable RTC command by default
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

The real-time clock is needed for most X86 systems and it is useful to
be able to read from it. Enable the rtc command by default.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rebase to -next

 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Applied to u-boot-dm, thanks!
