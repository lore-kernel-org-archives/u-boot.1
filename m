Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373D5C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91EFB83390;
	Fri, 23 May 2025 15:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NvY6ctFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27804830B4; Fri, 23 May 2025 15:19:06 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F31E832FE
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-601c5cd15ecso9036516a12.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006344; x=1748611144; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cCqVUe4x8wIn1AuMIxLxFpkf4iKZm6lnYmN/9xZCWjk=;
 b=NvY6ctFJ6dnvGOrzYpH2VlhOSH6rR5ehjVoKeFy/H5t3W5JS//WZqtYLSb5735bGiP
 o2C1dzi/c0AB4LmNE6YH7S8VL52CEg092Q8Ik/0wQ0ZxYL+S9TbtfbED+O/Sqf4WUgVq
 pkYiNyvYFulUL+U0U8wBj3XH6U1iYuCD5/zWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006344; x=1748611144;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cCqVUe4x8wIn1AuMIxLxFpkf4iKZm6lnYmN/9xZCWjk=;
 b=dWIqlZ8ppo1UJMT9NmDdZJDGNM7YA6GURkxqwit4R3IXwCuZOytlIOqQgvoiBj03xm
 tWm0YH9/ID4XzNU57RrlYB4ZwFTrF99K4VzYDtjb4qCarwVEE1Gkk9i7hr9jst8bIewJ
 eyMog0ghbFfqLDMWma4atoQdaflRQ8KiaYIntIXKwjlH9kLsSUKxr4V0lEjlVvltTTuJ
 zxa6bAZwIdtuoldddHGZmFgWYhkelE7VDVfuGz1i14xWXLKi133MqAoPwkjyE8lcA66L
 YVFshUmq3lTva3o7UJ5XQvMTCc9pflZAagVmfwLn+iIosF9tsQG/2NnlVU3aidjyShKp
 4Psg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbJYkX7TCR4fpqmIiZla/JI3P/9sFXszLLBhaia+N1bUntOu3ua8cVwLla2naj2jazz7iXhOk=@lists.denx.de
X-Gm-Message-State: AOJu0YxYcdkH8Nm85jb7BIfaKnMDybe+O/XocKJn9lKLacH7Q3N5Mq2O
 r5SZMFII766IqS9weMUVYUwlu5U6DxnlIxcnNhYVFBDjkO2skZ1Xo3mDkoaccREe6X6KSGmlyRa
 79OIjg/uvSwQeyHNB8PwOw5PfLnxJP4xfBn5Ac+WckIhUy4jHWu+OZW6K
X-Gm-Gg: ASbGncvJU9eEbeOOo1jx3hz9Sjrq3qvo4+VMkuiE0P9rhurjZ3z2QKuNvWGT124MZO+
 pxBL3B3fOJF2hcNqysSaioSmEZczAEGbr5VoMJE1Dwsqnilxpsf/mCi1lKyMSa2tTqNFVw9tKAB
 kGI25GUrQLNi/xxCzzt3bFZiz3Xb8/2xqQwQ==
X-Google-Smtp-Source: AGHT+IEjx1m7hjly2+Ubf7V/ARW9cDxqNozBcgaQ4+lFLqDhasrgLs1XRwiAFoy4zF06iM5L0GR27AmmC7lR4952EoY=
X-Received: by 2002:a17:907:3e16:b0:ad4:f512:733 with SMTP id
 a640c23a62f3a-ad536dce6e4mr2896147166b.45.1748006342728; Fri, 23 May 2025
 06:19:02 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 06:18:59 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 06:18:59 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-13-sjg@chromium.org>
References: <20250504132356.2317305-13-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 06:18:59 -0700
X-Google-Sender-Auth: 7EIbDU6zxlLitLB5TbmfAEN05ck
X-Gm-Features: AX0GCFtNeNi2ZuQKFRPu73t3uADncUXCyZZIbBgmW-BW8U5UkPi1Sv4CN5G2TRc
Message-ID: <CAFLszThjL3Rts85eH-CGHGQQ5cV6kbPHBbN42e5P_w+XjSLkRw@mail.gmail.com>
Subject: Re: [PATCH v2 12/30] patman: Tidy up the start-up code
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

Much of this was written before the other Python tools and they have
evolved. Make a few updates:

- Rather than calling sys.exit(), return the exit code from the control
  module and use it in __main__
- Set up tout as it is used in some places
- We now have quite a few tests, so update the comment about that

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/__main__.py |  8 ++++++--
 tools/patman/control.py  | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 14 deletions(-)

Applied to sjg/master, thanks!
