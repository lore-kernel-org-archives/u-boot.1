Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4B0C5AE59
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 19:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246FF82C67;
	Sun, 25 May 2025 21:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jY1XsJvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E3282C7F; Sun, 25 May 2025 21:44:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F5282B33
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 21:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60410a9c6dcso2575923a12.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748202277; x=1748807077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QZv8XQHeRPl1kHCye3hon8D1P5toburQgHLCkAoQ/3c=;
 b=jY1XsJvQunMfi8rEJ/5UCfpS0ISyI6rnyhySfYU8dWpV5O43YbIx3qP9XE5s9EXrQn
 K6YeMOtnL3CAdNvhXCGZxBM9mQ8FmtLGi1QFXkPLTqXqaXlvR2qQ8s6mbqiyuDFm5Ufb
 faAJfF8AQ6at1z73fI7e873zwmRJCdaFG0oAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748202277; x=1748807077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZv8XQHeRPl1kHCye3hon8D1P5toburQgHLCkAoQ/3c=;
 b=byzcSVJHWe2M97HOdZKQCVYPV5/OLmjIn8KIbRsxuwuvpxqawqxsNxM4BtofUfl39P
 wSwXF//GsUhAOAjOdzAuDfoLJ3T2/9pHEu8aEDpJG5k12SdFLm3/T4sOJAml5i36V2cI
 HyARel8REwhPkVr/nZwD9fNbxjrn0hZfSbGM0p+nCVxAWLRHgXoLyQ7EgAPPPQ0GM7fr
 kY4abhVs8OR0/zwZu0FgM5A7p6JFERk3Jz6EQraW7y5FTi5N/9EeIyJOqcfWyYdA/O2A
 s1yk6IbYf3uVxvrDcqSMI7UCX89oQ4vVNEZXcIN6KKO5K3SArsYyLIB6VjNe7QnR4cq0
 zlyA==
X-Gm-Message-State: AOJu0YzUdyVCgNa0uW71UP8ItKLKCg1Ycn6OS+E4zz5Ujr7YSNlzWoWZ
 NgyWYOQa/Ec42oyzKLne6wJ1VXZ9krev5pp5tHuZ7CgON0ot5R0Cv2wX8fljgZX1g5KPRkD+ymw
 pdVT3WYs425r6ocEa0xpJRsnHWq72zOoBIMY7nSFS
X-Gm-Gg: ASbGncvJc3zQmeDHnTfqRnim2AGBiMSfrfvRyJwMFuARsZG6rfPIykb7ODFoZ/c+A61
 djKdn/xeUHGtPzm51Btx/E8mWToUn5cdPs9ofULJqjHSUvZ5jLEXw8tQ3swxbMsW1QrNmUr9DDT
 ulK1sI6pNBzxeiAzkX2MHXebGB2utAoQk=
X-Google-Smtp-Source: AGHT+IH4m+V64zjgj3udAFSUaKp06E+4db2PlgmcEGZhcK5IYBf/qVda73WYcksUlb4IA34B6b1+LqaxHgNWF7wtS0E=
X-Received: by 2002:a05:6402:26cc:b0:5fb:c126:12c9 with SMTP id
 4fb4d7f45d1cf-602db0c06cemr4993407a12.25.1748202277474; Sun, 25 May 2025
 12:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250525104801.1440260-1-sjg@chromium.org>
 <20250525104801.1440260-16-sjg@chromium.org>
 <bca898a4-cb1c-4b78-a2ed-4f7e6025a3e9@kwiboo.se>
In-Reply-To: <bca898a4-cb1c-4b78-a2ed-4f7e6025a3e9@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 20:44:25 +0100
X-Gm-Features: AX0GCFsjeQ-BIBjLyhuumE15ZiDOjIBZQRTh6sgzPaO5pVckNX4p6ohEcX_bPEI
Message-ID: <CAFLszTgvGUC42tZz0K=xg-rqXKAJyarZYPP05jPiB6KSPfTEgg@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] rockchip: rk3399: Adjust initial TPL-stack to
 match SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Sun, 25 May 2025 at 20:25, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-05-25 12:47, Simon Glass wrote:
> > There doesn't seem to be a good reason to use a different value for TPL
> > than SPL. Change the TPL value, since it allows a 256-byte bloblist to
> > be safely located above the stack in all phases.
>
> As mentioned for prior versions of this, this commit message does not
> make any sense with the current state of SPL stack used.
>
> This does not change the TPL stack to match SPL stack, it only moves it
> to make room for a 256-byte bloblist used by VBE/VPL.
>
> Please update the commit message and subject to reflect the reason for
> this change.

Thanks for the comments. Yes I found your comments on the previous
version but unfortunately not before I sent this series. I'll take a
look in the next few days,

I am looking forward to getting this in!!

Regards,
Simon
