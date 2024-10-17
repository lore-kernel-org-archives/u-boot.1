Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B0D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE588911A;
	Fri, 18 Oct 2024 01:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lZSIT0s+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B55989059; Fri, 18 Oct 2024 01:11:41 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40D5890BE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cd7a2ed34bso1476336d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206696; x=1729811496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vb3uDrKZDJB5biXTqZ3s8A4zq5yw1MGkWzRKIPGkvSY=;
 b=lZSIT0s++/+BjuuSFnqhbKqle+H+rT5FG+vYB6nd85/BJcrH1DLm6LFz5rnGCpEdr/
 /sEH6rb4oVLp8iib0YW87+JXHMiis9aSp8z8lDJlQk3JUH26vaWEHyWFeDQmYFSyLKJi
 FaCE/CIyx1ViPEikDy5S8l/UQ0jwLwli+Nbo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206696; x=1729811496;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vb3uDrKZDJB5biXTqZ3s8A4zq5yw1MGkWzRKIPGkvSY=;
 b=p464vHxeKIpUbanJ97UGuJNBCA9DUi0lPoc5gkH0N2t+7aQI7EmkKya3cKbfS0BXSU
 bLp8pVcWCJGNHTExv9sjF30cRQnx8V5zb8CWpSgBf0n/kGhtwgsYWJQ95DBmhNiVEKgo
 c+i0pPPpztj+IHEPKuqCODSZJCs2gJShGPRw4ga7Hoh31jkIhoYapwk0XWM08Nl0oQID
 SuiPaUQb0Xr4tSkrEfesLmnLtyVf6LqpPj6umV2zYtLKgfV6Pbd1Vs83N8KLX4j+uFKr
 tJMbQfdHR9Sv8dlSxyRsQKd5zi7eiUhM+AhgBeSYd+V4SxpGjfq42jTBPGy2DRQnjK9S
 bZlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvKPaAbUMRBIJujwNlHMsWlZFLLiYVFVF/MpDBrNrPZFsr0L+/fJIkbydQy1TG3k5A5KUdIoM=@lists.denx.de
X-Gm-Message-State: AOJu0YxYdScDc2iIE/XW2pw8L04obeIQyerCjpwBXusN/xDbfRlFcdqj
 LaSFUuha1N5zEJr2lHWDZ8eR0E1n7P7Ppp9gcwNHSbxUfxhu4FY1Oba1vzC4uUuioCNhYKV1sLX
 KUGXMZ7QzJrr7RxNVU+i9nUU+DKJV3BlAzbU/
X-Google-Smtp-Source: AGHT+IHNHng3AyVnxTp5gQld3kGd2BMX29tWicfvsZxKlqO5pKW/vXqjnZOiRdalld+PmUH0fLS762Ai4/xgrcuzlcs=
X-Received: by 2002:a05:6214:3289:b0:6cb:cd05:cddd with SMTP id
 6a1803df08f44-6cde154de07mr7682626d6.26.1729206696563; Thu, 17 Oct 2024
 16:11:36 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:36 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-9-sjg@chromium.org>
References: <20241014223212.2212442-9-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:36 -0700
X-Google-Sender-Auth: mxqAzLjK0Zccnn-VnKEidnzty34
Message-ID: <CAFLszTjLB1i9AF6tUVfL6NO5R0QrQ70Lm4gt0sPzCGkTHLUz8Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] expo: Support menu-item values in cedit
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Update the cedit read/write functions to support menu items with
values.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c                    | 148 +++++++++++++++++++++-----------
 boot/scene_menu.c               |   2 +-
 doc/usage/cmd/cedit.rst         |  15 +++-
 test/boot/cedit.c               |   8 +-
 test/boot/files/expo_layout.dts |   4 +-
 5 files changed, 117 insertions(+), 60 deletions(-)

Applied to u-boot-dm, thanks!
