Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD03DC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138428894E;
	Mon, 29 Jul 2024 18:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kwMzZZQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DAE88867; Mon, 29 Jul 2024 18:19:48 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA09888B2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b796667348so27543956d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269985; x=1722874785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M+GRCuFWsoCbY3M7GUBrBlzVywNkUoe0ulaQhJszl7A=;
 b=kwMzZZQ7z5FHr3pZeklHTo1t+Vm5onXg7OAVi2IUBtXahshZfjS9Gb48POt0ORt2WE
 6Nct+dMUm3g83jl3EMTuMCbVM3cLN4ipQCTenlCQykK1yy52rrphGcDfKpJXuDoMsr5b
 VuSNHMpaCljlwlx0ypZUr14AndPl+i1TWObHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269985; x=1722874785;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+GRCuFWsoCbY3M7GUBrBlzVywNkUoe0ulaQhJszl7A=;
 b=pH6MUBynnIeqP7TjMIddKPIYWsJjPQVp0VnrZHRwMZ3g2U3hHMhARAhpR7SATPfw2i
 CtIlpH6lQMoE1qaXCmMemVVNLgTfKUbrht0RwQyvxeIFAZ/2XyRosmXtX/5cSaV8vK1t
 hiLlNP9SUD6yhPIZw3UVXnq1AdObtI6+/TnHZ7m06xNIk3y7vyByUpr9oFkZeLJggeFC
 4uuh2rz3qnVk0aieDgZ7GzjWqWCxfPY7AbMiyTazwzxWJd1xP1nDMoYbbISZeOoJ32PZ
 6hOg6MX55Pa6kPA3WA9MS1YbGfWGcT+Qq1F4DBx1k4iqK9yZN32gR7y6LKtZPLULoRzW
 Fyzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVZwpCrfIHuqzYIFUXClUlNtXE6OWbAQrRHE4lSaJjOvC1cJVgysZxlBUCpmM7TRK0algycV+zX/pY9J4laUZuny/+EA==
X-Gm-Message-State: AOJu0Yy7mq1rXIvu7SwsdFhEhh8L+63PPjM39bbwz/VnI0Dbjbfrf6s2
 548lUE1nfOYmoXr+QyC8B1RJJ5ipPvcrBu1pcwVVCzh+8qpIaveci4oaZpE17zUPacasF2yQ0Pc
 0YeBInX+7sGtAxINWFs4Ew9vD5AfX99XdZ85Fc0+PZUKSD0s=
X-Google-Smtp-Source: AGHT+IEU+NNR8FGFv1Gc0wNCsKldLbiqFTYZHPqsVjsbrEFhcmwK5FPtABbFjemNnjUfdVYBn8jH55LyK5yUoXSNjyE=
X-Received: by 2002:a05:6214:5009:b0:6b5:25b6:dd04 with SMTP id
 6a1803df08f44-6bb562e30c1mr210425056d6.1.1722269985417; Mon, 29 Jul 2024
 09:19:45 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:44 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240718091125.3788990-27-sjg@chromium.org>
References: <20240718091125.3788990-27-sjg@chromium.org>
 <20240718091125.3788990-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:44 -0700
X-Google-Sender-Auth: sOQ3L2cZKrpzydKzT0nUpSj5DMc
Message-ID: <CAFLszThtbcO1jrP-CEQk_Em0gNgxt82pqXMnNp074RnxSQRiFw@mail.gmail.com>
Subject: Re: [PATCH v2 26/26] qconfig: Support a 'list' format
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

Add a flag to output the found list in a more user-friendly format, with
one board per line. Omit the board count.

This can be useful with grep, for example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to support a 'list' format

 tools/qconfig.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
