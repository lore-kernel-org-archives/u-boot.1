Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF0F34C5F
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E58F841F2;
	Mon, 13 Apr 2026 16:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZXoLgU7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3BFD841F2; Mon, 13 Apr 2026 16:57:24 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21A4841C2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so21513555ad.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092241; cv=none;
 d=google.com; s=arc-20240605;
 b=CbHHN+o78Oip4eJkTWBaleQcJx8a5NHW4MRWVq0YW4Q89YwubNXUW0LN5jwr4TO96K
 llSgMnDrQ/QrZ4hirKNUjyM2NVUXGCyFusq6trKFRqlwRaMfTTBv8Q1mWNnceZjBpYLf
 GshkXZZa5DSOFUkchpGv5ncaRP0pOzr3LFuUnW/f7vWC4V29Pi07kzeDCSoRmbVTiDHH
 Xe0MyfA0BiuqNDrgQLwwPZwTzvsq39imWugR3S1Xdp0/Aha64/oKTT3xr+Q6bNI7YICN
 cqT/4Hb96PFHPmcRxc1OCG5HCvjTg0OgtEdRkGFKkCjZeLR+Qx8J65SWxi3h4c4FN4cn
 45qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7Bd6ZT9IQSHIYEIZt8S9oKgZc5ccJbmtvTcvIo/RTb0=;
 fh=is6TKv49MgERBAcyxHwJilOvaFSawPXqsCYNk2VrlTs=;
 b=FcKsK22JS5KB8Ka7BOYVnweJUjMR9/Sqc9Db94fO5RICffiPeumf1v5eu9kHgXRjYd
 VXq4m8avl+4YvJSxub0XmZxntYuHjVjEcf4RUXLvWumWj2jETWvTkG8JzrMhb8TuTV+z
 ipNI+pzGHId/m+UVKzkhXb3ioLj1evz8zZQBe/oXjKqLaJFx1GvJdAkbtW/CB1oZGRTN
 A/H8NcjNE3kAXE4ll4QFB12JRPK3KHFWZqC8/udsCSsRMgwjQjLi+pNUDHhewIOLHpFk
 uyBzGmHa06+zFTYutEGG9xVTyQIfAKlY3Y6SR7K/hejgxA+SwYwF8rk/WGv1QmpVCdNq
 FGEw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092241; x=1776697041; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Bd6ZT9IQSHIYEIZt8S9oKgZc5ccJbmtvTcvIo/RTb0=;
 b=ZXoLgU7DuDDLBv1xqyNsSP6RHjcPbwzOEB41vROeowDaBjl6tRDI/+hztddwLU1ou6
 CZn775bGrzAE+0Et6/X21QBYJJwx8lEeU175VBuy+fXOTZXyyV7XW1u5v6gOmj97nsdE
 XP9mlv90MMjmgL01FeukkOpdFZOImT3IqaAb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092241; x=1776697041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Bd6ZT9IQSHIYEIZt8S9oKgZc5ccJbmtvTcvIo/RTb0=;
 b=U9CyX6u3n0sD+6dw48HDfVT2k47mymplL0n7x0fY0hEkAwdcDLjniq3k9j0Mae24UT
 dbJkHdJI3SSgBMcRzxr1mYw1uC82PNQxBDJQjeWqof/thsp/66IEubeoZk/GGF1ptBN/
 CUKc0fRWw9yRSExHTIoO2aXiR+Xt5d10hYUXu5eHpaSZ/p7F+hRCYfUTlMP/861la7mx
 dEyo9QP8I/brmArW4cDZ0nbYWAN5MV8ye2g22zl+Lw24pMguS2yhl+ksSLy++K4+8ub7
 kXSSMRerRqYmj+6msy8iw+XnaOD1M8hDAe0QOmFD03WfDGXtAqqxXzUensq2sta096NA
 1TtA==
X-Gm-Message-State: AOJu0YxIpFxGjDKjlDRNDgupwvz5FEYFPeEeDfKvNsfvPV4qDfj8ROXC
 qlvhr8RIu9APUKnPlHAOa7Fr3rK/ah7gHCZPjAk8iE54jxIUA2VRKchImLhWXDS4iRRB/T0PwLY
 Osw1YKzUHJOu+h3uirgh8pwf5t0oMqkRm3CjHqE0TVVxR1VrGmwU=
X-Gm-Gg: AeBDieuvxKS0LuNninvlzaDarc3nWJHeEJyK40MLQ+L4baDKDIQDHD+a+4J0g1HoD1a
 72s6Om5u0FxO2Eo/diFt2s44UYacQw3Uo50KN1BEfXvPdHHqAFoE6XLaydKUbc6ZYOTvyiHVdRp
 SWoq497PVcOCqm6plegskhlN6gfQ0VRg9aLvxovwnAmG2M3XAKb/82jBKEAbxZWHgZ6RSgb2IDQ
 5xaDqPEba7WWmwYJYw9TMlNIblnAYgJpEYJMo/kQoFGqvpF4Q15j3Sx/WBS8NX8huYvu2swtvVh
 8QmDeA==
X-Received: by 2002:a17:903:489:b0:2b4:460e:6fa8 with SMTP id
 d9443c01a7336-2b4460e723dmr38722535ad.34.1776092240978; Mon, 13 Apr 2026
 07:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:56:47 -0600
X-Gm-Features: AQROBzBxtmVmJfUU4m1x35-BfLuEJriwwdwASXvx9nNWNRNmbFmB4Ck8m3lELD8
Message-ID: <CAFLszTgPMjsp-HLAGfTx2tdU9Kqj2LoebJaLSRQ9OuewRHu7TQ@mail.gmail.com>
Subject: Re: [0/8] add memdup_nul(), use it and memdup() in a few places
To: ravi@prevas.dk
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

Hi Rasmus,

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:

> lib/string.c: introduce memdup_nul() helper

This looks like a nice cleanup series.

Since you are adding a new public helper, please can you add a unit
test for memdup_nul() in test/lib/string.c?

Regards,
Simon
