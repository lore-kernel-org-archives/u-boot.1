Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0072CCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 20:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF2B83D3D;
	Mon,  6 Oct 2025 22:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HTSAnXW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D2483C46; Mon,  6 Oct 2025 22:38:34 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049FB83D3D
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 22:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso12487350a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 13:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759783112; x=1760387912; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iR/mKrc/slFOne8w8gz2HUVwpr4pEdNsKTcgGgZlrG8=;
 b=HTSAnXW/6067FkcdxRLVltQ5B5+Qr3HJWW4HOd721jbjSL4q/oSzzMQ+CBzkvHIa8Z
 y297yr0imfWCwsdIRydLo6jyjkVGnri0iVhbBTnq9Zq5dFjk4FlxVkS6TS/uoqprt/YU
 Dec239rDMa+pferkddNQM2EgS6/sc1SJbyiXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759783112; x=1760387912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iR/mKrc/slFOne8w8gz2HUVwpr4pEdNsKTcgGgZlrG8=;
 b=McQD37roZzaD6J/F7JhDpqXy04WJsgPUdcPAA08VC6g45PCPf9wnVSgfdOlWkLo8eW
 kimv2BoFCivz2hJ6zK/DD/AJyBqAMjykdP/YWGJ1f0esKZ/WK/olnoesCgMRl7G6VsaS
 uJEmosxdMqYYdIlR+O7BCHNHr7jIKKM9cB2A6D+cttXv5DMDvKnICVsHI03D3F2qVoob
 4QWzyol8gnHG5NX00TR3yEnQ4QtN+SCdG2mxZ1U/f1K1sVEr0SykIye0xeNVSc6Lb6eQ
 ln7Qs1k68SQER1ey/8ymcLW2O/MMYL2g/eQVfvk2ThqeSbQQIwO6GZZ5Bb7CyfzxdBax
 QF6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeYnjMpb7uKSakyj9RY9EMAWu2ghiP7CFk4g3xJxaOKTXFsn9u/g568RoHAOnedqIYct+j9kU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9rc0V1B9zztVG+ry5mKMPXUxgKzAoaU3lKhPYU1hDSSnhpQB8
 Hzw3RnXLX4eMzpCasIxsRQcvei8yrdb7haSx1vMKRld81lGcp1hECfzeSEOGh/c4jSYXAh66+pF
 YQQI/DAli5qgpPxEOtQJRH9wKLJzDgZEmfM2dG5Cd
X-Gm-Gg: ASbGnctgRcHyiyVJW1FOhVn2PNfAEDw5g88vy/a7P+zcDPOoah0O+LZcPtSxv1T1O7d
 z0flgVZcuvqRnS/cqGkocHdR+9LFa8fFg9E7aY+1ePbsbpC06O1o1yVmmDOAN2u9apm6U61M5fx
 P+rmhEjvX705ewUOZjoeoqUVRp41hwZyje/nxYivT6nINnk87VFjEGmPx3yv8TXC2jwJxInPKxn
 TIg6UDr+i1fFEAFAX0Hp2CewE0DETUtx9VLKSom89E=
X-Google-Smtp-Source: AGHT+IHXGhK4yzUAQhOt7/ouHDMNMd20Z41gJK7qwev/pIUgplV1h2p8h3duHqd7cfyBz4m67UIw6+uHFXKZw+DuHgw=
X-Received: by 2002:a50:d60a:0:b0:634:81c8:59d3 with SMTP id
 4fb4d7f45d1cf-639bb134e34mr710439a12.12.1759783112437; Mon, 06 Oct 2025
 13:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251001232259.3599563-1-apr@cn-eng.de>
 <CAFLszThMci29aiyCUfEwUpWjdncQ=KQZfvBsSz961=KYjy2u1A@mail.gmail.com>
 <a47c21cc55ee6856a2c69ce20649e273ff32ef06.camel@cn-eng.de>
 <cdcde4cd10945f2a686e1f191797a4d2fface36c.camel@phytec.de>
In-Reply-To: <cdcde4cd10945f2a686e1f191797a4d2fface36c.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 14:38:17 -0600
X-Gm-Features: AS18NWCK4qK_mg3N0bpGZeqrF2Y_SzswxsFpECy4Tvd2y9imhkmKOjlehrd0Tws
Message-ID: <CAFLszTg0U85HEjWg2d9_=V=2Fo32_z7YJUmUUS46h5QCkdWQqA@mail.gmail.com>
Subject: Re: [PATCH 0/2] bootstd: rauc: fix doc and info msg to reflect real
 flow - test cases
To: Martin Schwan <M.Schwan@phytec.de>
Cc: Andreas Pretzsch <apr@cn-eng.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Martin,

On Mon, 6 Oct 2025 at 00:01, Martin Schwan <M.Schwan@phytec.de> wrote:
>
> Hi Simon,
>
> sorry, that I didn't reply to your personal message.
>
> I had the tests for bootmeth_rauc on my to-do list and I am working on
> it right now. It took me some time to get the existing tests in
> test/boot/ to work (test instructions and environment are not easy to
> understand from the documentation). I hope to have some patches soon.

OK, great! If you are able to send a patch for the docs to make it
easier for future people, please do.

Regards,
Simon
