Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A05BF34C5E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52D7841C2;
	Mon, 13 Apr 2026 16:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fyh0THlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA30F84222; Mon, 13 Apr 2026 16:57:32 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943F0839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2addb31945aso27424025ad.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092249; cv=none;
 d=google.com; s=arc-20240605;
 b=ciD64os6m5a2qXvNeiW/S6I2K7K1+GiGUQMeuLhoQ4KQ/P13wbAQE1b9AoCNGPc4lR
 sL+7eoiQBfbJZxl/qcEkvx5uQfd9Ai5NlSB68x/ZS3GxKDiai9EpPB7ELGhykEjtnufQ
 8ffLF1XZKdfUJo5/Z6v2b+cXhzgYMlJoizLQKCtxt7a3bdPic8JaIScdYS/hcqtLApzL
 BRh2+Tj0vnENFWZD11NDKlYXU3Q8pTN+1+Y36cr5meJ9c3O4D1CDTSRxWsIcFiC1Ima6
 a5WtxOr60NefttEBpswED55GH6YZ7TRgPs2Rax/Gc73WDelBDewUw1PdO1xOsYeDbsBL
 G2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tQdewbT840Q2kS8U8J5AyTyNzsfkHprGuYEFIkF5QD8=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=lUa0gG3Ca/+XRLAxFTI/YJzdMKj/2dcbDW4fZvtGmCJYjjWfWRIViE+ZE7eK/YZj+X
 qeOJCh/4gWdx4AQAIgdgTSz5j/cErIZrqKUaQHOkMa0Er+aJl02NVWIShQsrERzJ5pKG
 m8hA8jtrl4Y6No4ophDpIFI98AKVGtfFDfZSIXZplzxeVnRDCR0PiuhW3jHQbM22j+5a
 5NkDrB+LW9Mym+yravMKEW8fN51HBOHOAWepCkkd8WE1HC1LbXY4Syn8ActXCX/le2jq
 ivNPgSsi9A2jPPCSZPavf2VciA0ul1xelFL+KUcoCuAAUhPvoUrpbJli1mNthwCc5MGJ
 mNew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092249; x=1776697049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tQdewbT840Q2kS8U8J5AyTyNzsfkHprGuYEFIkF5QD8=;
 b=fyh0THlAfqajopUlfFxGh4WXXIXNTRt9HhBI3EZ4jO5L8vTIb9oKSAvHniL5nyODNu
 Z7aI7Qnhbc7XCoaE99Z3yTwlmyLAoX4oezZrKwveuF91bK7ow4NMqe8wLk3eM6UscTKG
 PUu+jxQIbcK7iTzAJXTtloiQg77lxi4/qc/LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092249; x=1776697049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQdewbT840Q2kS8U8J5AyTyNzsfkHprGuYEFIkF5QD8=;
 b=XSqJZdHn7CjstZlLkzYpPHrTQNk4ugu6luI3hlWizf30/z15NKwVpdtqqcqL1ihlOz
 jwCnB1RhOdLA8W0cbhkX+twbKFQotqpxDv05GyTVEkUtJ2cBxJvuYGO3l9xit1MwbJJs
 hbGMI3upD4mnyrw/NAlBxb7UjfP+7TOZ2mJqSXvf4sndFQ+fHC9nxgJpAXjV8jGysrHp
 NJ8nj3ghM/ukTx/iCVSB9nCsjPErgUAOm9X2gqkDnuO158ZRMzmVUaP/P+DqSANGeuQV
 0AL7soN/85aFh+RIF1juyl/rjUsikrgo9O05JyD1wk3km+yg4zs9VHQhtoosO1Mqm5kn
 CI2g==
X-Gm-Message-State: AOJu0Ywtxz2jitQa4GxBhHpkfg3vX1BeDS8O0wLKmfkBcasvIpGWrL0A
 UbLJf93b0mXDo5UlLvfdaK5jcoeiErxSzY3rzkLLgvxJ5PZar0p3rFw/P2g1IAhUrAjaiCeCaV/
 017iDnF2hxVOQIC1ZtseVe/bqlZ0iMa9Z3HtKjr+k
X-Gm-Gg: AeBDievXjcbTAM2GAe2mV5sEdCocH1FIsMJoK6MpnXAiB8Fqd2NcyGDiSxlWqKBIHQe
 2yUGQ0QeNOZ+I2Sq5TNXddLKUypO4jMd4ccl97bMLKyFqjVL/UVSB5bKR4Yi0lfm8f6gANpd/pZ
 hkCfagKx8qsw9oUrEWtRkFFByCLOw1laaPA30Ao8JJQWA5dwGW5jvZTRdMEu19V0D9MdpSfQmnO
 XE6rVsc2EUqkRvBr1CDYWl0pJvYFvQVm721AtmPl/GmmmMJIC/+Eb0456YUUy84t2gb0Y+ntVOi
 WwsrUg==
X-Received: by 2002:a17:903:1104:b0:2b2:ecc6:5e28 with SMTP id
 d9443c01a7336-2b2ecc66307mr65325045ad.25.1776092248845; Mon, 13 Apr 2026
 07:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
 <20260412195947.1982729-3-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-3-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:56:54 -0600
X-Gm-Features: AQROBzC9tNDFCzvn9qX_ipCcIWXiTrfz7pPkl8t2b8PMOioyNECMD1ksN1GJv68
Message-ID: <CAFLszTjFUSaQ=6_=VVeZVbf5ZTeUT3WP85RZY+HoVOTo4PL6BQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] stdio: drop stdio_clone
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
> stdio: drop stdio_clone
>
> The helper stdio_clone only has a single caller, so it certainly
> doesn't need to be public. But in fact, it is merely an open-coded
> memdup() - which for some reason uses calloc() even if the whole
> allocation is obviously immediately overwritten.
>
> Drop it and just use memdup() directly.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> common/stdio.c      | 18 +-----------------
>  include/stdio_dev.h |  1 -
>  2 files changed, 1 insertion(+), 18 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
