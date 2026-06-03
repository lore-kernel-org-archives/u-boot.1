Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418C6CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2603844CF;
	Wed,  3 Jun 2026 19:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OwnY0aWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80750848D2; Wed,  3 Jun 2026 19:11:18 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D0683FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-687e7edaafeso21832011a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506676; cv=none;
 d=google.com; s=arc-20240605;
 b=GUU3HzeTeQvbcgNxaFqff1TCKNr73KGkxRx9nYseEOL6MnZ44K2+w8Wt3kMyXqB+Ig
 sxfZ9qEvP9LjrlCyi26kAggMosp89+tgBxSgf0A9Zzs/A7yY8AZwz8YDu1in1xUAKkwV
 L6s4xoR98NdZKlIo2l+wVMBjymnH+/6U/akShOnr5ztLMlb+5a6u1xKB7SRe5RyJpRSs
 EH9xcj2QvvbXWNPPUKpJZjlJTJthxqWKeU10eHBBX3ehkHTuzFWYpUn4geQ3Sc8mPgYb
 t0IOu6Bwedz0HtLdMlrprXIsWShO9liayshl36/6M4KGSlcQKqHALB6iLEPm1PImTJAi
 9Evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YeyzkPFz95HV3M3cxjDFCK39Bn9YGylDU8xqGyhBGjI=;
 fh=PeEydQ2hvwtp+1/k8K8imEwfaH20KPrHght1b4v3g9w=;
 b=PFcfEFgQGrQD1V4snpo/E/fhnT8aNAEngWsYy/jLCWNlINOGkhCuN9Qt4x7HLz6EZf
 DRt5ndfu1j4k2MtC8WqnHLa0+aG9GXEcGf3L7lnqre1M1HGf2pKLyuqxA6Yc/qYJ844m
 J8AIuJg5G+L3pxFA5usEnwYfHzSaBl1U3iXRliPhif0tll0aYM16W0+8KaooPy04XaWq
 0ORV1enEwdWAs117INh6bQc0+wU0xfUovuRtL/5jCTN6L+Sb0hoQwLl9c4L/ZrA82Bb3
 bVt5fUUak0PIchVevZEiwumBXfG8f3hNj3B9pWmcXQ0+LpZcPBK7yCMl5UjX2CAt9d4o
 4dLw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506676; x=1781111476; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YeyzkPFz95HV3M3cxjDFCK39Bn9YGylDU8xqGyhBGjI=;
 b=OwnY0aWTF2MBxDINcstYOQ84YXIheC6+KPAFVWd/JjJ3d97/bWYFajMev/BXfCx6Lc
 7DIaF0nJUQIAhVSaj3naVGSGGN2gePqrr4Su+S51PeMWcrOhrF969urEoRz5QQoQPCcv
 aRouM3uaC50YA9eKRDjyRq5EOeMutcM2f9i6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506676; x=1781111476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeyzkPFz95HV3M3cxjDFCK39Bn9YGylDU8xqGyhBGjI=;
 b=gZNRLd7g5gkhyyPtJH8TrIBYiqzXNDQuY12I7wWkenyHVHuODe7WzpKmiL1FNQjJFv
 wQiUgMT7bA53iPDiPg5u2+gpBq9YbqzJV7+evRKv/tjE5DjZbnVkRSvKXlteNcwrLvrq
 IoHEkL44nJ77GiQIl1k5UDNMdh2zfOK7DCXFGFX+4WQ04qpFT7iWujhoOFTL6p15qDIB
 vLeH2gF3PhjCOzH4wlORiVYO2nU3PsQq+t42x4y4EZ8x2kqGpMcTO6Wm2Dn23zSNCl4l
 rfwWWg5JwK2+Nh7mt/PfeM3izX9S0l4D5hrMyLnbZg8M4DvybWt6qFJJvfMU6euJU9kd
 UGXA==
X-Gm-Message-State: AOJu0YzlpTyTjZ+bPXiA4aYiHUGbFirMCAk1a7fNHZZ1NHl6C9FyO9l9
 YVOlLLKJIPR021rGZJB+baNl4WuVNZtG/QXeBIUONBQsho/VNN9V/t3v9Cj6DBkWBPxtdDldHlk
 YyZ8L7pkcC/qYo5PohF6dDMcQmvbDUThYyMzwcq2toPjI0KzrYiA=
X-Gm-Gg: Acq92OFjGHk1hJtrZ8svqeHDb3kXBjR0qh2vIVnnMt4Xc5BNcnFGxto0+Aq2ffXbXbr
 2B/lFEsK0GJimcWUWze2id4NKPlngiKs2FSklrYwfcJe1+j18fouca/yF+zcKBD1sWTiV9umvtD
 o3no3i7In8Llz/4WMka8BEsQKlKToM2RNGUEWvYaJHTOKFqvZ0TQ9djhaLlfQCQQJiUteXkekHG
 giclODy5MBkpxnaMzgrPxO8iQEJzeljj9NZYT/H1sILgzqHWeQzRTw+KxE6703bRv/oPtQlWgKN
 b9UyIo+0uJ9eBH6B6A+6vQJeygA=
X-Received: by 2002:a17:907:94c5:b0:bda:8e57:5639 with SMTP id
 a640c23a62f3a-bf0a9711453mr229892466b.20.1780506676013; Wed, 03 Jun 2026
 10:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
In-Reply-To: <20260527150637.2850104-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:11:03 -0600
X-Gm-Features: AVHnY4Ke2vgg_NUWsZ0w1N8P-SDn0yk9qMiZ-YFOkadTdSax9nD1qUdh7t6XTP0
Message-ID: <CAFLszTic1wWJRRPw4ncrQdcV8EZXKdsmVCdTOMPhEW=vzekBZQ@mail.gmail.com>
Subject: Re: [v2,0/3] bootm: bound noload kernel decompression to the
 allocated buffer
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de
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

Hi Aristo,

On 2026-05-27T15:04:32, Aristo Chen <aristo.chen@canonical.com> wrote:

> Patch 2 adds two sandbox py-tests against the per-image buffer [...]
> New patch 3: raise the noload-decompression headroom from 4x to 8x [...]
> the same commit also updates the regression test references so each
> patch stays self-consistent.

I suggest swapping patches 2 and 3: bump the multiplier first, then
add the tests at the final 8x value. That way the test references are
introduced once, instead of being written at 4x in patch 2 and
rewritten at 8x in patch 3. Patch 1 stays first as the self-contained
security fix for backporting.

Regards,
Simon
